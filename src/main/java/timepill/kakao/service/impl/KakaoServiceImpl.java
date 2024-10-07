package timepill.kakao.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.RequiredArgsConstructor;
import timepill.alarm.service.AlarmService;
import timepill.kakao.service.KakaoDAO;
import timepill.kakao.service.KakaoMessageTemplate;
import timepill.kakao.service.KakaoService;
import timepill.schedule.service.ScheduleVO;
import timepill.user.service.UserVO;

@RequiredArgsConstructor
@Service("kakaoService")
public class KakaoServiceImpl implements KakaoService {

	private final HttpSession httpSession;

	/** httpCallService DI */
	@Autowired
	private HttpCallService httpCallService;

	/** kakaoDAO DI */
	@Autowired
	private KakaoDAO kakaoDAO;

	/** alarmService DI */
	@Autowired
	AlarmService alarmService;

	@Value("${rest-api-key}")
	private String REST_API_KEY;

	@Value("${login-callback-uri}")
	private String LOGIN_CALLBACK_URI;

	@Value("${message-callback-uri}")
	private String MESSAGE_CALLBACK_URI;

	@Value("${authorize-uri}")
	private String AUTHORIZE_URI;

	@Value("${token-uri}")
	public String TOKEN_URI;

	@Value("${client-secret}")
	private String CLIENT_SECRET;

	@Value("${kakao-api-host}")
	private String KAKAO_API_HOST;

	/** 인가코드 요청 주소 */
	@Override
	public String goKakaoOAuth(String scope, String rediUri) throws Exception {
		
		// 요청 콜백 구분
		String uri = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			uri = AUTHORIZE_URI + "?redirect_uri=" + LOGIN_CALLBACK_URI + "&response_type=code&client_id=" + REST_API_KEY;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			uri = AUTHORIZE_URI + "?redirect_uri=" + MESSAGE_CALLBACK_URI + "&response_type=code&client_id=" + REST_API_KEY;
		}
		
		// 스코프 여부 체크
		if (!scope.isEmpty())
			uri += "&scope=" + scope;
		
		System.out.println("scope : " + scope);
		System.out.println("uri : " + uri);
		return uri;
	}

	/** 액세스 토큰 요청 및 저장 */
	@Override
	public void callback(String code, String rediUri) throws Exception {
		// 요청 처리 구분
		String callbackUri = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			callbackUri = LOGIN_CALLBACK_URI;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			callbackUri = MESSAGE_CALLBACK_URI;
		}

		String param = "grant_type=authorization_code&client_id=" + REST_API_KEY + "&redirect_uri=" + callbackUri + "&client_secret=" + CLIENT_SECRET + "&code=" + code;

		// http 요청 진행
		String rtn = httpCallService.Call("POST", TOKEN_URI, "", param);
		
		// 파싱
		JsonObject element = JsonParser.parseString(rtn).getAsJsonObject();
		String accessToken = element.get("access_token").getAsString();
		String refreshToken = element.get("refresh_token").getAsString();
		System.out.println("accessToken : " + accessToken);
		System.out.println("refreshToken : " + refreshToken);
		
		// 세션 저장
		httpSession.setAttribute("token", accessToken); // 세션에 액세스 토큰 저장
		httpSession.setAttribute("refreshToken", refreshToken); // 세션에 리프레시 토큰 저장
	}

	/** 액세스 토큰 재발급 */
	@Override
	public String getNewAccessToken(String code, String refreshToken) throws Exception {
		String param = "grant_type=refresh_token&refresh_token=" + refreshToken + "&client_id=" + REST_API_KEY + "&client_secret=" + CLIENT_SECRET;
		String newAccessToken = httpCallService.Call("POST", "https://kauth.kakao.com/oauth/token", "", param);
		System.out.println("새로운 토큰 : " + newAccessToken);
		return newAccessToken;
	}

	/** 사용자 정보 가져오기 */
	@Override
	public String getProfile() throws Exception {
		String uri = KAKAO_API_HOST + "/v2/user/me";
		return httpCallService.CallwithToken("GET", uri, httpSession.getAttribute("token").toString());
	}

	/** 카카오 가입&로그인 핸들러 */
	@Override
	public String userAuthHandler() throws Exception {
		// 사용자 정보 가져오기
		String userInfo = getProfile();
		JsonObject userJson = JsonParser.parseString(userInfo).getAsJsonObject();
		String kakaoId = userJson.get("id").getAsString();
		String nickname = userJson.get("properties").getAsJsonObject().get("nickname").getAsString();
//		String email = userJson.get("kakao_account").getAsJsonObject().get("email").getAsString();

		UserVO vo = new UserVO();
		vo.setUserId("KAKAO_" + kakaoId);
		vo.setNickname(nickname);

		// 회원가입 여부 체크
		UserVO userInfoResult = kakaoDAO.duplicateCheckUser(vo);
		if (userInfoResult != null) {
			// 시큐리티 로그인
			UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(userInfoResult, "",
					userInfoResult.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
			if ("Y".equals(userInfoResult.getTokenUseAt())) { // 메세지 알람을 위한 리프레시 토큰 사용 여부 체크
				vo.setRefreshToken(httpSession.getAttribute("refreshToken").toString());
			}
		} else {
			kakaoDAO.insertUser(vo);
			// 신규 유저 알람 생성
			ScheduleVO scheduleVO = new ScheduleVO();
			String[] hours = { "08", "12", "18", "22" };
			for (int i = 0; i < 4; i++) {
				scheduleVO.setUserId(vo.getUserId());
				scheduleVO.setAlarmType(i + 1);
				scheduleVO.setAlarmTime(hours[i] + ":00");
				alarmService.insertAlarm(scheduleVO);
			}
			httpSession.setAttribute("message", "회원가입이 완료되었습니다. 로그인을 해주세요.");
		}
		return "green";
	}

	/** 로그아웃 */
	@Override
	public void logout() throws Exception {
		String uri = KAKAO_API_HOST + "/v1/user/logout";
		if (httpSession.getAttribute("token") != null) {
			httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString());
		}
	}

	/** 카카오 메세지 권한 동의 여부 체크 */
	@Override
	public boolean checkMessageAuth() throws Exception {
		String token = httpSession.getAttribute("token").toString();
		String checkScopeUrl = KAKAO_API_HOST + "/v2/user/scopes";
		String response = httpCallService.CallwithToken("GET", checkScopeUrl, token, null); // 카카오 요청
		JsonObject element = JsonParser.parseString(response).getAsJsonObject();
		JsonArray scopes = element.get("scopes").getAsJsonArray();

		System.out.println("체크 메세지 권한");
		for (int i = 0; i < scopes.size(); i++) {
			JsonObject scope = scopes.get(i).getAsJsonObject();
			if (scope.get("id").getAsString().equals("talk_message") && scope.get("agreed").getAsBoolean()) { // 메세지 권한 동의 여부 체크
				UserVO vo = new UserVO();
				String userId = SecurityContextHolder.getContext().getAuthentication().getName();
				vo.setUserId(userId);
				vo.setTokenUseAt("Y");
				kakaoDAO.updateRefreshToken(vo);
				return true;
			}
		}
		return false;
	}

	/** 카카오 메세지 알람을 보내기 위한 리스트 조회 */
	@Override
	public List<UserVO> selectKakaoScheList() throws Exception {
		return kakaoDAO.selectKakaoScheList();
	}

	/** 카카오 메세지 보내기 */
	@Override
	public String message(String token) throws Exception {
		String uri = KAKAO_API_HOST + "/v2/api/talk/memo/default/send";
		String accessToken = "";
		if (!StringUtils.hasText(token)) { // 세션에 저장된 토큰 사용
			accessToken = httpSession.getAttribute("token").toString();
		} else {
			accessToken = token;
		}
		System.out.println("메세지 서비스 시작");
		return httpCallService.CallwithToken("POST", uri, accessToken, KakaoMessageTemplate.getDefaultMessageParam());
	}

}

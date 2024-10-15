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
		System.out.println("callback 호출됨: " + rediUri);
		
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
		System.out.println("callback 호출됨: " + rediUri);
		
		// 요청 처리 구분
		String callbackUri = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			callbackUri = LOGIN_CALLBACK_URI;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			callbackUri = MESSAGE_CALLBACK_URI;
		}

		String param = "grant_type=authorization_code&client_id=" + REST_API_KEY + "&redirect_uri=" + callbackUri + "&client_secret=" + CLIENT_SECRET + "&code=" + code;

		// HTTP 요청
		String rtn = httpCallService.Call("POST", TOKEN_URI, "", param);
		
		// JSON 응답 파싱
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
	public String getNewAccessToken(String refreshToken) throws Exception {
		System.out.println("getNewAccessToken 호출됨: " + refreshToken);
		
		String param = "grant_type=refresh_token&refresh_token=" + refreshToken + "&client_id=" + REST_API_KEY + "&client_secret=" + CLIENT_SECRET;
		
		// HTTP 요청
		String response = httpCallService.Call("POST", "https://kauth.kakao.com/oauth/token", "", param);
		    
		// JSON 응답 파싱
		JsonObject element = JsonParser.parseString(response).getAsJsonObject();
		String newAccessToken = element.get("access_token").getAsString();
		
		UserVO vo = new UserVO();
		vo.setTokenUseAt("Y");
		vo.setAccessToken(newAccessToken);
		// 새로운 액세스 토큰 저장
		kakaoDAO.updateAccessToken(vo);
		
		// 리프레시토큰 갱신 여부 체크
		if (element.has("refresh_token")) {
			vo.setRefreshToken(element.get("refresh_token").getAsString());
			vo.setOldRefreshToken(refreshToken);
			// 리프레시 토큰 갱신
			kakaoDAO.updateRefreshToken(vo);
		}
		
		// 새로운 액세스 토큰 반환
		return newAccessToken;
	}
	
	/** 카카오유저 DB정보 가져오기 */
	@Override
	public UserVO selectUserInfo(UserVO vo) throws Exception {
		return kakaoDAO.selectUserInfo(vo);
	}

	/** 카카오 사용자 정보 가져오기 */
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
		vo.setAccessToken(httpSession.getAttribute("token").toString());

		// 회원가입 여부 체크
		UserVO userInfoResult = kakaoDAO.selectUserInfo(vo);
		if (userInfoResult != null) {
			
			// 시큐리티 로그인
			UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userInfoResult, "", userInfoResult.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(authToken);
			
			System.out.println("액세스토큰 : " + vo.getAccessToken());
			
			// 액세스 토큰 저장 (알림 동의한 경우만)
			kakaoDAO.updateAccessToken(vo);
			
			return "green";
		} 
		
		// 회원가입
		kakaoDAO.insertUser(vo);
		
		// 신규 유저 알람 생성 (아침, 점심, 저녁, 취침전)
		ScheduleVO scheduleVO = new ScheduleVO();
		String[] hours = { "08", "12", "18", "22" };
		for (int i = 0; i < 4; i++) {
			scheduleVO.setUserId(vo.getUserId());
			scheduleVO.setAlarmType(i + 1);
			scheduleVO.setAlarmTime(hours[i] + ":00");
			alarmService.insertAlarm(scheduleVO);
		}
		httpSession.setAttribute("message", "회원가입이 완료되었습니다. 로그인을 해주세요.");
		
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
		System.out.println("checkMessageAuth 호출됨");
		
		String token = httpSession.getAttribute("token").toString();
		String checkScopeUrl = KAKAO_API_HOST + "/v2/user/scopes";
		
		// HTTP 요청 (메세지 권한 확인)
		System.out.println("권한확인 요청 시작");
		String response = httpCallService.CallwithToken("GET", checkScopeUrl, token, null); 
		System.out.println("권한확인 요청 끝");
		
		// JSON 응답 파싱
		JsonObject element = JsonParser.parseString(response).getAsJsonObject();
		JsonArray scopes = element.get("scopes").getAsJsonArray();

		// 스콥에서 메세지 권한 찾기
		for (int i = 0; i < scopes.size(); i++) {
			JsonObject scope = scopes.get(i).getAsJsonObject();
			// 메세지 권한 동의 여부 확인
			if (scope.get("id").getAsString().equals("talk_message") && scope.get("agreed").getAsBoolean()) {
				
				UserVO vo = new UserVO();
				String userId = SecurityContextHolder.getContext().getAuthentication().getName();
				vo.setUserId(userId);
				vo.setTokenUseAt("Y");
				vo.setRefreshToken(httpSession.getAttribute("refreshToken").toString());
				vo.setAccessToken(httpSession.getAttribute("token").toString());
				
				// 리프레시 토큰 & 액세스 토큰 저장
				kakaoDAO.updateRefreshToken(vo);
				kakaoDAO.updateAccessToken(vo);
				return true;
			}
		}
		return false;
	}
	
	/** 카카오 메세지 권한 동의 철회 */
	@Override
	public boolean revokeMessageAuth() throws Exception {
		System.out.println("revokeMessageAuth 호출됨");
		
		String refeshToken = httpSession.getAttribute("refreshToken").toString();
		String newAccessToken = getNewAccessToken(refeshToken);
	    String revokeScopeUrl = KAKAO_API_HOST + "/v2/user/revoke/scopes";
	    
	    // 권한 동의 철회 요청 본문 설정
	    String scope = "scopes=[\"talk_message\"]";
	    
	    // HTTP 요청 (메세지 권한 철회)
	    String response = httpCallService.CallwithToken("POST", revokeScopeUrl, newAccessToken, scope);
	    
	    // JSON 응답 파싱
	    JsonObject element = JsonParser.parseString(response).getAsJsonObject();
	    JsonArray scopes = element.get("scopes").getAsJsonArray();
	    
	    // 스콥에서 메세지 권한 찾기
		for (int i = 0; i < scopes.size(); i++) {
			JsonObject resultScope = scopes.get(i).getAsJsonObject();
			// 메세지 권한 비동의 여부 확인
			if (resultScope.get("id").getAsString().equals("talk_message") && !resultScope.get("agreed").getAsBoolean()) {
				
				UserVO vo = new UserVO();
		        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		        vo.setUserId(userId);
		        vo.setTokenUseAt("N");
		        vo.setRefreshToken("");
		        
		        // 리프레시 토큰 초기화
		        kakaoDAO.updateRefreshToken(vo);
		        return true;
			}
		}
        return false;
	}

	/** 카카오 메세지 알람을 보내기 위한 리프레시 토큰 리스트 조회 */
	@Override
	public List<UserVO> selectKakaoRefreshTokenList() throws Exception {
		return kakaoDAO.selectKakaoRefreshTokenList();
	}

	/** 카카오 메세지 보내기 */
	@Override
	public String message(String token) throws Exception {
		System.out.println("message 메서드 호출됨: " + token);
		
		String uri = KAKAO_API_HOST + "/v2/api/talk/memo/default/send";
		
		String accessToken = token;
		
		// 파라미터로 받은 토큰이 비어있는 경우
		if (!StringUtils.hasText(accessToken)) {
			System.out.println("토큰이 비어있음");
			accessToken = httpSession.getAttribute("token").toString();
		}
		System.out.println("요청을 보내기 전 최종 액세스 토큰값 : " + accessToken);
		
		// HTTP 요청 (메세지 보내기)
		String callwithToken = httpCallService.CallwithToken("POST", uri, accessToken, KakaoMessageTemplate.getDefaultMessageParam());
		
		return callwithToken;
	}

}

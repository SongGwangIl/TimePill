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
import lombok.extern.slf4j.Slf4j;
import timepill.alarm.service.AlarmService;
import timepill.com.push.PushMessageTemplate;
import timepill.kakao.service.KakaoDAO;
import timepill.kakao.service.KakaoService;
import timepill.schedule.service.ScheduleVO;
import timepill.user.service.UserVO;

@Slf4j
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
	
	/** 카카오 요청 주소 */
	@Override
	public String goKakaoOAuth(String scope, String rediUri) throws Exception {
		log.debug("callback 호출됨: {}", rediUri);
		
		// 요청 콜백 구분
		String callbackUri = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			callbackUri = LOGIN_CALLBACK_URI;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			callbackUri = MESSAGE_CALLBACK_URI;
		} else {
			throw new IllegalArgumentException("Invalid rediUri: " + rediUri);
		}
		String uri = AUTHORIZE_URI + "?redirect_uri=" + callbackUri + "&response_type=code&client_id=" + REST_API_KEY;;
		
		// 스코프 여부 체크
		if (!scope.isEmpty())
			uri += "&scope=" + scope;
		
		log.debug("uri : {}", uri);
		log.debug("scope : {}", scope);
		return uri;
	}

	/** 액세스 토큰 요청 및 저장 */
	@Override
	public void callback(String code, String rediUri) throws Exception {
		log.debug("callback 호출됨: {}", rediUri);
		
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
		log.debug("accessToken : {}", accessToken);
		log.debug("refreshToken : {}", refreshToken);
		
		// 세션 저장
		httpSession.setAttribute("token", accessToken); // 세션에 액세스 토큰 저장
		httpSession.setAttribute("refreshToken", refreshToken); // 세션에 리프레시 토큰 저장
	}

	/** 액세스 토큰 재발급 */
	@Override
	public String getNewAccessToken(String refreshToken) throws Exception {
		log.debug("getNewAccessToken 호출됨: {}", refreshToken);
		
		String param = "grant_type=refresh_token&refresh_token=" + refreshToken + "&client_id=" + REST_API_KEY + "&client_secret=" + CLIENT_SECRET;
		
		// HTTP 요청
		String response = httpCallService.Call("POST", TOKEN_URI, "", param);
		    
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
	public UserVO getKakaoUserInfo(UserVO vo) throws Exception {
		return kakaoDAO.selectKakaoUserInfo(vo);
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
		
		// JSON 응답 파싱
		JsonObject userJson = JsonParser.parseString(userInfo).getAsJsonObject();
		String kakaoId = userJson.get("id").getAsString();
		String nickname = userJson.get("properties").getAsJsonObject().get("nickname").getAsString();

		UserVO vo = new UserVO();
		vo.setUserId("KAKAO_" + kakaoId);
		vo.setNickname(nickname);
		vo.setAccessToken(httpSession.getAttribute("token").toString());

		// 회원가입 여부 체크
		UserVO userInfoResult = kakaoDAO.selectKakaoUserInfo(vo);
		if (userInfoResult != null && "Y".equals(userInfoResult.getUserStatus())) {
			
			// 시큐리티 로그인
			UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userInfoResult, "", userInfoResult.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(authToken);
			
			// 액세스 토큰 저장 (알림 동의한 경우만)
			kakaoDAO.updateAccessToken(vo);
			
			return "green";
		} 
		
		if (userInfoResult != null && !"Y".equals(userInfoResult.getUserStatus())) {
			vo.setUserStatus("Y");
			int resultCnt = kakaoDAO.updateKakaoUserStatus(vo);
			if (resultCnt != 1) {
				httpSession.setAttribute("message", "기존 회원정보를 불러오는데 문제가 발생했습니다.");
				return "red";
			}
			httpSession.setAttribute("message", "기존 회원정보를 불러오는데 성공했습니다. 로그인을 해주세요.");
			return "green";
		}
		
		// 회원가입
		kakaoDAO.insertKakaoUser(vo);
		
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
	
	/** 카카오 회원탈퇴 */
	@Override
	public int deleteKakaoAccount(UserVO vo) throws Exception {
		
		// 카카오 서버에 연결 끊기 요청
		String uri = KAKAO_API_HOST + "/v1/user/unlink";
		httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString());
		
		// 카카오 회원정보 변경
		int resultCnt = kakaoDAO.updateKakaoUserStatus(vo);
		
		return resultCnt;
	}

	/** 로그아웃 */
	@Override
	public void logout() throws Exception {
		String uri = KAKAO_API_HOST + "/v1/user/logout";
		if (httpSession.getAttribute("token") != null) {
			httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString());
		}
	}
	
	// 카카오 권한 동의여부 체크
	private boolean checkScope(JsonArray scopes, String scopeId) {
	    for (int i = 0; i < scopes.size(); i++) {
	        JsonObject scope = scopes.get(i).getAsJsonObject();
	        // 동의여부 체크
	        if (scope.get("id").getAsString().equals(scopeId) && scope.get("agreed").getAsBoolean()) {
	            return true;
	        }
	    }
	    return false;
	}
	
	// 토큰 저장 or 삭제
	private void updateUserTokens(String useAt) throws Exception {
	    UserVO vo = new UserVO();
	    String userId = SecurityContextHolder.getContext().getAuthentication().getName();
	    vo.setUserId(userId);
	    vo.setTokenUseAt(useAt);
	    vo.setRefreshToken(useAt.equals("Y") ? httpSession.getAttribute("refreshToken").toString() : "");
	    vo.setAccessToken(useAt.equals("Y") ? httpSession.getAttribute("token").toString() : "");
	    kakaoDAO.updateRefreshToken(vo);
	    kakaoDAO.updateAccessToken(vo);
	}
	

	/** 카카오 메세지 권한 동의 여부 체크 */
	@Override
	public boolean checkMessageAuth() throws Exception {
		log.debug("checkMessageAuth 호출됨");
		
		String token = httpSession.getAttribute("token").toString();
		String checkScopeUrl = KAKAO_API_HOST + "/v2/user/scopes";
		
		// HTTP 요청 (메세지 권한 확인)
		String response = httpCallService.CallwithToken("GET", checkScopeUrl, token, null); 
		
		// JSON 응답 파싱
		JsonObject element = JsonParser.parseString(response).getAsJsonObject();
		JsonArray scopes = element.get("scopes").getAsJsonArray();

		// 메세지 권한 동의 여부 체크
		if (checkScope(scopes, "talk_message")) {
			
			// 토큰 저장
			updateUserTokens("Y");
			return true;
		}
		return false;
	}
	
	/** 카카오 메세지 권한 동의 철회 */
	@Override
	public boolean revokeMessageAuth() throws Exception {
		log.debug("revokeMessageAuth 호출됨");
		
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
	    
	 // 메세지 권한 동의 여부 체크
		if (!checkScope(scopes, "talk_message")) {
			
			// 토큰 삭제
			updateUserTokens("N");
			return true;
		}
        return false;
	}

	/** 카카오 토큰 리스트 가져오기 */
	@Override
	public List<UserVO> getKakaoTokenList() throws Exception {
		return kakaoDAO.selectKakaoTokenList();
	}

	/** 카카오 메세지 보내기 */
	@Override
	public String message(String token) throws Exception {
		log.debug("message 메서드 호출됨: {}", token);
		
		String uri = KAKAO_API_HOST + "/v2/api/talk/memo/default/send";
		
		String accessToken = token;
		
		// 파라미터로 받은 토큰이 비어있는 경우
		if (!StringUtils.hasText(accessToken)) {
			accessToken = httpSession.getAttribute("token").toString();
		}
		
		// HTTP 요청 (메세지 보내기)
		String callwithToken = httpCallService.CallwithToken("POST", uri, accessToken, PushMessageTemplate.getKakaoMessage());
		
		return callwithToken;
	}

}

package timepill.kakao.service.impl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.RequiredArgsConstructor;
import timepill.kakao.service.KakaoDAO;
import timepill.kakao.service.KakaoService;
import timepill.kakao.service.KakaoMessageTemplate;
import timepill.user.UserVO;

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
		String uri = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			uri = AUTHORIZE_URI + "?redirect_uri=" + LOGIN_CALLBACK_URI + "&response_type=code&client_id=" + REST_API_KEY;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			uri = AUTHORIZE_URI + "?redirect_uri=" + MESSAGE_CALLBACK_URI + "&response_type=code&client_id=" + REST_API_KEY;
		}
		if (!scope.isEmpty())
			uri += "&scope=" + scope;
		System.out.println("scope : " + scope);
		System.out.println("uri : " + uri);
		return uri;
	}

	/** 액세스 토큰 요청 및 저장 */
	@Override
	public void callback(String code, String rediUri) throws Exception {
		String param = "";
		if ("login-callback".equals(rediUri)) { // 로그인 요청
			param = "grant_type=authorization_code&client_id=" + REST_API_KEY + "&redirect_uri=" + LOGIN_CALLBACK_URI + "&client_secret=" + CLIENT_SECRET + "&code="
					+ code;
		} else if ("message-callback".equals(rediUri)) { // 메세지 권한 요청
			param = "grant_type=authorization_code&client_id=" + REST_API_KEY + "&redirect_uri=" + MESSAGE_CALLBACK_URI + "&client_secret=" + CLIENT_SECRET + "&code="
					+ code;
		}
		String rtn = httpCallService.Call("POST", TOKEN_URI, "", param);
		JsonObject element = JsonParser.parseString(rtn).getAsJsonObject();
		String accessToken = element.get("access_token").getAsString();
		httpSession.setAttribute("token", accessToken); // 세션에 액세스 토큰 저장
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
		vo.setUserName(nickname);

		// 회원가입 여부 체크
		if (kakaoDAO.duplicateCheckUser(vo) > 0) {
			httpSession.setAttribute("loginUser", vo);
			httpSession.setAttribute("message", "로그인 완료");
		} else {
			kakaoDAO.insertUser(vo);
			httpSession.setAttribute("message", "회원가입 완료");
		}
		return "green";
	}

	/** 로그아웃 */
	@Override
	public void logout() throws Exception {
		String uri = KAKAO_API_HOST + "/v1/user/logout";
		httpSession.invalidate();
		if (httpSession.getAttribute("token") != null) {
			httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString());
		}
	}

	/** 카카오 메세지 권한 동의 여부 체크 */
	@Override
	public boolean checkMessageAuth() throws Exception {
		String checkScopeUrl = KAKAO_API_HOST + "/v2/user/scopes";
		String response = httpCallService.CallwithToken("GET", checkScopeUrl, httpSession.getAttribute("token").toString(), null);
		JsonObject element = JsonParser.parseString(response).getAsJsonObject();
		JsonArray scopes = element.get("scopes").getAsJsonArray();

		System.out.println("체크 메세지 권한");
		for (int i = 0; i < scopes.size(); i++) {
			JsonObject scope = scopes.get(i).getAsJsonObject();
			if (scope.get("id").getAsString().equals("talk_message") && scope.get("agreed").getAsBoolean()) {
				return true;
			}
		}
		return false;
	}

	/** 카카오 메세지 보내기 */
	@Override
	public String message() throws Exception {
		String uri = KAKAO_API_HOST + "/v2/api/talk/memo/default/send";
		System.out.println("메세지 서비스 시작");
		return httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString(), KakaoMessageTemplate.default_msg_param);
	}

	/** 카카오 API를 호출해 친구 목록을 가져옴 */
	@Override
	public String getFriends() throws Exception {
		String uri = KAKAO_API_HOST + "/v1/api/talk/friends";
		return httpCallService.CallwithToken("GET", uri, httpSession.getAttribute("token").toString());
	}

	/** 액세스 토큰을 사용하여 특정 친구에게 메시지를 보냄 */
	@Override
	public String friendMessage(String uuids) throws Exception {
		String uri = KAKAO_API_HOST + "/v1/api/talk/friends/message/default/send";
		return httpCallService.CallwithToken("POST", uri, httpSession.getAttribute("token").toString(),
				KakaoMessageTemplate.default_msg_param + "&receiver_uuids=[" + uuids + "]");
	}

}

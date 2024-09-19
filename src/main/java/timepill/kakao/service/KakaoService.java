package timepill.kakao.service;

import org.springframework.web.servlet.view.RedirectView;

public interface KakaoService {
	/** 카카오 인증 서버로부터 카카오 인가 코드 요청 */
	public String goKakaoOAuth() throws Exception;
	
	/** 인가코드요청 시 추가권한 요청 가능 */
//	public RedirectView goKakaoOAuth(String scope) throws Exception;
	public String goKakaoOAuth(String scope, String rediUri) throws Exception;

	/** 인가코드를 사용하여 액세스 토큰 요청 및 세션에 저장 */
	public void loginCallback(String code) throws Exception;
	
	/** 로그인 or 회원가입 */
	public String login() throws Exception;

	/** 사용하여 카카오 API를 호출해 사용자 정보를 가져옴 */
	public String getProfile() throws Exception;
	
	/** 카카오 메세지 권한 동의 여부 체크 */
	public boolean checkMessageAuth() throws Exception;

	/** 카카오 API를 호출해 메세지를 보냄 */
	public String message() throws Exception;
	
	/** 카카오 API를 호출해 친구 목록을 가져옴 */
	public String getFriends() throws Exception;

	/** 액세스 토큰을 사용하여 특정 친구에게 메시지를 보냄 */
	public String friendMessage(String uuids) throws Exception;

	/** 카카오 API를 호출해 로그아웃 */
	public void logout() throws Exception;
}

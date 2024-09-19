package timepill.kakao.service;

public interface KakaoService {

	/** 인가코드 요청 주소 */
	public String goKakaoOAuth(String scope, String rediUri) throws Exception;

	/** 액세스 토큰 요청 및 저장 */
	public void callback(String code, String rediUri) throws Exception;

	/** 사용자 정보 가져오기 */
	public String getProfile() throws Exception;

	/** 카카오 가입&로그인 핸들러 */
	public String userAuthHandler() throws Exception;

	/** 로그아웃 */
	public void logout() throws Exception;

	/** 카카오 메세지 권한 동의 여부 체크 */
	public boolean checkMessageAuth() throws Exception;

	/** 카카오 메세지 보내기 */
	public String message() throws Exception;

	/** 카카오 API를 호출해 친구 목록을 가져옴 */
	public String getFriends() throws Exception;

	/** 액세스 토큰을 사용하여 특정 친구에게 메시지를 보냄 */
	public String friendMessage(String uuids) throws Exception;
}

package timepill.kakao.service;

import java.util.List;

import timepill.user.service.UserVO;

public interface KakaoService {

	/** 카카오 요청 주소 */
	public String goKakaoOAuth(String scope, String rediUri) throws Exception;

	/** 액세스 토큰 요청 및 저장 */
	public void callback(String code, String rediUri) throws Exception;

	/** 액세스 토큰 재발급 */
	public String getNewAccessToken(String refreshToken) throws Exception;

	/** 카카오 사용자 정보 가져오기 */
	public String getProfile() throws Exception;

	/** 카카오 유저정보 가져오기 */
	public UserVO getKakaoUserInfo(UserVO vo) throws Exception;

	/** 카카오 가입&로그인 핸들러 */
	public String userAuthHandler() throws Exception;

	/** 로그아웃 */
	public void logout() throws Exception;

	/** 카카오 메세지 권한 동의 여부 체크 */
	public boolean checkMessageAuth() throws Exception;

	/** 카카오 메세지 권한 동의 철회 */
	public boolean revokeMessageAuth() throws Exception;

	/** 카카오 토큰 리스트 가져오기 */
	public List<UserVO> getKakaoTokenList() throws Exception;

	/** 카카오 메세지 보내기 */
	public String message(String token) throws Exception;

}

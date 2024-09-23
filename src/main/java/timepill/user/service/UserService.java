package timepill.user.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import timepill.user.UserVO;

public interface UserService extends UserDetailsService {
	// 회원등록
	int add(UserVO vo);

	// 로그인
//	UserVO login(String userId);

	// 사용가능한 아이디 확인
	String checkId(String userId);

	// 사용자이름얻기
	String getUserNickame(String userId);

	// 보호자이름얻기
	String getProtectorName(String userId);

	// 보호자정보등록
	void addProtectorInfo(UserVO vo);

	// 사용자정보등록
	void addUserInfo(UserVO vo);

	// 사용자정보얻기
	UserVO getUserInfo(String userId);

	// 나의정보수정
	void updateMyInfo(UserVO uivo);

	//
	String getUserValid(String userId);

	String getUserCarerAt(String userId);

}

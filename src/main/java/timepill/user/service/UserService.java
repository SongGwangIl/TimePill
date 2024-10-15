package timepill.user.service;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
	// 회원등록
	public void add(UserVO vo) throws Exception;

	// 사용가능한 아이디 확인
	String checkId(String userId);

	// 이메일주소로 아이디 확인
	String findId(String email);

	// 인증번호 등록
	public void setAuthNumber(UserVO vo);
	
	// 비밀번호 변경(로그인 전)
	public void resetPassword(UserVO vo);

	// 내정보 변경
	public void changeMyInfo(UserVO vo);

	// 내정보 가져오기
	public UserVO getMyInfo(UserVO vo);

	// 비밀번호 가져오기
	public String getPassword(String userId);

	// 비밀번호 변경(로그인 후)
	public int changePassword(UserVO vo);
}

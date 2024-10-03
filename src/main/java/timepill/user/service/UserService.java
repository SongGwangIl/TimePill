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
	
	// 비밀번호 변경
	public void resetPassword(UserVO vo);

}

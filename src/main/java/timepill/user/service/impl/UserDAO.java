package timepill.user.service.impl;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.service.AuthVO;
import timepill.user.service.UserVO;

@Mapper
public interface UserDAO {

	int add(UserVO vo);

	UserVO login(String userId);

	String checkId(String userId);
	
	String checkEmail(String email);

	String findId(String email);

	void setAuthNumber(UserVO vo);

	void resetPassword(UserVO vo);
	
	AuthVO checkUser(AuthVO vo);

	void changeMyInfo(UserVO vo);

	UserVO getMyInfo(UserVO vo);

	String getPassword(String userId);

	int changePassword(UserVO vo);	
}
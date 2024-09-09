package timepill.user.service.impl;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.UserVO;

@Mapper
public interface UserDAO {

	int add(UserVO vo);

	UserVO login(String userId);

	String checkId(String userId);

	String getUserName(String userId);

	String getProtectorName(String userId);

	void addProtectorInfo(UserVO vo);

	void addUserInfo(UserVO vo);

	void hasInfo(String userId);
	
	UserVO getUserInfo(String string);

	UserVO getProtectorInfo(String string);

	String getUserEmail(String userId);

	String getUserCarerAt(String userId);

	void updateUserInfo(UserVO uivo);

	void updateProtectorInfo(UserVO uivo);

	void updateEmail(UserVO uivo);

	String getUserValid(String userId);
}
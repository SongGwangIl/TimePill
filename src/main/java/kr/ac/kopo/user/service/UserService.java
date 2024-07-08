package kr.ac.kopo.user.service;

import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;

public interface UserService {

	int add(UserVO vo);

	UserVO login(String userId);

	String checkId(String userId);

	UserInfoVO getUserInfo(String userId);

	UserInfoVO getProtectorInfo(String userId);

	void addProtectorInfo(UserInfoVO vo);

	void addUserInfo(UserInfoVO vo);
}

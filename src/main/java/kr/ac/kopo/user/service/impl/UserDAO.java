package kr.ac.kopo.user.service.impl;

import org.apache.ibatis.annotations.Mapper;

import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;

@Mapper
public interface UserDAO {

	int add(UserVO vo);

	UserVO login(String userId);

	String checkId(String userId);

	UserInfoVO getUserInfo(String userId);

	UserInfoVO getProtectorInfo(String userId);

	void addProtectorInfo(UserInfoVO vo);

	void addUserInfo(UserInfoVO vo);
}
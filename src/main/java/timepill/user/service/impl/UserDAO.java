package timepill.user.service.impl;

import org.apache.ibatis.annotations.Mapper;

import timepill.user.service.UserVO;

@Mapper
public interface UserDAO {

	int add(UserVO vo);

	UserVO login(String userId);

	String checkId(String userId);
}
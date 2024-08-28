package kr.ac.kopo.member.service.impl;

import org.apache.ibatis.annotations.Mapper;

import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;

@Mapper
public interface MemberDAO {

	String userSelect(UserVO userVO);

	UserInfoVO userInfoSelect(UserVO userVO);

	UserInfoVO deviceSelect(UserInfoVO userInfoVO);

	int registUser(UserInfoVO userInfoVO);
	
	int accept(UserInfoVO userInfoVo);
	
	int deny(UserInfoVO userInfoVo);

}
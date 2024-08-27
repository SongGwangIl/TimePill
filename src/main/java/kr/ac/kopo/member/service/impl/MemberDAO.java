package kr.ac.kopo.member.service.impl;

import org.apache.ibatis.annotations.Mapper;

import kr.ac.kopo.user.UserVO;

@Mapper
public interface MemberDAO {

	String userSelect(UserVO userVO);

}
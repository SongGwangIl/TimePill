package kr.ac.kopo.member.service;

import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;

public interface MemberService {

	String userSelect(UserVO userVO);
	
	UserInfoVO userInfoSelect(UserVO userVO);

	UserInfoVO deviceSelect(UserInfoVO vo);

	int registUser(UserInfoVO userInfoVO);

	int accept(UserInfoVO userInfoVO);

	int deny(UserInfoVO userInfoVO);
	
}

package kr.ac.kopo.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public String userSelect(UserVO userVO) {
		return memberDAO.userSelect(userVO);
	}
	
	@Override
	public UserInfoVO userInfoSelect(UserVO userVO) {
		return memberDAO.userInfoSelect(userVO);
	}

	@Override
	public UserInfoVO deviceSelect(UserInfoVO userInfoVO) {
		return memberDAO.deviceSelect(userInfoVO);
	}

	@Override
	public int registUser(UserInfoVO userInfoVO) {
		return memberDAO.registUser(userInfoVO);
	}
	
	@Override
	public int accept(UserInfoVO userInfoVO) {
		return memberDAO.accept(userInfoVO);
	}
	
	@Override
	public int deny(UserInfoVO userInfoVO) {
		return memberDAO.deny(userInfoVO);
	}





}

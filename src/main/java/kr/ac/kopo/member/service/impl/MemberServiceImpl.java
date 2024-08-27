package kr.ac.kopo.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.user.UserVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public String userSelect(UserVO userVO) {
		return memberDAO.userSelect(userVO);
	}



}

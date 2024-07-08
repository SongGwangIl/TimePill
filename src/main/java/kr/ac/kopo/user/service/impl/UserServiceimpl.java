package kr.ac.kopo.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.user.UserInfoVO;
import kr.ac.kopo.user.UserVO;
import kr.ac.kopo.user.service.UserService;

@Service
public class UserServiceimpl implements UserService{
	
	@Autowired
	UserDAO userdao;

	@Override
	public int add(UserVO vo) {
		
		return userdao.add(vo);
	}


	@Override
	public UserVO login(String userId) {
		
		return userdao.login(userId);
	}


	@Override
	public String checkId(String userId) {

		return userdao.checkId(userId);
	}


	@Override
	public UserInfoVO getUserInfo(String userId) {
		
		return userdao.getUserInfo(userId);
	}


	@Override
	public UserInfoVO getProtectorInfo(String userId) {
		
		return userdao.getProtectorInfo(userId);
	}

	@Override
	public void addProtectorInfo(UserInfoVO vo) {
		
		userdao.addProtectorInfo(vo);
		
	}

	@Override
	public void addUserInfo(UserInfoVO vo) {
		
		userdao.addUserInfo(vo);
		
	}
}

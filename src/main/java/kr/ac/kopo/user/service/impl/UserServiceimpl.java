package kr.ac.kopo.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public String getUserName(String userId) {
		
		return userdao.getUserName(userId);
	}


	@Override
	public String getProtectorName(String userId) {
		
		return userdao.getProtectorName(userId);
	}

	@Override
	public void addProtectorInfo(UserInfoVO vo) {
		
		userdao.addProtectorInfo(vo);
		userdao.hasInfo(vo.getUserId());
		
	}

	@Override
	public void addUserInfo(UserInfoVO vo) {
		String birthDay = vo.getYy()+"-"+vo.getMm()+"-"+vo.getDd();
		vo.setUserBirth(birthDay);
		
		userdao.addUserInfo(vo);
		userdao.hasInfo(vo.getUserId());
		
	}
	
	@Override
	public UserInfoVO getUserInfo(UserVO vo) {
		
		UserInfoVO uivo = new UserInfoVO();
		
		if(vo.getUserSelect().equals("user"))
			uivo = (UserInfoVO)userdao.getUserInfo(vo.getUserId());
		else if(vo.getUserSelect().equals("protector"))
			uivo = (UserInfoVO)userdao.getProtectorInfo(vo.getUserId());
		
		String email = userdao.getUserEmail(vo.getUserId());
		uivo.setUserEmail(email);
		
		String select = userdao.getUserSelect(vo.getUserId());
		uivo.setUserSelect(select);
		
		return uivo;
	}


	@Transactional
	public String updateMyInfo(UserInfoVO uivo) {
		String select = userdao.getUserSelect(uivo.getUserId());
		
		
		if(select.equals("user"))
			userdao.updateUserInfo(uivo);
		else
			userdao.updateProtectorInfo(uivo);
		
		userdao.updateEmail(uivo);
		
		return select;
		
	}


	@Override
	public String getUserValid(String userId) {
		
		return userdao.getUserValid(userId);
	}


	@Override
	public String getUserSelect(String userId) {
		
		return userdao.getUserSelect(userId);
	}
}

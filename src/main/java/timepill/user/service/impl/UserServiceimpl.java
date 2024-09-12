package timepill.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import timepill.user.UserVO;
import timepill.user.service.UserService;

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
	public void addProtectorInfo(UserVO vo) {
		
		userdao.addProtectorInfo(vo);
		userdao.hasInfo(vo.getUserId());
		
	}

	@Override
	public void addUserInfo(UserVO vo) {
		if(vo.getYy() != null && vo.getMm() != null && vo.getDd() != null) {
			String birthDay = vo.getYy()+"-"+vo.getMm()+"-"+vo.getDd();
			vo.setUserBirth(birthDay);			
		}
		userdao.addUserInfo(vo);		
	}
	
	@Override
	public UserVO getUserInfo(String userId) {
		UserVO vo = userdao.getUserInfo(userId);
		
		if(StringUtils.hasText(vo.getUserBirth())) {			
			vo.setYy(vo.getUserBirth().substring(0, 4));
			vo.setMm(vo.getUserBirth().substring(5, 7));
			vo.setDd(vo.getUserBirth().substring(8, 10));
		}
		
		return vo;
	}


	@Transactional
	public void updateMyInfo(UserVO uivo) {
		uivo.setUserBirth(uivo.getYy() + "-" + uivo.getMm() + "-" + uivo.getDd());
		
		userdao.updateUserInfo(uivo);		
	}


	@Override
	public String getUserValid(String userId) {
		
		return userdao.getUserValid(userId);
	}


	@Override
	public String getUserCarerAt(String userId) {
		
		return userdao.getUserCarerAt(userId);
	}
}

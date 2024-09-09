package timepill.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		String birthDay = vo.getYy()+"-"+vo.getMm()+"-"+vo.getDd();
		vo.setUserBirth(birthDay);
		
		userdao.addUserInfo(vo);
		userdao.hasInfo(vo.getUserId());
		
	}
	
//	@Override
//	public UserVO getUserInfo(UserVO vo) {
//		
//		UserInfoVO uivo = new UserInfoVO();
//		
//		if(vo.getUserSelect().equals("user"))
//			uivo = (UserInfoVO)userdao.getUserInfo(vo.getUserId());
//		else if(vo.getUserSelect().equals("protector"))
//			uivo = (UserInfoVO)userdao.getProtectorInfo(vo.getUserId());
//		
//		String email = userdao.getUserEmail(vo.getUserId());
//		uivo.setUserEmail(email);
//		
//		String select = userdao.getUserSelect(vo.getUserId());
//		uivo.setUserSelect(select);
//		
//		return uivo;
//	}


	@Transactional
	public void updateMyInfo(UserVO uivo) {
		
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


	@Override
	public UserVO getUserInfo(UserVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
}

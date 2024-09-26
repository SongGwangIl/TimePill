package timepill.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;
import timepill.user.UserVO;
import timepill.user.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userdao;
	
	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;

	/** 스프링시큐리티 bCryptPasswordEncoder DI */
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Override
	public void add(UserVO vo) throws Exception {
		String encodedPwd = bCryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodedPwd);
		userdao.add(vo);
		
		// 신규 유저 알람 생성
		ScheduleVO scheduleVO = new ScheduleVO();
		String[] hours = {"08", "12", "18", "22"};
		for (int i = 0; i < 4; i++) {
			scheduleVO.setUserId(vo.getUserId());
			scheduleVO.setAlarmType(i+1);
			scheduleVO.setAlarmTime(hours[i] + ":00");
			scheduleService.insertAlarm(scheduleVO);
		}
		
	}

	/** 스프링 시큐리티 로그인 메서드 */
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		UserVO userInfo = userdao.login(userId);
		System.out.println("유저 정보 존재 여부 : " + userInfo);
		if (userInfo == null) {
			throw new UsernameNotFoundException("사용자 정보를 찾을 수 없음");
		}
		System.out.println("닉네임체크 " + userInfo.getUserId());
		return userInfo;
	}

//	@Override
//	public UserVO login(String userId) {
//		
//		return userdao.login(userId);
//	}

	@Override
	public String checkId(String userId) {

		return userdao.checkId(userId);
	}

	@Override
	public String getUserNickame(String userId) {

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
		if (vo.getYy() != null && vo.getMm() != null && vo.getDd() != null) {
			String birthDay = vo.getYy() + "-" + vo.getMm() + "-" + vo.getDd();
			vo.setUserBirth(birthDay);
		}
		// 패스워드 암호화
		String encodePwd = bCryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodePwd);
		userdao.addUserInfo(vo);
	}

	@Override
	public UserVO getUserInfo(String userId) {
		UserVO vo = userdao.getUserInfo(userId);

		if (StringUtils.hasText(vo.getUserBirth())) {
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

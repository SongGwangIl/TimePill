package timepill.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import timepill.alarm.service.AlarmService;
import timepill.notification.service.NotificationService;
import timepill.notification.service.NotificationVO;
import timepill.schedule.service.ScheduleVO;
import timepill.user.service.UserService;
import timepill.user.service.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userdao;
	
	/** alarmService DI */
	@Autowired
	AlarmService alarmService;
	
	/** notificationService DI */
	@Autowired
	private NotificationService notificationService;

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
			alarmService.insertAlarm(scheduleVO);
		}
		
	}
	
	/** 일반회원탈퇴 */
	@Override
	public int deleteAccount(UserVO vo) throws Exception {
		
		// 푸시알림 구독정보 삭제
		NotificationVO notificationVO = new NotificationVO();
		notificationVO.setUserId(vo.getUserId());
		notificationService.delSubscription(notificationVO);
		
		// 회원정보 삭제
		int resultCnt = userdao.updateUserStatus(vo);
		
		return resultCnt;
	}

	/** 스프링 시큐리티 로그인 메서드 */
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		UserVO userInfo = userdao.login(userId);
		if (userInfo == null) {
			throw new UsernameNotFoundException("사용자 정보를 찾을 수 없음");
		}
		return userInfo;
	}

	@Override
	public String checkId(String userId) {

		return userdao.checkId(userId);
	}
	
	@Override
	public String checkEmail(String email) {
		
		return userdao.checkEmail(email);
	}


	@Override
	public String findId(String email) {
		
		return userdao.findId(email);
	}

	@Override
	public void setAuthNumber(UserVO vo) {
		
		userdao.setAuthNumber(vo);
		
		
	}

	@Override
	public void resetPassword(UserVO vo) {
		
		String encodedPwd = bCryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodedPwd);		
		userdao.resetPassword(vo);
		
	}

	@Override
	public void changeMyInfo(UserVO vo) {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);		
		userdao.changeMyInfo(vo);
		
	}

	@Override
	public UserVO getMyInfo(UserVO vo) {
		
		return userdao.getMyInfo(vo);
	}

	@Override
	public String getPassword(String userId) {
		
		return userdao.getPassword(userId);
	}

	@Override
	public int changePassword(UserVO vo) {
		String encodedPwd = bCryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodedPwd);
		
		return userdao.changePassword(vo);
	}

	@Override
	public String checkEmailId(UserVO vo) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		return userdao.checkEmailId(vo);
	}
}

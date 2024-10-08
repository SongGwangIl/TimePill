package timepill.alarm.service;

import java.util.List;

import timepill.schedule.service.ScheduleVO;

public interface AlarmService {
	
	/** 알람 리스트 조회 */
	public List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;
	
	/** 알람 생성(회원가입) */
	public void insertAlarm(ScheduleVO vo) throws Exception;
	
	/** 알람 시간 변경 */
	public void updateAlarm(ScheduleVO vo) throws Exception;
	
	
}

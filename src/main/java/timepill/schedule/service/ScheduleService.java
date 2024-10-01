package timepill.schedule.service;

import java.util.List;

public interface ScheduleService {
	
	/** 알람 리스트 */
	public List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;
	
	/** 알람 생성(회원가입) */
	public void insertAlarm(ScheduleVO vo) throws Exception;
	
	/** 알람 시간 변경 */
	public void updateAlarm(ScheduleVO vo) throws Exception;
	
	/** 스케줄 리스트 */
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	public void handleSchedule(ScheduleVO vo) throws Exception;
	
}

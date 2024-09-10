package timepill.schedule.service.impl;

import java.util.List;

import timepill.schedule.service.ScheduleVO;

public interface ScheduleService {
	
	/** 스케줄 리스트 */
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 알람 리스트 */
	public List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;
	
	/** 알람 정보 설정 */
	public int updateAlarm(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 */
	public ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 등록 */
	public int insertMedInfo(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 수정 */
	public int updateMedInfo(ScheduleVO vo) throws Exception;
	
}

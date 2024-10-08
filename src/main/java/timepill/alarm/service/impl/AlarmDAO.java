package timepill.alarm.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface AlarmDAO {
	
	/** 알람 아이디 조회 */
	List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;

	/** 알람 아이디 조회 */
	String selectAlarm(ScheduleVO vo) throws Exception;

	/** 마지막 알람 아이디 조회 */
	String selectLastAlarmId() throws Exception;

	/** 알람 생성(회원가입) */
	int insertAlarmSet(ScheduleVO vo) throws Exception;

	/** 알람 시간 변경 */
	int updateAlarm(ScheduleVO vo) throws Exception;

}

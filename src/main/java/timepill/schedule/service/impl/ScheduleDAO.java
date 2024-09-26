package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/** 스케줄 리스트 */
	List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	int insertSchedule(ScheduleVO vo) throws Exception;
	
	/** 알람 리스트 */
	List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;
	
	/** 알람 아이디 가져오기*/
	String selectAlarm(ScheduleVO vo) throws Exception;
	
	/** 마지막 알람 아이디 가져오기 */
	String selectLastAlarmId() throws Exception;
	
	/** 알람 생성(회원가입) */
	int insertAlarmSet(ScheduleVO vo) throws Exception;
	
	/** 알람 정보 설정 */
	int updateAlarm(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 */
	ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception;
	
	/** 마지막 복약 아이디 가져오기 가져오기*/
	String selectLastMedId(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 등록 */
	int insertMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 수정 */
	int updateMedInfo(ScheduleVO vo) throws Exception;

	
}

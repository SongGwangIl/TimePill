package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/** 스케줄 리스트 */
	List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 알람 리스트 */
	List<ScheduleVO> selectAlarmList(ScheduleVO vo) throws Exception;
	
	/** 알람 정보 설정 */
	int updateAlarm(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 */
	ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 등록 */
	int insertMedInfo(ScheduleVO vo) throws Exception;
	
	/** 처방약 정보 수정 */
	int updateMedInfo(ScheduleVO vo) throws Exception;
	
}

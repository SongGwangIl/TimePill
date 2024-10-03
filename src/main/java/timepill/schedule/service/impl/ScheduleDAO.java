package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/** 스케줄 리스트 */
	List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 정보 조회 */
	ScheduleVO selectSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	int insertSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 삭제 */
	int deleteSchedule(ScheduleVO vo) throws Exception;
	
}

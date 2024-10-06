package timepill.schedule.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/** 한달 총 스케줄 리스트 */
	List<ScheduleVO> selectMthScheList(ScheduleVO vo) throws Exception;
	
	/** 한달 완료된 스케줄 리스트 */
	List<ScheduleVO> selectMthComplScheList(ScheduleVO vo) throws Exception;
	
	
	/** 오늘의 스케줄 리스트 */
	List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 정보 조회 */
	ScheduleVO selectSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	int insertSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 삭제 */
	int deleteSchedule(ScheduleVO vo) throws Exception;
	
	
	/** 스케줄 로그 조회 */
	ScheduleVO selectScheduleLog(ScheduleVO vo) throws Exception;
	
	/** 마지막 스케줄 로그 아이디 가져오기 */
	String selectLastLogId(ScheduleVO vo) throws Exception;
	
	/** 스케줄 로그 등록 */
	int insertScheduleLog(ScheduleVO vo) throws Exception;
	
	/** 스케줄 로그 수정 */
	int updateScheduleLog(ScheduleVO vo) throws Exception;

}

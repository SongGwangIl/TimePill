package timepill.medication.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import timepill.schedule.service.ScheduleVO;

@Mapper
public interface MedicationDAO {
	
	/** 복약 리스트 */
	List<ScheduleVO> selectMedList(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 조회 */
	ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 알람타입 리스트 */
	List<String> selectMedAlarmTypes(ScheduleVO vo) throws Exception;
	
	/** 마지막 복약 아이디 조회 */
	String selectLastMedId() throws Exception;
	
	/** 복약 정보 등록 */
	int insertMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 수정 */
	int updateMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 삭제 */
	int deleteMedInfo(ScheduleVO vo) throws Exception;
}

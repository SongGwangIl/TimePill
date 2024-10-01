package timepill.medication.service;

import java.util.List;

import timepill.schedule.service.ScheduleVO;

public interface MedicationService {
	
	/** 복약 리스트 */
	public List<ScheduleVO> selectMedList(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 조회 */
	public ScheduleVO selectMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 등록 */
	public void insertMedInfo(ScheduleVO vo) throws Exception;
	
	/** 복약 정보 수정 */
	public void updateMedInfo(ScheduleVO vo) throws Exception;
		
	/** 복약 정보 삭제 */
	public void deleteMedInfo(ScheduleVO vo) throws Exception;
}

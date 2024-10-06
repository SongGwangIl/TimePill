package timepill.schedule.service;

import java.util.List;

public interface ScheduleService {
	
	/** 한달 총 스케줄 리스트 */
	public List<ScheduleVO> selectMthScheList(ScheduleVO vo) throws Exception;
	
	/** 한달 완료된 스케줄 리스트 */
	public List<ScheduleVO> selectMthComplScheList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 리스트 */
	public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	public void handleSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 로그 생성, 수정 */
	public void handleScheduleLog(ScheduleVO vo) throws Exception;
	
}

package timepill.schedule.service;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	
	/** 한달 일정 카운트 가져오기 */
	public Map<String, String> getTodoCntList(ScheduleVO vo) throws Exception;
	
	/** 하루 스케줄 */
	public List<ScheduleVO> selectDayScheList(ScheduleVO vo) throws Exception;
	
	/** 스케줄 등록 */
	public void handleSchedule(ScheduleVO vo) throws Exception;
	
	/** 스케줄 로그 생성, 수정 */
	public void handleScheduleLog(ScheduleVO vo) throws Exception;
	
}

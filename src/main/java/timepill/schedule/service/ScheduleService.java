package timepill.schedule.service;

import java.util.List;

public interface ScheduleService {

	List<ScheduleVO> list(String userId);

	int add(ScheduleVO vo);

	ScheduleVO findById(String scheId);

	int delete(String scheId);
	
	int edit(ScheduleVO vo);
}

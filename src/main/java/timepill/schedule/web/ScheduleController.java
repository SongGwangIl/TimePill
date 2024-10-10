package timepill.schedule.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@RestController
public class ScheduleController {

	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;
	
	/** 하루 스케줄 */
	@PostMapping("/day-schedule")
	public List<ScheduleVO> daySchedule(ScheduleVO vo) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		// 하루 스케줄 가져오기
		List<ScheduleVO> selectDayScheList = scheduleService.selectDayScheList(vo);
		
		return selectDayScheList;
	}

	/** 한달 스케줄 */
	@PostMapping("/month-schedule")
	public Map<String, String> mthSchedule(ScheduleVO vo) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		// 한달 일정 카운트 가져오기
		Map<String, String> todoCntList = scheduleService.getTodoCntList(vo);
		
		return todoCntList;
	}

	/** 스케줄 로그 생성, 수정 */
	@PostMapping("/log")
	public String handleScheduleLog(ScheduleVO vo) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		scheduleService.handleScheduleLog(vo);

		return vo.getScheChk();
	}
}

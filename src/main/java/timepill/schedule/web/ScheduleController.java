package timepill.schedule.web;

import java.util.HashMap;
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
	public Map<String, List<ScheduleVO>> daySchedule(ScheduleVO vo) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		HashMap<String, List<ScheduleVO>> map = new HashMap<String, List<ScheduleVO>>();
		
		// 하루 스케줄 가져오기
		System.out.println("하루 스케줄 가져오기 시작");
		List<ScheduleVO> selectDayScheList = scheduleService.selectDayScheList(vo);
		System.out.println("하루 스케줄 가져오기 끝");
		map.put("dayScheList", selectDayScheList);
		
		return map;
	}

	/** 한달 스케줄 */
	@PostMapping("/month-schedule")
	public Map<String, Map<String, String>> mthSchedule(ScheduleVO vo) throws Exception {
		
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();

		// 한달 일정 카운트 가져오기
		Map<String, String> todoCntList = scheduleService.getTodoCntList(vo);
		map.put("mthScheList", todoCntList);
		
		return map;
	}

	/** 스케줄 로그 생성, 수정 */
	@PostMapping("/log")
	public Map<String, String> handleScheduleLog(ScheduleVO vo) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		scheduleService.handleScheduleLog(vo);

		Map<String, String> map = new HashMap<String, String>();
		map.put("scheChk", vo.getScheChk());

		return map;
	}
}

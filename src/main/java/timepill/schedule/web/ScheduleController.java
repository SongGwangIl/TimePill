package timepill.schedule.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@Controller
public class ScheduleController {

	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;
	
	
	/** 임시 메인 */
	@GetMapping("/")
	public String main() {
		return "/main";
	}
	
	/** 스케줄 리스트 */
	@GetMapping("/schedule/list")
	public String selectScheduleList(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		List<ScheduleVO> resultList = scheduleService.selectScheduleList(vo);
		model.addAttribute("scheList", resultList);
		
		return "/schedule/list";
	}
	
	/** 알람 시간 변경 폼(임시) */
	@GetMapping("/schedule/reg-alarm")
	public String registAlarm(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		List<ScheduleVO> resultList = scheduleService.selectAlarmList(vo);
		model.addAttribute("alarmList", resultList);
		
		return "/schedule/registAlarm";
	}
	
	/** 알람 시간 변경 */
	@ResponseBody
	@PostMapping("/schedule/set-alarm")
	public void setAlarm(@RequestBody List<ScheduleVO> resultList) throws Exception {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		for (ScheduleVO vo : resultList) {
			vo.setUserId(userId);
			scheduleService.updateAlarm(vo);
		}
	}
}

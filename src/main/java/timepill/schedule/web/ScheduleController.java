package timepill.schedule.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@Controller
public class ScheduleController {

	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;

	/** 스케줄 리스트(메인) */
	@GetMapping("/")
	public String selectScheduleList(ScheduleVO vo, ModelMap model) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		List<ScheduleVO> resultList = scheduleService.selectScheduleList(vo);
		model.addAttribute("scheList", resultList);

		return "/Main";
	}
	
	/** 스케줄 로그 생성, 수정 */
	@ResponseBody
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

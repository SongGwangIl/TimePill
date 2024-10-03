package timepill.schedule.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;

@Controller
public class ScheduleController {

	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;

	/** 스케줄 리스트(메인) */
	@GetMapping("/")
	public String selectScheduleList(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		List<ScheduleVO> resultList = scheduleService.selectScheduleList(vo);
		model.addAttribute("scheList", resultList);

		return "/Main";
	}
}

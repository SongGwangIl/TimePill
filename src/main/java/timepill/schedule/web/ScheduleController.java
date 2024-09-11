package timepill.schedule.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.schedule.service.ScheduleService;
import timepill.schedule.service.ScheduleVO;
import timepill.user.UserVO;

@Controller
public class ScheduleController {

	/** scheduleService DI */
	@Autowired
	ScheduleService scheduleService;

	
	/** 알람 스케줄 리스트 */
	@GetMapping("/medication/schedule/list")
	public String selectScheduleList(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {

		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		vo.setUserId(userId);

		List<ScheduleVO> resultList = scheduleService.selectScheduleList(vo);
		model.addAttribute("scheList", resultList);
		return "/schedule/list";
	}
	
	/** 알람 정보 설정 폼 */
	@GetMapping("/medication/schedule/reg-alarm")
	public String registAlarm(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		vo.setUserId(userId);
		
		List<ScheduleVO> resultList = scheduleService.selectAlarmList(vo);
		model.addAttribute("alarmList", resultList);
		return "/schedule/registAlarm";
	}
	
	/** 알람 정보 설정 */
	@ResponseBody
	@PostMapping("/medication/schedule/set-alarm")
	public void setAlarm(@RequestBody List<ScheduleVO> resultList) throws Exception {
		
		for (ScheduleVO vo : resultList) {
			scheduleService.updateAlarm(vo);
		}
	}
	
	/** 처방약 정보 등록 or 수정 폼 */
	@GetMapping("/medication/schedule/reg-med")
	public String registMedInfo(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		vo.setUserId(userId);
		
		ScheduleVO result = new ScheduleVO();
		if (vo.getPrescMedId() != null)
			result = scheduleService.selectMedInfo(vo);
		model.addAttribute("result", result);
		return "/schedule/registMed";
	}
	
	/** 처방약 정보 등록*/
	@PostMapping("/medication/schedule/add-med")
	public String addMedInfo(ScheduleVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		vo.setUserId(userId);
		
		scheduleService.insertMedInfo(vo);
		return "redirect:/medication/schedule/list";
	}
	
	/** 처방약 정보 수정*/
	@PostMapping("/medication/schedule/edit-med")
	public String editMedInfo(ScheduleVO vo, ModelMap model) throws Exception {
		
		scheduleService.updateMedInfo(vo);
		return "redirect:/medication/schedule/list";
	}
}

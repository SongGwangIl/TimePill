package timepill.main.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import timepill.alarm.service.AlarmService;
import timepill.schedule.service.ScheduleVO;
import timepill.user.service.UserVO;

@Controller
public class MainController {
	
	/** alarmService DI */
	@Autowired
	AlarmService alarmService;
	
	/** 메인페이지 */
	@GetMapping("/")
	public String main(ScheduleVO vo, ModelMap model) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		List<ScheduleVO> selectAlarmList = alarmService.selectAlarmList(vo);
		
		// 알람 가져오기
		model.addAttribute("alarmList", selectAlarmList);

		return "/Main";
	}
	
	/** 헤더 */
	@GetMapping("/header")
	public String header(ModelMap model, HttpSession session) throws Exception {

		// 로그인 여부 확인
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserVO user = (UserVO) authentication.getPrincipal();
			session.setAttribute("loginUser", user);
		}
		return "common/header";
	}

	/** 푸터 */
	@GetMapping("/footer")
	public String footer() throws Exception {
		return "cmm/Footer";
	}
	
	/** 캘린더 */
	@GetMapping("/calendar")
	public String calendar() throws Exception {
		return "calendar/calendar";
	}

}

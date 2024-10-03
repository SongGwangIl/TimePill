package timepill.alarm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.alarm.service.AlarmService;
import timepill.schedule.service.ScheduleVO;

@Controller
public class AlarmController {

	/** alarmService DI */
	@Autowired
	AlarmService alarmService;

	/** 알람 시간 변경 */
	@ResponseBody
	@PostMapping("/alarm")
	public void setAlarm(ScheduleVO vo) throws Exception {

		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);

		alarmService.updateAlarm(vo);
	}
}

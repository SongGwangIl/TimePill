package timepill.schedule.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

		// 하루 스케줄
		List<ScheduleVO> resultList = scheduleService.selectScheduleList(vo);
		model.addAttribute("scheList", resultList);

		// 한달 총 스케줄
		List<ScheduleVO> selectMthScheList = scheduleService.selectMthScheList(vo);
		model.addAttribute("mthScheList", selectMthScheList);

		// 한달 완료된 스케줄
		List<ScheduleVO> selectMthComplScheList = scheduleService.selectMthComplScheList(vo);
		model.addAttribute("mthCompScheList", selectMthComplScheList);

		return "/Main";
	}

	/** 한달 스케줄 */
	@ResponseBody
	@PostMapping("/mthSchedule")
	public Map<String, Map<String, String>> mthSchedule(ScheduleVO vo) throws Exception {
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();


		// 한달 총 스케줄
		List<ScheduleVO> selectMthScheList = scheduleService.selectMthScheList(vo);
//		map.put("mthScheList", selectMthScheList);

		// 한달 완료된 스케줄
		List<ScheduleVO> selectMthComplScheList = scheduleService.selectMthComplScheList(vo);
//		map.put("mthCompScheList", selectMthComplScheList);

		Map<String, String> mthScheList = new HashMap<String, String>();
		
		
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		calendar.setTime(vo.getMthStartDate()); // 달 시작일
		Date mthEndDate = vo.getMthEndDate(); // 달 마지막일

		while (calendar.getTime().before(mthEndDate) || calendar.getTime().equals(mthEndDate)) {
			Date currentDate = calendar.getTime();
			Integer uncompletedTodo = 0;
			// 현재 날짜에 대한 작업 수행
			for (ScheduleVO result : selectMthScheList) {
				if (currentDate.compareTo(result.getStartDate()) > 0 && currentDate.compareTo(result.getEndDate()) <= 0) { // 복약날짜가 선택된 달의 범위 안에 있는 경우
					uncompletedTodo += result.getTotalDayTodo();
					for (ScheduleVO result2 : selectMthComplScheList) {
						if (result2.getScheDate().compareTo(currentDate) == 0) { // 완료 일정이 현재날짜와 같은 경우
							uncompletedTodo -= result2.getCompletedDayTodo();
						}
					}
					mthScheList.put(dateFormat.format(currentDate), uncompletedTodo.toString());
				}

				// 하루를 더함
				calendar.add(Calendar.DATE, 1);
			}
		}
		map.put("mthScheList", mthScheList);
		return map;
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

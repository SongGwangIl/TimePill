package kr.ac.kopo.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.schedule.service.ScheTimeService;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.schedule.service.ScheduleService;
import kr.ac.kopo.schedule.service.ScheduleVO;

@Controller("/schedule/time")
@RequestMapping("/schedule/time")
public class ScheTimeController {

	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	ScheTimeService scheTimeService;
	
	@GetMapping("/add1.do")
	public String addform(String scheId, Model model) {
		model.addAttribute("svo", scheduleService.findById(scheId));
		return "schedule/time/add1";
	}

	@PostMapping("/add1.do")
	public String add1(String scheId, ScheTimeVO tvo, Model model) {
		
		tvo.setScheId(scheId);
		
		ScheduleVO svo = scheduleService.findById(scheId);
		if(scheTimeService.add(tvo) == 1) 
			System.out.println(svo.getScheId() + "의 scheTime add1 완료");
		
		if(svo.getScheTakeNum() > 1) {
			model.addAttribute("svo", svo);
			return "schedule/time/add2";
		}
		else return "redirect:/schedule/list.do";
	}
	
	@PostMapping("/add2.do")
	public String add2(String scheId, ScheTimeVO tvo, Model model) {
		
		tvo.setScheId(scheId);
		ScheduleVO svo = scheduleService.findById(scheId);
		
		if(scheTimeService.add(tvo) == 1) 
			System.out.println(svo.getScheId() + "의 scheTime add2 완료");
		
		if(svo.getScheTakeNum() > 2) {
			model.addAttribute("svo", svo);
			return "schedule/time/add3";
		}
		else return "redirect:/schedule/list.do";
	}
	
	@PostMapping("/add3.do")
	public String add3(String scheId, ScheTimeVO tvo) {
		
		tvo.setScheId(scheId);
		
		if(scheTimeService.add(tvo) == 1) 
			System.out.println(scheId + "의 scheTime add3 완료");
		return "redirect:/schedule/list.do";
	}
}

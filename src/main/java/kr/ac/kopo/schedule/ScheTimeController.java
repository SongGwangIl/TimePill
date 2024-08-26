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
	
	//소분류 알림 상세 조회 및 수정용 페이지로 이동
	@GetMapping("/edit.do")
	public String findById(String timeId, Model model) {
		
		ScheTimeVO svo = scheTimeService.findById(timeId);
		
		model.addAttribute("svo", svo);
		
		return "schedule/time/edit";
	}

	
	//소분류 알림 위 view 페이지에서 넘겨받은 값으로 수정
	@PostMapping("/edit.do")
	public String edit(ScheTimeVO vo) {
		
		if(scheTimeService.edit(vo) == 1)
			System.out.println(vo + " 수정 성공!");

		return "redirect:/schedule/list.do";  
	}
	
	
	
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
	
	@GetMapping("/deltime.do")
	public String delTime(String timeId) {
		
		if(scheTimeService.delTime(timeId) == 1)
			System.out.println(timeId + " 삭제 성공!");

		return "redirect:/schedule/list.do";  
	}
}

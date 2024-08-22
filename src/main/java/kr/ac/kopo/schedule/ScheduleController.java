package kr.ac.kopo.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.ac.kopo.schedule.service.ScheTimeService;
import kr.ac.kopo.schedule.service.ScheduleService;
import kr.ac.kopo.schedule.service.ScheduleVO;
import kr.ac.kopo.user.UserVO;

@Controller("/schedule")
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	ScheTimeService scheTimeService;
	
	
	//대분류 알림 목록 조회
	@GetMapping("/list.do")
	public String list(@SessionAttribute("loginUser") UserVO uvo, Model model) {
		List<ScheduleVO> lvo = scheduleService.list(uvo.getUserId());
		model.addAttribute("lvo",lvo);
		
		return "schedule/list";
	}

	
	//대분류 알림 추가 목적 view로 이동
	@GetMapping("/add.do")
	public String addform() {
		return "schedule/add";
	}
	
	//대분류 알림 추가
	@PostMapping("/add.do")
	public String add(@SessionAttribute("loginUser") UserVO uvo, ScheduleVO svo) {
		
		svo.setUserId(uvo.getUserId());
		scheduleService.add(svo);
		
		System.out.println(svo.getScheTitle() + " 스케줄 추가 완료");
		
		return "redirect:/schedule/list.do";
	}
	
	
	//대분류 알림 삭제
	@GetMapping("/delete.do")
	public String delete(String scheId) {
		
		if(scheduleService.delete(scheId) == 1)
			System.out.println(scheId + " 삭제 성공!");

		return "redirect:/schedule/list.do";  
	}
	
	
	//대분류 알림 상세 조회 및 수정용 페이지로 이동
	@GetMapping("/edit.do")
	public String findById(String scheId, Model model) {
		ScheduleVO vo = scheduleService.findById(scheId);
		model.addAttribute("vo",vo);
		
		return "schedule/edit";
	}
	
	//대분류 알림 위 view 페이지에서 넘겨받은 값으로 수정
	@PostMapping("/edit.do")
	public String edit(ScheduleVO vo) {
		
		if(scheduleService.edit(vo) == 1)
			System.out.println(vo + " 수정 성공!");

		return "redirect:/schedule/list.do";  
	}

}

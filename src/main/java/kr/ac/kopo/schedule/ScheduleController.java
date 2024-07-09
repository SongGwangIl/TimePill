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
import kr.ac.kopo.schedule.service.ScheTimeVO;
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
	
	@GetMapping("/list.do")
	public String list(@SessionAttribute("loginUser") UserVO uvo, Model model) {
		List<ScheduleVO> lvo = scheduleService.list(uvo.getUserId());
		model.addAttribute("lvo",lvo);
		
//		List<ScheTimeVO> tvo = scheTimeService.list(uvo.getUserId()); // xml에 schedule이랑 조인문 들어가야 함
//		model.addAttribute(tvo); // 근데 이거 있으면 스케쥴 vo 필요없는거 아냐?
		
		// scheTimeVO tvo 추가. tvo.scheId = lvo...scheId인 데이터만 가져오는게 가능할까?
		// 스케쥴 갯수만큼 scheId로 조회해서 가져와야 하는데 이거 되는거 맞나? ^^;
		// 어떻게든 가능은 할 수 있더라도 로딩이슈 장난아닐것같음...
		
		return "schedule/list";
	}
	
	@GetMapping("/add.do")
	public String addform() {
		return "schedule/add";
	}
	
	@PostMapping("/add.do")
	public String add(@SessionAttribute("loginUser") UserVO uvo, ScheduleVO svo) {
		svo.setUserId(uvo.getUserId());
		int num = scheduleService.add(svo);
		System.out.println(svo.getScheTitle() + " 스케쥴 추가 완료");
		
		return "redirect:/schedule/list.do";
	}
	
}

package kr.ac.kopo.main;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;
import kr.ac.kopo.user.UserVO;

@Controller
public class MainController{
		
	@Autowired
	private RecordService recordService;
		
	@GetMapping("/main")
	public String list(Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();

		List<RecordVO> listByAll = recordService.selectByAll(userId);
		List<RecordVO> listByToday = recordService.selectByToday(userId);
		
		model.addAttribute("recordSelectByAll", listByAll);
		model.addAttribute("recordSelectByToday", listByToday);

		return "common/main";
	}

	
	@GetMapping("/select.do")
	public String select(RecordVO vo, Model model, HttpSession session) {
			
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//vo로 받아온 파라미터 takeDate
		String takeDate = vo.getTakeDate();

		List<RecordVO> listByDate = recordService.selectByDate(takeDate, userId);
			
		model.addAttribute("recordSelectByDate", listByDate);
		model.addAttribute("takeDate", takeDate);

		return "record/select";
	}
	
}
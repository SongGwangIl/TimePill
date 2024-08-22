package kr.ac.kopo.record;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;
import kr.ac.kopo.schedule.service.ScheTimeService;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.schedule.service.ScheduleService;
import kr.ac.kopo.user.UserVO;

@Controller
public class MainController{
		
	@Autowired
	private RecordService recordService;

		
	@GetMapping("/main")
	public String alarmList(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		//파라미터 takeDate
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		String takeDate = vo.getTakeDate();
		
		//오늘의 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String today = LocalDate.now().format(formatter);

		List<RecordVO> alarmList = recordService.selectAlarmToday(takeDate, userId);
		
		/* 구현중 
		//먹은 날짜 takeDate와 timeId를 통해서 takeId가 없어도 특정 로그를 특정할 수 있음
		// 로그가 없으면 N, 있으면 Y/N 가져오면 됨
		List<String> takeSuccess = recordService.selectTakeSuccess()
		*/
			
		//view 출력용 model 세팅
		model.addAttribute("today", today);
		model.addAttribute("alarmList", alarmList);

		return "common/main";
	}
	
	@PostMapping("/addlog.do")
	public String addLog(ScheTimeVO stvo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//debug용 객체 int num
		int num1 = 0;
		int num2 = 0;
		
		//ScheTimeVO를 통해 timeId 받아옴
		String timeId = stvo.getTimeId();
		
		//오늘의 날짜 takeDate
		DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter dateTimeFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
		String takeDate = LocalDate.now().format(dateFmt);
		String takeDateTime = LocalDateTime.now().format(dateTimeFmt);
		
		System.out.println(takeDate + " " + takeDateTime);
		
		// 1. timeId + takeDate 를 통해 셀렉트 해서 해당 값이 있으면 업데이트로, 없으면 인서트로 
		// 값이 없으면 takeId가 없으므로 위와 같은 변수를 통해서 select해야함
		int result = recordService.selectLogToday(takeDate, timeId);
		
		System.out.println(result + "개의 takeLog 있음");
		
		if(result == 0 ) {
			//결과가 없다 = 오늘의 날짜로는 먹었다고 체크한 적이 없다
			//timeId, userId를 매개변수로 addTakeLog 실행
			num1 = recordService.addTakeLog(timeId, userId);
		} else {
			//결과가 있다 = 오늘의 날짜로 먹었다고 체크한 적이 있다 (삭제했다고 하더라도)
			//takeDate, timeId를 통해서 특정 및 takeDate 값으로 업데이트
			num2 = recordService.updateTakeLog(takeDateTime, timeId);
		}
		
		//디버깅로그
		System.out.println(num1 + "개의 takeLog 추가");
		System.out.println(num2 + "개의 takeLog 수정");
		
		return "redirect:/main";
		
	}
	
	@PostMapping("/alarmSelect.do")
	public String alarmSelect(RecordVO rvo, ScheTimeVO stvo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//ScheTimeVO를 통해 timeId 받아옴
		String timeId = stvo.getTimeId();
		
		//vo로 받아온 파라미터 takeDate
		String takeDate = rvo.getTakeDate();

		//timeId, userId를 매개변수로 addTakeLog 실행
		List<RecordVO> alarmByDateList = recordService.selectAlarmByDate(timeId, userId, takeDate);
		
		model.addAttribute("alarmByDateList", alarmByDateList);
		model.addAttribute("takeDate", takeDate);
		
		return "/record/mainselect";
		
	}

}
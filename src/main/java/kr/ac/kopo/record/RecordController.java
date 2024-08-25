package kr.ac.kopo.record;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.user.UserVO;


@Controller
@RequestMapping
public class RecordController{
		
	@Autowired
	private RecordService recordService;
	
	
	//메인 화면 (오늘의 날짜로 자동 알람 목록 조회)
	@GetMapping("/main")
	public String alarmList(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		
		//오늘의 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String todayDate = LocalDate.now().format(formatter);

		List<RecordVO> alarmByDateList = recordService.selectAlarmByDate(todayDate, userId);
			
		//view 출력용 model 세팅
		model.addAttribute("today", todayDate);
		model.addAttribute("alarmByDateList", alarmByDateList);

		return "record/main";
	}
	
	
	//복용 로그 기록 및 수정
	@PostMapping("/addlog.do")
	public String addLog(ScheTimeVO stvo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//debug용
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
		
		// timeId + takeDate 를 통해 셀렉트 해서 해당 값이 있으면 업데이트로, 없으면 인서트로 
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
	
	
	//먹어야 할 약품 목록을 날짜를 기준으로 조회
	@GetMapping("/alarmSelect.do")
	public String alarmSelect(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//브라우저에서 파라미터 takeDate, 조회하고 싶은 날짜
		String takeDate = vo.getTakeDate();

		//날짜를 기준으로 복용해야 하는 약의 알람 리스트 조회
		List<RecordVO> alarmByDateList = recordService.selectAlarmByDate(takeDate, userId);
		
		//view 전달
		model.addAttribute("alarmByDateList", alarmByDateList);
		model.addAttribute("takeDate", takeDate);
		
		return "/record/alarmselect";
		
	}
	
	
	@GetMapping("record/list.do")
	public String list(RecordVO recordVO, Model model, HttpSession session) {
		
		
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		System.out.println(userId);
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		recordVO.setUserId(userId);

		//조회를 위한 날짜 파라미터 값 
		// 1. takeDate(브라우저로부터 넘겨받는 값) 
		String takeDate = recordVO.getTakeDate();
		System.out.println(takeDate);
		
		// 2. today(오늘의 날짜 첫 조회 디폴트 값) 
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String today = LocalDate.now().format(formatter);
		System.out.println(today);
		
		//전체목록 조회, 날짜별목록 조회
		List<RecordVO> listByAll = recordService.selectLogByAll(recordVO);
		List<RecordVO> listByDate;
		List<RecordVO> listChart;
		
		//조회하려는 날짜와 오늘 날짜가 동일할 경우 혹은 takeDate값이 없음
		if (takeDate == today || takeDate == "") { 
			listByDate = recordService.selectLogByDate(today, userId);
			listChart = recordService.selectChart(today, userId);
		} else {
		//조회하려는 날짜와 오늘 날짜가 동일하지 않을 경우
			listByDate = recordService.selectLogByDate(takeDate, userId);
			listChart = recordService.selectChart(takeDate, userId);
		}
		
		Iterator<RecordVO> it = listChart.iterator();

		//JSON 
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		while(it.hasNext()) {
			RecordVO rvo = it.next();
			JsonObject object = new JsonObject();
			
			double cntTakeLog = rvo.getCntTakeLog();
			int cntAlarm = rvo.getCntAlarm();
			
			double rate = Math.round(cntTakeLog/cntAlarm * 100);
			String date = rvo.getTakeDate();
		
		    object.addProperty("Rate", rate);
			object.addProperty("Date", date);
			jArray.add(object);	
		}
		
		String json = gson.toJson(jArray);
		
		//view 출력용 model 세팅
		model.addAttribute("JSON", json);
		model.addAttribute("today", today);
		model.addAttribute("takeDate", takeDate);
		model.addAttribute("recordSelectByAll", listByAll);
		model.addAttribute("recordSelectByDate", listByDate);

		//view 주소 반환
		return "record/list";
	}
	
	
	
	//복용 기록 off 기능
	@PostMapping("record/off")
	public String off(String takeId, Model model) {
		
		//오늘의 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String takeDate = LocalDate.now().format(formatter);

		int result = recordService.off(takeId);
		
		System.out.println(takeId);
		System.out.println(result + "개의 복용 기록 취소");
		
		return "redirect:/record/list.do?takeDate=" + takeDate;
	}

}
package kr.ac.kopo.record;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;
import kr.ac.kopo.user.UserVO;

@Controller
@RequestMapping("/record")
public class RecordController{
		
	@Autowired
	private RecordService recordService;
		
	@PostMapping("/list.do")
	public String list(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//파라미터 takeDate
		String takeDate = vo.getTakeDate();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();

		//전체목록 조회, 날짜별목록 조회
		List<RecordVO> listByAll = recordService.selectByAll(userId);
		List<RecordVO> listByDate = recordService.selectByDate(takeDate, userId);
		List<RecordVO> listChart = recordService.selectChart(takeDate, userId);
		
		Iterator<RecordVO> it = listChart.iterator();

		//JSON 
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
		
		//오늘의 날짜
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String fmtToday = today.format(formatter);
		
		//view 출력용 model 세팅
		model.addAttribute("JSON", json);
		model.addAttribute("today", fmtToday);
		model.addAttribute("recordSelectByAll", listByAll);
		model.addAttribute("recordSelectByDate", listByDate);
		model.addAttribute("takeDate", takeDate);

		//view 주소 반환
		return "record/list";
	}

	
//	@GetMapping("/select.do")
//	public String select(RecordVO vo, Model model, HttpSession session) {
//			
//		//세션객체에 저장된 로그인 정보에서 id를 받아옴
//		UserVO uvo = (UserVO) session.getAttribute("loginUser");
//		String userId = uvo.getUserId();
//		
//		//vo로 받아온 파라미터 takeDate
//		String takeDate = vo.getTakeDate();
//
//		List<RecordVO> listByDate = recordService.selectByDate(takeDate, userId);
//			
//		model.addAttribute("recordSelectByDate", listByDate);
//		model.addAttribute("takeDate", takeDate);
//
//		return "record/select";
//	}
	

//	@GetMapping("/selectChart")
//	public String selectChart(RecordVO vo, Model model, HttpSession session) {
//			
//		//세션객체에 저장된 로그인 정보에서 id를 받아옴
//		UserVO uvo = (UserVO) session.getAttribute("loginUser");
//		String userId = uvo.getUserId();
//		
//		//vo로 받아온 파라미터 takeDate
//		String takeDate = vo.getTakeDate();
//		
//		Gson gson = new Gson();
//		JsonArray jArray = new JsonArray();
//		
//
//		List<RecordVO> listChart = recordService.selectChart(takeDate, userId);
//		//List<Double> rateArray = new ArrayList<Double>();
//		
//		
//		Iterator<RecordVO> it = listChart.iterator();
//
//		
//		while(it.hasNext()) {
//			RecordVO rvo = it.next();
//			JsonObject object = new JsonObject();
//			
//			double cntTakeLog = rvo.getCntTakeLog();
//			int cntAlarm = rvo.getCntAlarm();
//			
//			double rate = Math.round(cntTakeLog/cntAlarm * 100) / 100.0;
//			String date = rvo.getTakeDate();
//		
//		    object.addProperty("Rate", rate);
//			object.addProperty("Date", date);
//			jArray.add(object);	
//		}
//		
//		String json = gson.toJson(jArray);
//		
//		model.addAttribute("JSON", json);
//		model.addAttribute("listChart", listChart);
//		model.addAttribute("takeDate", takeDate);
//
//		return "record/chart";
//			
//	}
}
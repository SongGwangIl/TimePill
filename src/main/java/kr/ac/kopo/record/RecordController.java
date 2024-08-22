package kr.ac.kopo.record;

import java.time.LocalDate;
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
import kr.ac.kopo.user.UserVO;

@Controller
@RequestMapping("/record")
public class RecordController{
		
	@Autowired
	private RecordService recordService;
		
	@GetMapping("/list.do")
	public String list(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		//파라미터 takeDate
		String userId = ((UserVO) session.getAttribute("loginUser")).getUserId();
		String takeDate = vo.getTakeDate();
		
		//오늘의 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String today = LocalDate.now().format(formatter);

		//전체목록 조회, 날짜별목록 조회
		List<RecordVO> listByAll = recordService.selectLogByAll(userId);
		List<RecordVO> listByDate = recordService.selectLogByDate(takeDate, userId);
		List<RecordVO> listChart = recordService.selectChart(takeDate, userId);
		
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
		model.addAttribute("recordSelectByAll", listByAll);
		model.addAttribute("recordSelectByDate", listByDate);
		model.addAttribute("takeDate", takeDate);

		//view 주소 반환
		return "record/list";
	}
	
	//복용 기록 on/off 기능
	@PostMapping("/off")
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
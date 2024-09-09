package timepill.dispensor;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import timepill.dispensor.service.DispensorService;
import timepill.user.UserVO;

@Controller
public class DispensorController {
	
	@Autowired
	DispensorService dispensorService;
	
	private final SseEmitters sseEmitters;
	
	public DispensorController(SseEmitters sseEmitters) {
		this.sseEmitters = sseEmitters;
	}
	
	@GetMapping("/dispensor")
	public String dispensor() {
				
		return "dispensor/dispensor";
	}
	@ResponseBody
	@PostMapping("/dispensor/getAlarms")
	public Map<String, Object> getAlarms(@SessionAttribute("loginUser") UserVO vo){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<AlarmInfoVO> alarms = dispensorService.getAlarms(vo.getUserId());
		map.put("arlarms",alarms);
		
		return map;
	}	
	
	@ResponseBody
	@GetMapping(value = "/dispensor/connect", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> connect(){
		
		SseEmitter emitter = new SseEmitter();
		sseEmitters.add(emitter);
		try {
			emitter.send(SseEmitter.event().name("connect").data("connected"));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return ResponseEntity.ok(emitter);
	}
	@ResponseBody
	@PostMapping("/update")
	public ResponseEntity<Void> update(){
		sseEmitters.update();
		return ResponseEntity.ok().build();
	}
	

}

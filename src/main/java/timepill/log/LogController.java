package timepill.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import timepill.log.service.LogService;

@Controller
public class LogController {
	
	@Autowired
	LogService logService;

	@GetMapping("/")
	public String main() {
		
		return "log/main";
	}
	
}
	

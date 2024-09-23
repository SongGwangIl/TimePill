package timepill.com;

import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import timepill.user.UserVO;

@Controller
public class HeaderFooterController {
	
	@GetMapping("/header")
	public String header(ModelMap model, HttpSession session) throws Exception {

		// 로그인 여부 확인
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserVO user = (UserVO) authentication.getPrincipal();
			session.setAttribute("loginUser", user);
		}
		return "common/header";
	}

	@GetMapping("/footer")
	public String footer() throws Exception {
		return "cmm/Footer";
	}

}

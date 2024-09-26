package timepill.user.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.user.service.UserService;
import timepill.user.service.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	/** 초기화면요청 */
	@GetMapping("/cover")
	public String cover() {
		return "cover";
	}
	
	/** 로그인(시큐리티 처리) */
	@GetMapping("/user/login")
	public String loginForm() {
		
		return "user/login";
	}
	
	/** 약관동의 화면요청 */
	@GetMapping("/user/terms")
	public String terms() {
		
		return "user/terms";
	}
	
	/** 회원가입 화면요청 */
	@GetMapping("/user/singup")
	public String addForm() {
		
		return "user/add";
	}
	
	/** 회원가입 */ 
	@PostMapping("/user/singup")
	public String add(UserVO vo, HttpServletRequest request) throws Exception {
		
		userService.add(vo);
		
		request.setAttribute("msg", "회원가입 되었습니다.");
		request.setAttribute("url", "/cover");		
		
		return "common/msg";			
	}
	
	/** 아이디 사용유무확인 ajax 요청,응답 */
	@ResponseBody
	@PostMapping("/user/checkId")
	public String checkId(String userId) {
		
		String result = userService.checkId(userId);
		
		return result;
	}
	
}

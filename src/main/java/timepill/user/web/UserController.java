package timepill.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.kakao.service.KakaoService;
import timepill.user.service.AuthService;
import timepill.user.service.AuthVO;
import timepill.user.service.UserService;
import timepill.user.service.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	AuthService authService;
	
	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	/** 로그인(시큐리티 처리) */
	@GetMapping("/user/login")
	public String loginForm() {
		
		return "user/Login";
	}
	
	/** 로그아웃(시큐리티 처리) */
	@PostMapping("/user/logout")
	public void logout() throws Exception {
		kakaoService.logout();
	}
	
	/** 약관동의 화면요청 */
	@GetMapping("/user/terms")
	public String terms() {
		
		return "user/Terms";
	}
	
	/** 회원가입 화면요청 */
	@GetMapping("/user/singup")
	public String addForm(UserVO vo) {
		
		return "user/Add";
	}
	
	/** 회원가입 */ 
	@PostMapping("/user/singup")
	public String add(@Valid UserVO vo, BindingResult result, HttpServletRequest request) throws Exception {
		if(result.hasErrors())
			return "user/Add";
		
		userService.add(vo);
		
		request.getSession().setAttribute("message", "회원가입 되었습니다.");
		
		return "user/Login";			
	}
	
	/** 아이디 사용유무확인 ajax 요청,응답 */
	@ResponseBody
	@PostMapping("/user/check-id")
	public String checkId(String userId) {
		
		String result = userService.checkId(userId);
		
		return result;
	}
	
	@GetMapping("/user/find-id")
	public String findId() {
		
		return "user/findId";
	}
	
	@ResponseBody
	@PostMapping("/user/find-id")
	public String findId(String email) {
		
		String result = userService.findId(email);
		
		return result;
	}
	
	@GetMapping("/user/auth-email")
	public String authEmail() {
		
		return "user/AuthEmail";
	}
	
	@ResponseBody
	@PostMapping("/user/auth-email")
	public String authEmail(AuthVO vo, HttpServletResponse response, Model model) throws Exception {
		
		String result = authService.authEmail(vo);
		
		return result;
	}
	
	@PostMapping("/user/auth-atmp")
	public String authAtmp(AuthVO vo, HttpSession session, Model model) {
		
		String result = authService.authAtmp(vo);
		
		if(result.equals("Y")) {
			session.setAttribute("authOK", vo);
			
			return "user/ResetPassword";
		}			
		else {
			model.addAttribute("message", "인증에 실패했습니다.");
			
			return "user/AuthEmail";
		}
		
		
	}
	
	@GetMapping("/user/reset-password")
	public String resetPassword(HttpSession session) {
		
		if(session.getAttribute("authOK") == null) {
			session.setAttribute("message", "인증정보가 없습니다.");
			
			return "/user/Auth-email";
		}
				
		return "user/ResetPassword";
	}
	
	@PostMapping("/user/reset-password")
	public String resetPassword(UserVO vo, HttpSession session) {
		
		AuthVO avo = (AuthVO)session.getAttribute("authOK");
		session.removeAttribute("authOK");
		vo.setUserId(avo.getUserId());
		vo.setEmail(avo.getEmail());
		
		userService.resetPassword(vo);
		session.setAttribute("message", "변경되었습니다.");
		
		return "redirect:/user/login";		
	}
	
	
	@GetMapping("/mypage")
	public String myPage() {
		
		return "user/MyPage";
	}
	
	@PostMapping("/mypage")
	public String myPage(String password, UserVO vo, HttpSession session) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		
		UserVO uvo = userService.getMyInfo(vo);
		boolean isMatch = encoder.matches(password, uvo.getPassword());
		
		if(isMatch)
			return "redirect:/changeMyInfo";
		else
			session.setAttribute("message", "비밀번호가 일치하지 않습니다.");
		return "user/Mypage";
	}
	
	@GetMapping("/mypage/change-Password")
	public String changePw() {
		return "user/resetPassword";
	}
	
	@GetMapping("/mypage/change-myinfo")
	public String changeMyInfo(UserVO vo, Model model) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId);
		System.out.println(vo.getPassword());
		UserVO uvo = userService.getMyInfo(vo);
		
		model.addAttribute("userVO", uvo);
		
		return "user/ChangeMyInfo";
	}
	
	@PostMapping("/mypage/change-myinfo")
	public String chageMyInfo(UserVO vo, BindingResult result, Model model) {
		
		if(result.hasErrors())
			return "changeMyInfo";
		
		userService.changeMyInfo(vo);
		model.addAttribute("message", "변경되었습니다.");
		
		return "redirect:/";
	}
}

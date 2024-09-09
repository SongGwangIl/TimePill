package timepill.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import timepill.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	// 초기화면요청
	@GetMapping("/cover")
	public String cover() {
		return "cover";
	}
	// 로그인 화면요청
	@GetMapping("/user/login")
	public String loginForm() {
		
		return "user/login";
	}
	// 로그인 요청
	@PostMapping("/user/login")
	public String login(UserVO vo, HttpSession session) {
		UserVO uvo = userService.login(vo.getUserId());
		String name = null;
		//name에 사용자이름또는 보호자이름 저장
		if(StringUtils.hasText(uvo.getUserName()))
			name = uvo.getUserName();
		//로그인
		if ( uvo != null && vo.getUserId().equals(uvo.getUserId()) && 
				vo.getPassword().equals(uvo.getPassword()) ) 
		{
			//로그인 성공
			session.setAttribute("loginUser", uvo);
			//정보미입력시 입력창 이동
			if(name == null) 				
				return "user/addUserInfo";			
			
			//정보입력완료시 메인창 이동
			else {
				session.setAttribute("name", name);
				if (uvo.getUserCarerAt().equals("N"))
					return "redirect:/device";
				else 
					return "redirect:/main";
			}
		}
		// 로그인 실패	
		return "redirect:/login";
	}
	//로그아웃 요청
	@GetMapping("/user/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/cover";
	}
	//약관동의 화면요청
	@GetMapping("/user/terms")
	public String terms() {
		
		return "user/terms";
	}
	//회원가입 화면요청
	@GetMapping("/user/singup")
	public String addForm() {
		
		return "user/add";
	}
	//회원가입 
	@PostMapping("/user/singup")
	public String add(UserVO vo, HttpServletRequest request) {
		
		userService.add(vo);
		
		request.setAttribute("msg", "회원가입 되었습니다.");
		request.setAttribute("url", "/cover");		
		
		return "user/msg";			
	}
	//아이디 사용유무확인 ajax 요청,응답
	@ResponseBody
	@PostMapping("/user/checkId")
	public String checkId(String userId) {
		String result = userService.checkId(userId);
		
		return result;
	}
	//사용자 정보입력 화면요청
	@GetMapping("/user/addUserInfo")
	public String UserInfo(@SessionAttribute("loginUser")UserVO vo, Model model) {
		String carerAt = userService.getUserCarerAt(vo.getUserId());
		model.addAttribute("carerAt", carerAt);
		
		return "user/addUserInfo";
	}
	//사용자 정보입력
	@PostMapping("/user/addUserInfo")
	public String addUserInfo(UserVO vo, HttpServletRequest request) {
		
		userService.addUserInfo(vo);
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/kopo/device");
		
		return "user/msg";
	}
	//나의정보변경 화면 요청
	@GetMapping("/myPage")
	public String myPage(@SessionAttribute("loginUser") UserVO vo, Model model) {
		String userId = vo.getUserId();
		String userName = userService.getUserName(userId);
		//정보 미 등록시 등록화면 이동
		if(!StringUtils.hasText(userName))			
			return "user/addUserInfo";
			
		//정보 등록되어있는 경우 변경화면 이동
		UserVO uivo = userService.getUserInfo(vo);
		
		model.addAttribute("myInfo", uivo);
		
		return "user/myPage";
	}
	//나의정보변경
	@PostMapping("/myPage")
	public String myPage(UserVO uvo, HttpSession session) {
		
		userService.updateMyInfo(uvo);
		  
		session.setAttribute("name", uvo.getUserName());
		
		return "redirect:/main";
	}
}

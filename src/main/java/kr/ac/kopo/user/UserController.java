package kr.ac.kopo.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.ac.kopo.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	// 초기화면요청
	@RequestMapping("/cover")
	public String cover() {
		return "user/cover";
	}
	// 로그인 화면요청
	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String loginForm() {
		
		return "user/login";
	}
	// 로그인 요청
	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("userId") UserVO vo, HttpSession session) {
			
		UserVO uvo = userService.login(vo.getUserId());
		String name = null;
		//name에 사용자이름또는 보호자이름 저장
		if(uvo != null && uvo.getUserSelect().equals("user"))
			name = userService.getUserName(vo.getUserId());
		else if(uvo != null && uvo.getUserSelect().equals("protector"))
			name = userService.getProtectorName(vo.getUserId());
		
		//로그인
		if ( uvo != null && vo.getUserId().equals(uvo.getUserId()) && 
				vo.getUserPwd().equals(uvo.getUserPwd()) ) 
		{
			//로그인 성공
			session.setAttribute("loginUser", uvo);
			//정보미입력시 입력창 이동
			if(name == null) {
				if(uvo.getUserSelect().equals("user"))				
					return "user/addUserInfo";				
				else 
					return "user/addProtectorInfo";				
			}
			//정보입력완료시 메인창 이동
			else {
				session.setAttribute("name", name);
				
				return "redirect:/main";
			}
		}
		// 로그인 실패	
		return "redirect:/login";
	}
	//로그아웃 요청
	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/cover";
	}
	//약관동의 화면요청
	@RequestMapping(path = "/terms", method = RequestMethod.GET)
	public String terms() {
		
		return "user/terms";
	}
	//회원가입 화면요청
	@RequestMapping(path = "/singup", method = RequestMethod.GET)
	public String addForm() {
		
		return "user/add";
	}
	//회원가입 
	@RequestMapping(path = "/singup", method = RequestMethod.POST)
	public String add(UserVO vo, HttpServletRequest request) {
		
		userService.add(vo);
		
		request.setAttribute("msg", "회원가입 되었습니다.");
		request.setAttribute("url", "/kopo/cover");		
		
		return "user/msg";			
	}
	//아이디 사용유무확인 ajax 요청,응답
	@ResponseBody
	@RequestMapping(path = "/checkId", method = RequestMethod.POST)
	public String checkId(String userId) {
		String result = userService.checkId(userId);
		
		return result;
	}
	//보호자 정보입력 화면요청
	@RequestMapping(path = "/addProtectorInfo", method = RequestMethod.GET)
	public String ProtectorInfo() {
		
		return "user/addProtectorInfo";
	}
	//보호자 정보입력
	@RequestMapping(path = "/addProtectorInfo", method = RequestMethod.POST)
	public String addProtectorInfo(UserInfoVO vo, HttpServletRequest request) {
		
		userService.addProtectorInfo(vo);
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/kopo/main");
		
		return "user/msg";
	}	
	//사용자 정보입력 화면요청
	@RequestMapping(path = "/addUserInfo", method = RequestMethod.GET)
	public String UserInfo() {
		
		return "user/addUserInfo";
	}
	//사용자 정보입력
	@RequestMapping(path = "/addUserInfo", method = RequestMethod.POST)
	public String addUserInfo(UserInfoVO vo, HttpServletRequest request) {
		
		userService.addUserInfo(vo);
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/kopo/main");
		
		return "user/msg";
	}
	//나의정보변경 화면 요청
	@GetMapping("/myPage")
	public String myPage(@SessionAttribute("loginUser") UserVO vo, Model model) {
		String userId = vo.getUserId();
		String userValid = userService.getUserValid(userId);
		String userSelect = userService.getUserSelect(userId);
		//정보 미 등록시 등록화면 이동
		if(userValid.equals("F")) {
			if(userSelect.equals("user"))
				return "user/addUserInfo";
			else
				return "user/addProtectorInfo";
		}
		//정보 등록되어있는 경우 변경화면 이동
		UserInfoVO uivo = userService.getUserInfo(vo);
		
		model.addAttribute("myInfo", uivo);
		
		return "user/myPage";
	}
	//나의정보변경
	@PostMapping("/myPage")
	public String myPage(UserInfoVO uivo, HttpSession session) {
		
		String select = userService.updateMyInfo(uivo);
		
		String name;
		if(select.equals("user"))
			name = uivo.getUserName();
		else
			name = uivo.getProtName();
		session.setAttribute("name", name);
		
		return "redirect:/main";
	}
}

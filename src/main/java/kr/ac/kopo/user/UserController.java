package kr.ac.kopo.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ac.kopo.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/cover")
	public String cover() {
		return "user/cover";
	}
	
	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String loginForm() {
		
		return "user/login";
	}

	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("userId") UserVO vo, HttpSession session) {
			
		UserVO uvo = userService.login(vo.getUserId());
		String name = null;
		
		if(uvo.getUserSelect().equals("user"))
			name = userService.getUserName(vo.getUserId());
		else if(uvo.getUserSelect().equals("protector"))
			name = userService.getProtectorName(vo.getUserId());
		
		
		if ( uvo != null && vo.getUserId().equals(uvo.getUserId()) && 
				vo.getUserPwd().equals(uvo.getUserPwd()) ) 
		{
			//로그인 성공
			session.setAttribute("loginUser", uvo);
			if(name == null) {
				if(uvo.getUserSelect().equals("user"))				
					return "user/addUserInfo";				
				else 
					return "user/addProtectorInfo";				
			}				
			else {
				session.setAttribute("name", name);
				
				return "redirect:/main";
			}
		}
		// 로그인 실패	
		return "redirect:/login";
	}
	
	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/cover";
	}
	
	@RequestMapping(path = "/terms", method = RequestMethod.GET)
	public String terms() {
		
		return "user/terms";
	}
	
	@RequestMapping(path = "/term1Show", method = RequestMethod.GET)
	public String terms1Show() {
		
		return "user/term1";
	}
	
	
	
	@RequestMapping(path = "/singup", method = RequestMethod.GET)
	public String addForm() {
		
		return "user/add";
	}
	
	@RequestMapping(path = "/singup", method = RequestMethod.POST)
	public String add(UserVO vo, HttpServletRequest request) {
		
		userService.add(vo);
		
		request.setAttribute("msg", "회원가입 되었습니다.");
		request.setAttribute("url", "/kopo/cover");		
		
		return "user/msg";			
	}
	
	@ResponseBody
	@RequestMapping(path = "/checkId", method = RequestMethod.POST)
	public String checkId(String userId) {
		String result = userService.checkId(userId);
		
		return result;
	}
	
	@RequestMapping(path = "/addProtectorInfo", method = RequestMethod.GET)
	public String ProtectorInfo() {
		
		return "user/addProtectorInfo";
	}
	
	@RequestMapping(path = "/addProtectorInfo", method = RequestMethod.POST)
	public String addProtectorInfo(UserInfoVO vo, HttpServletRequest request) {
		
		userService.addProtectorInfo(vo);
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/kopo/main");
		
		return "user/msg";
	}
	
	
	@RequestMapping(path = "/addUserInfo", method = RequestMethod.GET)
	public String UserInfo() {
		
		return "user/addUserInfo";
	}

	@RequestMapping(path = "/addUserInfo", method = RequestMethod.POST)
	public String addUserInfo(UserInfoVO vo, HttpServletRequest request) {
		
		userService.addUserInfo(vo);
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/kopo/main");
		
		return "user/msg";
	}
}

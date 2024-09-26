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
	
	/** 초기화면요청 */
	@GetMapping("/cover")
	public String cover() {
		return "cover";
	}
	
	/** 로그인 화면요청 */
	@GetMapping("/user/login")
	public String loginForm() {
		
		return "user/login";
	}
	
	
//	/** 로그인 요청 */
//	@PostMapping("/user/login")
//	public String login(UserVO vo, HttpSession session) {
//		UserVO uvo = userService.login(vo.getUserId());
//
//		// 로그인
//		if ( uvo != null && vo.getUserId().equals(uvo.getUserId()) && 
//				uvo.getPassword().equals(vo.getPassword()) )
//		
//			// 로그인 성공
//			{
//				uvo.setPassword(null);
//				session.setAttribute("loginUser", uvo);
//				// 정보미입력시 입력창 이동
//				if(!StringUtils.hasText(uvo.getNickName())) 				
//					
//					return "redirect:/addUserInfo";			
//				
//				// 정보입력완료시 디바이스메서드 호출
//				else 					
//					return "redirect:/medication/schedule/list";
//			}
//		
//		// 로그인 실패
//		
//		return "redirect:/user/login";
//	}
	
	/** 로그아웃 요청 */
//	@GetMapping("/user/logout")
//	public String logout(HttpSession session) {
//		
//		session.invalidate();
//		
//		return "redirect:/cover";
//	}
	
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
	
	/** 사용자 정보입력 화면요청 <br> 
	 * carer인 경우의 조건판단을 위해 정보등록후 등록폼 이동
	 * */
	@GetMapping("/addUserInfo")
	public String UserInfo() {

		return "user/addUserInfo";
	}
	
	/** 사용자 정보입력 <br>
	 * 정보등록 후
	 * 디바이스 정보등록여부 확인하여 등록을 진행 
	 * 	or 
	 * 메인페이지로 연결
	 * */
	@PostMapping("/addUserInfo")
	public String addUserInfo(UserVO vo, HttpServletRequest request, HttpSession session) {
		
		userService.addUserInfo(vo);
		String userNickname = userService.getUserNickame(vo.getUserId());
		vo.setNickname(userNickname);
		session.setAttribute("loginUser", vo);
		
		
		request.setAttribute("msg", "정보가 등록 되었습니다.");
		request.setAttribute("url", "/medication/schedule/list");
		
		return "common/msg";
	}
	
	/** 나의정보변경 화면 요청 */
	@GetMapping("/myinfo/edit")
	public String infoEdit(@SessionAttribute("loginUser") UserVO vo, Model model) {
		
		String userId = vo.getUserId();
		String userName = userService.getUserNickame(userId);
		
		// 정보 미 등록시 등록화면 이동
		if(!StringUtils.hasText(userName))			
			return "redirect:/addUserInfo";
			
		// 정보 등록되어있는 경우 변경화면 이동
		UserVO uivo = userService.getUserInfo(userId);		
		model.addAttribute("myInfo", uivo);
		
		return "user/userInfo";
	}
	
	/** 나의정보변경 */
	@PostMapping("/myinfo/edit")
	public String infoEdit(UserVO uvo, HttpSession session) {
		
		userService.updateMyInfo(uvo);		  
		session.setAttribute("name", uvo.getNickname());
		
		return "redirect:/medication/schedule/list";
	}
}

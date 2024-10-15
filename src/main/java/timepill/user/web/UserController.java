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
		kakaoService.logout(); //유저 로그아웃
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
		
		userService.add(vo); //유저정보 DB추가
		
		request.getSession().setAttribute("message", "회원가입 되었습니다.");
		
		return "user/Login";			
	}
	
	/** 아이디 사용유무확인 ajax 요청,응답 */
	@ResponseBody
	@PostMapping("/user/check-id")
	public String checkId(String userId) {
		
		String result = userService.checkId(userId); // DB에 존재하는 userId인지 확인
		
		return result;
	}
	
	/** 아이디 찾기 페이지 요청 */
	@GetMapping("/user/find-id")
	public String findId() {
		
		return "user/FindId";
	}
	/** 아이디 찾기 */
	@ResponseBody
	@PostMapping("/user/find-id")
	public String findId(String email) {
		
		String result = userService.findId(email); // email정보가 일치하는 id확인
		
		return result;
	}
	
	/** 이메일 인증 페이지 요청 */
	@GetMapping("/user/auth-email")
	public String authEmail() {
		
		return "user/AuthEmail";
	}
	
	/** 이메일 인증번호 발송 */
	@ResponseBody
	@PostMapping("/user/auth-email")
	public String authEmail(AuthVO vo, HttpServletResponse response, Model model) throws Exception {
		
		String result = authService.authEmail(vo); // 이메일 셋팅 및 전송
		
		return result;
	}
	
	/** 이메일 인증 */
	@PostMapping("/user/auth-atmp")
	public String authAtmp(AuthVO vo, HttpSession session, Model model) {
		
		String result = authService.authAtmp(vo); // 이메일 인증
		
		if(result.equals("Y")) { // 인증 성공
			session.setAttribute("authOK", vo);
			
			return "user/ResetPassword";
		}			
		else { // 인증 실패
			model.addAttribute("message", "인증에 실패했습니다.");
			
			return "user/AuthEmail";
		}
		
		
	}
	
	/** 이메일 인증 확인 */
	@GetMapping("/user/reset-password")
	public String resetPassword(HttpSession session) {
		
		if(session.getAttribute("authOK") == null) { // 인증여부 확인
			session.setAttribute("message", "인증정보가 없습니다.");
			
			return "/user/Auth-email";
		}
				
		return "user/ResetPassword";
	}
	
	/** 패스워드 변경 */
	@PostMapping("/user/reset-password")
	public String resetPassword(UserVO vo, HttpSession session) {
		
		// 인증된 정보와 패스워드로 DB내용 변경
		AuthVO avo = (AuthVO)session.getAttribute("authOK");
		session.removeAttribute("authOK");
		vo.setUserId(avo.getUserId());
		vo.setEmail(avo.getEmail());
		
		userService.resetPassword(vo);
		session.setAttribute("message", "변경되었습니다.");
		
		return "redirect:/user/login";		
	}
	
	/** 마이페이지 요청 */
	@GetMapping("/mypage")
	public String myPage(UserVO vo, HttpSession session) {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();

		if(userId.startsWith("KAKAO_")) {
			session.setAttribute("changeInfoUser", userId);
		}
		
		return "user/MyPage";
	}
	
	/** 내 정보 변경 페이지 요청 */
	@PostMapping("/mypage")
	public String myPage(String password, HttpSession session) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		
		String encodedPassword = userService.getPassword(userId); // 내정보 가져오기
		boolean isMatch = encoder.matches(password, encodedPassword); // 비밀번호 일치여부 확인
		
		if(isMatch) { // 비밀번호 일치
			session.setAttribute("changeInfoUser", userId);
			session.setAttribute("message", "인증되었습니다.");
		}
		else // 비밀번호 불일치
			session.setAttribute("message", "비밀번호가 일치하지 않습니다.");
		return "redirect:/mypage";
	}
	
	/** 비밀번호 변경페이지 요청 */
	@GetMapping("/mypage/change-password")
	public String changePwForm(HttpSession session, UserVO vo) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		vo.setUserId(userId); // 시큐리티에서 유저 아이디 가져와 셋팅
		UserVO uvo = userService.getMyInfo(vo); // 유저 정보 가져오기
		
		if(session.getAttribute("changeInfoUser") == null) {
			session.setAttribute("message", "인증 후 이용가능합니다.");
			return "redirect:/mypage";
		}else if(uvo.getUserId().startsWith("KAKAO_")) {
			session.setAttribute("message", "카카오 유저입니다.");
			return "redirect:/mypage";
		}
		return "user/ChangePassword";
	}
	@PostMapping("/mypage/change-password")
	public String changePw(HttpSession session, UserVO vo) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		vo.setUserId(userInfo);
		
		System.out.println(vo.getPassword());
		int result = userService.changePassword(vo);
		if(result > 0)
			session.setAttribute("message", "비밀번호가 변경되었습니다.");
		else
			session.setAttribute("message", "비밀번호변경을 실패했습니다.");
		return "redirect:/mypage";
	}
	
	/** 내 정보 변경 페이지 요청 */
	@GetMapping("/mypage/change-myinfo")
	public String changeMyInfo(UserVO vo, Model model, HttpSession session) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		
		vo.setUserId(userInfo);
		UserVO uvo = userService.getMyInfo(vo); // 유저 정보 가져오기
		
		model.addAttribute("userVO", uvo); // 기존유저정보 셋팅
		
		return "user/ChangeMyInfo";
	}
	
	/** 내 정보 변경 */
	@PostMapping("/mypage/change-myinfo")
	public String chageMyInfo(UserVO vo, BindingResult result, Model model, HttpSession session) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		// 검증결과 error가 있으면
		if(result.hasErrors())
			return "user/ChangeMyInfo";
		if(userInfo.startsWith("KAKAO_"))
			vo.setEmail("카카오유저");
		
		userService.changeMyInfo(vo); // 유저정보변경
		UserVO user = (UserVO) session.getAttribute("loginUser");
		if (user != null) {
		    user.setNickname(vo.getNickname());
		    session.setAttribute("loginUser", user);
		}
		model.addAttribute("message", "정보가 변경되었습니다.");
		
		return "redirect:/";
	}
}

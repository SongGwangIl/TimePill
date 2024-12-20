package timepill.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.com.ValidGroup.EditInfo;
import timepill.com.ValidGroup.EditPasswrod;
import timepill.com.ValidGroup.Singup;
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
	@GetMapping("/user/termsAgree")
	public String terms() {
		
		return "user/TermsAgree";
	}
	
	/** 회원가입 화면요청 */
	@GetMapping("/user/singup")
	public String addForm(UserVO vo) {
		
		return "user/Signup";
	}
	
	/** 회원가입 */ 
	@PostMapping("/user/singup")
	public String add(@Validated(Singup.class) UserVO vo, BindingResult result, HttpServletRequest request) throws Exception {
		if(result.hasErrors())
			
			return "user/Signup";
		
		String check = userService.checkEmail(vo.getEmail());
		if(check.equals("0")) {
			userService.add(vo); //유저정보 DB추가
			request.getSession().setAttribute("message", "회원가입 되었습니다.");
			
			return "user/Login";			
		}		
		request.getSession().setAttribute("message", "이미등록된 메일이라 가입할 수 없습니다.");
		
		return "user/Signup";
	}
	
	/** 회원탈퇴 */
	@PostMapping("/deleteAccount")
	public String deleteAccount(String delAcctAgree, HttpServletRequest req, HttpServletResponse resp) throws Exception {

		// 입력 문자열 검증
		if (!"회원탈퇴".equals(delAcctAgree)) {
			req.getSession().setAttribute("message", "잘못된 요청입니다.");
			return "redirect:/";
		}

		// 파라미터 세팅
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		UserVO vo = new UserVO();
		vo.setUserId(userId);
		vo.setUserStatus("N");
		int resultCnt = 0;

		// 회원탈퇴
		if (userId.startsWith("KAKAO_")) {
			// 카카오 회원
			vo.setTokenUseAt("N");
			vo.setRefreshToken("");
			vo.setAccessToken("");
			resultCnt = kakaoService.deleteKakaoAccount(vo);
		} else {
			// 일반 회원
			resultCnt = userService.deleteAccount(vo);
		}

		if (resultCnt != 1) {
			req.getSession().setAttribute("message", "회원탈퇴 중 문제가 발생했습니다.");
			return "redirect:/";
		}
		req.getSession().setAttribute("message", "회원탈퇴가 완료되었습니다.");
		
		// 로그아웃 처리
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null)
			new SecurityContextLogoutHandler().logout(req, resp, auth);
		
		return "redirect:/cover";
	}
	
	/** 아이디 사용유무확인 ajax 요청,응답 */
	@ResponseBody
	@PostMapping("/user/check-id")
	public String checkId(String userId) {
		
		String result = userService.checkId(userId); // DB에 존재하는 userId인지 확인
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/user/check-email")
	public String checkEmail(String email) {
		
		String result = userService.checkEmail(email);
		
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
	@GetMapping("/user/auth-email")
	public String authEmail() {
		
		return "user/AuthEmail";
	}
	
	/** 이메일 인증 페이지 요청 */
	@PostMapping("/user/auth-email")
	public String authEmail(UserVO vo, Model model) {
		vo.setAccessToken(null);
		model.addAttribute("auth", vo);
		
		return "user/AuthEmail";
	}
	
	/** 이메일 인증번호 발송 */
	@ResponseBody
	@PostMapping("/user/auth-email/send")
	public String authEmail(AuthVO vo, HttpServletResponse response, Model model) throws Exception {
		
		String result = authService.authEmail(vo); // 이메일 셋팅 및 전송
		
		return result;
	}
	
	/** 이메일 인증 */
	@PostMapping("/user/auth-atmp")
	public String authAtmp(AuthVO vo, HttpSession session) {
		
		String result = authService.authAtmp(vo); // 이메일 인증
		
		if(result.equals("Y")) { // 인증 성공
			session.setAttribute("authOK", vo);
			
			return "user/Password";
		}			
		else { // 인증 실패
			session.setAttribute("message", "인증에 실패했습니다.");
			
			return "user/AuthEmail";
		}
		
		
	}
	
	/** 이메일 인증 확인 */
	@GetMapping("/user/password")
	public String resetPassword(HttpSession session) {
		
		if(session.getAttribute("authOK") == null) { // 인증여부 확인
			session.setAttribute("message", "인증정보가 없습니다.");
			
			return "/user/Auth-email";
		}
				
		return "user/Password";
	}
	
	/** 패스워드 변경 */
	@PostMapping("/user/password")
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
		
		return "myPage/MyPage";
	}
	
	/** 내 정보 변경 페이지 요청 */
	@PostMapping("/mypage")
	public String myPage(String password, HttpSession session) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		
		String encodedPassword = userService.getPassword(userId); // 내정보 가져오기
		boolean isMatch = encoder.matches(password, encodedPassword); // 비밀번호 일치여부 확인
		
		if(isMatch) { // 비밀번호 일치
			session.setAttribute("changeInfoUser", userId);
		}
		else // 비밀번호 불일치
			session.setAttribute("message", "비밀번호가 일치하지 않습니다.");
		return "redirect:/mypage";
	}
	
	/** 비밀번호 변경페이지 요청 */
	@GetMapping("/mypage/myPassword")
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
		return "myPage/MyPassword";
	}
	@PostMapping("/mypage/myPassword")
	public String changePw(HttpSession session,@Validated(EditPasswrod.class) UserVO vo, BindingResult valResult, Model model) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		vo.setUserId(userInfo);
		
		if(valResult.hasErrors())
			return "myPage/MyPassword";
		
		
		System.out.println(vo.getPassword());
		int result = userService.changePassword(vo);
		if(result > 0)
			session.setAttribute("message", "비밀번호가 변경되었습니다.");
		else
			session.setAttribute("message", "비밀번호변경을 실패했습니다.");
		return "redirect:/mypage";
	}
	
	/** 내 정보 변경 페이지 요청 */
	@GetMapping("/mypage/myinfo")
	public String changeMyInfo(UserVO vo, Model model, HttpSession session) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		
		vo.setUserId(userInfo);
		UserVO uvo = userService.getMyInfo(vo); // 유저 정보 가져오기
		
		model.addAttribute("userVO", uvo); // 기존유저정보 셋팅
		
		return "myPage/MyInfo";
	}
	
	/** 내 정보 변경 */
	@PostMapping("/mypage/myinfo")
	public String chageMyInfo(@Validated(EditInfo.class) UserVO vo, BindingResult result, Model model, HttpSession session) {
		String userInfo = (String) session.getAttribute("changeInfoUser");
		if(userInfo == null) {
			session.setAttribute("message", "잘못된 접근입니다.");
			return "redirect:/mypage";
		}
		
		// 검증결과 error가 있으면
		if(result.hasErrors())
			return "myPage/MyInfo";
		if(userInfo.startsWith("KAKAO_"))
			vo.setEmail("카카오유저");
		String check = userService.checkEmailId(vo);
		if(check.equals("0")) {
			userService.changeMyInfo(vo); // 유저정보변경
			session.setAttribute("message", "정보가 변경되었습니다.");			
		}else {
			session.setAttribute("message", "이미 등록된 이메일입니다.");
			
			return "redirect:/mypage/myinfo";
		}
		UserVO user = (UserVO) session.getAttribute("loginUser");
		if (user != null) {
		    user.setNickname(vo.getNickname());
		    session.setAttribute("loginUser", user);
		}
		
		return "redirect:/mypage";
	}
}

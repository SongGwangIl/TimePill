package timepill.user.web;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import timepill.com.RandomCharacterGenerator;
import timepill.kakao.service.KakaoService;
import timepill.user.service.MailService;
import timepill.user.service.UserService;
import timepill.user.service.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailService mailService;
	
	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;
	
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
	
	/** 로그아웃(시큐리티 처리) */
	@PostMapping("/user/logout")
	public String logout() throws Exception {
		kakaoService.logout();
		return "redirect:/schedule/list";
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
		
		request.getSession().setAttribute("message", "회원가입 되었습니다.");
		
		return "/user/login";			
	}
	
	/** 아이디 사용유무확인 ajax 요청,응답 */
	@ResponseBody
	@PostMapping("/user/checkId")
	public String checkId(String userId) {
		
		String result = userService.checkId(userId);
		
		return result;
	}
	
	@GetMapping("/user/findId")
	public String findId() {
		
		return "user/findId";
	}
	
	@ResponseBody
	@PostMapping("/user/findId")
	public String findId(String email) {
		
		String result = userService.findId(email);
		
		return result;
	}
	
	@GetMapping("/user/authEmail")
	public String authEmail() {
		
		return "user/authEmail";
	}
	
	
	@PostMapping("/user/authEmail")
	public void authEmail(UserVO vo, HttpServletResponse response, RandomCharacterGenerator random, Model model) throws Exception {
		
		String message = "이메일로 인증번호를 전송하였습니다.";
		
		JSONObject jo = new JSONObject();
		response.setContentType("application/json; charset=utf-8");
		
		if(vo.getUserId().isEmpty() || vo.getEmail().isEmpty()) {
			message = "아이디와 이메일을 모두 입력해주세요";
		}else{
			//임시 비밀번호를 생성(영+영+숫+영+영+숫=6자리)
			String authNumber = "";
			for(int i=1; i<=6; i++) {
				//영자
				if(i % 3 != 0)
					authNumber += random.getRandomCharacter();
				//숫자
				else
					authNumber += random.getRandomNumber();
			}
			userService.setAuthNumber(vo);
		
			//메일전송
			String title = "비밀번호변경";
			String content = "인증번호는 (" + authNumber + ") 입니다.";
			//javax.mail.Session
			Session session = mailService.mailSetting(new Properties());
			mailService.sendMail(session, title, content, vo.getEmail());
		}
		jo.put("message", message);
		
		PrintWriter printwriter = response.getWriter();
		printwriter.println(jo.toString());
		printwriter.flush();
		printwriter.close();
	}
	
	@PostMapping("/user/resetPassword")
	public String resetPassword() {
		
		return "";
	}
}

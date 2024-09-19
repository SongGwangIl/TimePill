package timepill.kakao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import timepill.kakao.service.KakaoService;

@Controller
public class KakaoController {

	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;
	
	
	/** 카카오 로그인(회원가입) 요청 */
	@GetMapping("/user/kakao-login")
	public String goKakaoOAuth() throws Exception {
		return "redirect:" + kakaoService.goKakaoOAuth();
	}

	/** 카카오 로그인 콜백 */
	@GetMapping("/user/login-callback")
	public String loginCallback(@RequestParam("code") String code) throws Exception {
		kakaoService.loginCallback(code);
		String resultLogin = kakaoService.login();
		if ("Login".equals(resultLogin) || "Join".equals(resultLogin)) {
			return "redirect:/medication/schedule/list";
		}
		return "redirect:/user/login"; 
	}

	/** 카카오 유저정보 요청 */
	@GetMapping("/user/profile")
	public String getProfile() throws Exception {
		return kakaoService.getProfile();
	}
	
	/** 로그아웃 */
	@GetMapping("/user/kakao-logout")
	public String logout() throws Exception {
		kakaoService.logout();
		return "redirect:/medication/schedule/list";
	}
	
	/** 나에게 메세지 보내기 */
	@RequestMapping("/user/message")
	public String message() throws Exception {
		boolean checkMessageAuth = kakaoService.checkMessageAuth();
		if (!checkMessageAuth) {
			// 권한 동의 페이지로 리다이렉트
//			kakaoService.goKakaoOAuth("talk_message", "http://localhost:8090/user/message");
			System.out.println("권한 동의 확인");
			return "redirect:" + kakaoService.goKakaoOAuth("talk_message", "http://localhost:8090/user/message-callback");
		}
		String messageResult = kakaoService.message();
		System.out.println("messageResult : " + messageResult);
		return "redirect:/medication/schedule/list";
	}
	
	@RequestMapping("/user/message-callback")
	public String messageCallback(@RequestParam("code") String code) throws Exception {
		kakaoService.loginCallback(code);
		return "redirect:/medication/schedule/list";
	}


	@RequestMapping("/user/authorize")
	public String goKakaoOAuth(@RequestParam("scope") String scope) throws Exception {
		return "redirect:" + kakaoService.goKakaoOAuth(scope, "");
	}

	@RequestMapping("/user/friends")
	public String getFriends() throws Exception {
		return kakaoService.getFriends();
	}
	

	@RequestMapping("/user/friends-message")
	public String friends_message(@RequestParam("uuids") String uuids) throws Exception {
		return kakaoService.friendMessage(uuids);
	}

	
}

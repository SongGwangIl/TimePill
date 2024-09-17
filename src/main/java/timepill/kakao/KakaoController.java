package timepill.kakao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import timepill.kakao.service.KakaoService;

@Controller
public class KakaoController {

	@Autowired
	KakaoService kakaoService;

	/** 카카오 로그인(회원가입) 요청 */
	@RequestMapping("/user/kakao-login")
	public RedirectView goKakaoOAuth() throws Exception {
		return kakaoService.goKakaoOAuth();
	}

	/** 카카오 로그인 콜백 */
	@RequestMapping("/user/login-callback")
	public String loginCallback(@RequestParam("code") String code) throws Exception {
		String loginCallback = kakaoService.loginCallback(code);
		if ("Login".equals(loginCallback) || "Join".equals(loginCallback)) {
			return "redirect:/medication/schedule/list";
		}
		return "redirect:/user/login"; 
	}

	/** 카카오 유저정보 요청 */
	@RequestMapping("/user/profile")
	public String getProfile() throws Exception {
		return kakaoService.getProfile();
	}
	
	/** 로그아웃 */
	@RequestMapping("/user/kakao-logout")
	public String logout() throws Exception {
		kakaoService.logout();
		return "redirect:/medication/schedule/list";
	}


	@RequestMapping("/user/authorize")
	public RedirectView goKakaoOAuth(@RequestParam("scope") String scope) throws Exception {
		return kakaoService.goKakaoOAuth(scope);
	}

	@RequestMapping("/user/friends")
	public String getFriends() throws Exception {
		return kakaoService.getFriends();
	}

	@RequestMapping("/user/message")
	public String message() throws Exception {
		return kakaoService.message();
	}

	@RequestMapping("/user/friends-message")
	public String friends_message(@RequestParam("uuids") String uuids) throws Exception {
		return kakaoService.friendMessage(uuids);
	}

	
}

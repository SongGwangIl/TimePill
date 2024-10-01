package timepill.kakao.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import timepill.kakao.service.KakaoService;

@Controller
public class KakaoController {

	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;
	
	
	/** 카카오 로그인or회원가입 요청 */
	@GetMapping("/kakao/login")
	public String goKakaoOAuth() throws Exception {
		String resultUri = kakaoService.goKakaoOAuth("", "login-callback");
		return "redirect:" + resultUri;
	}

	/** 카카오 로그인 콜백 */
	@GetMapping("/kakao/login-callback")
	public String loginCallback(@RequestParam("code") String code) throws Exception {
		
		kakaoService.callback(code, "login-callback");
		
		String resultLogin = kakaoService.userAuthHandler();
		if (!"green".equals(resultLogin)) {
			return "redirect:/user/login"; 
		}
		return "redirect:/";
	}
	
	
	/** 나에게 메세지 보내기 */
	@RequestMapping("/kakao/message")
	public String message() throws Exception {
		boolean checkMessageAuth = kakaoService.checkMessageAuth(); 
		// 메세지 권한 동의 여부 체크
		if (!checkMessageAuth) {
			System.out.println("권한 미동의");
			return "redirect:" + kakaoService.goKakaoOAuth("talk_message", "message-callback");
		}
		System.out.println("권한 동의");
		String messageResult = kakaoService.message();
		System.out.println("messageResult : " + messageResult);
		return "redirect:/schedule/list";
	}
	
	/** 나에게 메세지 보내기 권한 동의 콜백 */
	@RequestMapping("/kakao/message-callback")
	public String messageCallback(@RequestParam("code") String code) throws Exception {
		kakaoService.callback(code, "message-callback");
		return "redirect:/kakao/message";
	}

}

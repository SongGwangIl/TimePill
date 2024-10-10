package timepill.kakao.web;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import timepill.kakao.service.KakaoService;
import timepill.user.service.UserVO;

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
	@GetMapping("/kakao/login/callback")
	public String loginCallback(@RequestParam("code") String code) throws Exception {
		
		kakaoService.callback(code, "login-callback");
		
		String resultLogin = kakaoService.userAuthHandler();
		if (!"green".equals(resultLogin)) {
			return "redirect:/user/login"; 
		}
		return "redirect:/";
	}
	
	
	/** 카카오 알림 메세지 보내기 허용 설정 */
	@ResponseBody
	@PostMapping("/kakao/message")
	public String message(UserVO vo, HttpServletResponse resp) throws Exception {
		
		// 카카오 유저 체크
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		if (!userId.startsWith("KAKAO_")) {
			return null;
		}
		
		vo.setUserId(userId);
		UserVO resultUserInfo = kakaoService.selectUserInfo(vo);
		
		// 초기값
		if (!StringUtils.hasText(vo.getTokenUseAt())) {
			return "Y".equals(resultUserInfo.getTokenUseAt()) ? "Y" : "N";
		}
		
		// 알람 비활성화
		if ("N".equals(vo.getTokenUseAt())) {
			boolean result = kakaoService.revokeMessageAuth();
			// 메세지 권한에 관한 정보를 찾을 수 없는 경우
			if (!result) {
				return null;
			} 
			return "N";
		}
		
		
		// 알람 활성화
		boolean checkMessageAuth = kakaoService.checkMessageAuth(); // 메세지 권한 동의 여부 체크
		// 미동의 상태인 경우
		if (!checkMessageAuth) {
			// 카카오 권한 동의 페이지 url 반환
			return kakaoService.goKakaoOAuth("talk_message", "message-callback");
		}
		
		return "Y";
	
	}
	
	/** 권한 동의 후 메세지 보내기 */
	@GetMapping("/kakao/message")
	public String sendMessage(UserVO vo, HttpSession session) throws Exception {
		boolean checkMessageAuth = kakaoService.checkMessageAuth(); // 메세지 권한 동의 여부 체크
		if (checkMessageAuth) {
			// 메세지 보내기 실행
			String messageResult = kakaoService.message("");
			System.out.println("messageResult : " + messageResult);
		} else {
			session.setAttribute("message", "잘못된 접근입니다.");
		}
		return "redirect:/";
	}
	
	
	
	/** 나에게 메세지 보내기 권한 동의 콜백 */
	@GetMapping("/kakao/message/callback")
	public String messageCallback(@RequestParam("code") String code) throws Exception {
		kakaoService.callback(code, "message-callback");
		// 동의 후 메세지 보내기 다시 실행
		return "redirect:/kakao/message";
	}

}

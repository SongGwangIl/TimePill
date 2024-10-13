package timepill.kakao.web;

import java.util.List;

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
	
	/** 나에게 메세지 보내기 권한 동의 콜백 */
	@GetMapping("/kakao/message/callback")
	public String messageCallback(@RequestParam("code") String code) throws Exception {
		kakaoService.callback(code, "message-callback");
		kakaoService.checkMessageAuth();
		return "redirect:/";
	}
	
	/** 테스트용 메세지 보내기 */
	@ResponseBody
	@GetMapping("/kakao/message-test")
	public void sendMessage(UserVO vo, HttpSession session) throws Exception {
//		boolean checkMessageAuth = kakaoService.checkMessageAuth(); // 메세지 권한 동의 여부 체크
//		if (checkMessageAuth) {
//			// 메세지 보내기 실행
//			String messageResult = kakaoService.message("");
//			System.out.println("messageResult : " + messageResult);
//		} 
		System.out.println("테스트 메세지 보내기 실행");
		
		// 메세지 알람 사용자 리프레시 토큰 가져오기
		List<UserVO> tokenList = kakaoService.selectKakaoRefreshTokenList();
		for (UserVO token : tokenList) {
			
			String accessToken = token.getAccessToken();
			String message = kakaoService.message(accessToken);
			
			if ("401".equals(message)) {
				String refreshToken = token.getRefreshToken();
				
				// 액세스토큰 재발급
				String newAccessToken = kakaoService.getNewAccessToken(refreshToken);
				
				// 새로운 액세스 토큰으로 메세지 보내기
				kakaoService.message(newAccessToken);
				
			}
			
			System.out.println("메세지 보내기 완료 : " + message);
		}
	}
	

}

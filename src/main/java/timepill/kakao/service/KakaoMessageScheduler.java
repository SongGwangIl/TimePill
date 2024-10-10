package timepill.kakao.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import timepill.user.service.UserVO;

@Configuration
@EnableScheduling
public class KakaoMessageScheduler {
	
	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;

	// 카카오 메세지 알람 스케줄
	@Scheduled(cron = "0 * * * * ?") // 매 분 00초에 실행
	public void kakaoMessage() throws Exception {
		
		// 메세지 알람 사용자 리프레시 토큰 가져오기
		List<UserVO> tokenList = kakaoService.selectKakaoScheList();
		for (UserVO token : tokenList) {
			String refreshToken = token.getRefreshToken();
			
			// 액세스토큰 재발급
			String newAccessToken = kakaoService.getNewAccessToken(refreshToken);
			
			// 새로운 액세스 토큰으로 메세지 보내기
			kakaoService.message(newAccessToken);
		}
	}
}

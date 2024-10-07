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
	@Scheduled(fixedRate = 60000) // 5분, 300.000 간격으로 실행 
	public void kakaoMessage() throws Exception {
		// 메세지 알람 사용자 리프레시 토큰 가져오기
		List<UserVO> tokenList = kakaoService.selectKakaoScheList();
		for (UserVO token : tokenList) {
			String refreshToken = token.getRefreshToken();
			
			String newAccessToken = kakaoService.getNewAccessToken(refreshToken);
			
			kakaoService.message(newAccessToken);
		}
	}
}

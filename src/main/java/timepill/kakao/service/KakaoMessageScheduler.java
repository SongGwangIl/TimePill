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
	@Scheduled(fixedRate = 300000) // 5분, 300.000 간격으로 실행 
	public void kakaoMessage() throws Exception {
		List<UserVO> tokenList = kakaoService.selectKakaoScheList();
		for (UserVO token : tokenList) {
			String kakaoToken = token.getKakaoToken();
			kakaoService.message(kakaoToken);
		}
	}
}

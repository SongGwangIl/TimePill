package timepill.kakao.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableScheduling
public class KakaoMessageScheduler {
	
	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;

	// 카카오 메세지 알람 스케줄
	@Scheduled(fixedRate = 300000) // 1시간 3600.000 간격으로 실행 
	public void kakaoMessage() throws Exception {
		kakaoService.selectKakaoScheList();
	}
}

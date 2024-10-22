package timepill.com.push;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.util.StringUtils;

import nl.martijndwars.webpush.Subscription;
import timepill.kakao.service.KakaoService;
import timepill.notification.service.NotificationService;
import timepill.notification.service.NotificationVO;
import timepill.user.service.UserVO;

@Configuration
@EnableScheduling
public class MessageScheduler {

	/** kakaoService DI */
	@Autowired
	KakaoService kakaoService;

	/** notificationService DI */
	@Autowired
	private NotificationService notificationService;

	/** 카카오 메세지 알람 스케줄 */
	@Scheduled(cron = "0 * * * * ?") // 매 분 00초에 실행
	public void kakaoMessage() throws Exception {

		// 메세지 알람 사용자 토큰 가져오기
		List<UserVO> tokenList = kakaoService.getKakaoTokenList();
		for (UserVO token : tokenList) {
			String message = null;

			System.out.println("토큰 겟");

			// 토큰이 비어있지 않은 경우
			if (StringUtils.hasText(token.getAccessToken())) {
				System.out.println("토큰이 존재함 : " + token.getAccessToken());
				// 메세지 보내기 실행
				message = kakaoService.message(token.getAccessToken());
			}

			// 토큰이 비어있거나 만료된 경우
			if (!StringUtils.hasText(token.getAccessToken()) || "401".equals(message)) {
				String refreshToken = token.getRefreshToken();

				// 액세스토큰 재발급
				String newAccessToken = kakaoService.getNewAccessToken(refreshToken);

				// 새로운 액세스 토큰으로 메세지 보내기
				kakaoService.message(newAccessToken);
			}

		}
	}

	/** 푸시알림 스케줄 */
	@Scheduled(cron = "55 * * * * ?") // 매 분 55초에 실행
	public void sendPush() throws Exception {
		// 푸시 구독정보 리스트 가져오기
		List<NotificationVO> subscriptions = notificationService.getSubcription();
		for (NotificationVO vo : subscriptions) {
			Subscription sub = new Subscription(vo.getEndpoint(), new Subscription.Keys(vo.getP256dh(), vo.getAuth()));
			// 푸시 메시지 처리
			notificationService.processSendMessage(sub, vo);
		}
	}
}

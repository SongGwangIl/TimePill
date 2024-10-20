package timepill.notification.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import nl.martijndwars.webpush.Subscription;
import timepill.notification.service.impl.NotificationDAO;

@Configuration
@EnableScheduling
public class NotificationScheduler {

	
	/** notificationService DI */
	@Autowired
	private NotificationService notificationService;
	
	/** notificationDAO DI */
	@Autowired
	NotificationDAO notificationDAO;
	
	final String message = "{"
	        + "\"title\": \"복약 알림\","
	        + "\"body\": \"약먹을 시간이에요.\","
	        + "\"icon\": \"/resources/img/logo.svg\","
	        + "\"url\": \"/\""
	        + "}";

	// 푸시알림 스케줄
	@Scheduled(cron = "55 * * * * ?") // 매 분 00초에 실행
	public void sendPush() throws Exception {
		List<NotificationVO> subscriptions = notificationDAO.selectListSub();
		for (NotificationVO vo : subscriptions) {
			Subscription sub = new Subscription(vo.getEndpoint(), new Subscription.Keys(vo.getP256dh(), vo.getAuth()));
			// 각 구독자에게 푸시 메시지 전송
			int sendPushMessage = notificationService.sendPushMessage(sub, message);
			if (sendPushMessage == 410) {
				notificationDAO.deleteSub(vo);
			}
		}
	}
}

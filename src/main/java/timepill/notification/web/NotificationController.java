package timepill.notification.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import nl.martijndwars.webpush.Subscription;
import timepill.notification.service.NotificationVO;
import timepill.notification.service.impl.NotificationServiceImpl;

@RestController
public class NotificationController {
	
	@Autowired
	private NotificationServiceImpl notificationService;

	/** 푸시 구독 */
	@PostMapping("/subscribe")
	public Integer subscribe(@RequestBody Subscription subscription) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		NotificationVO vo = new NotificationVO();
		vo.setUserId(userId);
		vo.setEndpoint(subscription.endpoint);
		vo.setP256dh(subscription.keys.p256dh);
		vo.setAuth(subscription.keys.auth);
		
		// db에 구독정보 저장
		int saveSubscription = notificationService.saveSubscription(vo);
		return saveSubscription;
	}

	/** 푸시알람 테스트 */
	@GetMapping("/test")
	public ResponseEntity<Void> test() throws Exception {
		String jsonString = "{"
		        + "\"title\": \"복약 알림\","
		        + "\"body\": \"약먹을 시간이에요.\","
		        + "\"icon\": \"/resources/img/logo.svg\","
		        + "\"url\": \"/\""
		        + "}";
		notificationService.sendNotificationToAllSubscribers(jsonString);
		return ResponseEntity.ok().build();
	}
}

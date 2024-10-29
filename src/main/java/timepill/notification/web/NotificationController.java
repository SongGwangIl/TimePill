package timepill.notification.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import nl.martijndwars.webpush.Subscription;
import timepill.notification.service.NotificationService;
import timepill.notification.service.NotificationVO;

@RestController
public class NotificationController {
	
	/** notificationService DI */
	@Autowired
	private NotificationService notificationService;
	
	/** 푸시 구독 확인 */
	@PostMapping("/check-subscribe")
	public NotificationVO checkSubscribe(@RequestBody Subscription subscription) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		NotificationVO vo = new NotificationVO();
		vo.setUserId(userId);
		vo.setEndpoint(subscription.endpoint);
		
		// db에 구독정보 가져오기
		NotificationVO checkSubscription = notificationService.checkSubscription(vo);
		if (checkSubscription != null) {
			return checkSubscription;
		}
		return null;
	}

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
	
	/** 푸시 구독취소 */
	@PostMapping("/unsubscribe")
	public Integer unsubscribe(@RequestBody Subscription subscription) throws Exception {
		
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		NotificationVO vo = new NotificationVO();
		vo.setUserId(userId);
		vo.setEndpoint(subscription.endpoint);
		
		// db에 구독정보 저장
		int delSubscription = notificationService.saveSubscription(vo);
		return delSubscription;
	}
}

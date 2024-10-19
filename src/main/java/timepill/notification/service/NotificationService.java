package timepill.notification.service;

import nl.martijndwars.webpush.Subscription;

public interface NotificationService {

	/** 푸시구독정보 저장 */
	public int saveSubscription(NotificationVO vo) throws Exception;
	
	/** 푸시알림 전송 */
	public void sendPushMessage(Subscription subscription, String payload) throws Exception;
}

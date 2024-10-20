package timepill.notification.service;

import nl.martijndwars.webpush.Subscription;

public interface NotificationService {

	/** 푸시구독정보 저장 */
	public int saveSubscription(NotificationVO vo) throws Exception;
	
	/** 푸시 구독정보 삭제 */
	public int delSubscription(NotificationVO vo) throws Exception;

	/** 푸시알림 전송 */
	public int sendPushMessage(Subscription subscription, String payload) throws Exception;

	// 구독자들에게 푸시 알림을 보냄(임시)
	public void sendNotificationToAllSubscribers(String message) throws Exception;
}

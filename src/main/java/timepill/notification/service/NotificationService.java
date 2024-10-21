package timepill.notification.service;

import java.util.List;

import nl.martijndwars.webpush.Subscription;

public interface NotificationService {

	/** 푸시구독정보 저장 */
	public int saveSubscription(NotificationVO vo) throws Exception;
	
	/** 푸시 구독정보 삭제 */
	public int delSubscription(NotificationVO vo) throws Exception;

	/** 푸시알림 전송 */
	public int sendPushMessage(Subscription subscription, String payload) throws Exception;
	
	/** 푸시알림 처리 */
	public void processSendMessage(Subscription sub, NotificationVO vo) throws Exception;

	/** 푸시 구독정보 가져오기*/
	public List<NotificationVO> getSubcription() throws Exception;
}

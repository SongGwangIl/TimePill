package timepill.notification.service.impl;

import java.security.Security;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.http.HttpResponse;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import nl.martijndwars.webpush.Notification;
import nl.martijndwars.webpush.PushService;
import nl.martijndwars.webpush.Subscription;
import timepill.notification.service.NotificationService;
import timepill.notification.service.NotificationVO;

@Slf4j
@Service
public class NotificationServiceImpl implements NotificationService {

	/** BouncyCastleProvider 초기화 */
	@PostConstruct
    public void initializeProvider() {
        if (Security.getProvider(BouncyCastleProvider.PROVIDER_NAME) == null) {
            Security.addProvider(new BouncyCastleProvider());
        }
    }
	
	@Value("${public-key}")
	private String PUBLIC_KEY;
	
	@Value("${private-key}")
	private String PRIVATE_KEY;

	/** notificationDAO DI */
	@Autowired
	NotificationDAO notificationDAO;

	/** 푸시구독정보 저장 */
	@Override
	public int saveSubscription(NotificationVO vo) throws Exception {
		int insertSub = notificationDAO.insertSub(vo);
		return insertSub;
	}

	/** 푸시알림 전송 */
	@Override
	public void sendPushMessage(Subscription subscription, String payload) throws Exception {

		// 푸시 서비스에 키 설정
		PushService pushService = new PushService();
		pushService.setPublicKey(PUBLIC_KEY);
		pushService.setPrivateKey(PRIVATE_KEY);

		// 알림 생성
		Notification notification = new Notification(subscription, payload);
		log.debug("엔드포인트 : {}", subscription.endpoint);
		log.debug("p256dh     : {}", subscription.keys.p256dh);
		log.debug("auth       : {}", subscription.keys.auth);
		log.debug("메세지     : {}", payload);

		// 알림 전송
		HttpResponse send = pushService.send(notification);
		System.out.println("요청 응답 : " + send);
	}

	// 구독자들에게 푸시 알림을 보냄
	public void sendNotificationToAllSubscribers(String message) throws Exception {
		List<NotificationVO> subscriptions = notificationDAO.selectListSub();
		for (NotificationVO vo : subscriptions) {
			Subscription sub = new Subscription(vo.getEndpoint(), new Subscription.Keys(vo.getP256dh(), vo.getAuth()));
			System.out.println(sub.toString());
			// 각 구독자에게 푸시 메시지 전송
			sendPushMessage(sub, message);
		}
	}
}

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
import timepill.com.push.PushMessageTemplate;
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
	
	
	/** 푸시구독정보 확인 */
	@Override
	public NotificationVO checkSubscription(NotificationVO vo) throws Exception{
		return notificationDAO.selectSub(vo);
	}

	/** 푸시 구독정보 저장 */
	@Override
	public int saveSubscription(NotificationVO vo) throws Exception {
		// 복약 아이디 생성 로직
		String lastSubId = notificationDAO.selectLastSubId(); // 마지막 복약아이디 조회
		int nextIdNum = 1;
		if (lastSubId != null && lastSubId.startsWith("PUSH_")) {
			nextIdNum = Integer.parseInt(lastSubId.substring("PUSH_".length())) + 1;
		}
		String nextId = String.format("PUSH_%010d", nextIdNum);
		vo.setPushId(nextId); // 생성 아이디

		int insertSub = notificationDAO.insertSub(vo);
		return insertSub;
	}
	
	/** 푸시 구독정보 삭제 */
	@Override
	public int delSubscription(NotificationVO vo) throws Exception {
		int delSub = notificationDAO.deleteSub(vo);
		return delSub;
	}

	/** 푸시알림 전송 */
	@Override
	public int sendPushMessage(Subscription subscription, String payload) throws Exception {

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
		return send.getStatusLine().getStatusCode();
	}
	
	/** 푸시알림 처리 */
	@Override
	public void processSendMessage(Subscription sub, NotificationVO vo) throws Exception {
		int sendPushMessage = sendPushMessage(sub, PushMessageTemplate.getWebPushMessage());
		if (sendPushMessage == 410 || sendPushMessage == 401) {
			notificationDAO.deleteSub(vo);
		}
	}

	/** 푸시 구독정보 가져오기*/
	@Override
	public List<NotificationVO> getSubcription() throws Exception {
		return notificationDAO.selectListSub();
	}
}

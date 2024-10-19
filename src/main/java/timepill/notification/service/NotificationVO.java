package timepill.notification.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationVO {
	private String pushId; 		// 푸시 아이디
	private String userId;		// 유저 아이디
	private String endpoint; 	// 푸시 엔드포인트
	private String p256dh; 		// 클라이언트 키
	private String auth;		// 인증 키
}

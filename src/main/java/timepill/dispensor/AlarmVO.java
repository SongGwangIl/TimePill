package timepill.dispensor;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class AlarmVO {
	
	// alarm 테이블
	private String alarmId; // 알람번호
	
	private String alarmDate; // 알람시간
	private String alarmCheck; // 확인여부
	private String userId; // 회원아이디
	private String takeId; // 복약번호

}

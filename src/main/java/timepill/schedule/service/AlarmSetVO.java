package timepill.schedule.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AlarmSetVO {
	private String alarmId; 		// 알람 PK
	private Integer alarmType;		// 알람타입 1~7 [시간타입, 아침식전, 아침식후, 점심식전, 점심식후, 저녁식전, 저넉식후, 자기전]
	private String alarmTime; 		// 알람 시작 시간
	private Integer alarmInterval; 	// 알람 유효 시간 ex) 1시간
	private Integer rptCount; 		// 재알람 횟수
	private Integer rptInterval; 	// 재알람 간격
}

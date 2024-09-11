package timepill.schedule.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleVO {
	
	
	private String alarmId; 		// 알람 PK
	private Integer alarmType;		// 알람타입 1~7 [시간타입 : 아침식전, 아침식후, 점심식전, 점심식후, 저녁식전, 저녁식후, 자기전]
	private String alarmTime; 		// 알람 시작 시간
	private Integer alarmInterval; 	// 알람 유효 시간 ex) 1시간
	private Integer rptInterval; 	// 재알람 간격
	private String alarmUseAt;		// 알람 사용여부
	
	
	private String prescMedId; 		// 처방약 PK
	private String userId; 			// 유저아이디
	private String prescMedName;	// 처방약이름
	private Date startDate;			// 복약 시작 일자
	private Date endDate;			// 복약 만료 일자
	private String duration;		// 처방 기간
	private String frequency;		// 하루 복약 횟수
	private String medStatus;		// 처방약 정보 상태
	
	// 시작일자 타입 변환
	public void setStartDate(String startDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.startDate = formatter.parse(startDate);
	}
	
	// 만료일자 타입 변환
	public void setEndDate(String endDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.endDate = formatter.parse(endDate);
	}
	
}

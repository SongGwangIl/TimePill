package timepill.dispensor;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class AlarmInfoVO {
	
	// schedule 테이블
	private String scheId; // 복약 정보번호
	private String userId; // 회원 아이디
	
	private String scheStartDate; // 시작일자
	private String scheEndDate; // 만료일자
	private int scheSelect; // 처방기간 or 지급기간 
	
	// scheTime 테이블
	private String timeId; // 복약 시간번호
	
	private String timeAlarm; // 알람시간
	private String timeLimit; // 시간제한
	private int reAlarmCount; // 재알람 횟수
	private int reAlarmTime; // 재알람 간격
	private int medLocation; // 디스펜서 칸 위치
	
	// 생성된 정보
	private long startTime; // 최초알람까지 남은시간
	private int totalCount; // 알람이 종료일까지 반복설정되는 횟수
}

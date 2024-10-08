package timepill.schedule.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleVO {
	
	private String medId; 		// 복용약 PK
	private String userId; 		// 유저아이디
	private String medName;		// 약이름
	private Date startDate;		// 복약 시작 일자
	private Date endDate;		// 복약 만료 일자
	private String medStatus;	// 복약정보 사용여부
	
	private String alarmId; 	// 알람 PK
	private Integer alarmType;	// 알람타입 1~4
	private String alarmTime; 	// 알람 시작 시간
	private String alarmUseAt;	// 알람 사용여부
	
	private List<String> alarmTypes;	// 복용약 알람 리스트
	
	private String logId;		// 스케줄 로그 PK
	private Date scheDate;		// 스케줄 일자
	private String scheChk; 	// 복용여부(스케줄) 체크
	private String logStatus;	// 스케줄 로그 사용여부
	
	private Integer totalDayTodo; // 하루 총 스케줄
	private Integer completedDayTodo; // 하루 완료된 스케줄
	

	private Date selectedDay;		// 캘린더 선택 일자
	private Date mthStartDate;		// 한달 시작 일자
	private Date mthEndDate;		// 한달 끝 일자
	
	
	/** 시작일자 타입 변환 */
	public void setStartDate(String startDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.startDate = formatter.parse(startDate);
	}
	
	/** 만료일자 타입 변환 */
	public void setEndDate(String endDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.endDate = formatter.parse(endDate);
	}
	
	/** 스케줄 일자 타입 변환 */
	public void setScheDate(String scheDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.scheDate = formatter.parse(scheDate);
	}
	
	/** 스케줄 일자 타입 변환 */
	public void setSelectedDay(String selectedDay) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.selectedDay = formatter.parse(selectedDay);
	}
	
	/** 한달 시작일자 타입 변환 */
	public void setMthStartDate(String mthStartDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.mthStartDate = formatter.parse(mthStartDate);
	}
	
	/** 한달 끝 일자 타입 변환 */
	public void setMthEndDate(String mthEndDate) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.mthEndDate = formatter.parse(mthEndDate);
	}
	
}

package timepill.schedule.service;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MedInfoVO {
	private String prescMedId; 	// 처방약 PK
	private String userId; 		// 유저아이디
	private String prescMedName;// 처방약이름
	private Date startDate;		// 복약 시작 일자
	private Date endDate;		// 복약 만료 일자
	private String duration;	// 처방 기간
	private String frequency;	// 하루 복약 횟수
	private String medStatus;	// 처방약 정보 상태
}

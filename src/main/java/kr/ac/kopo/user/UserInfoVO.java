package kr.ac.kopo.user;

import kr.ac.kopo.com.Pagination;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserInfoVO extends Pagination  {
	
	private String userId;  //회원아이디
	private String userName; //사용자 이름
	private String userPhone; //사용자 전화번호
	private String userGender; //사용자 성별 
	private double userHeight; //사용자 신장
	private double userWeight; //사용자 체중
	private String userBirth; //사용자 생년월일
	private String protRelation; //사용자와의 관계
	private String protPhone; //보호자 전화번호
	private String protName; //보호자 이름
	private String yy; //생년월일 연월일
	private String mm;
	private String dd;
	private String userEmail; //사용자 이메일
	private String userSelect; //사용자 구분 user 또는 protector
	private String userProId;
	private char userProRegist;
}

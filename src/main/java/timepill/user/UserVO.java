package timepill.user;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVO {

	// 공통컬럼
	private String userId; //유저아이디
	
	//users 테이블
	private String password; //유저비밀번호
	private String email; //유저이메일
	private String userStatus; //유저사용상태 가입시 Y, 탈퇴시 N
	private String userCarerAt; //복용관리자 여부 복용관리자 Y, 복용자 N
	
	//userInfo 테이블
	private String userName; // 유저이름
	private String userPhone; // 유저전화번호
	private String userGender; // 유저성별
	private String userHeight; //유저신장
	private String userWeight; //유저체중
	private String userBirth; //유저생년월일
	
	//생년월일
	private String yy;
	private String mm;
	private String dd;
}

package kr.ac.kopo.user;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVO {
	
	private String userId; //회원아이디
	private String userPwd; //회원비밀번호
	private String userEmail; //이메일
	private char userValid; //회원가입상태 탈퇴시N, 정보미등록시F, 정보등록완료시Y
	private char deviceRegist; //기기등록여부
	private String userSelect; //사용자 구분
}

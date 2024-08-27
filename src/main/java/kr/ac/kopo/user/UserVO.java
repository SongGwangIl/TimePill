package kr.ac.kopo.user;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVO {
	
	//회원아이디
	private String userId; 

	//회원비밀번호
	private String userPwd; 

	//이메일
	private String userEmail; 
	
	//회원가입상태 탈퇴시N, 정보미등록시F, 정보등록완료시Y
	private char userValid; 
	
	//기기등록여부
	private char deviceRegist; 
	
	//사용자 구분
	private String userSelect; 

}

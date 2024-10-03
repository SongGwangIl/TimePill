package timepill.user.service;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class AuthVO {
	
	//아이디
	private String userId;
	
	//이메일
	private String email;
	
	//인증번호
	private String authNum;
	
	//인증시도횟수
	private int authCount = 0;

}

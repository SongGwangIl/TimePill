package kr.ac.kopo.user;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVO {
	private String userId;
	private String userPwd;
	private String userEmail;
	private char userValid;
	private char deviceRegist;
	private String userSelect;
}

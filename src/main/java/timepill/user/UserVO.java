package timepill.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
@Getter
@Setter
public class UserVO implements UserDetails {

	// users테이블
	private String userId; // 유저아이디
	private String role; // 유저권한
	private String password; // 유저비밀번호
	private String email; // 유저이메일
	private String userStatus; // 유저사용상태 가입시 Y, 탈퇴시 N
	private String nickname; // 유저이름
	private String userPhone; // 유저전화번호
	private String userGender; // 유저성별
	private String userHeight; // 유저신장
	private String userWeight; // 유저체중
	private String userBirth; // 유저생년월일

	// 생년월일 셋팅
	private String yy;
	private String mm;
	private String dd;
	
	
	
	// 스프링 시큐리티 메소드
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + this.role));
		return authorities;
	}
	@Override
	public String getUsername() {
		return this.userId;
	}
	@Override
	public String getPassword() {
		return this.password;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return this.userStatus.equals("Y");
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return this.userStatus.equals("Y");
	}

}

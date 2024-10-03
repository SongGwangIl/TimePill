package timepill.user.service;

public interface AuthService {
	
	public String authEmail(AuthVO vo);
	
	public void setAuthInfo(AuthVO vo);

	public String authAtmp(AuthVO vo);

}

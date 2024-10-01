package timepill.user.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;

@Configuration
@Getter
public class MailConfig {
	
	@Value("${gmailUser}")
	private String user;
	
	@Value("${gmailUserName}")
	private String userName;
	
	@Value("${gmailPassword}")
	private String password;	

}

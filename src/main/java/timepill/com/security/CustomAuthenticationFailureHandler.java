package timepill.com.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author JJ
 * @see : 로그인 실패 핸들러
 * 
 */
@Slf4j
public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler implements AuthenticationFailureHandler {

	/** 로그인 실패 처리 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse resp, AuthenticationException e) throws IOException, ServletException {
		String errorMessage;
		if (e instanceof BadCredentialsException || e instanceof InternalAuthenticationServiceException || e instanceof UsernameNotFoundException) {
			log.error("로그인 에러 : " + e);
			errorMessage = "아이디 또는 비밀번호가 맞지 않습니다.";
		} else
			errorMessage = "로그인 중 문제가 발생했습니다.";

		req.getSession().setAttribute("message", errorMessage);
		setDefaultFailureUrl("/user/login");
		super.onAuthenticationFailure(req, resp, e);
	}

}
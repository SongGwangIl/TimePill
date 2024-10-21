package timepill.com.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

/**
 * 
 * @author JJ
 * @see : 미인증 핸들러
 * 
 */
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

	/* 미인증 처리 */
	@Override
	public void commence(HttpServletRequest req, HttpServletResponse resp, AuthenticationException authException) throws IOException, ServletException {
		
		// 미인증 사용자 리다이렉트 Url
		String deniedUrl = "/cover";

		resp.sendRedirect(deniedUrl);
	}
}

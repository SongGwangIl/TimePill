package timepill.com.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

/**
 * 
 * @author JJ
 * @see : 접근 거부 핸들러
 * 
 */
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	/** 접근 거부 처리 */
	@Override
	public void handle(HttpServletRequest req, HttpServletResponse resp, AccessDeniedException accessDeniedException) throws IOException, ServletException {

		String deniedUrl = "/";

		resp.sendRedirect(deniedUrl);
	}

}

package timepill.com;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

/**
 * 
 * @author JJ
 * @see : 로그아웃 성공 핸들러
 * 
 */
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	/** 로그아웃 성공 처리 */
	@Override
	public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth) throws IOException, ServletException {
		// 미인증 사용자 리다이렉트 Url
		String deniedUrl = "/cover";

		resp.sendRedirect(deniedUrl);
	}
}

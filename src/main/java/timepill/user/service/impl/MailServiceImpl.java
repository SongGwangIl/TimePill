package timepill.user.service.impl;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.user.service.MailConfig;
import timepill.user.service.MailService;

@Service("mailService")
public class MailServiceImpl implements MailService{

	@Autowired
	MailConfig mail;
	
	final String encoding = "UTF-8";
	final String port = "465"; //구글의 경우
	final String smtpHost = "smtp.gmail.com"; //구글의 경우
	
	//메일 session값 셋팅
	@Override
	public Session mailSetting(Properties props){
		
		Session session = null;
		
		try {
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", smtpHost);//이메일 발송을 처리해줄 STMP 서버
			props.put("mail.smtp.port", port);//SMTP 통신 포트
			props.put("mail.smtp.auth", true);//SMTP 인증 기능
			props.put("mail.smtp.ssl.enable", true);//SSL 사용여부
			props.put("mail.smtp.ssl.trust", smtpHost);//SSL 신뢰여부
			props.put("mail.smtp.starttls.required", true);//TLS 보호 연결을 활성화하는 데 사용
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");//SSL 버전
			props.put("mail.smtp.quit-wait", "false");//서버가 연결을 올바르게 종료했다는 응답을 확인
			props.put("mail.smtp.socketFactory.port", port);
			//SSL 통신에 사용할 소켓통신 클래스
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
			props.put("mail.smtp.socketFactory.fallback", "false");
			//Authenticator : javax.mail.Authenticator
			session = Session.getInstance(props, new Authenticator() {
				@Override
				//PasswordAuthentication : javax.mail.PasswordAuthentication
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(mail.getUser()
								, mail.getPassword());
				}

			});			
		} catch (Exception e) {
			System.out.println("실패");
		}
		
		return session;
	}
	
	//메일 보내기
	@Override
	public void sendMail(Session session, String title, String content, String receiver){
		
		Message msg = new MimeMessage(session);
		
		try {
			msg.setFrom(new InternetAddress(mail.getUser(), mail.getUserName()
						, encoding));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			msg.setSubject(title);
			msg.setContent(content, "text/html; charset=utf-8");
			
			Transport.send(msg);
			
		} catch (Exception e) {
			System.out.println(e);
		}		
	}	
}


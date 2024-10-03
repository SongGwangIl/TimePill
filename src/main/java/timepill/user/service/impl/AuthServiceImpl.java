package timepill.user.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.mail.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import timepill.com.RandomCharacterGenerator;
import timepill.user.service.AuthService;
import timepill.user.service.AuthVO;
import timepill.user.service.MailService;

@Service
public class AuthServiceImpl extends RandomCharacterGenerator implements AuthService {
	
	@Autowired
	MailService mailService;	
	
	//HashMap을 사용하여 인증정보 저장
	private final Map<String, AuthVO> AuthMap = new HashMap<>();
	
	//ScheduledExecutorService 사용하여 일정시간 뒤 인증정보를 삭제할 스케줄러 생성
	private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	
	
	//이메일 인증번호발송
	@Override
	public String authEmail(AuthVO vo) {
		
		String message = "이메일로 인증번호를 전송하였습니다.";
			
		if(vo.getUserId().isEmpty() || vo.getEmail().isEmpty()) {
			message = "아이디와 이메일을 모두 입력해주세요";
		}else{
			//임시 비밀번호를 생성(영+영+숫+영+영+숫=6자리)
			String authNumber = "";
			for(int i=1; i<=6; i++) {
				//영자
				if(i % 3 != 0)
					authNumber += getRandomCharacter();
				//숫자
				else
					authNumber += getRandomNumber();
			}
			//인증정보셋팅
			AuthVO avo = new AuthVO();
			setAuthInfo(avo);
		
			//메일전송
			String title = "비밀번호변경";
			String content = "인증번호는 (" + authNumber + ") 입니다.";
			//javax.mail.Session
			Session session = mailService.mailSetting(new Properties());
			mailService.sendMail(session, title, content, vo.getEmail());
		
		}
		return message;
	}

	//인증정보저장
	@Override
	public void setAuthInfo(AuthVO vo) {		
		
		String id = vo.getUserId();
		
		AuthMap.put(id, vo);
		
		//5분뒤 인증정보 삭제 스케줄링
		scheduler.schedule(()-> AuthMap.remove(id), 5, TimeUnit.MINUTES);
	}

	//인증
	@Override
	public String authAtmp(AuthVO vo) {
		
		AuthVO avo = AuthMap.get(vo.getUserId());
		
		if(avo != null) {
			//인증성공
			if(avo.getUserId().equals(vo.getUserId()) && avo.getEmail().equals(vo.getEmail()) 
					&& avo.getAuthNum().equals(vo.getAuthNum()) && avo.getAuthCount() < 3) {
				
				return "Y";
				//인증실패
			}else {
				int count = avo.getAuthCount() + 1;
				avo.setAuthCount(count);
				AuthMap.put(avo.getUserId(), avo);
				
				return "N";
			}			
		}else
			return "N";
	}

}

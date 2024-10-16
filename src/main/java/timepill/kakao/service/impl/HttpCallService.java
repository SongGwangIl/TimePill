package timepill.kakao.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class HttpCallService {
	

	/** HTTP 요청을 보내고 응답을 받는 메소드 */
	public String Call(String method, String reqURL, String header, String param) {
		log.debug("HTTP 요청 시작");
		
		String result = "";
		int responseCode = 0;
		
		try {
			
			// 요청 url 설정
			String response = "";
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // 요청 URL
			System.out.println("요청 URL: " + reqURL);
			
			// 요청 메서드 및 헤더 설정
			conn.setRequestMethod(method); // 요청 method 타입
			conn.setRequestProperty("Authorization", header); // 인증 방식 ex)액세스 토큰으로 인증 요청
			log.debug("메서드: {}", method);
			log.debug("Authorization: {}", header);

			
			// 요청 전송
			if (param != null) {
				conn.setDoOutput(true);
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(param);
				bw.flush();
			}
			log.debug("파라미터: ", param == null ? "null" : param);
			
			// HTTP 응답 코드 반환
			responseCode = conn.getResponseCode();
			log.debug("응답 코드: {}", responseCode);
			
			// 에러 체크
			InputStream stream = conn.getErrorStream();
			if (stream != null) {
				try (Scanner scanner = new Scanner(stream)) {
					scanner.useDelimiter("\\Z");
					response = scanner.next();
				}
				log.debug("에러 응답: {}", response);
			}

			// HTTP 응답 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			br.close();
			log.debug("응답 본문: {}", result);
			
		} catch (IOException e) {
			log.debug("예외 발생: {}", e.getMessage());
			
			if (responseCode == 401)
				return Integer.toString(responseCode);
			return e.getMessage();
		}
		return result;
	}

	/** 액세스 토큰을 포함하여 HTTP 요청을 보내는 메소드 */
	public String CallwithToken(String method, String reqURL, String access_Token) {
		return CallwithToken(method, reqURL, access_Token, null);
	}

	/** 액세스 토큰과 파라미터를 포함하여 HTTP 요청을 보내는 메소드 */
	public String CallwithToken(String method, String reqURL, String access_Token, String param) {
		String header = "Bearer " + access_Token;
		return Call(method, reqURL, header, param);
	}
}

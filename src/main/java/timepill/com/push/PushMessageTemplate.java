package timepill.com.push;

import org.springframework.beans.factory.annotation.Value;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class PushMessageTemplate {
	
	@Value("${message-url}")
	private static String MESSAGE_URL;
	

	/* 카카오 피드 메세지 템플릿 참고 형태
	 	{
		    "object_type": "feed",
		    "content": {
		        "title": "복약 알림",
		        "description": "약먹을 시간이에요.",
		        "image_url": "이미지url주소",
		        "image_width": 640,
		        "image_height": 640,
		        "link": {
		            "web_url": "url주소"
		        }
		    },
		    "buttons": [
		        {
		            "title": "복약체크",
		            "link": {
		                "web_url": "url주소",
		                "mobile_web_url": "url주소"
		            }
		        }
		    ]
		}
	 */
	
	/** 카카오 피드 메세지 템플릿 */
	public static String getKakaoMessage() {
		JsonObject link = new JsonObject();
		link.addProperty("web_url", MESSAGE_URL);

		JsonObject content = new JsonObject();
		content.addProperty("title", "복약 알림");
		content.addProperty("description", "약먹을 시간이에요.");
		content.addProperty("image_url", "http://www.friendlycommunity.xyz/image/d85a5982-1d85-487c-9725-3a45d46b49da");
		content.addProperty("image_width", "250");
		content.addProperty("image_height", "150");
		content.add("link", link);

		JsonObject button = new JsonObject();
		button.addProperty("title", "복약체크");
		button.add("link", link);

		JsonArray buttons = new JsonArray();
		buttons.add(button);

		JsonObject templateObject = new JsonObject();
		templateObject.addProperty("object_type", "feed");
		templateObject.add("content", content);
		templateObject.add("buttons", buttons);

		return "template_object=" + templateObject.toString();
	}
	
	/* 웹 푸시 메세지 템플릿 참고 형태
		{
		   "title": "복약 알림",
		    "body": "약먹을 시간이에요.",
		    "icon": "/resources/img/logo.svg",
		    "url": "/"
		}
	*/
	
	/** 웹 푸시 메세지 템플릿 */
	public static String getWebPushMessage() {
		JsonObject jsonMessge = new JsonObject();
		jsonMessge.addProperty("title", "복약 알림");
		jsonMessge.addProperty("body", "약먹을 시간이에요.");
		jsonMessge.addProperty("icon", "/resources/img/logo.svg");
		jsonMessge.addProperty("url", "/");
		
		return jsonMessge.toString();
	}
}

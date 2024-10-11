package timepill.kakao.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class KakaoMessageTemplate {

	/* 카카오 피드 메세지 템플릿 참고 형태
	 	{
		    "object_type": "feed",
		    "content": {
		        "title": "복약 알림",
		        "description": "약먹을 시간이에요.",
		        "image_url": "http://115.10.156.136/image/c687a0f4-713e-4c03-a6ea-b09d0c004d0d",
		        "image_width": 640,
		        "image_height": 640,
		        "link": {
		            "web_url": "http://115.10.156.136/board/69"
		        }
		    },
		    "buttons": [
		        {
		            "title": "복약체크",
		            "link": {
		                "web_url": "http://115.10.156.136/board/69",
		                "mobile_web_url": "http://115.10.156.136/board/69"
		            }
		        }
		    ]
		}
	 */
	
	/** 카카오 피드 메세지 템플릿 */
	public static String getDefaultMessageParam() {
		JsonObject link = new JsonObject();
		link.addProperty("web_url", "http://www.friendlycommunity.xyz/board/69");
		link.addProperty("mobile_web_url", "http://www.friendlycommunity.xyz/board/69");

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
	
	
}

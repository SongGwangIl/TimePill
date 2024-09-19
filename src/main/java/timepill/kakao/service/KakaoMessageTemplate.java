package timepill.kakao.service;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class KakaoMessageTemplate {

	public static String default_msg_param = ""
    		+ "template_object={\n"
    		+ "        \"object_type\": \"feed\",\n"
    		+ "        \"content\": {\n"
    		+ "            \"title\": \"복약 알림\",\n"
    		+ "            \"description\": \"약먹을 시간입니다.\",\n"
    		+ "            \"link\": {\n"
    		+ "                \"web_url\": \"http://daum.net\",\n"
    		+ "                \"mobile_web_url\": \"http://dev.kakao.com\"\n"
    		+ "            }\n"
    		+ "        },\n"
    	    + "    \"buttons\": [\n"
    	    + "        {\n"
    	    + "            \"title\": \"바로 확인\",\n"
    	    + "            \"link\": {\n"
    	    + "                \"web_url\": \"http://daum.net\",\n"
    	    + "                \"mobile_web_url\": \"http://dev.kakao.com\"\n"
    	    + "            }\n"
    	    + "        }\n"
    	    + "    ]\n"
    		+ "    }"
    		+ "";		

	public static JsonObject getDefaultMessageParam() {
		Gson gson = new Gson();

        Map<String, Object> link = new HashMap<>();
        link.put("web_url", "https://www.google.co.kr/search?q=drone&source=lnms&tbm=nws");
        link.put("mobile_web_url", "https://www.google.co.kr/search?q=drone&source=lnms&tbm=nws");

        Map<String, Object> templateObject = new HashMap<>();
        templateObject.put("object_type", "text");
        templateObject.put("text", "Google 뉴스: drone");
        templateObject.put("link", link);

        JsonObject data = new JsonObject();
        data.add("template_object", JsonParser.parseString(gson.toJson(templateObject)).getAsJsonObject());

        return data;
		
		
//		JsonObject link = new JsonObject();
//		link.addProperty("web_url", "https://src.hidoc.co.kr/image/lib/2016/12/23/20161223184952714_0.jpg");
//		link.addProperty("mobile_web_url", "https://src.hidoc.co.kr/image/lib/2016/12/23/20161223184952714_0.jpg");
//
//		JsonObject content = new JsonObject();
//		content.addProperty("text", "약먹을 시간입니다.");
//		content.add("link", link);
//
//		JsonObject templateObject = new JsonObject();
//		templateObject.addProperty("object_type", "text");
//		templateObject.add("content", content);
//		templateObject.addProperty("button_title", "복약 체크");
//
//		JsonObject messageParam = new JsonObject();
//		messageParam.add("template_object", templateObject);
//
//		return messageParam;
	}
}

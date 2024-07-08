<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="membership" class=" step1">
	        <h1 class="logo"><a href="#">TIME PILL</a></h1>
	        <div class="terms_wrap">
	            <div class="total_agree">
	                <input type="checkbox" id="terms_agree" autocomplete="off"/><label for="terms_agree"><em><i></i></em><span>모두 동의합니다.</span></label>
	                <p>전체 동의에는 필수 및 선택 정보에 대한 동의가 포함되어 있으며, 개별적으로 동의를 선택 하실 수 있습니다. 선택 항목에 대한 동의를 거부하시는 경우에도 서비스 이용이 가능합니다.</p>
	            </div>
	            <ul>
	                <li>
	                    <input type="checkbox" id="terms_agree1" class="agree_chk" autocomplete="off"/>
	                    <label for="terms_agree1"><em><i></i></em><span>이용약관 동의 </span> <i>(필수)</i></label>
	                    <button type="button" id="btn1">보기</button>
	                </li>

	                <li>
	                    <input type="checkbox" id="terms_agree2" class="agree_chk" autocomplete="off">
	                    <label for="terms_agree2"><em><i></i></em><span>개인정보 수집 및 이용 동의 </span> <i>(필수)</i></label>
	                    <button type="button" id="btn2">보기</button>
	                </li>                    
	            </ul>
	        </div>
	        <p id="alertArea"></p>
	        	        
	        <div class="btn_wrap">
	            <!-- <a href="#n" class="btn"></a> -->
	            <a href="#n" class="btn gray">취소</a>
	            <a href="#n" class="btn blue">동의</a>
	        </div>

	    </div>
</body>
</html>
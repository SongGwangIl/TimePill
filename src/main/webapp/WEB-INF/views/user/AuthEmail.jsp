<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>비밀번호 찾기 - TimePill </title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/resources/img/logo.svg">
	
	<!-- jQuery 3.7.1-->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<!-- Gmarket SANS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css"
	    type="text/css" />
	<!-- NotoSans KR-->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	    rel="stylesheet">
	<!-- jQuery UI -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.0/themes/base/jquery-ui.css">
	    
	<!-- 기본 템플릿 CSS -->
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/user/authEmail.css">
	<sec:csrfMetaTags/>
</head>
<body>
<div id="contents" class="bgimg">
	<img src="/resources/img/mainico.png" class="main-ico">
    <div class="boxh">
        <img src="/resources/img/logo.svg" class="logo">
        <h1 class="gsansdown title">비밀번호찾기</h1>
    </div>

    <div class="wrap">
		<form id="authFrm" action="/user/auth-atmp" method="post">				                 
	        <span>아이디</span>	            
	        <div class="input password">
	            <input type="text" class="form-input" id="userId" name="userId" value="${auth.userId}" required>
	        </div>
	        <span>이메일</span>	            
	        <div class="input password">
	            <input type="email" class="form-input" id="email" name="email" value="${auth.email}" required>
	        </div>	                               
            <div class="btns boxh">
	           <a class="btn-sky btn" id="reqAuthNum" type="button">
	               <p class="btndesc"> 인증번호요청 </p>
	           </a>
			</div>
	        <span>인증번호</span>	            
	        <div class="input password">
	            <input type="text" class="form-input" name="authNum" required>
	        </div>	                               
			<sec:csrfInput/>
			<div class="btns boxh" id="btns">
		        <a class="btn-sky btn" id="authAtmp">
		            <p class="btndesc"> 인증 </p>
		        </a>
		        <a class="btn-white btn" id="goLogin">
		            <p class="btndesc"> 로그인화면 </p>
		        </a>
			</div>			
		</form>
     </div>
</div>
<script>

document.querySelector('#reqAuthNum').onclick = reqAuthNum;
document.querySelector('#authAtmp').onclick = function(){
	document.querySelector('#authFrm').submit();
}
document.querySelector('#goLogin').onclick = function(){
	window.location.href = "/user/login";
}

function reqAuthNum(){
	let header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	let token = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	let userIdInp = document.querySelector('#userId');
	let emailInp = document.querySelector('#email');
	
	$.ajax({
		url: "/user/auth-email/send",
		type: "post",
		data: {
			"userId": userIdInp.value,
			"email": emailInp.value				
		},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/string");
		},
		success: function(result){
			if(result === 'Y')
				alert("이메일로 인증번호를 전송하였습니다.");
			else
				alert("아이디와 이메일을 모두 입력해주세요.");
		}, error: function(){
			alert("인증번호 발송을 실패했습니다.");
		}
	});		
}

<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
</body>

</html>
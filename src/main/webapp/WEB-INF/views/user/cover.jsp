<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cover.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
.bg { 
	width:100%;
	height:380px;
	position:absolute;
	left:0px;
	top:182px;
	background-image: url(resources/img/background.png);
	background-repeat:no-repeat;
	background-size:cover;
}
.device { 
	width:377px;
	height:506px;
	position:absolute;
	left:0px;
	top:0px;
	background-image:url(resources/img/device2.png);
	background-repeat:no-repeat;
	background-size:cover;
}
</style>

</head>
<body>
	<div class="e1_6">
		<div class="e1_4">
			<div class="bg"></div>
			<span class="desc1">
				홀로 복용 관리에 어려움을 느끼는 노인들과 <br> 가족과 멀리 떨어져 지내는
				보호자들에게 <br> 스마트한 어플리케이션을 제공하여 <br>약물 복용 관리 맞춤형 서비스를 제공합니다.
			</span>
			<div class=e3_15>
				<div class="device"></div>
				<span class="title"> TimePill Dispensor </span>
				
				<span class="desc2">
					가족의 건강을 <br> 모두가 함께 관리할 수 있는 <br> 스마트한 알약 디스펜서
				</span>
				<div class="e2_13"></div>
			</div>
			<div class=e3_21>
				<a href="${pageContext.request.contextPath}/login">
				<span class="btn1">로그인</span>
				<div class="e3_16"></div>
				</a>
				
				<a href="${pageContext.request.contextPath}/singup">
				<span class="btn2">회원가입</span>
				<div class="e3_19"></div>
				</a>
			</div>
			<span class="e3_24">타임필 소프트웨어를 본격적으로 사용해보세요!</span>
		</div>
	</div><br><br>
	
<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/cover.css" type="text/css">
<style>
	.bg{
		top: 0px;
		left: 0px;
		width: 1920px;
		height: 1080px;
		/* UI Properties */
		background: transparent url('${pageContext.request.contextPath}/resources/img/background.png') 0% 0% no-repeat padding-box;
		opacity: 1;
	}
	
	
	
</style>

</head>
<body class="bg">
	<div id="wrap">
		
		<h1>TimePill Dispensor</h1>
		<h3>홀로 거주하는 노인들과 보호자들에게 스마트폰 연동 애플리케이션을 통한 약물 복용 관리 맞춤형 서비스를 제공합니다.</h3>
		
			<div>
				<a href="${pageContext.request.contextPath}/login">로그인</a>
				<a href="${pageContext.request.contextPath}/terms">회원가입</a>
		 
	
	</div>
</body>
</html>
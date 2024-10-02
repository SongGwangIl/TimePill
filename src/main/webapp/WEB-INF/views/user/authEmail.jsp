<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<sec:csrfMetaTags/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>이메일 인증</h1>
	<form action="/user/resetPassword">
		<label>아이디</label>
		<input type="text" id="userId"><br>
		<label>이메일</label>
		<input type="text" id="email">
		<button type="button" id="reqAuthNumBtn">인증번호요청</button><br>
		<label>인증번호</label>
		<input type="text" name="authEmail">
		<button type="button">인증</button>	
	</form>
	<p id="authCount"></p>

	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
	<script>
	document.querySelector('#reqAuthNumBtn').onclick = reqAuthNum;
	
	function reqAuthNum(){
		let header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
		let token = document.querySelector('meta[name="_csrf"]').getAttribute('content');
		let userIdInp = document.querySelector('#userId');
		let emailInp = document.querySelector('#email');
		
		$.ajax({
			url: "/user/authEmail",
			type: "post",
			data: {
				"userId": userIdInp.value,
				"email": emailInp.value				
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
				xhr.setRequestHeader("Accept", "application/json");
			},
			success: function(result){
				alert(result.message);
			}, error: function(){
				alret("인증번호 발송을 실패했습니다.");
			}
		});		
	}
	</script>
</body>
</html>
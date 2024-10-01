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
	<h1>비밀번호 변경</h1>
	
	<label>아이디</label>
	<input type="text" id="userId"><br>
	<label>이메일</label>
	<input type="text" id="email">
	<button type="button" id="reqAuthNumBtn">인증번호요청</button><br>
	<label>인증번호: </label>
	<input type="text" name="authEmail">
	<button type="button">인증</button>	
	<p id="authCount"></p>
	
	<form action="/user/resetPassword" method="post">
		<label>새비밀번호</label>
		<input type="text" name="password"><br>
		<label>비밀번호확인</label>
		<input type="text" name="checkPassword">
		<button type="button">변경</button>	
		<sec:csrfInput/>	
	</form>
	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
	<script>
	document.querySelector('#reqAuthNumBtn').onclick = reqAuthNum();
	
	function reqAuthNum(){
		let userId = document.querySelector('#userId');
		let userEmail = document.querySelector('#userEmail');
		
		$.ajax({
			url: "/user/authEmail",
			type: "post",
			data: {
				userId: userId.value,
				email: userEmail.value				
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
				xhr.setRequestHeader("Accept", "application/json");
			},
			success: function(result){
				if(result === ''){
					viewIdSp.innerText = "등록되지 않은 이메일 입니다.";
				}else{
					viewIdSp.innerText = result;
					let reqBtn = document.createElement('button');
					reqBtn.type = 'button';
					reqBtn.id = 'reqAuthBtn';
					reqBtn.textContent = "인증번호요청"
					reqBtn.onclick = 'reqAuthNum';
					document.querySelector('#authNumber').append(reqBtn);
				}
			},
			error: function(){
				alert("서버요청실패");
			}			
		});		
	}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<sec:csrfMetaTags/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>이메일 인증</h1>
	<form action="/user/authAtmp" id="authFrm" method="post">
		<label>아이디</label>
		<input type="text" id="userId" name="userId" required="required"><br>
		<label>이메일</label>
		<input type="text" id="email" name="email" required="required">
		<button type="button" id="reqAuthNumBtn">인증번호요청</button><br>
		<label>인증번호</label>
		<input type="text" name="authNum" required="required">
		<button type="submit" id="authAtmpBtn">인증</button>
		<sec:csrfInput/>
	</form>

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
				xhr.setRequestHeader("Accept", "application/string");
			},
			success: function(result){
				if(result === 'Y')
					alert("이메일로 인증번호를 전송하였습니다.");
				else
					alert("아이디와 이메일을 모두 입력해주세요.");
			}, error: function(){
				alret("인증번호 발송을 실패했습니다.");
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
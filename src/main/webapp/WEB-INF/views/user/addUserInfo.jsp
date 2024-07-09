<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:,">
<meta charset="UTF-8">
<title>사용자 정보 입력</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h1>사용자 정보 입력</h1>
	<form action="${pageContext.request.contextPath}/addUserInfo"
		method="post">
		<input type="hidden" name="userId" value="${loginUser.userId}"><br>
		<ul class="input">
			<li><label class="label">이름</label> <input type="text"
				name="userName" required><br></li>
			<li><label class="label">전화번호</label> <input type="text"
				name="userPhone" placeholder="-를 제외한 숫자만 입력"><br></li>
			<li><label class="label">성별</label>
				<div class="select">
					<input type="radio" id="male" name="userGender" value="m"><label
						for="male" class="hover">남성</label> <input type="radio"
						id="female" name="userGender" value="fm" checked><label
						for="female" class="hover">여성</label>
				</div></li>
			<li><label class="label">키</label> <input type="number"
				name="userHeight"><br></li>
			<li><label class="label">몸무게</label> <input type="number"
				name="userWeight"><br></li>
			<li><label class="label">생년월일</label> <input type="text"
				name="userBirth"><br></li>
		</ul>
		<ul id="buttons">
			<li>
				<button type="submit">등록</button>
				<br>
			</li>
			<li>
				<button type="button" onclick="location.href='cover'">취소</button> <br>
			</li>
		</ul>
	</form>
</body>
</html>
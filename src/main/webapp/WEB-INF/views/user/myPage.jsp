<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:,">
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="wrap">
		<h1>나의정보변경</h1>
		<c:choose>
			<c:when test="${myInfo.userSelect eq 'user'}">
				<form action="${pageContext.request.contextPath}/myPage"
					method="post">
					<input type="hidden" name="userId" value="${myInfo.userId}"><br>
					<ul>
						<li><label class="label">이름</label> <input type="text"
							name="userName" class="input" required value="${myInfo.userName}"><br></li>
						<li><label class="label">전화번호</label> <input type="text"
							name="userPhone" class="input" placeholder="-를 제외한 숫자만 입력" value="${myInfo.userPhone}"><br></li>
						
						<li><label class="label">키</label> <input type="number"
							name="userHeight" class="input" value="${myInfo.userHeight}"><br></li>
						<li><label class="label">몸무게</label> <input type="number"
							name="userWeight" class="input" value="${myInfo.userWeight}"><br></li>
						
						<li>
							<label class="label">이메일</label>
							<input type="text" name="userEmail" value="${myInfo.userEmail}">
						</li>
					</ul>
					<ul id="buttons">
						<li>
							<button type="submit" id="changeUserInfo">변경</button>
						</li>
						<li>
							<button type="button" onclick="location.href='main'">취소</button> <br>
						</li>
					</ul>
				</form>
			</c:when>
			<c:otherwise>
				<form action="${pageContext.request.contextPath}/myPage"
					method="post">
					<input type="hidden" name="userId" value="${myInfo.userId}"><br>
					<ul>
						<li>
							<label class="label">이름</label> 
							<input type="text" name="protName" value="${myInfo.protName}" required>
						</li>
						<li>
							<label class="label">전화번호</label>
							<input type="text" name="protPhone" value="${myInfo.protPhone}">
						</li>
						<li>
							<label class="label">관계</label>
							<input type="text" name="protRelation" value="${myInfo.protRelation}">
						</li>
						<li>
							<label class="label">이메일</label>
							<input type="text" name="userEmail" value="${myInfo.userEmail}">
						</li>
					</ul>
					<ul id="buttons">
						<li>
							<button type="submit" id="changeProtectorInfo">변경</button>
						</li>
						<li>
							<button type="button" onclick="location.href='main'">취소</button> <br>
						</li>
					</ul>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
<script>
	$(document).ready(function(){
		//정보변경
		$("#changeUserInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
		
		$("#changeProtectorInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
	});
</script>
</body>
</html>
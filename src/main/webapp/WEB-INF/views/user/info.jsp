<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<div id="wrap">
		<h1>TimePill<br>추가정보입력</h1>
		<c:choose>
			<c:when test='${user.userSelect eq "user"}'>
			
				<form method="post" name="userInfo">
					<input type="hidden" name="userId" value="${user.userId}"><br>
					<ul class="input">						
						<li>
		                	<label class="label">이름</label>
		                	<input type="text" name="userName" required><br>
						</li>
						<li>
		                	<label class="label">전화번호</label>
		                	<input type="text" name="userPhone" placeholder="-를 제외한 숫자만 입력"><br>
						</li>
						<li>
		                	<label class="label">성별</label>
		                	<div class="select">
			                	<input type="radio" id="male" name="userGender" value="m"><label for="male" class="hover">남성</label>
			                	<input type="radio" id="female" name="userGender" value="fm" checked><label for="female" class="hover">여성</label>	                
		                	</div>                
						</li>
						<li>
		                	<label class="label">키</label>
		                	<input type="number" name="userHeight"><br>
						</li>
						<li>
		                	<label class="label">몸무게</label>
		                	<input type="number" name="userWeight"><br>
						</li>
						<li>
		                	<label class="label">생년월일</label>
		                	<input type="date" name="userBirth"><br>
						</li>
		            </ul>
		            <ul id="buttons">
		            	<li>
						    <button type="submit" onclick="javascript: userInfo.action='/kopo/user';">등록</button><br>
		            	</li>
		            	<li>
						    <button type="button" onclick="location.href='cover'">취소</button><br>        
		            	</li>
		            </ul>
				</form>
			</c:when>
			<c:otherwise>			
				<form method="post" name="protectorInfo">
					<input type="hidden" name="userId" value="${user.userId}"><br>
					<ul class="input">
						<li>
		                	<label class="label">이름</label>
		                	<input type="text" name="protName" required><br>
						</li>
						<li>
		                	<label class="label">전화번호</label>
		                	<input type="number" name="protPhone" placeholder="-를 제외한 숫자만 입력"><br>
						</li>
						<li>
		                	<label class="label">관계</label>
		                	<input type="text" name="protRelation"><br>
						</li>
		            </ul>
		            <ul id="buttons">
		            	<li>
						    <button type="submit" onclick="javascript: protectorInfo.action='/kopo/protector';">등록</button><br>
		            	</li>
		            	<li>
						    <button type="button" onclick="location.href='cover'">취소</button><br>        
		            	</li>
		            </ul>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
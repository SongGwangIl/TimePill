<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/add.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/jquery-ui.css" type="text/css">
</head>
<body>
	<div id="wrap">
		<h1>회원가입</h1>
		<form action="${pageContext.request.contextPath}/singup" method="post">
			<ul class="input">
				<li>
                	<label class="label">아이디</label>
                	<input type="text" name="userId" id="userId" placeholder="6-15자리 영문과 숫자로 입력" required><br>				
                	<p id="idCheck"></p>
				</li>
				<li>
                	<label class="label">비밀번호</label>
                	<input type="password" name="userPwd" id="userPwd" placeholder="8-20자리 영문 대,소문자 숫자 특수문자 포함" required><br>
                	<p id="userPwdMsg"></p>
				</li>
				<li>
                	<label class="label">비밀번호 확인</label>
                	<input type="password" name="checkUserPwd" id="checkUserPwd" required><br>
                	<p id="checkUserPwdMsg"></p>
				</li>
				<li>
                	<label class="label">이메일</label>
                	<input type="email" name="userEmail" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required><br>
				</li>
				<li>
                	<label class="label">사용방법선택</label>
                	<div class="select">
	                	<input type="radio" id=user name="userSelect" value="user"><label for="user" class="hover">사용자</label>
	                	<input type="radio" id=protector name="userSelect" value="protector" checked><label for="protector" class="hover">보호자</label>	                
                	</div>                
				</li>
            </ul>
            <ul id="buttons">
            	<li>
				    <button type="submit">회원가입</button><br>
            	</li>
            	<li>
				    <button type="button" onclick="location.href='cover'">취소</button><br>        
            	</li>
            </ul>
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/user/add.js"></script>
</body>
</html>
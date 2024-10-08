<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/jquery-ui.css"
	type="text/css">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="wrap">
	<h1>내 정보 변경</h1>
	<form:form action="${pageContext.request.contextPath}/user/singup"
		modelAttribute="userVO" method="post">
		<ul class="input">
			<li>
				<label class="label">이름</label> 
				<form:input type="text" path="nickname" id="nickname" required="required" /><br> 
				<form:errors path="nickname"></form:errors>
			</li>
			<li>
				<label class="label">비밀번호</label> 
				<form:input type="password" path="password" id="password"
					placeholder="8-20자리 영문 대,소문자 숫자 특수문자 포함" required="required" /><br>
				<p id="userPwdMsg"></p> 
				<form:errors path="password"></form:errors>
			</li>
			<li>
				<label class="label">이메일</label> 
				<form:input type="email" path="email" placeholder="이메일 입력" id="email" 
					onkeyup='autoEmail("email",this.value)' required="required" /><br>
				<form:errors path="email"></form:errors>
			</li>
		</ul>
		<button class="btn" id="change">변경</button>
		<button class="btn" type="button" onclick="location.href='/'">취소</button>
		<sec:csrfInput />
	</form:form>
</div>
<script src="/resources/js/common/jquery-3.7.1.min.js"></script>
<script src="/resources/js/common/jquery-ui.min.js"></script>
<script src="/resources/js/user/myInfoValidation.js"></script>

<script>
	$(document).ready(function() {
		let form = $("#form")
		//정보변경
		$("#change").click(function() {
			if (!confirm("변경하시겠습니까?")) {
				return false;
			}
			form.submit();
		});
	});
</script>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>
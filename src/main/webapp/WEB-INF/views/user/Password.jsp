<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill"/>
</c:import>

<!-- 파비콘 -->
<link rel="icon" href="/resources/img/logo.svg">

<link rel="stylesheet" href="/resources/css/user/password.css">
<link rel="stylesheet" href="/resources/css/common/common.css">
<div id="contents">
	<h1>비밀번호 변경</h1>
	
	<form id="passFrm" action="/user/password" method="post">
		<div class="passWrap">
			<label>새비밀번호</label>
			<input id="password" class="form-input" type="password" name="password" required><br>
			<p id="userPwdMsg" class="msg"></p>
			<label>비밀번호확인</label>
			<input id="checkUserPwd" class="form-input" type="password" name="checkPassword" required>
			<p id="checkUserPwdMsg" class="msg"></p>			
			<div class="btns boxh">
            <a href="#" class="btn-sky" id="change">
                <p class="btndesc"> 수정하기 </p>
            </a>
            <a href="#" class="btn-white" id="cancel">
                <p class="btndesc"> 돌아가기 </p>
            </a>
        </div>
		</div>
<%-- 		<sec:csrfInput/>	 --%>
	</form>	
</div>
<script src="/resources/js/user/password.js"></script>
<script>
document.getElementById('change').addEventListener('click', function () {
	event.stopPropagation();
    let changeConfirm = confirm("등록된 정보로 수정하시겠습니까?");
    if(changeConfirm){
    	document.getElementById('passFrm').submit();
    }
});
document.getElementById('cancel').addEventListener('click', function () {
	event.stopPropagation();
	window.location.href = "/";
});
    
</script>
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>
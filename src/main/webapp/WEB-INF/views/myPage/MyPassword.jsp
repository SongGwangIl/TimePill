<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="비밀번호 변경 - TimePill"/>
</c:import>

<link rel="stylesheet" href="/resources/css/myPage/myPassword.css">

<div id="contents">
	<!-- 타이틀 -->
	<div>
	    <h1 class="txa subtitle">비밀번호 변경</h1>
	</div>
	
	<form id="passFrm" action="/mypage/myPassword" method="post">
		<div class="passWrap">
			<label>새비밀번호</label>
			<input id="password" class="form-input" type="password" name="password" required/><br>
			<p id="userPwdMsg" class="msg"></p>
			<label>비밀번호확인</label>
			<input id="checkUserPwd" class="form-input" type="password" name="checkPassword" required/>
			<p id="checkUserPwdMsg" class="msg"></p>			
        </div>
		<div class="btns boxh">
            <a class="btn-sky" id="change">
                <p class="btndesc"> 수정하기 </p>
            </a>
            <a class="btn-white" id="cancel">
                <p class="btndesc"> 돌아가기 </p>
            </a>
		</div>
		<sec:csrfInput/>
	</form>	
</div>
<script src="/resources/js/user/password.js"></script>
<script>
const passwordInp = document.querySelector('#password');
const checkUserPwdInp = document.querySelector('#checkUserPwd');

document.getElementById('change').addEventListener('click', function () {
    let changeConfirm = confirm("등록된 정보로 수정하시겠습니까?");
    if(changeConfirm){
    	if (!checkValidity()) {
            event.preventDefault(); // 유효성 검사 실패 시 제출 방지
            alert("입력을 확인하세요.");
        }
    	else
    		document.getElementById('passFrm').submit();
    }
});
document.getElementById('cancel').addEventListener('click', function () {
	window.location.href = "/mypage ";
});

function checkValidity(){
	if(passwordInp.value === '' || checkUserPwdInp === '')
		return false;
	return true;
}
    
</script>
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>
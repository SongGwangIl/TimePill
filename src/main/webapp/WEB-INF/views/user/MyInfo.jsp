<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="내 정보 수정 - TimePill"/>
</c:import>

<!-- jQuery 3.7.1-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>    
<!-- Gmarket SANS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css" />
<!-- NotoSans KR-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- jQuery UI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.0/themes/base/jquery-ui.css">
<!-- 기본 템플릿 CSS -->   
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/user/myInfo.css">

<div id="backcontainer" class="boxv">
     <div id="contents" class="">
        <!-- 타이틀 -->
        <div>
            <h1 class="txa subtitle"> 내 정보 수정 </h1>
        </div>
        <div>
            <form:form id="joinForm" action="/mypage/myinfo" modelAttribute="userVO" method="post">
                <table class="joinform">
                    <tr>
                            <td>이름(닉네임)</td>
                        </tr>
                        <tr>
                            <td>
                                <form:input type="text" path="nickname" class="form-input" required="required" />
                            </td>
                        </tr>
                        <sec:authorize access="!principal.username.contains('KAKAO_')">
	                        <tr>
	                            <td>이메일</td>
	                        </tr>
	                        <tr>
	                            <td>
	                                <form:input type="email" class="form-input" path="email" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required="required"/>
	                                <form:errors path="email"></form:errors>
	                            </td>
	                        </tr>
                        </sec:authorize>
                </table>
                <sec:csrfInput /> 
            </form:form>
        </div>

        <div class="btns boxh">
            <a href="#" class="btn-white" id="change">
                <p class="btndesc"> 수정하기 </p>
            </a>
            <a href="/" class="btn-white">
                <p class="btndesc"> 돌아가기 </p>
            </a>
        </div>
    </div>
</div>
<template id="checkImg">
	<img id="logo" src="/resources/img/chhe.png" style="width: 20px; margin: 0;">
</template>

<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"></script>
<script src="/resources/js/user/myInfoValidation.js"></script>

<script>
//'가입하기' 버튼 클릭 시 form 제출
document.getElementById('change').addEventListener('click', function () {
    event.preventDefault();
    let signupConfirm = confirm("등록된 정보로 수정하시겠습니까?");
    if(signupConfirm){
    	document.getElementById('joinForm').submit();  
    }
    });
	
    const joinForm = document.querySelector('.joinform');
    const pwInp = document.querySelector('#password');
    const nameInp = document.querySelector('#nickname');
    const emailInp = document.querySelector('#email');
    const changeBtn = document.querySelector('#change');
    const checkImg = document.querySelector('#logo');
    const template = document.querySelector('#checkImg');
    
    joinForm.onchange = check;
    check();
 // MutationObserver 설정
    const observer = new MutationObserver((mutations) => {
        mutations.forEach(mutation => {
            check();
        });
    });

    // 관찰할 대상과 설정
    observer.observe(joinForm, { attributes: true });

    function check() {
    	if(nameInp.value == '' || emailInp.value == ''){
    		changeBtn.setAttribute('class', "btn-white");
    		changeBtn.classList.add('nonClick')
    		changeBtn.style.pointerEvents = 'none';
    		changeBtn.querySelector('#logo').remove();
    	} else {
    		changeBtn.setAttribute('class', "btn-sky");
    		changeBtn.classList.remove('nonClick');
    		changeBtn.style.pointerEvents = 'auto';
    		if(!document.querySelector('.btns img')){
	    		let clone =document.importNode(template.content, true);
	    		changeBtn.prepend(clone);    			
    		}
    	}
    }
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>
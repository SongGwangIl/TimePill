<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<sec:csrfMetaTags/>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>JOIN</title>
	
	<!-- jQuery 3.7.1-->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<!-- Gmarket SANS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css"
	    type="text/css" />
	<!-- NotoSans KR-->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	    rel="stylesheet">
	<!-- jQuery UI -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.0/themes/base/jquery-ui.css">
	    
	<!-- 기본 템플릿 CSS -->
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/joinform.css">

</head>

<body>

 <div id="backcontainer" class="boxv">
    <div id="contents" class="bgimg">

        <!-- 약병 그림 -->
        <div class="main-ico">
        </div>

        <!-- 타이틀 -->
        <div class="boxh titlebox">
            <img src="/resources/img/logo.svg" class="logo">
            <h1 class="gsansdown title">TimePill</h1>
        </div>
        <div>
            <h1 class="jointitle txa"> 회원 가입 </h1>
        </div>

        <div>
            <form:form id="joinForm" action="/user/singup" modelAttribute="userVO" method="post">

                <table class="joinform">
                    <tr>
                        <td>아이디</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input password">
                                <form:input type="text" class="form-input" path="userId" id="userId" placeholder="4-15자리 영문과 숫자로 입력" minlength="4" maxlength="15" required="required"/>
                                <p id="idCheck" class="checkText"></p>
           						<form:errors path="userId"  class="checkText"></form:errors>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>비밀번호</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input password">
                                <form:input type="password" class="form-input pwd" path="password" id="password" placeholder="10-20자리 영문, 숫자, 특수문자 포함" required="required"/>
                                <img class="eye" src="/resources/img/eye.png"></img>
                                <p id="userPwdMsg"></p>
           						<form:errors path="password"></form:errors>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>비밀번호 확인</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="password" class="form-input" placeholder="비밀번호를 다시 입력해주세요." id="checkUserPwd" required="required"/>
                            <p id="checkUserPwdMsg"></p>
                        </td> 
                    </tr>
                    <tr>
                        <td>이름</td>
                    </tr>
                    <tr>
                        <td>
                            <form:input type="text" class="form-input" placeholder="이름을 입력해주세요." path="nickname" id="nickname" required="required"/>
                        </td>
                    </tr>
                    <tr>
                        <td>이메일</td>
                    </tr>
                    <tr>
                        <td>
                            <form:input type="email" class="form-input" path="email" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required="required"/>
                            <form:errors path="email"></form:errors>
                        </td>
                    </tr>
                </table>
                <sec:csrfInput /> 
            </form:form>
        </div>

        <div class="btns boxv genbtn">
            <a href="#" class="btn-white" id="signup">
                <p class="btndesc"> 가입하기 </p>
            </a>
            <a href="#" class="btn-white">
                <p class="btndesc"> 돌아가기 </p>
            </a>
        </div>
    </div>
</div>

<script>
    // eye 이미지 클릭 시 패스워드 필드 토글
    document.querySelector('.eye').addEventListener('click', function() {
        const pwdfiled = document.querySelector('.pwd');
        const type = pwdfiled.getAttribute('type');
        
        if (type === 'password') {
            pwdfiled.setAttribute('type', 'text');
            this.src = '/resources/img/eyeno.png';
        } else {
            pwdfiled.setAttribute('type', 'password');
            this.src = '/resources/img/eye.png';
        }
    });

    // '가입하기' 버튼 클릭 시 form 제출
    document.getElementById('signup').addEventListener('click', 
        function (event) {
            event.preventDefault();
            let signupConfirm = confirm("등록된 정보로 가입하시겠습니까?");
            if(signupConfirm)
            	document.getElementById('joinForm').submit();
            	
    });
    
    const joinForm = document.querySelector('.joinform');
    const idInp = document.querySelector('#userId');
    const checkP = document.querySelector('#idCheck');
    const pwInp = document.querySelector('#password');
    const nameInp = document.querySelector('#nickname');
    const emailInp = document.querySelector('#email');
    const signupBtn = document.querySelector('#signup');
    
    joinForm.onchange = check;
    
 // MutationObserver 설정
    const observer = new MutationObserver((mutations) => {
        mutations.forEach(mutation => {
            check();
        });
    });

    // 관찰할 대상과 설정
    observer.observe(checkP, { attributes: true });

    function check() {
    	if(idInp.value == '' || pwInp.value == '' || nameInp.value == '' || emailInp.value == '' || checkP.getAttribute('check') === 'false'){
    		signupBtn.setAttribute('class', "btn-white");
    		signupBtn.style.pointerEvents = 'none';
    	} else {
    		signupBtn.setAttribute('class', "btn-sky");
    		signupBtn.style.pointerEvents = 'auto';
    	}
    }
    
</script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"></script>
<script src="/resources/js/user/frontValidation.js"></script>

</body>
</html>
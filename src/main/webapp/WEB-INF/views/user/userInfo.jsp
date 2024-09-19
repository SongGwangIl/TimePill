<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/jquery-ui.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 
	<div id="wrap-from"> 
	  
		<h1 class="subTitle">사용자 정보 입력</h1>
		<form:form id="form" modelAttribute="myInfo" method="post">
			<input type="hidden" name="userId" value="${myInfo.userId}">
			<ul>
				<li class="c1">
					<label class="label">이름</label> 
					<form:input path="userName" class="input"/>					
				</li>
				
				<li class="c1">
					<label class="label">전화번호</label> 
					<form:input path="userPhone" class="input" placeholder="-를 제외한 숫자만 입력"/>
				</li>
				<li class="c1">
                	<label class="label">이메일</label>
                	<input type="email" name="email" value="${myInfo.email}" class="input" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required><br>
				</li>
   				   				
				<li class="c1">
					<label class="label">성별</label>
					<div class="gender">
						<form:radiobutton id="male" path="userGender" value="M"/>
						<label for="male" class="hover">남성</label> 
						<form:radiobutton id="female" path="userGender" value="F"/>
						<label for="female" class="hover">여성</label>
					</div>
				</li> 
   
				<li class="c1"> 
					<label class="label">키</label> 
					<form:input type="number" path="userHeight" class="input"/>
				</li>
				
				<li class="c1">
					<label class="label">몸무게</label> 
					<form:input type="number" path="userWeight" class="input"/>
				</li>
				 
				<li class="c1">
	                <div id="birth">
	                    <label for="yy" class="label">생년월일</label>
 
	                    <div id="bir_wrap">		                
	                        <div id="bir_yy">
	                            <span class="box">
	                                <form:input type="text" id="yy"  path="yy" class="int" maxlength="4" placeholder="년(4자)"/>
	                            </span>
	                        </div>		                        
	                      
	                        <div id="bir_mm">
	                            <span class="box">
	                            	<form:select path="mm" id="mm">		                            		
	                                    <form:option value="00" label="월"/>
	                                    <form:option value="01" label="1"/>
	                                    <form:option value="02" label="2"/>
	                                    <form:option value="03" label="3"/>
	                                    <form:option value="04" label="4"/>
	                                    <form:option value="05" label="5"/>
	                                    <form:option value="06" label="6"/>
	                                    <form:option value="07" label="7"/>
	                                    <form:option value="08" label="8"/>
	                                    <form:option value="09" label="9"/>
	                                    <form:option value="10" label="10"/>
	                                    <form:option value="11" label="11"/>
	                                    <form:option value="12" label="12"/>		                                    
	                            	</form:select>		                            		
	                            </span>
	                        </div>
	                        <div id="bir_dd">
	                            <span class="box">
	                                <form:input type="text" id="dd" path="dd" class="int" maxlength="2" placeholder="일"/>
	                            </span>
	                        </div>
	                    </div>		                    
	                </div>
	        	</li>   				
			</ul>
			<ul id="buttons">			
				<li>
					<form:button id="update" class="btn">수정</form:button>
				</li>				
				<li>
					<form:button class="btn" type="button" onclick="location.href='/main'">취소</form:button>
				</li>				
			</ul>
		</form:form>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-ui.min.js"></script>
<script>
	$(document).ready(function(){
		let form = $("#form")
		//정보변경
		$("#update").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
			form.action = "/myinfo/edit";
			form.submit();			
		});
		
	});
		function autoEmail(a,b){
			  
			  const mailId = b.split('@'); // 메일계정의 ID만 받아와서 처리하기 위함
			  const mailList = ['naver.com','gmail.com','daum.net','hanmail.net','yahoo.com','outlook.com','nate.com','kakao.com']; // 메일목록
			  let availableCity = new Array; // 자동완성 키워드 리스트
			  
			  if(b.includes("@")){  

			    for(let i=0; i < mailList.length; i++ ){
			      availableCity.push( mailId[0] +'@'+ mailList[i] ); // 입력되는 텍스트와 메일목록을 조합
			    }
			    $("#"+a).autocomplete({
			      source: availableCity // jQuery 자동완성에 목록을 넣어줌
			    });
			  }
			  else{
			    availableCity = new Array;
			    $("#"+a).autocomplete({    
			      source: availableCity      
			    });
			  }
			}
			  
			const email = document.querySelector("#email")
			const emailMsg = document.querySelector('#userPwdMsg')
			let emailVal;
			email.onchange = emailCheck 

			function emailCheck(){
			  const eamilRegExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i
			  emailVal = email.value
			  if(!eamilRegExp.test(emailVal)) { // 정규식 조건 만족 X
			    email.value = null;
			    email.focus();    
			  }
			}
</script>
</body>
</html>
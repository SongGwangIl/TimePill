<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 
	<div id="wrap"> 
	  
		<h1 class="title">사용자 정보 입력</h1>
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
</script>
</body>
</html>
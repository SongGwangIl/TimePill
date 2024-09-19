<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 
	<div id="wrap"> 
	  
		<h1 class="subTitle">사용자 정보 입력</h1>
		<form id="form" action="/addUserInfo" method="post">
			<input type="hidden" name="userId" value="${loginUser.userId}">
			<ul class="box">
				<li class="c1">
					<label class="label">이름</label> 
					<input name="userName" class="input"/>					
				</li>
				
				<li class="c1">
					<label class="label">전화번호</label> 
					<input name="userPhone" class="input" placeholder="-를 제외한 숫자만 입력"/>
				</li>
   				 
   							
				<li class="c1">
					<label class="label">성별</label>
					<div class="gender">
						<input type="radio" id="male" name="userGender" value="M">
						<label for="male" class="hover">남성</label> 
						<input type="radio" id="female" name="userGender" value="F">
						<label for="female" class="hover">여성</label>
					</div>
				</li> 
   
				<li class="c1"> 
					<label class="label">키</label> 
					<input type="number" name="userHeight" class="input"/>
				</li>
				
				<li class="c1">
					<label class="label">몸무게</label> 
					<input type="number" name="userWeight" class="input"/>
				</li>
				 
				<li class="c1">
	                <div id="birth">
	                    <label for="yy" class="label">생년월일</label>
 
	                    <div id="bir_wrap">		                
	                        <div id="bir_yy">
	                            <span class="box">
	                                <input type="text" id="yy"  name="yy" class="int" maxlength="4" placeholder="년(4자)"/>
	                            </span>
	                        </div>		                        
	                      
	                        <div id="bir_mm">
	                            <span class="box">
	                            	<select name="mm" id="mm">		                            		
	                                    <option label="월"/>
	                                    <option value="01" label="1"/>
	                                    <option value="02" label="2"/>
	                                    <option value="03" label="3"/>
	                                    <option value="04" label="4"/>
	                                    <option value="05" label="5"/>
	                                    <option value="06" label="6"/>
	                                    <option value="07" label="7"/>
	                                    <option value="08" label="8"/>
	                                    <option value="09" label="9"/>
	                                    <option value="10" label="10"/>
	                                    <option value="11" label="11"/>
	                                    <option value="12" label="12"/>		                                    
	                            	</select>		                            		
	                            </span>
	                        </div>
	                        <div id="bir_dd">
	                            <span class="box">
	                                <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일"/>
	                            </span>
	                        </div>
	                    </div>		                    
	                </div>
	        	</li>   				
			</ul>
			<ul id="buttons">			
				<li>
					<button id="add" class="btn">등록</button>
				</li>				
				<li>
					<button class="btn" type="button" onclick="location.href='/main'">다음에 등록</button>
				</li>				
			</ul>
			
		</form>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("#add").click(function(){
			if(!confirm("등록하시겠습니까?")){
				
				return false;
			}
			$("#form").submit();			
		});
	});
</script>
</body>
</html>
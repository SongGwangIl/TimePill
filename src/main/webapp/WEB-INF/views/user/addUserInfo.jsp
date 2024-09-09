<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	 
	<div id="wrap"> 
	  
		<h1 class="title">사용자 정보 입력</h1>
		
		<form action="${pageContext.request.contextPath}/addUserInfo" method="post">
			<input type="hidden" name="userId" value="${loginUser.userId}">
			 
			<br>
			  
			<ul>
				<li class="c1">
					<label class="label">이름</label> 
					<input type="text" name="userName" class="input" required>
					<br><br>
				</li>
				
				<li class="c1">
					<label class="label">전화번호</label> 
					<input type="text" name="userPhone" class="input" placeholder="-를 제외한 숫자만 입력"><br><br>
				</li>
   
   				<c:if test="${loginUser.userCarerAt eq 'N'}">   				
					<li class="c1">
						<label class="label">성별</label>
						<div class="gender">
							<input type="radio" id="male" name="userGender" value="m">
							<label for="male" class="hover">남성</label> 
							<input type="radio" id="female" name="userGender" value="fm" checked>
							<label for="female" class="hover">여성</label>
						</div><br><br>
					</li> 
	   
					<li class="c1"> 
						<label class="label">키</label> 
						<input type="number" name="userHeight" class="input"><br><br>
					</li>
					
					<li class="c1">
						<label class="label">몸무게</label> 
						<input type="number" name="userWeight" class="input"><br><br>
					</li>
					 
					<li class="c1">
						<!-- BIRTH -->
		                <div id="birth">
		                    <label for="yy" class="label">생년월일</label>
	 
		                    <div id="bir_wrap">  
	
	
		                        <!-- BIRTH_YY -->
		                        <div id="bir_yy">
		                            <span class="box">
		                                <input type="text" id="yy"  name="yy" class="int" maxlength="4" placeholder="년(4자)">
		                            </span>
		                        </div>
		                        
		                        
		                        <!-- BIRTH_MM -->
		                        <div id="bir_mm">
		                            <span class="box">
		                                <select id="mm" name="mm">
		                                    <option>월</option>
		                                    <option value="01">1</option>
		                                    <option value="02">2</option>
		                                    <option value="03">3</option>
		                                    <option value="04">4</option>
		                                    <option value="05">5</option>
		                                    <option value="06">6</option>
		                                    <option value="07">7</option>
		                                    <option value="08">8</option>
		                                    <option value="09">9</option>                                    
		                                    <option value="10">10</option>
		                                    <option value="11">11</option>
		                                    <option value="12">12</option>
		                                </select>
		                            </span>
		                        </div>
	
	
		                        <!-- BIRTH_DD -->
		                        <div id="bir_dd">
		                            <span class="box">
		                                <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일">
		                            </span>
		                        </div>
		                    </div>
		                    
		                    <span class="error_next_box"></span>    
		                    
		                </div>
		        	</li>
	        	</c:if>
			</ul>
			
			<ul id="buttons">
			
				<li>
					<button class="btn" type="submit" onclick="location.href='device'">등록</button>
				</li>
				
				<li>
					<button class="btn" type="button" onclick="location.href='device'">다음에 입력</button> <br>
				</li>
				
			</ul>
			 
		</form>
	</div>
</body>
</html>
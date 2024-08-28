<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- header -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>



	<!-- 검색 -->
		<div>
			유저 타입 : ${userSelect eq 'user' ? '사용자' : '보호자'} 
		</div>
		
		<div>
			<!-- 사용자 -->
			<c:if test="${userSelect eq 'user'}">
				<jsp:include page="/WEB-INF/views/member/user.jsp"/>
			</c:if>

			<!-- 보호자 -->
			<c:if test="${userSelect eq 'protector'}">
				<jsp:include page="/WEB-INF/views/member/protector.jsp"/>
			</c:if>
		</div>



	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>

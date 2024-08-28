<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${userInfoSelect.userProId eq 'F'}">
		보호자에게 관계 신청을 요청해보세요! 
	</c:when>
	<c:otherwise>
		<br> 신청한 보호자 아이디 : ${userInfoSelect.userProId}
		<br> 신청한 보호자 이름 : ${userInfoSelect.protName}
		<br> 승낙 여부 : ${userInfoSelect.userProRegist}
		
		<c:if test="${userProRegist eq 'F'}">

			<form action="${pageContext.request.contextPath}/member/choice" method="post">
				<input type="hidden" name="choice" value="T"><button>승낙</button>
			</form>
			<form action="${pageContext.request.contextPath}/member/choice" method="post">
				<input type="hidden" name="choice" value="F"><button>거절</button>
			</form>
		
		</c:if>
	</c:otherwise>
</c:choose>











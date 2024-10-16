<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/footer.css">

		<!-- 푸터 : nav -->
        <nav id="mainmenu" class="">
            <ul class="menu">
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/">
					     <img id="logo" src="/resources/img/sched.png" style="width: 50px;">
					    	<br><span class="footer-menu">스케줄</span>
					     </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/medication">
					     <img id="logo" src="/resources/img/medmng.png" style="width: 50px;">
					    	<br><span class="footer-menu">복약관리</span>
					    </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/mypage">
					    	<img id="logo" src="/resources/img/myinfo.png" style="width: 50px;">
					    	<br><span class="footer-menu">내 정보</span>
					     </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/notice">
					     <img id="logo" src="/resources/img/notice.png" style="width: 50px;">
					     <br><span class="footer-menu">공지사항</span>
					    </a>
					</div>
                </li>
            </ul>
        </nav>
    </div>
</body>

</html>

<script>
<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>

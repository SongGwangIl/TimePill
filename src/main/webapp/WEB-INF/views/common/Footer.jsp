<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/footer.css">

		<!-- 푸터 : nav -->
        <nav id="mainmenu" class="">
            <ul class="menu">
                <li>
                    <a href="#">
                        <div class="boxv">
                            <a href="/">
	                            <img id="logo" src="/resources/img/sched.png" style="width: 50px;">
                            	<br>스케줄
                             </a>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <div class="boxv">
                            <a href="/medication">
	                            <img id="logo" src="/resources/img/medmng.png" style="width: 50px;">
                            	<br>복약관리
                            </a>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <div class="boxv">
                            <a href="/mypage">
                            	<img id="logo" src="/resources/img/myinfo.png" style="width: 50px;">
                            	<br>내 정보
                             </a>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <div class="boxv">
                            <a href="/notice">
	                            <img id="logo" src="/resources/img/notice.png" style="width: 50px;">
	                            <br>공지사항
                            </a>
                        </div>
                    </a>
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

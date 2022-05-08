<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>reservation</title>

    <fmt:setLocale value="${sessionScope.locale}"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <fmt:message bundle="${loc}" key="reservation.lable" var="lable"/>
    <fmt:message bundle="${loc}" key="reservation.lable.reservation" var="reservation"/>
    <fmt:message bundle="${loc}" key="reservation.lable.phone" var="phone"/>
    <fmt:message bundle="${loc}" key="reservation.lable.timework" var="timework"/>
    <fmt:message bundle="${loc}" key="reservation.lable.schedule" var="schedule"/>
    <fmt:message bundle="${loc}" key="reservation.lable.location" var="location"/>

</head>
<body class="animsition">
<jsp:include page="part/header.jsp"/>

<!-- Title Page -->
<section class="bg-title-page flex-c-m p-t-160 p-b-80 p-l-15 p-r-15" style="background-image: url(${pageContext.request.contextPath}/static/img/bg-title-page-02.jpg);">
    <h2 class="tit6 t-center">
        ${lable}
    </h2>
</section>

<section class="bg2-pattern p-t-116 p-b-110 t-center p-l-15 p-r-15">
		<span class="tit2 t-center">
			${reservation}
            <p></p><p></p>
            ${phone}
            <p></p><p></p>
            ${timework}
            <p></p><p></p>
            ${schedule}
            <p></p><p></p>
            ${location}
            <p></p><p></p>
		</span>

</section>

<jsp:include page="part/footer.jsp"/>
</body>
</html>
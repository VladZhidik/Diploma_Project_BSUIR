<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>orders</title>

    <fmt:setLocale value="${sessionScope.locale}"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <fmt:message bundle="${loc}" key="userorder.lable" var="userorder"/>
    <fmt:message bundle="${loc}" key="currency.byn" var="byn"/>
    <fmt:message bundle="${loc}" key="main.lable.feedback" var="feedback"/>
    <fmt:message bundle="${loc}" key="main.lable.userfeedback" var="userFeedback"/>
    <fmt:message bundle="${loc}" key="userorders.lable.username" var="name"/>
    <fmt:message bundle="${loc}" key="feedback.lable.enteryourfeedback" var="enterYourFeedback"/>
    <fmt:message bundle="${loc}" key="feedback.lable.leftfeedback" var="leftFeedback"/>

</head>
<body>
<jsp:include page="part/header.jsp"/>

<!-- Title Page -->
<section class="bg-title-page flex-c-m p-t-160 p-b-80 p-l-15 p-r-15"
         style="background-image: url(${pageContext.request.contextPath}/static/img/bg-title-page-02.jpg);">
    <h2 class="tit6 t-center">
        ${feedback}
    </h2>
</section>

<section class="section-lunch bgwhite">
    <div class="container">

        <div class="row p-t-108 p-b-70">

            <div class="col-md-8 col-lg-6 m-l-r-auto">

                <form action="Controller" method="post">
                    <p><b>${enterYourFeedback}</b></p>
                    <p><textarea name="comment" cols="50"></textarea></p>
                    <p><br>
                        <button type="submit" class="btn3 flex-c-m size13 txt11 trans-0-4" name="command"
                                value="leftFeedback">
                            ${leftFeedback}
                        </button>
                    </p>
                </form>

                <c:forEach items="${requestScope.users}" var="user">
                    <c:if test="${user.feedback.trim().length() > 1}">
                        <hr><hr>
                        <div class="user-info">
                            <div class="avatar-info">
                                <div class="avatar-container">
                                    <img class="avatar-image"
                                         src="${pageContext.request.contextPath}/static/avatars/${user.avatarPath}"/>
                                </div>
                                <div>
                                <span class="txt22 m-t-20">
                                    <u style="color: #cf2227">${name}:</u>  ${user.name}<br/>
                                </span>
                                    <br>
                                    <span class="txt22 m-t-20">
                                        <u style="color: #cf2227">${userFeedback}:</u>  ${user.feedback}<br/>
                                </span>
                                </div>
                            </div>
                        </div>
                        <br>
                    </c:if>
                </c:forEach>

            </div>
        </div>
    </div>
</section>

<jsp:include page="part/footer.jsp"/>
</body>
</html>

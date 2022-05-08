<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>user orders</title>

    <fmt:setLocale value="${sessionScope.locale}" />
    <fmt:setBundle basename="locale" var="loc" />
    <fmt:message bundle="${loc}" key="userorders.lable" var="userorders"/>
    <fmt:message bundle="${loc}" key="userorders.lable.userid" var="userid"/>
    <fmt:message bundle="${loc}" key="userorders.lable.username" var="userName"/>
    <fmt:message bundle="${loc}" key="userorders.lable.time" var="time"/>
    <fmt:message bundle="${loc}" key="userorders.lable.dishes" var="dishes"/>
    <fmt:message bundle="${loc}" key="userorders.lable.price" var="price"/>
    <fmt:message bundle="${loc}" key="currency.byn" var="byn"/>
    <fmt:message bundle="${loc}" key="userorders.button.downloadOrders" var="downloadOrders"/>
    <fmt:message bundle="${loc}" key="userorders.lable.averageCheck" var="averageCheck"/>
</head>
<body>
<jsp:include page="../part/header.jsp"/>

<!-- Title Page -->
<section class="bg-title-page flex-c-m p-t-160 p-b-80 p-l-15 p-r-15"
         style="background-image: url(${pageContext.request.contextPath}/static/img/bg-title-page-02.jpg);">
    <h2 class="tit6 t-center">
        ${userorders}
    </h2>
</section>

<section class="section-lunch bgwhite">
    <div class="container">
        <div class="row p-t-108 p-b-70">

                <table style="width: 100%">
                    <tr>
                        <td>${userid}</td>
                        <td>${time}</td>
                        <td>${userName}</td>
                        <td>${dishes}</td>
                        <td>${price}</td>
                    </tr>

                    <c:forEach items="${requestScope.orders}" var="orders">
                        <c:if test="${orders.status eq 'PAID'}">
                                <tr>
                                    <td>${orders.userId}</td>
                            <td>${orders.time}</td>
                            <td>
                            <c:forEach items="${orders.dishes}" var="dish">
                                ${dish.title} - ${dish.price} ${byn} <br/>
                            </c:forEach>
                            </td>
                            <td>${orders.totalPrice} ${byn}</td>

                    </tr><br/>
                        </c:if>

                    </c:forEach>

                </table>
        </div>
        <hr><hr>
        <button>
            <a href="Controller?command=downloadOrders" class="btn1 flex-c-m size1 txt3 trans-0-4">
                ${downloadOrders}
            </a>
        </button>
        <hr><hr><hr>
        <p>
            ${averageCheck}: ${requestScope.averageCheck}
        </p>
        <hr><hr><hr>
    </div>

</section>

<jsp:include page="../part/footer.jsp"/>
</body>
</html>

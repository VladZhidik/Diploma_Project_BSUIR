<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dish Of the Day</title>

    <fmt:setLocale value="${sessionScope.locale}"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <fmt:message bundle="${loc}" key="menu.lable" var="lable"/>
    <fmt:message bundle="${loc}" key="menu.search" var="search"/>
    <fmt:message bundle="${loc}" key="menu.sorting" var="sorting"/>
    <fmt:message bundle="${loc}" key="menu.alphabetically" var="alphabetically"/>
    <fmt:message bundle="${loc}" key="menu.price" var="price"/>
    <fmt:message bundle="${loc}" key="makeorder.lable.calorieContent" var="calorieContent"/>
    <fmt:message bundle="${loc}" key="currency.byn" var="byn"/>
    <fmt:message bundle="${loc}" key="menu.notavailable" var="notavailable"/>
    <fmt:message bundle="${loc}" key="menu.update" var="update"/>
    <fmt:message bundle="${loc}" key="menu.delete" var="delete"/>
    <fmt:message bundle="${loc}" key="menu.toorder" var="toorder"/>

</head>
<body>
<jsp:include page="part/header.jsp"/>

<!-- Title Page -->
<section class="bg-title-page flex-c-m p-t-160 p-b-80 p-l-15 p-r-15"
         style="background-image: url(${pageContext.request.contextPath}/static/img/bg-title-page-01.jpg);">
    <h2 class="tit6 t-center">
        ${lable}
    </h2>
</section>


<section class="section-lunch bgwhite">
    <div class="container">

        <c:if test="${sessionScope.userRole != 'ADMIN'}">
            <div class="row p-t-60 p-b-70">
                <div class="col-md-8 col-lg-6 m-l-r-auto">

                    <br><br>
                    <section class="bg2-pattern p-t-116 p-b-110 t-center p-l-15 p-r-15">
		        <span class="tit2 t-center">
                  <fmt:message bundle="${loc}" key="menu.button.dishoftheday"/>
                 </span>
                    </section>
                    <br><br>

                    <c:forEach items="${requestScope.dishes}" var="dishes">
                        <c:if test="${dishes.available == true}">
                            <form id="addToOrder" action="Controller" method="post">
                                <input type="hidden" name="command" value="addToOrder"/>
                            </form>
                            <!-- Block3 -->
                            <div class="blo3 flex-w flex-col-l-sm m-b-30">
                                <div class="pic-blo3 size20 bo-rad-10 hov-img-zoom m-r-28">
                                    <a href="#"><img src="${pageContext.request.contextPath}${dishes.picturePath}"
                                                     alt="IMG-MENU"></a>
                                </div>
                                <div class="text-blo3 size21 flex-col-l-m">
                                    <a href="#" class="txt21 m-b-3">
                                            ${dishes.title}
                                    </a>

                                    <span class="txt23">
                                    ${dishes.description}<br/>
                                    ${calorieContent} ${dishes.calorieContent}
							    </span>

                                    <span class="txt22 m-t-20">
                                    ${dishes.price} ${byn}
							    </span>
                                    <span>
                                    <c:if test="${sessionScope.userRole == 'USER'}">
                                        <button form="addToOrder" class="btn btn-success delete2" type="submit"
                                                value="${dishes.id}" name="dishId">${toorder}</button>
                                    </c:if>
                                </span>
                                </div>

                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</section>

</body>
</html>

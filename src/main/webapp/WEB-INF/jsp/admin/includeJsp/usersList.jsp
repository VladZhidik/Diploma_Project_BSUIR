<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User List</title>
    <fmt:setLocale value="${sessionScope.locale}"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <fmt:message bundle="${loc}" key="userlist.lable" var="userList"/>
</head>
<jsp:include page="../../part/header.jsp"/>

<!-- Title Page -->
<section class="bg-title-page flex-c-m p-t-160 p-b-80 p-l-15 p-r-15"
         style="background-image: url(${pageContext.request.contextPath}/static/img/bg-title-page-02.jpg);">
    <h2 class="tit6 t-center">
        ${userList}
    </h2>

</section>
<br/><br/>
<section class="section-lunch bgwhite">
    <div class="container">
        <c:if test="${not empty requestScope.users}">
            <c:forEach var="user" items="${requestScope.users}">
                <c:if test="${sessionScope.userEmail != user.email}">
                    <div class="admin-list-item">
                        <p>
                            <fmt:message bundle="${loc}" key="userlist.lable.activeuser"/>
                        </p>
                        <div class="header admin-item-header">${user.email}</div>
                        <div class="admin-item-options">
                            <c:choose>
                                <c:when test="${user.role eq 'ADMIN'}">
                                    <form id="banadmin" action="Controller" method="post">
                                        <input type="hidden" name="command" value="banadmin"/>
                                    </form>
                                    <button form="banadmin" class="btn btn-success delete2" type="submit"
                                            value="${user.email}" name="login">
                                        <fmt:message bundle="${loc}" key="userlist.lable.banadmin"/>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <form id="appointadmin" action="Controller" method="post">
                                        <input type="hidden" name="command" value="appointadmin"/>
                                    </form>
                                    <button form="appointadmin" class="btn btn-success delete2" type="submit"
                                            value="${user.email}" name="login">
                                        <fmt:message bundle="${loc}" key="userlist.lable.appointadmin"/>
                                    </button>
                                    <form id="banuser" action="Controller" method="post">
                                        <input type="hidden" name="command" value="banuser"/>
                                    </form>
                                    <button form="banuser" class="btn btn-success delete2" type="submit"
                                            value="${user.email}" name="login">
                                        <fmt:message bundle="${loc}" key="userlist.lable.banuser"/>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</section>
<jsp:include page="../../part/footer.jsp"/>
</body>
</html>
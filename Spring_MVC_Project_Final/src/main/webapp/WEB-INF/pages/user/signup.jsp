<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sign Up Page</title>
        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />

        <jsp:include  page="include/css.jsp"/>
    </head>
    <body>
        <jsp:include page="include/menuheader.jsp"/>

        <!-- BREADCRUMB -->
        <div id="breadcrumb" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="breadcrumb-header">Sign Up</h3>
                        <ul class="breadcrumb-tree">
                            <li><a href="<c:url value="/home" />">Home</a></li>
                            <li class="active">Sign Up</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->
        <!-- NEWSLETTER -->
        <c:if test="${message != null && message != ''}">
            <c:if test="${type != null && type != '' && type == 'fail'}">
                <div class="alert alert-danger">${message}</div>
            </c:if>
            <c:if test="${type != null && type != '' && type == 'success'}">
                <div class="alert alert-success">${message}</div>
            </c:if>
        </c:if>
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <mvc:form action="${pageContext.request.contextPath}/signup" modelAttribute="signup" method="POST">
                    <div  class="caption">
                        <p>Enter Customer Info</p>
                        <div class="form-group">
                            <input class="input" type="text" name="fullName" placeholder="Enter your name" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="email" name="email" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <input class="input" id="password" type="password" name="password" placeholder="password" minlength="8" required>
                        </div>
                        <div class="form-group">
                            <input class="input" id="confirm_password" type="password" name="confirm_password" placeholder="Confirm password" > <span id='messagePass'></span>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="address" placeholder="Address" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="date" name="birthDate" placeholder="Birthday" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="phoneNumber" placeholder="Phone Number" required>
                        </div>
                        <c:forEach var="role" items="${roles}">
                            <div class="col-lg-6">
                                <c:if test="${role.getRole() == 'ROLE_USER'}">
                                    <div class="checkbox">
                                        <label hidden="">
                                            <input type="checkbox" checked="true" name="role" value="${role.id}" hidden="true">
                                            ${role.getRole()}
                                        </label>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
<!--<button  onclick="window.location.href = '<c:url value="/payment"/> '">Payment on cash</button>-->
                        <input  name="delivery" type="submit"  style="width: 100%" class="primary-btn order-submit" value="Sign Up"/>
                    </div>
                </mvc:form>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /NEWSLETTER -->

        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>
        <script>
            $('#password, #confirm_password').on('keyup', function () {
                if ($('#password').val() == $('#confirm_password').val()) {
                    $('#messagePass').html('Matching').css('color', 'green');
                } else
                    $('#messagePass').html('Not Matching').css('color', 'red');
            });
        </script>

    </body>
</html>

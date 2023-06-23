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
        <title>Account Page</title>
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
                        <h3 class="breadcrumb-header">Account</h3>
                        <ul class="breadcrumb-tree">
                            <li><a href="<c:url value="/home" />">Home</a></li>
                            <li class="active">Account</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->
        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <mvc:form action="${pageContext.request.contextPath}/result" method="post"
                          modelAttribute="userEntity">
                    <div  class="caption">
                        <p>Update Customer Info: ${userEntity.email}</p>
                        <div class="form-group">
                            <input class="input" type="text" name="fullName" placeholder="your name"  value="${userEntity.fullName}" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="address" placeholder="Address" value="${userEntity.address}" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="date" name="birthDate" placeholder="Birthday" value="${userEntity.birthDate}" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="phoneNumber" placeholder="Phone Number" value="${userEntity.phoneNumber}" required>
                        </div>
                        <div class="form-group">
                            <input  class="input"  type="hidden" name="email"  value="${userEntity.email}">
                        </div>
                        <div class="form-group">
                            <input  class="input"  type="hidden" name="uuid"  value="${userEntity.uuid}">
                        </div>
                        <div class="form-group">
                            <input  class="input"type="hidden" name="status"  value="${userEntity.status}">
                        </div>
                        <div class="form-group">
                            <input  class="input" id="password" type="hidden" name="password" placeholder="password" value="${userEntity.password}" required>
                        </div>
                        <c:if test="${action == 'update'}">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="${userEntity.id}" name="id">
                            <button style="width: 100%" class="primary-btn order-submit" type="submit">
                                Update Account     
                            </button>
                        </c:if>
                    </div>
                </mvc:form>
                <!-- /row -->
                <div class="row">
                    <a href="http://localhost:8080/Spring_MVC_Project_Final/change-password/${userEntity.getUuid()}">Change password</a>
                </div>
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

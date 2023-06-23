<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
        <jsp:include page="admin/include/css.jsp" />
        <link rel="stylesheet" href="<c:url value="/resources-management/style.css"/>">
    </head>
    <body>
        <div class="color-line"></div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12"></div>
                <div class="col-md-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="text-center m-b-md custom-login">
                        <h3 style="margin-top: 50px;">CHANGE PASSWORD</h3>
                    </div>
                    <div class="hpanel">
                        <div class="panel-body">
                            <mvc:form action="${pageContext.request.contextPath}/change-password" id="loginForm" modelAttribute="userEntity">
                                <div class="form-group">
                                    <label class="control-label" for="username">Username</label>
                                    <input type="text" style="background-color: #152036" title="Please enter you username" required="" 
                                           value="${userEntity.email}" name="email" id="username" class="form-control" readonly="">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="password">Password</label>
                                    <input type="password" title="Please enter your password" placeholder="******" required="" name="password" id="password" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="password">Confirm Password</label>
                                    <input type="password" title="Please enter your password" 
                                           placeholder="******" required="" name="confirm_password" id="confirm_password" class="form-control"><span id='messagePass'></span>
                                </div>
                                <input type="text" value="${userEntity.id}" name="id" hidden="">
                                <input type="text" value="${userEntity.fullName}" name="fullName" hidden="">
                                <input type="text" value="${userEntity.uuid}" name="uuid" hidden="">
                                <div class="form-group">
                                    <input class="input" type="text" name="address" placeholder="Address" value="${userEntity.address}" hidden>
                                </div>
                                <div class="form-group">
                                    <input class="input" type="date" name="birthDate" placeholder="Birthday" value="${userEntity.birthDate}" hidden>
                                </div>
                                <div class="form-group">
                                    <input class="input" type="text" name="phoneNumber" placeholder="Phone Number" value="${userEntity.phoneNumber}" hidden>
                                </div>
                                <c:forEach var="role" items="${roles}">
                                    <% String check = ""; %>
                                    <c:forEach items="${userEntity.getUserRoles()}" var="roleUser"> 
                                        <c:if test="${roleUser.id == role.id}">
                                            <% check = "checked";%>
                                        </c:if>
                                    </c:forEach>
                                    <div>
                                        <div class="checkbox">
                                            <label hidden="">
                                                <input type="checkbox" <%=check%> name="role" value="${role.id}" hidden="true">
                                                ${role.getRole()}
                                            </label>
                                        </div>
                                    </div>     
                                </c:forEach>
                                <button type="submit" class="btn btn-success btn-block loginbtn">Submit</button>
                            </mvc:form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12"></div>
            </div>
        </div>
        <jsp:include page="admin/include/js_management.jsp" />
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

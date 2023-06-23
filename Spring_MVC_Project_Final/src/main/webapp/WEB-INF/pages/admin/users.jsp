<%-- 
    Document   : user-list
    Created on : Nov 19, 2020, 6:41:25 PM
    Author     : NhatHuu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users Page</title>
        <jsp:include page="include/css.jsp" />
        <link rel="stylesheet" href="<c:url value="/resources-management/style.css"/>">
        <style>
        </style>
    </head>
    <body>
        <jsp:include page="include/menu_left.jsp" />
        <div class="all-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="logo-pro">
                            <a href="#"><img class="main-logo" src="<c:url value="/resources-management/img/logo/logo.png"/>" alt="" /></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-advance-area">
                <jsp:include page="include/header_top.jsp" />
                <div class="breadcome-area">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="breadcome-list">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <div class="breadcomb-wp">
                                                <div class="breadcomb-icon">
                                                    <i class="icon nalika-home"></i>
                                                </div>
                                                <div class="breadcomb-ctn">
                                                    <h2>Manage Users</h2>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <!-- Search form -->
                                            <mvc:form action="/Spring_MVC_Project_Final/admin/search-user" method="GET" class="form-inline">
                                                <div class="form-group">
                                                    <input value="${strSearch}" type="text" name="strSearch" class="form-control" placeholder="Search..." style="width: 400px; border-radius: 10px;" required=""/>
                                                    <input type="submit" value="Search" class="btn btn-info" />
                                                </div>
                                            </mvc:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-status mg-b-30">
                <div class="container-fluid">
                    <c:if test="${message != null && message != ''}">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 10px">
                                <c:if test="${type != null && type!= '' && type == 'error'}">
                                    <div class="alert alert-danger">${message}</div>
                                </c:if>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 10px">
                                <c:if test="${type != null && type!= '' && type == 'success'}">
                                    <div class="alert alert-success">${message}</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="product-status-wrap">

                                <div style="display: flex;" > 
                                    <div class="add-user">
                                        <a href="<c:url value="/admin/add-user"/>">Add User</a>
                                    </div>
                                    <div class="add-role">
                                        <a style="margin-left: 20px" href="<c:url value="/admin/add-user-role"/>" >Add User Role</a>
                                    </div>
                                </div>
                                <table>
                                    <tr>
                                        <c:if test="${numberPages != 1}">
                                            <c:if test="${(page + 1) < numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1} - ${page*size + users.size()} of ${n} results</td></i>
                                        </c:if>
                                        <c:if test="${(page + 1) >= numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1}-${n} of ${n} results</td></i>  
                                        </c:if> 
                                    </c:if>
                                    <td colspan="7"></td>
                                    </tr>
                                    <tr>
                                        <th>Email</th>
                                        <th>Full Name</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                    </tr>
                                    <c:if test="${users != null && fn:length(users)>0}">
                                        <c:forEach items="${users}" var="user">
                                            <mvc:form action="${pageContext.request.contextPath}/admin/user/update-user"
                                                      modelAttribute="user">
                                                <tr>
                                                    <td><b>${user.email}</b></td>
                                                    <td>${user.fullName}</td>
                                                    <td>
                                                        <div id="roleCheckBox">
                                                            <c:forEach var="role" items="${roles}">
                                                                <% String check = ""; %>
                                                                <c:forEach items="${user.getUserRoles()}" var="roleUser"> 
                                                                    <c:if test="${roleUser.id == role.id}">
                                                                        <% check = "checked";%>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <div>
                                                                    <c:if test="${role.getRole() == 'ROLE_USER'}">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" checked="true" name="" value="" disabled="">
                                                                                <input type="checkbox" <%=check%> name="role" value="${role.id}" hidden="true">
                                                                                ${role.getRole()}
                                                                            </label>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${role.getRole() != 'ROLE_USER'}">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" <%=check%> name="role" value="${role.id}">
                                                                                ${role.getRole()}
                                                                            </label>
                                                                        </div>
                                                                    </c:if>
                                                                </div>     
                                                            </c:forEach>
                                                        </div>
                                                    </td>
                                                    <td style="display: flex; verticle-align: middle;" >
                                                        <select style="width: 150px" name="status" class="form-control">
                                                            <c:forEach items="${userStatus}" var="s">
                                                                <c:if test="${s == user.status}">
                                                                    <option selected="selected" value="${s}">${s}</option>
                                                                </c:if>
                                                                <c:if test="${s != user.status}">
                                                                    <option value="${s}">${s}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <input type="hidden" value="${user.id}" name="id">
                                                        <button data-toggle="tooltip" title="Update User" class="pd-setting-ed" type="submit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                    </td>
                                                </tr>
                                            </mvc:form>
                                        </c:forEach>
                                        <tr><td colspan="9"></td></tr>
                                            <c:if test="${strSearch == null}">
                                            <tr>
                                                <td colspan="1">Page ${page + 1} of ${numberPages}</td>
                                                <td colspan="3" style="text-align: center;">
                                                    <c:if test="${page <= 1 && start <= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/users/?page=${0}&start=${0}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page > 1 && start >= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/users/?page=${page - 1}&start=${start - 1}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                                        <c:if test="${i < numberPages}">
                                                            <c:if test="${page == i}">
                                                                <button id="btnN" style="color: red" class="btn btn-danger" onclick="location.href = '<c:url value="/admin/users/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${page != i}">
                                                                <button id="btnN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/users/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${page < numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/users/?page=${page + 1}&start=${start + 1}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page == numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/users/?page=${page}&start=${start}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${users == null || fn:length(users)<=0}">
                                        <tr>
                                            <td colspan="8" style="color: red">Empty List!!!</td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="include/js_management.jsp" />
    </body>
</html>

<%-- 
    Document   : product-list
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
        <title>Manage Orders Page</title>
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
                            <a href="index.html"><img class="main-logo" src="<c:url value="/resources-management/img/logo/logo.png"/>" alt="" /></a>
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
                                                    <h2>Manage Orders</h2>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <c:if test="${fromDate != null && toDate != null && orders.size() > 0}">
                                                <div class="breadcomb-report">
                                                    <button data-toggle="tooltip" data-placement="left" title="Download Report" class="btn" onclick="location.href = '<c:url value="/admin/export-file" />'"><i class="icon nalika-download"></i></button>
                                                </div>
                                            </c:if>
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
                                <div style="display: flex">
                                    <div>
                                        <!-- Search form -->
                                        <mvc:form action="/Spring_MVC_Project_Final/admin/search-order" method="GET" class="form-inline">
                                            <div class="form-group">
                                                <input type="text"  name="strSearch" class="form-control" placeholder="Enter order number..." style="width: 300px; border-radius: 10px;" value="${strSearch}" required="true"/>
                                                <input type="submit" value="Search" class="btn btn-info" />
                                            </div>
                                        </mvc:form>
                                    </div>
                                    <div style="margin-left: 300px;">
                                        <!-- Search form -->
                                        <mvc:form action="/Spring_MVC_Project_Final/admin/search-order-date" method="GET" class="form-inline" >
                                            <div class="form-group">
                                                <input type="date" id="fromDate" name="fromDate" class="form-control" value="${fromDate}" required="true"/>
                                                <input type="date" id="toDate" name="toDate" class="form-control" value="${toDate}" required="true"/>
                                                <input type="submit" value="Search" class="btn btn-info" />
                                            </div>
                                        </mvc:form> 
                                    </div>
                                </div>

                                <table>
                                    <tr>
                                        <c:if test="${numberPages != 1}">
                                            <c:if test="${(page + 1) < numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1} - ${page*size + orders.size()} of ${n} results</td></i>
                                        </c:if>
                                        <c:if test="${(page + 1) >= numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1}-${n} of ${n} results</td></i>  
                                        </c:if> 
                                    </c:if>
                                    <td colspan="7"></td>
                                    </tr>
                                    <tr>
                                        <th>Order Number</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Phone Number</th>
                                        <th>Order Date</th>
                                        <th>Total price</th>
                                        <th>Status</th>
                                        <th></th>
                                    </tr>

                                    <c:if test="${orders != null && fn:length(orders)>0}">

                                        <c:forEach items="${orders}" var="order">
                                            <mvc:form action="${pageContext.request.contextPath}/admin/order/change-status"
                                                      method="post">
                                                <tr>
                                                    <td title="Order Detail"><a href="${pageContext.request.contextPath}/admin/order-detail/${order.id}">${order.orderNumber.substring(0, 8)}</a></td>
                                                    <td>${order.fullName}</td>
                                                    <td>${order.email}</td>
                                                    <td>${order.phoneNumber}</td>
                                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                                                    <td>$${order.totalPrice}</td>
                                                    <c:if test="${order.status == 'CANCEL' || order.status == 'COMPLETED'}">
                                                        <td style="display: flex">
                                                            <select style="width: 150px; background-color: #152036" name="status" class="form-control" disabled="true" title="Can't change status!!">
                                                                <c:forEach items="${orderStatus}" var="s">
                                                                    <c:if test="${s == order.status}">
                                                                        <option selected="selected" value="${s}">${s}</option>
                                                                    </c:if>
                                                                    <c:if test="${s != order.status}">
                                                                        <option value="${s}">${s}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                            <input type="hidden" value="${order.id}" name="id">
                                                            <button data-toggle="tooltip" title="Update Status" class="pd-setting-ed" type="submit" disabled="true"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${order.status != 'CANCEL' && order.status != 'COMPLETED'}">
                                                        <td style="display: flex">
                                                            <select style="width: 150px" name="status" class="form-control">
                                                                <c:forEach items="${orderStatus}" var="s">
                                                                    <c:if test="${s == order.status}">
                                                                        <option selected="selected" value="${s}">${s}</option>
                                                                    </c:if>
                                                                    <c:if test="${s != order.status}">
                                                                        <option value="${s}">${s}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                            <input type="hidden" value="${order.id}" name="id">
                                                            <button data-toggle="tooltip" title="Update Status" class="pd-setting-ed" type="submit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </mvc:form>
                                        </c:forEach>
                                        <tr><td colspan="9"></td></tr>
                                            <c:if test="${strSearch == null && fromDate == null}">
                                            <tr>
                                                <td colspan="1">Page ${page + 1} of ${numberPages}</td>
                                                <td colspan="3" style="text-align: center;">
                                                    <c:if test="${page <= 1 && start <= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/orders/?page=${0}&start=${0}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page > 1 && start >= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/orders/?page=${page - 1}&start=${start - 1}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                                        <c:if test="${i < numberPages}">
                                                            <c:if test="${page == i}">
                                                                <button id="btnN" style="color: red" class="btn btn-danger" onclick="location.href = '<c:url value="/admin/orders/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${page != i}">
                                                                <button id="btnN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/orders/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${page < numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/orders/?page=${page + 1}&start=${start + 1}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page == numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/orders/?page=${page}&start=${start}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${orders == null || fn:length(orders)<=0}">
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

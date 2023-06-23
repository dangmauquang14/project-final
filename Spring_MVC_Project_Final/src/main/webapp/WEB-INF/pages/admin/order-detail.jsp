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
        <title>Order Detail Page</title>
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
                                                    <h2>Order Detail</h2>
                                                </div>
                                            </div>
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
                                <h4>Order</h4>
                                <table>
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
                                    <mvc:form action="${pageContext.request.contextPath}/admin/order/change-status"
                                              method="post">
                                        <tr>
                                            <td>${order.orderNumber.substring(0, 8)}</td>
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
                                    <tr><td colspan="9"></td></tr>
                                </table>
                                <br/>
                                <h4>Order Detail</h4>
                                <table>
                                    <tr>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Discount</th>
                                        <th>Quantity</th>
                                        <th>Sub Total Price</th>
                                    </tr>
                                    <tr>
                                        <c:forEach items="${order.getOrderDetails()}" var="orderItem">
                                            <c:forEach items="${products}" var="product">
                                                <c:if test="${product.id == orderItem.getProduct().getId()}">
                                                    <td><img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="" /></td>
                                                    </c:if>
                                                </c:forEach>
                                            <td>${orderItem.getProduct().getProductName()}</td>
                                            <td>$${orderItem.price}</td>
                                            <td>${orderItem.discount*100}%</td>
                                            <td>${orderItem.quantity}</td>
                                            <td>$<fmt:formatNumber value="${orderItem.quantity * orderItem.price * (1 - orderItem.discount)}" pattern="###,###" type="numer"/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr><td colspan="6"></td></tr>
                                    <tr style="font-weight: bold; font-size: 120%">
                                        <td colspan="5" style="text-align: right">Total price: </td>
                                        <td colspan="1">$${order.totalPrice}</td>
                                    </tr>
                                    <tr><td colspan="6"><button class="pd-setting" onclick="location.href = '<c:url value="/admin/orders"/>'">Back</button></td></tr>
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

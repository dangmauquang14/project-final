<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <style>

            .hover5 {
                background-color: white;
                color: black;
                border: 2px solid #000000;
            }

            .hover5:hover {
                background-color: #000000;
                color: white;
            }
            #customers {
                font-family: Arial, Helvetica, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }

            #customers td, #customers th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            #customers tr:nth-child(even){background-color: #f2f2f2;}

            #customers tr:hover {background-color: #ddd;}

            #customers th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #4CAF50;
                color: white;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Sublime project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager order Page</title>
        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />

        <jsp:include  page="include/cssCrat.jsp"/>
        <jsp:include  page="include/css.jsp"/>

    </head>
    <body>
        <jsp:include page="include/menuheader.jsp"/>
        <div>
            <!-- BREADCRUMB -->
            <div id="breadcrumb" class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3 class="breadcrumb-header">Manager</h3>
                            <ul class="breadcrumb-tree">
                                <li><a href="<c:url value="/home" />" >Home</a></li>
                                <li class="active">order</li>
                            </ul>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /BREADCRUMB -->

            <!-- Cart Info -->
            <c:if test="${message != null && message != ''}">
                <c:if test="${type != null && type != '' && type == 'fail'}">
                    <div class="alert alert-danger">${message}</div>
                </c:if>
                <c:if test="${type != null && type != '' && type == 'success'}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
            </c:if>
            <div class="cart_info">
                <div class="container">
                    <div style="padding-bottom: 50px">
                        <mvc:form action="/Spring_MVC_Project_Final/search-orderid"
                                  method="GET" class="form-inline">
                            <input  type="text" name="strSearch" class="form-control" placeholder="Search for your order code..." style="width: 250px ;height: 40px;  border-radius: 100px;"/>
                            <input type="submit" value="Check" class="hover hover5" style="width: 70px ;height: 40px; " />
                        </mvc:form> 
                    </div>
                    <!-- Coupon Code -->
                </div>
            </div>

            <div class="cart_info">
                <div class="container">
                    <div class="row">
                        <P>HISTORY ORDER: <b>${orders.get(0).email}</b></P>
                    </div>
                    <br>     
                    <br>
                    <div class="row">
                        <div class="col" style="font-weight: bold ">
                            <!-- Column Titles -->
                            <div class="cart_info_columns clearfix">
                                <div class="cart_info_col cart_info_col_p1">Mail</div>
                                <div class="cart_info_col cart_info_col_p2">Phone Number</div>
                                <div class="cart_info_col cart_info_col_p3">Status</div>
                                <div class="cart_info_col cart_info_col_p4">Date Order</div>
                                <div class="cart_info_col cart_info_col_p5">Quantity</div>
                                <div class="cart_info_col cart_info_col_p6">Total</div>
                                <div class="cart_info_col cart_info_col_p7"> </div>
                            </div>
                        </div>
                    </div>

                    <c:forEach items="${orders}" var="order">
                        <!--method="post">-->
                        <div class="row cart_items_row">
                            <div class="col">

                                <!-- Cart Item -->
                                <a href = "<c:url value="/get-orderid/${order.orderNumber}" />" >  <div class="cart_item d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-start">
                                        <!-- email -->
                                        <div class="cart_item_product d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_item_p1">
                                                ${order.email}
                                            </div>
                                            <!-- email -->
                                            <!-- phone -->
                                            <div class="cart_item_p2">
                                                ${order.phoneNumber}
                                            </div>
                                            <!-- phone -->
                                        </div>
                                        <!-- status -->
                                        <div class="cart_item_p3"> 
                                            <c:if test="${order.status == 'CANCEL'}">
                                                Canceled
                                            </c:if> 
                                            <c:if test="${order.status != 'CANCEL'}">
                                                ${order.status}
                                            </c:if> 
                                        </div>
                                        <!-- status -->
                                        <!-- Date -->
                                        <div class="cart_item_p4"> 
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                        <!-- Date -->
                                        <!-- Quantity -->
                                        <div class="cart_item_p5">
                                            ${order.quantity}
                                        </div>
                                        <!-- Quantity -->

                                        <!-- Total -->
                                        <div class="cart_item_p6">$<fmt:formatNumber value="${order.totalPrice}" pattern="###,###" type="number" /></div>
                                        <input type="hidden" value="${order.id}" name="id">

                                        <!-- delete item -->
                                        <!--<div  class="cart_item_action"><a class="fa fa-trash" href="${pageContext.request.contextPath}/cart/delete/${cart.value.getProduct().id}"></a></div>-->
                                        <div class="row row_cart_buttons cart_item_action">
                                            <div  class="col cart_item_p7">
                                                <!--<button style="height: 30px; width: 50px;" value="cancel order"name="status" title="Update Status"  type="submit"></button>-->
                                                <!--<div style=""  class="button continue_shopping_button"><a href="<c:url value="/home" />" >cancel order</a></div>-->
                                                <c:if test="${order.status == 'COMFIRM' || order.status == 'PENDING'}" >
                                                    <button onclick="window.location.href = '${pageContext.request.contextPath}/order-cancel/${order.id}'" style="width: 80px; height: 40px" class="hover hover5">
                                                        Cancel
                                                    </button>

                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <br>
                        <br>
                    </c:forEach>
                    <div class="row row_extra">
                        <div class="col-lg-4">

                            <!-- Delivery -->
                            <div class="delivery">
                                <div class="section_title"></div>
                                <div class="section_subtitle"></div>
                                <div class="delivery_options">
                                </div>
                            </div>

                            <!-- Coupon Code -->
                        </div>
                    </div>
                </div>		
            </div>
        </div>


        <!-- /FOOTER -->
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>

    </body> 
</html>


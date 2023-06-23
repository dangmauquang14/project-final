<%-- 
    Document   : home2
    Created on : Nov 19, 2020, 2:39:54 PM
    Author     : NhatHuu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard Page</title>
        <jsp:include page="../admin/include/css.jsp" />
        <link rel="stylesheet" href="<c:url value="/resources-management/style.css"/>">
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
                                                    <h2>Dashboard</h2>
                                                    <p>Welcome to <span class="bread-ntd">Admin Page</span></p>
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
            <div class="section-admin container-fluid">
                <div class="row admin text-center">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <!--//show total product in shop--> 
                                <div class="admin-content analysis-progrebar-ctn res-mg-t-15">
                                    <h4 class="text-left text-uppercase"><b>Products</b></h4>
                                    <div class="row vertical-center-box vertical-center-box-tablet">
                                        <div class="col-xs-3 mar-bot-15 text-left">

                                        </div>
                                        <div class="col-xs-9 cus-gh-hd-pro">
                                            <h2 class="text-right no-margin">${sizeProductsActive}</h2>
                                        </div>
                                    </div>
                                    <div class="progress progress-mini">
                                        <div style="width: 50%" class="progress-bar bg-green"></div>
                                    </div>
                                </div>
                            </div>
                            <!--total user-->
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="margin-bottom:1px;">
                                <div class="admin-content analysis-progrebar-ctn res-mg-t-30">
                                    <h4 class="text-left text-uppercase"><b>All Pending Orders</b></h4>
                                    <div class="row vertical-center-box vertical-center-box-tablet">
                                        <div class="col-xs-3 mar-bot-15 text-left">

                                        </div>
                                        <div class="col-xs-9 cus-gh-hd-pro">
                                            <h2 class="text-right no-margin" style="color: red">${countOrderPending}</h2>
                                        </div>
                                    </div>
                                    <div class="progress progress-mini">
                                        <div style="width: 50%;" class="progress-bar bg-blue"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <div class="admin-content analysis-progrebar-ctn res-mg-t-30">
                                    <h4 class="text-left text-uppercase"><b>Users</b></h4>
                                    <div class="row vertical-center-box vertical-center-box-tablet">
                                        <div class="text-left col-xs-3 mar-bot-15">
                                        </div>
                                        <div class="col-xs-9 cus-gh-hd-pro">
                                            <h2 class="text-right no-margin">${sizeUsers}</h2>
                                        </div>
                                    </div>
                                    <div class="progress progress-mini">
                                        <div style="width: 50%;" class="progress-bar progress-bar-danger bg-red"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <div class="admin-content analysis-progrebar-ctn res-mg-t-30">
                                    <h4 class="text-left text-uppercase"><b>Promotions Active</b></h4>
                                    <div class="row vertical-center-box vertical-center-box-tablet">
                                        <div class="text-left col-xs-3 mar-bot-15">
                                        </div>
                                        <div class="col-xs-9 cus-gh-hd-pro">
                                            <h2 class="text-right no-margin">${countPromotionActive}</h2>
                                        </div>
                                    </div>
                                    <div class="progress progress-mini">
                                        <div style="width: 50%;" class="progress-bar bg-purple"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-sales-area mg-tb-30">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12" id="columnchart_values" style="height: 400px;"></div>

                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="white-box analytics-info-cs mg-b-30 res-mg-t-30">
                                <h3 class="box-title">Revenue<small class="pull-right m-t-10 text-success last-month-sc cl-one"> In month ${month}</small></h3>
                                <ul class="list-inline two-part-sp">
                                    <li>
                                        <div id="sparklinedash"></div>
                                    </li>
                                    <li class="text-right sp-cn-r"><span class="counter sales-sts-ctn">$${sumRevenue}</span></li>
                                </ul>
                            </div>
                            <div class="white-box analytics-info-cs mg-b-30">
                                <h3 class="box-title">Products sold <small class="pull-right m-t-10 text-success last-month-sc cl-one"> In month ${month}</small></h3>
                                <ul class="list-inline two-part-sp">
                                    <li>
                                        <div id="sparklinedash2"></div>
                                    </li>
                                    <li class="text-right"><span class="counter sales-sts-ctn">${sumProductSold}</span></li>
                                </ul>
                            </div>
                            <div class="white-box analytics-info-cs">
                                <h3 class="box-title">Total products in stock</h3>
                                <ul class="list-inline two-part-sp">
                                    <li>
                                        <div id="sparklinedash4"></div>
                                    </li>
                                    <li class="text-right"><span class="sales-sts-ctn">${sumProductsInStock}</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                        

            <%--<jsp:include page="include/foodter.jsp" />--%>
        </div>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load("current", {packages: ['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ["Element", "Order", {role: "style"}],
                    <c:forEach var="item" items="${listReceipt}">["${item.time}", ${item.value}, "#8A2BE2"],</c:forEach>
                    
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0, 1,
                    {calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation"},
                    2]);

                var options = {
                    title: "Total number of orders by month of ${year}"
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
                chart.draw(view, options);
            }
        </script>
        <jsp:include page="include/js_management.jsp" />
    </body>
</html>

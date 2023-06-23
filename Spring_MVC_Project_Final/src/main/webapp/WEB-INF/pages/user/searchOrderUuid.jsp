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
        <title>Search order Page</title>
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
                            <h3 class="breadcrumb-header">Search</h3>
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
        </div>
        <br>
        <br>
        <br>
        <br>


        <!-- /FOOTER -->
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>

    </body> 
</html>


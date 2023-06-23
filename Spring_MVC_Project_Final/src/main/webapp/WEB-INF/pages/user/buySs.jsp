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
        <title>Payment Page</title>
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
                        <h3 class="breadcrumb-header">BUY</h3>
                        <ul class="breadcrumb-tree">
                            <li><a href="<c:url value="/home" />">Home</a></li>
                            <li class="active">Buy Success</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->
        <c:if test="${message != null && message != ''}">
            <c:if test="${type != null && type != '' && type == 'fail'}">
                <div class="alert alert-danger">${message}</div>
            </c:if>
            <c:if test="${type != null && type != '' && type == 'success'}">
                <div class="alert alert-success">${message}</div>
            </c:if>
        </c:if>
        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <div class="section-title">
                    <h3 class="title">Buy Success </h3> 
                </div>
                <div class="section-title">
                    Thank you for your purchase. You can check email 
                    <b><a target="_blank" href="https://mail.google.com/mail/u/0/#inbox">${orderEntity.getEmail()}</a> </b>
                    for order details, and track your order
                </div>
                <br>

                <div class="section-title">
                    <a href="<c:url value="/home" />">Continue to buy</a>
                </div>
                <br>
                <br>
                <br>
                <br>
                <br>    
                <br>
                <br>
                <br>
                <br>  
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /NEWSLETTER -->

        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>

    </body>
</html>

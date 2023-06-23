<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Checkout Page</title>
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
                        <h3 class="breadcrumb-header">Checkout</h3>
                        <ul class="breadcrumb-tree">
                            <li><a href="<c:url value="/home" />">Home</a></li>
                            <li class="active">Checkout</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-7">
                        <!-- Billing Details -->
                        <div class="billing-details">
                            <mvc:form action="${pageContext.request.contextPath}/checkout" modelAttribute="checkout" method="POST" >

                                <div class="section-title">
                                    <h3 class="title">Customer Info </h3> 
                                </div>
                                <div class="form-group">
                                    <input class="input" value="${userEntity.fullName}" type="text" name="fullName" placeholder="Full Name*" required>
                                </div>
                                <div class="form-group">
                                    <input class="input" value="${userEntity.email}" type="email" name="email" placeholder="Email*" required>
                                </div>
                                <div class="form-group">
                                    <input class="input" value="${userEntity.address}" type="text" name="address" placeholder="Address*" required>
                                </div>
                                <div class="form-group">
                                    <input class="input"  value="${userEntity.phoneNumber}" type="text" name="phoneNumber" placeholder="Telephone*" required>
                                </div>
                            </div>
                            <!-- /Billing Details -->
                        </div>

                        <!-- Order Details -->
                        <div class="col-md-5 order-details">
                            <div class="section-title text-center">
                                <h3 class="title">Your Order</h3>
                            </div>
                            <div class="order-summary">
                                <div class="order-col">
                                    <div><strong>PRODUCT</strong></div>
                                    <div style="padding-left:150px "><strong>Quantity</strong></div>
                                    <div><strong>TOTAL</strong></div>
                                </div>
                                <c:forEach items="${cartItems}" var="cp">
                                    <div class="order-products">
                                        <div class="order-col">
                                            <div>${cp.value.getProduct().productName}</div>
                                            <div>${cp.value.quantity}</div>
                                            <!-- Total -->
                                            <% String temp1 = ""; %>
                                            <!-- Promotion-->
                                            <c:if test="${not empty cp.value.getProduct().getPromotions()}">
                                                <c:forEach items="${promotions}" var="promotion">
                                                    <c:forEach items="${cp.value.getProduct().getPromotions()}" var="promotionProduct">
                                                        <c:if test="${promotion.id == promotionProduct.id}">
                                                            <% temp1 = "none";%>
                                                            <div style="width: 10px; padding-left:  115px">$${cp.value.quantity * cp.value.getProduct().price*(1 - promotion.percent)}</div>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:if>
                                            <div style="display: <%=temp1%>">$${cp.value.quantity * cp.value.getProduct().price} </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="order-col">
                                    <div>Shipping</div>
                                    <div><strong>FREE</strong></div>
                                </div>
                                <div class="order-col">
                                    <div><strong>TOTAL</strong></div>
                                    <div><strong class="order-total">$${totalPrice} </strong></div>
                                </div>
                                <c:if test="${cartItems.size() >0 }">                                        
                                    <div class="payment-method">
                                        <div class="form-group">
                                            <div class="input-checkbox">
                                                <input name="paymentMethod" value="CASH_ON_DELIVERY" type="checkbox" id="delivery" >
                                                <label for="delivery">
                                                    <span></span>
                                                    Payment on delivery
                                                </label>
                                                <div class="caption">
                                                    <input  name="delivery" type="submit"  style="width: 100%" class="primary-btn order-submit"  value="Payment on delivery" />
                                                </div>
                                            </div>
                                            <div class="input-checkbox">
                                                <input name="paymentMethod" value="CREDIT_CARD" type="checkbox" id="cash" >
                                                <label for="cash">
                                                    <span></span>
                                                    Payment on cash
                                                </label>
                                                <div class="caption">
                                                    <input  name="cash" type="submit"  style="width: 100%" class="primary-btn order-submit"  value="Payment on cash" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </mvc:form>

                            <%--<mvc:form action="${pageContext.request.contextPath}/payment" modelAttribute="paymentCart" method="GET">--%>
                            <!--                                    <div class="form-group">
                                                                    <div class="input-checkbox">
                                                                        <input name="option" type="checkbox" id="create-account">
                                                                        <label>
                                                                            <span></span>
                                                                            <i><a href = '<c:url value="/payment"/> '>  Payment on cash >></a></i>
                                                                        </label>
                                                                                                                    <div  class="caption">
                                                                                                                        <p>Enter your cart</p>
                                                                                                                        <div class="form-group">
                                                                                                                            <input class="input" type="text" name="cartName" placeholder="Enter the cardholder's name" required>
                                                                                                                        </div>
                                                                                                                        <div class="form-group">
                                                                                                                            <input class="input" type="text" name="cartNumber" placeholder="000-000-000" required>
                                                                                                                        </div>
                                                                                                                        <div class="form-group">
                                                                                                                            <input class="input" type="text" name="cartExdate" placeholder="YYYY/MM/DD" required>
                                                                                                                        </div>
                                                                                                                        <div class="form-group">
                                                                                                                            <input class="input" type="text" name="code" placeholder="000" required>
                                                                                                                        </div>
                                                                                                                            <button  onclick="window.location.href = '<c:url value="/payment"/> '">Payment on cash</button>
                                                                                                                        <input  name="delivery" type="submit"  style="width: 100%" class="primary-btn order-submit" value="Payment on cash"/>
                                                                                                                    </div>
                                                                    </div>
                                                                </div>-->
                            <%--</mvc:form>--%>
                        </div>
                    </div>
                    <!-- /Order Details -->
                </div>
                <!-- /row -->
            </div>

            <!-- /container -->
        </div>
        <!-- /SECTION -->
        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="newsletter">
                            <!--                                <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                                                            <form>
                                                                <input class="input" type="email" placeholder="Enter Your Email">
                                                                <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                                                            </form>-->
                            <ul class="newsletter-follow">
                                <li>
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!--</div>-->
        <!-- /NEWSLETTER -->

        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>

    </body>
</html>

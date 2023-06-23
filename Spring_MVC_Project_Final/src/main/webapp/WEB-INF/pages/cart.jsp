<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Sublime project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>order Page</title>
        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />

        <jsp:include  page="user/include/cssCrat.jsp"/>
        <jsp:include  page="user/include/css.jsp"/>
    </head>
    <body>
        <jsp:include page="user/include/menuheader.jsp"/>
        <div>
            <!-- BREADCRUMB -->
            <div id="breadcrumb" class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3 class="breadcrumb-header">Cart</h3>
                            <ul class="breadcrumb-tree">
                                <li><a href="<c:url value="/home" />" >Home</a></li>
                                <li class="active">Cart</li>
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
                    <div class="row">
                        <div class="col">
                            <!-- Column Titles -->
                            <div class="cart_info_columns clearfix">
                                <div class="cart_info_col cart_info_col_product">Product</div>
                                <div class="cart_info_col cart_info_col_price">Price</div>
                                <div class="cart_info_col cart_info_col_quantity">Quantity</div>
                                <div class="cart_info_col cart_info_col_total">Total</div>
                                <div class="cart_info_col cart_info_col_action">Action</div>
                            </div>
                        </div>
                    </div>
                    <mvc:form modelAttribute="" action="" method="POST">
                        <c:forEach items="${cartItems}" var="cart"> 

                            <div class="row cart_items_row">
                                <div class="col">

                                    <!-- Cart Item -->
                                    <div class="cart_item d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-start">
                                        <!-- Name -->
                                        <div class="cart_item_product d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_item_image">
                                                <c:if test="${not empty cart.value.getProduct().getImages()}">
                                                    <div>
                                                        <img src="<c:url value='/resources/img/product/${cart.value.getProduct().getImages().get(0).imageName}' />" alt="">
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="cart_item_name_container">
                                                <div class="cart_item_name"><a href="<c:url value="/productdetail/${cart.value.getProduct().id}/${cart.value.getProduct().getCategory().id}" />">${cart.value.getProduct().productName}</a></div>
                                                <div class="cart_item_edit"><a href="<c:url value="/productdetail/${cart.value.getProduct().id}/${cart.value.getProduct().getCategory().id}" />">${cart.value.getProduct().getCategory().categoryName}</a></div>
                                            </div>
                                        </div>
                                        <!-- Price -->
                                        <% String temp = ""; %>
                                        <!-- Promotion-->
                                        <c:if test="${not empty cart.value.getProduct().getPromotions()}">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:forEach items="${cart.value.getProduct().getPromotions()}" var="promotionProduct">
                                                    <c:if test="${promotion.id == promotionProduct.id}">
                                                        <% temp = "none";%>
                                                        <div class="cart_item_price"> 
                                                            $   ${cart.value.getProduct().price*(1 - promotion.percent)}
                                                            <del class="product-old-price">
                                                                $  ${cart.value.getProduct().price}
                                                            </del>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </c:if>

                                        <div style="display: <%=temp%>" class="cart_item_price"> $  
                                            ${cart.value.getProduct().price}
                                        </div>
                                        <!-- Quantity -->
                                        <div class="cart_item_quantity">
                                            <input  class="form-control" style="text-align: center; width: 70px;height: 40px; display: inline" 
                                                    id="quantity_input" type="number" name="q" min="1" 
                                                    max="${cart.value.getProduct().quantity}" value="${cart.value.quantity}"/>
                                            <input type="hidden"  name="id" value="${cart.value.getProduct().id}"/>
                                        </div>
                                        <!-- Total -->
                                        <% String temp1 = ""; %>
                                        <!-- Promotion-->
                                        <c:if test="${not empty cart.value.getProduct().getPromotions()}">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:forEach items="${cart.value.getProduct().getPromotions()}" var="promotionProduct">
                                                    <c:if test="${promotion.id == promotionProduct.id}">
                                                        <% temp1 = "none";%>
                                                        <div class="cart_item_total">$${cart.value.quantity * cart.value.getProduct().price*(1 - promotion.percent)}</div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </c:if>
                                        <div style="display: <%=temp1%>" class="cart_item_total">$${cart.value.quantity * cart.value.getProduct().price}</div>
                                        <!-- delete item -->
                                        <div  class="cart_item_action"><a class="fa fa-trash" href="${pageContext.request.contextPath}/cart/delete/${cart.value.getProduct().id}"></a></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="row row_cart_buttons">
                            <div class="col">
                                <div class="cart_buttons d-flex flex-lg-row flex-column align-items-start justify-content-start">
                                    <div class="button continue_shopping_button"><a href="<c:url value="/home" />" >Continue shopping</a></div>
                                    <div class="cart_buttons_right ml-lg-auto">
                                        <input class="button clear_cart_button hover hover5" value="Clear cart" type="submit" formaction="${pageContext.request.contextPath}/cart/delete">
                                        <input class="button clear_cart_button  hover hover5" value="Update cart" type="submit" formaction="${pageContext.request.contextPath}/cart/update">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </mvc:form>

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
                        <c:if test="${cartItems.size() >0 }">

                            <div class="col-lg-6 offset-lg-2">
                                <div class="cart_total">
                                    <div class="section_title">Cart total</div>
                                    <div class="section_subtitle"></div>
                                    <div class="cart_total_container">
                                        <ul>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Shipping</div>
                                                <div class="cart_total_value ml-auto">Free</div>
                                            </li>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Total</div>
                                                <div class="cart_total_value ml-auto">$<fmt:formatNumber  value="${totalPrice}"
                                                                  pattern="###.#" type="number" /></div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="button checkout_button"><a href="<c:url value="/checkout"/>">Proceed to checkout</a></div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>		
            </div>
        </div>
        <jsp:include page="user/include/footer.jsp"/>
        <jsp:include page="user/include/js-page.jsp"/>
        <jsp:include page="user/include/js-crat.jsp"/>
    </body> 
</html>

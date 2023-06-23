<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!-- HEADER -->
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
                <li><a href="#"><i class="fa fa-envelope-o"></i> itg@email.com</a></li>
                <li><a href="https://goo.gl/maps/b9vBTA7aUB7LRNnh8 " target="_blank"><i class="fa fa-map-marker"></i> 08 Ha Van Tinh - Lien Chieu - Da Nang</a></li>
            </ul>
            <ul class="header-links pull-right">
                <sec:authorize access="isAuthenticated()">
                    <li><a href="<c:url value="/manager-oder"/>"><i></i>Manager order</a></li>
                    <li><a href="<c:url value="/changeAccount/${username}"/>"><i class="fa fa-user-o"></i>${username}</a></li>
                    <li><a href="<c:url value="/logout" />"><i class="fa fa-user-o"></i>Logout</a></li>
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                    <li><a href="<c:url value="/search-orderUuid"/>"><i></i>Check order</a></li>
                    <li><a href="<c:url value="/login" />"><i class="fa fa-user-o"></i>Login</a></li>
                    </sec:authorize>
            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="<c:url value="/home" />" class="logo">
                            <img src="<c:url value="/resources/img/logo1.png"/>" alt="" width="70" height="70">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <mvc:form action="/Spring_MVC_Project_Final/search-here"
                                  method="GET" class="form-inline">
                            <input  name="strSearch" style="border-radius: 50px"  type="text"  class="input" placeholder="Search here" value="${strSearch}" required="">
                            <input  type="submit"  class="search-btn" value="Search"/>
                        </mvc:form> 

                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Wishlist -->
                        <sec:authorize access="isAuthenticated()">
                            <div>
                                <a href="<c:url value="/viewFavorite"/>">
                                    <i class="fa fa-heart-o"></i>
                                    <span>Your Wishlist</span>
                                    <!--<div class="qty"></div>-->
                                </a>
                            </div>
                        </sec:authorize>
                        <!-- /Wishlist -->

                        <!-- Cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Your Cart</span>
                                <!--<div class="qty">3</div>-->
                            </a>
                            <div class="cart-dropdown">
                                <c:forEach items="${cartItems}" var="cart"> 

                                    <div class="cart-list">
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <c:if test="${not empty cart.value.getProduct().getImages()}">
                                                    <img src="<c:url value='/resources/img/product/${cart.value.getProduct().getImages().get(0).imageName}' />" alt="">
                                                </c:if>                                           
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="<c:url value="/productdetail/${cart.value.getProduct().id}/${cart.value.getProduct().getCategory().id}" />">${cart.value.getProduct().productName}</a></h3>
                                                <h6  class="product-price"><span class="qty">${cart.value.quantity} x </span>

                                                    <!-- Price -->
                                                    <% String temp = ""; %>
                                                    <!-- Promotion-->
                                                    <c:if test="${not empty cart.value.getProduct().getPromotions()}">
                                                        <c:forEach items="${promotions}" var="promotion">
                                                            <c:forEach items="${cart.value.getProduct().getPromotions()}" var="promotionProduct">
                                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                                    <% temp = "none";%>
                                                                    $   ${cart.value.getProduct().price*(1 - promotion.percent)}
                                                                    <del class="product-old-price">
                                                                        $  ${cart.value.getProduct().price}
                                                                    </del>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:forEach>
                                                    </c:if>
                                                    <span style="display: <%=temp%>" >  $  
                                                        ${cart.value.getProduct().price}
                                                    </span>
                                                </h6>
                                            </div>
                                            <button onclick="window.location.href = '${pageContext.request.contextPath}/cart/delete/${cart.value.getProduct().id}'" class="delete"><i class="fa fa-close"></i></button>
                                        </div>
                                    </div>

                                    <!--                                    <div class="cart-summary">
                                                                            <small>3 Item(s) selected</small>
                                                                            <h5>SUBTOTAL: $2940.00</h5>
                                                                        </div>-->
                                </c:forEach>
                                <div class="cart-btns">
                                    <a href="${pageContext.request.contextPath}/view-cart">View Cart</a>
                                    <a href="${pageContext.request.contextPath}/checkout">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<script>
    /* When the user clicks on the button, 
     toggle between hiding and showing the dropdown content */
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>
<!-- /HEADER -->
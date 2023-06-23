<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>List Product Page</title>
        <link rel="shortcut icon" href="<c:url value="../resources/img/logo1.png"/>" />

        <jsp:include  page="include/css.jsp"/>
    </head>
    <body>
        <jsp:include page="include/menuheader.jsp"/>

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div  id="idTop" class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul  class="main-nav nav navbar-nav">
                        <li class="active"><a href=""<c:url value="/home" />"">Home</a></li>
                        <li><a href="<c:url value="/viewproduct" />">Laptops</a></li>
                        <li style="padding-top: 12px;">   <div class="dropdown">
                                <button onclick="myFunction()" class="dropbtn">Category <i class="icon nalika-down-arrow nalika-angle-dw"></i></button>
                                <div id="myDropdown" class="dropdown-content">
                                    <c:forEach items="${categories}" var="c">
                                        <c:if test="${c.status == 'ACTIVE'}">
                                            <a href="<c:url value="/viewproduct/${c.id}"/>">${c.categoryName}</a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </li>
                        <!--<li><a href="<c:url value="/about-us" /> " >About Us</a></li>-->
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- Cart Info -->
        <c:if test="${message != null && message != ''}">
            <c:if test="${type != null && type != '' && type == 'fail'}">
                <div class="alert alert-danger">${message}</div>
            </c:if>
            <c:if test="${type != null && type != '' && type == 'success'}">
                <div class="alert alert-success">${message}</div>
            </c:if>
        </c:if>
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- ASIDE -->
                    <div id="aside" class="col-md-3">
                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Categories</h3>
                            <c:forEach  begin="0" end="${categories.size()-1}" var="i">
                                <div class="checkbox-filter">
                                    <div class="input-checkbox">
                                        <a href="<c:url value="/viewproduct/${categories[i].id}"/>" id="category-1">
                                            <label for="category-1">
                                                <span></span>
                                                ${categories[i].categoryName}
                                                <small>(${countProducts[i]})</small>
                                            </label></a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <!--                        <div class="aside">
                                                    <h3 class="aside-title">Price</h3>
                                                    <div class="checkbox-filter">
                        
                                                        <div class="input-checkbox">
                                                            <input type="checkbox" id="category-1">
                                                            <label for="category-1">
                                                                <span></span>
                                                                All
                                                            </label>
                                                        </div>
                                                        <div class="input-checkbox">
                                                            <input type="checkbox" id="category-1">
                                                            <label for="category-1">
                                                                <span></span>
                                                                Under 10 million
                                                            </label>
                                                        </div>
                        
                                                        <div class="input-checkbox">
                                                            <input type="checkbox" id="category-2">
                                                            <label for="category-2">
                                                                <span></span>
                                                                From 10 - 15 million
                                                            </label>
                                                        </div>
                        
                                                        <div class="input-checkbox">
                                                            <input type="checkbox" id="category-3">
                                                            <label for="category-3">
                                                                <span></span>
                                                                From 15 - 20 million
                                                            </label>
                                                        </div>
                        
                                                        <div class="input-checkbox">
                                                            <input type="checkbox" id="category-4">
                                                            <label for="category-4">
                                                                <span></span>
                                                                Over 20 million
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>-->
                        <!-- /aside Widget -->


                        <!-- aside Widget -->
                        <!--                        <div class="aside">
                                                    <h3 class="aside-title">Top selling</h3>
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <img src="<c:url value="/resources/img/product01.png"/>" alt="">
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">Category</p>
                                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                            <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                        </div>
                                                    </div>
                        
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <img src="<c:url value="/resources/img/product02.png"/>" alt="">
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">Category</p>
                                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                            <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                        </div>
                                                    </div>
                        
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <img src="<c:url value="/resources/img/product03.png"/>" alt="">
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">Category</p>
                                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                            <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                        </div>
                                                    </div>
                                                </div>-->
                        <!-- /aside Widget -->
                    </div>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                            </div>
                        </div>
                        <!-- /store top filter -->

                        <!-- store products -->
                        <div  style="background-color: white ; border-radius: 10px" class="row">
                            <!-- product -->
                            <c:forEach items="${products}" var="product">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <c:if test="${not empty product.getImages()}">
                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                            </c:if>
                                            <div class="product-label">
                                                <c:if test="${not empty product.getPromotions()}">
                                                    <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                        <c:forEach items="${promotions}" var="promotion">
                                                            <c:if test="${promotion.id == promotionProduct.id}">
                                                                <span title="${promotion.promotionName}" class="sale">Sale&nbsp;${promotion.percent*100}%</span>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${product.quantity >= 10}"> 
                                                </c:if>
                                                <c:if test="${product.quantity <= 0}"> 
                                                    <span class="new">Sold out</span>
                                                </c:if>
                                                <c:if test="${product.quantity > 0 && product.quantity < 10}"> 
                                                    <span class="new">Limited</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>
                                            <!-- Promotion-->
                                            <% String temp = ""; %>
                                            <c:if test="${not empty product.getPromotions()}">
                                                <c:forEach items="${promotions}" var="promotion">
                                                    <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                        <c:if test="${promotion.id == promotionProduct.id}">
                                                            <% temp = "none";%>
                                                            <h4 class="product-price">
                                                                $   ${product.price*(1 - promotion.percent)}
                                                                <del class="product-old-price">
                                                                    $   ${product.price}</del>
                                                            </h4>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:if>

                                            <h4 class="product-price" style="display: <%=temp%>">
                                                $   ${product.price}
                                            </h4>
                                            <!-- Promotion-->    
                                            <div class="product-rating">
                                            </div>
                                            <div class="product-btns">

                                                <sec:authorize access="isAuthenticated()">
                                                    <% String tempp = ""; %>
                                                    <c:forEach items="${favorites}" var="favorite"> 
                                                        <c:if test="${product.id == favorite.getProduct().getId()}">
                                                            <% tempp = "none";%>
                                                            <button  onclick="location.href = '<c:url value="/user/delete-favorie/${favorite.id}" />'" class="add-to-wishlist"><i class="fa fa-heart" style="color: red"></i><span class="tooltipp">removed wishlist</span></button>
                                                                </c:if> 
                                                            </c:forEach>
                                                    <button style="display: <%=tempp%>" onclick="location.href = '<c:url value="/user/add-favorie/${product.id}" />'" class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                        </sec:authorize>
                                                        <sec:authorize access="!isAuthenticated()">
                                                    <button onclick="window.location.href = '/Spring_MVC_Project_Final/login'" class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                        </sec:authorize>
                                                <button onclick="location.href = '<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />'" class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">view detail</span></button>
                                            </div>
                                        </div>
                                        <c:if test="${product.quantity > 0}">
                                            <div class="add-to-cart">
                                                <% String tempp2 = ""; %>
                                                <c:forEach items="${cartItems}" var="cart"> 
                                                    <c:if test="${cart.value.getProduct().id == product.id}">
                                                        <% tempp2 = "none";%>
                                                        <button class="add-to-cart-btn-n" onclick="location.href = '<c:url value="/view-cart"/>'"><i class="fa fa-shopping-cart" ></i> view cart</button>
                                                    </c:if>   
                                                </c:forEach>
                                                <button style="display: <%=tempp2%>"  class="add-to-cart-btn" onclick="location.href = '<c:url value="/cart/${product.id}"/>'"><i class="fa fa-shopping-cart" ></i> add to cart</button>
                                            </div>
                                        </c:if>
                                        <c:if test="${product.quantity <= 0}">
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn" onclick="location.href = '<c:url value="/productdetail/${product.id}/${product.getCategory().id}"/>'"><i class="fa fa-shopping-cart" ></i> View detail</button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="clearfix visible-sm visible-xs"></div>
                            </c:forEach>
                        </div>
                        <!-- /store products -->
                        <!-- store bottom filter -->
                        <c:if test="${strSearch == null}">
                            <div class="store-filter clearfix">
                                <span class="store-qty">Page ${page + 1} of ${numberPages}</span>
                                <ul class="store-pagination">
                                    <c:if test="${page <= 1 && start <= 1}">
                                        <li><a id="btnPN" href="<c:url value="/viewproduct/?page=${0}&start=${0}"/>"><i class="fa fa-angle-left"></i></a>
                                        </li>
                                    </c:if>

                                    <c:if test="${page > 1 && start >= 1}">
                                        <li><a id="btnPN" href="<c:url value="/viewproduct/?page=${page - 1}&start=${start - 1}"/>"><i class="fa fa-angle-left"></i></a>
                                        </li>
                                    </c:if>

                                    <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                        <c:if test="${i < numberPages}">
                                            <c:if test="${page == i}">
                                                <li class="active" ><a style="color: white" id="btnN" href="<c:url value="/viewproduct/?page=${i}&start=${start}"/>">${i + 1}</a></li>
                                                </c:if>
                                                <c:if test="${page != i}">
                                                <li><a id="btnN" href="<c:url value="/viewproduct/?page=${i}&start=${start}"/>"> ${i + 1}</a></li>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                    <c:if test="${page < numberPages - 1}">
                                        <li><a id="btnPN" href="<c:url value="/viewproduct/?page=${page + 1}&start=${start + 1}"/>"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                    </c:if>

                                    <c:if test="${page == numberPages - 1}">
                                        <li><a id="btnPN" href="<c:url value="/viewproduct/?page=${page}&start=${start}"/>"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                        <!-- /store bottom filter -->
                    </div>
                    <!-- /STORE -->
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
                            <!--                            <p>Sign Up for the <strong>NEWSLETTER</strong></p>
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
        <!-- /NEWSLETTER -->        

        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/js-page.jsp"/>
        <jsp:include page="include/js-crat.jsp"/>

    </body>
</html>

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
        <title>Product Detail Page</title>
        <link rel="shortcut icon" href="<c:url value="../resources/img/logo1.png"/>" />

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
                        <ul class="breadcrumb-tree">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Product</a></li>
                            <li class="active">Detail</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <c:forEach items="${product.getImages()}" var="img">
                                <div class="product-preview">
                                    <img src="<c:url value='/resources/img/product/${img.imageName}' />" alt="">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <c:forEach items="${product.getImages()}" var="img">
                                <div class="product-preview">
                                    <img src="<c:url value='/resources/img/product/${img.imageName}' />" alt="">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name">${product.productName}</h2>
                            <div>
                            </div>
                            <div>
                                <% String temp = ""; %>
                                <!-- Promotion-->
                                <c:if test="${not empty product.getPromotions()}">
                                    <c:forEach items="${promotions}" var="promotion">
                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:if test="${promotion.id == promotionProduct.id}">
                                                <% temp = "none";%>
                                                <h4 class="product-price">
                                                    $   ${product.price*(1 - promotion.percent)}

                                                    <del class="product-old-price">
                                                        $   ${product.price}
                                                    </del>
                                                </h4>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </c:if>

                                <h4 class="product-price" style="display: <%=temp%>">
                                    $   ${product.price}

                                </h4>
                                <c:if test="${product.quantity >= 10}"> 
                                    <span class="product-available">In Stock</span>
                                </c:if>
                                <c:if test="${product.quantity <= 0}"> 
                                    <span class="product-available">Out of Stock</span>
                                </c:if>
                                <c:if test="${product.quantity > 0 && product.quantity < 10}"> 
                                    <span class="product-available">low Stock</span>
                                </c:if>
                            </div>
                            <p>${product.description}</p>

                            <br>
                            <c:if test="${product.quantity > 0}">
                                <div class="add-to-cart">
                                    <% String tempb = ""; %>
                                    <c:forEach items="${cartItems}" var="cart"> 
                                        <c:if test="${cart.value.getProduct().id == product.id}">
                                            <% tempb = "none";%>
                                            <button class="add-to-cart-btn" style="background-color: aqua" onclick="location.href = '<c:url value="/view-cart"/>'"><i class="fa fa-shopping-cart" ></i> view cart</button>
                                        </c:if>   
                                    </c:forEach>
                                    <button style="display: <%=tempb%>"  class="add-to-cart-btn" onclick="location.href = '<c:url value="/cart/${product.id}"/>'"><i class="fa fa-shopping-cart" ></i> add to cart</button>
                                </div>
                            </c:if>


                            <c:if test="${product.quantity <= 0}">
                                <div class="add-to-cart">
                                    <button class="add-to-cart-btn" onclick="location.href = '<c:url value="/productdetail/${product.id}/${product.getCategory().id}"/>'"><i class="fa fa-shopping-cart" ></i> View detail</button>
                                </div>
                            </c:if>
                            <ul class="product-btns">
                                <sec:authorize access="isAuthenticated()">
                                    <% String temp1 = ""; %>
                                    <c:forEach items="${favorites}" var="favorite"> 
                                        <c:if test="${product.id == favorite.getProduct().getId()}">
                                            <% temp1 = "none";%>
                                            <li><a  href = '<c:url value="/user/delete-favorie/${favorite.id}" />' ><i class="fa fa-heart" style="color: red"></i> removed wishlist</a></li>
                                            </c:if> 
                                        </c:forEach>
                                    <li><a style="display: <%=temp1%>" href = '<c:url value="/user/add-favorie/${product.id}" />'><i class="fa fa-heart-o"></i> add to wishlist </a></li>
                                    </sec:authorize>

                                <sec:authorize access="!isAuthenticated()">
                                    <li><a href="/Spring_MVC_Project_Final/login"><i class="fa fa-heart-o"></i> add to wishlist</a></li>

                                </sec:authorize>
                            </ul>

                            <ul class="product-links">
                                <li>Category:</li>
                                <li><a href="<c:url value="/viewproduct/${product.getCategory().id}" />">${product.getCategory().categoryName}</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Share:</li>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                            </ul>

                        </div>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>${product.description}</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>${product.description}</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab2  -->
                            </div>
                        </div>
                        <!-- /tab3  -->
                    </div>
                    <!-- /product tab content  -->
                </div>
            </div>
            <!-- /product tab -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- /Section -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div style="background-color: white ; border-radius: 10px" class="row">

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                            <div class="products-slick" data-nav="#slick-nav-1">
                                <!-- product -->
                                <c:forEach items="${products}" var="product">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
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
                                                <% String temppp = ""; %>

                                            <!-- Promotion-->
                                            <c:if test="${not empty product.getPromotions()}">
                                                <c:forEach items="${promotions}" var="promotion">
                                                    <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                        <c:if test="${promotion.id == promotionProduct.id}">
                                                            <% temppp = "none";%>
                                                            <h4 class="product-price">
                                                                $   ${product.price*(1 - promotion.percent)} 

                                                                <del class="product-old-price">
                                                                    $   ${product.price}
                                                                </del>
                                                            </h4>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:if>

                                            <h4 class="product-price" style="display: <%=temppp%>">
                                                $   ${product.price}

                                            </h4>
                                            <!-- Promotion-->

                                            <div>
                                                <div class="product-rating">
                                                    <i class="fa fa-star-o"></i>
                                                </div>
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
                                        <div class="add-to-cart">
                                            <% String tempb2 = ""; %>
                                            <c:forEach items="${cartItems}" var="cart"> 
                                                <c:if test="${cart.value.getProduct().id == product.id}">
                                                    <% tempb2 = "none";%>
                                                    <button class="add-to-cart-btn-n" onclick="location.href = '<c:url value="/view-cart"/>'"><i class="fa fa-shopping-cart" ></i> view cart</button>
                                                </c:if>   
                                            </c:forEach>
                                            <button style="display: <%=tempb2%>"  class="add-to-cart-btn" onclick="location.href = '<c:url value="/cart/${product.id}"/>'"><i class="fa fa-shopping-cart" ></i> add to cart</button>
                                        </div>
                                    </div>
                                    <%--</c:if>--%>
                                </c:forEach>
                                <!-- product -->
                            </div>
                            <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- Products tab & slick -->
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
                    <!--                    <p>Sign Up for the <strong>NEWSLETTER</strong></p>
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
</body> 
</html>

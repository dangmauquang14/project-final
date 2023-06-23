<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="description" content="Sublime project">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home Page</title>   
        <jsp:include  page="user/include/css.jsp"/>
        <%--<jsp:include  page="user/include/cssHome.jsp"/>--%>


        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />

    </head>
    <body style="background-color: #f2f3f1">
        <jsp:include page="user/include/menuheader.jsp"/>

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


        <!--        <div class="home">
                    <div class="home_slider_container">
        
                         Home Slider 
                        <div class="owl-carousel owl-theme home_slider">
        
        <c:forEach items="${promotions}" var="promotion">
             Slider Item 
            <div class="owl-item home_slider_item">
            <%--<c:if test="${not empty promotion.getImages()}">--%>
            <%--<c:forEach items="${promotion.getImages()}" var="img">--%>
            <div class="home_slider_background" style="background-image: url(<c:url value='/resources/img/promotions/${img.imageName}' />)" ></div>
            <%--</c:forEach>--%>
            <%--</c:if>--%>
            <div class="home_slider_background" style="background-image:url(resources/resou/images/home_slider_1.jpg)"></div>
            <div class="home_slider_content_container">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_slider_content"  data-animation-in="fadeIn" data-animation-out="animate-out fadeOut">
                                <div class="home_slider_title">${promotion.getPromotionName()}</div>
                                <div class="home_slider_subtitle">${promotion.getDescription()}</div>
                                <div class="button button_light home_button"><a href="#sale">Shop Now</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>              

     Slider Item 
                     Home Slider Dots 
                    <div class="home_slider_dots_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_slider_dots">
                                        <ul id="home_slider_custom_dots" class="home_slider_custom_dots">
                                            <li class="home_slider_custom_dot active">01.</li>
                                            <li class="home_slider_custom_dot">02.</li>
                                            <li class="home_slider_custom_dot">03.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>	
                    </div>

</div>
</div>-->
        <a href="#sale"> 
            <div id="hot-deal" class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="hot-deal">
                                <ul class="hot-deal-countdown">
                                </ul>
                            </div>
                        </div>


                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div> 
        </a>
        <!-- /HOT DEAL SECTION -->

        <!-- Home Slider Dots -->
        <!-- SECTION -->
        <!--        <div class="section">
                     container 
                    <div class="container">
                         row 
                        <div class="row">-->
        <!-- shop -->
        <%--<c:forEach items="${products}" var="p">--%>
        <%--<c:if test="${p.status == 'ACTIVE'}">--%>
        <!--                            <div class="col-md-4 col-xs-6">
                                        <div class="shop">
                                            <div class="shop-img">
                                                <img src="<c:url value="/resources/img/product/${p.getImages().get(0).imageName}"/>" alt="">
                                            </div>
                                            <div class="shop-body">
                                                <h3>${p.getCategory().categoryName}<br>Collection</h3>
                                                <a href="<c:url value="viewproduct/${p.getCategory().id}"/>" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                            </div>
                                        </div>
                                    </div>-->
        <%--</c:if>--%>
        <%--</c:forEach>--%>

        <!-- /shop -->

        <!-- shop -->
        <!--                    <div class="col-md-4 col-xs-6">
                                <div class="shop">
                                    <div class="shop-img">
                                        <img src="<c:url value="/resources/img/shop03.png"/>" alt="">
                                    </div>
                                    <div class="shop-body">
                                        <h3>Apple<br>Collection</h3>
                                        <a href="" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div>
                            </div>
                             /shop 
        
                             shop 
                            <div class="col-md-4 col-xs-6">
                                <div class="shop">
                                    <div class="shop-img">
                                        <img src="<c:url value="/resources/img/shop02.png"/>" alt="">
                                    </div>
                                    <div class="shop-body">
                                        <h3>Msi<br>Collection</h3>
                                        <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div>
                            </div>
                             /shop 
                        </div>
                         /row 
                    </div>
                     /container 
                </div>-->
        <!-- /SECTION -->
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div style="background-color: white ; border-radius: 10px" class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">New Products</h3>
                            <div class="section-nav">
                                <ul class="section-tab-nav tab-nav">
                                    <%--<c:forEach   items="${categories}" var="cateI">--%>
                                        <!--<li><a data-toggle="tab" href="<c:url value="/viewproduct/${cateI.id}"/>"> ${cateI.categoryName}</a></li>-->
                                    <%--</c:forEach>--%>    
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">

                                        <!-- product -->
                                        <c:forEach items="${products}" var="product">

                                            <%--<c:if test="${product.status == 'ACTIVE'}">--%>
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
                                                                            $   ${product.price}</del>
                                                                    </h4>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:forEach>
                                                    </c:if>

                                                    <h4 class="product-price" style="display: <%=temp%>">
                                                        $ ${product.price}
                                                    </h4>
                                                    <!-- Promotion-->

                                                    <div>
                                                        <div class="product-rating">
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                    </div>
                                                    <div class="product-btns">

                                                        <sec:authorize access="isAuthenticated()">
                                                            <% String temp1 = ""; %>
                                                            <c:forEach items="${favorites}" var="favorite"> 
                                                                <c:if test="${product.id == favorite.getProduct().getId()}">
                                                                    <% temp1 = "none";%>
                                                                    <button  onclick="location.href = '<c:url value="/user/delete-favorie/${favorite.id}" />'" class="add-to-wishlist"><i class="fa fa-heart" style="color: red"></i><span class="tooltipp">removed wishlist</span></button>
                                                                        </c:if> 
                                                                    </c:forEach>
                                                            <button style="display: <%=temp1%>" onclick="location.href = '<c:url value="/user/add-favorie/${product.id}" />'" class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                                </sec:authorize>

                                                        <sec:authorize access="!isAuthenticated()">
                                                            <button onclick="window.location.href = '/Spring_MVC_Project_Final/login'" class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                                </sec:authorize>
                                                        <button onclick="location.href = '<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />'" class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">view detail</span></button>
                                                    </div>
                                                </div>
                                                <c:if test="${product.quantity > 0}">
                                                    <div class="add-to-cart">
                                                        <% String temppp = ""; %>
                                                        <c:forEach items="${cartItems}" var="cart"> 
                                                            <c:if test="${cart.value.getProduct().id == product.id}">
                                                                <% temppp = "none";%>
                                                                <button class="add-to-cart-btn-n" onclick="location.href = '<c:url value="/view-cart"/>'"><i class="fa fa-shopping-cart" ></i> view cart</button>
                                                            </c:if>   
                                                        </c:forEach>
                                                        <button style="display: <%=temppp%>"  class="add-to-cart-btn" onclick="location.href = '<c:url value="/cart/${product.id}"/>'"><i class="fa fa-shopping-cart" ></i> add to cart</button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${product.quantity <= 0}">
                                                    <div class="add-to-cart">
                                                        <button class="add-to-cart-btn" onclick="location.href = '<c:url value="/productdetail/${product.id}/${product.getCategory().id}"/>'"><i class="fa fa-shopping-cart" ></i> View detail</button>
                                                    </div>
                                                </c:if>


                                            </div>
                                            <%--</c:if>--%>
                                            <!-- product -->
                                        </c:forEach>

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
        <!-- HOT DEAL SECTION -->
        <!--        <div id="hot-deal" class="section">
                     container 
                    <div class="container">
                         row 
                        <div class="row">
                            <a href="#sale">  <div class="col-md-12">
                                    <div class="hot-deal">
                                        <ul class="hot-deal-countdown">
                                        </ul>
                                    </div>
                                </div>
                            </a>
        
                        </div>
                         /row 
                    </div>
                     /container 
                </div>-->
        <!-- /HOT DEAL SECTION -->
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div id="sale" style="background-color: white ; border-radius: 10px" class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">Sale Products</h3>
                            <div class="section-nav">
                                <ul class="section-tab-nav tab-nav">
                                    <%--<c:forEach   items="${categories}" var="cateI">--%>
                                        <!--<li><a data-toggle="tab" href="<c:url value="/viewproduct/${cateI.id}"/>"> ${cateI.categoryName}</a></li>-->
                                    <%--</c:forEach>--%>    
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">

                                        <!-- product -->
                                        <c:forEach items="${products}" var="product">
                                            <c:if test="${not empty product.getPromotions()}">
                                                <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                    <c:forEach items="${promotions}" var="promotion">
                                                        <c:if test="${promotion.id == promotionProduct.id}">
                                                            <div class="product">
                                                                <div class="product-img">
                                                                    <c:if test="${not empty product.getImages()}">
                                                                        <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                                    </c:if>
                                                                    <div class="product-label">
                                                                        <c:if test="${not empty product.getPromotions()}">

                                                                            <span title="${promotion.promotionName}" class="sale">Sale&nbsp;${promotion.percent*100}%</span>

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
                                                                        <% String tempp = ""; %>
                                                                    <!-- Promotion-->

                                                                    <% tempp = "none";%>
                                                                    <h4 class="product-price">
                                                                        $  ${product.price*(1 - promotion.percent)}
                                                                        <del class="product-old-price">
                                                                            $  ${product.price}
                                                                        </del>
                                                                    </h4>
                                                                    <h4 class="product-price" style="display: <%=tempp%>">
                                                                        $  ${product.price}
                                                                    </h4>
                                                                    <!-- Promotion-->
                                                                    <div>
                                                                        <div class="product-rating">
                                                                            <i class="fa fa-star-o"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-btns">

                                                                        <sec:authorize access="isAuthenticated()">
                                                                            <% String temp2 = ""; %>
                                                                            <c:forEach items="${favorites}" var="favorite"> 
                                                                                <c:if test="${product.id == favorite.getProduct().getId()}">
                                                                                    <% temp2 = "none";%>
                                                                                    <button  onclick="location.href = '<c:url value="/user/delete-favorie/${favorite.id}" />'" class="add-to-wishlist"><i class="fa fa-heart" style="color: red"></i><span class="tooltipp">removed wishlist</span></button>
                                                                                        </c:if> 
                                                                                    </c:forEach>
                                                                            <button style="display: <%=temp2%>" onclick="location.href = '<c:url value="/user/add-favorie/${product.id}" />'" class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
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
                                                            <!-- product -->
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>



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
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top sale</h4>
                            <div class="section-nav">
                                <div id="slick-nav-3" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-3">
                            <div>
                                <!-- product widget -->
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${not empty product.getPromotions()}">

                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                            </c:if>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>

                                                            <h4 class="product-price">
                                                                $${product.price*(1 - promotion.percent)}
                                                                <del class="product-old-price">
                                                                    $${product.price}</del>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <!-- /product widget -->


                                <!-- /product widget -->
                            </div>
                            <div>
                                <!-- product widget -->
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${not empty product.getPromotions()}">

                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                            </c:if>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>

                                                            <h4 class="product-price">
                                                                $  ${product.price*(1 - promotion.percent)}

                                                                <del class="product-old-price">
                                                                    $  ${product.price}
                                                                </del>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <!-- /product widget -->

                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top Sale</h4>
                            <div class="section-nav">
                                <div id="slick-nav-4" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-4">
                            <div>
                                <!-- product widget -->
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${not empty product.getPromotions()}">

                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                            </c:if>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>

                                                            <h4 class="product-price">
                                                                $  ${product.price*(1 - promotion.percent)}

                                                                <del class="product-old-price">
                                                                    $  ${product.price}
                                                                </del>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <!-- /product widget -->

                            </div>

                            <div>
                                <!-- product widget -->
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${not empty product.getPromotions()}">

                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                            </c:if>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>

                                                            <h4 class="product-price">
                                                                $  ${product.price*(1 - promotion.percent)}

                                                                <del class="product-old-price">
                                                                    $  ${product.price}
                                                                </del>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <!-- /product widget -->

                            </div>
                        </div>
                    </div>

                    <div class="clearfix visible-sm visible-xs"></div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top Sale</h4>
                            <div class="section-nav">
                                <div id="slick-nav-5" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-5">
                            <div>

                                <!-- product widget -->
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${not empty product.getPromotions()}">

                                        <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                            <c:forEach items="${promotions}" var="promotion">
                                                <c:if test="${promotion.id == promotionProduct.id}">
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="">
                                                            </c:if>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${product.getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${product.id}/${product.getCategory().id}" />">${product.productName}</a></h3>

                                                            <h4 class="product-price">
                                                                $  ${product.price*(1 - promotion.percent)}

                                                                <del class="product-old-price">
                                                                    $  ${product.price}
                                                                </del>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <!-- /product widget -->
                            </div>

                        </div>

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
        </div>
        <jsp:include page="user/include/footer.jsp"/>
        <%--<jsp:include page="user/include/js-fomotion.jsp"/>--%>
        <jsp:include page="user/include/js-page.jsp"/>
        <script>
            // Select all links with hashes
            $('a[href*="#"]')
                    // Remove links that don't actually link to anything
                    .not('[href="#"]')
                    .not('[href="#0"]')
                    .click(function (event) {
                    // On-page links
                    if (
                            location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
                            &&
                            location.hostname == this.hostname
                            ) {
                    // Figure out element to scroll to
                    var target = $(this.hash);
                    target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                    // Does a scroll target exist?
                    if (target.length) {
                    // Only prevent default if animation is actually gonna happen
                    event.preventDefault();
                    $('html, body').animate({
                    scrollTop: target.offset().top
                    }, 1000, function () {
                    // Callback after animation
                    // Must change focus!
                    var $target = $(target);
                    $target.focus();
                    if ($target.is(":focus")) { // Checking if the target was focused
                    return false;
                    } else {
                    $target.attr('tabindex', '-1'); // Adding tabindex for elements not focusable
                    $target.focus(); // Set focus again
                    }
                    ;
                    });
                    }
                    }
                    });
        </script>
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
    </body>
</html>

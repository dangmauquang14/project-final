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
        <title>View favorite Page</title>   
        <%--<jsp:include  page="include/cssHome.jsp"/>--%>
        <jsp:include  page="include/css.jsp"/>
        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />

    </head>
    <body style="background-color: #f2f3f1">
        <jsp:include page="include/menuheader.jsp"/>
        <!--<a href="#idTop"><img  src="<c:url value="resources/img/arrow.png"/>"style="position: absolute; position: fixed; width: 50px; height: 50px; margin-left:  1100px ;z-index: 2;;" > </a>-->  

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
        <!-- /HOT DEAL SECTION -->


        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div style="background-color: white ; border-radius: 10px" class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">My Favorite</h3>
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

                                            <c:forEach items="${favorites}" var="favorite">
                                                <c:if test="${product.id == favorite.getProduct().getId()}">
                                                    <div class="product">
                                                        <div class="product-img">
                                                            <c:if test="${product.id == favorite.getProduct().getId()}">
                                                                <img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="" />
                                                            </c:if>



                                                            <div class="product-label">
                                                                <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                                    <c:forEach items="${promotions}" var="promotion">
                                                                        <c:if test="${promotion.id == promotionProduct.id}">
                                                                            <span title="${promotion.promotionName}" class="sale">Sale&nbsp;${promotion.percent*100}%</span>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:forEach>
                                                                <c:if test="${favorite.getProduct().quantity >= 10}"> 
                                                                </c:if>
                                                                <c:if test="${favorite.getProduct().quantity <= 0}"> 
                                                                    <span class="new">Sold out</span>
                                                                </c:if>
                                                                <c:if test="${favorite.getProduct().quantity > 0 && favorite.getProduct().quantity < 10}"> 
                                                                    <span class="new">Limited</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="product-body">
                                                            <p class="product-category">${favorite.getProduct().getCategory().categoryName}</p>
                                                            <h3 class="product-name"><a href="<c:url value="/productdetail/${favorite.getProduct().id}/${favorite.getProduct().getCategory().id}" />">${favorite.getProduct().productName}</a></h3>


                                                            <% String temp = ""; %>
                                                            <!-- Promotion-->

                                                            <c:forEach items="${promotions}" var="promotion">
                                                                <c:forEach items="${product.getPromotions()}" var="promotionProduct">
                                                                    <c:if test="${promotion.id == promotionProduct.id}">

                                                                        <% temp = "none";%>
                                                                        <h4 class="product-price">
                                                                            $${product.price*(1 - promotion.percent)}
                                                                            <del class="product-old-price">
                                                                                $${product.price}</del>
                                                                        </h4>
                                                                    </c:if>
                                                                </c:forEach>

                                                            </c:forEach>
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
                                                                    <c:if test="${product.id == favorite.getProduct().getId()}">
                                                                        <% temp1 = "none";%>
                                                                        <button  onclick="location.href = '<c:url value="/user/delete-favorie/${favorite.id}" />'" class="add-to-wishlist"><i class="fa fa-heart" style="color: red"></i><span class="tooltipp">removed wishlist</span></button>
                                                                            </c:if> 
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
                                                </c:if>
                                            </c:forEach>
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
    </div>
    <jsp:include page="include/footer.jsp"/>
    <%--<jsp:include page="include/js-fomotion.jsp"/>--%>
    <jsp:include page="include/js-page.jsp"/>
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

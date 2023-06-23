<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="left-sidebar-pro">
    <nav id="sidebar" class="">
        <div class="nalika-profile">
            <div class="profile-dtl">
                <a href="${pageContext.request.contextPath}/admin/home"><img style="border-radius: 0;" src="<c:url value="/resources/img/logo1.png"/>" alt=""/></a>
            </div>
            <div class="profile-social-dtl">
                <ul class="dtl-social">
                    <li><a href="https://www.facebook.com/"><i class="icon nalika-facebook"></i></a></li>
                    <li><a href="#"><i class="icon nalika-twitter"></i></a></li>
                    <li><a href="https://www.instagram.com/"><i class="icon nalika-linkedin"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="left-custom-menu-adp-wrap comment-scrollbar">
            <nav class="sidebar-nav left-sidebar-menu-pro">
                <ul class="metismenu" id="menu1">
                    <li class="active">
                        <a class="has-arrow" href="#">
                            <i class="icon nalika-home icon-wrap"></i>
                            <span class="mini-click-non">Ecommerce</span>
                        </a>
                        <ul class="submenu-angle" aria-expanded="true">
                            <li><a title="Dashboard v.1" href="${pageContext.request.contextPath}/admin/home"><span class="mini-sub-pro">Dashboard</span></a></li>
                            <li><a title="Product List" href="${pageContext.request.contextPath}/admin/product-list"><span class="mini-sub-pro">Manage Products</span></a></li>
                            <li><a title="Manage Categories" href="${pageContext.request.contextPath}/admin/categories"><span class="mini-sub-pro">Manage Categories</span></a></li>
                            <li><a title="Manage Promotions" href="${pageContext.request.contextPath}/admin/promotions"><span class="mini-sub-pro">Manage Promotions</span></a></li>
                            <li><a title="Manage Orders" href="${pageContext.request.contextPath}/admin/orders"><span class="mini-sub-pro">Manage Orders</span></a></li>
                        </ul>
                    </li>
                    <li class="active">
                        <a class="has-arrow" href="#" aria-expanded="false"><i class="icon nalika-user"></i> <span class="mini-click-non">Account</span></a>
                        <ul class="submenu-angle" aria-expanded="false">
                            <li><a title="Manage Users" href="${pageContext.request.contextPath}/admin/users"><span class="mini-sub-pro">Manage Users</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </nav>
</div>
<%-- 
    Document   : product-list
    Created on : Nov 19, 2020, 6:41:25 PM
    Author     : NhatHuu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Products Page</title>
        <jsp:include page="include/css.jsp" />
        <link rel="stylesheet" href="<c:url value="/resources-management/style.css"/>">
        <style>
        </style>
    </head>
    <body>
        <jsp:include page="include/menu_left.jsp" />
        <div class="all-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="logo-pro">
                            <a href="index.html"><img class="main-logo" src="<c:url value="/resources-management/img/logo/logo.png"/>" alt="" /></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-advance-area">
                <jsp:include page="include/header_top.jsp" />
                <div class="breadcome-area">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="breadcome-list">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <div class="breadcomb-wp">
                                                <div class="breadcomb-icon">
                                                    <a title="Product List" href="${pageContext.request.contextPath}/admin/product-list"><i class="icon nalika-home"></i></a>
                                                </div>
                                                <div class="breadcomb-ctn">
                                                    <h2>Manage Products</h2>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <!-- Search form -->
                                            <mvc:form action="/Spring_MVC_Project_Final/admin/search" method="GET" class="form-inline">
                                                <div class="form-group">
                                                    <input value="${strSearch}" type="text" name="strSearch" class="form-control" placeholder="Search..." style="width: 400px; border-radius: 10px;" required/>
                                                    <input type="submit" value="Search" class="btn btn-info" />
                                                </div>
                                            </mvc:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-status mg-b-30">
                <div class="container-fluid">
                    <c:if test="${message != null && message != ''}">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 10px">
                                <c:if test="${type != null && type!= '' && type == 'error'}">
                                    <div class="alert alert-danger">${message}</div>
                                </c:if>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 10px">
                                <c:if test="${type != null && type!= '' && type == 'success'}">
                                    <div class="alert alert-success">${message}</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="product-status-wrap">
                                <h4>Products List</h4>
                                <div class="add-product">
                                    <a href="<c:url value="/admin/add-product"/>">Add Product</a>
                                </div>

                                <table>
                                    <tr>
                                        <c:if test="${numberPages != 1}">
                                            <c:if test="${(page + 1) < numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1} - ${page*size + products.size()} of ${n} results</td></i>
                                        </c:if>
                                        <c:if test="${(page + 1) >= numberPages}">
                                            <i><td colspan="2">Showing ${page*size + 1}-${n} of ${n} results</td></i>  
                                        </c:if> 
                                    </c:if>
                                    <td colspan="7"></td>
                                    </tr>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>
                                            <div class="dropdown">
                                                <button onclick="myFunction()" class="dropbtn">Category <i class="icon nalika-down-arrow nalika-angle-dw"></i></button>
                                                <div id="myDropdown" class="dropdown-content">
                                                    <c:forEach items="${categories}" var="c">
                                                        <c:if test="${c.status == 'ACTIVE'}">
                                                            <a href="<c:url value="/admin/search-cate/${c.id}"/>">${c.categoryName}</a>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Status</th>
                                        <th>Stock</th>
                                        <!--<th>Purchases</th>-->
                                        <th>Warranty</th>
                                    </tr>
                                    <c:if test="${products != null && fn:length(products)>0}">
                                        <c:forEach items="${products}" var="product">
                                            <c:if test="${product.getCategory().getStatus() == 'ACTIVE'}">
                                                <tr>
                                                    <c:if test="${not empty product.getImages()}">
                                                        <td><img src="<c:url value='/resources/img/product/${product.getImages().get(0).imageName}' />" alt="" /></td>
                                                        </c:if>
                                                        <c:if test="${empty product.getImages()}">
                                                        <td></td>
                                                    </c:if>
                                                    <td><b>${product.productName}</b></td>
                                                    <td>${product.getCategory().categoryName}</td>
                                                    <td>$<fmt:formatNumber value="${product.price}" pattern="###.#" type="numer"/></td>
                                                    <td>${product.quantity}</td>
                                                    <td>
                                                        <c:if test="${product.status == 'ACTIVE'}" >
                                                            <button style="width: 100px;" class="pd-setting" onclick="location.href = '<c:url value="/admin/product/change-status/${product.id}"/>'">
                                                                ${product.status}
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${product.status == 'DISABLED'}" >
                                                            <button style="width: 100px;" class="ps-setting" onclick="location.href = '<c:url value="/admin/product/change-status/${product.id}"/>'">
                                                                ${product.status}
                                                            </button>
                                                        </c:if>
                                                    </td>
                                                    <c:if test="${product.quantity <= 0}" >
                                                        <td style="color: red">Out Of Stock</td>
                                                    </c:if>
                                                    <c:if test="${product.quantity >= 10}" >
                                                        <td>In Stock</td>
                                                    </c:if>
                                                    <c:if test="${product.quantity > 0 && product.quantity < 10}" >
                                                        <td style="color: yellow">Low Stock</td>
                                                    </c:if>
                                                    <td>${product.warranty}</td>
                                                    <td>
                                                        <button data-toggle="tooltip" title="Edit" class="pd-setting-ed"><i class="fa fa-pencil-square-o" aria-hidden="true" onclick="location.href = '<c:url value="/admin/update-product/${product.id}"/>'"></i></button>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <tr><td colspan="9"></td></tr>
                                            <c:if test="${strSearch == null}">
                                            <tr>
                                                <td colspan="1">Page ${page + 1} of ${numberPages}</td>
                                                <td colspan="3" style="text-align: center;">
                                                    <c:if test="${page <= 1 && start <= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/product-list/?page=${0}&start=${0}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page > 1 && start >= 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/product-list/?page=${page - 1}&start=${start - 1}"/>'">
                                                            Previous
                                                        </button>
                                                    </c:if>
                                                    <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                                        <c:if test="${i < numberPages}">
                                                            <c:if test="${page == i}">
                                                                <button id="btnN" style="color: red" class="btn btn-danger" onclick="location.href = '<c:url value="/admin/product-list/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${page != i}">
                                                                <button id="btnN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/product-list/?page=${i}&start=${start}"/>'">
                                                                    ${i + 1}
                                                                </button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${page < numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/product-list/?page=${page + 1}&start=${start + 1}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${page == numberPages - 1}">
                                                        <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/admin/product-list/?page=${page}&start=${start}"/>'">
                                                            Next
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${products == null || fn:length(products)<=0}">
                                        <tr>
                                            <td colspan="8" style="color: red">Empty List!!!</td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
        <jsp:include page="include/js_management.jsp" />
    </body>
</html>

<%-- 
    Document   : product-list
    Created on : Nov 19, 2020, 6:41:25 PM
    Author     : NhatHuu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Categories Page</title>
        <jsp:include page="include/css.jsp" />
        <link rel="stylesheet" href="<c:url value="/resources-management/style.css"/>">
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
                                                    <i class="icon nalika-home"></i>
                                                </div>
                                                <div class="breadcomb-ctn">
                                                    <h2>Manage Categories</h2>
                                                </div>
                                            </div>
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
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="product-status-wrap">
                                <h4>Categories List</h4>
                                <div class="add-product">
                                    <a href="<c:url value="/admin/add-category"/>">Add Category</a>
                                </div>
                                <table>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Category Name</th>
                                        <th>Description</th>
                                        <th>Quantity product</th>
                                        <th>Status</th>
                                        <th></th>


                                    </tr>
                                    <c:forEach begin="0" end="${categories.size() - 1}" var="i">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td><b>${categories[i].getCategoryName()}</b></td>
                                            <td>${categories[i].getDescription()}</td>
                                            <td>${countProducts[i]}</td>
                                            <td>
                                                <c:if test="${categories[i].getStatus() == 'ACTIVE'}" >
                                                    <button style="width: 100px;" class="pd-setting" onclick="location.href = '<c:url value="/admin/category/change-status/${categories[i].getId()}"/>'">
                                                        ${categories[i].getStatus()}
                                                    </button>
                                                </c:if>
                                                <c:if test="${categories[i].getStatus() == 'DISABLED'}" >
                                                    <button style="width: 100px;" class="ps-setting" onclick="location.href = '<c:url value="/admin/category/change-status/${categories[i].getId()}"/>'">
                                                        ${categories[i].getStatus()}
                                                    </button>
                                                </c:if>
                                            </td>
                                            <td>
                                                <button data-toggle="tooltip" title="Edit" class="pd-setting-ed"><i class="fa fa-pencil-square-o" aria-hidden="true" onclick="location.href = '<c:url value="/admin/update-category/${categories[i].getId()}"/>'"></i></button>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include/js_management.jsp" />
    </body>
</html>

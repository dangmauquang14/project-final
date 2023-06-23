<%-- 
    Document   : product
    Created on : Nov 19, 2020, 9:12:18 PM
    Author     : NhatHuu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Page</title>
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
                                                    <c:if test="${action == 'add'}">
                                                        <h2>Create Category</h2>
                                                    </c:if>
                                                    <c:if test="${action == 'update'}">
                                                        <h2>Update Category</h2>
                                                    </c:if>
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
            <mvc:form action="${pageContext.request.contextPath}/admin/result-category"
                      method="post" modelAttribute="category">
                <div class="single-product-tab-area mg-b-30">
                    <!-- Single pro tab review Start-->
                    <div class="single-pro-review-area">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <div class="review-tab-pro-inner">
                                        <ul id="myTab3" class="tab-review-design">
                                            <li class="active"><a href="#description"><i class="icon nalika-edit" aria-hidden="true"></i> Category </a></li>
                                        </ul>
                                        <div id="myTabContent" class="tab-content custom-product-edit">
                                            <div class="product-tab-list tab-pane fade active in" id="description">
                                                <div class="row">
                                                    <div class="review-content-section " style="width: 700px;">
                                                        <div class="text-center">
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-user" aria-hidden="true"></i></span>
                                                                <input name="categoryName" type="text" class="form-control" placeholder="Category Name" value="${category.categoryName}">
                                                                <span class="input-group-addon" style="color: red"><mvc:errors path="categoryName"/></span>
                                                            </div>
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-favorites-button" aria-hidden="true"></i></span>
                                                                <textarea name="description" warranty rows="5" class="form-control" placeholder="Category Description" >${category.description}</textarea>
                                                                <span class="input-group-addon" style="color: red"><mvc:errors path="description"/></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row"><br/></div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="text-center custom-pro-edt-ds">
                                                            <c:if test="${action == 'add'}">
                                                                <input type="hidden" value="add" name="action">
                                                                <button class="btn btn-ctl-bt waves-effect waves-light m-r-10" type="submit">
                                                                    Create Category     
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${action == 'update'}">
                                                                <input type="hidden" value="update" name="action">
                                                                <input type="hidden" value="${category.id}" name="id">
                                                                <button class="btn btn-ctl-bt waves-effect waves-light m-r-10" type="submit">
                                                                    Update Category    
                                                                </button>
                                                            </c:if>
                                                            <div class="btn btn-ctl-bt waves-effect waves-light m-r-10">
                                                                <a style="color: white" href="<c:url value="/admin/categories"/>">Discard</a>
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
                    </div>
                </div>
            </div>
        </mvc:form>
        <%--<jsp:include page="include/foodter.jsp" />--%>
    </div>

    <jsp:include page="include/js_management.jsp" />
</body>
</html>

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
        <title>Product Page</title>
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
                                                        <h2>Create Product</h2>
                                                    </c:if>
                                                    <c:if test="${action == 'update'}">
                                                        <h2>Update Product</h2>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <mvc:form action="${pageContext.request.contextPath}/admin/result"
                      method="post" modelAttribute="product" enctype="multipart/form-data">
                <div class="single-product-tab-area mg-b-30">
                    <!-- Single pro tab review Start-->
                    <div class="single-pro-review-area">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <div class="review-tab-pro-inner">
                                        <ul id="myTab3" class="tab-review-design">
                                            <li class="active"><a href="#description"><i class="icon nalika-edit" aria-hidden="true"></i> Product </a></li>
                                            <li><a href="#reviews"><i class="icon nalika-picture" aria-hidden="true"></i> Pictures</a></li>
                                        </ul>
                                        <div id="myTabContent" class="tab-content custom-product-edit">
                                            <div class="product-tab-list tab-pane fade active in" id="description">
                                                <div class="row">
                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                        <div class="review-content-section">
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-user" aria-hidden="true"></i></span>
                                                                <input name="productName" type="text" class="form-control" placeholder="Product Name*" value="${product.productName}">
                                                                <span class="input-group-addon" style="color: red"><mvc:errors path="productName"/></span>
                                                            </div>
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="fa fa-usd" aria-hidden="true"></i></span>
                                                                <input name="price" type="text" class="form-control" placeholder="Price" value="${product.price}">
                                                            </div>
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-favorites" aria-hidden="true"></i></span>
                                                                <input  name="quantity" type="number" class="form-control" placeholder="Quantity" value="${product.quantity}">
                                                            </div>
                                                            <select style="margin-bottom: 10px;" name="category.id" class="form-control pro-edt-select form-control-primary">
                                                                <c:forEach items="${categories}" var="c">
                                                                    <c:if test="${c.status == 'ACTIVE'}">
                                                                        <c:if test="${c.categoryName == product.getCategory().categoryName}">
                                                                            <option selected="selected" value="${c.id}">${c.categoryName}</option>
                                                                        </c:if>
                                                                        <c:if test="${c.categoryName != product.getCategory().categoryName}">
                                                                            <option value="${c.id}">${c.categoryName}</option>
                                                                        </c:if>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                        <div class="review-content-section">
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-new-file" aria-hidden="true"></i></span>
                                                                <input name="warranty" type="text" class="form-control" placeholder="Warranty" value="${product.warranty}">
                                                                <span class="input-group-addon" style="color: red"><mvc:errors path="warranty"/></span>
                                                            </div>
                                                            <div style="margin-bottom: 12px;">
                                                                <p style="color: white">Add new Image:</p>
                                                                <input style="color: white" type="file"  name="file" /><br/>
                                                            </div>
                                                            <!--  <select style="margin-bottom: 10px;" name="promotion.id" class="form-control pro-edt-select form-control-primary">
                                                            <c:forEach items="${promotions}" var="p">
                                                                <option value="${p.id}">${p.promotionName}</option>
                                                            </c:forEach>
                                                        </select>-->
                                                            <div class="input-group mg-b-pro-edt">
                                                                <span class="input-group-addon"><i class="icon nalika-favorites-button" aria-hidden="true"></i></span>
                                                                <textarea name="description" warranty rows="2" class="form-control" placeholder="Product Description" >${product.description}</textarea>
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
                                                                    Create Product     
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${action == 'update'}">
                                                                <input type="hidden" value="update" name="action">
                                                                <input type="hidden" value="${product.id}" name="id">
                                                                <button class="btn btn-ctl-bt waves-effect waves-light m-r-10" type="submit">
                                                                    Update Product     
                                                                </button>
                                                            </c:if>
                                                            <div class="btn btn-ctl-bt waves-effect waves-light m-r-10">
                                                                <a style="color: white" href="<c:url value="/admin/product-list"/>">Discard</a>
                                                            </div>  
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-tab-list tab-pane fade" id="reviews">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="review-content-section">
                                                            <c:if test="${not empty product.getImages()}">
                                                                <c:forEach items="${product.getImages()}" var="img">
                                                                    <div class="row">
                                                                        <div class="col-lg-4">
                                                                            <div class="pro-edt-img">
                                                                                <img src="<c:url value='/resources/img/product/${img.imageName}' />" alt="" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-8">
                                                                            <div class="row">
                                                                                <div class="col-lg-12">
                                                                                    <div class="product-edt-pix-wrap">
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-addon">TT</span>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-lg-6">
                                                                                                <div class="product-edt-remove">
                                                                                                    <input value="Remove" type="submit" 
                                                                                                           formaction="${pageContext.request.contextPath}/admin/remove-img/${img.id}"/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
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
                </div>
            </mvc:form>
            <%--<jsp:include page="include/foodter.jsp" />--%>
        </div>

        <jsp:include page="include/js_management.jsp" />
    </body>
</html>

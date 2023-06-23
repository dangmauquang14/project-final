<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <jsp:include page="user/include/css.jsp"/>
        <jsp:include  page="user/include/cssLogin.jsp"/>
        <link rel="shortcut icon" href="<c:url value="resources/img/logo1.png"/>" />
        <style>
            .field-icon {
                position: absolute;
                /*float: right;*/
                margin-left: -35px;
                margin-top: 20px;
                z-index: 2;
            }
        </style>
    </head>

    <body>
        <jsp:include page="user/include/menuheader.jsp"/>

        <div class="row" style="padding-top: 20px; padding-bottom: 30px">
            <div style="padding-left: 100px" class="col-xs-8 col-sm-8 col-md-8 col-lg-7">
                <img src="<c:url value='/resources/img/BackgroudSale.png' />" alt="" style="width:650px;height:400px">

            </div>

            <div  class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                <div class=" order-details">
                    <div class="payment-method">
                        <div class="section-title text-center">
                            <h3>Sign in to continue buying</3>
                        </div>
                        <!-- /login?error=true -->
                        <c:if test="${message != null && message != ''}">
                            <p style="color: red">${message}</p>
                        </c:if>
                        <form action="<c:url value="j_spring_security_check"/>" method="post">
                            <div>
                                <label for="uname"><b>Username</b></label>
                                <input  type="text" placeholder="Enter Username" name="email" required>

                                <label for="psw"><b>Password</b></label>
                                <div>

                                    <input stype="border: none;" type="password" placeholder="Enter Password" name="password" required id="myInput" >

                                    <img class="field-icon containerrrr" onclick="javascript:myFunction()" src="<c:url value="resources/img/eye.png"/>" style="width:20px; height:20px"/>

                                </div>
                                <button class="primary-btn order-submit " type="submit">Login </button>
                                <label>
                                    <input type="checkbox" checked="checked" name="remember"> Remember me
                                </label>

                                <div style="background-color:#f1f1f1">
                                    <span class="psw"> Forgot <a href="#">password?</a></span>
                                    <span class="psw">Sign Up <a href="<c:url value="/signup"/>">account/  </a></span>

                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- SECTION -->
        <jsp:include page="user/include/footer.jsp"/>
        <script>
            function myFunction() {
                var x = document.getElementById("myInput");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }
        </script>
    </body>
</html>

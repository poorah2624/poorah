<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <%@include file="head.jsp"%>

    <style>
        .success-box {
            text-align: center;
            margin-top: 80px;
            padding: 40px;
            border-radius: 10px;
            background: #f9f9f9;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .success-icon {
            font-size: 80px;
            color: green;
        }

        .btn-custom {
            margin-top: 20px;
            padding: 10px 25px;
            font-size: 16px;
        }
    </style>
</head>

<body>

<%@include file="header.jsp"%>

<div class="container">
    <div class="success-box">

        
        <div class="success-icon">
            ✔
        </div>

      
        <h2>Order Placed Successfully!</h2>
        <p>Your order has been placed and will be delivered soon.</p>

      
        <a href="${pageContext.request.contextPath}/myOrders" 
           class="btn btn-primary btn-custom">
           View My Orders
        </a>

        <br>

        <a href="${pageContext.request.contextPath}/home" 
           class="btn btn-default btn-custom">
           Continue Shopping
        </a>

    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
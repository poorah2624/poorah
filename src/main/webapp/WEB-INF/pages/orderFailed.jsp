<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Failed</title>
    <%@include file="head.jsp"%>

    <style>
        .fail-box {
            text-align: center;
            margin-top: 80px;
            padding: 40px;
            border-radius: 10px;
            background: #fff3f3;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .fail-icon {
            font-size: 80px;
            color: red;
        }
    </style>
</head>

<body>

<%@include file="header.jsp"%>

<div class="container">
    <div class="fail-box">

        <div class="fail-icon">❌</div>

        <h2>Order Failed!</h2>

        <p>${errorMsg}</p>

        <a href="checkout" 
           class="btn btn-danger">
           Try Again
        </a>

    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
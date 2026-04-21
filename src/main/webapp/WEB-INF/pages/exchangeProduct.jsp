<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="head.jsp"%>
</head>
<body>
	<%@include file="header.jsp"%>>
	<div class="banner10" id="home1">
		<div class="container">
			<h2>User Profile</h2>
		</div>
	</div>

	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home.jsp"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>User Profile</li>
			</ul>
		</div>
	</div>
	<br>
	<br>
	<div class="user-profile">
		<div class="container">
			<h2 style="text-align: center; margin-bottom: 30px;">Exchange Product</h2>
            <form method="post" action="/order/exchange">

            <input type="hidden" id="exchangeOrderId" name="orderId" />

            <!-- SIZE SELECT -->
            <label>Select New Size:</label>
            <select name="newSize" required>
                <option value="">Select Size</option>
                <option value="S">S</option>
                <option value="M">M</option>
                <option value="L">L</option>
                <option value="XL">XL</option>
            </select>

            <br><br>

            <!-- REASON -->
            <label>Reason:</label>
            <textarea name="reason" placeholder="Why do you want exchange?" required></textarea>

            <br><br>

            <button type="submit">Submit</button>
            <button type="button" onclick="closeModal()">Cancel</button>

        </form>
			
		</div>
	</div>
	<%@include file="footer.jsp"%>
	
	<script>
function openExchangeModal(orderId) {
    document.getElementById("exchangeModal").style.display = "block";
    document.getElementById("exchangeOrderId").value = orderId;
}

function closeModal() {
    document.getElementById("exchangeModal").style.display = "none";
}
</script>

</body>
</html>

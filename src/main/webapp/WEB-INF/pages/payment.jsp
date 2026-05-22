<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
</head>

<body>
	<!-- header -->
	<%@include file="header1.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>Payment Page</h2>
		</div>
	</div> -->
	<!-- //banner -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home"
						aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Checkout</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<div class="container">
		<h2>Select Payment Method</h2>

		<h4>
			Total: ₹
			<fmt:formatNumber value="${finalAmount}" maxFractionDigits="0" />
		</h4>

		<!-- <form action="/orderPlaced" method="post"> -->
		<form action="/payment" method="post" id="paymentForm">

			<input type="hidden" name="addressId" value="${selectedAddressId}">

			<!-- PAYMENT OPTIONS -->
			<div>

				<label> <input type="radio" name="paymentMethod" value="UPI"
					onclick="showOption('upi')"> Pay Full Amount Online
				</label> <br> <br> <label> <input type="radio"
					name="paymentMethod" value="PARTIAL_COD"
					onclick="showOption('partial_cod')"> Pay 50% Now & 50% On
					Delivery
				</label>

			</div>

			<hr>

			<div id="partial_codBox" style="display: none;">
				<p>Pay only 50% now. Remaining 50% will be collected at
					delivery.</p>
			</div>

			<br>

			<button type="button" onclick="handlePayment()"
				class="btn btn-success btn-block">Confirm Order</button>

		</form>
	</div>

	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

	<script>
	function showOption(type){

	    if(type === 'partial_cod'){
	        document.getElementById("partial_codBox").style.display = "block";
	    } else {
	        document.getElementById("partial_codBox").style.display = "none";
	    }
	}
</script>

	<!-- payment gateway -->

	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

	<script>

	function handlePayment(){

	    var selected =
	        document.querySelector('input[name="paymentMethod"]:checked');

	    if(!selected){
	        alert("Please select payment method");
	        return;
	    }

	    payNow();
	}


// ✅ Separate function
function payNow() {

    var paymentMethod =
        document.querySelector('input[name="paymentMethod"]:checked').value;

    var amountToPay = Math.round(${finalAmount});

    if(paymentMethod === "PARTIAL_COD"){
        amountToPay = Math.round(${finalAmount} / 2);
    }

    fetch("/create-order", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "amount=" + amountToPay
    })
    .then(res => res.json())
    .then(data => {

        var options = {
            key: "rzp_live_SjF1cX3eDU1byW",
            amount: data.amount,
            currency: "INR",
            name: "PooRah",
            description: "Order Payment",
            order_id: data.id,

            handler: function(response){

                var form = document.getElementById("paymentForm");

                var methodInput = document.createElement("input");
                methodInput.type = "hidden";
                methodInput.name = "paymentMethod";
                methodInput.value = paymentMethod;

                var paymentIdInput = document.createElement("input");
                paymentIdInput.type = "hidden";
                paymentIdInput.name = "razorpayPaymentId";
                paymentIdInput.value = response.razorpay_payment_id;

                var orderIdInput = document.createElement("input");
                orderIdInput.type = "hidden";
                orderIdInput.name = "razorpayOrderId";
                orderIdInput.value = response.razorpay_order_id;

                form.appendChild(methodInput);
                form.appendChild(paymentIdInput);
                form.appendChild(orderIdInput);

                form.action = "/orderPlaced";
                form.method = "post";
                form.submit();
            },

            theme: {
                color: "#ff3f6c"
            }
        };

        var rzp = new Razorpay(options);
        rzp.open();
    });
}

</script>



</body>
</html>
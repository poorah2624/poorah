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
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
</head>

<body>
	<!-- header -->
	<%@include file="header.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>Checkout</h2>
		</div>
	</div> -->
	<!-- //banner -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Checkout</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->
	
	<form action="payment"
					method="post">

	<div class="container" style="margin-top: 30px;">

		<div class="row">

			<!-- LEFT SIDE -->
			<div class="col-md-8">

				<!-- ADDRESS SECTION -->
				<h3>Select Delivery Address</h3>

				

					<c:forEach var="addr" items="${addresses}">
						<div class="panel panel-default">
							<div class="panel-body">

								<label> <input type="radio" name="addressId"
									value="${addr.addressId}"
									${addr.defaultAddress ? 'checked' : ''}> <b>${addr.fullName}</b>
									(${addr.mobile})<br> ${addr.houseNo}, ${addr.area},
									${addr.landmark}<br> ${addr.city}, ${addr.state} -
									${addr.pincode}<br> <span style="color: green;">
										${addr.addressType} </span>
								</label>

							</div>
						</div>
					</c:forEach>

					<a href="addAddress"
						class="btn btn-link">+ Add New Address</a>
			</div>

			<!-- RIGHT SIDE -->
			<div class="col-md-4">

				<h3>Order Summary</h3>

				<div class="panel panel-default">
					<div class="panel-body">

						<c:forEach var="c" items="${cartItems}">
							<p>
								${c.item.itemName} × ${c.quantity} <span style="float: right;">₹<fmt:formatNumber
										value="${c.totalPrice}" maxFractionDigits="0" />/-
								</span>
							</p>
						</c:forEach>

						<hr>

						<p>
							Subtotal <span style="float: right;">₹<fmt:formatNumber
									value="${grandTotal}" maxFractionDigits="0" />/-
							</span>
						</p>

						<p>
							Delivery <span style="float: right;"> <c:choose>
									<c:when test="${deliveryCharge == 0}">
                                    FREE
                                </c:when>
									<c:otherwise>
                                    ₹${deliveryCharge}
                                </c:otherwise>
								</c:choose>
							</span>
						</p>

						<hr>

						<h4>
							Total <span style="float: right;"><b>₹<fmt:formatNumber
										value="${finalAmount}" maxFractionDigits="0" />/-
							</b></span>
						</h4>

						<br>

						
							<button class="btn btn-success btn-block">Place Order</button>
						

					</div>
				</div>
				</div>

			

			

		</div>

	</div>
	</form>

	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

	<script>
		$(document).ready(function(c) {
			$('.close1').on('click', function(c) {
				$('.rem1').fadeOut('slow', function(c) {
					$('.rem1').remove();
				});
			});
		});
	</script>

	<!--quantity-->
	<script>
		$('.value-plus')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value'), newVal = parseInt(
									divUpd.text(), 10) + 1;
							divUpd.text(newVal);
						});

		$('.value-minus')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value'), newVal = parseInt(
									divUpd.text(), 10) - 1;
							if (newVal >= 1)
								divUpd.text(newVal);
						});
	</script>
	<!--quantity-->

</body>
</html>
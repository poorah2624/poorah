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
<style>
/* --- Modern Checkout Page Layout Styles --- */
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.checkout-section {
	padding: 30px 0;
}

.checkout-title {
	font-size: 20px;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 20px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* --- Premium Address Card Layout --- */
.address-card {
	background: #fff;
	border: 1px solid #e0e0e0;
	border-radius: 12px;
	padding: 20px;
	margin-bottom: 15px;
	cursor: pointer;
	position: relative;
	transition: all 0.2s ease;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
}

.address-card:hover {
	border-color: #ff9b05;
	background-color: #fffcf7;
}

.address-card input[type="radio"] {
	position: absolute;
	top: 22px;
	left: 20px;
	transform: scale(1.2);
	accent-color: #ff9b05;
}

.address-details {
	margin-left: 30px;
	cursor: pointer;
}

.address-name {
	font-size: 16px;
	font-weight: 700;
	color: #333;
	margin-bottom: 5px;
}

.address-text {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.address-type-badge {
	display: inline-block;
	background: #e6f7ed;
	color: #27ae60;
	font-size: 11px;
	font-weight: 700;
	padding: 3px 10px;
	border-radius: 20px;
	margin-top: 8px;
	text-transform: uppercase;
}

.btn-add-address {
	display: inline-block;
	color: #ff9b05;
	font-weight: 600;
	font-size: 15px;
	text-decoration: none;
	margin-top: 10px;
	padding: 10px 15px;
	border: 1px dashed #ff9b05;
	border-radius: 8px;
	background: #fff;
	transition: all 0.2s;
}

.btn-add-address:hover {
	background: #fffcf7;
	text-decoration: none;
	color: #d17d00;
}

/* --- Modern Order Summary Block --- */
.summary-card {
	background: #fff;
	border-radius: 16px;
	padding: 25px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	position: sticky;
	top: 20px;
}

.cart-item-row {
	padding: 15px 0;
	border-bottom: 1px solid #f5f5f5;
}

.cart-item-name {
	font-size: 14px;
	font-weight: 600;
	color: #2c3e50;
	margin-bottom: 4px;
}

.cart-item-price-meta {
	font-size: 13px;
	color: #7f8c8d;
}

/* 🌟 Item Level No Return Feature UI 🌟 */
.item-discount-toggle-box {
	background: #fffdf2;
	border: 1px dashed #ffeaa7;
	border-radius: 6px;
	padding: 6px 10px;
	margin-top: 8px;
	display: inline-block;
}
.item-discount-toggle-box label {
	font-size: 11px !important;
	font-weight: 700 !important;
	color: #b38200 !important;
	cursor: pointer;
	margin: 0;
}
.item-discount-toggle-box input[type="checkbox"] {
	margin-right: 5px;
	vertical-align: middle;
	accent-color: #ff9b05;
}

.price-breakdown {
	margin-top: 20px;
}

.price-row {
	display: flex;
	justify-content: space-between;
	font-size: 14px;
	color: #555;
	margin-bottom: 12px;
}

.price-row.final-total {
	font-size: 18px;
	font-weight: 700;
	color: #2c3e50;
	border-top: 1px dashed #ddd;
	padding-top: 15px;
	margin-top: 15px;
}

.btn-place-order {
	background-color: #ff9b05 !important;
	border-color: #ff9b05 !important;
	color: #fff !important;
	padding: 14px;
	font-size: 16px;
	font-weight: 700;
	border-radius: 8px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin-top: 20px;
	transition: all 0.2s;
}

.btn-place-order:hover {
	opacity: 0.9;
	box-shadow: 0 4px 12px rgba(255, 155, 5, 0.3);
}
</style>
</head>

<body>
	<!-- header -->
	<%@include file="header1.jsp"%>
	<!-- //header -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Checkout</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<form action="/payment" method="post" id="checkoutForm">
		<div class="container checkout-section">
			<div class="row">

				<!-- LEFT SIDE: Address Management -->
				<div class="col-md-8">
					<h3 class="checkout-title">Select Delivery Address</h3>

					<c:forEach var="addr" items="${addresses}" varStatus="status">
						<div class="address-card" onclick="document.getElementById('addr_${addr.addressId}').click();">
							<input type="radio" name="addressId" id="addr_${addr.addressId}" value="${addr.addressId}" ${addr.defaultAddress ? 'checked' : ''} onclick="event.stopPropagation();">
							
							<div class="address-details">
								<div class="address-name">
									${addr.fullName} 
									<span style="font-weight: normal; color: #7f8c8d; font-size: 13px; margin-left: 5px;">(${addr.mobile})</span>
								</div>
								<div class="address-text">
									${addr.houseNo}, ${addr.area}, ${addr.landmark}<br>
									${addr.city}, ${addr.state} - <b>${addr.pincode}</b>
								</div>
								<div>
									<span class="address-type-badge">${addr.addressType}</span>
								</div>
							</div>
						</div>
					</c:forEach>

					<a href="/addAddress" class="btn-add-address">
						<span class="glyphicon glyphicon-plus"></span> Add New Address
					</a>
				</div>

				<!-- RIGHT SIDE: Bill Details / Order Summary -->
				<div class="col-md-4">
					<h3 class="checkout-title">Order Summary</h3>

					<div class="summary-card">
						<!-- Items List Wrapper -->
						<div style="max-height: 320px; overflow-y: auto; padding-right: 5px;">
							<c:forEach var="c" items="${cartItems}" varStatus="loop">
								
								<c:set var="resolvedPrice" value="0" />
								<c:choose>
									<c:when var="isCustom" test="${c.isCustom}">
										<c:set var="resolvedPrice" value="${c.totalPrice}" />
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${not empty c.item.discountedPrice}">
												<c:set var="resolvedPrice" value="${c.item.discountedPrice}" />
											</c:when>
											<c:otherwise>
												<c:set var="resolvedPrice" value="${c.item.itemPrice}" />
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>

								<div class="cart-item-row item-calculation-bucket" 
									 data-index="${loop.index}" 
									 data-original-total="${resolvedPrice * c.quantity}">
									
									<c:choose>
										<c:when test="${c.isCustom}">
											<div class="cart-item-name">Custom T-Shirt</div>
											<div class="cart-item-meta text-muted" style="font-size:13px;">Qty: ${c.quantity}</div>
										</c:when>
										<c:otherwise>
											<div class="cart-item-name">${c.item.itemName}</div>
											<div class="cart-item-price-meta">Qty: ${c.quantity} &times; ₹<fmt:formatNumber value="${resolvedPrice}" maxFractionDigits="0" /></div>
										</c:otherwise>
									</c:choose>

									<!-- 🌟 ITEM LEVEL NO RETURN OPTION CHECKBOX 🌟 -->
									<div class="item-discount-toggle-box">
										<label>
											<input type="checkbox" class="no-return-item-trigger" onchange="recalculateSummaryPrice()">
											🔒 Extra 8% Off (No Return Only Exchange)
										</label>
									</div>

									
									<div id="itemDisplayPrice_${loop.index}" style="text-align: right; font-weight: 600; color: #2c3e50; margin-top: -22px;">
										
										₹<fmt:formatNumber value="${resolvedPrice * c.quantity}" maxFractionDigits="0" />/-
									</div>
								</div>
							</c:forEach>
						</div>

						<!-- Price Breakdown Detail Block -->
						<div class="price-breakdown">
							<div class="price-row">
								<span>Subtotal</span>
								<span id="summarySubtotal">₹<fmt:formatNumber value="${grandTotal}" maxFractionDigits="0" />/-</span>
							</div>
							<div class="price-row">
								<span>Delivery Charges</span>
								<span id="summaryDelivery" style="color: ${deliveryCharge == 0 ? '#27ae60' : '#555'}; font-weight: ${deliveryCharge == 0 ? '700' : 'normal'};">
									<c:choose>
										<c:when test="${deliveryCharge == 0}">FREE</c:when>
										<c:otherwise>₹${deliveryCharge}/-</c:otherwise>
									</c:choose>
								</span>
							</div>
							
							<div class="price-row final-total">
								<span>Total Amount</span>
								<span id="summaryFinalAmount" style="color: #ff9b05;">₹<fmt:formatNumber value="${finalAmount}" maxFractionDigits="0" />/-</span>
							</div>
						</div>

						<input type="hidden" id="noReturnDiscountHidden" name="noReturnDiscount" value="NO">

						<button type="submit" class="btn btn-success btn-block btn-place-order">Proceed to Payment</button>
					</div>
				</div>

			</div>
		</div>
	</form>

	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

	<script>
		
		function recalculateSummaryPrice() {
			let grandTotal = 0;
			let selectedOfferFlags = [];

		
			document.querySelectorAll('.item-calculation-bucket').forEach(function(bucket) {
				let index = bucket.getAttribute('data-index');
				let originalTotal = parseFloat(bucket.getAttribute('data-original-total'));
				let checkbox = bucket.querySelector('.no-return-item-trigger');
				
				let effectiveItemTotal = originalTotal;

				if (checkbox.checked) {
			
					effectiveItemTotal = originalTotal - (originalTotal * 0.08);
					selectedOfferFlags.push("YES");
				} else {
					selectedOfferFlags.push("NO");
				}

		
				effectiveItemTotal = Math.round(effectiveItemTotal);
				document.getElementById('itemDisplayPrice_' + index).innerText = "₹" + effectiveItemTotal + "/-";
				
				grandTotal += effectiveItemTotal;
			});

		
			let deliveryCharge = (grandTotal > 500 || grandTotal === 0) ? 0 : 50;
			let finalAmount = grandTotal + deliveryCharge;

		
			document.getElementById('summarySubtotal').innerText = "₹" + grandTotal + "/-";
			
			let deliveryElement = document.getElementById('summaryDelivery');
			if (deliveryCharge === 0) {
				deliveryElement.innerText = "FREE";
				deliveryElement.style.color = "#27ae60";
				deliveryElement.style.fontWeight = "700";
			} else {
				deliveryElement.innerText = "₹" + deliveryCharge + "/-";
				deliveryElement.style.color = "#555";
				deliveryElement.style.fontWeight = "normal";
			}

			document.getElementById('summaryFinalAmount').innerText = "₹" + finalAmount + "/-";

		
			document.getElementById('noReturnDiscountHidden').value = selectedOfferFlags.join(",");
		}

		document.getElementById("checkoutForm").addEventListener("submit", function(e) {
			let selectedAddress = document.querySelector('input[name="addressId"]:checked');
			if (!selectedAddress) {
				e.preventDefault();
				alert("Please select or add a delivery address before placing order.");
			}
		});

	
		document.querySelectorAll('input[name="addressId"]').forEach(radio => {
			radio.addEventListener('change', function() {
				document.querySelectorAll('.address-card').forEach(card => {
					card.style.borderColor = "#e0e0e0";
					card.style.backgroundColor = "#ffffff";
				});
				if(this.checked) {
					let targetCard = this.closest('.address-card');
					targetCard.style.borderColor = "#ff9b05";
					targetCard.style.backgroundColor = "#fffcf7";
				}
			});
		});
	</script>
</body>
</html>
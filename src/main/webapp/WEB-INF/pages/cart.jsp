<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<title>PooRah Fashion - Your Cart</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="head.jsp"%>

<style>
/* Premium Modern Cart Styling */
body {
	background-color: #fbfbfc;
}

.checkout {
	padding: 40px 0;
}

.cart-title {
	font-size: 26px;
	font-weight: 700;
	margin-bottom: 30px;
	color: #212121;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* Layout Structure */
.modern-cart-container {
	display: grid;
	grid-template-columns: 1fr 380px;
	gap: 30px;
	align-items: start;
}

.cart-items-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

/* Modern Product Cards */
.cart-card, .custom-cart-card {
	display: flex;
	background: #ffffff;
	border-radius: 12px;
	padding: 20px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
	border: 1px solid #f0f0f0;
	position: relative;
	transition: transform 0.2s ease;
}

.cart-card:hover, .custom-cart-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
}

.cart-img, .custom-img {
	width: 130px;
	height: 165px;
	min-width: 130px;
	border-radius: 8px;
	overflow: hidden;
	background: #f7f7f7;
	position: relative;
}

.cart-img img, .custom-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.custom-badge {
	position: absolute;
	top: 8px;
	left: 8px;
	background: rgba(0, 0, 0, 0.75);
	color: #fff;
	padding: 4px 8px;
	font-size: 10px;
	font-weight: 600;
	border-radius: 20px;
	backdrop-filter: blur(2px);
}

/* Product Details */
.cart-details, .custom-details {
	padding-left: 24px;
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.brand {
	font-size: 12px;
	font-weight: 700;
	color: #878787;
	letter-spacing: 1px;
	margin-bottom: 4px;
}

.title, .custom-details h3 {
	font-size: 16px;
	font-weight: 600;
	color: #2c2c2c;
	margin: 0 0 8px 0;
	line-height: 1.4;
}

.meta-info {
	font-size: 13px;
	color: #666;
	margin-bottom: 12px;
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
}

.meta-info span {
	background: #f5f5f5;
	padding: 3px 8px;
	border-radius: 4px;
}

/* Pricing Section */
.price-wrapper {
	display: flex;
	align-items: baseline;
	gap: 10px;
	margin-bottom: 15px;
}

.final-price {
	font-size: 18px;
	font-weight: 700;
	color: #212121;
}

.old-price {
	font-size: 14px;
	color: #999;
	text-decoration: line-through;
}

.discount {
	font-size: 13px;
	color: #ff5722;
	font-weight: 600;
}

/* Modern Quantity & Delete Row */
.action-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: auto;
}

.qty-selector {
	display: flex;
	align-items: center;
	border: 1px solid #ddd;
	border-radius: 6px;
	overflow: hidden;
	background: #fff;
}

.qty-selector button {
	background: #f8f9fa;
	border: none;
	width: 32px;
	height: 32px;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.2s;
}

.qty-selector button:hover {
	background: #e9ecef;
}

.qty-selector input {
	width: 40px;
	height: 32px;
	text-align: center;
	border: none;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	font-weight: 600;
	-moz-appearance: textfield;
}

.qty-selector input::-webkit-outer-spin-button, .qty-selector input::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.update-link-btn {
	background: none;
	border: none;
	color: #ff9800;
	font-weight: 600;
	font-size: 13px;
	margin-left: 10px;
	cursor: pointer;
}

.update-link-btn:hover {
	text-decoration: underline;
}

.delete-btn {
	color: #ff4d4f;
	font-size: 18px;
	text-decoration: none !important;
	padding: 5px 10px;
	border-radius: 6px;
	transition: background 0.2s;
}

.delete-btn:hover {
	background: #fff1f0;
}

/* Sidebar Order Summary Card */
.cart-summary-card {
	background: #ffffff;
	border-radius: 12px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
	border: 1px solid #f0f0f0;
}

.summary-title {
	font-size: 18px;
	font-weight: 700;
	margin-bottom: 20px;
	border-bottom: 1px solid #f0f0f0;
	padding-bottom: 12px;
	color: #212121;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 14px;
	font-size: 14px;
	color: #666;
}

.summary-row.total-row {
	border-top: 1px dashed #ddd;
	padding-top: 15px;
	margin-top: 15px;
	font-size: 18px;
	font-weight: 700;
	color: #212121;
}

.delivery-tip {
	font-size: 12px;
	margin-top: 8px;
	padding: 10px;
	border-radius: 6px;
	text-align: center;
}

/* Checkout CTA Buttons */
.checkout-actions {
	display: flex;
	flex-direction: column;
	gap: 12px;
	margin-top: 24px;
}

.btn-checkout {
	background: #ff9800;
	color: #fff !important;
	font-weight: 600;
	padding: 14px;
	border-radius: 8px;
	text-align: center;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	font-size: 14px;
	border: none;
	transition: background 0.2s;
}

.btn-checkout:hover {
	background: #e68a00;
}

.btn-continue {
	background: #fff;
	color: #555 !important;
	font-weight: 600;
	padding: 12px;
	border-radius: 8px;
	text-align: center;
	font-size: 14px;
	border: 1px solid #ddd;
	transition: all 0.2s;
}

.btn-continue:hover {
	background: #f8f9fa;
	border-color: #bbb;
}

/* Responsive Design */
@media ( max-width : 991px) {
	.modern-cart-container {
		grid-template-columns: 1fr;
	}
	.cart-summary-card {
		position: static;
	}
}

@media ( max-width : 480px) {
	.cart-card, .custom-cart-card {
		flex-direction: column;
		gap: 15px;
	}
	.cart-img, .custom-img {
		width: 100%;
		height: 200px;
	}
	.cart-details, .custom-details {
		padding-left: 0;
	}
}
</style>
</head>

<body>
	<%@include file="header1.jsp"%>
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home"
						aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Cart</li>
			</ul>
		</div>
	</div>
	<div class="checkout">
		<div class="container">
			<h3 class="cart-title">Your Shopping Cart</h3>

			<div class="modern-cart-container">

				<div class="cart-items-list">
					<c:forEach var="c" items="${cartItems}" varStatus="status">
						<c:choose>

							<%-- CUSTOM PRODUCT CARD --%>
							<c:when test="${c.isCustom}">
								<div class="custom-cart-card">
									<div class="custom-img">
										<img src="${c.customImage}" alt="Custom Design" /> <span
											class="custom-badge">Your Design 🎨</span>
									</div>

									<div class="custom-details">
										<div>
											<h3>Custom T-Shirt</h3>
											<div class="meta-info">
												<span><b>Size:</b> ${c.size}</span> <span><b>Color:</b>
													${c.color}</span> <span><b>Type:</b> ${c.tshirtType}</span> <span><b>Gender:</b>
													${c.gender}</span>
											</div>
											<c:if test="${not empty c.customNote}">
												<p style="font-size: 12px; color: #666; margin-top: 5px;">
													<i class="glyphicon glyphicon-comment"></i> <b>Note:</b>
													${c.customNote}
												</p>
											</c:if>
										</div>

										<div class="action-row">
											<div class="final-price">
												<c:if test="${not empty c.totalPrice}">₹ ${c.totalPrice}</c:if>
											</div>
											<a href="/DeleteCart/${c.cartId}" class="delete-btn"
												title="Remove Item">🗑</a>
										</div>
									</div>
								</div>
							</c:when>

							<%-- STANDARD PRODUCT CARD --%>
							<c:otherwise>
								<div class="cart-card">
									<div class="cart-img">
										<img src="${fn:split(c.item.itemImage, ',')[0]}"
											alt="${c.item.itemName}" />
									</div>

									<div class="cart-details">
										<div>
											<div class="brand">POORAH</div>
											<h3 class="title">${c.item.itemName}</h3>

											<div class="meta-info">
												<c:if
													test="${c.item.category.categoryName == 'Men' || c.item.category.categoryName == 'Women'}">
													<span><b>Size:</b> ${c.size}</span>
												</c:if>
												<span><b>Qty:</b> ${c.quantity}</span>
											</div>

											<div class="price-wrapper">
												<div class="final-price">
													<c:if test="${not empty c.totalPrice}">₹ ${c.totalPrice}</c:if>
												</div>
												<span class="old-price">₹ ${c.item.itemPrice}</span> <span
													class="discount">${c.item.discount}% OFF</span>
											</div>
										</div>

										<div class="action-row">
											<form action="/UpdateQuantity" method="post"
												style="display: flex; align-items: center;">
												<input type="hidden" name="itemId" value="${c.item.itemId}">
												<input type="hidden" name="userEmail"
													value="${c.user.userEmail}"> <input type="hidden"
													name="size" value="${c.size}">

												<div class="qty-selector">
													<button type="button"
														onclick="this.nextElementSibling.stepDown()">-</button>
													<input type="number" name="quantity" value="${c.quantity}"
														min="1">
													<button type="button"
														onclick="this.previousElementSibling.stepUp()">+</button>
												</div>
												<button type="submit" class="update-link-btn">Update</button>
											</form>

											<a href="/DeleteCart/${c.cartId}" class="delete-btn"
												title="Remove Item">🗑</a>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>

				<div class="cart-summary-card">
					<div class="summary-title">Price Details</div>

					<div class="summary-row">
						<span>Bag Total</span> <span>₹ ${grandTotal}</span>
					</div>

					<div class="summary-row">
						<span>Delivery Charges</span> <span
							style="color: ${deliveryCharge == 0 ? 'green' : '#666'}; font-weight: ${deliveryCharge == 0 ? '600' : 'normal'};">
							<c:choose>
								<c:when test="${deliveryCharge == 0}">FREE</c:when>
								<c:otherwise>₹ ${deliveryCharge}</c:otherwise>
							</c:choose>
						</span>
					</div>

					<c:if test="${grandTotal < 500}">
						<div class="delivery-tip"
							style="background: #fff3cd; color: #856404;">
							Add <b>₹${500 - grandTotal}</b> more to get FREE Delivery 🚚
						</div>
					</c:if>
					<c:if test="${grandTotal >= 500}">
						<div class="delivery-tip"
							style="background: #d4edda; color: #155724;">🎉 You qualify
							for FREE Delivery!</div>
					</c:if>

					<div class="summary-row total-row">
						<span>Total Amount</span> <span>₹ ${finalAmount}</span>
					</div>

					<div class="checkout-actions">
						<a href="/checkout" class="btn-checkout">Proceed to Checkout</a> <a
							href="/products2" class="btn-continue"> <span
							class="glyphicon glyphicon-menu-left"></span> Continue Shopping
						</a>
					</div>
				</div>

			</div>
		</div>
	</div>

	<%@include file="footer.jsp"%>
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$(".scroll").click(function(event) {
				event.preventDefault();
				$('html,body').animate({
					scrollTop : $(this.hash).offset().top
				}, 1000);
			});
		});
	</script>
</body>
</html>
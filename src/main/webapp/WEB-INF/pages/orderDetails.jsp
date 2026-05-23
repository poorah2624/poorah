<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Order Details - PooRah Fashion</title>
<%@include file="head.jsp"%>

<style>
body {
	background-color: #f7f9fa;
}

.profile-section {
	padding: 40px 0;
}

.page-title {
	font-size: 24px;
	font-weight: 700;
	color: #212121;
	margin-bottom: 30px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* 2-Column Split Layout */
.order-container {
	display: grid;
	grid-template-columns: 1fr 380px;
	gap: 30px;
	align-items: start;
}

/* Box Wrappers */
.detail-card {
	background: #ffffff;
	border-radius: 12px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
	border: 1px solid #f0f0f0;
	margin-bottom: 25px;
}

.product-split {
	display: flex;
	gap: 25px;
}

.product-img-box {
	width: 140px;
	min-width: 140px;
	height: 180px;
	border-radius: 8px;
	overflow: hidden;
	border: 1px solid #eee;
}

.product-img-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.product-info-box {
	flex: 1;
}

.product-info-box h3 {
	font-size: 18px;
	font-weight: 600;
	color: #2c2c2c;
	margin: 0 0 10px 0;
}

.price-tag {
	font-size: 20px;
	font-weight: 700;
	color: #212121;
	margin-bottom: 12px;
}

.meta-p {
	font-size: 14px;
	color: #666;
	margin: 4px 0;
}

/* Badge Status Elements */
.status-badge {
	display: inline-block;
	padding: 6px 14px;
	font-size: 12px;
	font-weight: 600;
	border-radius: 20px;
	margin-top: 8px;
}

/* Action Buttons Row */
.action-group {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
	margin-top: 20px;
}

.btn-action {
	font-weight: 600;
	font-size: 13px;
	padding: 10px 20px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	transition: background 0.2s;
}

.btn-cancel {
	background: #ff4d4f;
	color: #fff;
}

.btn-cancel:hover {
	background: #d9363e;
}

.btn-undo {
	background: #e6f7ff;
	color: #1890ff;
	border: 1px solid #91d5ff;
}

.btn-undo:hover {
	background: #bae7ff;
}

.btn-return {
	background: #fff7e6;
	color: #fa8c16;
	border: 1px solid #ffd591;
}

.btn-return:hover {
	background: #ffe7ba;
}

.btn-exchange {
	background: #f0f5ff;
	color: #2f54eb;
	border: 1px solid #adc6ff;
}

.btn-exchange:hover {
	background: #d6e4ff;
}

/* Info Rows */
.info-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	font-size: 14px;
	color: #555;
}

.info-row b {
	color: #222;
}

/* Address Box styling */
.address-box {
	background: #f8f9fa;
	border-radius: 8px;
	padding: 15px;
	font-size: 14px;
	line-height: 1.6;
	color: #444;
	border: 1px solid #e9ecef;
}

/* ---------------------------------
       MODERN TRACK STEPPER 
    --------------------------------- */
.track-wrapper {
	display: flex;
	flex-direction: column;
	gap: 20px;
	position: relative;
	padding-left: 30px;
	margin-top: 20px;
}

.track-wrapper::before {
	content: '';
	position: absolute;
	left: 9px;
	top: 5px;
	bottom: 5px;
	width: 2px;
	background: #e8e8e8;
}

.track-step {
	position: relative;
	display: flex;
	flex-direction: column;
}

.track-step .circle-node {
	position: absolute;
	left: -30px;
	top: 0;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background: #fff;
	border: 2px solid #ccc;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 10px;
	color: #fff;
	z-index: 2;
}

.track-step p {
	margin: 0;
	font-size: 14px;
	font-weight: 500;
	color: #8c8c8c;
}

/* Active State Control via Controller Variable */
.track-step.active .circle-node {
	background: #52c41a;
	border-color: #52c41a;
}

.track-step.active p {
	color: #222;
	font-weight: 600;
}

/* Special status overlays */
.alert-banner {
	background: #f0f7ff;
	padding: 12px 15px;
	border-radius: 8px;
	border-left: 4px solid #1890ff;
	margin-top: 15px;
	font-size: 13px;
}

/* ---------------------------------
       MODERN MODALS (POP-UPS)
    --------------------------------- */
.custom-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	backdrop-filter: blur(4px);
	z-index: 10000;
}

.modal-content-card {
	background: white;
	width: 100%;
	max-width: 450px;
	margin: 12% auto;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.modal-content-card h3 {
	margin-top: 0;
	margin-bottom: 20px;
	font-size: 18px;
	font-weight: 700;
}

.modal-content-card textarea {
	width: 100%;
	height: 90px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	resize: none;
	font-family: inherit;
}

.modal-content-card select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	margin-bottom: 15px;
}

.modal-btn-row {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 20px;
}

/* Responsive */
@media ( max-width : 991px) {
	.order-container {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 480px) {
	.product-split {
		flex-direction: column;
	}
	.product-img-box {
		width: 100%;
		height: 220px;
	}
}
</style>
</head>
<body>
	<%@include file="header1.jsp"%>

	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home.jsp"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Order Details</li>
			</ul>
		</div>
	</div>

	<div class="profile-section">
		<div class="container">
			<h2 class="page-title">Order Item Details</h2>

			<div class="order-container">

				<div>

					<div class="detail-card">
						<div class="product-split">
							<div class="product-img-box">
								<img src="${fn:split(item.item.itemImage, ',')[0]}"
									alt="Product Image">
							</div>

							<div class="product-info-box">
								<h3>${item.item.itemName}</h3>
								<div class="price-tag">
									₹
									<fmt:formatNumber value="${item.finalPrice}"
										maxFractionDigits="0" />
								</div>
								<c:if test="${item.order.noReturnOrder}">
									<div
										style="background: #fff7e6; color: #d46b08; padding: 6px 10px; border-radius: 6px; margin-top: 8px; display: inline-block; font-size: 12px; font-weight: 600;">
										₹50 Discount Applied • No Return Order</div>
								</c:if>
								<p class="meta-p">
									<b>Quantity:</b> ${item.quantity}
								</p>

								<c:choose>
									<c:when test="${item.item.category.categoryName == 'Kids'}">
										<p class="meta-p">
											<b>Age:</b> ${item.age}
										</p>
									</c:when>
									<c:otherwise>
										<p class="meta-p">
											<b>Size:</b> ${item.size}
										</p>
									</c:otherwise>
								</c:choose>

								<c:set var="statusColor" value="#ff9800" />
								<c:set var="statusBg" value="#fff7e6" />
								<c:choose>
									<c:when test="${item.returnRequested}">
										<c:set var="statusColor" value="#1890ff" />
										<c:set var="statusBg" value="#e6f7ff" />
									</c:when>
									<c:when test="${item.order.status == 'Delivered'}">
										<c:set var="statusColor" value="#52c41a" />
										<c:set var="statusBg" value="#f6ffed" />
									</c:when>
									<c:when test="${item.order.status == 'Cancelled'}">
										<c:set var="statusColor" value="#ff4d4f" />
										<c:set var="statusBg" value="#fff1f0" />
									</c:when>
								</c:choose>

								<span class="status-badge"
									style="color: ${statusColor}; background: ${statusBg};">
									<c:choose>
										<c:when test="${item.returnRequested}">Return Status: ${item.returnStatus}</c:when>
										<c:otherwise>${item.order.status}</c:otherwise>
									</c:choose>
								</span>

								<c:if test="${item.status == 'Returned'}">
									<p style="color: #ff4d4f; font-size: 13px; margin-top: 10px;">
										<b>Refund Status:</b> ${item.refundStatus}
									</p>
								</c:if>
								<c:if test="${item.order.status == 'Cancelled'}">
									<p style="color: #ff4d4f; font-size: 13px; margin-top: 10px;">
										<b>Refund Status:</b> ${item.refundStatus}
									</p>
								</c:if>
								<c:if test="${item.exchangeRequested}">
									<div class="alert-banner">
										<b>🔄 Exchange in progress</b><br>Expected Delivery:
										${item.exchangeDeliveryDate}
									</div>
								</c:if>

								<div class="action-group">
									<c:if
										test="${item.status == 'Pending' || item.status == 'Processing' || item.status == 'Packed'}">
										<form method="post" action="/order/cancel-item">
											<input type="hidden" name="orderItemId" value="${item.id}">
											<button class="btn-action btn-cancel">Cancel Order</button>
										</form>
									</c:if>

									<c:if
										test="${item.status == 'Cancelled' && item.refundStatus != 'Processed'}">
										<form action="/order/revert-cancel" method="post">
											<input type="hidden" name="orderItemId" value="${item.id}">
											<button class="btn-action btn-undo">Undo Cancel</button>
										</form>
									</c:if>

									<c:if
										test="${!item.returnRequested 
              && item.order.status == 'Delivered'
              && !item.order.noReturnOrder}">
										<button onclick="openReturnModal('${item.id}')"
											class="btn-action btn-return">Return Item</button>
									</c:if>

									<c:if test="${item.order.noReturnOrder}">
										<div class="alert-banner"
											style="background: #fff7e6; border-left: 4px solid #fa8c16;">
											₹50 discount applied. This order is not eligible for return.
										</div>
									</c:if>

									<c:if
										test="${item.returnStatus == 'Requested' || item.returnStatus == 'Approved'}">
										<form action="/order/revert-return" method="post">
											<input type="hidden" name="orderItemId" value="${item.id}">
											<button class="btn-action btn-undo">Cancel Return
												Request</button>
										</form>
									</c:if>

									<c:if
										test="${!item.exchangeRequested && item.order.status == 'Delivered'}">
										<button onclick="openExchangeModal('${item.id}')"
											class="btn-action btn-exchange">Exchange Item</button>
									</c:if>

									<c:if
										test="${item.exchangeStatus == 'Requested' || item.exchangeStatus == 'Approved'}">
										<form action="/order/revert-exchange" method="post">
											<input type="hidden" name="orderItemId" value="${item.id}">
											<button class="btn-action btn-undo">Cancel Exchange</button>
										</form>
									</c:if>
								</div>
							</div>
						</div>
					</div>

					<div class="detail-card">
						<h3
							style="font-size: 16px; font-weight: 700; margin-bottom: 20px;">Track
							Order Timeline</h3>

						<div class="track-wrapper">
							<div
								class="track-step ${item.order.orderDate != null ? 'active' : ''}">
								<div class="circle-node">✓</div>
								<p>Order Placed</p>
							</div>

							<div
								class="track-step ${item.order.packedDate != null ? 'active' : ''}">
								<div class="circle-node">✓</div>
								<p>Packed</p>
							</div>

							<div
								class="track-step ${item.order.shippedDate != null ? 'active' : ''}">
								<div class="circle-node">✓</div>
								<p>Shipped</p>
							</div>

							<div
								class="track-step ${item.order.status eq 'Out for delivery' ? 'active' : ''}">
								<div class="circle-node">🚚</div>
								<p>Out for Delivery</p>
							</div>

							<div
								class="track-step ${item.order.deliveredDate != null ? 'active' : ''}">
								<div class="circle-node">🎉</div>
								<p>Delivered</p>
							</div>

							<c:if test="${item.status eq 'Cancelled'}">
								<div class="track-step active">
									<div class="circle-node"
										style="background: #ff4d4f; border-color: #ff4d4f;">❌</div>
									<p>Order Cancelled</p>
								</div>
								<div
									class="track-step ${item.refundStatus eq 'Processed' ? 'active' : ''}">
									<div class="circle-node">💰</div>
									<p>Refund Completed</p>
								</div>
							</c:if>

							<c:if test="${item.returnRequested}">
								<div class="track-step active">
									<div class="circle-node">🔁</div>
									<p>Return Requested</p>
								</div>
								<div
									class="track-step ${item.returnStatus eq 'Approved' ? 'active' : ''}">
									<div class="circle-node">✓</div>
									<p>Return Approved</p>
								</div>
								<div
									class="track-step ${item.returnStatus eq 'Picked' ? 'active' : ''}">
									<div class="circle-node">📦</div>
									<p>Item Picked Up</p>
								</div>
								<div
									class="track-step ${item.refundStatus eq 'Processed' ? 'active' : ''}">
									<div class="circle-node">💰</div>
									<p>Refund Completed</p>
								</div>
							</c:if>

							<c:if test="${item.exchangeRequested}">
								<div class="track-step active">
									<div class="circle-node">🔄</div>
									<p>Exchange Requested</p>
								</div>
								<div
									class="track-step ${item.exchangeStatus eq 'Approved' ? 'active' : ''}">
									<div class="circle-node">✓</div>
									<p>Exchange Approved</p>
								</div>
								<div
									class="track-step ${item.exchangeStatus eq 'Shipped' ? 'active' : ''}">
									<div class="circle-node">🚚</div>
									<p>New Item Shipped</p>
								</div>
								<div
									class="track-step ${item.exchangeStatus eq 'Delivered' ? 'active' : ''}">
									<div class="circle-node">🎉</div>
									<p>Exchange Delivered</p>
								</div>
							</c:if>
						</div>
					</div>
				</div>

				<div>
					<div class="cart-summary-card"
						style="background: #fff; border-radius: 12px; padding: 24px; border: 1px solid #f0f0f0; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);">
						<div class="summary-title"
							style="font-size: 16px; font-weight: 700; border-bottom: 1px solid #f0f0f0; padding-bottom: 12px; margin-bottom: 15px;">Order
							Info Summary</div>

						<div class="info-row">
							<span>Order Number:</span> <b>${item.order.orderNumber}</b>
						</div>
						<div class="info-row">
							<span>Date:</span> <b>${item.order.orderDate}</b>
						</div>
						<div class="info-row">
							<span>Payment Method:</span> <b>${item.order.paymentMethod}</b>
						</div>
						<div class="info-row">
							<span>Payment Status:</span> <b style="color: green;">${item.order.paymentStatus}</b>
						</div>

						<div class="info-row"
							style="border-top: 1px dashed #eee; padding-top: 10px; margin-top: 10px; font-size: 15px;">
							<span>Paid Amount:</span> <b
								style="font-size: 16px; color: #222;">₹ <fmt:formatNumber
									value="${item.order.payment.amount}" maxFractionDigits="0" /></b>
						</div>

						<div style="margin-top: 25px;">
							<h4
								style="font-size: 14px; font-weight: 700; color: #444; margin-bottom: 10px;">Shipping
								Address</h4>
							<div class="address-box">
								<b>${item.order.address.fullName}</b><br> Mobile:
								${item.order.address.mobile}<br>
								${item.order.address.houseNo}, ${item.order.address.area}<br>
								Landmark: ${item.order.address.landmark}<br>
								${item.order.address.city}, ${item.order.address.state} - <b>${item.order.address.pincode}</b>
							</div>
						</div>

						<div style="margin-top: 25px;">
							<a href="/order/invoice/${item.id}"
								class="btn btn-success btn-block"
								style="font-weight: 600; padding: 12px;" target="_blank"> 📄
								Download Invoice </a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<div id="returnModal" class="custom-modal">
		<div class="modal-content-card">
			<h3>Return Product</h3>
			<form method="post" action="/order/return">
				<input type="hidden" id="returnItemId" name="orderItemId"> <label
					style="font-size: 13px; color: #555; display: block; margin-bottom: 8px;">Reason
					for return:</label>
				<textarea name="reason" placeholder="Write reason here..." required></textarea>
				<div class="modal-btn-row">
					<button type="button" class="btn btn-default"
						onclick="closeModal()">Cancel</button>
					<button type="submit" class="btn btn-warning"
						style="font-weight: 600;">Submit Request</button>
				</div>
			</form>
		</div>
	</div>

	<div id="exchangeModal" class="custom-modal">
		<div class="modal-content-card">
			<h3>Exchange Product</h3>
			<form method="post" action="/order/exchange">
				<input type="hidden" id="exchangeItemId" name="orderItemId">

				<label
					style="font-size: 13px; color: #555; display: block; margin-bottom: 5px;">Select
					New Size:</label> <select name="newSize" required>
					<option value="">Choose Size</option>
					<option>S</option>
					<option>M</option>
					<option>L</option>
					<option>XL</option>
				</select> <label
					style="font-size: 13px; color: #555; display: block; margin-bottom: 8px;">Reason
					for exchange:</label>
				<textarea name="reason" placeholder="Write reason here..." required></textarea>

				<div class="modal-btn-row">
					<button type="button" class="btn btn-default"
						onclick="closeModal()">Cancel</button>
					<button type="submit" class="btn btn-primary"
						style="font-weight: 600; background: #2874f0;">Submit
						Exchange</button>
				</div>
			</form>
		</div>
	</div>

	<%@include file="footer.jsp"%>

	<script>
		function openReturnModal(id) {
			document.getElementById("returnModal").style.display = "block";
			document.getElementById("returnItemId").value = id;
		}

		function openExchangeModal(id) {
			document.getElementById("exchangeModal").style.display = "block";
			document.getElementById("exchangeItemId").value = id;
		}

		function closeModal() {
			document.getElementById("returnModal").style.display = "none";
			document.getElementById("exchangeModal").style.display = "none";
		}

		// Close popups when clicking anywhere outside the card box
		window.onclick = function(event) {
			var modal1 = document.getElementById("returnModal");
			var modal2 = document.getElementById("exchangeModal");
			if (event.target == modal1) {
				modal1.style.display = "none";
			}
			if (event.target == modal2) {
				modal2.style.display = "none";
			}
		}
	</script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Orders - PooRah</title>
<%@include file="head.jsp"%>

<style>
body {
	background-color: #f8f9fa;
}

.profile-container {
	margin: 40px auto;
}

.order-card {
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	border: 1px solid #eef2f5;
	margin-bottom: 25px;
	overflow: hidden;
	transition: transform 0.2s;
}

.order-card:hover {
	transform: translateY(-2px);
}

.order-header {
	background: #fafbfc;
	padding: 15px 20px;
	border-bottom: 1px solid #edf2f7;
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 10px;
}

.order-id {
	font-weight: 700;
	color: #1a202c;
	font-size: 15px;
}

.payment-badge {
	background: #e2e8f0;
	color: #4a5568;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	text-transform: uppercase;
}

.order-body {
	padding: 20px;
}

.item-row {
	display: flex;
	align-items: center;
	padding: 15px 0;
	border-bottom: 1px dashed #e2e8f0;
}

.item-row:last-child {
	border-bottom: none;
	padding-bottom: 0;
}

.item-row:first-child {
	padding-top: 0;
}

.product-img {
	width: 75px;
	height: 95px;
	object-fit: cover;
	border-radius: 8px;
	border: 1px solid #edf2f7;
	margin-right: 20px;
}

.item-details {
	flex: 1;
}

.item-name {
	font-size: 16px;
	font-weight: 600;
	color: #2d3748;
	margin-bottom: 5px;
}

.item-meta {
	font-size: 13px;
	color: #718096;
	margin-bottom: 5px;
}

.item-price {
	font-size: 15px;
	font-weight: 700;
	color: #1a202c;
}

.action-area {
	text-align: right;
	min-width: 160px;
}

/* Premium Buttons Setup */
.btn-custom-view {
	background: #ffffff;
	color: #2d3748;
	border: 1px solid #cbd5e0;
	padding: 7px 14px;
	border-radius: 6px;
	font-weight: 500;
	font-size: 13px;
	width: 100%;
	margin-bottom: 8px;
	transition: all 0.2s;
}

.btn-custom-view:hover {
	background: #f7fafc;
	border-color: #a0aec0;
}

.btn-action-cancel {
	background: #fff5f5;
	color: #e53e3e;
	border: 1px solid #fed7d7;
	padding: 7px 14px;
	border-radius: 6px;
	font-weight: 600;
	font-size: 13px;
	width: 100%;
	cursor: pointer;
}

.btn-action-cancel:hover {
	background: #e53e3e;
	color: #fff;
}

.btn-action-blue {
	background: #ebf8ff;
	color: #3182ce;
	border: 1px solid #bee3f8;
	padding: 7px 14px;
	border-radius: 6px;
	font-weight: 600;
	font-size: 13px;
	width: 100%;
}

.btn-action-blue:hover {
	background: #3182ce;
	color: #fff;
}

/* Modal Modern Custom Styling */
.modal-wrapper {
	background: white;
	width: 100%;
	max-width: 420px;
	margin: 12% auto;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.modal-wrapper textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	border-radius: 6px;
	border: 1px solid #cbd5e0;
	resize: none;
	margin-top: 10px;
}

.modal-wrapper select {
	width: 100%;
	padding: 10px;
	border-radius: 6px;
	border: 1px solid #cbd5e0;
	margin-top: 10px;
}

.modal-btn-group {
	display: flex;
	gap: 10px;
	margin-top: 20px;
}

@media ( max-width : 768px) {
	.profile-container .row {
		display: block !important;
	}
	.item-row {
		flex-direction: column !important;
		align-items: flex-start !important;
		gap: 12px;
	}
	.product-img {
		margin-right: 0 !important;
		margin-bottom: 10px;
	}
	.action-area {
		text-align: left !important;
		width: 100% !important;
		min-width: unset !important;
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
				<li>My Orders</li>
			</ul>
		</div>
	</div>

	<div class="user-profile profile-container">
		<div class="container">
			<div class="row">

				<div class="col-md-3" style="margin-bottom: 25px;">
					<div
						style="background: white; padding: 20px; border-radius: 12px; border: 1px solid #edf2f7; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);">
						<div style="text-align: center; margin-bottom: 15px;">
							<div
								style="width: 60px; height: 60px; background: #ff9800; color: white; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; font-size: 24px; font-weight: bold; text-transform: uppercase;">
								${fn:substring(sessionScope.LoggedInUser.userName, 0, 1)}</div>
							<h4 style="margin: 10px 0 2px 0; font-weight: 700;">Hi,
								${sessionScope.LoggedInUser.userName}</h4>
							<p style="font-size: 12px; color: #a0aec0;">${sessionScope.LoggedInUser.userEmail}</p>
						</div>
						<hr style="margin: 10px 0;">
						<ul
							style="list-style: none; padding: 0; margin: 0; line-height: 2.5;">
							<li><a href="/userProfile"
								style="color: #ff9800; font-weight: bold;"><i
									class="fa fa-shopping-bag"></i> My Orders</a></li>
							<li><a href="/address" style="color: #4a5568;"><i
									class="fa fa-map-marker"></i> Manage Addresses</a></li>
							<li><a href="/cart" style="color: #4a5568;"><i
									class="fa fa-shopping-cart"></i> My Active Cart</a></li>
						</ul>
					</div>
				</div>

				<div class="col-md-9">
					<h3
						style="font-weight: 700; color: #1a202c; margin: 0 0 25px 0; text-transform: uppercase; letter-spacing: 0.5px;">Order
						History</h3>

					<c:choose>
						<c:when test="${empty orders}">
							<div
								style="text-align: center; background: white; padding: 50px 20px; border-radius: 12px; border: 1px solid #eef2f5;">
								<span style="font-size: 50px;">📦</span>
								<h3 style="margin-top: 15px; color: #718096; font-weight: 600;">No
									Orders Found Yet</h3>
								<p style="color: #a0aec0; margin-bottom: 20px;">Looks like
									you haven't shopped anything recently.</p>
								<a href="/products2" class="btn btn-warning"
									style="padding: 8px 25px; border-radius: 6px; font-weight: bold;">Start
									Shopping</a>
							</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="order" items="${orders}">
								<div class="order-card">

									<div class="order-header">
										<div class="order-id">
											Order ID: <span style="color: #ff9800;">${order.orderNumber}</span>
										</div>
										<div>
											<span class="payment-badge"
												style="background: ${order.paymentStatus == 'Paid' ? '#c6f6d5; color: #22543d;' : '#feebc8; color: #744210;'}">
												${order.paymentStatus} </span>
										</div>
									</div>

									<div class="order-body">
										<c:forEach var="item" items="${order.items}">
											<div class="item-row">

												<img src="${fn:split(item.item.itemImage, ',')[0]}"
													class="product-img" alt="Item Preview" />

												<div class="item-details">
													<div class="item-name">${item.item.itemName}</div>
													<div class="item-meta">
														<span><b>Qty:</b> ${item.quantity}</span>
														<c:if test="${not empty item.size}">
															<span style="margin-left: 15px;"><b>Size:</b> <span
																class="badge"
																style="background: #edf2f7; color: #2d3748; font-size: 11px;">${item.size}</span></span>
														</c:if>
													</div>
													<div class="item-price">
														₹
														<fmt:formatNumber value="${item.finalPrice}"
															maxFractionDigits="0" />
														/-
													</div>

													<c:if test="${item.exchangeRequested}">
														<div
															style="background: #ebf8ff; padding: 6px 12px; border-radius: 6px; margin-top: 10px; display: inline-block; font-size: 12px; color: #2b6cb0;">
															🔄 Exchange in progress (Delivery:
															${item.exchangeDeliveryDate})</div>
													</c:if>
												</div>

												<div class="action-area">
													<a href="/order/details?orderItemId=${item.id}"
														class="btn-custom-view btn"> <i class="fa fa-eye"></i>
														View Details
													</a>

													<c:if test="${item.order.status == 'Cancelled'}">
														<p
															style="color: #e53e3e; font-size: 12px; font-weight: bold; margin: 5px 0;">Refund:
															${item.refundStatus}</p>
													</c:if>

													<c:if
														test="${item.status == 'Pending' || item.status == 'Processing' || item.status == 'Packed'}">
														<form method="post" action="/order/cancel-item"
															style="margin: 0;">
															<input type="hidden" name="orderItemId"
																value="${item.id}">
															<button type="submit" class="btn-action-cancel">Cancel
																Item</button>
														</form>
													</c:if>

													<c:if
														test="${item.status == 'Cancelled' && item.refundStatus != 'Processed'}">
														<form action="/order/revert-cancel" method="post"
															style="margin: 0;">
															<input type="hidden" name="orderItemId"
																value="${item.id}">
															<button type="submit" class="btn-action-blue btn">Undo
																Cancel</button>
														</form>
													</c:if>

													<c:if
														test="${!item.returnRequested && item.order.status == 'Delivered' && !item.noReturnOrder}">
														<button type="button"
															onclick="openReturnModal('${item.id}')"
															class="btn btn-action-blue"
															style="background: #ff9800; color: #fff; border: none; margin-bottom: 8px;">
															Return Item</button>
													</c:if>

													<c:if test="${!item.exchangeRequested}">
														<c:if test="${item.order.status == 'Delivered'}">
															<button type="button"
																onclick="openExchangeModal('${item.id}')"
																class="btn btn-action-blue"
																style="background: #2874f0; color: #fff; border: none;">
																Exchange Item</button>
														</c:if>
													</c:if>
													<c:if
														test="${item.exchangeStatus == 'Requested' || item.exchangeStatus == 'Approved'}">
														<form action="/order/revert-exchange" method="post"
															style="margin: 0;">
															<input type="hidden" name="orderItemId"
																value="${item.id}">
															<button type="submit" class="btn btn-action-cancel btn"
																style="background: #fffaf0; color: #dd6b20; border-color: #ffeebc;">Cancel
																Exchange</button>
														</form>
													</c:if>

													<c:if test="${item.status == 'Returned'}">
														<p
															style="color: #e53e3e; font-size: 12px; font-weight: bold; margin-top: 5px;">Refund:
															${item.refundStatus}</p>
													</c:if>
												</div>

											</div>
										</c:forEach>
									</div>

								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>
	</div>

	<div id="exchangeModal"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: 99999;">
		<div class="modal-wrapper">
			<h4 style="margin: 0 0 10px 0; font-weight: 700; color: #1a202c;">Exchange
				Item Variant</h4>
			<p style="color: #718096; font-size: 13px; margin-bottom: 15px;">Please
				pick your requested replacement size profile layout safely from the
				list below.</p>

			<form method="post" action="/order/exchange">
				<input type="hidden" id="exchangeOrderItemId" name="orderItemId" />

				<label style="font-weight: 600; font-size: 13px; color: #4a5568;">Select
					New Size *</label> <select name="newSize" class="form-control" required>
					<option value="">-- Choose Target Size --</option>
					<option value="S">S (Small)</option>
					<option value="M">M (Medium)</option>
					<option value="L">L (Large)</option>
					<option value="XL">XL (Extra Large)</option>
					<option value="XXL">XXL (Double Extra Large)</option>
				</select>

				<div class="modal-btn-group">
					<button type="submit" class="btn btn-warning"
						style="flex: 1; font-weight: bold;">Confirm Exchange</button>
					<button type="button" onclick="closeModal()"
						class="btn btn-default" style="flex: 1; background: #edf2f7;">Dismiss</button>
				</div>
			</form>
		</div>
	</div>

	<div id="returnModal"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: 99999;">

		<div class="modal-wrapper">
			<h4>Return Product</h4>

			<form method="post" action="/order/return">

				<input type="hidden" id="returnOrderItemId" name="orderItemId" />

				<textarea name="reason" placeholder="Reason for return" required></textarea>

				<div class="modal-btn-group">
					<button type="submit" class="btn btn-warning">Submit</button>

					<button type="button" onclick="closeModal()"
						class="btn btn-default">Cancel</button>
				</div>

			</form>
		</div>
	</div>

	<%@include file="footer.jsp"%>

	<script type="text/javascript">
		function openExchangeModal(orderItemId) {
			document.getElementById("exchangeModal").style.display = "block";
			document.getElementById("exchangeOrderItemId").value = orderItemId;
		}
		function openReturnModal(orderItemId) {
		    document.getElementById("returnModal").style.display = "block";
		    document.getElementById("returnOrderItemId").value = orderItemId;
		}

		function closeModal() {
		    document.getElementById("returnModal").style.display = "none";
		    document.getElementById("exchangeModal").style.display = "none";
		}
	</script>
</body>
</html>
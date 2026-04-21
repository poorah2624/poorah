<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="head.jsp"%>
</head>
<body>
	<%@include file="header.jsp"%>
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>User Profile</h2>
		</div>
	</div>-->

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
			<h2 style="text-align: center; margin-bottom: 30px;">Order Item
				Details</h2>

			<div class="container" style="margin-top: 30px;">

				<div style="display: flex; gap: 20px;">

					<!-- LEFT SIDE IMAGE -->
					<div style="flex: 1;">
						<img
							src="uploads/${fn:split(item.item.itemImage, ',')[0]}"
							style="width: 100%; max-width: 300px; border-radius: 10px;">
					</div>

					<!-- RIGHT SIDE DETAILS -->
					<div style="flex: 2;">

						<h3>${item.item.itemName}</h3>

						<p style="font-size: 18px; font-weight: bold;">
							₹
							<fmt:formatNumber value="${item.finalPrice}"
								maxFractionDigits="0" />
							/-
						</p>

						<p>Quantity: ${item.quantity}</p>

						<c:choose>
							<c:when test="${item.item.category.categoryName == 'Kids'}">
								<p>Age: ${item.age}</p>
							</c:when>
							<c:otherwise>
								<p>Size: ${item.size}</p>
							</c:otherwise>
						</c:choose>

						<!-- STATUS -->
						<p
							style="font-weight:bold; color:
    ${item.returnRequested ? 'blue' :
      item.order.status == 'Delivered' ? 'green' :
      item.order.status == 'Pending' ? 'orange' : 'red'};">
							<c:choose>
								<c:when test="${item.returnRequested}">
            Return ${item.returnStatus}
        </c:when>
								<c:otherwise>
            ${item.order.status}
        </c:otherwise>
							</c:choose>
						</p>
						<c:if test="${item.status == 'Returned'}">
							<p style="color: red; margin-top: 10px;">Refund Status:
								${item.refundStatus}</p>
						</c:if>

						<hr>
						<!-- REFUND SHOW -->
						<c:if test="${item.order.status == 'Cancelled'}">
							<p style="color: red;">Refund: ${item.refundStatus}</p>
						</c:if>
						<!-- ACTION BUTTONS -->

						<!-- CANCEL -->
						<c:if
							test="${item.status == 'Pending' || item.status == 'Processing' || item.status == 'Packed'}">
							<form method="post"
								action="order/cancel-item">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button
									style="background: red; color: white; padding: 8px 15px; border: none; border-radius: 5px;">
									Cancel Order</button>
							</form>
						</c:if>

						<c:if
							test="${item.status == 'Cancelled' && item.refundStatus != 'Processed'}">
							<form
								action="order/revert-cancel"
								method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button
									style="background: #007bff; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Undo
									Cancel</button>
							</form>
						</c:if>

						<!-- RETURN -->
						<c:if test="${!item.returnRequested}">
							<c:if test="${item.order.status == 'Delivered'}">
								<button onclick="openReturnModal('${item.id}')"
									style="background: orange; color: white; padding: 8px 15px; border: none; border-radius: 5px; margin-top: 10px;">
									Return</button>
							</c:if>
						</c:if>
						<c:if
							test="${item.returnStatus == 'Requested' || item.returnStatus == 'Approved'}">
							<form
								action="order/revert-return"
								method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button
									style="background: #f0ad4e; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Cancel
									Return Request</button>
							</form>
						</c:if>

						<!-- EXCHANGE -->
						<c:if test="${!item.exchangeRequested}">
							<c:if test="${item.order.status == 'Delivered'}">
								<button onclick="openExchangeModal('${item.id}')"
									style="background: #2874f0; color: white; padding: 8px 15px; border: none; border-radius: 5px; margin-top: 10px;">
									Exchange</button>
							</c:if>
						</c:if>
						<c:if
							test="${item.exchangeStatus == 'Requested' || item.exchangeStatus == 'Approved'}">
							<form
								action="order/revert-exchange"
								method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button
									style="background: #007bff; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Cancel
									Exchange</button>
							</form>
						</c:if>

						<!-- REFUND -->
						<c:if test="${item.order.status == 'Cancelled'}">
							<p style="color: red; margin-top: 10px;">Refund Status:
								${item.refundStatus}</p>
						</c:if>

						<c:if test="${item.exchangeRequested}">
							<div
								style="background: #f0f7ff; padding: 10px; border-radius: 8px;">
								<p>🔄 Exchange in progress</p>
								<p>Expected Delivery: ${item.exchangeDeliveryDate}</p>
							</div>
						</c:if>

					</div>
				</div>

				<hr>

				<!-- ORDER INFO -->
				<div style="margin-top: 20px;">

					<h4>Order Information</h4>
					<p>Order ID: ${item.order.orderNumber}</p>
					<p>Order Date: ${item.order.orderDate}</p>
					<p>Payment: ${item.order.paymentMethod}</p>
					<p>Payment Status: ${item.order.paymentStatus}</p>
					<p>
						Paid Amount: ₹
						<fmt:formatNumber value="${item.order.payment.amount}"
							maxFractionDigits="0" />
						/-
					</p>
					<br>
					<p>
						Delivery to: <br>${item.order.address.fullName }<br>
						${item.order.address.mobile } ${item.order.address.houseNo } ,
						${item.order.address.area }<br> ${item.order.address.landmark }<br>
						${item.order.address.city } , ${item.order.address.state }<br>
						${item.order.address.pincode }
					</p>
					<hr>

					<!-- INVOICE BUTTON -->
					<div style="margin-top: 15px;">
						<a
							href="order/invoice/${item.id}"
							class="btn btn-success" target="_blank"> 📄 Download Invoice
						</a>
					</div>

				</div>

				<hr>



				<!-- new track -->
				<div style="margin-top: 30px;">
					<h3>Track Order</h3>

					<div class="track">

						<!-- ORDER FLOW -->
						<div class="step ${item.order.orderDate != null ? 'active' : ''}">
							<div class="circle">✔</div>
							<p>Order Placed</p>
						</div>

						<div class="step ${item.order.packedDate != null ? 'active' : ''}">
							<div class="circle">✔</div>
							<p>Packed</p>
						</div>

						<div
							class="step ${item.order.shippedDate != null ? 'active' : ''}">
							<div class="circle">✔</div>
							<p>Shipped</p>
						</div>

						<div
							class="step ${item.order.status eq 'Out for delivery' ? 'active' : ''}">
							<div class="circle">🚚</div>
							<p>Out for Delivery</p>
						</div>

						<div
							class="step ${item.order.deliveredDate != null ? 'active' : ''}">
							<div class="circle">🎉</div>
							<p>Delivered</p>
						</div>

						<!-- ❌ CANCELLED -->
						<c:if test="${item.status eq 'Cancelled'}">
							<div class="step active">
								<div class="circle">❌</div>
								<p>Order Cancelled</p>
							</div>

							<div
								class="step ${item.refundStatus eq 'Processed' ? 'active' : ''}">
								<div class="circle">💰</div>
								<p>Refund Completed</p>
							</div>
						</c:if>

						<!-- 🔁 RETURN FLOW -->
						<c:if test="${item.returnRequested}">

							<div class="step active">
								<div class="circle">🔁</div>
								<p>Return Requested</p>
							</div>

							<div
								class="step ${item.returnStatus eq 'Approved' ? 'active' : ''}">
								<div class="circle">✔</div>
								<p>Return Approved</p>
							</div>

							<div
								class="step ${item.returnStatus eq 'Picked' ? 'active' : ''}">
								<div class="circle">📦</div>
								<p>Picked Up</p>
							</div>

							<div
								class="step ${item.refundStatus eq 'Processed' ? 'active' : ''}">
								<div class="circle">💰</div>
								<p>Refund Completed</p>
							</div>

						</c:if>

						<!-- 🔄 EXCHANGE FLOW -->
						<c:if test="${item.exchangeRequested}">

							<div class="step active">
								<div class="circle">🔄</div>
								<p>Exchange Requested</p>
							</div>

							<div
								class="step ${item.exchangeStatus eq 'Approved' ? 'active' : ''}">
								<div class="circle">✔</div>
								<p>Exchange Approved</p>
							</div>

							<div
								class="step ${item.exchangeStatus eq 'Shipped' ? 'active' : ''}">
								<div class="circle">🚚</div>
								<p>New Item Shipped</p>
							</div>

							<div
								class="step ${item.exchangeStatus eq 'Delivered' ? 'active' : ''}">
								<div class="circle">🎉</div>
								<p>Exchange Delivered</p>
							</div>

						</c:if>

					</div>
				</div>
				<!-- track end -->

			</div>

			<!-- RETURN MODAL -->
			<div id="returnModal"
				style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">

				<div
					style="background: white; width: 400px; margin: 100px auto; padding: 20px; border-radius: 10px;">

					<h3>Return Product</h3>

					<form method="post"
						action="order/return">

						<input type="hidden" id="returnItemId" name="orderItemId">

						<textarea name="reason" placeholder="Reason" required></textarea>

						<br> <br>

						<button type="submit">Submit</button>
						<button type="button" onclick="closeModal()">Cancel</button>

					</form>

				</div>
			</div>

			<!-- EXCHANGE MODAL -->
			<div id="exchangeModal"
				style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">

				<div
					style="background: white; width: 400px; margin: 100px auto; padding: 20px; border-radius: 10px;">

					<h3>Exchange Product</h3>

					<form method="post"
						action="order/exchange">

						<input type="hidden" id="exchangeItemId" name="orderItemId">

						<label>Select Size:</label> <select name="newSize" required>
							<option value="">Select</option>
							<option>S</option>
							<option>M</option>
							<option>L</option>
							<option>XL</option>
						</select> <br> <br>
						<textarea name="reason" placeholder="Reason" required></textarea>

						<button type="submit">Submit</button>
						<button type="button" onclick="closeModal()">Cancel</button>

					</form>

				</div>
			</div>

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
			</script>
			<%@include file="footer.jsp"%>
</body>
</html>

<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="head.jsp"%>
</head>
<body>
	<%@include file="header.jsp"%>
	<!-- <div class="banner10" id="home1">
		<div class="container">
			<h2>User Profile</h2>
		</div>
	</div>  -->

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
			<h2 style="text-align: center; margin-bottom: 30px;">My Orders</h2>


			<c:choose>

				<c:when test="${empty orders}">
					<h3 style="text-align: center; color: gray;">No Orders Yet 😔
					</h3>
				</c:when>

				<c:otherwise>
					<c:forEach var="order" items="${orders}">

						<div
							style="border: 1px solid #ddd; border-radius: 10px; padding: 20px; margin-bottom: 20px; background: #fafafa;">

							<!-- ORDER HEADER -->
							<div style="display: flex; justify-content: space-between;">
								<div>
									<h4 style="margin: 0;">Order ID: ${order.orderNumber}</h4>
									<p style="margin: 5px 0;">Payment: ${order.paymentStatus}</p>
								</div>

								
							</div>

							<hr>

							<!-- ITEMS -->
							<c:forEach var="item" items="${order.items}">


								<div
									style="display: flex; align-items: center; margin-bottom: 15px;">

									<!-- PRODUCT IMAGE -->
									<img
										src="/uploads/${fn:split(item.item.itemImage, ',')[0]}"
										style="width: 80px; height: 100px; border-radius: 8px; margin-right: 15px;" />

									<!-- DETAILS -->
									<div style="flex: 1;">
										<p style="margin: 0; font-weight: bold;">
											${item.item.itemName}</p>

										<p style="margin: 5px 0;">Qty: ${item.quantity}</p>
										<div class="meta">


											<c:choose>
												<c:when test="${c.item.category.categoryName == 'Kids'}">
                                   <p style="margin: 5px 0;">Age : ${item.age}</p>
                                </c:when>
												<c:otherwise>
                                   <p style="margin: 5px 0;">Size : ${item.size}</p>
                                </c:otherwise>
											</c:choose>
										</div>

										<p style="margin: 0; color: #555;">₹ <fmt:formatNumber value="${item.finalPrice}" maxFractionDigits="0"/> /-</p>
									</div>
									<div style="margin-bottom: 15px;">
										<a
											href="/order/details?orderItemId=${item.id}">
											<button>View Details</button>
										</a>
										<br><br>
										<c:if test="${item.order.status == 'Cancelled'}">
							<p style="color: red;">Refund: ${item.refundStatus}</p>
						</c:if>
						
						<c:if
							test="${item.status == 'Pending' || item.status == 'Processing' || item.status == 'Packed'}">
							<form method="post"
								action="/order/cancel-item">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button
									style="background: red; color: white; padding: 8px 15px; border: none; border-radius: 5px;">
									Cancel Order</button>
							</form>
						</c:if>
						
						<c:if
							test="${item.status == 'Cancelled' && item.refundStatus != 'Processed'}">
							<form action="/order/revert-cancel" method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button style="background: #007bff; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Undo Cancel</button>
							</form>
						</c:if>

						<!-- RETURN -->
						<!--<c:if test="${!item.returnRequested}">
							<c:if test="${item.order.status == 'Delivered'}">
								<button onclick="openReturnModal('${item.id}')"
									style="background: orange; color: white; padding: 8px 15px; border: none; border-radius: 5px; margin-top: 10px;">
									Return</button>
							</c:if>
						</c:if>
						<c:if
							test="${item.returnStatus == 'Requested' || item.returnStatus == 'Approved'}">
							<form action="/order/revert-return" method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button style="background: #f0ad4e; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Cancel Return Request</button>
							</form>
						</c:if> -->

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
							<form action="/order/revert-exchange" method="post">
								<input type="hidden" name="orderItemId" value="${item.id}">
								<button style="background: #007bff; color: white; padding: 8px 15px; border: none; border-radius: 5px;">Cancel Exchange</button>
							</form>
						</c:if>

						<!-- REFUND -->
						<c:if test="${item.status == 'Returned'}">
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
								
								
								<br>
								<br>
								<br>
							</c:forEach>

						</div>



					</c:forEach>
				</c:otherwise>

			</c:choose>
			<!-- Return Modal -->
			<div id="returnModal"
				style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">

				<div
					style="background: white; width: 400px; margin: 100px auto; padding: 20px; border-radius: 10px;">

					<h3>Return Product</h3>


					<form method="post"
						action="/order/return">

						<input type="hidden" id="returnOrderItemId" name="orderItemId" />

						<textarea name="reason" placeholder="Reason"></textarea>

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
						action="/order/exchange">

						<input type="hidden" id="exchangeOrderItemId" name="orderItemId" />

						<!-- SIZE SELECT -->
						<label>Select New Size:</label> <select name="newSize" required>
							<option value="">Select Size</option>
							<option value="S">S</option>
							<option value="M">M</option>
							<option value="L">L</option>
							<option value="XL">XL</option>
						</select> <br> <br> <br> <br>

						<button type="submit">Submit</button>
						<button type="button" onclick="closeModal()">Cancel</button>

					</form>

				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
	<script>
		function openReturnModal(orderItemId) {

			console.log("ITEM:", orderItemId);
			document.getElementById("returnModal").style.display = "block";
			document.getElementById("returnOrderItemId").value = orderItemId;
		}

		function closeModal() {
			document.getElementById("returnModal").style.display = "none";
		}
	</script>
	<script>
		function openExchangeModal(orderItemId) {

			console.log("ITEM:", orderItemId);
			document.getElementById("exchangeModal").style.display = "block";
			document.getElementById("exchangeOrderItemId").value = orderItemId;
		}

		function closeModal() {
			document.getElementById("exchangeModal").style.display = "none";
		}
	</script>
</body>
</html>

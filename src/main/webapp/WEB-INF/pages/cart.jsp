<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
<title>PooRah Fashion</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="head.jsp"%>

</head>

<body>
	<!-- header -->
	<%@include file="header1.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>Cart</h2>
		</div>
	</div> -->
	<!-- //banner -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home"
						aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Cart</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<!-- checkout -->
	<div class="checkout">
		<div class="container">
			<h3>Your shopping cart:</h3>

			<!-- new cart -->

			<div class="modern-cart">

				<c:forEach var="c" items="${cartItems}" varStatus="status">
					<c:choose>
						<c:when test="${c.isCustom}">
							<div class="custom-cart-card">

								<!-- IMAGE -->
								<div class="custom-img">
									<img src="${c.customImage}" /> <span class="custom-badge">Your
										Design 🎨</span>
								</div>

								<!-- DETAILS -->
								<div class="custom-details">

									<h3>Custom T-Shirt</h3>

									<div class="custom-meta">
										<p>
											<b>Size:</b> ${c.size}
										</p>
										<p>
											<b>Color:</b> ${c.color}
										</p>
										<p>
											<b>Type:</b> ${c.tshirtType}
										</p>
										<p>
											<b>Gender:</b> ${c.gender}
										</p>
										<p>
											<b>Tshirt Type:</b> ${c.tshirtType}
										</p>

										<c:if test="${not empty c.customNote}">
											<p>
												<b>Note:</b> ${c.customNote}
											</p>
										</c:if>
									</div>

									<!-- PRICE -->
									<div class="custom-price">
										<c:if test="${not empty c.totalPrice}">
										₹ ${c.totalPrice} /-
										</c:if>
									</div>

									<!-- ACTION -->
									<div class="custom-actions">
										<a href="/DeleteCart/${c.cartId}"
											class="btn btn-danger btn-sm">Remove</a>
									</div>

								</div>

							</div>
						</c:when>
						<c:otherwise>
							<div class="cart-card">

								<!-- IMAGE -->
								<div class="cart-img">
									<img src="${fn:split(c.item.itemImage, ',')[0]}" />

								</div>

								<!-- DETAILS -->
								<div class="cart-details">

									<div class="brand">POORAH</div>

									<div class="title">${c.item.itemName}</div>

									<div class="price-section">

										<div class="final-price">
											<c:if test="${not empty c.totalPrice}">
											₹ ${c.totalPrice} /-
											</c:if>
										</div>

										<div class="price-meta">
											<span class="old-price"> ₹ ${c.item.itemPrice} /- </span> <span
												class="discount"> ${c.item.discount}% OFF </span>
										</div>

									</div>

									<div class="meta">


										<c:if
											test="${item.category.categoryName == 'Men' || item.category.categoryName == 'Women'}">
                                   
                                   Size : ${c.size}
                                
										</c:if>
									</div>

									<!-- QUANTITY -->
									<div class="qty-box">
										<form action="/UpdateQuantity" method="post">

											<input type="hidden" name="itemId" value="${c.item.itemId}">
											<input type="hidden" name="userEmail"
												value="${c.user.userEmail}">

											<button type="button"
												onclick="this.nextElementSibling.stepDown()">-</button>

											<input type="number" name="quantity" value="${c.quantity}"
												min="1">

											<button type="button"
												onclick="this.previousElementSibling.stepUp()">+</button>

											<button type="submit" class="btn btn-warning">Update</button>
										</form>

										<!-- DELETE -->
										<a href="/DeleteCart/${c.cartId}" class="delete-btn"> 🗑 </a>
									</div>

								</div>

							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- TOTAL SECTION -->
				<div class="cart-summary">
					<div>Total: ₹ ${grandTotal} /-</div>

					<div>
						Delivery:
						<c:choose>
							<c:when test="${deliveryCharge == 0}">
                    FREE
                </c:when>
							<c:otherwise>
                    ₹${deliveryCharge}
                </c:otherwise>
						</c:choose>
						<c:if test="${grandTotal < 500}">
							<p style="color: orange; font-weight: bold;">Add ₹${500 - grandTotal}
								more to get FREE Delivery 🚚</p>
						</c:if>

						<c:if test="${grandTotal >= 500}">
							<p style="color: green; font-weight: bold;">🎉 You got FREE
								Delivery!</p>
						</c:if>
					</div>

					<div class="final-total">Total Amount: ₹ ${finalAmount} /-</div>
				</div>

			</div>

			<div class="checkout-left">

				<div class="checkout-right-basket">
					<a href="/checkout" class="btn btn-warning">Order Now</a> <a
						href="/products2"><span class="glyphicon glyphicon-menu-left"
						aria-hidden="true"></span>Continue Shopping</a>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>



	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->


	<!-- start-smooth-scrolling -->
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
	<!-- //end-smooth-scrolling -->
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
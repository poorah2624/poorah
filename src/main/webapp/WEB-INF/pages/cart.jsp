<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Women's Fashion Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

<script type="application/x-javascript">
	
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 



</script>

<!-- //for-mobile-apps -->
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/fasthover.css"
	rel="stylesheet" type="text/css" media="all" />


<link href='//fonts.googleapis.com/css?family=Glegoo:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'
	rel='stylesheet' type='text/css'>



</head>

<body>
	<!-- header -->
	<%@include file="header.jsp"%>
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
				<li><a href="${pageContext.request.contextPath}/home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
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
									<img
										src="${pageContext.request.contextPath}/uploads/${c.customImage}" />
									<span class="custom-badge">Your Design 🎨</span>
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
										₹
										<fmt:formatNumber value="${c.totalPrice}"
											maxFractionDigits="0" />
										/-
									</div>

									<!-- ACTION -->
									<div class="custom-actions">
										<a
											href="${pageContext.request.contextPath}/DeleteCart/${c.cartId}"
											class="btn btn-danger btn-sm">Remove</a>
									</div>

								</div>

							</div>
						</c:when>
						<c:otherwise>
							<div class="cart-card">

								<!-- IMAGE -->
								<div class="cart-img">
									<img
										src="${pageContext.request.contextPath}/uploads/${fn:split(c.item.itemImage, ',')[0]}" />

								</div>

								<!-- DETAILS -->
								<div class="cart-details">

									<div class="brand">POORAH</div>

									<div class="title">${c.item.itemName}</div>

									<div class="price-section">

										<div class="final-price">
											₹
											<fmt:formatNumber value="${c.totalPrice}"
												maxFractionDigits="0" />
											/-
										</div>

										<div class="price-meta">
											<span class="old-price"> ₹ <fmt:formatNumber
													value="${c.item.itemPrice}" maxFractionDigits="0" /> /-
											</span> <span class="discount"> ${c.item.discount}% OFF </span>
										</div>

									</div>

									<div class="meta">


										<c:choose>
											<c:when test="${c.item.category.categoryName == 'Kids'}">
                                   Age : ${c.age}
                                </c:when>
											<c:otherwise>
                                   Size : ${c.size}
                                </c:otherwise>
										</c:choose>
									</div>

									<!-- QUANTITY -->
									<div class="qty-box">
										<form
											action="${pageContext.request.contextPath}/UpdateQuantity"
											method="post">

											<input type="hidden" name="itemId" value="${c.item.itemId}">
											<input type="hidden" name="userEmail"
												value="${c.user.userEmail}">

											<button type="button"
												onclick="this.nextElementSibling.stepDown()">-</button>

											<input type="number" name="quantity" value="${c.quantity}"
												min="1">

											<button type="button"
												onclick="this.previousElementSibling.stepUp()">+</button>

											<button class="btn btn-warning" style="">Update</button>
										</form>

										<!-- DELETE -->
										<a
											href="${pageContext.request.contextPath}/DeleteCart/${c.cartId}"
											class="delete-btn"> 🗑 </a>
									</div>

								</div>

							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- TOTAL SECTION -->
				<div class="cart-summary">
					<div>
						Total: ₹
						<fmt:formatNumber value="${grandTotal}" maxFractionDigits="0" />
						/-
					</div>

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

					<div class="final-total">
						Total Amount: ₹
						<fmt:formatNumber value="${finalAmount}" maxFractionDigits="0" />
						/-
					</div>
				</div>

			</div>

			<div class="checkout-left">

				<div class="checkout-right-basket">
					<a href="${pageContext.request.contextPath}/checkout"
						class="btn btn-warning">Order Now</a> <a
						href="${pageContext.request.contextPath}/products2"><span
						class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Continue
						Shopping</a>
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
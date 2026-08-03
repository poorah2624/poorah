<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
<link rel="stylesheet" href="/css/flexslider.css" type="text/css"
	media="screen" />
<style>
/* --- Modern E-commerce Product Page Layout --- */
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.single {
	padding: 40px 0;
}

.product-container-card {
	background: #fff;
	padding: 30px;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

.gallery-wrapper {
	position: relative;
	border: 1px solid #f0f0f0;
	border-radius: 12px;
	background: #fff;
	overflow: hidden;
}

#productFlexSlider .slides li {
	height: 600px !important;
	background: #fff !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
}

#productFlexSlider .slides li img {
	width: 100% !important;
	height: 100% !important;
	object-fit: cover !important;
	margin: 0 auto !important;
	display: block !important;
}

.thumb-image {
	width: 100% !important;
	height: 100% !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	background: #fff !important;
	position: relative;
}

#mainProductImg {
	width: auto !important;
	height: 100% !important;
	max-height: 100% !important;
	object-fit: cover !important;
	margin: 0 auto;
	display: block;
}

.flex-control-nav.flex-control-thumbs li {
	width: 60px !important;
	margin: 8px 4px 0 4px !important;
}

.flex-control-nav.flex-control-thumbs img {
	height: 75px !important;
	object-fit: cover !important;
	border-radius: 6px !important;
	transition: all 0.2s ease;
}

.flex-control-nav.flex-control-thumbs img.flex-active {
	border: 2px solid #ff9b05 !important; /* Active indicator grid */
}

.zoomImg {
	background-color: #fff !important;
	width: auto !important;
	height: auto !important;
	max-width: none !important;
	max-height: none !important;
	object-fit: scale-down !important;
}

.imagezoom-viewer {
	overflow: hidden !important;
	background-color: #fff !important;
	border: 1px solid #ddd !important;
}

/* --- Typography & Badges --- */
.product-title {
	font-size: 26px;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 15px;
}

.price-box {
	background: #fff5f7;
	padding: 15px;
	border-radius: 8px;
	display: inline-block;
	margin-bottom: 20px;
}

.final-price {
	font-size: 28px;
	font-weight: 700;
	color: #ff9b05;
	display: inline-block;
}

.old-price {
	text-decoration: line-through;
	color: #7f8c8d;
	margin-left: 10px;
	font-size: 16px;
}

.discount-badge {
	background: #27ae60;
	color: #fff;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 14px;
	font-weight: 600;
	margin-left: 10px;
}

/* --- Interactive Swatches --- */
.section-title {
	font-size: 14px;
	font-weight: 700;
	color: #34495e;
	text-transform: uppercase;
	margin-bottom: 10px;
	letter-spacing: 0.5px;
}

.color-swatch {
	display: inline-block;
	padding: 10px 20px;
	margin-right: 10px;
	margin-bottom: 10px;
	border: 2px solid #e0e0e0;
	border-radius: 25px;
	cursor: pointer;
	background: #fff;
	font-weight: 600;
	color: #555;
	transition: all 0.2s ease;
}

.color-swatch.active {
	border-color: #ff9b05;
	background-color: #fff5f7;
	color: #ff9b05;
}

.size-chart-link {
	color: #ff9b05;
	font-weight: 600;
	text-decoration: none;
	margin-left: 15px;
}

.size-chart-link:hover {
	text-decoration: underline;
	color: #d11a4a;
}

/* Size Active Hide/Show Control */
.size-wrapper {
	display: none !important;
}

.size-wrapper.active {
	display: block !important;
}

/* Size Radio Styles */
.size-option-label {
	display: inline-block;
	position: relative;
	margin-right: 12px;
	margin-bottom: 12px;
	cursor: pointer;
}

.size-option-label input[type="radio"] {
	display: none;
}

.size-custom-box {
	display: inline-block;
	padding: 10px 22px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-weight: 600;
	color: #333;
	transition: all 0.2s;
}

.size-option-label input[type="radio"]:checked+.size-custom-box {
	border-color: #000;
	background: #000;
	color: #fff;
}

.disabled-size .size-custom-box {
	color: #b2bec3;
	background: #f1f2f6;
	border-color: #dfe6e9;
	text-decoration: line-through;
	cursor: not-allowed;
}

.stock-warning {
	display: block;
	font-size: 11px;
	color: #e74c3c;
	margin-top: 4px;
	text-align: center;
	font-weight: 600;
}

/* --- Action Buttons --- */
.btn-action-group {
	margin-top: 25px;
	display: flex;
	gap: 15px;
}

.btn-custom {
	padding: 14px 30px;
	font-size: 16px;
	font-weight: 700;
	border-radius: 8px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	transition: all 0.2s;
	flex: 1;
}

.btn-add-cart {
	background: #fff;
	border: 2px solid #ff9b05;
	color: #ff9b05;
}

.btn-add-cart:hover {
	background: #fff5f7;
}

.btn-buy-now {
	background: #ff9b05;
	border: 2px solid #ff9b05;
	color: #fff;
}

.btn-buy-now:hover {
	opacity: 0.9;
}

.btn-success-go {
	background: #27ae60;
	border: 2px solid #27ae60;
	color: #fff;
}

/* Trust Banner */
.trust-banner {
	margin-top: 20px;
	padding: 12px;
	background: #f0f9f4;
	border: 1px solid #c2ebd4;
	border-radius: 8px;
	color: #1e7e34;
}

/* Pincode Box */
.pincode-section {
	margin-top: 25px;
	background: #fdfdfd;
	padding: 15px;
	border: 1px solid #eee;
	border-radius: 8px;
}

/* Modal Fixes */
.modal-content {
	border-radius: 12px !important;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}
/* 📱 --- Dedicated Responsive Breakpoint for Mobile Overrides --- */
@media ( max-width : 767px) {
	.single .product-container-card {
		padding: 15px 0 !important;
	}
	.single-left {
		padding-left: 0 !important;
		padding-right: 0 !important;
		margin-bottom: 20px;
	}
	.gallery-wrapper {
		border: none !important;
		border-radius: 0 !important;
	}
	#productFlexSlider .slides li {
		height: 500px !important;
	}
	.thumb-image {
		padding: 0 !important;
	}
	#productFlexSlider .slides li img {
		width: 100% !important;
		height: 100% !important;
		object-fit: cover !important;
	}
	.single-right {
		padding-left: 20px !important;
		padding-right: 20px !important;
	}
}
</style>
</head>

<body>
	<%@include file="header1.jsp"%>

	<c:if test="${not empty defaultAddress}">
		<div
			style="background: #e9ecef; padding: 12px 0; border-bottom: 1px solid #dee2e6;">
			<div class="container" style="font-size: 14px; color: #495057;">
				<span class="glyphicon glyphicon-map-marker" style="color: #ff9b05;"></span>
				<b>Deliver to:</b> ${defaultAddress.fullName},
				${defaultAddress.pincode} <a href="/address"
					style="margin-left: 15px; color: #ff9b05; font-weight: 600;">Change</a>
			</div>
		</div>
	</c:if>

	<!-- Breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home"
						aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Product Detail</li>
			</ul>
		</div>
	</div>

	<!-- Single Product View Detail -->
	<div class="single">
		<div class="container">
			<div class="product-container-card row">

				<!-- Left Column: Image Area -->
				<div class="col-md-6 col-sm-12 single-left">
					<div class="gallery-wrapper">
						<div class="flexslider" id="productFlexSlider">
							<ul class="slides">
								<li data-thumb="${fn:split(item.itemImage, ',')[0]}"
									id="mainDisplayLi">
									<div class="thumb-image">
										<img src="${fn:split(item.itemImage, ',')[0]}"
											id="mainProductImg" class="img-responsive">
									</div>
								</li>
								<c:forEach var="img" items="${fn:split(item.itemImage, ',')}"
									varStatus="loop">
									<c:if test="${!loop.first}">
										<li data-thumb="${img}">
											<div class="thumb-image">
												<img src="${img}" class="img-responsive">
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

				<!-- Right Column: Product Operations Section -->
				<div class="col-md-6 col-sm-12 single-right">
					<h3 class="product-title">${item.itemName}</h3>

					<!-- Pricing Details Container -->
					<div class="price-box">
						<div class="final-price">
							₹
							<fmt:formatNumber value="${item.discountedPrice}"
								maxFractionDigits="0" />
							/-
						</div>
						<span class="old-price">₹<fmt:formatNumber
								value="${item.itemPrice}" maxFractionDigits="0" />/-
						</span> <span class="discount-badge">${fn:split(item.discount, '.')[0]}%
							OFF</span>
					</div>

					<div class="color-quality">
						<div class="color-quality-left" style="width: 100%;">

							<!-- Variants Check Logic -->
							<c:if
								test="${(item.category.categoryName == 'Men' || item.category.categoryName == 'Women' || item.category.categoryName == 'Couple Wear') && not empty item.variants}">

								<!-- 1. COLOR SELECTION SECTION -->
								<div style="margin-bottom: 25px;">
									<div class="section-title">Select Color</div>
									<c:forEach var="v" items="${item.variants}" varStatus="status">
										<span class="color-swatch ${status.first ? 'active' : ''}"
											data-variant-image="${v.variantImage}"
											onclick="selectColorBlock(${status.index}, this)">
											${v.variantColor} </span>
									</c:forEach>
								</div>

								<!-- 2. SIZE SELECTION SECTION -->
								<div style="margin-bottom: 15px;">
									<span class="section-title">Select Size</span>
									<c:set var="isPolo"
										value="${fn:containsIgnoreCase(item.itemName, 'Polo')}" />

									<a href="javascript:void(0);" class="size-chart-link"
										onclick="openSizeChart('${not empty item.subCategory ? item.subCategory.subCategoryName : item.subCategoryName}')">
										<span class="glyphicon glyphicon-list-alt"></span> Size Chart
									</a>
								</div>

								<div class="size-options-container" style="margin-bottom: 25px;">

									<c:choose>
										<c:when test="${item.category.categoryName == 'Couple Wear'}">
											<div class="couple-size-selector"
												style="background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px dashed #ff9b05;">

												<div class="form-group" style="margin-bottom: 15px;">
													<label
														style="font-weight: 600; color: #34495e; display: block; margin-bottom: 5px;">🧔
														Men's T-Shirt Size:</label> <select id="coupleMenSize"
														class="form-control"
														style="width: 100%; max-width: 200px; height: 38px; font-weight: 600;">
														<option value="">-- Choose Size --</option>
														<option value="S">S</option>
														<option value="M">M</option>
														<option value="L">L</option>
														<option value="XL">XL</option>
														<option value="XXL">XXL</option>
													</select>
												</div>

												<div class="form-group" style="margin-bottom: 5px;">
													<label
														style="font-weight: 600; color: #34495e; display: block; margin-bottom: 5px;">👩
														Women's T-Shirt Size:</label> <select id="coupleWomenSize"
														class="form-control"
														style="width: 100%; max-width: 200px; height: 38px; font-weight: 600;">
														<option value="">-- Choose Size --</option>
														<option value="S">S</option>
														<option value="M">M</option>
														<option value="L">L</option>
														<option value="XL">XL</option>
														<option value="XXL">XXL</option>
													</select>
												</div>
											</div>
										</c:when>

										<c:otherwise>
											<c:forEach var="v" items="${item.variants}"
												varStatus="status">
												<div id="sizeWrapper_${status.index}"
													class="size-wrapper ${status.first ? 'active' : ''}">

													<c:set var="stockStr" value="${v.variantStock}" />
													<c:set var="sQty"
														value="${fn:contains(stockStr,'S:') ? fn:substringBefore(fn:substringAfter(stockStr,'S:'),',M:') : ''}" />
													<c:set var="mQty"
														value="${fn:contains(stockStr,'M:') ? fn:substringBefore(fn:substringAfter(stockStr,'M:'),',L:') : ''}" />
													<c:set var="lQty"
														value="${fn:contains(stockStr,'L:') ? fn:substringBefore(fn:substringAfter(stockStr,'L:'),',XL:') : ''}" />
													<c:set var="xlQty"
														value="${fn:contains(stockStr,'XL:') ? (fn:contains(stockStr,'XXL:') ? fn:substringBefore(fn:substringAfter(stockStr,'XL:'),',XXL:') : fn:substringAfter(stockStr,'XL:')) : ''}" />
													<c:set var="xxlQty"
														value="${fn:contains(stockStr,'XXL:') ? fn:substringAfter(stockStr,'XXL:') : ''}" />

													<label
														class="size-option-label ${sQty == '0' ? 'disabled-size' : ''}">
														<input type="radio" name="selectedSize" value="S"
														${sQty == '0' ? 'disabled' : ''}> <span
														class="size-custom-box">S</span> <c:if
															test="${sQty > 0 && sQty <= 5}">
															<span class="stock-warning">${sQty} Left!</span>
														</c:if>
													</label> <label
														class="size-option-label ${mQty == '0' ? 'disabled-size' : ''}">
														<input type="radio" name="selectedSize" value="M"
														${mQty == '0' ? 'disabled' : ''}> <span
														class="size-custom-box">M</span> <c:if
															test="${mQty > 0 && mQty <= 5}">
															<span class="stock-warning">${mQty} Left!</span>
														</c:if>
													</label> <label
														class="size-option-label ${lQty == '0' ? 'disabled-size' : ''}">
														<input type="radio" name="selectedSize" value="L"
														${lQty == '0' ? 'disabled' : ''}> <span
														class="size-custom-box">L</span> <c:if
															test="${lQty > 0 && lQty <= 5}">
															<span class="stock-warning">${lQty} Left!</span>
														</c:if>
													</label> <label
														class="size-option-label ${xlQty == '0' ? 'disabled-size' : ''}">
														<input type="radio" name="selectedSize" value="XL"
														${xlQty == '0' ? 'disabled' : ''}> <span
														class="size-custom-box">XL</span> <c:if
															test="${xlQty > 0 && xlQty <= 5}">
															<span class="stock-warning">${xlQty} Left!</span>
														</c:if>
													</label>

													<c:if test="${not empty xxlQty}">
														<label
															class="size-option-label ${xxlQty eq '0' ? 'disabled-size' : ''}">
															<input type="radio" name="selectedSize" value="XXL"
															${xxlQty eq '0' ? 'disabled' : ''}> <span
															class="size-custom-box">XXL</span> <c:if
																test="${xxlQty > 0 && xxlQty <= 5}">
																<span class="stock-warning">${xxlQty} Left!</span>
															</c:if>
														</label>
													</c:if>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>

								</div>
							</c:if>

							<c:if test="${empty item.variants}">
								<div
									style="margin-bottom: 20px; color: #27ae60; font-weight: bold; font-size: 16px;">
									<span class="glyphicon glyphicon-ok-sign"></span> In Stock
									(Ready to dispatch)
								</div>
							</c:if>
						</div>

						<!-- Action Buttons Setup -->
						<div class="simpleCart_shelfItem" style="clear: both;">
							<div class="btn-action-group">
								<c:choose>
									<c:when test="${not empty sessionScope.LoggedInUser}">
										<c:choose>
											<c:when test="${item.inCart}">
												<button onclick="goToCart()"
													class="btn btn-custom btn-success-go">Go to Cart</button>
											</c:when>
											<c:otherwise>
												<button
													onclick="handleCartAction('add', ${item.itemId}, this)"
													class="btn btn-custom btn-add-cart">Add to Cart</button>
												<button
													onclick="handleCartAction('buy', ${item.itemId}, this)"
													class="btn btn-custom btn-buy-now">Buy Now</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<a class="btn btn-custom btn-buy-now text-center"
											style="line-height: 24px;"
											onclick="alert('Please login first to manage shopping cart operations.'); return false;"
											href="/login">Add to cart</a>
									</c:otherwise>
								</c:choose>
							</div>

							<!-- Policy Guard Alert -->
							<div class="trust-banner">
								<b style="font-size: 15px;">↩️ 5 Days Easy Returns and
									Exchange Available</b> <small
									style="display: block; color: #555; margin-top: 4px;">(Conditions
									apply. No return on products purchased with "No Return
									Discount".) </small>
							</div>

							<!-- Pincode Checker UI Section -->
							<div class="pincode-section">
								<div class="section-title" style="font-size: 12px;">Check
									Delivery Availability</div>
								<div class="input-group" style="width: 280px; margin-top: 8px;">
									<input type="text" id="pincode"
										placeholder="Enter 6-digit Pincode" class="form-control"
										maxlength="6" /> <span class="input-group-btn">
										<button onclick="checkDelivery()" class="btn btn-default"
											style="background: #333; color: #fff; border-color: #333;">Check</button>
									</span>
								</div>
								<i id="deliveryResult"
									style="margin-top: 10px; display: inline-block; font-weight: 600; color: #2c3e50;"></i>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!-- Product Details & Features -->
			<div class="product-container-card row" style="margin-top: 20px;">
				<div class="col-xs-12">
					<div class="description" style="margin-bottom: 25px;">
						<h4
							style="font-weight: 700; color: #2c3e50; border-bottom: 2px solid #ff9b05; padding-bottom: 8px; display: inline-block;">Product
							Overview</h4>
						<p
							style="margin-top: 15px; line-height: 1.8; color: #555; font-size: 15px;">${item.itemDesc}</p>
					</div>
					<div class="keyFeatures">
						<h4
							style="font-weight: 700; color: #2c3e50; border-bottom: 2px solid #ff9b05; padding-bottom: 8px; display: inline-block;">Product
							Specifications</h4>
						<ul style="margin-top: 15px; padding-left: 20px; line-height: 2;">
							<c:forTokens items="${item.keyFeatures}" delims="." var="feature">
								<c:if test="${not empty fn:trim(feature)}">
									<li
										style="color: #555; font-size: 14px; list-style-type: square;">${feature}</li>
								</c:if>
							</c:forTokens>
						</ul>
					</div>
				</div>
			</div>
			<div class="product-container-card row"
				style="margin-top: 20px; padding: 25px;">
				<div class="col-xs-12">
					<h3
						style="font-size: 22px; font-weight: 700; color: #2c3e50; margin-bottom: 25px; border-bottom: 2px solid #ff9b05; padding-bottom: 10px;">
						Product Reviews & Ratings (${fn:length(reviews)})</h3>

					<div class="row">
						<div class="col-md-7 col-sm-12"
							style="border-right: 1px solid #eee; max-height: 500px; overflow-y: auto; padding-right: 20px; margin-bottom: 25px;">
							<h4
								style="font-weight: 700; margin-bottom: 20px; color: #34495e;">User
								Feedback</h4>

							<c:if test="${empty reviews}">
								<p style="color: #7f8c8d; font-style: italic; padding: 10px;">No
									reviews yet for this product. Be the first to share your
									experience!</p>
							</c:if>

							<c:forEach var="r" items="${reviews}">
								<div
									style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 15px; border-left: 4px solid #ff9b05; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);">
									<div class="row">
										<div class="col-xs-8">
											<h5
												style="margin: 0 0 5px 0; font-weight: 700; color: #2c3e50;">
												<c:choose>
													<c:when test="${not empty r.user}">${r.user.userName}</c:when>
													<c:otherwise>${r.guestName}</c:otherwise>
												</c:choose>
											</h5>
											<small
												style="color: #95a5a6; display: block; margin-bottom: 8px;">${r.createdAt}</small>
										</div>
										<div class="col-xs-4 text-right">
											<c:forEach begin="1" end="5" var="i">
												<span
													style="font-size: 16px; color: ${i <= r.rating ? 'gold' : 'lightgray'};">★</span>
											</c:forEach>
										</div>
									</div>
									<p
										style="margin: 0; color: #555; line-height: 1.5; font-size: 14px;">${r.message}</p>
								</div>
							</c:forEach>
						</div>

						<div class="col-md-5 col-sm-12" style="padding-left: 25px;">
							<h4
								style="font-weight: 700; margin-bottom: 20px; color: #34495e;">Add
								A Review</h4>
							<form action="/addReview" method="post"
								style="background: #fff; border: 1px solid #eef0f2; padding: 20px; border-radius: 10px; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.03);">
								<input type="hidden" name="itemId" value="${item.itemId}">

								<div class="form-group">
									<label
										style="font-weight: 600; color: #555; display: block; margin-bottom: 5px;">Your
										Rating:</label>
									<div class="modern-star-rating">
										<input type="radio" name="rating" id="mstar5" value="5"
											checked /><label for="mstar5">★</label> <input type="radio"
											name="rating" id="mstar4" value="4" /><label for="mstar4">★</label>
										<input type="radio" name="rating" id="mstar3" value="3" /><label
											for="mstar3">★</label> <input type="radio" name="rating"
											id="mstar2" value="2" /><label for="mstar2">★</label> <input
											type="radio" name="rating" id="mstar1" value="1" /><label
											for="mstar1">★</label>
									</div>
								</div>

								<c:choose>
									<c:when test="${not empty sessionScope.LoggedInUser}">
										<div class="form-group">
											<label
												style="font-size: 12px; color: #7f8c8d; margin-bottom: 2px;">Name</label>
											<input type="text" name="userName"
												value="${sessionScope.LoggedInUser.userName}"
												class="form-control" readonly
												style="background: #f1f2f6; cursor: not-allowed;" required>
										</div>
										<div class="form-group">
											<label
												style="font-size: 12px; color: #7f8c8d; margin-bottom: 2px;">Email</label>
											<input type="email" name="userEmail"
												value="${sessionScope.LoggedInUser.userEmail}"
												class="form-control" readonly
												style="background: #f1f2f6; cursor: not-allowed;" required>
										</div>
									</c:when>
									<c:otherwise>
										<div class="form-group">
											<input type="text" name="guestName" placeholder="Your Name"
												class="form-control" required>
										</div>
										<div class="form-group">
											<input type="email" name="guestEmail"
												placeholder="Your Email" class="form-control" required>
										</div>
									</c:otherwise>
								</c:choose>

								<div class="form-group">
									<textarea name="message"
										placeholder="Write your valuable review here..."
										class="form-control" rows="4" style="resize: none;" required></textarea>
								</div>

								<button type="submit" class="btn btn-block"
									style="background: #ff9b05; color: #fff; font-weight: 700; text-transform: uppercase; padding: 11px; border-radius: 6px; border: none; font-size: 14px; letter-spacing: 0.5px;">
									Submit Review</button>
							</form>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>



	<%@include file="footer.jsp"%>



	<div id="sizeChartModal" class="modal"
		style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0, 0, 0, 0.5);">
		<div class="modal-content"
			style="background-color: #fff; margin: 10% auto; padding: 20px; border-radius: 12px; width: 90%; max-width: 500px; position: relative;">

			<span onclick="closeSizeChart()"
				style="position: absolute; right: 20px; top: 15px; font-size: 28px; font-weight: bold; cursor: pointer; color: #aaa;">&times;</span>

			<h3 id="sizeChartTitle"
				style="margin-top: 0; font-weight: 700; color: #2c3e50; border-bottom: 2px solid #ff9b05; padding-bottom: 8px;">Size
				Chart</h3>

			<!-- 1. POLO WEAR SIZE CHART -->
			<div id="poloSizeChart"
				style="display: none; overflow-x: auto; margin-top: 15px;">
				<table class="table table-bordered text-center" style="width: 100%;">
					<thead>
						<tr style="background-color: #f8f9fa;">
							<th>Size</th>
							<th>Chest (Inches)</th>
							<th>Length (Inches)</th>
							<th>Shoulder (Inches)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>S</b></td>
							<td>38"</td>
							<td>26.5"</td>
							<td>16.5"</td>
						</tr>
						<tr>
							<td><b>M</b></td>
							<td>40"</td>
							<td>27.5"</td>
							<td>17.5"</td>
						</tr>
						<tr>
							<td><b>L</b></td>
							<td>42"</td>
							<td>28.5"</td>
							<td>18.5"</td>
						</tr>
						<tr>
							<td><b>XL</b></td>
							<td>44"</td>
							<td>29.5"</td>
							<td>19.5"</td>
						</tr>
						<tr>
							<td><b>XXL</b></td>
							<td>46"</td>
							<td>30.5"</td>
							<td>20.5"</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 2. OVERSIZED WEAR SIZE CHART -->
			<div id="oversizedSizeChart"
				style="display: none; overflow-x: auto; margin-top: 15px;">
				<table class="table table-bordered text-center" style="width: 100%;">
					<thead>
						<tr style="background-color: #f8f9fa;">
							<th>Size</th>
							<th>Chest (Inches)</th>
							<th>Length (Inches)</th>
							<th>Drop Shoulder (Inches)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>S</b></td>
							<td>42"</td>
							<td>28"</td>
							<td>20"</td>
						</tr>
						<tr>
							<td><b>M</b></td>
							<td>44"</td>
							<td>29"</td>
							<td>21"</td>
						</tr>
						<tr>
							<td><b>L</b></td>
							<td>46"</td>
							<td>30"</td>
							<td>22"</td>
						</tr>
						<tr>
							<td><b>XL</b></td>
							<td>48"</td>
							<td>31"</td>
							<td>23"</td>
						</tr>
						<tr>
							<td><b>XXL</b></td>
							<td>50"</td>
							<td>32"</td>
							<td>24"</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 3. REGULAR / DEFAULT SIZE CHART -->
			<div id="regularSizeChart"
				style="display: none; overflow-x: auto; margin-top: 15px;">
				<table class="table table-bordered text-center" style="width: 100%;">
					<thead>
						<tr style="background-color: #f8f9fa;">
							<th>Size</th>
							<th>Chest (Inches)</th>
							<th>Front Length (Inches)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>S</b></td>
							<td>40"</td>
							<td>27"</td>
						</tr>
						<tr>
							<td><b>M</b></td>
							<td>42"</td>
							<td>28"</td>
						</tr>
						<tr>
							<td><b>L</b></td>
							<td>44"</td>
							<td>29"</td>
						</tr>
						<tr>
							<td><b>XL</b></td>
							<td>46"</td>
							<td>30"</td>
						</tr>
						<tr>
							<td><b>XXL</b></td>
							<td>48"</td>
							<td>31"</td>
						</tr>
					</tbody>
				</table>
			</div>

			<p style="font-size: 12px; color: #7f8c8d; margin-top: 10px;">*Note:
				Measurements may vary slightly by 0.5 inches due to manual auditing.</p>
		</div>
	</div>



	<script defer src="/js/jquery.flexslider.js"></script>
	<!--  <script src="/js/imagezoom.js"></script> -->
	<script src="/js/easyResponsiveTabs.js" type="text/javascript"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			let initialImg = $(".color-swatch.active").attr("data-variant-image");
			if(initialImg && initialImg.trim() !== "") {
				$("#mainProductImg").attr("src", initialImg);
			}
		});
		
		$(window).load(function() {
			$('.flexslider').flexslider({
				animation : "slide",
				controlNav : "thumbnails"
			});
		});

		function selectColorBlock(index, element) {
		    $(".color-swatch").removeClass("active");
		    $(element).addClass("active");

		    $(".size-wrapper").removeClass("active").addClass("size-wrapper");
		    $("#sizeWrapper_" + index).addClass("active");
		    
		    $('input[name="selectedSize"]').prop('checked', false);

		    let variantImgUrl = $(element).attr("data-variant-image");
		    if(variantImgUrl && variantImgUrl.trim() !== "") {
		       
		        $("#mainProductImg").attr("src", variantImgUrl);
		    }
		}

		function handleCartAction(action, itemId, btn) {
		    let activeColor = $(".color-swatch.active").text().trim();
		    let selectedSize = "";
		    
		    let errorId = "cartError_" + itemId;
		    let errorDiv = document.getElementById(errorId);
		    if (!errorDiv) {
		        errorDiv = document.createElement("div");
		        errorDiv.id = errorId;
		        errorDiv.style.color = "#e74c3c";
		        errorDiv.style.fontWeight = "600";
		        errorDiv.style.marginTop = "8px";
		        btn.parentElement.appendChild(errorDiv);
		    }
		    errorDiv.innerHTML = ""; 

		    let menSizeEl = document.getElementById("coupleMenSize");
		    let womenSizeEl = document.getElementById("coupleWomenSize");

		    if (menSizeEl && womenSizeEl) {
		       
		        let mSize = menSizeEl.value;
		        let wSize = womenSizeEl.value;

		        if (!mSize || !wSize) {
		            errorDiv.innerHTML = "⚠️ Please select BOTH Men and Women sizes for Couple Wear.";
		            return;
		        }
		        selectedSize = "Men:" + mSize + ",Women:" + wSize;
		    } else {
		       
		        let activeWrapper = $(".size-wrapper.active");
		        selectedSize = activeWrapper.find('input[name="selectedSize"]:checked').val();

		        if (activeWrapper.length > 0 && !selectedSize) {
		            errorDiv.innerHTML = "⚠️ Please select a size for the chosen color.";
		            return;
		        }
		    }

		    let url = '/' + (action === 'add' ? 'addToCart' : 'buyNow') + '?itemId=' + itemId;
		    
		    if (activeColor && activeColor !== "") { 
		        url += '&color=' + encodeURIComponent(activeColor); 
		    }
		    if (selectedSize) { 
		        url += '&size=' + encodeURIComponent(selectedSize); 
		    }

		  
		    if (action === 'add') {
		        fetch(url)
		        .then(res => res.text())
		        .then(data => {
		            if (data === "SUCCESS") {
		                btn.innerText = "Go to Cart";
		                btn.className = "btn btn-custom btn-success-go";
		                btn.onclick = goToCart;
		            } else if (data === "LOGIN_REQUIRED") {
		                alert("Please login first to add products to your cart.");
		                window.location.href = "/login";
		            } else if (data === "SIZE_REQUIRED") {
		                errorDiv.innerHTML = "⚠️ Please select size.";
		            } else {
		                errorDiv.innerHTML = "⚠️ Something went wrong. Please try again.";
		            }
		        })
		        .catch(err => {
		            console.error(err);
		            errorDiv.innerHTML = "⚠️ Network error. Please check server logs.";
		        });
		    } else {
		        window.location.href = url;
		    }
		}

		function goToCart(){ window.location.href = '/cart'; }
		function openSizeChart(subCatName) {
		    let modal = document.getElementById("sizeChartModal");
		    let poloChart = document.getElementById("poloSizeChart");
		    let oversizedChart = document.getElementById("oversizedSizeChart");
		    let regularChart = document.getElementById("regularSizeChart");
		    let title = document.getElementById("sizeChartTitle");

		   
		    poloChart.style.display = "none";
		    oversizedChart.style.display = "none";
		    regularChart.style.display = "none";

		    
		    if (subCatName && subCatName.toLowerCase().includes("polo")) {
		        title.innerText = "Polo Wear Size Chart";
		        poloChart.style.display = "block";
		    } else if (subCatName && subCatName.toLowerCase().includes("oversized")) {
		        title.innerText = "Oversized Wear Size Chart";
		        oversizedChart.style.display = "block";
		    } else {
		        title.innerText = "Standard Size Chart";
		        regularChart.style.display = "block";
		    }

		    modal.style.display = "block";
		}
		function closeSizeChart() { document.getElementById("sizeChartModal").style.display = "none"; }
		
		
		window.onclick = function(event) {
		    let modal = document.getElementById("sizeChartModal");
		    if (event.target == modal) {
		        modal.style.display = "none";
		    }
		}

		function checkDelivery(){
		    let pincode = document.getElementById("pincode").value;
		    
		    if(pincode.length !== 6 || isNaN(pincode)){ 
		        alert("Please enter a valid 6-digit pincode"); 
		        return; 
		    }
		    
		    document.getElementById("deliveryResult").innerText = "Checking availability...";
		    document.getElementById("deliveryResult").style.color = "#7f8c8d";

		    fetch('/checkDelivery?pincode=' + pincode)
		    .then(res => res.text())
		    .then(data => { 
		        let resultElement = document.getElementById("deliveryResult");
		        resultElement.innerText = data; 
		      
		        if(data.includes("❌")) {
		            resultElement.style.color = "#e74c3c"; // Red for errors
		        } else {
		            resultElement.style.color = "#2c3e50"; // Dark for success delivery track
		        }
		    })
		    .catch(err => {
		        console.error(err);
		        document.getElementById("deliveryResult").innerText = "⚠️ Error while fetching details.";
		    });
		}
	</script>
</body>
</html>
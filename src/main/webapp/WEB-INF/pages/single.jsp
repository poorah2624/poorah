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

/* --- Anti-Squeeze Professional Image Viewer --- */
.gallery-wrapper {
	position: relative;
	border: 1px solid #f0f0f0;
	border-radius: 12px;
	background: #fff;
}

.thumb-image {
	width: 100%;
	height: 480px; /* फिक्स्ड हाइट ताकि लेआउट न हिले */
	overflow: hidden;
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #fff;
}

#mainProductImg {
	max-height: 100%;
	max-width: 100%;
	width: auto !important;
	height: auto !important;
	object-fit: contain !important;
	/* इमेज का ओरिजिनल रेशियो कभी नहीं बिगड़ेगा */
	margin: 0 auto;
	display: block;
}

/* इमेज ज़ूम को सिकुड़ने से रोकने के लिए */
.zoomImg {
	background-color: #fff;
	object-fit: contain !important;
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
	color: #ff3f6c;
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
	border-radius: 25px; /* कैप्सूल डिजाइन */
	cursor: pointer;
	background: #fff;
	font-weight: 600;
	color: #555;
	transition: all 0.2s ease;
}

.color-swatch.active {
	border-color: #ff3f6c;
	background-color: #fff5f7;
	color: #ff3f6c;
}

.size-chart-link {
	color: #ff3f6c;
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
	display: none;
}

.size-wrapper.active {
	display: block; /* सिर्फ एक्टिव कलर के साइज दिखेंगे */
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
	display: none; /* ओरिजिनल गोल रेडियो बटन छिपाया */
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
	border: 2px solid #ff3f6c;
	color: #ff3f6c;
}

.btn-add-cart:hover {
	background: #fff5f7;
}

.btn-buy-now {
	background: #ff3f6c;
	border: 2px solid #ff3f6c;
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
</style>
</head>

<body>
	<%@include file="header1.jsp"%>

	<c:if test="${not empty defaultAddress}">
		<div
			style="background: #e9ecef; padding: 12px 0; border-bottom: 1px solid #dee2e6;">
			<div class="container" style="font-size: 14px; color: #495057;">
				<span class="glyphicon glyphicon-map-marker" style="color: #ff3f6c;"></span>
				<b>Deliver to:</b> ${defaultAddress.fullName},
				${defaultAddress.pincode} <a href="/address"
					style="margin-left: 15px; color: #ff3f6c; font-weight: 600;">Change</a>
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

				<!-- Left Column: Image Area (Flexslider with original imagezoom support) -->
				<div class="col-md-5 single-left">
					<div class="gallery-wrapper">
						<div class="flexslider" id="productFlexSlider">
							<ul class="slides">
								<li data-thumb="${fn:split(item.itemImage, ',')[0]}"
									id="mainDisplayLi">
									<div class="thumb-image">
										<!-- पुराना डेटा-इमेजज़ूम प्लगइन वापस लगा दिया गया है -->
										<img src="${fn:split(item.itemImage, ',')[0]}"
											id="mainProductImg" data-imagezoom="true"
											class="img-responsive">
									</div>
								</li>
								<c:forEach var="img" items="${fn:split(item.itemImage, ',')}"
									varStatus="loop">
									<c:if test="${!loop.first}">
										<li data-thumb="${img}">
											<div class="thumb-image">
												<img src="${img}" data-imagezoom="true"
													class="img-responsive">
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

				<!-- Right Column: Product Operations Section -->
				<div class="col-md-7 single-right">
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
								test="${(item.category.categoryName == 'Men' || item.category.categoryName == 'Women') && not empty item.variants}">

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
									<span class="section-title">Select Size</span> <a
										href="javascript:void(0);" class="size-chart-link"
										onclick="openSizeChart()"> <span
										class="glyphicon glyphicon-list-alt"></span> Size Chart
									</a>
								</div>

								<div class="size-options-container" style="margin-bottom: 25px;">
									<c:forEach var="v" items="${item.variants}" varStatus="status">
										<!-- यहाँ ID को फिक्स किया गया है (sizeWrapper_${status.index}) ताकि साइज रिपीट न हों -->
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

											<!-- S Size Card -->
											<label
												class="size-option-label ${sQty == '0' ? 'disabled-size' : ''}">
												<input type="radio" name="selectedSize" value="S"
												${sQty == '0' ? 'disabled' : ''}> <span
												class="size-custom-box">S</span> <c:if
													test="${sQty > 0 && sQty <= 5}">
													<span class="stock-warning">${sQty} Left!</span>
												</c:if>
											</label>

											<!-- M Size Card -->
											<label
												class="size-option-label ${mQty == '0' ? 'disabled-size' : ''}">
												<input type="radio" name="selectedSize" value="M"
												${mQty == '0' ? 'disabled' : ''}> <span
												class="size-custom-box">M</span> <c:if
													test="${mQty > 0 && mQty <= 5}">
													<span class="stock-warning">${mQty} Left!</span>
												</c:if>
											</label>

											<!-- L Size Card -->
											<label
												class="size-option-label ${lQty == '0' ? 'disabled-size' : ''}">
												<input type="radio" name="selectedSize" value="L"
												${lQty == '0' ? 'disabled' : ''}> <span
												class="size-custom-box">L</span> <c:if
													test="${lQty > 0 && lQty <= 5}">
													<span class="stock-warning">${lQty} Left!</span>
												</c:if>
											</label>

											<!-- XL Size Card -->
											<label
												class="size-option-label ${xlQty == '0' ? 'disabled-size' : ''}">
												<input type="radio" name="selectedSize" value="XL"
												${xlQty == '0' ? 'disabled' : ''}> <span
												class="size-custom-box">XL</span> <c:if
													test="${xlQty > 0 && xlQty <= 5}">
													<span class="stock-warning">${xlQty} Left!</span>
												</c:if>
											</label>

											<!-- XXL Size Card -->
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
								<b style="font-size: 15px;">↩️ 5 Days Easy Returns Available</b>
								<small style="display: block; color: #555; margin-top: 4px;">
									No returns applicable if purchased using "No Return Discount
									Offer". </small>
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
							style="font-weight: 700; color: #2c3e50; border-bottom: 2px solid #ff3f6c; padding-bottom: 8px; display: inline-block;">Product
							Overview</h4>
						<p
							style="margin-top: 15px; line-height: 1.8; color: #555; font-size: 15px;">${item.itemDesc}</p>
					</div>
					<div class="keyFeatures">
						<h4
							style="font-weight: 700; color: #2c3e50; border-bottom: 2px solid #ff3f6c; padding-bottom: 8px; display: inline-block;">Product
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

			<!-- Reviews Section Container Layout -->
			<div class="product-container-card row">
				<div class="col-xs-12">
					<div class="sap_tabs">
						<div id="horizontalTab1"
							style="display: block; width: 100%; margin: 0px;">
							<ul class="resp-tabs-list"
								style="border-bottom: 2px solid #eee; margin-bottom: 20px;">
								<li class="resp-tab-item" aria-controls="tab_item-1" role="tab"
									style="font-weight: 700; font-size: 16px;">Customer
									Reviews (${fn:length(reviews)})</li>
							</ul>

							<div class="resp-tabs-container">
								<div class="tab-2 resp-tab-content" aria-labelledby="tab_item-1">
									<div class="additional_info_sub_grids"
										style="max-height: 400px; overflow-y: auto; padding-right: 10px;">
										<c:forEach var="r" items="${reviews}">
											<div class="row"
												style="margin-bottom: 15px; border-bottom: 1px solid #f5f5f5; padding-bottom: 15px;">
												<div class="col-md-9">
													<h5 style="font-weight: 700; margin: 0 0 5px 0;">
														<c:choose>
															<c:when test="${not empty r.user}">${r.user.userName}</c:when>
															<c:otherwise>${r.guestName}</c:otherwise>
														</c:choose>
													</h5>
													<small class="text-muted" style="font-size: 11px;">Published
														on ${r.createdAt}</small>
													<p style="margin-top: 8px; color: #555; font-size: 14px;">${r.message}</p>
												</div>
												<div class="col-md-3 text-right">
													<c:forEach begin="1" end="5" var="step">
														<span
															style="color: ${step <= r.rating ? '#ffc107' : '#e0e0e0'}; font-size: 16px;">★</span>
													</c:forEach>
												</div>
											</div>
										</c:forEach>
										<c:if test="${empty reviews}">
											<p class="text-muted">No reviews yet for this product. Be
												the first to share your experience!</p>
										</c:if>
									</div>

									<!-- Add Review Area -->
									<div class="review_grids"
										style="margin-top: 30px; border-top: 1px dashed #ddd; padding-top: 25px;">
										<h4
											style="font-weight: 700; margin-bottom: 20px; color: #2c3e50;">Write
											a Review</h4>
										<form action="/addReview" method="post">
											<input type="hidden" name="itemId" value="${item.itemId}">
											<div class="row" style="margin-bottom: 15px;">
												<c:choose>
													<c:when test="${not empty sessionScope.LoggedInUser}">
														<div class="col-md-6">
															<input type="text" name="userName"
																value="${sessionScope.LoggedInUser.userName}"
																class="form-control" readonly
																style="background: #f8f9fa;">
														</div>
													</c:when>
													<c:otherwise>
														<div class="col-md-6" style="margin-bottom: 10px;">
															<input type="text" name="guestName"
																placeholder="Your Name" class="form-control" required>
														</div>
														<div class="col-md-6">
															<input type="email" name="guestEmail"
																placeholder="Your Email Address" class="form-control"
																required>
														</div>
													</c:otherwise>
												</c:choose>
											</div>

											<div class="form-group">
												<label>Select Rating:</label> <select name="rating"
													class="form-control" style="width: 180px;" required>
													<option value="5">⭐⭐⭐⭐⭐ (5/5)</option>
													<option value="4">⭐⭐⭐⭐ (4/5)</option>
													<option value="3">⭐⭐⭐ (3/5)</option>
													<option value="2">⭐⭐ (2/5)</option>
													<option value="1">⭐ (1/5)</option>
												</select>
											</div>

											<div class="form-group">
												<textarea name="message"
													placeholder="Share your experience with this product..."
													class="form-control" rows="4" required></textarea>
											</div>
											<input type="submit" value="Submit Review"
												class="btn btn-success"
												style="padding: 10px 25px; font-weight: 700;">
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Premium Size Chart Modal -->
	<div id="sizeChartModal" class="modal"
		style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6);">
		<div class="modal-content"
			style="background: #fff; width: 450px; margin: 10% auto; padding: 25px; border-radius: 12px; position: relative;">
			<span
				style="position: absolute; right: 20px; top: 15px; font-size: 28px; cursor: pointer; color: #aaa;"
				onclick="closeSizeChart()">&times;</span>
			<h3 style="font-weight: 700; margin-bottom: 15px; color: #2c3e50;">Standard
				Size Chart</h3>
			<table class="table table-bordered table-striped"
				style="margin-top: 15px;">
				<thead style="background: #f8f9fa;">
					<tr>
						<th>Size</th>
						<th>Chest (inch)</th>
						<th>Length (inch)</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><b>S</b></td>
						<td>36</td>
						<td>26</td>
					</tr>
					<tr>
						<td><b>M</b></td>
						<td>38</td>
						<td>27</td>
					</tr>
					<tr>
						<td><b>L</b></td>
						<td>40</td>
						<td>28</td>
					</tr>
					<tr>
						<td><b>XL</b></td>
						<td>42</td>
						<td>29</td>
					</tr>
					<tr>
						<td><b>XXL</b></td>
						<td>44</td>
						<td>30</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<%@include file="footer.jsp"%>

	<script defer src="/js/jquery.flexslider.js"></script>
	<script src="/js/imagezoom.js"></script>
	<script src="/js/easyResponsiveTabs.js" type="text/javascript"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#horizontalTab1').easyResponsiveTabs({
				type: 'default',           
				width: 'auto', 
				fit: true
			});
			
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

			// सिर्फ क्लिक किए गए इंडेक्स वाले साइज कंटेनर को एक्टिव करेगा
			$(".size-wrapper").removeClass("active");
			$("#sizeWrapper_" + index).addClass("active");
			
			$('input[name="selectedSize"]').prop('checked', false);

			let variantImgUrl = $(element).attr("data-variant-image");
			if(variantImgUrl && variantImgUrl.trim() !== "") {
				$("#mainProductImg").attr("src", variantImgUrl);
				$("#mainProductImg").attr("data-zoom-image", variantImgUrl);
				
				// प्लगइन इमेज ऑब्जेक्ट को री-फ्रेश करना ताकि सिकुड़े नहीं
				if($(".zoomImg").length > 0) {
					$(".zoomImg").attr("src", variantImgUrl); 
				}
			}
		}

		function handleCartAction(action, itemId, btn) {
			let activeWrapper = $(".size-wrapper.active");
			let selectedSize = activeWrapper.find('input[name="selectedSize"]:checked').val();
			let activeColor = $(".color-swatch.active").text().trim();

			let errorId = "cartError_" + itemId;
			let errorDiv = document.getElementById(errorId);
			if(!errorDiv){
				errorDiv = document.createElement("div");
				errorDiv.id = errorId;
				errorDiv.style.color = "#e74c3c";
				errorDiv.style.fontWeight = "600";
				errorDiv.style.marginTop = "8px";
				btn.parentElement.appendChild(errorDiv);
			}
			errorDiv.innerHTML = "";

			if (activeWrapper.length > 0 && !selectedSize) {
				errorDiv.innerHTML = "⚠️ Please select a size for the chosen color.";
				return;
			}

			let url = '/' + (action === 'add' ? 'addToCart' : 'buyNow') + '?itemId=' + itemId;
			if(activeColor) { url += '&color=' + encodeURIComponent(activeColor); }
			if(selectedSize) { url += '&size=' + selectedSize; }

			if(action === 'add') {
				fetch('https://www.poorah.com' + url)
				.then(() => {
					btn.innerText = "Go to Cart";
					btn.className = "btn btn-custom btn-success-go";
					btn.onclick = goToCart;
				})
				.catch(err => console.log(err));
			} else {
				window.location.href = url;
			}
		}

		function goToCart(){ window.location.href = '/cart'; }
		function openSizeChart() { document.getElementById("sizeChartModal").style.display = "block"; }
		function closeSizeChart() { document.getElementById("sizeChartModal").style.display = "none"; }

		function checkDelivery(){
			let pincode = document.getElementById("pincode").value;
			if(pincode.length !== 6){ alert("Enter valid pincode"); return; }
			document.getElementById("deliveryResult").innerText = "Checking...";
			fetch('https://www.poorah.com/checkDelivery?pincode=' + pincode)
			.then(res => res.text())
			.then(data => { document.getElementById("deliveryResult").innerText = data; })
			.catch(err => console.log(err));
		}
	</script>
</body>
</html>
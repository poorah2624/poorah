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
	max-width: 100% !important;
	max-height: 100% !important;
	width: auto !important;
	height: auto !important;
	object-fit: contain !important; 
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
										<img src="${fn:split(item.itemImage, ',')[0]}" id="mainProductImg" class="img-responsive">
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
								<b style="font-size: 15px;">↩️ 5 Days Easy Returns and Exchange Available</b>
								<small style="display: block; color: #555; margin-top: 4px;">(Conditions apply. No return on products purchased with "No Return Discount".) </small>
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

		</div>
	</div>

	<%@include file="footer.jsp"%>

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
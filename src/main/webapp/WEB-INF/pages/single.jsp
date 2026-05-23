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
/* --- Product Image & Gallery Fixes --- */
.single-left {
	margin-bottom: 20px;
}

.flexslider {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 8px;
	position: relative;
	zoom: 1;
}

.thumb-image {
	width: 100%;
	height: auto;
	min-height: 400px; /* मुख्य इमेज का न्यूनतम एरिया सेट किया */
	display: flex;
	align-items: center;
	justify-content: center;
	background: #fff;
	overflow: hidden;
	position: relative;
}

#mainProductImg {
	max-height: 500px;
	width: auto !important; /* विड्थ को ऑटो किया ताकि इमेज खिंचे नहीं */
	max-width: 100%;
	object-fit: contain; /* इमेज का आस्पेक्ट रेशियो सुरक्षित रखने के लिए */
	margin: 0 auto;
	display: block;
}
/* जूम होने वाली इमेज को सिकुड़ने से रोकने के लिए */
.zoomImg {
	background-color: #fff;
	object-fit: contain !important;
}

/* --- Color & Size Swatches Styling --- */
.color-swatch {
	display: inline-block;
	padding: 6px 14px;
	margin-right: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	cursor: pointer;
	background: #fff;
	transition: all 0.2s ease;
}

.color-swatch.active {
	border-color: #28a745;
	background-color: #e2f0d9;
	font-weight: bold;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.size-wrapper {
	display: none;
}

.size-wrapper.active {
	display: block;
}

.disabled-size {
	color: #ccc;
	text-decoration: line-through;
	cursor: not-allowed;
}
</style>
</head>

<body>
	<%@include file="header1.jsp"%>

	<c:if test="${not empty defaultAddress}">
		<div
			style="background: #f5f5f5; padding: 10px; margin-bottom: 15px; border-radius: 5px;">
			<div class="container">
				<b>Deliver to:</b> ${defaultAddress.fullName},
				${defaultAddress.pincode} <a href="/address"
					style="margin-left: 10px;">Change</a>
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

			<!-- Left Column: Image Gallery Viewer (col-md-5 किया ताकि इमेज बड़ी दिखे) -->
			<div class="col-md-5 single-left">
				<div class="flexslider" id="productFlexSlider">
					<ul class="slides">
						<!-- Target Main Active Display Container Box -->
						<li data-thumb="${fn:split(item.itemImage, ',')[0]}"
							id="mainDisplayLi">
							<div class="thumb-image">
								<img src="${fn:split(item.itemImage, ',')[0]}"
									id="mainProductImg" data-imagezoom="true"
									class="img-responsive">
							</div>
						</li>
						<!-- Remaining fallback dynamic slider tabs -->
						<c:forEach var="img" items="${fn:split(item.itemImage, ',')}"
							varStatus="loop">
							<c:if test="${!loop.first}">
								<li data-thumb="${img}">
									<div class="thumb-image">
										<img src="${img}" data-imagezoom="true" class="img-responsive">
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>

			<!-- Right Column: Product Management Detail Panel (col-md-7 किया संतुलन के लिए) -->
			<div class="col-md-7 single-right">
				<h3>${item.itemName}</h3>

				<div class="color-quality">
					<div class="color-quality-left" style="width: 100%;">

						<!-- VALIDATION CHECK -->
						<c:if
							test="${(item.category.categoryName == 'Men' || item.category.categoryName == 'Women') && not empty item.variants}">

							<!-- 1. SELECT COLOR CONFIGURATION -->
							<div style="margin-bottom: 20px;">
								<h5>Select Color:</h5>
								<c:forEach var="v" items="${item.variants}" varStatus="status">
									<span class="color-swatch ${status.first ? 'active' : ''}"
										data-variant-image="${v.variantImage}"
										onclick="selectColorBlock(${status.index}, this)">
										${v.variantColor} </span>
								</c:forEach>
							</div>

							<!-- 2. SELECT SIZES LAYOUT -->
							<div
								style="display: flex; align-items: center; gap: 15px; margin-bottom: 10px;">
								<h5 style="margin: 0;">Select Size:</h5>
								<a href="javascript:void(0);" class="size-chart-link"
									onclick="openSizeChart()">Size Chart</a>
							</div>

							<div class="size-options-container" style="margin-bottom: 20px;">
								<c:forEach var="v" items="${item.variants}" varStatus="status">
									<div id="sizeWrapper_"
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

										<!-- S SIZE -->
										<label style="margin-right: 15px;"
											class="${sQty == '0' ? 'disabled-size' : ''}"> <input
											type="radio" name="selectedSize" value="S"
											${sQty == '0' ? 'disabled' : ''}> S <c:choose>
												<c:when test="${sQty == '0'}"> (Out of stock)</c:when>
												<c:when test="${sQty > 0 && sQty <= 5}">
													<span style="color: red; font-weight: bold;"> (Only
														${sQty} left!)</span>
												</c:when>
											</c:choose>
										</label>

										<!-- M SIZE -->
										<label style="margin-right: 15px;"
											class="${mQty == '0' ? 'disabled-size' : ''}"> <input
											type="radio" name="selectedSize" value="M"
											${mQty == '0' ? 'disabled' : ''}> M <c:choose>
												<c:when test="${mQty == '0'}"> (Out of stock)</c:when>
												<c:when test="${mQty > 0 && mQty <= 5}">
													<span style="color: red; font-weight: bold;"> (Only
														${mQty} left!)</span>
												</c:when>
											</c:choose>
										</label>

										<!-- L SIZE -->
										<label style="margin-right: 15px;"
											class="${lQty == '0' ? 'disabled-size' : ''}"> <input
											type="radio" name="selectedSize" value="L"
											${lQty == '0' ? 'disabled' : ''}> L <c:choose>
												<c:when test="${lQty == '0'}"> (Out of stock)</c:when>
												<c:when test="${lQty > 0 && lQty <= 5}">
													<span style="color: red; font-weight: bold;"> (Only
														${lQty} left!)</span>
												</c:when>
											</c:choose>
										</label>

										<!-- XL SIZE -->
										<label style="margin-right: 15px;"
											class="${xlQty == '0' ? 'disabled-size' : ''}"> <input
											type="radio" name="selectedSize" value="XL"
											${xlQty == '0' ? 'disabled' : ''}> XL <c:choose>
												<c:when test="${xlQty == '0'}"> (Out of stock)</c:when>
												<c:when test="${xlQty > 0 && xlQty <= 5}">
													<span style="color: red; font-weight: bold;"> (Only
														${xlQty} left!)</span>
												</c:when>
											</c:choose>
										</label>

										<!-- XXL SIZE -->
										<c:if test="${not empty xxlQty}">
											<label style="margin-right: 15px;"
												class="${xxlQty eq '0' ? 'disabled-size' : ''}"> <input
												type="radio" name="selectedSize" value="XXL"
												${xxlQty eq '0' ? 'disabled' : ''}> XXL <c:choose>
													<c:when test="${xxlQty eq '0'}">(Out of stock)</c:when>
													<c:when test="${xxlQty > 0 && xxlQty <= 5}">
														<span style="color: red; font-weight: bold;"> (Only
															${xxlQty} left!) </span>
													</c:when>
												</c:choose>
											</label>
										</c:if>
									</div>
								</c:forEach>
							</div>
						</c:if>

						<c:if test="${empty item.variants}">
							<div
								style="margin-bottom: 20px; color: #28a745; font-weight: bold;">
								<span class="glyphicon glyphicon-ok-sign"></span> In Stock
								(Ready to dispatch)
							</div>
						</c:if>
					</div>

					<!-- Pricing and Transaction Buttons -->
					<div class="simpleCart_shelfItem"
						style="clear: both; margin-top: 20px;">
						<div class="price-section">
							<div class="final-price">
								₹
								<c:if test="${not empty item.discountedPrice}">
									<fmt:formatNumber value="${item.discountedPrice}"
										maxFractionDigits="0" />/-</c:if>
							</div>
							<div class="price-meta">
								<span class="old-price">₹<fmt:formatNumber
										value="${item.itemPrice}" maxFractionDigits="0" />/-
								</span> <span class="discount">${fn:split(item.discount, '.')[0]}%
									OFF</span>
							</div>
						</div>

						<c:choose>
							<c:when test="${not empty sessionScope.LoggedInUser}">
								<c:choose>
									<c:when test="${item.inCart}">
										<button onclick="goToCart()" class="btn btn-success">Go
											to Cart</button>
									</c:when>
									<c:otherwise>
										<button
											onclick="handleCartAction('add', ${item.itemId}, this)"
											class="btn btn-primary">Add to Cart</button>
										<button
											onclick="handleCartAction('buy', ${item.itemId}, this)"
											class="btn btn-primary"
											style="background: orange; border: none;">Buy Now</button>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<p>
									<a class="item_add"
										onclick="alert('Please login first to manage shopping cart operations.'); return false;"
										href="/login">Add to cart</a>
								</p>
							</c:otherwise>
						</c:choose>

						<div
							style="margin-top: 15px; padding: 10px; background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 5px;">
							<span style="color: #28a745; font-size: 16px;"> ↩️ 5 Days
								Easy Returns </span> <small
								style="display: block; color: #666; margin-top: 4px;">
								Conditions apply. No returns on products purchased with "No
								Return Discount". </small>
						</div>

						<div style="margin-top: 25px;">
							<input type="text" id="pincode" placeholder="Enter Pincode"
								class="form-control"
								style="width: 200px; display: inline-block;" />
							<button onclick="checkDelivery()" class="btn btn-primary">Check</button>
							<br> <i id="deliveryResult"
								style="margin-top: 10px; display: inline-block;"></i>
						</div>
					</div>

				</div>
				<div class="clearfix"></div>
				<div class="description">
					<h5>
						<i>Overview</i>
					</h5>
					<p>${item.itemDesc}</p>
				</div>
				<div class="keyFeatures">
					<h5>
						<i>Details</i>
					</h5>
					<ul>
						<c:forTokens items="${item.keyFeatures}" delims="." var="feature">
							<li>${feature}</li>
						</c:forTokens>
					</ul>
				</div>
			</div>
		</div>

		<!-- Reviews Tab Panel Section -->
		<div class="additional_info">
			<div class="container">
				<div class="sap_tabs">
					<div id="horizontalTab1"
						style="display: block; width: 100%; margin: 0px;">
						<ul class="resp-tabs-list">
							<li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Reviews</span></li>
						</ul>

						<div class="resp-tabs-container">
							<div class="tab-2 resp-tab-content additional_info_grid"
								aria-labelledby="tab_item-1">
								<h4>(${fn:length(reviews)}) Reviews</h4>
								<div class="additional_info_sub_grids"
									style="margin-top: 15px; max-height: 400px; overflow-y: auto;">
									<c:forEach var="r" items="${reviews}">
										<div class="col-xs-12 additional_info_sub_grid_right"
											style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
											<div class="col-md-9 additional_info_sub_grid_rightl">
												<h5>
													<c:choose>
														<c:when test="${not empty r.user}">${r.user.userName}</c:when>
														<c:otherwise>${r.guestName}</c:otherwise>
													</c:choose>
												</h5>
												<small class="text-muted">${r.createdAt}</small>
												<p style="margin-top: 5px; color: #555;">${r.message}</p>
											</div>
											<div class="col-md-3 additional_info_sub_grid_rightr"
												style="text-align: right;">
												<div class="rating">
													<c:forEach begin="1" end="5" var="step">
														<span
															style="color: ${step <= r.rating ? 'gold' : 'lightgray'}; font-size: 18px;">★</span>
													</c:forEach>
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
									</c:forEach>
									<c:if test="${empty reviews}">
										<p class="text-muted" style="margin-top: 10px;">No reviews
											yet for this product. Be the first one to review!</p>
									</c:if>
								</div>

								<div class="review_grids"
									style="margin-top: 30px; border-top: 1px dashed #ccc; padding-top: 20px;">
									<h5 style="font-weight: bold; margin-bottom: 15px;">Add A
										Review</h5>
									<form action="/addReview" method="post" class="form-vertical">
										<input type="hidden" name="itemId" value="${item.itemId}">
										<div class="row" style="margin-bottom: 15px;">
											<c:choose>
												<c:when test="${not empty sessionScope.LoggedInUser}">
													<div class="col-md-6">
														<input type="text" name="userName"
															value="${sessionScope.LoggedInUser.userName}"
															class="form-control" readonly style="background: #eee;">
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

										<div class="form-group" style="margin-bottom: 15px;">
											<label style="display: block; margin-bottom: 5px;">Your
												Rating:</label> <select name="rating" class="form-control"
												style="width: 150px;" required>
												<option value="5">⭐⭐⭐⭐⭐ (5/5)</option>
												<option value="4">⭐⭐⭐⭐ (4/5)</option>
												<option value="3">⭐⭐⭐ (3/5)</option>
												<option value="2">⭐⭐ (2/5)</option>
												<option value="1">⭐ (1/5)</option>
											</select>
										</div>

										<div class="form-group" style="margin-bottom: 15px;">
											<textarea name="message"
												placeholder="Add Your Review Message here..."
												class="form-control" rows="4" required></textarea>
										</div>
										<input type="submit" value="Submit Review"
											class="btn btn-success">
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Size Chart Modal -->
	<div id="sizeChartModal" class="modal"
		style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">
		<div class="modal-content"
			style="background: #fff; width: 400px; margin: 15% auto; padding: 20px; border-radius: 5px; position: relative;">
			<span
				style="position: absolute; right: 15px; top: 10px; font-size: 24px; cursor: pointer;"
				onclick="closeSizeChart()">&times;</span>
			<h3>Size Chart</h3>
			<table class="table table-striped" style="margin-top: 15px;">
				<tr>
					<th>Size</th>
					<th>Chest (inch)</th>
					<th>Length (inch)</th>
				</tr>
				<tr>
					<td>S</td>
					<td>36</td>
					<td>26</td>
				</tr>
				<tr>
					<td>M</td>
					<td>38</td>
					<td>27</td>
				</tr>
				<tr>
					<td>L</td>
					<td>40</td>
					<td>28</td>
				</tr>
				<tr>
					<td>XL</td>
					<td>42</td>
					<td>29</td>
				</tr>
				<tr>
					<td>XXL</td>
					<td>44</td>
					<td>30</td>
				</tr>
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

			$(".size-wrapper").removeClass("active");
			$("#sizeWrapper_" + index).addClass("active");
			
			$('input[name="selectedSize"]').prop('checked', false);

			let variantImgUrl = $(element).attr("data-variant-image");
			if(variantImgUrl && variantImgUrl.trim() !== "") {
				$("#mainProductImg").attr("src", variantImgUrl);
				$("#mainProductImg").attr("data-zoom-image", variantImgUrl);
				
				// यहाँ पुराना एब्सोल्यूट ज़ूम कंटेनर क्लीन करके नया री-असाइन करता है ताकि पुराना स्ट्रेच साफ़ हो जाए
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
				errorDiv.style.color = "red";
				errorDiv.style.marginTop = "8px";
				btn.parentElement.appendChild(errorDiv);
			}
			errorDiv.innerHTML = "";

			if (activeWrapper.length > 0 && !selectedSize) {
				errorDiv.innerHTML = "Please select a size for the chosen color.";
				return;
			}

			let url = '/' + (action === 'add' ? 'addToCart' : 'buyNow') + '?itemId=' + itemId;
			if(activeColor) { url += '&color=' + encodeURIComponent(activeColor); }
			if(selectedSize) { url += '&size=' + selectedSize; }

			if(action === 'add') {
				fetch('https://www.poorah.com' + url)
				.then(() => {
					btn.innerText = "Go to Cart";
					btn.className = "btn btn-success";
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
			fetch('https://www.poorah.com/checkDelivery?pincode=' + pincode)
			.then(res => res.text())
			.then(data => { document.getElementById("deliveryResult").innerText = data; })
			.catch(err => console.log(err));
		}
	</script>
</body>
</html>
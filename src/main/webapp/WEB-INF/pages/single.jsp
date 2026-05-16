<!-- AUTHOR AND HEADER META BLOCKS -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
<link rel="stylesheet" href="/css/flexslider.css" type="text/css" media="screen" />
<style>
	.color-swatch {
		display: inline-block;
		padding: 6px 12px;
		margin-right: 8px;
		border: 1px solid #ccc;
		border-radius: 4px;
		cursor: pointer;
		background: #fff;
	}
	.color-swatch.active {
		border-color: #28a745;
		background-color: #e2f0d9;
		font-weight: bold;
	}
	.size-wrapper {
		display: none; /* JavaScript handle karega toggle color select hone par */
	}
	.size-wrapper.active {
		display: block;
	}
</style>
</head>

<body>
	<%@include file="header1.jsp"%>

	<c:if test="${not empty defaultAddress}">
		<div style="background: #f5f5f5; padding: 10px; margin-bottom: 15px; border-radius: 5px; container">
			<div class="container">
				<b>Deliver to:</b> ${defaultAddress.fullName}, ${defaultAddress.pincode} 
				<a href="/address" style="margin-left:10px;">Change</a>
			</div>
		</div>
	</c:if>

	<!-- Breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Single Page</li>
			</ul>
		</div>
	</div>

	<!-- Single Product View Detail -->
	<div class="single">
		<div class="container">
			
			<!-- Image Flexslider View -->
			<div class="col-md-4 single-left">
				<div class="flexslider">
					<ul class="slides">
						<c:forEach var="img" items="${fn:split(item.itemImage, ',')}">
							<li data-thumb="${img}">
								<div class="thumb-image">
									<img src="${img}" data-imagezoom="true" class="img-responsive">
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<!-- Product Details Info Panel -->
			<div class="col-md-8 single-right">
				<h3>${item.itemName}</h3>

				<div class="description">
					<h5><i>Description</i></h5>
					<p>${item.itemDesc}</p>
				</div>
				<div class="keyFeatures">
					<h5><i>Key Features</i></h5>
					<p>${item.keyFeatures}</p>
				</div>

				<div class="color-quality">
					<div class="color-quality-left" style="width: 100%;">

						<c:if test="${item.category.categoryName == 'Men' || item.category.categoryName == 'Women' || not empty item.variants}">
							
							<!-- 1. STEP ONE: CHOOSE COLOR BLOCK -->
							<div style="margin-bottom: 20px;">
								<h5>Select Color:</h5>
								<c:forEach var="v" items="${item.variants}" varStatus="status">
									<span class="color-swatch ${status.first ? 'active' : ''}" 
										  onclick="selectColorBlock(${status.index}, this)">
										${v.variantColor}
									</span>
								</c:forEach>
							</div>

							<!-- 2. STEP TWO: DYNAMIC SIZE SELECTORS ACCORDING TO COLOR CHOSEN -->
							<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 10px;">
								<h5 style="margin: 0;">Select Size:</h5>
								<a href="javascript:void(0);" class="size-chart-link" onclick="openSizeChart()">Size Chart</a>
							</div>

							<div class="size-options-container">
								<c:forEach var="v" items="${item.variants}" varStatus="status">
									<div id="sizeWrapper_${status.index}" class="size-wrapper ${status.first ? 'active' : ''}">
										
										<c:set var="stockStr" value="${v.variantStock}" />
										
										<!-- Extract stocks to check availability -->
										<c:set var="sQty" value="${fn:contains(stockStr, 'S:') ? fn:substringBefore(fn:substringAfter(stockStr, 'S:'), ',M:') : '0'}" />
										<c:set var="mQty" value="${fn:contains(stockStr, 'M:') ? fn:substringBefore(fn:substringAfter(stockStr, 'M:'), ',L:') : '0'}" />
										<c:set var="lQty" value="${fn:contains(stockStr, 'L:') ? fn:substringBefore(fn:substringAfter(stockStr, 'L:'), ',XL:') : '0'}" />
										<c:set var="xlQty" value="${fn:contains(stockStr, 'XL:') ? fn:substringAfter(stockStr, 'XL:') : '0'}" />

										<!-- S Size Option Row -->
										<label style="margin-right: 15px; ${sQty == '0' ? 'color:#ccc; text-decoration:line-through;' : ''}">
											<input type="radio" name="selectedSize" value="S" ${sQty == '0' ? 'disabled' : ''}> S (${sQty} left)
										</label>

										<!-- M Size Option Row -->
										<label style="margin-right: 15px; ${mQty == '0' ? 'color:#ccc; text-decoration:line-through;' : ''}">
											<input type="radio" name="selectedSize" value="M" ${mQty == '0' ? 'disabled' : ''}> M (${mQty} left)
										</label>

										<!-- L Size Option Row -->
										<label style="margin-right: 15px; ${lQty == '0' ? 'color:#ccc; text-decoration:line-through;' : ''}">
											<input type="radio" name="selectedSize" value="L" ${lQty == '0' ? 'disabled' : ''}> L (${lQty} left)
										</label>

										<!-- XL Size Option Row -->
										<label style="margin-right: 15px; ${xlQty == '0' ? 'color:#ccc; text-decoration:line-through;' : ''}">
											<input type="radio" name="selectedSize" value="XL" ${xlQty == '0' ? 'disabled' : ''}> XL (${xlQty} left)
										</label>
									</div>
								</c:forEach>
							</div>
						</c:if>

					</div>

					<!-- Checkout Pricing and Action Buttons Elements -->
					<div class="simpleCart_shelfItem" style="clear:both; margin-top:20px;">
						<div class="price-section">
							<div class="final-price">
								₹<c:if test="${not empty item.discountedPrice}"><fmt:formatNumber value="${item.discountedPrice}" maxFractionDigits="0" />/-</c:if>
							</div>
							<div class="price-meta">
								<span class="old-price">₹<fmt:formatNumber value="${item.itemPrice}" maxFractionDigits="0" />/-</span> 
								<span class="discount">${fn:split(item.discount, '.')[0]}% OFF</span>
							</div>
						</div>

						<c:choose>
							<c:when test="${not empty sessionScope.LoggedInUser}">
								<c:choose>
									<c:when test="${item.inCart}">
										<button onclick="goToCart()" class="btn btn-success">Go to Cart</button>
									</c:when>
									<c:otherwise>
										<button onclick="handleCartAction('add', ${item.itemId}, this)" class="btn btn-primary">Add to Cart</button>
										<button onclick="handleCartAction('buy', ${item.itemId}, this)" class="btn btn-primary" style="background: orange; border:none;">Buy Now</button>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<p>
									<a class="item_add" onclick="alert('Please login first to add items into cart'); return false;" href="/login">Add to cart</a>
								</p>
							</c:otherwise>
						</c:choose>

						<div style="margin-top: 25px;">
							<input type="text" id="pincode" placeholder="Enter Pincode" class="form-control" style="width: 200px; display: inline-block;" />
							<button onclick="checkDelivery()" class="btn btn-primary">Check</button>
							<br><i id="deliveryResult" style="margin-top: 10px; display:inline-block;"></i>
						</div>
					</div>

				</div>
				<div class="clearfix"></div>
			</div>
		</div>

		<!-- Specification and Tab Info Block -->
		<div class="additional_info">
			<div class="container">
				<div class="sap_tabs">
					<div id="horizontalTab1" style="display: block; width: 100%; margin: 0px;">
						<ul>
							<li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>Product Specification</span></li>
							<li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Reviews</span></li>
						</ul>
						<div class="tab-1 resp-tab-content additional_info_grid" aria-labelledby="tab_item-0">
							<h3>${item.itemName}</h3>
							<table class="table table-bordered">
								<tr><th>Price</th><td>₹ ${item.itemPrice}</td></tr>
								<tr><th>Category</th><td>${item.category.categoryName}</td></tr>
								<tr><th>Sub Category</th><td>${item.subCategory.subCategoryName}</td></tr>
								<tr><th>Weight</th><td>${item.weight}</td></tr>
								<tr><th>Fabric</th><td>${item.fabric}</td></tr>
								<tr><th>Description</th><td>${item.itemDesc}</td></tr>
							</table>
						</div>

						<!-- Reviews Tab Item Block -->
						<div class="tab-2 resp-tab-content additional_info_grid" aria-labelledby="tab_item-1">
							<h4>(${fn:length(reviews)}) Reviews</h4>
							<div class="additional_info_sub_grids">
								<c:forEach var="r" items="${reviews}">
									<div class="col-xs-10 additional_info_sub_grid_right" style="margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px;">
										<div class="additional_info_sub_grid_rightl">
											<h5><c:choose><c:when test="${not empty r.user}">${r.user.userName}</c:when><c:otherwise>${r.guestName}</c:otherwise></c:choose></h5>
											<small class="text-muted">${r.createdAt}</small>
											<p style="margin-top:5px;">${r.message}</p>
										</div>
										<div class="additional_info_sub_grid_rightr">
											<div class="rating">
												<c:forEach begin="1" end="5" var="step">
													<span style="color: ${step <= r.rating ? 'gold' : 'lightgray'}; font-size: 18px;">★</span>
												</c:forEach>
											</div>
										</div>
										<div class="clearfix"></div>
									</div>
								</c:forEach>
							</div>
							
							<!-- Review Box Input Submission -->
							<div class="review_grids" style="margin-top:20px;">
								<h5>Add A Review</h5>
								<form action="/addReview" method="post">
									<input type="hidden" name="itemId" value="${item.itemId}">
									<textarea name="message" placeholder="Add Your Review" required="" class="form-control" rows="3" style="margin-bottom:10px;"></textarea>
									<input type="submit" value="Submit" class="btn btn-sm btn-success">
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Size Chart Modal Dashboard Content -->
	<div id="sizeChartModal" class="modal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.5);">
		<div class="modal-content" style="background:#fff; width:400px; margin:15% auto; padding:20px; border-radius:5px; position:relative;">
			<span style="position:absolute; right:15px; top:10px; font-size:24px; cursor:pointer;" onclick="closeSizeChart()">&times;</span>
			<h3>Size Chart</h3>
			<table class="table table-striped" style="margin-top:15px;">
				<tr><th>Size</th><th>Chest (inch)</th><th>Length (inch)</th></tr>
				<tr><td>S</td><td>36</td><td>26</td></tr>
				<tr><td>M</td><td>38</td><td>27</td></tr>
				<tr><td>L</td><td>40</td><td>28</td></tr>
				<tr><td>XL</td><td>42</td><td>29</td></tr>
			</table>
		</div>
	</div>

	<%@include file="footer.jsp"%>

	<!-- Core Flexslider and Tab Setup Dependencies Scripts -->
	<script defer src="/js/jquery.flexslider.js"></script>
	<script src="/js/imagezoom.js"></script>
	<script src="/js/easyResponsiveTabs.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#horizontalTab1').easyResponsiveTabs({
				type : 'default',           
				width : 'auto', 
				fit : true
			});
		});
		
		$(window).load(function() {
			$('.flexslider').flexslider({
				animation : "slide",
				controlNav : "thumbnails"
			});
		});

		// 1. CHOOSE ACTIVE COLOR FUNCTIONALITY
		function selectColorBlock(index, element) {
			$(".color-swatch").removeClass("active");
			$(element).addClass("active");

			$(".size-wrapper").removeClass("active");
			$("#sizeWrapper_" + index).addClass("active");
			
			// Uncheck previous sizes when color switches
			$('input[name="selectedSize"]').prop('checked', false);
		}

		// 2. CHECK SIZE AND TRIGGER SHOPPING CART ACTIONS
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

			// Build target parameters url query
			let url = '/' + (action === 'add' ? 'addToCart' : 'buyNow') + '?itemId=' + itemId;
			url += '&color=' + encodeURIComponent(activeColor);
			if(selectedSize) {
				url += '&size=' + selectedSize;
			}

			if(action === 'add') {
				fetch('https://www.poorah.com' + url)
				.then(() => {
					btn.innerText = "Go to Cart";
					btn.className = "btn btn-success";
					btn.onclick = goToCart;
				})
				.catch(err => console.log(err));
			} else {
				window.location.href = url; // Buy now redirects instantly
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
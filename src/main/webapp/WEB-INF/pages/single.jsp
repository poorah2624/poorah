<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
<link rel="stylesheet"
	href="/css/flexslider.css"
	type="text/css" media="screen" />
</head>

<body>
	<!-- header -->
	<%@include file="header.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>Single Page</h2>
		</div>
	</div> -->
	<!-- //banner -->

	<c:if test="${not empty defaultAddress}">

		<div
			style="background: #f5f5f5; padding: 10px; margin-bottom: 15px; border-radius: 5px;">

			<b>Deliver to:</b> ${defaultAddress.fullName},
			${defaultAddress.pincode} <a
				href="/address" style="float:;">Change</a>
		</div>

	</c:if>

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Single Page</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<!-- single -->
	<div class="single">
		<div class="container">
			<div class="col-md-4 single-left">
				<div class="flexslider">
					<ul class="slides">
						<c:forEach var="img" items="${fn:split(item.itemImage, ',')}">

							<li
								data-thumb="${img}">
								<div class="thumb-image">
									<img src="${img}"
										data-imagezoom="true" class="img-responsive">
								</div>
							</li>
							
						</c:forEach>
					</ul>
				</div>

			</div>
			<div class="col-md-8 single-right">
				<h3>${item.itemName }</h3>
				
				<div class="description">
					<h5>
						<i>Description</i>
					</h5>
					<p>${item.itemDesc }</p>
				</div>
				<div class="keyFeatures">
					<h5>
						<i>Key Features</i>
					</h5>
					<p>${item.keyFeatures }</p>
				</div>
				<div class="color-quality">
					<!--  <div class="color-quality-left">
						<h5>Color :</h5>
						<ul>
							<li><a href="#"><span></span>Red</a></li>
							<li><a href="#" class="brown"><span></span>Yellow</a></li>
							<li><a href="#" class="purple"><span></span>Purple</a></li>
							<li><a href="#" class="gray"><span></span>Violet</a></li>
						</ul>
					</div> -->
					<div class="color-quality-left">
						<h5>
							<c:choose>
								<c:when test="${item.category.categoryName == 'Kids'}">
                                 
                                   Size :
                                </c:when>
							</c:choose>
						</h5>

						<c:choose>


							


							<c:when test="${item.category.categoryName == 'Clothing'}">

								<c:forEach var="s" items="${fn:split(item.size, ',')}">
									<label style="margin-right: 10px;"> <input type="radio"
										name="size_${item.itemId}" value="${s}"> ${s}
									</label>
								</c:forEach>

							</c:when>

						</c:choose>
					</div>
					<!--  <div class="color-quality-right">
						<h5>Quantity :</h5>
						<div class="quantity">
							<div class="quantity-select">
								<div class="entry value-minus1">&nbsp;</div>
								<div class="entry value1">
									<span>1</span>
								</div>
								<div class="entry value-plus1 active">&nbsp;</div>
							</div>
						</div>


					</div>-->
					<div class="clearfix"></div>
				</div>
				<!--  <div class="occasional">
					<h5>Occasion :</h5>
					<div class="colr ert">
						<div class="check">
							<label class="checkbox"><input type="checkbox"
								name="checkbox" checked=""><i> </i>Occasion Wear</label>
						</div>
					</div>
					<div class="colr">
						<div class="check">
							<label class="checkbox"><input type="checkbox"
								name="checkbox"><i> </i>Party Wear</label>
						</div>
					</div>
					<div class="colr">
						<div class="check">
							<label class="checkbox"><input type="checkbox"
								name="checkbox"><i> </i>Formal Wear</label>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>  -->
				<div class="simpleCart_shelfItem">
					<div class="price-section">

								<div class="final-price">₹ <fmt:formatNumber value="${item.discountedPrice}" maxFractionDigits="0"/> /-</div>

								<div class="price-meta">
									<span class="old-price"> ₹ <fmt:formatNumber value="${item.itemPrice}" maxFractionDigits="0"/> /-</span> <span
										class="discount"> ${fn:split(item.discount, '.')[0]}% OFF </span>
								</div>

							</div>
					<c:choose>
						<c:when test="${not empty sessionScope.LoggedInUser}">

							<c:choose>

								<c:when test="${item.inCart}">
									<button onclick="goToCart()" class="btn btn-success">
										Go to Cart</button>
								</c:when>

								<c:otherwise>
									<button onclick="addToCart(${item.itemId}, this)"
										class="btn btn-primary">Add to Cart</button>
									<a onclick="return buyNowOrder(${item.itemId}, this)"
										class="btn btn-primary" value="Buy Now"
										style="background: orange;">Buy Now</a>
								</c:otherwise>

							</c:choose>

						</c:when>
						<c:otherwise>


							<p>
								<a class="item_add"
									onclick="return addToCart(${item.itemId}, this)"
									href="/addToCart?itemId=${item.itemId}">Add
									to cart</a>
							</p>

							
						</c:otherwise>

					</c:choose>
					<div style="margin-top: 15px;">

								<input type="text" id="pincode" placeholder="Enter Pincode"
									class="form-control"
									style="width: 200px; display: inline-block;" />

								<button onclick="checkDelivery()" class="btn btn-primary">
									Check</button>
									<br>

								<i id="deliveryResult" style="margin-top: 10px; color: green;"></i>

							</div>
					
				</div>

			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<div class="additional_info">
		<div class="container">
			<div class="sap_tabs">
				<div id="horizontalTab1"
					style="display: block; width: 100%; margin: 0px;">
					<ul>
						<li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>Product
								Specification</span></li>
						<li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Reviews</span></li>
					</ul>
					<div class="tab-1 resp-tab-content additional_info_grid"
						aria-labelledby="tab_item-0">
						<h3>${item.itemName }</h3>
						<table class="table table-bordered">
							<tr>
								<th>Price</th>
								<td>₹ ${item.itemPrice}</td>
							</tr>

							<tr>
								<th>Category</th>
								<td>${item.category.categoryName}</td>
							</tr>

							<tr>
								<th>Sub Category</th>
								<td>${item.subCategory.subCategoryName}</td>
							</tr>

							<c:choose>
								<c:when test="${item.category.categoryName == 'Kids'}">
									<tr>
										<th>Age</th>
										<td>${item.age}</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th>Size</th>
										<td>${item.size}</td>
									</tr>
								</c:otherwise>

							</c:choose>

							<tr>
								<th>Weight</th>
								<td>${item.weight}</td>
							</tr>

							<tr>
								<th>Fabric</th>
								<td>${item.fabric}</td>
							</tr>

							<tr>
								<th>Description</th>
								<td>${item.itemDesc}</td>
							</tr>
						</table>
					</div>

					<div class="tab-2 resp-tab-content additional_info_grid"
						aria-labelledby="tab_item-1">
						<h4>(${fn:length(reviews)}) Reviews</h4>

						<div class="additional_info_sub_grids">
							<c:forEach var="r" items="${reviews}">
								<div class="col-xs-10 additional_info_sub_grid_right">
									<div class="additional_info_sub_grid_rightl">
										<c:choose>
											<c:when test="${not empty r.user}">
                                              ${r.user.userName}
                                            </c:when>
											<c:otherwise>
                                              ${r.guestName}
                                            </c:otherwise>
										</c:choose>
										<h5>${r.createdAt }</h5>
										<p>${r.message }</p>
									</div>
									<div class="additional_info_sub_grid_rightr">
										<div class="rating">


											<c:forEach begin="1" end="5" var="i">
												<c:choose>
													<c:when test="${i <= r.rating}">
														<span style="color: gold; font-size: 20px;">★</span>
													</c:when>
													<c:otherwise>
														<span style="color: lightgray; font-size: 20px;">★</span>
													</c:otherwise>
												</c:choose>
											</c:forEach>

											<div class="clearfix"></div>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</c:forEach>
							<div class="clearfix"></div>
						</div>
						<div class="review_grids">
							<h5>Add A Review</h5>
							<form action="/addReview"
								method="post">
								<input type="hidden" name="itemId" value="${item.itemId}">
								<c:choose>
									<c:when test="${not empty sessionScope.LoggedInUser}">
										<input type="text" name="userName" value="Name"
											onfocus="this.value = '';"
											onblur="if (this.value == '') {this.value = 'Name';}"
											required="">
										<input type="email" name="userEmail" value="Email"
											onfocus="this.value = '';"
											onblur="if (this.value == '') {this.value = 'Email';}"
											required="">
									</c:when>
									<c:otherwise>
										<!-- guest form -->
										<input type="text" name="guestName" value="Name"
											onfocus="this.value = '';"
											onblur="if (this.value == '') {this.value = 'Name';}"
											required="">
										<input type="email" name="guestEmail" value="Email"
											onfocus="this.value = '';"
											onblur="if (this.value == '') {this.value = 'Email';}"
											required="">
									</c:otherwise>
								</c:choose>
								<br>
								<div class="star-rating">

									<input type="radio" name="rating" id="star5" value="5" checked><label
										for="star5">★</label> <input type="radio" name="rating"
										id="star4" value="4"><label for="star4">★</label> <input
										type="radio" name="rating" id="star3" value="3"><label
										for="star3">★</label> <input type="radio" name="rating"
										id="star2" value="2"><label for="star2">★</label> <input
										type="radio" name="rating" id="star1" value="1"><label
										for="star1">★</label>

								</div>

								<textarea name="message" onfocus="this.value = '';"
									onblur="if (this.value == '') {this.value = 'Add Your Review';}"
									required="">Add Your Review</textarea>
								<input type="submit" value="Submit">
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


	<!-- //single -->
	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

	<!-- js -->



	<!-- flixslider -->
	<script defer
		src="/js/jquery.flexslider.js"></script>
	<!-- zooming-effect -->
	<script src="/js/imagezoom.js"></script>
	<!-- //zooming-effect -->
	<!-- for bootstrap working -->

	<script
		src="/js/jquery.magnific-popup.js"></script>
	<script src="/js/jquery.flexisel.js"></script>
	<script src="/js/simpleCart.min.js"></script>
	<!-- //js -->
	<script
		src="/js/easyResponsiveTabs.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#horizontalTab1').easyResponsiveTabs({
				type : 'default', //Types: default, vertical, accordion           
				width : 'auto', //auto or any width like 600px
				fit : true
			// 100% fit in a container
			});
		});
	</script>

	<script>
		// Can also be used with $(document).ready()
		$(window).load(function() {
			$('.flexslider').flexslider({
				animation : "slide",
				controlNav : "thumbnails"
			});
		});
	</script>
	<!-- flixslider --

<!--quantity-->
	<script>
		$('.value-plus1')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value1'), newVal = parseInt(
									divUpd.text(), 10) + 1;
							divUpd.text(newVal);
						});

		$('.value-minus1')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value1'), newVal = parseInt(
									divUpd.text(), 10) - 1;
							if (newVal >= 1)
								divUpd.text(newVal);
						});
	</script>
	<!--quantity-->
	<script>

function addToCart(itemId, btn){

	let size = document.querySelector('input[name="size_' + itemId + '"]:checked')?.value;
    let age = document.querySelector('input[name="age_' + itemId + '"]:checked')?.value;
    
    console.log("SIZE:", size);
    console.log("AGE:", age);
    
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

    //  CATEGORY CHECK (important)
    let category = "${item.category.categoryName}";

    // Kids product
    if(category.toLowerCase() === "kids"){
        if(!age){
            errorDiv.innerHTML = "Please select age";
            return; // STOP API CALL
        }
    } else {
        if(!size){
            errorDiv.innerHTML = "Please select size";
            return; // STOP API CALL
        }
    }
    
    let url = '/addToCart?itemId=' + itemId;
    
    if(size){
        url += '&size=' + size;
    }
    if(age){
        url += '&age=' + age;
    }

    fetch(url)
    .then(response => {
        if(response.ok){

            // button change
            btn.innerText = "Go to Cart";
            btn.classList.remove("btn-primary");
            btn.classList.add("btn-success");

            // click change
            btn.onclick = goToCart;
        }
    })
    .catch(error => console.log(error));
}

function goToCart(){
    window.location.href = '/cart';
}

</script>

	<script>
function buyNowOrder(itemId, btn){

	let size = document.querySelector('input[name="size_' + itemId + '"]:checked')?.value;
    let age = document.querySelector('input[name="age_' + itemId + '"]:checked')?.value;
    
    console.log("SIZE:", size);
    console.log("AGE:", age);
    
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

    //  CATEGORY CHECK (important)
    let category = "${item.category.categoryName}";

    // Kids product
    if(category.toLowerCase() === "kids"){
        if(!age){
            errorDiv.innerHTML = "Please select age";
            return; // STOP API CALL
        }
    } else {
        if(!size){
            errorDiv.innerHTML = "Please select size";
            return; // STOP API CALL
        }
    }
    
    window.location.href = '/buyNow?itemId=' + itemId;

    return false;
}
</script>

<script>
function checkDelivery(){

    let pincode = document.getElementById("pincode").value;

    if(pincode.length !== 6){
        alert("Enter valid pincode");
        return;
    }

    fetch('/checkDelivery?pincode=' + pincode)
    .then(res => res.text())
    .then(data => {
        document.getElementById("deliveryResult").innerText = data;
    })
    .catch(err => console.log(err));
}
</script>


</body>
</html>
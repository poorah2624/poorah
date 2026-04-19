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

<!-- cart -->
<script src="${pageContext.request.contextPath}/js/simpleCart.min.js"></script>
<!-- cart -->

<link href='//fonts.googleapis.com/css?family=Glegoo:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'
	rel='stylesheet' type='text/css'>
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
</head>

<body>
	<!-- header -->
	<%@include file="header.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner8" id="home1">
		<div class="container">
			<h2>
				Women Cosmetics<span>up to</span> Flat 40% <i>Discount</i>
			</h2>
		</div>
	</div>-->
	<!-- //banner -->

	<c:if test="${not empty defaultAddress}">

		<div
			style="background: #f5f5f5; padding: 10px; margin-bottom: 15px; border-radius: 5px;">

			<b>Deliver to:</b> ${defaultAddress.fullName},
			${defaultAddress.pincode} <a
				href="${pageContext.request.contextPath}/address"
				style="float: ;">Change</a>
		</div>

	</c:if>

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="${pageContext.request.contextPath}/home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Products</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<!-- dresses -->
	<div class="dresses">
		<div class="container">
			<div class="w3ls_dresses_grids">
				<div class="col-md-4 w3ls_dresses_grid_left">
					<div class="w3ls_dresses_grid_left_grid">
						<h3>Categories</h3>
						<div class="w3ls_dresses_grid_left_grid_sub">
							<div class="panel-group" id="accordion" role="tablist"
								aria-multiselectable="true">


								<div id="collapseOne" class="panel-collapse collapse in"
									role="tabpanel" aria-labelledby="headingOne">
									<div class="panel-body panel_text">

										<ul>
											<li><a
												href="${pageContext.request.contextPath}/products">${category.categoryName }</a></li>
										</ul>

									</div>
								</div>


							</div>
							<ul class="panel_bottom">
								<li><a href="${pageContext.request.contextPath}/products2">Shop</a></li>
								<c:forEach var="c" items="${categories}">

									<li><a
										href="${pageContext.request.contextPath}/products3/category/${c.categoryId}">${c.categoryName }</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>


				</div>
				<div class="col-md-8 w3ls_dresses_grid_right">

					<div class="clearfix"></div>

					<div class="w3ls_dresses_grid_right_grid2">
						<div class="w3ls_dresses_grid_right_grid2_left">
							<h3>Showing Results: 0-1</h3>
						</div>
						<div class="w3ls_dresses_grid_right_grid2_right">
							<select name="select_item" class="select_item">
								<option selected="selected">Default sorting</option>
								<option>Sort by popularity</option>
								<option>Sort by average rating</option>
								<option>Sort by newness</option>
								<option>Sort by price: low to high</option>
								<option>Sort by price: high to low</option>
							</select>
						</div>
						<div class="clearfix"></div>
					</div>

					<div class="w3ls_dresses_grid_right_grid3">
						<c:forEach var="p" items="${items}">

							<div
								class="col-md-4 agileinfo_new_products_grid agileinfo_new_products_grid_dresses">


								<div class="agile_ecommerce_tab_left dresses_grid">



									<div class="hs-wrapper hs-wrapper2">
										<img
											src="${pageContext.request.contextPath}/uploads/${fn:split(p.itemImage, ',')[0]}"
											alt=" " class="img-responsive"
											style="width: 210px; height: 250px;" />

										<div class="w3_hs_bottom w3_hs_bottom_sub1">
											<ul>
												<li><a
													href="${pageContext.request.contextPath}/single/${p.itemId}"
													data-target="#myModal4"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>

									<h5>
										<a
											href="${pageContext.request.contextPath}/single/${p.itemId}">${p.itemName }</a>
									</h5>
									<div class="simpleCart_shelfItem" style="text-align:center;">
									  <div style="display:flex; justify-content:center; gap:10px; align-items:center;">
									<p>
									<b class="item_price">₹ <fmt:formatNumber value="${p.discountedPrice}" maxFractionDigits="0"/> /-</b>
									
								</p>
										<p>
											<!-- <span>&#8377 price/-</span>  -->
											<b class="item_price"><span>&#8377 <fmt:formatNumber value="${p.itemPrice }" maxFractionDigits="0"/>/-</span></b>
										</p>
										
                                     </div>
									</div>


								</div>

							</div>
						</c:forEach>

						<div class="clearfix"></div>
					</div>

				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>



	<!-- footer -->
	<%@include file="footer.jsp" %>
	<!-- //footer -->

	<script>

function addToCart(itemId, btn){

    fetch('${pageContext.request.contextPath}/addToCart?itemId=' + itemId)
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
    window.location.href = '${pageContext.request.contextPath}/cart';
}

</script>
</body>
</html>
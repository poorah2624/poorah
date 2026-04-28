<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<%@include file="head.jsp"%>
</head>

<body style="font-family: 'Poppins', sans-serif; background: #f8f9fa;">
	<!-- header -->

	<div data-aos="zoom-in">

		<%@include file="header.jsp"%>
		<!-- //header -->
		<!-- banner -->
		<!-- banner -->

		<div class="reveal">

			<div class="col-md-12">
				<jsp:include page="slider.jsp"></jsp:include>
			</div>
			<div class="clearfix"></div>
			</br>
		</div>
		</br>

		<!-- //banner -->
		<!-- //banner -->

		<div class="reveal">
			<div class="category-section">

				<!-- MEN -->
				<div class="category-box">
					<a href="/products/gender/MEN"> <img
						src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880777/11_o4fxd5.jpg"
						alt="Men">
						<div class="overlay">
							<h2>Men Collection</h2>
						</div>
					</a>
				</div>

				<!-- WOMEN -->
				<div class="category-box">
					<a href="/products/gender/WOMEN"> <img
						src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880777/22_bmq1op.jpg"
						alt="Women">
						<div class="overlay">
							<h2>Women Collection</h2>
						</div>
					</a>
				</div>

			</div>
		</div>

		<!-- banner-bottom -->
		<div class="reveal">
			<div class="banner-bottom">

				<div class="col-md-5 wthree_banner_bottom_left">
					<div class="video-img custom-upload-box">
						<div class="overlay"></div>
						<div class="overlay-content">


							<a href="/customDesign">
								<button class="upload-btn">Upload Design</button>
							</a>
						</div>

					</div>
					<!-- pop-up-box -->
					<link href="css/popuo-box.css" rel="stylesheet" type="text/css"
						property="" media="all" />
					<!--//pop-up-box -->
					<div id="small-dialog" class="mfp-hide">
						<iframe
							src="https://player.vimeo.com/video/23259282?title=0&byline=0&portrait=0"></iframe>
					</div>

				</div>

				<div class="clearfix"></div>

			</div>
		</div>
		<!-- //banner-bottom -->

		<div class="reveal">
			<div class="banner-bottom">
				<div class="col-md-12 wthree_banner_bottom_right">
					<div class="bs-example bs-example-tabs" role="tabpanel"
						data-example-id="togglable-tabs">
						<ul id="categoryTabs" class="nav nav-tabs" role="tablist">
							<c:forEach var="cat" items="${categories}">
								<li><a href="#tab-${cat.categoryId}" data-toggle="tab">${cat.categoryName}</a>
								</li>
							</c:forEach>
						</ul>
						<div id="myTabContent" class="tab-content">
							<c:forEach var="cat" items="${categories}" varStatus="status">
								<div role="tabpanel"
									class="tab-pane fade ${status.first ? 'active in' : ''}"
									id="tab-${cat.categoryId}">
									<div class="agile_ecommerce_tabs">
										<c:set var="itemsList"
											value="${categoryItems[cat.categoryId]}" />
										<div class="row">
											<c:forEach var="item" items="${itemsList}" begin="0" end="2">
												<div class="col-md-4 agile_ecommerce_tab_left">
													<div class="hs-wrapper">
														<img src="${fn:split(item.itemImage, ',')[0]}"
															alt="${item.itemName}" class="img-responsive" />
														<div class="w3_hs_bottom">
															<ul>
																<li><a href="/single/${item.itemId}"
																	data-target="#myModal"><span
																		class="glyphicon glyphicon-eye-open"
																		aria-hidden="true"></span></a></li>
															</ul>
														</div>
													</div>
													<div class="product-info">
														<h5>
															<a href="/single">${item.itemName}</a>
														</h5>
														<div class="simpleCart_shelfItem">
															<p class="price">
																₹
																<fmt:formatNumber value="${item.discountedPrice}"
																	maxFractionDigits="0" />
																<span>₹ <fmt:formatNumber
																		value="${item.itemPrice}" maxFractionDigits="0" /></span>
															</p>

														</div>
													</div>
												</div>



											</c:forEach>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

				</div>
				<div class="clearfix"></div>
			</div>
		</div>


		<div class="reveal">
			<div class="insta-slider">

				<div class="insta-track">
					<c:forEach var="s" items="${social}">
						<div class="insta-card">
							<blockquote class="instagram-media"
								data-instgrm-permalink="${s.url}" data-instgrm-version="14">
							</blockquote>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>

		<script async src="//www.instagram.com/embed.js"></script>

		<div class="reveal">

			<!-- footer -->
			<%@include file="footer.jsp"%>
		</div>
		<!-- //footer -->

	</div>



</body>
</html>
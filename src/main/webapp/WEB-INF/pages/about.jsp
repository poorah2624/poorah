<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
</head>

<body>
	<!-- header -->
	<%@include file="header.jsp"%>
	<!-- //header -->
	<!-- banner -->
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>About Us</h2>
		</div>
	</div> -->
	<!-- //banner -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>About Us</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<!-- about -->
	<div class="about">
		<div class="container">

			<div class="w3ls_about_grids">

				<div class="col-md-6 w3ls_about_grid_left">
					<p>Welcome to Poorah – where creativity meets quality.</p>
					<p>At Poorah, we believe that fashion is more than just
						clothing — it’s a way to express who you are. Our goal is to bring
						your ideas to life through high-quality custom printing on a wide
						range of products.</p>
					<p>We specialize in printed T-shirts for men, women, and kids,
						designed with creativity, comfort, and durability in mind. From
						trendy graphics and festive designs to personalized prints, we
						offer something for everyone.</p>
					<p>But we don’t stop at T-shirts. Poorah is your one-stop
						destination for all kinds of printed products. Whether it’s custom
						apparel or unique printed items, we aim to deliver products that
						stand out and make an impact.</p>
					
					<div class="col-xs-10 w3ls_about_grid_left2">
						<p>Our focus is simple:</p>
						<p>
							✔ Premium fabric and print quality<br>
							✔ Unique and eye-catching designs<br>
							✔ Affordable pricing<br>
							✔ Customer satisfaction at every step
						</p>
					</div>
					<div class="clearfix"></div>
					
					<div class="col-xs-10 w3ls_about_grid_left2">
						<p>Every product we create is crafted with attention to detail, ensuring that you receive not just a product, but an experience.</p>
						<p>Join us in celebrating style, creativity, and individuality — only at Poorah.</p>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="col-md-6 w3ls_about_grid_right">
					<img src="uploads/${about.aImage }" alt=" " class="img-responsive" />
				</div>
				<div class="clearfix"></div>
			</div>

		</div>
	</div>
	<!-- //about -->

	<!-- team -->
	<div class="team">
		<div class="container">
			<h3>Meet Our Team</h3>
			<div class="wthree_team_grids">
			 <c:forEach var="t" items="${team }">
				<div class="col-md-3 wthree_team_grid">
					<img src="uploads/${t.tImage}" alt=" " class="img-responsive" style="width: 120px;height: 120px;object-fit: cover;border-radius: 50%;"/>
					<h4>
						${t.tName } <span>${t.tDesignation }</span>
					</h4>
					<div class="agileits_social_button">
						<ul>
							<li><a href="#" class="facebook"> </a></li>
							<li><a href="#" class="twitter"> </a></li>
							<li><a href="#" class="google"> </a></li>
							<li><a href="#" class="pinterest"> </a></li>
						</ul>
					</div>
				</div>
				</c:forEach>
				<div class="clearfix"></div>
				<p>Behind every product, there’s a team that believes in quality, creativity, and customer satisfaction.</p>
			</div>
		</div>
	</div>
	<!-- //team -->
	<!-- team-bottom -->
	<!--  <div class="team-bottom">
		<div class="container">
			<h3>
				Are You Ready For Awesomeness? Flat <span>50% Offer</span> For
				Women's
			</h3>
			<p>Itaque earum rerum hic tenetur a sapiente delectus, ut aut
				reiciendis voluptatibus maiores alias consequatur aut perferendis
				doloribus asperiores repellat.</p>
			<a href="dresses.html">Shop Now</a>
		</div>
	</div>-->
	<!-- //team-bottom -->
	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

</body>
</html>
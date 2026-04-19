<!--Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>
<head>
<title>Shoppy an Admin Panel Category Flat Bootstrap Responsive
	Website Template | Login :: w3layouts</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Shoppy Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<link href="${pageContext.request.contextPath}/admin/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all">
<!-- Custom Theme files -->
<link href="${pageContext.request.contextPath}/admin/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<!--js-->
<script
	src="${pageContext.request.contextPath}/admin/js/jquery-2.1.1.min.js"></script>
<!--icons-css-->
<link
	href="${pageContext.request.contextPath}/admin/css/font-awesome.css"
	rel="stylesheet">
<!--Google Fonts-->
<link href='//fonts.googleapis.com/css?family=Carrois+Gothic'
	rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Work+Sans:400,500,600'
	rel='stylesheet' type='text/css'>
<!--static chart-->
</head>
<body>
	<div class="login-page">
		<div class="login-main">
			<div class="login-head">
				<h1>Forgot Password</h1>
			</div>
			<c:if test="${not empty Error}">
				<p style="color: red">${Error }</p>
			</c:if>
			<c:if test="${not empty msg}">
				<p style="color: green">${msg }</p>
			</c:if>
			<div class="login-block">
				<form action="${pageContext.request.contextPath}/forgot"
					method="post">
					<input type="text"
						pattern="[a-z][a-zA-Z0-9.+@]+@[a-zA-Z.]+\.[a-z]{2,3}"
						class="form-control" name="email" placeholder="Email" required="">
					<div class="forgot-top-grids">
						<div class="forgot-grid">
							<ul>
								<li><input type="checkbox" id="brand1" value=""> <label
									style="font-weight: normal;"> <input type="checkbox"
										name="remember" value="true"
										style="display: inline-block; width: auto; height: auto;">
										Remember me
								</label></li>
							</ul>
						</div>

						<div class="clearfix"></div>
					</div>
					<input type="submit" name="Sign In" value="Send Reset link">
					<h3>
						Not a member?<a href="signup.html"> Sign up now</a>
					</h3>
					<h2>or login with</h2>
					<div class="login-icons">
						<ul>
							<li><a href="#" class="facebook"><i
									class="fa fa-facebook"></i></a></li>
							<li><a href="#" class="twitter"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#" class="google"><i
									class="fa fa-google-plus"></i></a></li>
						</ul>
					</div>
				</form>
				<h5>
					<a href="index.html">Go Back to Home</a>
				</h5>
			</div>
		</div>
	</div>
	<!--inner block end here-->
	<!--copy rights start here-->
	<div class="copyrights">
		<p>
			© 2016 Shoppy. All Rights Reserved | Design by <a
				href="http://w3layouts.com/" target="_blank">W3layouts</a>
		</p>
	</div>
	<!--COPY rights end here-->

	<!--scrolling js-->
	<script
		src="${pageContext.request.contextPath}/admin/js/jquery.nicescroll.js"></script>
	<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
	<!--//scrolling js-->
	<script src="${pageContext.request.contextPath}/admin/js/bootstrap.js">
		
	</script>
	<!-- mother grid end here-->
</body>
</html>





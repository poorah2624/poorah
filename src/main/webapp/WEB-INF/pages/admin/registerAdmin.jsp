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
<link href="admin/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all">
<!-- Custom Theme files -->
<link href="admin/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<!--js-->
<script
	src="admin/js/jquery-2.1.1.min.js"></script>
<!--icons-css-->
<link
	href="admin/css/font-awesome.css"
	rel="stylesheet">
<!--Google Fonts-->
<link href='//fonts.googleapis.com/css?family=Carrois+Gothic'
	rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Work+Sans:400,500,600'
	rel='stylesheet' type='text/css'>
<!--static chart-->
</head>
<body>
	<div class="login-page" style="background-color: #EDEDED">
		<c:if test="${not empty Error}">
			<p style="color: red">${Error }</p>
		</c:if>
		<c:if test="${not empty msg}">
			<p style="color: green">${msg }</p>
		</c:if>
		<div class="login-main">
			<div class="login-head">
				<h1>Register</h1>
			</div>
			<c:if test="${not empty Error}">
				<p style="color: red">${Error }</p>
			</c:if>
			<c:if test="${not empty msg}">
				<p style="color: green">${msg }</p>
			</c:if>
			<div class="login-block">
				<form action="registerAdmin"
					method="post" enctype="multipart/form-data">
					<input placeholder="Name" pattern="([A-Za-z .])+" name="name"
						type="text" required=""> <input
						placeholder="Email Address"
						pattern="[a-z][a-zA-Z0-9.+@]+@[a-zA-Z.]+\.[a-z]{2,3}" name="email"
						type="email" required=""> <input
						placeholder="Alternate Email"
						pattern="[a-z][a-zA-Z0-9.+@]+@[a-zA-Z.]+\.[a-z]{2,3}"
						name="altEmail" type="email" required=""><input
						placeholder="Password" name="password" type="password" required="">
					<input placeholder="Confirm Password" name="confirmPassword"
						type="password" required=""> <input placeholder="Address"
						name="address" type="textarea" required=""><input
						placeholder="Mobile" name="mobile" type="text" required="">
					<input type="file" name="image" required="" /> </br>

					<div class="sign-up">
						<input type="submit" value="Sign Up" />
					</div>

				</form>



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
		src="admin/js/jquery.nicescroll.js"></script>
	<script src="admin/js/scripts.js"></script>
	<!--//scrolling js-->
	<script src="admin/js/bootstrap.js">
		
	</script>
	<!-- mother grid end here-->
</body>
</html>





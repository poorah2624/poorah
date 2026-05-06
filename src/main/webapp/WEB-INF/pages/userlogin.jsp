<%-- 
    Document   : userlogin
    Created on : 3 May, 2019, 4:46:38 PM
    Author     : Cuteepoo_pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="head.jsp"%>
</head>
<body>

	<div class="modal show" id="myModal88" tabindex="-1" role="dialog"
		style="display: block; background: rgba(0, 0, 0, 0.5);">
		<div class="modal-dialog modal-lg" style="margin-top: 80px;">
			<div class="modal-content">
				<div class="modal-header">
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button>  -->
					<c:if test="${not empty Error}">
						<p style="color: red">${Error }</p>
					</c:if>
					<c:if test="${not empty msg}">
						<p style="color: green">${msg }</p>
					</c:if>

					<h4 class="modal-title" id="myModalLabel">Don't Wait, Login
						now!</h4>
				</div>
				<div class="modal-body modal-body-sub">
					<div class="row" style="display: flex;">
						<div class="col-md-8 modal_body_left modal_body_left1"
							style="border-right: 1px dotted #C2C2C2; padding-right: 3em;">
							<div class="sap_tabs">
								<div id="horizontalTab"
									style="display: block; width: 100%; margin: 0px;">
									<ul class="resp-tabs-list">
										<li class="resp-tab-item" aria-controls="tab_item-0"><span>Sign
												in</span></li>
										<li class="resp-tab-item" aria-controls="tab_item-1"><span>Sign
												up</span></li>
										<li class="resp-tab-item" aria-controls="tab_item-2"><span>Forgot
												Password</span></li>
									</ul>
									<div class="tab-1 resp-tab-content"
										aria-labelledby="tab_item-0">
										<div class="facts">
											<div class="register">
												<form action="/dologin" method="post">
													<input name="userEmail"
														pattern="[a-z][a-zA-Z0-9.+@]+@[a-zA-Z.]+\.[a-z]{2,3}"
														placeholder="Email Address" type="text" required="">
													<input name="userPassword" placeholder="Password"
														type="password" required="">
													<div class="sign-up">
														<input type="submit" value="Sign in" />
													</div>
												</form>
											</div>
										</div>
									</div>

									<div class="tab-2 resp-tab-content"
										aria-labelledby="tab_item-1">
										<div class="facts">
											<div class="register">
												<form action="/register" method="post"
													enctype="multipart/form-data">
													<input placeholder="Name" pattern="([A-Za-z .])+"
														name="userName" type="text" required=""> <input
														placeholder="Email Address"
														pattern="[a-z][a-zA-Z0-9.+@]+@[a-zA-Z.]+\.[a-z]{2,3}"
														name="userEmail" type="email" required=""> <input
														placeholder="Password" name="userPassword" type="password"
														required=""> <input placeholder="Confirm Password"
														name="confirmPassword" type="password" required="">
													<input placeholder="Mobile" name="userMobile" type="text"
														required="">
													<div class="sign-up">
														<input type="submit" value="Create Account" />
													</div>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-3 resp-tab-content"
										aria-labelledby="tab_item-2">
										<div class="facts">
											<div class="register">
												<form action="/forgotPassword" method="post">
													<input name="userEmail" placeholder="Email Address"
														type="text" required="">
													<div class="sign-up">
														<input type="submit" value="Send Reset Link" />
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--  <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
							<script type="text/javascript">
								$(document).ready(function() {
									$('#horizontalTab').easyResponsiveTabs({
										type : 'default', //Types: default, vertical, accordion           
										width : 'auto', //auto or any width like 600px
										fit : true
									// 100% fit in a container
									});
								});
							</script>-->
							<div id="OR" class="hidden-xs">OR</div>
						</div>
						<div class="col-md-4 modal_body_right modal_body_right1">
							<div class="row text-center sign-with">
								<div class="col-md-12">
									<h3 class="other-nw">Sign in with</h3>
								</div>
								<div class="col-md-12">
									<ul class="social">
										<li><a href="#" onclick="googleLogin()"
											class="entypo-google"> </a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- js -->
	<script src="<c:url value='/js/jquery.min.js'/>"></script>
	<!-- for bootstrap working -->
	<script type="text/javascript"
		src="<c:url value='/js/bootstrap-3.1.1.min.js'/>"></script>
	<script src="<c:url value='/js/jquery.magnific-popup.js'/>"></script>
	<script src="<c:url value='/js/jquery.flexisel.js'/>"></script>
	<script src="<c:url value='/js/jquery.countdown.js'/>"></script>
	<script src="<c:url value='/js/jquery.wmuSlider.js'/>"></script>
	<script src="<c:url value='/js/simpleCart.min.js'/>"></script>
	<script src="<c:url value='/js/easyResponsiveTabs.js'/>"
		type="text/javascript"></script>
	<script src="<c:url value='/js/script.js'/>"></script>

	<script>
		$(document).ready(function() {
			$('.popup-with-zoom-anim').magnificPopup({
				type : 'inline',
				fixedContentPos : false,
				fixedBgPos : true,
				overflowY : 'auto',
				closeBtnInside : true,
				preloader : false,
				midClick : true,
				removalDelay : 300,
				mainClass : 'my-mfp-zoom-in'
			});

		});
	</script>
	<script>
		$('.example1').wmuSlider();
	</script>
	<script type="text/javascript">
		$(window).load(function() {
			$("#flexiselDemo1").flexisel({
				visibleItems : 4,
				animationSpeed : 1000,
				autoPlay : true,
				autoPlaySpeed : 3000,
				pauseOnHover : true,
				enableResponsiveBreakpoints : true,
				responsiveBreakpoints : {
					portrait : {
						changePoint : 480,
						visibleItems : 1
					},
					landscape : {
						changePoint : 640,
						visibleItems : 2
					},
					tablet : {
						changePoint : 768,
						visibleItems : 3
					}
				}
			});

		});
	</script>
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

	<script type="text/javascript">
		$(document).ready(function() {
			setTimeout(function() {
				if ($.fn.easyResponsiveTabs) {
					$('#horizontalTab').easyResponsiveTabs({
						type : 'default',
						width : 'auto',
						fit : true
					});
				}
			}, 300);
		});
	</script>


	<!-- //js -->

	<script src="https://www.gstatic.com/firebasejs/10.0.0/firebase-app.js"></script>
	<script
		src="https://www.gstatic.com/firebasejs/10.0.0/firebase-auth.js"></script>

	<script>
const firebaseConfig = {
		apiKey: "AIzaSyCnHe0gVTmrBlK3Q5h1SIQmmFCJ1a0NoSI",
		  authDomain: "poorah-30ac4.firebaseapp.com"
};

firebase.initializeApp(firebaseConfig);

function googleLogin(){
  const provider = new firebase.auth.GoogleAuthProvider();

  firebase.auth().signInWithPopup(provider)
    .then((result) => {

        const user = result.user;

        const email = user.email;
        const name = user.displayName;

        
        window.location.href = "googleLogin?email=" + email + "&name=" + name;
    })
    .catch((error) => {
        console.log(error);
    });
}
</script>

</body>
</html>

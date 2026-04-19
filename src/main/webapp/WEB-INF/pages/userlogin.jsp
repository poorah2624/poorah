<%-- 
    Document   : userlogin
    Created on : 3 May, 2019, 4:46:38 PM
    Author     : Cuteepoo_pc
--%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="head.jsp"%>
</head>
<body>

	<div class="modal fade" id="myModal88" tabindex="-1" role="dialog" aria-labelledby="myModal88" aria-hidden="true" >
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
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
					<div class="row">
						<div class="col-md-8 modal_body_left modal_body_left1"
							style="border-right: 1px dotted #C2C2C2; padding-right: 3em;">
							<div class="sap_tabs">
								<div id="horizontalTab"
									style="display: block; width: 100%; margin: 0px;">
									<ul>
										<li class="resp-tab-item" aria-controls="tab_item-0"><span>Sign
												in</span></li>
										<li class="resp-tab-item" aria-controls="tab_item-1"><span>Sign
												up</span></li>
										<li class="resp-tab-item" aria-controls="tab-item-2"><span>Forgot
												Password</span></li>
									</ul>
									<div class="tab-1 resp-tab-content"
										aria-labelledby="tab_item-0">
										<div class="facts">
											<div class="register">
												<form action="${pageContext.request.contextPath}/dologin"
													method="post">
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
												<form action="${pageContext.request.contextPath}/register"
													method="post" enctype="multipart/form-data">
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
												<form
													action="${pageContext.request.contextPath}/forgotPassword"
													method="post">
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
										<li class="social_facebook"><a href="#"
											class="entypo-facebook"></a></li>
										<li class="social_dribbble"><a href="#"
											class="entypo-dribbble"></a></li>
										<li class="social_twitter"><a href="#"
											class="entypo-twitter"></a></li>
										<li class="social_behance"><a href="#"
											class="entypo-behance"></a></li>
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
	<script src="js/jquery.min.js"></script>
	<!-- for bootstrap working -->
	<script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
	<script src="js/jquery.magnific-popup.js"></script>
	<script src="js/jquery.flexisel.js"></script>
	<script src="js/jquery.countdown.js"></script>
	<script src="js/jquery.wmuSlider.js"></script>
	<script src="js/simpleCart.min.js"></script>
	<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
	<script src="js/script.js"></script>

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
			$('#horizontalTab').easyResponsiveTabs({
				type : 'default', //Types: default, vertical, accordion           
				width : 'auto', //auto or any width like 600px
				fit : true
			// 100% fit in a container
			});
		});
	</script>
	<script>
		$('#myModal88').modal('show');
	</script>

	<!-- //js -->
	
	<c:if test="${empty sessionScope.LoggedInUser}">
    <script>
        $(document).ready(function(){
            $('#myModal88').modal({
                backdrop: 'static', // outside click se close nahi hoga
                keyboard: false     // ESC se close nahi hoga
            });

            $('#myModal88').modal('show');
        });
    </script>
</c:if>
</body>
</html>

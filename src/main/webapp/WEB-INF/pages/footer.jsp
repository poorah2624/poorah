
<div class="footer" style="text-align: left !important;">
	<div class="container">
		<div class="w3_footer_grids" style="text-align: left !important;">

			<div class="col-md-3 col-sm-6 w3_footer_grid"
				style="text-align: left !important; margin-bottom: 20px;">
				<h3
					style="text-align: left !important; font-size: 20px; color: #000; font-weight: bold; text-transform: uppercase; margin-bottom: 20px; border-bottom: 2px solid #ff9800; padding-bottom: 8px; display: inline-block;">Contact</h3>
				<ul class="address"
					style="padding: 0 !important; margin: 0 !important; list-style: none !important; text-align: left !important;">
					<li
						style="text-align: left !important; margin-bottom: 12px; color: #666; font-size: 14px; position: relative; padding-left: 25px;">
						<i class="glyphicon glyphicon-map-marker"
						style="position: absolute; left: 0; top: 3px; color: #333;"></i> <span
						style="display: block; text-align: left !important;">${cDetails.address}</span>
					</li>
					<li
						style="text-align: left !important; margin-bottom: 12px; color: #666; font-size: 14px; position: relative; padding-left: 25px;">
						<i class="glyphicon glyphicon-envelope"
						style="position: absolute; left: 0; top: 3px; color: #333;"></i> <a
						href="mailto:${cDetails.emailId}"
						style="color: #666; text-decoration: none;"><span
						style="display: block; text-align: left !important;">${cDetails.emailId}</span></a>
					</li>
					<li
						style="text-align: left !important; margin-bottom: 12px; color: #666; font-size: 14px; position: relative; padding-left: 25px;">
						<i class="glyphicon glyphicon-earphone"
						style="position: absolute; left: 0; top: 3px; color: #333;"></i> <span
						style="display: block; text-align: left !important;">${cDetails.mobileNo}</span>
					</li>
				</ul>
			</div>

			<div class="col-md-3 col-sm-6 w3_footer_grid"
				style="text-align: left !important; margin-bottom: 20px;">
				<h3
					style="text-align: left !important; font-size: 20px; color: #000; font-weight: bold; text-transform: uppercase; margin-bottom: 20px; border-bottom: 2px solid #ff9800; padding-bottom: 8px; display: inline-block;">Information</h3>
				<ul class="info"
					style="padding: 0 !important; margin: 0 !important; list-style: none !important; text-align: left !important;">
					<li style="text-align: left !important; margin-bottom: 10px;"><a
						href="/about"
						style="color: #666; text-decoration: none; display: block; text-align: left !important;">About
							Us</a></li>
					<li style="text-align: left !important; margin-bottom: 10px;"><a
						href="/mail"
						style="color: #666; text-decoration: none; display: block; text-align: left !important;">Contact
							Us</a></li>
					<li style="text-align: left !important; margin-bottom: 10px;"><a
						href="/faq"
						style="color: #666; text-decoration: none; display: block; text-align: left !important;">FAQ's</a></li>
					<li style="text-align: left !important; margin-bottom: 10px;"><a
						href="/products2"
						style="color: #666; text-decoration: none; display: block; text-align: left !important;">Special
							Products</a></li>
				</ul>
			</div>

			<div class="col-md-3 col-sm-6 w3_footer_grid"
				style="text-align: left !important; margin-bottom: 20px;">
				<h3
					style="text-align: left !important; font-size: 20px; color: #000; font-weight: bold; text-transform: uppercase; margin-bottom: 20px; border-bottom: 2px solid #ff9800; padding-bottom: 8px; display: inline-block;">Category</h3>
				<ul class="info"
					style="padding: 0 !important; margin: 0 !important; list-style: none !important; text-align: left !important;">
					<c:forEach var="c" items="${categories}">
						<li style="text-align: left !important; margin-bottom: 10px;"><a
							href="/products3/category/${c.categoryId}"
							style="color: #666; text-decoration: none; display: block; text-align: left !important;">${c.categoryName}</a></li>
					</c:forEach>
				</ul>
			</div>

			<div class="col-md-3 col-sm-6 w3_footer_grid"
				style="text-align: left !important; margin-bottom: 20px;">
				<h3
					style="text-align: left !important; font-size: 20px; color: #000; font-weight: bold; text-transform: uppercase; margin-bottom: 20px; border-bottom: 2px solid #ff9800; padding-bottom: 8px; display: inline-block;">Profile</h3>
				<ul class="info"
					style="padding: 0 !important; margin: 0 !important; list-style: none !important; text-align: left !important; margin-bottom: 15px;">
					<li style="text-align: left !important; margin-bottom: 10px;"><a
						href="/cart"
						style="color: #666; text-decoration: none; display: block; text-align: left !important;">My
							Cart</a></li>
				</ul>

				<h4
					style="text-align: left !important; color: #ff9800; font-size: 16px; font-weight: bold; margin-bottom: 12px; text-transform: uppercase;">Follow
					Us</h4>
				<div class="agileits_social_button"
					style="text-align: left !important;">
					<ul
						style="padding: 0 !important; margin: 0 !important; list-style: none !important; text-align: left !important;">
						<li
							style="display: inline-block !important; margin-right: 8px !important;">
							<a
							href="https://www.facebook.com/share/15o2B42JpFz/?mibextid=wwXIfr"
							target="_blank"
							style="display: block !important; width: 36px !important; height: 36px !important; background: #111 !important; color: #fff !important; border-radius: 50% !important; text-align: center !important; line-height: 36px !important; font-size: 16px !important; text-decoration: none !important;">
								<i class="fa fa-facebook"
								style="color: #fff !important; line-height: 36px !important;"></i>
						</a>
						</li>
						<li
							style="display: inline-block !important; margin-right: 8px !important;">
							<a
							href="https://www.instagram.com/poorah_official?igsh=c3gxN2RscjdsYzhu&utm_source=qr"
							target="_blank"
							style="display: block !important; width: 36px !important; height: 36px !important; background: #111 !important; color: #fff !important; border-radius: 50% !important; text-align: center !important; line-height: 36px !important; font-size: 16px !important; text-decoration: none !important;">
								<i class="fa fa-instagram"
								style="color: #fff !important; line-height: 36px !important;"></i>
						</a>
						</li>
						<li
							style="display: inline-block !important; margin-right: 8px !important;">
							<a
							href="https://youtube.com/@poorah_official?si=8ccRnxp2cGtgTz1z"
							target="_blank"
							style="display: block !important; width: 36px !important; height: 36px !important; background: #111 !important; color: #fff !important; border-radius: 50% !important; text-align: center !important; line-height: 36px !important; font-size: 16px !important; text-decoration: none !important;">
								<i class="fa fa-youtube-play"
								style="color: #fff !important; line-height: 36px !important;"></i>
						</a>
						</li>
						<li
							style="display: inline-block !important; margin-right: 8px !important;">
							<a href="#" target="_blank"
							style="display: block !important; width: 36px !important; height: 36px !important; background: #111 !important; color: #fff !important; border-radius: 50% !important; text-align: center !important; line-height: 36px !important; font-size: 16px !important; text-decoration: none !important;">
								<i class="fa fa-linkedin"
								style="color: #fff !important; line-height: 36px !important;"></i>
						</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="clearfix"></div>
		</div>
	</div>

	<div class="footer-copy">
		<div class="footer-copy1">
			<div class="footer-copy-pos">
				<a href="#home1" class="scroll"><img
					src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880816/arrow_ykqi4r.png"
					alt=" " class="img-responsive" /></a>
			</div>
		</div>
		<div class="container">
			<p>Copyright &copy; 2016 Women's Fashion. All Rights Reserved.</p>
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
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
	$(document).ready(function() {
		$('#customCarousel1').carousel({
			interval : 3000,
			ride : 'carousel'
		});
	});
</script>


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
	AOS.init({
		duration : 1000,
		once : true

	});
</script>

<script>
	$(window).load(function() {

		if (window.instgrm) {
			window.instgrm.Embeds.process();
		}
	});
</script>



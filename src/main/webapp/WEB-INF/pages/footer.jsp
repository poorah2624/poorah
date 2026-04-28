
<div class="footer">
	<div class="container">
		<div class="w3_footer_grids">
			<div class="col-md-3 w3_footer_grid">
				<h3>Contact</h3>

				<ul class="address">
					<li><i class="glyphicon glyphicon-map-marker"
						aria-hidden="true"></i>${cDetails.address }</span></li>
					<li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i><a
						href="mailto:info@example.com">${cDetails.emailId }</a></li>
					<li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>${cDetails.mobileNo }</li>
				</ul>
			</div>
			<div class="col-md-3 w3_footer_grid">
				<h3>Information</h3>
				<ul class="info">
					<li><a href="/about">About Us</a></li>
					<li><a href="/mail">Contact Us</a></li>
					<li><a href="/faq">FAQ's</a></li>
					<li><a href="/products2">Special Products</a></li>
				</ul>
			</div>
			<div class="col-md-3 w3_footer_grid">
				<h3>Category</h3>
				<ul class="info">
					<c:forEach var="c" items="${categories}">
						<li><a href="/products3/category/${c.categoryId}">${c.categoryName }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-md-3 w3_footer_grid">
				<h3>Profile</h3>
				<ul class="info">

					<li><a href="/cart">My Cart</a></li>
				</ul>
				<h4>Follow Us</h4>
				<div class="agileits_social_button">
					<ul>
						<li><a href="#" class="facebook"> </a></li>
						<li><a href="#" class="twitter"> </a></li>
						<li><a href="#" class="google"> </a></li>
						<li><a href="#" class="pinterest"> </a></li>
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



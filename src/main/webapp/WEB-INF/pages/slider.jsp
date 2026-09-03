<!-- slider section -->

<!-- slider section -->
<section class="slider_section">

	<div id="customCarousel1" class="carousel slide" data-ride="carousel"
		data-interval="3000">

		<div class="carousel-inner">

			<c:forEach var="b" items="${banner}" varStatus="status">
				<div class="item ${status.first ? 'active' : ''}">

					<div class="hero_area">

						<!-- IMAGE -->
						<div class="bg-box">
							<img src="${pageContext.request.contextPath}${b.bannerName}" />
						</div>



					</div>

				</div>
			</c:forEach>

		</div>
		<!-- LEFT ARROW -->
		<a class="carousel-control-prev" href="#customCarousel1" role="button"
			data-slide="prev"> <span class="carousel-control-prev-icon"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a>

		<!-- RIGHT ARROW -->
		<a class="carousel-control-next" href="#customCarousel1" role="button"
			data-slide="next"> <span class="carousel-control-next-icon"
			aria-hidden="true"></span> <span class="sr-only">Next</span>
		</a>

		<!-- DOTS -->
		<ol class="carousel-indicators">
			<c:forEach var="b" items="${banner}" varStatus="status">
				<li data-target="#customCarousel1" data-slide-to="${status.index}"
					class="${status.first ? 'active' : ''}"></li>
			</c:forEach>
		</ol>

	</div>

</section>
<!-- end slider section -->
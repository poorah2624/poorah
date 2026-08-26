<c:choose>
	<%-- ================= CASE 1: IF USER NOT LOGGED IN ================= --%>
	<c:when test="${empty sessionScope.LoggedInUser}">
		<c:if test="${not empty Error}">
			<p style="color: red; text-align: center;">${Error}</p>
		</c:if>
		<c:if test="${not empty msg}">
			<p style="color: green; text-align: center;">${msg}</p>
		</c:if>

		<div class="header">
			<div class="navigation">
				<nav class="navbar navbar-default">

					<div class="navbar-header nav_2">
						<a href="/home" class="mobile-brand-logo-link"> <img
							src="https://pub-f72b42c19b69475d89c86633058f5a7c.r2.dev/brand_image.png"
							alt="PooRah Logo" class="mobile-brand-logo">
						</a>

						<button type="button"
							class="navbar-toggle collapsed navbar-toggle1"
							data-toggle="collapse" data-target="#bs-megadropdown-tabs">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>

					<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
						<ul class="nav navbar-nav">
							<li class="desktop-logo-item"><a href="/home"
								style="padding: 10px 15px;"> <img
									src="https://pub-f72b42c19b69475d89c86633058f5a7c.r2.dev/brand_image.png"
									alt="PooRah Logo" class="site-logo">
							</a></li>
							<li class="active"><a href="/home" class="act">Home</a></li>

							<c:forEach var="cat" items="${categories}">
								<li class="dropdown mobile-category"><a
									href="/products3/category/${cat.categoryId}"
									class="category-link">${cat.categoryName}</a>
									<ul class="dropdown-menu">
										<c:forEach var="sub" items="${cat.subCategory}">
											<li><a href="/products/${sub.subCategoryId}">${sub.subCategoryName}</a></li>
										</c:forEach>
									</ul></li>
							</c:forEach>

							<li><a href="/userlogin" class="login-btn"><i
									class="fa fa-user"></i> Login</a></li>

							<li class="right-section"><a href="/cart"> (${cartCount}
									Items) <img
									src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880990/bag_yjk2pm.png" />
							</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</c:when>

	<%-- ================= CASE 2: IF USER LOGGED IN ================= --%>
	<c:otherwise>
		<c:if test="${not empty Error}">
			<p style="color: red; text-align: center;">${Error}</p>
		</c:if>
		<c:if test="${not empty msg}">
			<p style="color: green; text-align: center;">${msg}</p>
		</c:if>

		<div class="header">
			<div class="navigation">
				<nav class="navbar navbar-default">

					<div class="navbar-header nav_2">
						<a href="/home" class="mobile-brand-logo-link"> <img
							src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880803/brand_image_t93n6o.png"
							alt="PooRah Logo" class="mobile-brand-logo">
						</a>

						<button type="button"
							class="navbar-toggle collapsed navbar-toggle1"
							data-toggle="collapse" data-target="#bs-megadropdown-tabs">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>

					<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
						<ul class="nav navbar-nav">
							<li class="desktop-logo-item"><a href="/home"
								style="padding: 10px 15px;"> <img
									src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880803/brand_image_t93n6o.png"
									alt="PooRah Logo" class="site-logo">
							</a></li>
							<li class="active"><a href="/home" class="act">Home</a></li>

							<c:forEach var="cat" items="${categories}">
								<li class="dropdown mobile-category"><a
									href="/products3/category/${cat.categoryId}"
									class="category-link">${cat.categoryName}</a>
									<ul class="dropdown-menu">
										<c:forEach var="sub" items="${cat.subCategory}">
											<li><a href="/products/${sub.subCategoryId}">${sub.subCategoryName}</a></li>
										</c:forEach>
									</ul></li>
							</c:forEach>

							<li class="dropdown" style="position: relative;"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown"> Hi,
									${sessionScope.LoggedInUser.userName} <span class="caret"></span>
							</a>
								<ul class="dropdown-menu" style="left: 0; right: auto;">
									<li><a href="/userProfile">Dashboard</a></li>
									<li><a href="/address">Addresses</a></li>
									<li><a href="/myOrders">My Orders</a></li>
									<li><a href="/userlogin">Logout</a></li>
								</ul></li>

							<li class="right-section"><a href="/cart"> (${cartCount}
									Items) <img
									src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880990/bag_yjk2pm.png" />
							</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</c:otherwise>
</c:choose>

<script>
	if (window.innerWidth <= 768) {
		document.querySelectorAll('.mobile-category > .category-link').forEach(
				function(link) {
					link.addEventListener('click', function(e) {
						let parent = this.parentElement;
						if (!parent.classList.contains('mobile-open')) {
							e.preventDefault();
							document.querySelectorAll('.mobile-category')
									.forEach(function(item) {
										item.classList.remove('mobile-open');
									});
							parent.classList.add('mobile-open');
						}
					});
				});
	}
</script>
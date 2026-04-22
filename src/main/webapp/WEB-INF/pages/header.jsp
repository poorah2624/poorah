

<c:choose>
	<c:when test="${empty sessionScope.LoggedInUser}">
		<c:if test="${not empty Error}">
			<p style="color: red">${Error }</p>
		</c:if>
		<c:if test="${not empty msg}">
			<p style="color: green">${msg }</p>
		</c:if>
		<div class="header">
		
		
			
				<!--  <div class="w3l_login">
					<a href="/userlogin"
						data-target="#myModal88"><span
						class="glyphicon glyphicon-user" aria-hidden="true"></span></a>

				</div>-->


				<!-- <div class="w3l_logo">
					<h1>
						<a href="/home" class="logo-container"><img
							src="/uploads/brand_image.png"
							alt="PooRah Logo" class="site-logo"> <span class="tagline">For
								Fashion Lovers</span> 
								</a>
					</h1>
				</div>  -->
                <!--   <div class= "container">

				<div class="search">
					<input class="search_box" type="checkbox" id="search_box">
					<label class="icon-search" for="search_box"><span
						class="glyphicon glyphicon-search" aria-hidden="true"></span></label>
					<div class="search_form">
						<form action="#" method="post">
							<input type="text" name="Search" placeholder="Search...">
							<input type="submit" value="Send">
						</form>
					</div>
				</div>
				<div class="cart box_1">
					<a href="/cart">
						<div class="total"></div> <img
						src="/uploads/bag.png" alt="" />
					</a>
					<p>
						<a href="javascript:;" class="simpleCart_empty">Empty Cart</a>
					</p>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div> -->
		
		
	
		<div class="navigation">
			
				<nav class="navbar navbar-default" style="align-items: center;">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header nav_2">
						<button type="button"
							class="navbar-toggle collapsed navbar-toggle1"
							data-toggle="collapse" data-target="#bs-megadropdown-tabs">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>
					<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
						<ul class="nav navbar-nav" style="gap: 20px;">
						<li><img
							src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880803/brand_image_t93n6o.png"
							alt="PooRah Logo" class="site-logo"></li>
							<li class="active"><a
								href="/home" class="act">Home</a></li>
							<%--  Mega Menu --%>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Products <b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<div class="row">
										<c:forEach var="cat" items="${categories}">
											<div class="col-sm-3">
												<ul class="multi-column-dropdown">
													<h6>${cat.categoryName}</h6>
													<c:forEach var="sub" items="${cat.subCategory}">
														<li><a
															href="/products/${sub.subCategoryId}">${sub.subCategoryName }</a></li>
													</c:forEach>


												</ul>
											</div>


											<%--   <div class="col-sm-4">
												<div class="w3ls_products_pos">
													<h4>
														50%<i>Off/-</i>
													</h4>
													<img src="images/1.jpg" alt=" " class="img-responsive" />
												</div>
											</div>
											<div class="clearfix"></div>--%>
										</c:forEach>
									</div>
								</ul></li>
							<li><a href="/about">About
									Us</a></li>

							<li><a href="/mail">Mail
									Us</a></li>
							<li><a href="/userlogin"
								class="login-btn"><i class="fa fa-user"></i>Login</a></li>
								
								<li>
					<a href="/cart">
						(${cartCount} Items) <img
						src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880990/bag_yjk2pm.png" alt="" />
					</a>
					
					
				</li>
				<li>
				<div class="search">
					<input class="search_box" type="checkbox" id="search_box">
					<label class="icon-search" for="search_box"><span
						class="glyphicon glyphicon-search" aria-hidden="true"></span></label>
					<div class="search_form">
						<form action="#" method="post">
							<input type="text" name="Search" placeholder="Search...">
							<input type="submit" value="Send">
						</form>
					</div>
				</div>
				</li>
						</ul>
					</div>
				</nav>
			
		</div>
	</c:when>
	<%--  if user logged in --%>
	<c:otherwise>
		<c:if test="${not empty Error}">
			<p style="color: red">${Error }</p>
		</c:if>
		<c:if test="${not empty msg}">
			<p style="color: green">${msg }</p>
		</c:if>
		<div class="header">
			

				<!-- <div class="w3l_logo">
					<h1>
						<a href="/home" class="logo-container"><img
							src="/uploads/brand_image.png"
							alt="PooRah Logo" class="site-logo"><!--  <span class="tagline">For
								Fashion Lovers</span> 
								</a>
					</h1>
				</div>  -->
               <!--   <div class="container">
				<div class="search">
					<input class="search_box" type="checkbox" id="search_box">
					<label class="icon-search" for="search_box"><span
						class="glyphicon glyphicon-search" aria-hidden="true"></span></label>
					<div class="search_form">
						<form action="#" method="post">
							<input type="text" name="Search" placeholder="Search...">
							<input type="submit" value="Send">
						</form>
					</div>
				</div>
				<div class="cart box_1">
					<a href="/cart">
						<div class="total">(${cartCount} items)</div> <img
						src="/uploads/bag.png" alt="" />
					</a>
					<p>
						<a href="/emptyCart"
							class="simpleCart_empty">Empty Cart</a>
					</p>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			
		</div> -->
		<div class="navigation">
			
				<nav class="navbar navbar-default">
					<%-- Brand and toggle get grouped for better mobile display --%>
					<div class="navbar-header nav_2">
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
						<li><img
							src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880803/brand_image_t93n6o.png"
							alt="PooRah Logo" class="site-logo"></li>
							<li class="active"><a
								href="/home" class="act">Home</a></li>
							<%-- Mega Menu --%>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Products <b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<div class="row">
										<c:forEach var="cat" items="${categories}">
											<div class="col-sm-3">
												<ul class="multi-column-dropdown">
													<h6>${cat.categoryName}</h6>
													<c:forEach var="sub" items="${cat.subCategory}">
														<li><a
															href="/products/${sub.subCategoryId}">${sub.subCategoryName }</a></li>
													</c:forEach>


												</ul>
											</div>
										</c:forEach>
									</div>
								</ul></li>
							<li><a href="/about">About
									Us</a></li>

							<li><a href="/mail">Mail
									Us</a></li>

							<li class="dropdown" style="position: relative;"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown"> Hi,
									${sessionScope.LoggedInUser.userName} <span class="caret"></span>
							</a>

								<ul class="dropdown-menu" style="left: 0; right: auto;">
									<li><a
										href="/userProfile">Dashboard</a></li>
									<li><a href="/address">Addresses</a></li>
									<li><a href="/myOrders">My
											Orders</a></li>
									<li><a href="/userlogin">Logout</a></li>
								</ul></li>
								
								
								<li>
					<a href="/cart">
						(${cartCount} Items) <img
						src="/uploads/bag.png" alt="" />
					</a>
					
					
				</li>
				<li>
				<div class="search">
					<input class="search_box" type="checkbox" id="search_box">
					<label class="icon-search" for="search_box"><span
						class="glyphicon glyphicon-search" aria-hidden="true"></span></label>
					<div class="search_form">
						<form action="#" method="post">
							<input type="text" name="Search" placeholder="Search...">
							<input type="submit" value="Send">
						</form>
					</div>
				</div>
				</li>
						</ul>
					</div>
				</nav>
			
		</div>
	</c:otherwise>

	<%--  //header --%>
</c:choose>




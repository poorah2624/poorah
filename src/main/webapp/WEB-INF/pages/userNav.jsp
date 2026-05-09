<%-- 
    Document   : userNav
    Created on : 16 May, 2019, 4:33:35 PM
    Author     : Angel_pc
--%>



	
	<div class="row">
		<div class="col-md-12">
			<div class="profile-bar">
				<div class="contents">

					<p class="profile-name">Hello,
						${sessionScope.LoggedInUser.userName}!</p>
					<p class="profile-description">Welcome to Womens Fashion!</p>
					<div class="buttons">
						<ul>
							<li><a href="/userProfile"><i
									class="ti-user"></i><span> Profile</span></a></li>
							<li><a href=""><i class="ti-thumb-up"></i><span>Review</span></a>
							</li>

							<li><a href=""><i class="ti-key"></i><span>Change
										Password</span></a></li>
							<li><a href=""><i class="ti-shopping-cart"></i><span>My
										Cart</span></a></li>
							<li><a href=""><i class="ti-truck"></i><span>Order
										History</span></a></li>


						</ul>

					</div>


				</div>

			</div>
		</div>
	</div>


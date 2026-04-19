<%-- 
    Document   : sidebar
    Created on : Jul 31, 2018, 9:42:29 AM
    Author     : APTA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

						<div class="menu_section">
							<h3>General</h3>
							<ul class="nav side-menu">
                                                            <li><a><i class="fa fa-user"></i> Admin Profile <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                       
                                                                            <li><a href="${pageContext.request.contextPath}/edit_profile">Edit Profile</a>
										</li>
										<li><a href="${pageContext.request.contextPath}/change_Password">Change Password</a>
										</li>
                                                                             
									</ul>
								</li>
                                                                
								<li><a><i class="fa fa-file-image-o"></i> Banner <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/Add_Banner">Add Banner</a>
										</li>
										<li><a href="${pageContext.request.contextPath}/view_Banner">View Banner</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-file-image-o"></i> Gallery <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/Add_Gallery">Add Gallery</a>
										</li>
										<li><a href="${pageContext.request.contextPath}/view_Gallery">View Gallery</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-bars"></i> Category <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/Add_Category">Add Category</a>
										</li>
										<li><a href="${pageContext.request.contextPath}/view_Category">View Category</a>
										</li>
                                                                                <li><a href="${pageContext.request.contextPath}/Add_SubCategory">Add Sub-Category</a>
										</li>
                                                                                <li><a href="${pageContext.request.contextPath}/view_SubCategory">View Sub-Category</a>
										</li>
                                                                                <li><a href="${pageContext.request.contextPath}/Add_Item">Add Item</a>
										</li>
                                                                                <li><a href="${pageContext.request.contextPath}/view_Item">View Item</a>
										</li>
									</ul>
								</li>
								<li><a><i class="glyphicon glyphicon-heart-empty"></i> Testimonial <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/Testimonial">View Testimonial</a>
										</li>
										
									</ul>
								</li>
                                                                <li><a><i class="fa fa-question"></i> FAQ'S <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/ADD_FAQ">Add FAQ</a>
										</li>
										 <li><a href="${pageContext.request.contextPath}/View_FAQ">View FAQ</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-location-arrow"></i> Contact Details <span class="fa fa-chevron-down"></span></a>
                                                                    
									<ul class="nav child_menu" style="display: none">
                                                                          
                                                                            <li><a href="${pageContext.request.contextPath}/contactdetails">Contact Details</a>
										</li>
                                                                              
										 
									</ul>
                                                                   
								</li>
                                                                
                                                                <li><a><i class="fa fa-edit"></i> Pages <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/Addaboutus">Update About Us</a></li>
                                                                            <li><a href="${pageContext.request.contextPath}/PrivacyPolicy">Update Privacy Policy</a> </li>
								            <li><a href="${pageContext.request.contextPath}/Term_Condition">Update Terms & Conditions</a>
						                           </li>
                                                                           <li><a href="${pageContext.request.contextPath}/Add_team">Add Team</a>
						                           </li>
                                                                           <li><a href="${pageContext.request.contextPath}/View_team">View Team</a>
						                           </li>
                                                                           
                              					         </ul>
                                                                </li>
                                                                 <li><a><i class="fa fa-question"></i>Query<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/contact_Query">Contact Query</a>
										</li>
										 <li><a href="${pageContext.request.contextPath}/service_Query">Service Query</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-pin"></i> Pin <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/AddPin">Add Pin</a>
										</li>
										 <li><a href="${pageContext.request.contextPath}/viewPin">View Pin</a>
										</li>
									</ul>
								</li>
                                                                
                                                                 <li><a><i class="fa fa-cart-plus"></i>Orders<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="${pageContext.request.contextPath}/manage_order">Manage Orders</a>
									 <li><a href="${pageContext.request.contextPath}/order_History">Order History</a>
									 <li><a href="${pageContext.request.contextPath}/returns">Returns</a>
										<li><a href="${pageContext.request.contextPath}/exchange">Exchange</a>
                                                                            </li>
										
									</ul>
								</li>
								 <li><a><i class="fa fa-instagram"></i>Instagram<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                      <li><a href="${pageContext.request.contextPath}/add_insta">Add Instagram</a>
									 <li><a href="${pageContext.request.contextPath}/edit_insta">Edit Instagram</a>
									 <li><a href="${pageContext.request.contextPath}/view_insta">View Instagram</a>
									
										
									</ul>
								</li>
                                                                 <li><a><i class="fa fa-user"></i>Manage Accounts<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                           <!--   <li><a href="${pageContext.request.contextPath}/add_subadmin">Add Sub-Admin</a> </li>
                                                                             <li><a href="${pageContext.request.contextPath}/view_subadmin">View Sub-Admin</a> </li>  -->
									   <li><a href="${pageContext.request.contextPath}/view_Vendor">View Vendor</a>
										
                                                                            </li>
										
									</ul>
								</li>
                                                                
                                                                    
						</div>
					</div>   
    </body>
</html>

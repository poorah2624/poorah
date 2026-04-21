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
                                                                       
                                                                            <li><a href="edit_profile">Edit Profile</a>
										</li>
										<li><a href="change_Password">Change Password</a>
										</li>
                                                                             
									</ul>
								</li>
                                                                
								<li><a><i class="fa fa-file-image-o"></i> Banner <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Banner">Add Banner</a>
										</li>
										<li><a href="view_Banner">View Banner</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-file-image-o"></i> Gallery <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Gallery">Add Gallery</a>
										</li>
										<li><a href="view_Gallery">View Gallery</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-bars"></i> Category <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Category">Add Category</a>
										</li>
										<li><a href="view_Category">View Category</a>
										</li>
                                                                                <li><a href="Add_SubCategory">Add Sub-Category</a>
										</li>
                                                                                <li><a href="view_SubCategory">View Sub-Category</a>
										</li>
                                                                                <li><a href="Add_Item">Add Item</a>
										</li>
                                                                                <li><a href="view_Item">View Item</a>
										</li>
									</ul>
								</li>
								<li><a><i class="glyphicon glyphicon-heart-empty"></i> Testimonial <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Testimonial">View Testimonial</a>
										</li>
										
									</ul>
								</li>
                                                                <li><a><i class="fa fa-question"></i> FAQ'S <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="ADD_FAQ">Add FAQ</a>
										</li>
										 <li><a href="View_FAQ">View FAQ</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-location-arrow"></i> Contact Details <span class="fa fa-chevron-down"></span></a>
                                                                    
									<ul class="nav child_menu" style="display: none">
                                                                          
                                                                            <li><a href="contactdetails">Contact Details</a>
										</li>
                                                                              
										 
									</ul>
                                                                   
								</li>
                                                                
                                                                <li><a><i class="fa fa-edit"></i> Pages <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Addaboutus">Update About Us</a></li>
                                                                            <li><a href="PrivacyPolicy">Update Privacy Policy</a> </li>
								            <li><a href="Term_Condition">Update Terms & Conditions</a>
						                           </li>
                                                                           <li><a href="Add_team">Add Team</a>
						                           </li>
                                                                           <li><a href="View_team">View Team</a>
						                           </li>
                                                                           
                              					         </ul>
                                                                </li>
                                                                 <li><a><i class="fa fa-question"></i>Query<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="contact_Query">Contact Query</a>
										</li>
										 <li><a href="service_Query">Service Query</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-pin"></i> Pin <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="AddPin">Add Pin</a>
										</li>
										 <li><a href="viewPin">View Pin</a>
										</li>
									</ul>
								</li>
                                                                
                                                                 <li><a><i class="fa fa-cart-plus"></i>Orders<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="manage_order">Manage Orders</a>
									 <li><a href="order_History">Order History</a>
									 <li><a href="returns">Returns</a>
										<li><a href="exchange">Exchange</a>
                                                                            </li>
										
									</ul>
								</li>
								 <li><a><i class="fa fa-instagram"></i>Instagram<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                      <li><a href="add_insta">Add Instagram</a>
									 <li><a href="edit_insta">Edit Instagram</a>
									 <li><a href="view_insta">View Instagram</a>
									
										
									</ul>
								</li>
                                                                 <li><a><i class="fa fa-user"></i>Manage Accounts<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                           <!--   <li><a href="add_subadmin">Add Sub-Admin</a> </li>
                                                                             <li><a href="view_subadmin">View Sub-Admin</a> </li>  -->
									   <li><a href="view_Vendor">View Vendor</a>
										
                                                                            </li>
										
									</ul>
								</li>
                                                                
                                                                    
						</div>
					</div>   
    </body>
</html>

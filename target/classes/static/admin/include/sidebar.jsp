<%-- 
    Document   : sidebar
    Created on : Jul 31, 2018, 9:42:29 AM
    Author     : APTA
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.Connection"%>
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
                                                                            <%
                          Connection cn=new Connect().getConnection();
                          PreparedStatement ps=cn.prepareStatement("select * from admintable");
                          ResultSet rs=ps.executeQuery();
                          if(rs.next())
                          {
                      %>
                                                                            <li><a href="edit_profile.jsp?adminId=<%=rs.getString("adminId")%>&name=<%=rs.getString("name")%>&email=<%=rs.getString("email")%>&website=<%=rs.getString("website")%>&designation=<%=rs.getString("designation")%>&mobile=<%=rs.getString("mobile")%>">Edit Profile</a>
										</li>
										<li><a href="change_Password.jsp">Change Password</a>
										</li>
                                                                                <%
                                                                                    }
                                                                                %>
									</ul>
								</li>
                                                                
								<li><a><i class="fa fa-file-image-o"></i> Banner <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Banner.jsp">Add Banner</a>
										</li>
										<li><a href="view_Banner.jsp">View Banner</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-file-image-o"></i> Gallery <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Gallery.jsp">Add Gallery</a>
										</li>
										<li><a href="view_Gallery.jsp">View Gallery</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-bars"></i> Category <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Add_Category.jsp">Add Category</a>
										</li>
										<li><a href="view_Category.jsp">View Category</a>
										</li>
                                                                                <li><a href="Add_SubCategory.jsp">Add Sub-Category</a>
										</li>
                                                                                <li><a href="view_SubCategory.jsp">View Sub-Category</a>
										</li>
                                                                                <li><a href="Add_Item.jsp">Add Item</a>
										</li>
                                                                                <li><a href="view_Item.jsp">View Item</a>
										</li>
									</ul>
								</li>
								<li><a><i class="glyphicon glyphicon-heart-empty"></i> Testimonial <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Testimonial.jsp">View Testimonial</a>
										</li>
										
									</ul>
								</li>
                                                                <li><a><i class="fa fa-question"></i> FAQ'S <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="ADD_FAQ.jsp">Add FAQ</a>
										</li>
										 <li><a href="View_FAQ.jsp">View FAQ</a>
										</li>
									</ul>
								</li>
                                                                
                                                                <li><a><i class="fa fa-location-arrow"></i> Contact Details <span class="fa fa-chevron-down"></span></a>
                                                                    
									<ul class="nav child_menu" style="display: none">
                                                                            <%
                                                                     
                                                                      PreparedStatement ps1=cn.prepareStatement("select * from contactdetails");
                                                                     
                                                                      ResultSet rs1=ps1.executeQuery();
                                                                      if(rs1.next())
                                                                      {
                                                                %>
                                                                            <li><a href="contactdetails.jsp?detailsId=<%=rs1.getString("detailsId")%>">Contact Details</a>
										</li>
                                                                                 <%
                                                                      }
                                                                %>
										 
									</ul>
                                                                   
								</li>
                                                                
                                                                <li><a><i class="fa fa-edit"></i> Pages <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="Addaboutus.jsp">Update About Us</a></li>
                                                                            <li><a href="PrivacyPolicy.jsp">Update Privacy Policy</a> </li>
								            <li><a href="Term_Condition.jsp">Update Terms & Conditions</a>
						                           </li>
                                                                           <li><a href="Add_team.jsp">Add Team</a>
						                           </li>
                                                                           <li><a href="View_team.jsp">View Team</a>
						                           </li>
                                                                           
                              					         </ul>
                                                                </li>
                                                                 <li><a><i class="fa fa-question"></i>Query<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="contact_Query.jsp">Contact Query</a>
										</li>
										 <li><a href="service_Query.jsp">Service Query</a>
										</li>
									</ul>
								</li>
                                                                <li><a><i class="fa fa-pin"></i> Pin <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="AddPin.jsp">Add Pin</a>
										</li>
										 <li><a href="viewPin.jsp">View Pin</a>
										</li>
									</ul>
								</li>
                                                                
                                                                 <li><a><i class="fa fa-cart-plus"></i>Orders<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="manage_order.jsp">Manage Orders</a>
									 <li><a href="order_History.jsp">Order History</a>
										
                                                                            </li>
										
									</ul>
								</li>
                                                                 <li><a><i class="fa fa-user"></i>Manage Accounts<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
                                                                            <li><a href="add_subadmin.jsp">Add Sub-Admin</a> </li>
                                                                             <li><a href="view_subadmin.jsp">View Sub-Admin</a> </li>
									   <li><a href="view_Vendor.jsp">View Vendor</a>
										
                                                                            </li>
										
									</ul>
								</li>
                                                                
                                                                    
						</div>
					</div>   
    </body>
</html>

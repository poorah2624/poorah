<%-- 
    Document   : header
    Created on : Jul 31, 2018, 9:42:19 AM
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
       <div class="navbar nav_title" style="border: 0;">
						<a href="dashboard.jsp" class="site_title"><i class="fa fa-paw"></i> <span>Admin Panel</span></a>
					</div>
					<div class="clearfix"></div>

					<!-- menu prile quick info -->
					<div class="profile">
                                             <%
                                                 Connection cn=new Connect().getConnection();
                                                 PreparedStatement ps=cn.prepareStatement("select * from admintable");
                                                 ResultSet rs=ps.executeQuery();
                                                 if(rs.next())
                                                  {
                                                    %>
						<div class="profile_pic">
							<img src="images/<%=rs.getString("image")%>" alt="..." class="img-circle profile_img">
						</div>
                                               
						<div class="profile_info">
							<span>Welcome,</span>
							<h2><%=rs.getString("name")%></h2>
						</div>
                                                <%
                                                    }
                                                %>
					</div>
					<!-- /menu prile quick info -->

					<br />

    </body>
</html>

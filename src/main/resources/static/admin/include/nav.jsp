<%-- 
    Document   : nav
    Created on : Aug 2, 2018, 12:34:20 PM
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
         <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <%
                        Connection cn=new Connect().getConnection();
                        PreparedStatement ps=cn.prepareStatement("select * from admintable");
                        ResultSet rs=ps.executeQuery();
                        if(rs.next())
                        {
                    %>
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/<%=rs.getString("image")%>" alt=""><%=rs.getString("name")%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                    <%
                      }
                  %>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="dashboard.jsp"> <%=rs.getString("designation")%></a></li>
                    <li>
                      <a href="edit_profile.jsp?adminId=<%=rs.getString("adminId")%>&name=<%=rs.getString("name")%>&email=<%=rs.getString("email")%>&website=<%=rs.getString("website")%>&designation=<%=rs.getString("designation")%>&mobile=<%=rs.getString("mobile")%>">
                        
                        <span>Settings</span>
                      </a>
                    </li>
                
                    <li><a href="Logout.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                  
                </li>

               
                    
                  </ul>
                
         
            </nav>
          </div>
        </div>
      
    </body>
</html>

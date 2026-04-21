<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="head.jsp"%>
</head>
<body>
	<%@include file="header.jsp"%>>
	

	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home.jsp"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>User Profile</li>
			</ul>
		</div>
	</div>
	<br>
	<br>
	<div class="user-profile">
		<div class="container">
			<h2 style="text-align: center;">User Profile</h2>
			<div class="col-md-12">
				<table class="table table-bordered">
					
					<tr>
						<th><h4>Name</h4></th>
						<td><h5>${sessionScope.LoggedInUser.userName}</h5></td>
					</tr>
				
					<tr>
						<th><h4>Email</h4></th>
						<td><h5>${sessionScope.LoggedInUser.userEmail}</h5></td>
					</tr>
					<tr>
						<th><h4>Mobile</h4></th>
						<td><h5>${sessionScope.LoggedInUser.userMobile}</h5></td>
					</tr>
					<tr>
						<th></th>
						<td><a
							href="/editUser"
							class="btn btn-success">Edit Profile</a> <a
							href="/changeUserPass"
							class="btn btn-primary">Change Password</a></td>
					</tr>
					
				</table>

			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
	
</body>
</html>

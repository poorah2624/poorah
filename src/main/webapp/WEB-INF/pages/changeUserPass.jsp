<%-- 
    Document   : editUser
    Created on : 6 May, 2019, 11:32:08 AM
    Author     : Diction Technology
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="head.jsp"%>
<body>
	<%@include file="header1.jsp"%>
	<%@include file="userNav.jsp"%>
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Change Password</li>
			</ul>
		</div>
	</div>
	<br>
	<br>
	<div class="user-profile">
		<div class="container">
			<h2 style="text-align: center;">Change Password</h2>
			<div class="col-md-12">
				<form action="/changeUserPassword"
					method="post">

					<table class="table table-bordered">
						<input type="hidden" name="userId" value="${user.id}" />
						<tr>
							<th>Current Password</th>
							<td><input type="password" name="userPassword"
								placeholder="Current Password" required="" class="form-control" /></td>
						</tr>
						<tr>
							<th>New Password</th>
							<td><input type="password" name="newPassword"
								placeholder="New Password" required="" class="form-control" /></td>
						</tr>
						<tr>
							<th></th>
							<td><input type="submit" class="btn btn-success"
								value="Submit" /></td>
						</tr>
					</table>
				</form>
				
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>

<%-- 
    Document   : editUser
    Created on : 6 May, 2019, 11:32:08 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="head.jsp" %>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="userNav.jsp" %>
        
        <div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="${pageContext.request.contextPath}/home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Edit Profile</li>
			</ul>
		</div>
        </div><br><br>
         <div class="user-profile">
            <div class="container">
                <h2 style="text-align: center;"> Edit Profile</h2>
                <div class="col-md-12">
                    <form action="${pageContext.request.contextPath}/updateProfile" method="post" enctype="multipart/form-data">
                    <table class="table table-bordered">
                        
                        <input type="hidden" name="userId" value="${user.id}"/>
                        <tr>
                            <th>Name</th>
                            <td><input type="text" name="userName" value="${user.userName}" class="form-control"/></td>
                        </tr>
                        
                        <tr>
                            <th>Email</th>
                            <td><input type="text" name="userEmail" value="${user.userEmail}" class="form-control" readonly="true"/></td>
                        </tr>
                        <tr>
                            <th>Mobile</th>
                            <td><input type="text" name="userMobile" value="${user.userMobile}" class="form-control"/></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td><input type="submit" class="btn btn-success" value="Submit"/></td>
                        </tr>
                        
                    </table>
                    </form> 
                </div>
            </div>
         </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>

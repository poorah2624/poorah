<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Profile - PooRah Fashion</title>
<%@include file="head.jsp"%>

<style>
    body {
        background-color: #f7f9fa;
    }
    .profile-section {
        padding: 50px 0;
    }
   
    .profile-card {
        background: #ffffff;
        border-radius: 12px;
        padding: 35px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.04);
        border: 1px solid #f0f0f0;
        max-width: 600px;
        margin: 0 auto;
    }
    .profile-card-title {
        font-size: 24px;
        font-weight: 700;
        color: #212121;
        margin-bottom: 30px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        text-align: center;
    }
    
    .profile-avatar-row {
        text-align: center;
        margin-bottom: 25px;
    }
    .profile-avatar-circle {
        width: 80px;
        height: 80px;
        background: #fff9f2;
        border: 2px solid #ff9800;
        color: #ff9800;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        font-weight: 700;
        box-shadow: 0 4px 10px rgba(255, 152, 0, 0.1);
    }
   
    .profile-info-block {
        border-top: 1px solid #f0f0f0;
        padding: 20px 0;
    }
    .info-item-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px dashed #f0f0f0;
    }
    .info-item-row:last-child {
        border-bottom: none;
    }
    .info-label {
        font-size: 14px;
        font-weight: 600;
        color: #777;
    }
    .info-value {
        font-size: 15px;
        font-weight: 600;
        color: #222;
        text-align: right;
    }
  
    .profile-actions-row {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        border-top: 1px solid #eee;
        padding-top: 25px;
    }
    .btn-profile-edit {
        flex: 1;
        background: #ff9800;
        color: #fff !important;
        font-weight: 600;
        height: 45px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: none;
        transition: background 0.2s;
        text-decoration: none !important;
    }
    .btn-profile-edit:hover {
        background: #e68a00;
    }
    .btn-profile-pass {
        flex: 1;
        background: #fff;
        color: #555 !important;
        font-weight: 600;
        height: 45px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none !important;
        transition: background 0.2s;
    }
    .btn-profile-pass:hover {
        background: #f8f9fa;
        border-color: #bbb;
    }

    @media (max-width: 480px) {
        .profile-actions-row {
            flex-direction: column;
            gap: 12px;
        }
        .profile-card {
            padding: 20px;
        }
    }
</style>
</head>
<body>
    <%@include file="header1.jsp"%>

	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>User Profile</li>
			</ul>
		</div>
	</div>

	<div class="profile-section">
		<div class="container">
            <div class="row" style="margin: 0;">
                <div class="col-xs-12">
                    
                    <div class="profile-card">
                        <h2 class="profile-card-title">My Account</h2>
                        
                        <div class="profile-avatar-row">
                            <div class="profile-avatar-circle">
                                <c:out value="${fn:toUpperCase(fn:substring(sessionScope.LoggedInUser.userName, 0, 1))}" default="👤"/>
                            </div>
                        </div>
                        
                        <div class="profile-info-block">
                            
                            <div class="info-item-row">
                                <span class="info-label">Full Name</span>
                                <span class="info-value">${sessionScope.LoggedInUser.userName}</span>
                            </div>
                            
                            <div class="info-item-row">
                                <span class="info-label">Email Address</span>
                                <span class="info-value">${sessionScope.LoggedInUser.userEmail}</span>
                            </div>
                            
                            <div class="info-item-row">
                                <span class="info-label">Mobile Number</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.LoggedInUser.userMobile}">
                                            ${sessionScope.LoggedInUser.userMobile}
                                        </c:when>
                                        <c:otherwise><span style="color:#aaa; font-weight:normal; font-style:italic;">Not Provided</span></c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                        </div>
                        
                        <div class="profile-actions-row">
                            <a href="/changeUserPass" class="btn-profile-pass">
                                <span class="glyphicon glyphicon-lock" style="margin-right: 5px;"></span> Change Password
                            </a>
                            <a href="/editUser" class="btn-profile-edit">
                                <span class="glyphicon glyphicon-edit" style="margin-right: 5px;"></span> Edit Profile
                            </a>
                        </div>
                        
                    </div></div>
            </div>
		</div>
	</div>

	<%@include file="footer.jsp"%>
</body>
</html>
<%-- 
    Document   : editUser
    Created on : 6 May, 2019, 11:32:08 AM
    Author     : Diction Technology
--%>

<%@ page isELIgnored="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Profile - PooRah Fashion</title>
<%@include file="head.jsp" %>

<style>
    body {
        background-color: #f7f9fa;
    }
    .form-section {
        padding: 50px 0;
    }
    /* Elegant Form Container Card */
    .form-card {
        background: #ffffff;
        border-radius: 12px;
        padding: 35px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        border: 1px solid #f0f0f0;
    }
    .form-card-title {
        font-size: 22px;
        font-weight: 700;
        color: #212121;
        margin-bottom: 25px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid #eee;
        padding-bottom: 15px;
        text-align: center;
    }
    
    /* Modern Inputs Styling */
    .form-group label {
        font-size: 13px;
        font-weight: 600;
        color: #555;
        margin-bottom: 8px;
    }
    .form-control {
        height: 45px;
        border-radius: 6px;
        border: 1px solid #ccc;
        box-shadow: none !important;
        font-size: 14px;
        padding: 10px 15px;
        transition: border-color 0.2s, background-color 0.2s;
    }
    .form-control:focus {
        border-color: #ff9800 !important;
        background-color: #fffdfa;
    }
    .form-control[readonly] {
        background-color: #f5f5f5;
        color: #888;
        cursor: not-allowed;
        border-color: #ddd;
    }
    
    /* Action Row Buttons */
    .form-actions-row {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        border-top: 1px solid #eee;
        padding-top: 20px;
    }
    .btn-submit-profile {
        flex: 2;
        background: #ff9800;
        color: #fff !important;
        font-weight: 600;
        height: 48px;
        border-radius: 6px;
        border: none;
        font-size: 15px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: background 0.2s;
    }
    .btn-submit-profile:hover {
        background: #e68a00;
    }
    .btn-cancel-profile {
        flex: 1;
        background: #fff;
        color: #555 !important;
        font-weight: 600;
        height: 48px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none !important;
        transition: background 0.2s;
    }
    .btn-cancel-profile:hover {
        background: #f8f9fa;
        border-color: #bbb;
    }
</style>
</head>
    <body>
        <%@include file="header1.jsp" %>
        <%@include file="userNav.jsp" %>
        
        <div class="breadcrumb_dress">
    		<div class="container">
    			<ul>
    				<li><a href="/home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
    				<li>Edit Profile</li>
    			</ul>
    		</div>
        </div>

        <div class="form-section">
            <div class="container">
                <div class="row" style="margin: 0;">
                    <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                        
                        <div class="form-card">
                            <h2 class="form-card-title">Edit Profile</h2>
                            
                            <form action="/updateProfile" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="userId" value="${user.id}"/>
                                
                                <div class="form-group">
                                    <label>Full Name</label>
                                    <input type="text" name="userName" value="${user.userName}" class="form-control" required/>
                                </div>
                                
                                <div class="form-group">
                                    <label>Email Address (Cannot be changed)</label>
                                    <input type="text" name="userEmail" value="${user.userEmail}" class="form-control" readonly="true"/>
                                </div>
                                
                                <div class="form-group">
                                    <label>Mobile Number</label>
                                    <input type="text" name="userMobile" value="${user.userMobile}" class="form-control" required/>
                                </div>
                                
                                <div class="form-actions-row">
                                    <a href="/userProfile" class="btn-cancel-profile">Cancel</a>
                                    <button type="submit" class="btn-submit-profile">Save Changes</button>
                                </div>
                                
                            </form> 
                        </div></div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Addresses - PooRah Fashion</title>
<%@include file="head.jsp"%>

<style>
    body {
        background-color: #f7f9fa;
    }
    .address-section {
        padding: 40px 0;
    }
    .page-title {
        font-size: 24px;
        font-weight: 700;
        color: #212121;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 10px;
    }
    
    /* Top Row Styling */
    .address-header-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        border-bottom: 1px solid #e0e0e0;
        padding-bottom: 15px;
    }
    .btn-add-new {
        background: #ff9800;
        color: #fff !important;
        font-weight: 600;
        padding: 10px 20px;
        border-radius: 6px;
        border: none;
        transition: background 0.2s;
        text-decoration: none !important;
    }
    .btn-add-new:hover {
        background: #e68a00;
    }

    /* Address Grid */
    .address-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
        gap: 25px;
    }

    /* Elegant Address Card */
    .address-card {
        background: #ffffff;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.04);
        border: 1px solid #f0f0f0;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        position: relative;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .address-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }

    /* Type Tag (Home / Office) */
    .address-type-tag {
        position: absolute;
        top: 20px;
        right: 20px;
        background: #f5f5f5;
        color: #666;
        font-size: 11px;
        font-weight: 700;
        padding: 4px 10px;
        border-radius: 20px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    /* Text Styles */
    .user-name {
        font-size: 16px;
        font-weight: 700;
        color: #222;
        margin: 0 0 12px 0;
        padding-right: 60px; /* Tag के लिए जगह */
    }
    .address-details {
        font-size: 14px;
        color: #555;
        line-height: 1.6;
        margin-bottom: 15px;
    }
    .phone-number {
        font-size: 14px;
        color: #333;
        margin-bottom: 20px;
    }
    .phone-number b {
        color: #777;
    }

    /* Action Buttons Row */
    .card-actions {
        border-top: 1px solid #f0f0f0;
        padding-top: 15px;
        display: flex;
        gap: 15px;
    }
    .btn-card {
        flex: 1;
        text-align: center;
        font-weight: 600;
        font-size: 13px;
        padding: 8px 12px;
        border-radius: 6px;
        text-decoration: none !important;
        transition: all 0.2s;
    }
    .btn-edit {
        background: #fff;
        color: #2874f0 !important;
        border: 1px solid #2874f0;
    }
    .btn-edit:hover {
        background: #f0f5ff;
    }
    .btn-delete {
        background: #fff;
        color: #ff4d4f !important;
        border: 1px solid #ff4d4f;
    }
    .btn-delete:hover {
        background: #fff1f0;
    }

    /* Empty State */
    .empty-address-box {
        text-align: center;
        padding: 60px 20px;
        background: #fff;
        border-radius: 12px;
        border: 1px dashed #ccc;
    }

    /* Mobile Responsive Adjustments */
    @media (max-width: 480px) {
        .address-header-row {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }
        .btn-add-new {
            width: 100%;
            text-align: center;
        }
        .address-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>

<body>

<%@include file="header1.jsp"%>

<div class="breadcrumb_dress">
    <div class="container">
        <ul>
            <li>
                <a href="/home">
                    <span class="glyphicon glyphicon-home"></span> Home
                </a> 
                <i>/</i>
            </li>
            <li>My Addresses</li>
        </ul>
    </div>
</div>

<div class="address-section">
    <div class="container">
        
        <div class="address-header-row">
            <h2 class="page-title">Saved Addresses</h2>
            <a href="/addAddress" class="btn-add-new">
               + Add New Address
            </a>
        </div>

        <div class="address-grid">
            <c:forEach var="addr" items="${addresses}">
                
                <div class="address-card">
                    <div>
                        <span class="address-type-tag">${addr.addressType}</span>
                        
                        <h4 class="user-name">${addr.fullName}</h4>
                        
                        <p class="address-details">
                            ${addr.houseNo}, ${addr.area},<br>
                            ${addr.city}, ${addr.state} - <b>${addr.pincode}</b>
                        </p>
                        
                        <p class="phone-number">
                            <b>Mobile:</b> ${addr.mobile}
                        </p>
                    </div>

                    <div class="card-actions">
                        <a href="/editAddress/${addr.addressId}" class="btn-card btn-edit">
                           Edit
                        </a>
                        <a href="/deleteAddress/${addr.addressId}" 
                           class="btn-card btn-delete"
                           onclick="return confirm('Are you sure you want to delete this address?')">
                           Delete
                        </a>
                    </div>
                </div>

            </c:forEach>
        </div>

        <c:if test="${empty addresses}">
            <div class="empty-address-box">
                <span class="glyphicon glyphicon-map-marker" style="font-size: 48px; color: #ccc; margin-bottom: 15px;"></span>
                <h4 style="color: #888; font-weight: 500;">No saved addresses found</h4>
                <p style="color: #aaa; font-size: 13px; margin-bottom: 20px;">Please add a shipping address to enjoy seamless checkouts.</p>
                <a href="/addAddress" class="btn btn-warning" style="font-weight:600;">Add Your First Address</a>
            </div>
        </c:if>

    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
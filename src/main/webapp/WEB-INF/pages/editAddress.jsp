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
<title>Edit Address - PooRah Fashion</title>
<%@include file="head.jsp"%>

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
    
    /* Segmented Radio Button Group (Address Type) */
    .address-type-group {
        display: flex;
        gap: 12px;
        margin-top: 5px;
    }
    .address-type-group label {
        flex: 1;
        text-align: center;
        background: #fff;
        border: 1px solid #ddd;
        padding: 12px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        font-size: 14px;
        color: #666;
        transition: all 0.2s;
        margin: 0;
    }
    .address-type-group input[type="radio"] {
        display: none; /* ओरिजिनल गोल रेडियो बटन छुपाने के लिए */
    }
    /* जब रेडियो बटन सिलेक्टेड हो */
    .address-type-group input[type="radio"]:checked + span {
        color: #ff9800;
    }
    .address-type-group label:has(input[type="radio"]:checked) {
        border-color: #ff9800;
        background: #fff9f2;
        color: #ff9800;
    }
    
    /* Custom Checkbox */
    .default-addr-checkbox {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #444;
        cursor: pointer;
        user-select: none;
        margin-top: 15px;
    }
    .default-addr-checkbox input {
        width: 16px;
        height: 16px;
        accent-color: #ff9800; /* मॉडर्न ब्राउज़र्स के लिए ऑरेंज टिक */
        cursor: pointer;
    }

    /* Action Row Buttons */
    .form-actions-row {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        border-top: 1px solid #eee;
        padding-top: 20px;
    }
    .btn-submit-addr {
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
    .btn-submit-addr:hover {
        background: #e68a00;
    }
    .btn-cancel-addr {
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
    .btn-cancel-addr:hover {
        background: #f8f9fa;
        border-color: #bbb;
    }
    
    /* 2-Column row for city/state/pincode */
    .form-row-custom {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }
</style>
</head>

<body>

<%@include file="header1.jsp"%>

<div class="form-section">
    <div class="container">
        <div class="row" style="margin: 0;"> 
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                
                <div class="form-card">
                    <h3 class="form-card-title">Edit Shipping Address</h3>

                    <form action="/updateAddress" method="post">
                    
                        <input type="hidden" name="addressId" value="${address.addressId}"/>

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" value="${address.fullName}" class="form-control" required placeholder="e.g. John Doe">
                        </div>

                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="text" name="mobile" value="${address.mobile}" class="form-control" required placeholder="10-digit mobile number">
                        </div>

                        <div class="form-group">
                            <label>Flat, House no., Building, Company</label>
                            <input type="text" name="houseNo" value="${address.houseNo}" class="form-control" required placeholder="House No / Apartment details">
                        </div>

                        <div class="form-group">
                            <label>Area, Street, Sector, Village</label>
                            <input type="text" name="area" value="${address.area}" class="form-control" required placeholder="Area or Locality">
                        </div>

                        <div class="form-group">
                            <label>Landmark</label>
                            <input type="text" name="landmark" value="${address.landmark}" class="form-control" required placeholder="e.g. near Apollo Hospital">
                        </div>

                        <div class="form-row-custom">
                            <div class="form-group">
                                <label>Town/City</label>
                                <input type="text" name="city" value="${address.city}" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>State</label>
                                <input type="text" name="state" value="${address.state}" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Pincode</label>
                            <input type="text" name="pincode" value="${address.pincode}" class="form-control" required placeholder="6-digit PIN code">
                        </div>

                        <div class="form-group">
                            <label>Address Type</label>
                            <div class="address-type-group">
                                <label>
                                    <input type="radio" name="addressType" value="Home" ${address.addressType == 'Home' ? 'checked' : ''} ${empty address.addressType ? 'checked' : ''}>
                                    <span>🏠 Home</span>
                                </label>

                                <label>
                                    <input type="radio" name="addressType" value="Office" ${address.addressType == 'Office' ? 'checked' : ''}>
                                    <span>🏢 Office</span>
                                </label>
                                
                                <label>
                                    <input type="radio" name="addressType" value="Friend" ${address.addressType == 'Friend' ? 'checked' : ''}>
                                    <span>🙋‍♂️ Friend</span>
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="default-addr-checkbox">
                                <input type="checkbox" name="isDefaultAddress" ${address.defaultAddress ? 'checked' : ''}>
                                Use this as my default shipping address
                            </label>
                        </div>

                        <div class="form-actions-row">
                            <a href="/address" class="btn-cancel-addr">Cancel</a>
                            <button type="submit" class="btn-submit-addr">Update Address</button>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
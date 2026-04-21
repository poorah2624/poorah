<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
</head>

<body>

<%@include file="header.jsp"%>

<div class="banner10">
    <div class="container">
        <h2>Add Address</h2>
    </div>
</div>

<div class="container" style="margin-top:30px; margin-bottom:30px;">

    <div class="col-md-6 col-md-offset-3">

        <form action="/updateAddress" method="post">
        
        <input type="hidden" name="addressId" value="${address.addressId}"/>

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" value ="${address.fullName }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Mobile</label>
                <input type="text" name="mobile" value ="${address.mobile }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>House No</label>
                <input type="text" name="houseNo" value ="${address.houseNo }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Area</label>
                <input type="text" name="area" value ="${address.area }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Landmark</label>
                <input type="text" name="landmark" value ="${address.landmark }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>City</label>
                <input type="text" name="city" value ="${address.city }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>State</label>
                <input type="text" name="state" value ="${address.state }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Pincode</label>
                <input type="text" name="pincode" value ="${address.pincode }" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Address Type</label><br>

                <label>
                    <input type="radio" name="addressType" value="Home" ${address.addressType == 'Home' ? 'checked' : ''} checked> Home
                </label>

                <label style="margin-left:20px;">
                    <input type="radio" name="addressType" value="Office" ${address.addressType == 'Office' ? 'checked' : ''}> Office
                </label>
                
                <label style="margin-left:20px;">
                    <input type="radio" name="addressType" value="Friend" ${address.addressType == 'Friend' ? 'checked' : ''}> Friend
                </label>
            </div>

            <div class="form-group">
                <label>
                    <input type="checkbox" name="isDefaultAddress" ${address.defaultAddress ? 'checked' : ''}>
                    Set as Default Address
                </label>
            </div>

            <button type="submit" class="btn btn-success">Update Address</button>
            <a href="/address" class="btn btn-default">Cancel</a>

        </form>

    </div>

</div>

<%@include file="footer.jsp"%>

</body>
</html>
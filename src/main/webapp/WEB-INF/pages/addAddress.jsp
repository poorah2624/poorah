<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Address - PooRah Fashion</title>
<%@include file="head.jsp"%>

<style>
    body { background-color: #f7f9fa; }
    .form-section { padding: 50px 0; }
    .form-card { background: #ffffff; border-radius: 12px; padding: 35px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; }
    .form-card-title { font-size: 22px; font-weight: 700; color: #212121; margin-bottom: 25px; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid #eee; padding-bottom: 15px; }
    .form-group label { font-size: 13px; font-weight: 600; color: #555; margin-bottom: 8px; }
    .form-control { height: 45px; border-radius: 6px; border: 1px solid #ccc; box-shadow: none !important; font-size: 14px; padding: 10px 15px; transition: border-color 0.2s, background-color 0.2s; color: #333 !important; }
    .form-control:focus { border-color: #ff9800 !important; background-color: #fffdfa; }
    .address-type-group { display: flex; gap: 12px; margin-top: 5px; }
    .address-type-group label { flex: 1; text-align: center; background: #fff; border: 1px solid #ddd; padding: 12px; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 14px; color: #666; transition: all 0.2s; margin: 0; }
    .address-type-group input[type="radio"] { display: none; }
    .address-type-group input[type="radio"]:checked + span { color: #ff9800; }
    .address-type-group label:has(input[type="radio"]:checked) { border-color: #ff9800; background: #fff9f2; color: #ff9800; }
    .default-addr-checkbox { display: flex; align-items: center; gap: 8px; font-size: 14px; color: #444; cursor: pointer; user-select: none; margin-top: 15px; }
    .default-addr-checkbox input { width: 16px; height: 16px; accent-color: #ff9800; cursor: pointer; }
    .form-actions-row { display: flex; gap: 15px; margin-top: 30px; border-top: 1px solid #eee; padding-top: 20px; }
    .btn-submit-addr { flex: 2; background: #ff9800; color: #fff !important; font-weight: 600; height: 48px; border-radius: 6px; border: none; font-size: 15px; text-transform: uppercase; letter-spacing: 0.5px; transition: background 0.2s; }
    .btn-submit-addr:hover { background: #e68a00; }
    .btn-cancel-addr { flex: 1; background: #fff; color: #555 !important; font-weight: 600; height: 48px; border-radius: 6px; border: 1px solid #ccc; font-size: 15px; display: flex; align-items: center; justify-content: center; text-decoration: none !important; transition: background 0.2s; }
    .btn-cancel-addr:hover { background: #f8f9fa; border-color: #bbb; }
    .form-row-custom { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
</style>
</head>

<body>

<%@include file="header1.jsp"%>

<div class="form-section">
    <div class="container">
        <div class="row" style="margin: 0;">
            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                
                <div class="form-card">
                    <h3 class="form-card-title">Add New Address</h3>

                    <form action="/saveAddress" method="post">

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" required placeholder="e.g. John Doe">
                        </div>

                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="text" name="mobile" class="form-control" required placeholder="10-digit mobile number">
                        </div>

                        <div class="form-group">
                            <label>Flat, House no., Building, Company</label>
                            <input type="text" name="houseNo" class="form-control" required placeholder="House No / Apartment details">
                        </div>

                        <div class="form-group">
                            <label>Area, Street, Sector, Village</label>
                            <input type="text" name="area" class="form-control" required placeholder="Area or Locality">
                        </div>

                        <div class="form-group">
                            <label>Landmark</label>
                            <input type="text" name="landmark" class="form-control" required placeholder="e.g. near Apollo Hospital">
                        </div>

                        <div class="form-row-custom">
                            <div class="form-group">
                                <label>State</label>
                                <select name="state" id="stateSelector" class="form-control" required onchange="populateCities(this.value)">
                                    <option value="">-- Choose State --</option>
                                    <option value="Jharkhand">Jharkhand</option>
                                    <option value="Bihar">Bihar</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Karnataka">Karnataka</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Town/City</label>
                                <select name="city" id="citySelector" class="form-control" required>
                                    <option value="">-- Choose City --</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Pincode</label>
                            <input type="text" name="pincode" class="form-control" required placeholder="6-digit PIN code" maxlength="6">
                        </div>

                        <div class="form-group">
                            <label>Address Type</label>
                            <div class="address-type-group">
                                <label>
                                    <input type="radio" name="addressType" value="Home" checked>
                                    <span>🏠 Home</span>
                                </label>
                                <label>
                                    <input type="radio" name="addressType" value="Office">
                                    <span>🏢 Office</span>
                                </label>
                                <label>
                                    <input type="radio" name="addressType" value="Friend">
                                    <span>🙋‍♂️ Friend</span>
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="default-addr-checkbox">
                                <input type="checkbox" name="isDefaultAddress" value="true">
                                Use this as my default shipping address
                            </label>
                        </div>

                        <div class="form-actions-row">
                            <a href="/address" class="btn-cancel-addr">Cancel</a>
                            <button type="submit" class="btn-submit-addr">Save Address</button>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>

<script type="text/javascript">
    // Map object mapping framework data variables safely
    const stateCityMap = {
        "Jharkhand": ["Ranchi", "Jamshedpur", "Dhanbad", "Bokaro", "Hazaribagh", "Deoghar"],
        "Bihar": ["Patna", "Gaya", "Muzaffarpur", "Bhagalpur", "Darbhanga", "Purnia"],
        "Delhi": ["New Delhi", "North Delhi", "South Delhi", "East Delhi", "West Delhi"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Thane", "Nashik", "Aurangabad"],
        "Karnataka": ["Bengaluru", "Mysuru", "Hubballi", "Mangaluru", "Belagavi"]
    };

    function populateCities(selectedState) {
        const cityDropdown = document.getElementById("citySelector");
        
        // Clear previous items matrix loop
        cityDropdown.innerHTML = "<option value=''>-- Choose City --</option>";

        if (selectedState && stateCityMap[selectedState]) {
            stateCityMap[selectedState].forEach(function(city) {
                let option = document.createElement("option");
                option.value = city;
                option.text = city;
                cityDropdown.appendChild(option);
            });
        }
    }
</script>

</body>
</html>
<%-- 
    Document   : customDesignUpload
    Created on : 6 May, 2019
    Author     : PooRah Fashion Studio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Design Your Own T-Shirt - PooRah Fashion</title>
<%@include file="head.jsp"%>

<style>
/* ... aapke existing standard styles ... */
body { background-color: #f7f9fa; }
.studio-section { padding: 40px 0; }
.delivery-bar { /* bar styles */ }
.studio-container { display: grid; grid-template-columns: 450px 1fr; gap: 40px; align-items: start; }
.preview-canvas-card { /* card styles */ position: sticky; top: 20px; text-align: center; }
.gender-switch-group { /* gender switch styles */ }
.gender-switch-group label { /* label styles */ }
.gender-switch-group input[type="radio"] { display: none; }
.gender-switch-group label:has(input[type="radio"]:checked) { /* checked styles */ }
.tshirt-canvas-wrapper { position: relative; width: 100%; max-width: 360px; margin: 0 auto; background: #fdfdfd; border-radius: 8px; padding: 10px; }
.tshirt-base-img { width: 100%; height: auto; display: block; }
.design-overlay-preview { /* design overlay styles */ }
.studio-form-card { /* form card styles */ }
.studio-form-card h3 { /* h3 styles */ }
.studio-group { margin-bottom: 25px; }
.form-control { /* form control styles */ }
.size-chips-group { /* size chips styles */ }
.size-chips-group input[type="radio"] { display: none; }
.type-chips-group { /* type chips styles */ }
.type-chips-group input[type="radio"] { display: none; }
.studio-price-block { /* price block styles */ }
.final-price { font-size: 24px; }
.old-price { font-size: 15px; }
.discount { font-size: 14px; }
.btn-submit-studio { /* submit button styles */ }
.pin-checker-row { /* pincode row styles */ }
.btn-pin-check { /* pincode check button styles */ }
.custom-chart-modal { /* modal styles */ }
.modal-content-card { /* modal content card styles */ }
.close-modal-btn { /* modal close button styles */ }
.modal-content-card table { /* modal table styles */ }

@media ( max-width : 991px) { .studio-container { grid-template-columns: 1fr; } .preview-canvas-card { position: static; } }
</style>
</head>

<body>
	<%@include file="header1.jsp"%>

	<c:if test="${not empty defaultAddress}">
		<div class="container" style="margin-top: 20px; margin-bottom: -10px;">
			<div class="delivery-bar">
				<span><i class="glyphicon glyphicon-map-marker"
					style="color: #ff9800; margin-right: 5px;"></i> Deliver to: <b>${defaultAddress.fullName},
						${defaultAddress.pincode}</b></span> <a href="/address">Change Address</a>
			</div>
		</div>
	</c:if>

	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="home.jsp"><span
						class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Upload Custom Design</li>
			</ul>
		</div>
	</div>

	<div class="studio-section">
		<div class="container">
			<div class="studio-container">

				<div class="preview-canvas-card">
					<div class="gender-switch-group">
						<label> <input type="radio" name="gender" value="male"
							checked> <span>♂ Male T-Shirt</span>
						</label> <label> <input type="radio" name="gender" value="female">
							<span>♀ Female T-Shirt</span>
						</label>
					</div>

					<div class="tshirt-canvas-wrapper">
						<img
							src="https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880777/male_wqzxj0.png"
							class="tshirt-base-img" id="tshirtImage" alt="Tshirt Vector Base">
						<img id="designPreview" class="design-overlay-preview" src=""
							alt="" style="display: none;" />
					</div>
				</div>

				<div class="studio-form-card">
					<form action="/addCustomToCart" method="post"
						enctype="multipart/form-data">

						<h3>Create Your Custom T-Shirt 🎨</h3>

						<div class="studio-group">
							<label>Upload Your Design (PNG Format Preferred)</label> <input
								type="file" id="designInput" name="image" accept="image/*"
								class="form-control" required>
						</div>

						<div class="studio-group">
							<label> <span>Select Size</span> <a
								href="javascript:void(0);" class="size-chart-link"
								onclick="openSizeChart()"> <i
									class="glyphicon glyphicon-th-list"></i> Size Chart
							</a>
							</label>
							<div class="size-chips-group">
								<label><input type="radio" name="size" value="S"
									required><span>S</span></label> <label><input
									type="radio" name="size" value="M"><span>M</span></label> <label><input
									type="radio" name="size" value="L"><span>L</span></label> <label><input
									type="radio" name="size" value="XL"><span>XL</span></label> <label><input
									type="radio" name="size" value="XXL"><span>XXL</span></label>
							</div>
						</div>

                        <%-- Update: Added option tag for black t-shirt color selection --%>
						<select class="form-control" name="color" id="tshirtColorSelect"
							onchange="changeTshirtColorGender()" required>
							<option value="#ffffff">White</option>
							<option value="#000000">Black</option>
						</select>

						<div class="studio-group">
							<label>T-Shirt Fit Type</label>
							<div class="type-chips-group">
								<label><input type="radio" name="tshirtType"
									value="Regular" checked><span>Regular Fit</span></label> <label><input
									type="radio" name="tshirtType" value="Oversize"><span>Oversize
										Fit</span></label>
							</div>
						</div>

						<div class="studio-group">
							<label>Custom Instructions / Special Note (Optional)</label>
							<textarea name="customNote" class="form-control"
								placeholder="Tell us if you want the design on the back, custom size placement or print details..."></textarea>
						</div>

						<div class="studio-price-block">
							<div class="price-wrapper">
								<div class="final-price">₹ 599</div>
								<span class="old-price">₹ 1499</span> <span class="discount">60%
									OFF</span>
							</div>

							<button type="submit" class="btn-submit-studio">Add
								Custom T-Shirt to Cart</button>

							<div
								style="margin-top: 25px; border-top: 1px solid #eaeaea; padding-top: 20px;">
								<label
									style="font-size: 12px; font-weight: 700; color: #666; display: block; margin-bottom: 8px;">Check
									Delivery Availability</label>
								<div class="pin-checker-row">
									<input type="text" id="pincode"
										placeholder="Enter 6-digit Pincode" class="form-control"
										style="max-width: 220px;" maxlength="6" />
									<button type="button" onclick="checkDelivery()"
										class="btn-pin-check">Check</button>
								</div>
								<i id="deliveryResult"
									style="display: block; margin-top: 10px; font-size: 13px; font-weight: 600; color: green;"></i>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>

	<div id="sizeChartModal" class="custom-chart-modal">
		<div class="modal-content-card">
			<span class="close-modal-btn" onclick="closeSizeChart()">&times;</span>
			<h3 style="margin: 0 0 15px 0; font-weight: 700;">Studio Size Guide</h3>
			<p style="font-size: 12px; color: #888; margin-bottom: 15px;">Standard measurement metrics in inches for reference body mapping</p>
			<table>
				<thead><tr><th>Size</th><th>Chest (inch)</th><th>Length (inch)</th></tr></thead>
				<tbody>
					<tr><td>S</td><td>36</td><td>26</td></tr>
					<tr><td>M</td><td>38</td><td>27</td></tr>
					<tr><td>L</td><td>40</td><td>28</td></tr>
					<tr><td>XL</td><td>42</td><td>29</td></tr>
					<tr><td>XXL</td><td>44</td><td>30</td></tr>
				</tbody>
			</table>
		</div>
	</div>

	<%@include file="footer.jsp"%>

	<script type="text/javascript">
        // Pincode Availability Logic Handler
        function checkDelivery(){
            let pincode = document.getElementById("pincode").value;
            if(pincode.length !== 6 || isNaN(pincode)){
                alert("Please enter a valid 6-digit pincode number.");
                return;
            }
            fetch('/checkDelivery?pincode=' + pincode)
            .then(res => res.text())
            .then(data => {
                document.getElementById("deliveryResult").innerText = data;
            })
            .catch(err => console.log(err));
        }

        // Live Graphic Image File Upload Reader Sync Engine
        document.getElementById("designInput").addEventListener("change", function(event) {
            const file = event.target.files[0];
            const preview = document.getElementById("designPreview");
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = "block"; // Image uploaded, show layer
                };
                reader.readAsDataURL(file);
            }
        });

        // UPDATED: Standard Standard base switching to only trigger function call
        document.querySelectorAll('input[name="gender"]').forEach(radio => {
            radio.addEventListener("change", function () {
                // Call standard Standard change function which now handles both gender and color
                changeTshirtColorGender();
            });
        });

        // UPDATED: Combined Gender & Color image dynamic switcher
        function changeTshirtColorGender() {
            const selectedColor = document.getElementById("tshirtColorSelect").value;
            // Get value of checked gender radio button
            const currentGender = document.querySelector('input[name="gender"]:checked').value;
            const tshirt = document.getElementById("tshirtImage");
            const preview = document.getElementById("designPreview");

            if (currentGender === "male") {
                if (selectedColor === "#000000") { // Black
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1780162094/Gemini_Generated_Image_qlvfgfqlvfgfqlvf_t5wytp.png"; 
                    preview.style.top = "44%";
                    preview.style.width = "32%";
                } else { // White
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880777/male_wqzxj0.png";
                    preview.style.top = "44%";
                    preview.style.width = "32%";
                }
            } else { // Female
                if (selectedColor === "#000000") { // Black
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1780162030/Gemini_Generated_Image_8bbcih8bbcih8bbc_d9orx3.png"; 
                    preview.style.top = "42%";
                    preview.style.width = "30%";
                } else { // White
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880776/female_v4yclu.png";
                    preview.style.top = "42%";
                    preview.style.width = "30%";
                }
            }
        }

        // Size Modal View Layer Controllers
        function openSizeChart() { document.getElementById("sizeChartModal").style.display = "block"; }
        function closeSizeChart() { document.getElementById("sizeChartModal").style.display = "none"; }
        
        // Window Overlay Click dismiss trigger 
        window.onclick = function(event) {
            let modal = document.getElementById("sizeChartModal");
            if (event.target == modal) { modal.style.display = "none"; }
        }
	</script>
</body>
</html>
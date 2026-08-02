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
body {
	background-color: #f7f9fa;
}

.studio-section {
	padding: 40px 0;
}

/* Deliver To Bar */
.delivery-bar {
	background: #ffffff;
	padding: 14px 20px;
	margin-bottom: 25px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
	border: 1px solid #eef0f2;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.delivery-bar a {
	color: #ff9800;
	font-weight: 600;
	text-decoration: none !important;
}

/* Studio Workspaces Grid */
.studio-container {
	display: grid;
	grid-template-columns: 450px 1fr;
	gap: 40px;
	align-items: start;
}

/* Left Side Canvas: T-Shirt Live Mockup Container */
.preview-canvas-card {
	background: #ffffff;
	border-radius: 12px;
	padding: 25px;
	border: 1px solid #f0f0f0;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
	position: sticky;
	top: 20px;
	text-align: center;
}

/* Gender Switch (Top Canvas Tabs) */
.gender-switch-group {
	display: flex;
	background: #f1f3f5;
	padding: 4px;
	border-radius: 8px;
	margin-bottom: 25px;
}

.gender-switch-group label {
	flex: 1;
	text-align: center;
	padding: 10px;
	margin: 0;
	cursor: pointer;
	font-weight: 600;
	font-size: 14px;
	color: #666;
	border-radius: 6px;
	transition: all 0.2s;
}

.gender-switch-group input[type="radio"] {
	display: none;
}

.gender-switch-group label:has(input[type="radio"]:checked) {
	background: #ffffff;
	color: #ff9800;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

/* Absolute Accurate Canvas Mapping */
.tshirt-canvas-wrapper {
	position: relative;
	width: 100%;
	max-width: 360px;
	margin: 0 auto;
	background: #fdfdfd;
	border-radius: 8px;
	padding: 10px;
}

.tshirt-base-img {
	width: 100%;
	height: auto;
	display: block;
}

/* Design Overlap Matrix - Chest Area Center */
.design-overlay-preview {
	position: absolute;
	top: 44%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 32%;
	max-height: 35%;
	object-fit: contain;
	pointer-events: none; /* No drag issue */
	transition: all 0.2s ease;
}

/* Right Side Panel: Custom Configuration Card Form */
.studio-form-card {
	background: #ffffff;
	border-radius: 12px;
	padding: 35px;
	border: 1px solid #f0f0f0;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
}

.studio-form-card h3 {
	font-size: 22px;
	font-weight: 700;
	color: #212121;
	margin: 0 0 25px 0;
	border-bottom: 1px solid #eee;
	padding-bottom: 15px;
}

/* Labels & Standard Group Elements */
.studio-group {
	margin-bottom: 25px;
}

.studio-group>label {
	font-size: 14px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* Modern Custom Inputs */
.form-control {
	height: 45px;
	border-radius: 6px;
	border: 1px solid #ccc;
	box-shadow: none !important;
	font-size: 14px;
}

.form-control:focus {
	border-color: #ff9800 !important;
	background-color: #fffdfa;
}

textarea.form-control {
	height: 90px !important;
	resize: none;
	padding: 12px;
}

/* Modern Size Selector Chips (Includes XXL) */
.size-chips-group {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

.size-chips-group label {
	width: 50px;
	height: 45px;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 6px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 600;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	margin: 0;
	transition: all 0.2s;
}

.size-chips-group input[type="radio"] {
	display: none;
}

.size-chips-group label:has(input[type="radio"]:checked) {
	border-color: #ff9800;
	background: #fff9f2;
	color: #ff9800;
}

.size-chart-link {
	font-size: 12px;
	color: #2874f0 !important;
	font-weight: 600;
	text-decoration: none !important;
}

.size-chart-link:hover {
	text-decoration: underline !important;
}

/* Type Option Chips (Regular / Oversize) */
.type-chips-group {
	display: flex;
	gap: 15px;
}

.type-chips-group label {
	flex: 1;
	padding: 12px;
	text-align: center;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 6px;
	cursor: pointer;
	font-weight: 600;
	font-size: 14px;
	color: #666;
	margin: 0;
	transition: all 0.2s;
}

.type-chips-group input[type="radio"] {
	display: none;
}

.type-chips-group label:has(input[type="radio"]:checked) {
	border-color: #ff9800;
	background: #fff9f2;
	color: #ff9800;
}

/* Premium Dynamic Sticky Pricing block */
.studio-price-block {
	background: #fafafa;
	border-radius: 8px;
	padding: 20px;
	border: 1px dashed #ddd;
	margin-top: 30px;
}

.price-wrapper {
	display: flex;
	align-items: baseline;
	gap: 12px;
	margin-bottom: 15px;
}

.final-price {
	font-size: 24px;
	font-weight: 800;
	color: #222;
}

.old-price {
	font-size: 15px;
	color: #999;
	text-decoration: line-through;
}

.discount {
	font-size: 14px;
	color: #ff5722;
	font-weight: 600;
}

/* Buttons Actions Group */
.btn-submit-studio {
	background: #ff9800;
	color: #fff !important;
	font-weight: 700;
	height: 50px;
	font-size: 15px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	border-radius: 6px;
	border: none;
	width: 100%;
	transition: background 0.2s;
}

.btn-submit-studio:hover {
	background: #e68a00;
}

/* Pincode Container Checker Row */
.pin-checker-row {
	display: flex;
	gap: 10px;
	margin-top: 15px;
}

.btn-pin-check {
	background: #fff;
	color: #ff9800 !important;
	border: 1px solid #ff9800;
	font-weight: 600;
	padding: 0 20px;
	border-radius: 6px;
	height: 45px;
	transition: background 0.2s;
}

.btn-pin-check:hover {
	background: #fff9f2;
}

/* Size Chart Modal Component PopUp */
.custom-chart-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	backdrop-filter: blur(4px);
	z-index: 10000;
}

.modal-content-card {
	background: #fff;
	width: 100%;
	max-width: 480px;
	margin: 10% auto;
	padding: 30px;
	border-radius: 12px;
	position: relative;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.close-modal-btn {
	position: absolute;
	top: 15px;
	right: 20px;
	font-size: 24px;
	cursor: pointer;
	color: #999;
}

.close-modal-btn:hover {
	color: #333;
}

.modal-content-card table {
	width: 100%;
	margin-top: 15px;
	border-collapse: collapse;
}

.modal-content-card th {
	background: #f8f9fa;
	font-weight: 700;
	color: #333;
}

.modal-content-card th, .modal-content-card td {
	padding: 12px;
	text-align: center;
	border: 1px solid #eaeaea;
	font-size: 14px;
}

/* Screen Breakpoints Matrix */
@media ( max-width : 991px) {
	.studio-container {
		grid-template-columns: 1fr;
	}
	.preview-canvas-card {
		position: static;
	}
}
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
						<input type="hidden" name="gender" id="hiddenGender" value="male">

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

						<!-- IS LINE KO UPDATE KAREIN -->
						<div class="studio-group">
							<label> <span>Color</span></label>
						<select class="form-control" name="color" id="tshirtColorSelect"
							onchange="changeTshirtColorGender()" required>
							<option value="#ffffff">White</option>
							<option value="#000000">Black</option>
						</select>
						</div>
						<br>

						<div class="studio-group">
							<label>T-Shirt Fit Type</label>
							<div class="type-chips-group">
								<!--  <label><input type="radio" name="tshirtType"
									value="Regular" checked><span>Regular Fit</span></label> -->
								<label><input
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
								<!--  <span class="old-price">₹ 399</span> <span class="discount">20%
									OFF</span> -->
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
			<h3 style="margin: 0 0 15px 0; font-weight: 700;">Studio Size
				Guide</h3>
			<p style="font-size: 12px; color: #888; margin-bottom: 15px;">Standard
				measurement metrics in inches for reference body mapping</p>
			<table>
				<thead>
					<tr>
						<th>Size</th>
						<th>Chest (inch)</th>
						<th>Length (inch)</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>S</td>
						<td>40</td>
						<td>27</td>
					</tr>
					<tr>
						<td>M</td>
						<td>42</td>
						<td>28</td>
					</tr>
					<tr>
						<td>L</td>
						<td>44</td>
						<td>29</td>
					</tr>
					<tr>
						<td>XL</td>
						<td>46</td>
						<td>30</td>
					</tr>
					<tr>
						<td>XXL</td>
						<td>48</td>
						<td>31</td>
					</tr>
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

    
        document.querySelectorAll('input[name="gender"]').forEach(radio => {
            radio.addEventListener("change", function () {
                changeTshirtColorGender();
            });
        });

        
        function changeTshirtColorGender() {
            const selectedColor = document.getElementById("tshirtColorSelect").value;
            const currentGender = document.querySelector('input[name="gender"]:checked').value;
            
            
            document.getElementById("hiddenGender").value = currentGender;

            const tshirt = document.getElementById("tshirtImage");
            const preview = document.getElementById("designPreview");
           

            if (currentGender === "male") {
                if (selectedColor === "#000000") { // Black selected
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1780162094/Gemini_Generated_Image_qlvfgfqlvfgfqlvf_t5wytp.png"; 
                    preview.style.top = "44%";
                    preview.style.width = "32%";
                } else { // White selected
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1776880777/male_wqzxj0.png";
                    preview.style.top = "44%";
                    preview.style.width = "32%";
                }
            } else { // Female
                if (selectedColor === "#000000") { // Black selected
                    tshirt.src = "https://res.cloudinary.com/dqufjiuzx/image/upload/v1780162030/Gemini_Generated_Image_8bbcih8bbcih8bbc_d9orx3.png"; 
                    preview.style.top = "42%";
                    preview.style.width = "30%";
                } else { // White selected
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
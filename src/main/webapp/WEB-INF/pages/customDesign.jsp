<%-- 
    Document   : userProfile
    Created on : 6 May, 2019, 11:00:10 AM
    Author     : Diction Technology
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>


<%@include file="head.jsp"%>

</head>
<body>
	<%@include file="header.jsp"%>
	<!--  <div class="banner10" id="home1">
		<div class="container">
			<h2>User Profile</h2>
		</div>
	</div>-->
	<c:if test="${not empty defaultAddress}">

		<div
			style="background: #f5f5f5; padding: 10px; margin-bottom: 15px; border-radius: 5px;">

			<b>Deliver to:</b> ${defaultAddress.fullName},
			${defaultAddress.pincode} <a
				href="${pageContext.request.contextPath}/address" style="float:;">Change</a>
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
	<br>
	<br>
	<div class="single">
		<div class="container">
			<div class="col-md-4 single-left">
				<div class="flexslider">
					<div class="gender-select">
						<label><input type="radio" name="gender" value="male"
							checked> Male</label> <label><input type="radio"
							name="gender" value="female"> Female</label>
					</div>
					<ul class="slides">
						<li
							data-thumb="${pageContext.request.contextPath}/uploads/male.png">
							<div class="thumb-image">
								<div class="tshirt-container">
									<img src="${pageContext.request.contextPath}/uploads/male.png"
										class="img-responsive tshirt-base" id="tshirtImage"> <img
										id="designPreview" class="design-overlay" />
								</div>
							</div>
						</li>


					</ul>
				</div>

			</div>
			<div class="col-md-8 single-right">
				<form action="${pageContext.request.contextPath}/addCustomToCart"
					method="post" enctype="multipart/form-data">
					<div class="custom-form-box">

						<h3>Create Your Custom T-Shirt 🎨</h3>

						<!-- Upload -->
						<div class="form-group">
							<label>Upload Your Design</label> <input type="file"
								id="designInput" name="image" accept="image/png"
								class="form-control">
						</div>

						<!-- Size -->
						<div class="form-group">
							<label>Select Size</label> <a
								href="javascript:void(0);" class="size-chart-link"
								onclick="openSizeChart()"> Size Chart </a>
								<br> 
								<label><input
								type="radio" name="size" value="S"> S</label> <label><input
								type="radio" name="size" value="M"> M</label> <label><input
								type="radio" name="size" value="L"> L</label> <label><input
								type="radio" name="size" value="XL"> XL</label> 
								
						</div>

						<!-- <div class="form-group">
							<label>Gender</label><br> <label><input type="radio"
								name="gender" value="Male"> Male</label> <label><input
								type="radio" name="gender" value="Female"> Female</label>

						</div> -->

						<!-- Color -->
						<div class="form-group">
							<label>Select Color</label><br> <select class="form-control"
								name="color">
								<option>Black</option>
								<option>White</option>
								<option>Red</option>
								<option>Blue</option>
							</select>
						</div>

						<!-- Type -->
						<div class="form-group">
							<label>T-shirt Type</label><br> <label><input
								type="radio" name="tshirtType" value="Regular"> Regular</label>
							<label><input type="radio" name="tshirtType"
								value="Oversize"> Oversize</label>
						</div>

						<div class="form-group">
							<label>Custom Note (Optional)</label>
							<textarea name="customNote" class="form-control"
								placeholder="Write your design instructions..."></textarea>
						</div>

						<!-- Button -->
						<div class="simpleCart_shelfItem">
							<div class="price-section">

								<div class="final-price">₹ 599/-</div>

								<div class="price-meta">
									<span class="old-price"> ₹ 1499 /-</span> <span
										class="discount"> 10% OFF </span>
								</div>

							</div>
							<button type="submit" class="btn btn-primary"
								style="margin-top: 15px;">Add Custom T-Shirt to Cart</button>

							<div style="margin-top: 15px;">

								<input type="text" id="pincode" placeholder="Enter Pincode"
									class="form-control"
									style="width: 200px; display: inline-block;" />

								<button onclick="checkDelivery()" class="btn btn-primary">
									Check</button>
								<br> <i id="deliveryResult"
									style="margin-top: 10px; color: green;"></i>

							</div>

						</div>

					</div>
				</form>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- Size Chart Modal -->
	<div id="sizeChartModal" class="modal">

		<div class="modal-content">
			<span class="close" onclick="closeSizeChart()">&times;</span>

			<h3>Size Chart</h3>

			<table>
				<tr>
					<th>Size</th>
					<th>Chest (inch)</th>
					<th>Length (inch)</th>
				</tr>
				<tr>
					<td>S</td>
					<td>36</td>
					<td>26</td>
				</tr>
				<tr>
					<td>M</td>
					<td>38</td>
					<td>27</td>
				</tr>
				<tr>
					<td>L</td>
					<td>40</td>
					<td>28</td>
				</tr>
				<tr>
					<td>XL</td>
					<td>42</td>
					<td>29</td>
				</tr>
			</table>

		</div>

	</div>


	<%@include file="footer.jsp"%>

	<!-- flixslider -->
	<script defer
		src="${pageContext.request.contextPath}/js/jquery.flexslider.js"></script>

	<!-- for bootstrap working -->

	<script
		src="${pageContext.request.contextPath}/js/jquery.magnific-popup.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.flexisel.js"></script>
	<script src="${pageContext.request.contextPath}/js/simpleCart.min.js"></script>
	<!-- //js -->
	<script
		src="${pageContext.request.contextPath}/js/easyResponsiveTabs.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#horizontalTab1').easyResponsiveTabs({
				type : 'default', //Types: default, vertical, accordion           
				width : 'auto', //auto or any width like 600px
				fit : true
			// 100% fit in a container
			});
		});
	</script>


	<!-- flixslider --

<!--quantity-->
	<script>
		$('.value-plus1')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value1'), newVal = parseInt(
									divUpd.text(), 10) + 1;
							divUpd.text(newVal);
						});

		$('.value-minus1')
				.on(
						'click',
						function() {
							var divUpd = $(this).parent().find('.value1'), newVal = parseInt(
									divUpd.text(), 10) - 1;
							if (newVal >= 1)
								divUpd.text(newVal);
						});
	</script>
	<!--quantity-->
	<script>

function addToCart(itemId, btn){

	let size = document.querySelector('input[name="size_' + itemId + '"]:checked')?.value;
    let age = document.querySelector('input[name="age_' + itemId + '"]:checked')?.value;
    
    console.log("SIZE:", size);
    console.log("AGE:", age);
    
    let errorId = "cartError_" + itemId;
    let errorDiv = document.getElementById(errorId);

    if(!errorDiv){
        errorDiv = document.createElement("div");
        errorDiv.id = errorId;
        errorDiv.style.color = "red";
        errorDiv.style.marginTop = "8px";
        btn.parentElement.appendChild(errorDiv);
    }

    errorDiv.innerHTML = "";

    //  CATEGORY CHECK (important)
    let category = "${item.category.categoryName}";

    // Kids product
    if(category.toLowerCase() === "kids"){
        if(!age){
            errorDiv.innerHTML = "Please select age";
            return; // STOP API CALL
        }
    } else {
        if(!size){
            errorDiv.innerHTML = "Please select size";
            return; // STOP API CALL
        }
    }
    
    let url = '${pageContext.request.contextPath}/addToCart?itemId=' + itemId;
    
    if(size){
        url += '&size=' + size;
    }
    if(age){
        url += '&age=' + age;
    }

    fetch(url)
    .then(response => {
        if(response.ok){

            // button change
            btn.innerText = "Go to Cart";
            btn.classList.remove("btn-primary");
            btn.classList.add("btn-success");

            // click change
            btn.onclick = goToCart;
        }
    })
    .catch(error => console.log(error));
}

function goToCart(){
    window.location.href = '${pageContext.request.contextPath}/cart';
}

</script>

	<script>
function buyNowOrder(itemId, btn){

	let size = document.querySelector('input[name="size_' + itemId + '"]:checked')?.value;
    let age = document.querySelector('input[name="age_' + itemId + '"]:checked')?.value;
    
    console.log("SIZE:", size);
    console.log("AGE:", age);
    
    let errorId = "cartError_" + itemId;
    let errorDiv = document.getElementById(errorId);

    if(!errorDiv){
        errorDiv = document.createElement("div");
        errorDiv.id = errorId;
        errorDiv.style.color = "red";
        errorDiv.style.marginTop = "8px";
        btn.parentElement.appendChild(errorDiv);
    }

    errorDiv.innerHTML = "";

    //  CATEGORY CHECK (important)
    let category = "${item.category.categoryName}";

    // Kids product
    if(category.toLowerCase() === "kids"){
        if(!age){
            errorDiv.innerHTML = "Please select age";
            return; // STOP API CALL
        }
    } else {
        if(!size){
            errorDiv.innerHTML = "Please select size";
            return; // STOP API CALL
        }
    }
    
    window.location.href = '${pageContext.request.contextPath}/buyNow?itemId=' + itemId;

    return false;
}
</script>

	<script>
function checkDelivery(){

    let pincode = document.getElementById("pincode").value;

    if(pincode.length !== 6){
        alert("Enter valid pincode");
        return;
    }

    fetch('${pageContext.request.contextPath}/checkDelivery?pincode=' + pincode)
    .then(res => res.text())
    .then(data => {
        document.getElementById("deliveryResult").innerText = data;
    })
    .catch(err => console.log(err));
}
</script>

	<script>
document.getElementById("designInput").addEventListener("change", function(event) {
    const file = event.target.files[0];

    if (file) {
        const reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById("designPreview").src = e.target.result;
        };

        reader.readAsDataURL(file);
    }
});
</script>

	<script>
document.querySelectorAll('input[name="gender"]').forEach(radio => {
    radio.addEventListener("change", function () {

        const tshirt = document.getElementById("tshirtImage");

        if (this.value === "male") {
            tshirt.src = "<%=request.getContextPath()%>/uploads/male.png";
        } else {
            tshirt.src = "<%=request.getContextPath()%>/uploads/female.png";
        }

    });
});

if (this.value === "male") {
    document.getElementById("designPreview").style.top = "44%";
    document.getElementById("designPreview").style.width = "32%";
} else {
    document.getElementById("designPreview").style.top = "42%";
    document.getElementById("designPreview").style.width = "30%";
}
</script>

	<script>
function openSizeChart() {
    document.getElementById("sizeChartModal").style.display = "block";
}

function closeSizeChart() {
    document.getElementById("sizeChartModal").style.display = "none";
}
</script>

</body>
</html>

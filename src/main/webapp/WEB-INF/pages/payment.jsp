<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
<style>
/* Custom CSS for modern UI and Highlighting features */
.payment-wrapper {
	max-width: 600px;
	margin: 40px auto;
	background: #ffffff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
}

.total-amount-box {
	background: #fdf2f4;
	border-left: 5px solid #ff9b05;
	padding: 15px;
	border-radius: 4px;
	margin-bottom: 25px;
}

.total-amount-box h4 {
	margin: 0;
	color: #333;
	font-weight: 600;
}

.payment-option-card {
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	padding: 18px;
	margin-bottom: 15px;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
}

.payment-option-card:hover {
	border-color: #ff9b05;
	background-color: #fffafb;
}

.payment-option-card input[type="radio"] {
	transform: scale(1.2);
	margin-right: 10px;
	vertical-align: middle;
}

.payment-option-card label {
	font-size: 16px;
	font-weight: 600;
	color: #444;
	cursor: pointer;
	margin: 0;
	display: inline-block;
	width: 90%;
}
/* Highlighted Offer Box */
.discount-premium-box {
	background: linear-gradient(135deg, #fff3cd 0%, #ffeeba 100%);
	border: 1px dashed #ffc107;
	border-radius: 8px;
	padding: 15px;
	margin-top: 12px;
	margin-left: 28px;
	animation: fadeIn 0.4s ease-in-out;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.discount-premium-box label {
	color: #856404 !important;
	font-weight: 700 !important;
	font-size: 14px;
	cursor: pointer;
}

.discount-premium-box input[type="checkbox"] {
	transform: scale(1.3);
	margin-right: 8px;
	accent-color: #ff9b05;
}

.badge-discount {
	background-color: #28a745;
	color: white;
	padding: 3px 8px;
	border-radius: 4px;
	font-size: 12px;
	margin-left: 5px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.btn-confirm {
	background-color: #ff9b05 !important;
	border-color: #ff9b05 !important;
	padding: 12px;
	font-size: 18px;
	font-weight: 600;
	border-radius: 8px;
	transition: opacity 0.2s;
	margin-top: 15px;
}

.btn-confirm:hover {
	opacity: 0.9;
	color: #fff;
}

@keyframes fadeIn {
	from { 
		opacity: 0;
		transform: translateY(-10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}
</style>
</head>

<body style="background-color: #f8f9fa;">
	<!-- header -->
	<%@include file="header1.jsp"%>
	<!-- //header -->

	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="/home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Checkout</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->

	<div class="container">
		<div class="payment-wrapper">
			<h2 class="text-center" style="margin-bottom: 25px; color: #333; font-weight: 700;">Select Payment Method</h2>

			<!-- Total Amount Display -->
			<div class="total-amount-box">
				<h4>
					Total Amount to Pay: <span style="color: #ff9b05; font-size: 22px; float: right;">₹<fmt:formatNumber value="${finalAmount}" maxFractionDigits="0" /></span>
				</h4>
			</div>

			<form action="/payment" method="post" id="paymentForm">
				<input type="hidden" name="addressId" value="${selectedAddressId}">

				<!-- PAYMENT OPTIONS -->
				<div>
					<!-- Option 1: Pay Online -->
					<div class="payment-option-card" onclick="document.getElementById('payOnlineRadio').click();">
						<input type="radio" name="paymentMethod" value="UPI" id="payOnlineRadio" onclick="showOption('upi'); event.stopPropagation();"> 
						<label for="payOnlineRadio">Pay Online Securely</label>

						<!-- HIGHLIGHTED DISCOUNT BOX -->
						<div id="discountBox" style="display: none;" onclick="event.stopPropagation();">
							<div class="discount-premium-box">
								<label for="noReturnDiscountCheckbox"> 
									<input type="checkbox" id="noReturnDiscountCheckbox" onclick="toggleDiscountValue()"> 
									<!-- 🌟 टेक्स्ट को बदलकर 8% ऑफ़ कर दिया गया है ताकि बैकएंड मॉडल से मैच हो 🌟 -->
									🎉 Get Extra 8% Off <span class="badge-discount">No Return Only Exchange</span>
								</label>
							</div>
						</div>
					</div>

					<!-- Option 2: Partial COD (40% Advance, Rest on Delivery) -->
					<div class="payment-option-card" onclick="document.getElementById('partialCodRadio').click();">
						<input type="radio" name="paymentMethod" value="PARTIAL_COD" id="partialCodRadio" onclick="showOption('partial_cod'); event.stopPropagation();">
						<label for="partialCodRadio">COD : 40% Advance, Rest on Delivery</label>
					</div>

					<!-- Hidden form values for backend -->
					<input type="hidden" id="noReturnDiscountHidden" name="noReturnDiscount" value="NO">
				</div>

				<button type="button" onclick="handlePayment()" class="btn btn-success btn-block btn-confirm">Confirm & Place Order</button>
			</form>
		</div>
	</div>

	<!-- footer -->
	<%@include file="footer.jsp"%>
	<!-- //footer -->

	<!-- 🌟 Confetti Animation Library Script CDN 🌟 -->
	<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

	<!-- payment gateway -->
	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

	<script>
	// आपके बैकएंड से आ रहे डिलीवरी चार्ज और ग्रैंड टोटल की वैल्यू को JS वेरिएबल में स्टोर करना ताकि सटीक 8% डिस्काउंट निकल सके
	var backendGrandTotal = parseFloat("${grandTotal}");
	var backendDeliveryCharge = parseFloat("${deliveryCharge}");

	function showOption(type){
		var discountBox = document.getElementById("discountBox");
		var discountCheckbox = document.getElementById("noReturnDiscountCheckbox");
		var discountHidden = document.getElementById("noReturnDiscountHidden");
		
		document.querySelectorAll('.payment-option-card').forEach(card => {
			card.style.borderColor = "#e0e0e0";
			card.style.backgroundColor = "#ffffff";
		});

		if(type === 'partial_cod'){
			discountBox.style.display = "none";    
			discountCheckbox.checked = false; 
			discountHidden.value = "NO";  
			document.getElementById('partialCodRadio').closest('.payment-option-card').style.borderColor = "#ff9b05";
			document.getElementById('partialCodRadio').closest('.payment-option-card').style.backgroundColor = "#fffafb";
		} else {
			discountBox.style.display = "block"; 
			document.getElementById('payOnlineRadio').closest('.payment-option-card').style.borderColor = "#ff9b05";
			document.getElementById('payOnlineRadio').closest('.payment-option-card').style.backgroundColor = "#fffafb";
		}
	}

	function toggleDiscountValue() {
		var checkbox = document.getElementById("noReturnDiscountCheckbox");
		var hiddenInput = document.getElementById("noReturnDiscountHidden");
		
		if(checkbox.checked) {
			hiddenInput.value = "YES";
			triggerCelebration();
		} else {
			hiddenInput.value = "NO";
		}
	}

	function triggerCelebration() {
		var duration = 1.5 * 1000;
		var end = Date.now() + duration;

		(function frame() {
			confetti({
				particleCount: 4,
				angle: 60,
				spread: 55,
				origin: { x: 0, y: 0.8 },
				colors: ['#ff9b05', '#28a745', '#007bff', '#ff3f6c', '#e0a800']
			});
			confetti({
				particleCount: 4,
				angle: 120,
				spread: 55,
				origin: { x: 1, y: 0.8 },
				colors: ['#ff9b05', '#28a745', '#007bff', '#ff3f6c', '#e0a800']
			});

			if (Date.now() < end) {
				requestAnimationFrame(frame);
			}
		}());
	}

	function handlePayment(){
		var selected = document.querySelector('input[name="paymentMethod"]:checked');

		if(!selected){
			alert("Please select payment method");
			return;
		}
		
		payNow();
	}

	function payNow() {
		var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
		var checkbox = document.getElementById("noReturnDiscountCheckbox");
		
		var amountToPay = 0;

		// 🌟 नया 8% प्रोपोर्शनल कैलकुलेटर इंजन ताकि गेटवे पर ₹1 का भी अंतर न आए 🌟
		if (paymentMethod === "UPI") {
			if (checkbox.checked) {
				// सिर्फ ग्रैंड टोटल पर 8% कम करें, डिलीवरी चार्ज वैसा ही रहेगा
				var productPriceAfterDiscount = backendGrandTotal - (backendGrandTotal * 0.08);
				amountToPay = Math.round(productPriceAfterDiscount + backendDeliveryCharge);
			} else {
				amountToPay = Math.round(backendGrandTotal + backendDeliveryCharge);
			}
		} 
		else if (paymentMethod === "PARTIAL_COD") {
			// चूंकि आंशिक कैश ऑन डिलीवरी में चेकबॉक्स हाइड रहता है, इसलिए कुल फाइनल अमाउंट का फ्लैट 40% चार्ज करें
			var totalOrderAmount = backendGrandTotal + backendDeliveryCharge;
			amountToPay = Math.round(totalOrderAmount * 0.4);
		}

		fetch("/create-order", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded"
			},
			body: "amount=" + amountToPay
		})
		.then(res => res.json())
		.then(data => {

			var options = {
				key: "rzp_live_SjF1cX3eDU1byW", 
				amount: data.amount,
				currency: "INR",
				name: "PooRah",
				description: "Order Payment",
				order_id: data.id,

				handler: function(response){
				    var form = document.getElementById("paymentForm");

				    var existingRadios = form.querySelectorAll('input[name="paymentMethod"]');
				    existingRadios.forEach(function(radio) {
				        radio.remove();
				    });

				    var methodInput = document.createElement("input");
				    methodInput.type = "hidden";
				    methodInput.name = "paymentMethod";
				    methodInput.value = paymentMethod;

				    var paymentIdInput = document.createElement("input");
				    paymentIdInput.type = "hidden";
				    paymentIdInput.name = "razorpayPaymentId";
				    paymentIdInput.value = response.razorpay_payment_id;

				    var orderIdInput = document.createElement("input");
				    orderIdInput.type = "hidden";
				    orderIdInput.name = "razorpayOrderId";
				    orderIdInput.value = response.razorpay_order_id;

				    form.appendChild(methodInput);
				    form.appendChild(paymentIdInput);
				    form.appendChild(orderIdInput);

				    form.action = "/orderPlaced";
				    form.method = "post";
				    form.submit();
				},

				theme: {
					color: "#ff9b05"
				}
			};

			var rzp = new Razorpay(options);
			rzp.open();
		});
	}
	</script>
</body>
</html>
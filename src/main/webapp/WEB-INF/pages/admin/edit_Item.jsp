<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Panel | Edit Item</title>

<link href="/admin/css/bootstrap.min.css" rel="stylesheet">
<link href="/admin/fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/animate.min.css" rel="stylesheet">
<link href="/admin/css/custom.css" rel="stylesheet">
<script src="/admin/js/jquery.min.js"></script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<jsp:include page="include/header.jsp"></jsp:include>
					<jsp:include page="include/sidebar.jsp"></jsp:include>
				</div>
			</div>

			<jsp:include page="include/nav.jsp"></jsp:include>

			<!-- Page Content -->
			<div class="right_col" role="main">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>
									Edit Item <small>Here</small>
								</h2>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<form action="/edit_Item" method="post"
									class="form-horizontal form-label-left"
									enctype="multipart/form-data">
									<input type="hidden" name="itemId" value="${item.itemId}">

									<!-- Category -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Main
											Category *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<select name="category.categoryId" id="category"
												class="form-control" required>
												<option value="">Select Category</option>
												<c:forEach var="cat" items="${categories}">
													<option value="${cat.categoryId}"
														${cat.categoryId == item.category.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<!-- SubCategory -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Sub
											Category *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<select name="subCategory.subCategoryId"
												id="subCategorySelect" class="form-control" required>
												<option value="">Select Sub Category</option>

												<c:forEach var="s" items="${subcategories}">
													<option value="${s.subCategoryId}"
														${s.subCategoryId == item.subCategory.subCategoryId ? 'selected' : ''}>
														${s.subCategoryName}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<!-- Gender -->
									<div class="form-group" id="genderDiv">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Gender
											*</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<select name="gender" id="gender" class="form-control">
												<option value="MEN"
													${item.gender == 'MEN' ? 'selected' : ''}>MEN</option>
												<option value="WOMEN"
													${item.gender == 'WOMEN' ? 'selected' : ''}>WOMEN</option>
											</select>
										</div>
									</div>

									<!-- SKU -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">SKU
											Id *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="skuId" value="${item.skuId}"
												class="form-control" required>
										</div>
									</div>

									<!-- Item Name -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Item
											Name *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="itemName" value="${item.itemName}"
												class="form-control" required>
										</div>
									</div>

									<!-- Main Price -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Item
											Price (₹) *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="itemPrice" value="${item.itemPrice}"
												class="form-control" required>
										</div>
									</div>

									<!-- ADDED: MAIN ITEM IMAGE UPLOAD SECTION (Yeh missing tha) -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Main
											Item Image</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<!-- Puraani images ka preview dikhane ke liye -->
											<c:if test="${not empty item.itemImage}">
												<div style="margin-bottom: 10px;">
													<c:forEach var="img"
														items="${fn:split(item.itemImage, ',')}">
														<img src="${img}"
															style="width: 70px; height: 70px; margin-right: 5px; border: 1px solid #ccc; object-fit: cover;">
													</c:forEach>
												</div>
											</c:if>
											<!-- Input field jo controller me "file" ke naam se map hogi -->
											<input type="file" name="file"
												class="form-control col-md-7 col-xs-12" multiple> <small
												class="text-muted">Change Image</small>
										</div>
									</div>

									<!-- Stock Div (For non-clothing) -->
									<div class="form-group" id="stockDiv">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Item
											Stock *</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="stock" value="${item.stock}"
												class="form-control">
										</div>
									</div>

									<!-- Discount -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Discount
											(%)</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="discount" value="${item.discount}"
												class="form-control">
										</div>
									</div>

									<!-- PRODUCT VARIANTS (MAIN BLOCK) -->
									<div class="form-group" id="variantDiv">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Product
											Variants</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<div id="variantContainer">

												<c:forEach var="variant" items="${item.variants}"
													varStatus="st">
													<div class="colorBlock"
														style="border: 1px solid #ddd; padding: 15px; margin-bottom: 15px; border-radius: 5px; background: #fafafa;">
														<input type="hidden" name="variantId[]"
															value="${variant.variantId}" /> <label>Color</label> <input
															type="text" name="color[]"
															value="${variant.variantColor}" class="form-control"
															 /> <label style="margin-top: 10px;">Variant
															Image</label>
														<c:if test="${not empty variant.variantImage}">
															<div>
																<img src="${variant.variantImage}"
																	style="width: 80px; height: 80px; margin-bottom: 10px; border: 1px solid #ccc;" />
															</div>
														</c:if>
														<input type="file" name="variantImage_${st.index}"
															class="form-control" multiple/>

														<hr>
														<label>Sizes & Stock</label>

														<c:set var="stockStr" value="${variant.variantStock}" />

														<!-- Puraane variants ke liye dynamic parameters index: stockS_0, stockS_1... -->
														<div>
															<label>S</label> <input type="number"
																name="stockS_${st.index}" class="form-control" min="0"
																value="${fn:contains(stockStr, 'S:') ? fn:substringBefore(fn:substringAfter(stockStr, 'S:'), ',M:') : '0'}">
														</div>
														<div>
															<label>M</label> <input type="number"
																name="stockM_${st.index}" class="form-control" min="0"
																value="${fn:contains(stockStr, 'M:') ? fn:substringBefore(fn:substringAfter(stockStr, 'M:'), ',L:') : '0'}">
														</div>
														<div>
															<label>L</label> <input type="number"
																name="stockL_${st.index}" class="form-control" min="0"
																value="${fn:contains(stockStr, 'L:') ? fn:substringBefore(fn:substringAfter(stockStr, 'L:'), ',XL:') : '0'}">
														</div>
														<div>
															<label>XL</label> <input type="number"
																name="stockXL_${st.index}" class="form-control" min="0"
																value="${fn:contains(stockStr, 'XL:') ? fn:substringAfter(stockStr, 'XL:') : '0'}">
														</div>
														<div>
															<label>XXL</label> <input type="number"
																name="stockXXL_${st.index}" class="form-control" min="0"
																value="${fn:contains(stockStr, 'XXL:') ? fn:substringAfter(stockStr, 'XXL:') : '0'}">
														</div>

														<button type="button"
															class="btn btn-danger btn-sm removeVariant"
															style="margin-top: 10px;">Remove Color</button>
													</div>
												</c:forEach>

											</div>
											<button type="button" class="btn btn-primary"
												id="addVariantBtn">+ Add Color Block</button>
										</div>
									</div>

									<!-- Fabric & Weight -->
									<div class="form-group" id="fabricDiv">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Fabric</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="fabric" value="${item.fabric}"
												class="form-control">
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Weight</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<input type="text" name="weight" value="${item.weight}"
												class="form-control">
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12"
											for="feature">Featured Product <span class="required">
												*</span></label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<!-- Dropdown select se 'value' attribute hataiye, select ka name controller me match karega -->
											<select name="featuredProduct" id="feature"
												class="form-control col-md-7 col-xs-12" required>
												<!-- JSTL condition se select logic lagaiye -->
												<option value="Yes"
													${item.featuredProduct == 'Yes' ? 'selected' : ''}>Yes</option>
												<option value="No"
													${item.featuredProduct == 'No' ? 'selected' : ''}>No</option>
											</select>
										</div>
									</div>

									<!-- Textareas Description -->
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Description</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<textarea name="itemDesc" class="form-control" rows="4">${item.itemDesc}</textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Key
											Features</label>

										<div class="col-md-6 col-sm-6 col-xs-12">
											<textarea name="keyFeatures" class="form-control" rows="6"
												placeholder="Enter one feature per line">${item.keyFeatures}</textarea>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-md-3 col-sm-3 col-xs-12">Status</label>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<div id="status" class="btn-group" data-toggle="buttons">
												<label class="btn btn-default"
													data-toggle-class="btn-primary"
													data-toggle-passive-class="btn-default"> <input
													type="radio" name="status" value="active"> &nbsp;
													Active &nbsp;
												</label> <label class="btn btn-primary active"
													data-toggle-class="btn-primary"
													data-toggle-passive-class="btn-default"> <input
													type="radio" name="status" value="inactive" checked=""
													required=""> In-Active
												</label>
											</div>
										</div>
									</div>

									<div class="ln_solid"></div>
									<div class="form-group">
										<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
											<button type="submit" class="btn btn-success">Update
												Item</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
	</div>

	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script src="/admin/js/bootstrap.min.js"></script>

	<!-- bootstrap progress js -->
	<script src="/admin/js/progressbar/bootstrap-progressbar.min.js"></script>
	<script src="/admin/js/nicescroll/jquery.nicescroll.min.js"></script>
	<!-- icheck -->
	<script src="/admin/js/icheck/icheck.min.js"></script>
	<!-- tags -->
	<script src="/admin/js/tags/jquery.tagsinput.min.js"></script>
	<!-- switchery -->
	<script src="/admin/js/switchery/switchery.min.js"></script>
	<!-- daterangepicker -->
	<script type="text/javascript" src="/admin/js/moment/moment.min.js"></script>
	<script type="text/javascript"
		src="/admin/js/datepicker/daterangepicker.js"></script>
	<!-- richtext editor -->
	<script src="/admin/js/editor/bootstrap-wysiwyg.js"></script>
	<script src="/admin/js/editor/external/jquery.hotkeys.js"></script>
	<script
		src="/admin/js/editor/external/google-code-prettify/prettify.js"></script>
	<!-- select2 -->
	<script src="/admin/js/select/select2.full.js"></script>
	<!-- form validation -->
	<script type="text/javascript" src="/admin/js/parsley/parsley.min.js"></script>
	<!-- textarea resize -->
	<script src="/admin/js/textarea/autosize.min.js"></script>
	<script>
		autosize($('.resizable_textarea'));
	</script>
	<!-- Autocomplete -->
	<script type="text/javascript"
		src="/admin/js/autocomplete/countries.js"></script>
	<script src="/admin/js/autocomplete/jquery.autocomplete.js"></script>
	<!-- pace -->
	<script src="/admin/js/pace/pace.min.js"></script>
	<!--  <script type="text/javascript">
		$(function() {
			'use strict';
			var countriesArray = $.map(countries, function(value, key) {
				return {
					value : value,
					data : key
				};
			});
			// Initialize autocomplete with custom appendTo:
			$('#autocomplete-custom-append').autocomplete({
				lookup : countriesArray,
				appendTo : '#autocomplete-container'
			});
		});
	</script>-->
	<script src="/admin/js/custom.js"></script>

	<script>
	function toggleCategoryFields(){
	    var categoryName = $("#category option:selected").text().toLowerCase();
	    
	    $("#genderDiv, #variantDiv, #fabricDiv").hide();
	    $("#stockDiv").show();
	    $("#stock").attr("required", "required");
	    
	    var variantColorInputs = document.querySelectorAll("#variantContainer input[name='color[]']");

	    if(categoryName.includes("men") || categoryName.includes("women")){
	        $("#genderDiv, #variantDiv, #fabricDiv").show();
	        $("#stockDiv").hide();
	        
	        $("#stock").removeAttr("required");
	        
	        variantColorInputs.forEach(function(input) {
	            input.setAttribute("required", "required");
	        });
	    } else {
	       
	        variantColorInputs.forEach(function(input) {
	            input.removeAttribute("required");
	        });
	    }
	}

    $(document).ready(function(){
       
        toggleCategoryFields();

        $("#category").change(function(){
            toggleCategoryFields();
        });

       
        $("#category").change(function() {
            var categoryId = $(this).val();
            var subCategorySelect = $("#subCategorySelect");

            // Purane options clear karein
            subCategorySelect.html("");
            subCategorySelect.append("<option value=''>Select Sub Category</option>");

            if (categoryId != "") {
                $.ajax({
                    url : "/getSubCategories",
                    type : "GET",
                    data : {
                        categoryId : categoryId
                    },
                    success : function(result) {
                        $.each(result, function(i, sub) {
                            subCategorySelect.append("<option value='" + sub.subCategoryId + "'>" + sub.subCategoryName + "</option>");
                        });
                    },
                    error: function(err) {
                        console.log("Error fetching subcategories:", err);
                    }
                });
            }
        });

       
        let variantCount = $(".colorBlock").length;

        $("#addVariantBtn").click(function(){
            $("#variantContainer").append(`
                <div class="colorBlock" style="border:1px solid #ddd; padding:15px; margin-bottom:15px; border-radius:5px; background:#fafafa;">
                    <input type="hidden" name="variantId[]" value=""/>
                    <label>Color</label>
                    <input type="text" name="color[]" class="form-control" placeholder="Enter Color" required/>

                    <label style="margin-top:10px;">Variant Image</label>
                    <input type="file" name="variantImage_\${variantCount}" class="form-control" multiple/>

                    <hr>
                    <label>Sizes & Stock</label>
                    <div><label>S</label><input type="number" name="stockS_\${variantCount}" class="form-control" value="0" min="0"></div>
                    <div><label>M</label><input type="number" name="stockM_\${variantCount}" class="form-control" value="0" min="0"></div>
                    <div><label>L</label><input type="number" name="stockL_\${variantCount}" class="form-control" value="0" min="0"></div>
                    <div><label>XL</label><input type="number" name="stockXL_\${variantCount}" class="form-control" value="0" min="0"></div>
                    <div><label>XXL</label><input type="number" name="stockXXL_\${variantCount}" class="form-control" value="0" min="0"></div>

                    <button type="button" class="btn btn-danger btn-sm removeVariant" style="margin-top: 10px;">Remove Color</button>
                </div>
            `);
            variantCount++; 
        });

        // REMOVE VARIANT BLOCK
        $(document).on("click", ".removeVariant", function(){
            $(this).closest(".colorBlock").remove();
        });
    });
</script>
</body>
</html>
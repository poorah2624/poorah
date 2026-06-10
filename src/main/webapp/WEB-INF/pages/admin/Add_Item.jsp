<%-- 
    Document   : txt
    Created on : Aug 2, 2018, 12:22:15 PM
    Author     : APTA
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Gentellela Alela! |</title>

<!-- Bootstrap core CSS -->

<link href="/admin/css/bootstrap.min.css" rel="stylesheet">

<link href="/admin/fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/animate.min.css" rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="/admin/css/custom.css" rel="stylesheet">
<link href="/admin/css/icheck/flat/green.css" rel="stylesheet">
<!-- editor -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css"
	rel="stylesheet">
<link
	href="/admin/css/editor/external/google-code-prettify/prettify.css"
	rel="stylesheet">
<link href="/admin/css/editor/index.css" rel="stylesheet">
<!-- select2 -->
<link href="/admin/css/select/select2.min.css" rel="stylesheet">
<!-- switchery -->
<link rel="stylesheet" href="/admin/css/switchery/switchery.min.css" />

<script src="/admin/js/jquery.min.js"></script>

<!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
<script>
	function fileValidation() {
		var fileInput = document.getElementById('file');
		var filePath = fileInput.value;
		var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
		if (!allowedExtensions.exec(filePath)) {
			alert('Please upload file having extensions .jpeg/.jpg/.png/.gif only.');
			fileInput.value = '';
			return false;
		} else {
			//Image preview
			if (fileInput.files && fileInput.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('imagePreview').innerHTML = '<img src="'+e.target.result+'"/>';
				};
				reader.readAsDataURL(fileInput.files[0]);
			}
		}
	}
</script>





</head>


<body class="nav-md">

	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<jsp:include page="include/header.jsp"></jsp:include>


					<!-- sidebar menu -->
					<jsp:include page="include/sidebar.jsp"></jsp:include>

					<!-- /sidebar menu -->

					<!-- /menu footer buttons -->

					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<jsp:include page="include/nav.jsp"></jsp:include>
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">

					<div class="page-title">
						<div class="title_left">
							<h3>Add Item</h3>
						</div>

					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">





							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Add Item<small>Here</small>
										</h2>
										<ul class="nav navbar-right panel_toolbox">
											<li><a class="collapse-link"><i
													class="fa fa-chevron-up"></i></a></li>

											<li><a class="close-link"><i class="fa fa-close"></i></a>
											</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<form action="/Add_Item" method="post" name="my_form"
											class="form-horizontal form-label-left"
											enctype="multipart/form-data"
											onSubmit="document.my_form.editor_contents.value = $('#editor').html()">
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="Category">Main Category <span class="required">
														*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<select name="categoryId" id="category"
														class="form-control col-md-7 col-xs-12" required="">
														<option value="">Select Category</option>
														<c:forEach var="cat" items="${categories}">
															<option value="${cat.categoryId}">
																${cat.categoryName}</option>
														</c:forEach>

													</select>


												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="SubCategory">Sub Category <span
													class="required"> *</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12" id='subcategory'>
													<select name="subCategoryId" id="subCategorySelect"
														class="form-control" required>

														<option value="">Select Sub Category</option>

													</select>


												</div>
											</div>

											<div class="form-group" id="genderDiv" style="display: none;">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="Gender">Gender <span class="required">
														*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12" id='subcategory'>
													<select name="gender" id="gender" class="form-control">

														<option value="">Select Gender</option>
														<option value="MEN">MEN</option>
														<option value="WOMEN">WOMEN</option>

													</select>


												</div>
											</div>

											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="title">Item Name <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="title" pattern="([A-Za-z .-])+"
														name="itemName" title="Enter Words Only"
														required="required" placeholder="Enter Title here"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="file">Item Image <span class="required">*</span></label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="file" id="mainImageInput" name="itemImage"
														class="form-control col-md-7 col-xs-12" multiple>
													<div id="mainImagePreviewContainer"
														style="margin-top: 10px; display: flex; flex-wrap: wrap; gap: 10px;"></div>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="price">Item Price <span class="required">
														&#8377</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="price" pattern="[0-9]{1,8}"
														name="itemPrice"
														title="Enter Digits Only and it should not be more then INR 9.99 Crore"
														required="required" placeholder="Enter Price in &#8377"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>
											<div class="form-group" id="stockDiv">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="stock">Item Stock limit <span class="required">
														*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="stock" pattern="[0-9]{1,20}"
														name="stock" title="Enter Digits Only"
														placeholder="Enter Stock Limit"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>


											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="discount">Discount<span class="required">(%)</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="discount" pattern="[0-9]{1,2}"
														name="discount"
														title="Enter Digits Only and shoul not be more then 99"
														required="required" placeholder="Enter Discount in %"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>


											<div class="form-group" id="variantDiv"
												style="display: none;">
												<label class="control-label col-md-3 col-sm-3 col-xs-12">
													Product Variants </label>

												<div class="col-md-6 col-sm-6 col-xs-12">

													<div id="variantContainer">


														<div class="colorBlock"
															style="border: 1px solid #ddd; padding: 15px; margin-bottom: 15px; border-radius: 5px; background: #fafafa;">

															<label>Color</label> <input type="text" name="color[]"
																class="form-control" placeholder="Enter Color">

															<label style="margin-top: 10px;">Variant Image</label> <input
																type="file" name="variantImage_0" class="form-control"
																multiple>

															<hr>

															<label>Sizes & Stock</label>


															<div>
																<label> S </label> <input type="number" name="stockS_0"
																	placeholder="Stock for S" class="form-control"
																	value="0" min="0">
															</div>

															<div>
																<label> M </label> <input type="number" name="stockM_0"
																	placeholder="Stock for M" class="form-control"
																	value="0" min="0">
															</div>

															<div>
																<label> L </label> <input type="number" name="stockL_0"
																	placeholder="Stock for L" class="form-control"
																	value="0" min="0">
															</div>

															<div>
																<label> XL </label> <input type="number"
																	name="stockXL_0" placeholder="Stock for XL"
																	class="form-control" value="0" min="0">
															</div>
															<div>
																<label> XXL </label> <input type="number"
																	name="stockXXL_0" placeholder="Stock for XXL"
																	class="form-control" value="0" min="0">
															</div>

														</div>

													</div>

													<button type="button" class="btn btn-primary"
														onclick="addVariant()">+ Add Color</button>

												</div>
											</div>

											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="weight">Weight<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" name="weight"
														placeholder="Enter Weight (e.g. 500g)" required="required"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>

											<div class="form-group" id="fabricDiv" style="display: none;">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="fabric">Fabric <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="title" pattern="([A-Za-z .])+"
														name="fabric" title="Enter Words Only"
														placeholder="Enter Fabric here"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>

											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="feature">Featured Product <span
													class="required"> *</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<select name="featuredProduct" id="feature"
														class="form-control col-md-7 col-xs-12">
														<option value="Yes">Yes</option>
														<option value="No">No</option>

													</select>
												</div>

											</div>


											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12">Description</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<textarea name="itemDesc" class="form-control" rows="4"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12">Key
													Features</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<textarea name="keyFeatures" class="form-control" rows="6"
														placeholder="Enter one feature per line"></textarea>
												</div>
											</div>
											<br />
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
													<button type="reset" class="btn btn-danger">Reset</button>
													<button type="submit" class="btn btn-success">Submit</button>
												</div>
											</div>


										</form>
										<div class="ln_solid"></div>


									</div>
								</div>
							</div>


							<!-- /page content -->

							<!-- footer content -->
						</div>
						<div class="clearfix"></div>
					</div>
				</div>

			</div>
			<br />

			<!-- footer content -->
			<jsp:include page="include/footer.jsp"></jsp:include>


			<!-- /footer content -->
		</div>
		<!-- /page content -->

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


	<!-- select2 -->
	<script>
		$(document).ready(function() {
			$(".select2_single").select2({
				placeholder : "Select a state",
				allowClear : true
			});
			$(".select2_group").select2({});
			$(".select2_multiple").select2({
				maximumSelectionLength : 4,
				placeholder : "With Max Selection limit 4",
				allowClear : true
			});
		});
	</script>
	<!-- /select2 -->
	<!-- input tags -->
	<script>
		function onAddTag(tag) {
			alert("Added a tag: " + tag);
		}

		function onRemoveTag(tag) {
			alert("Removed a tag: " + tag);
		}

		function onChangeTag(input, tag) {
			alert("Changed a tag: " + tag);
		}

		$(function() {
			$('#tags_1').tagsInput({
				width : 'auto'
			});
		});
	</script>
	<!-- /input tags -->
	<!-- form validation -->
	<script type="text/javascript">
		$(document).ready(function() {
			$.listen('parsley:field:validate', function() {
				validateFront();
			});
			$('#demo-form .btn').on('click', function() {
				$('#demo-form').parsley().validate();
				validateFront();
			});
			var validateFront = function() {
				if (true === $('#demo-form').parsley().isValid()) {
					$('.bs-callout-info').removeClass('hidden');
					$('.bs-callout-warning').addClass('hidden');
				} else {
					$('.bs-callout-info').addClass('hidden');
					$('.bs-callout-warning').removeClass('hidden');
				}
			};
		});

		$(document).ready(function() {
			$.listen('parsley:field:validate', function() {
				validateFront();
			});
			$('#demo-form2 .btn').on('click', function() {
				$('#demo-form2').parsley().validate();
				validateFront();
			});
			var validateFront = function() {
				if (true === $('#demo-form2').parsley().isValid()) {
					$('.bs-callout-info').removeClass('hidden');
					$('.bs-callout-warning').addClass('hidden');
				} else {
					$('.bs-callout-info').addClass('hidden');
					$('.bs-callout-warning').removeClass('hidden');
				}
			};
		});
		try {
			hljs.initHighlightingOnLoad();
		} catch (err) {
		}
	</script>
	<!-- /form validation -->
	<!-- editor -->
	<script>
		$(document).ready(function() {
			$('.xcxc').click(function() {
				$('#descr').val($('#editor').jsp());
			});
		});

		$(function() {
			function initToolbarBootstrapBindings() {
				var fonts = [ 'Serif', 'Sans', 'Arial', 'Arial Black',
						'Courier', 'Courier New', 'Comic Sans MS', 'Helvetica',
						'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma',
						'Times', 'Times New Roman', 'Verdana' ], fontTarget = $(
						'[title=Font]').siblings('.dropdown-menu');
				$
						.each(
								fonts,
								function(idx, fontName) {
									fontTarget
											.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">'
													+ fontName + '</a></li>'));
								});
				$('a[title]').tooltip({
					container : 'body'
				});
				$('.dropdown-menu input').click(function() {
					return false;
				}).change(
						function() {
							$(this).parent('.dropdown-menu').siblings(
									'.dropdown-toggle').dropdown('toggle');
						}).keydown('esc', function() {
					this.value = '';
					$(this).change();
				});

				$('[data-role=magic-overlay]').each(
						function() {
							var overlay = $(this), target = $(overlay
									.data('target'));
							overlay.css('opacity', 0).css('position',
									'absolute').offset(target.offset()).width(
									target.outerWidth()).height(
									target.outerHeight());
						});
				if ("onwebkitspeechchange" in document.createElement("input")) {
					var editorOffset = $('#editor').offset();
					$('#voiceBtn').css('position', 'absolute').offset(
							{
								top : editorOffset.top,
								left : editorOffset.left
										+ $('#editor').innerWidth() - 35
							});
				} else {
					$('#voiceBtn').hide();
				}
			}
			;

			function showErrorAlert(reason, detail) {
				var msg = '';
				if (reason === 'unsupported-file-type') {
					msg = "Unsupported format " + detail;
				} else {
					console.log("error uploading file", reason, detail);
				}
				$(
						'<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'
								+ '<strong>File upload error</strong> '
								+ msg
								+ ' </div>').prependTo('#alerts');
			}
			;
			initToolbarBootstrapBindings();
			$('#editor').wysiwyg({
				fileUploadError : showErrorAlert
			});
			window.prettyPrint && prettyPrint();
		});
	</script>
	<!-- /editor -->

	<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  -->

	<script>
		$(document)
				.ready(
						function() {

							$("#category")
									.change(
											function() {

												var categoryId = $(this).val();

												var subCategorySelect = $("#subCategorySelect");

												// To remove previous
												subCategorySelect.html("");

												// default option add
												subCategorySelect
														.append("<option value=''>Select Sub Category</option>");

												if (categoryId != "") {

													$
															.ajax({

																url : "/getSubCategories",
																type : "GET",
																data : {
																	categoryId : categoryId
																},

																success : function(
																		result) {

																	$
																			.each(
																					result,
																					function(
																							i,
																							sub) {

																						subCategorySelect
																								.append("<option value='"+sub.subCategoryId+"'>"
																										+ sub.subCategoryName
																										+ "</option>");

																					});

																}

															});

												}

											});

						});
	</script>

	<script>
		document.getElementById("category").addEventListener(
				"change",
				function() {

					var categoryName = this.options[this.selectedIndex].text;

					var genderDiv = document.getElementById("genderDiv");
					var variantDiv = document.getElementById("variantDiv");
					var fabricDiv = document.getElementById("fabricDiv");
					var stockDiv = document.getElementById("stockDiv");

					genderDiv.style.display = "none";
					variantDiv.style.display = "none";
					fabricDiv.style.display = "none";
					stockDiv.style.display = "block";
					
					

					if (categoryName.toLowerCase().includes("men")
							|| categoryName.toLowerCase().includes("women") || categoryName.toLowerCase().includes("couple wear")) {
                       if(categoryName.toLowerCase().includes("couple wear"))
					{
                    	   genderDiv.style.display = "none";
                    }
                       else
                    	   {
                    	   genderDiv.style.display = "block";
                          }
						//genderDiv.style.display = "block";
						variantDiv.style.display = "block";
						fabricDiv.style.display = "block";
						stockDiv.style.display = "none";
					}
			
				});
	</script>

	<script>
    
	
	let variantCount = 1; 

	function addVariant(){
	    let html = `
	      <div class="colorBlock" style="border: 1px solid #ddd; padding: 15px; margin-bottom: 15px; border-radius: 5px; background: #fafafa;">
	        <label>Color</label>
	        <input type="text" name="color[]" class="form-control" placeholder="Enter Color">

	        <label style="margin-top: 10px;">Variant Image</label>
	        <input type="file" name="variantImage_\${variantCount}" id="vInput_\${variantCount}" class="form-control" multiple onchange="accumulateVariantFiles(this, \${variantCount})">
	        <div id="vPreview_\${variantCount}" style="margin-top: 5px; display: flex; gap: 5px; flex-wrap: wrap;"></div>

	        <hr>
	        <label>Sizes & Stock</label>
	        <div>
	          <label>S</label>
	          <input type="number" name="stockS_\${variantCount}" class="form-control" value="0" min="0">
	        </div>
	        <div>
	          <label>M</label>
	          <input type="number" name="stockM_\${variantCount}" class="form-control" value="0" min="0">
	        </div>
	        <div>
	          <label>L</label>
	          <input type="number" name="stockL_\${variantCount}" class="form-control" value="0" min="0">
	        </div>
	        <div>
	          <label>XL</label>
	          <input type="number" name="stockXL_\${variantCount}" class="form-control" value="0" min="0">
	        </div>
	        <div>
	          <!-- YAHAN CORRECTION KIYA HAI: name ko stockXXL aur placeholder ko XXL kiya -->
	          <label>XXL</label>
	          <input type="number" name="stockXXL_\${variantCount}" placeholder="Stock for XXL" class="form-control" value="0" min="0">
	        </div>

	        <button type="button" class="btn btn-danger btn-sm" onclick="removeVariant(this)" style="margin-top: 10px;">
	          Remove Color
	        </button>
	      </div>
	    `;
	    document.getElementById("variantContainer").insertAdjacentHTML("beforeend", html);
	    variantCount++;
	}

	function removeVariant(btn){
	    btn.closest(".colorBlock").remove();
	}
	
	
	const mainFileBasket = new DataTransfer();
	const varBaskets = {};

	
	document.getElementById("mainImageInput").addEventListener("change", function(e) {
	    const files = e.target.files;
	    const previewContainer = document.getElementById("mainImagePreviewContainer");

	    for (let i = 0; i < files.length; i++) {
	        mainFileBasket.items.add(files[i]); 
	    }
	    this.files = mainFileBasket.files; 
	    previewContainer.innerHTML = "";
	    Array.from(mainFileBasket.files).forEach((file, index) => {
	        const reader = new FileReader();
	        reader.onload = function(event) {
	            const imgDiv = document.createElement("div");
	            imgDiv.style.position = "relative";
	            imgDiv.innerHTML = `
	                <img src="${event.target.result}" style="width: 70px; height: 70px; object-fit: cover; border: 1px solid #ccc; border-radius: 4px;">
	                <span onclick="removeMainFileFromBasket(${index})" style="position: absolute; top: -5px; right: -5px; background: red; color: white; border-radius: 50%; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-size: 10px; cursor: pointer;">X</span>
	            `;
	            previewContainer.appendChild(imgDiv);
	        };
	        reader.readAsDataURL(file);
	    });
	});

	function removeMainFileFromBasket(index) {
	    const input = document.getElementById("mainImageInput");
	    const newBasket = new DataTransfer();
	    Array.from(input.files).forEach((file, i) => { if (i !== index) newBasket.items.add(file); });
	    mainFileBasket.items.clear();
	    Array.from(newBasket.files).forEach(file => mainFileBasket.items.add(file));
	    input.files = mainFileBasket.files;
	    input.dispatchEvent(new Event('change'));
	}

	
	function accumulateVariantFiles(inputElement, index) {
	    if (!varBaskets[index]) varBaskets[index] = new DataTransfer();
	    const incomingFiles = inputElement.files;
	    const previewDiv = document.getElementById("vPreview_" + index);
	    
	    for (let i = 0; i < incomingFiles.length; i++) {
	        varBaskets[index].items.add(incomingFiles[i]);
	    }
	    inputElement.files = varBaskets[index].files;
	    
	    previewDiv.innerHTML = "";
	    Array.from(inputElement.files).forEach((file) => {
	        const reader = new FileReader();
	        reader.onload = function(e) {
	            const img = document.createElement("img");
	            img.src = e.target.result;
	            img.style.cssText = "width: 50px; height: 50px; object-fit: cover; border: 1px solid #ddd; border-radius: 4px;";
	            previewDiv.appendChild(img);
	        };
	        reader.readAsDataURL(file);
	    });
	}
</script>
</body>

</html>

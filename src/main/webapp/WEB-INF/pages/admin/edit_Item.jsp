<%-- 
    Document   : Add_Banner
    Created on : Jul 31, 2018, 9:50:43 AM
    Author     : APTA
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Panel</title>

<!-- Bootstrap core CSS -->

<link
	href="/admin/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="/admin/fonts/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="/admin/css/animate.min.css"
	rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="/admin/css/custom.css"
	rel="stylesheet">
<link
	href="/admin/css/icheck/flat/green.css"
	rel="stylesheet">

<link
	href="/admin/js/datatables/jquery.dataTables.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/admin/js/datatables/buttons.bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/admin/js/datatables/fixedHeader.bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/admin/js/datatables/responsive.bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/admin/js/datatables/scroller.bootstrap.min.css"
	rel="stylesheet" type="text/css" />

<script src="/admin/js/jquery.min.js"></script>

<!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

</head>
<script>

$(document).ready(function () {

    // Page load par check
    toggleFieldsByCategory();

    // Category change hone par
    $("#category").change(function () {
        toggleFieldsByCategory();
    });

});

function toggleFieldsByCategory() {

    var categoryName = $("#category option:selected").text().trim();

    if (categoryName === "Clothing") {

        $("#sizeDiv").show();
        $("#ageDiv").hide();

    } 
    else if (categoryName === "Kids") {

        $("#ageDiv").show();
        $("#sizeDiv").hide();

    } 
    else {

        $("#sizeDiv").hide();
        $("#ageDiv").hide();

    }

}

</script>

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

				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="dashboard_graph">

							<div class="row x_title">
								<div class="col-md-6">
									<h3>
										View Items<small><a
											href="/view_Item"><button
													class="btn-lg btn btn-outline btn-success">View
													Items</button></a></small>
									</h3>
								</div>
								<div class="col-md-6"></div>
							</div>
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Edit Item <small>Here</small>
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

										<form action="/edit_Item"
											method="post" name="my_form"
											class="form-horizontal form-label-left"
											enctype="multipart/form-data"
											onSubmit="document.my_form.editor_contents.value = $('#editor').html()">
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="Category">Main Category <span class="required">
														*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<select name="category.categoryId" id="category"
														class="form-control col-md-7 col-xs-12" required="">
														<option value="">Select Category</option>
														<c:forEach var="cat" items="${categories}">
															<option value="${cat.categoryId}"
																${cat.categoryId == item.category.categoryId ? 'selected' : ''}>
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
													<select name="subCategory.subCategoryId"
														id="subCategorySelect" class="form-control" required>
														<c:forEach var="s" items="${subcategories}">
															<option value="${s.subCategoryId}"
																${s.subCategoryId == item.subCategory.subCategoryId ? 'selected' : ''}>
																${s.subCategoryName}</option>
														</c:forEach>

													</select>


												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="Gender">Gender <span
													class="required"> *</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12" id='subcategory'>
													<select name="gender"
														id="gender" class="form-control" required>
														
															<option value="${item.gender}">${item.gender}</option>
														    <option value="MEN">MEN</option>
														    <option value="WOMEN">WOMEN</option>

													</select>


												</div>
											</div>

											<input type="hidden" name="itemId" value="${item.itemId }">
											
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="skuId">SKU Id <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="skuId" pattern="([A-Za-z0-9 .-])+"
														name="skuId" value="${item.skuId }"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>


											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="title">Item Name <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="title" pattern="([A-Za-z .-])+"
														name="itemName" value="${item.itemName }"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>
											
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="file">Item Image <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
												<c:forEach var="img" items="${fn:split(item.itemImage, ',')}">
													<img
														src="/uploads/${img}"
														name="itemImage" style="width: 200px; height: 200px;">
												</c:forEach>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="file">Item Image <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="hidden" name="itemImage"
														value="${item.itemImage}"> <input type="file"
														id="file" name="file" value="${item.itemImage }"
														class="form-control col-md-7 col-xs-12"
														onchange="return fileValidation()" multiple>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="price">Item Price <span class="required">
														&#8377</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="price""
														name="itemPrice" value="${item.itemPrice }"
														title="Enter Digits Only and it should not be more then INR 9.99 Crore"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>

											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="stock">Item Stock limit <span class="required">
														*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="stock" pattern="[0-9]{1,20}"
														name="stock" value="${item.stock }"
														title="Enter Digits Only"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="discount">Discount<span class="required">(%)</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="discount" pattern="[0-9]{1,2}"
														name="discount" value="${item.discount }"
														title="Enter Digits Only and shoul not be more then 99"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>

											<div class="form-group" id="sizeDiv">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="size">Select Size<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="checkbox" name="size" value="S"
														<c:if test="${fn:contains(item.size,'S')}">checked</c:if>>
													S <input type="checkbox" name="size" value="M"
														<c:if test="${fn:contains(item.size,'M')}">checked</c:if>>
													M <input type="checkbox" name="size" value="L"
														<c:if test="${fn:contains(item.size,'L')}">checked</c:if>>
													L <input type="checkbox" name="size" value="XL"
														<c:if test="${fn:contains(item.size,'XL')}">checked</c:if>>
													XL <input type="checkbox" name="size" value="XXL"
														<c:if test="${fn:contains(item.size,'XXL')}">checked</c:if>>
													XXL
												</div>
											</div>
											<div class="form-group" id="ageDiv">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="size">Select Age<span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="checkbox" name="age" value="0-1"
														<c:if test="${fn:contains(item.age,'0-1')}">checked</c:if>>
													0-1 <input type="checkbox" name="age" value="1-3"
														<c:if test="${fn:contains(item.age,'1-3')}">checked</c:if>>
													1-3 <input type="checkbox" name="age" value="3-5"
														<c:if test="${fn:contains(item.age,'3-5')}">checked</c:if>>
													3-5 <input type="checkbox" name="age" value="5-7"
														<c:if test="${fn:contains(item.age,'5-7')}">checked</c:if>>
													5-7
												</div>
											</div>
											
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="weight">Weight<span class="required">(%)</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="weight"
														name="weight" value="${item.weight } g"
														class="form-control col-md-7 col-xs-12">
												</div>
											</div>
											
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="fabric">Fabric <span class="required">*</span>
												</label>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<input type="text" id="fabric" pattern="([A-Za-z .])+"
														name="fabric" value="${item.fabric }"
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
														value="${item.featuredProduct }"
														class="form-control col-md-7 col-xs-12">
														<option value="Yes">Yes</option>
														<option value="No">No</option>

													</select>
												</div>

											</div>


											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="descr">Add Description below: </label>

												<div id="editor">
													<textarea name="itemDesc" id="editor"
														class="form-control col-md-7 col-xs-12">${item.itemDesc }</textarea>
												</div>


											</div>
											<div class="form-group">
												<label class="control-label col-md-3 col-sm-3 col-xs-12"
													for="descr">Add Key Features below: </label>

												<div id="editor">
													<textarea name="keyFeatures" id="editor"
														class="form-control col-md-7 col-xs-12">${item.keyFeatures }</textarea>
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
															type="radio" name="status" value="active"
															${item.status=='active'?'checked':''}> &nbsp;
															Active &nbsp;
														</label> <label class="btn btn-primary active"
															data-toggle-class="btn-primary"
															data-toggle-passive-class="btn-default"> <input
															type="radio" name="status" value="inactive"
															${item.status=='inactive'?'checked':''} checked=""
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
						</div>
					</div>






				</div>
			</div>
		</div>
	</div>
	<!-- footer content -->
	<jsp:include page="include/footer.jsp"></jsp:include>
	<!-- /footer content -->

	</div>
	<!-- /page content -->
	</div>

	</div>

	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script
		src="/admin/js/bootstrap.min.js"></script>

	<!-- bootstrap progress js -->
	<script
		src="/admin/js/progressbar/bootstrap-progressbar.min.js"></script>
	<script
		src="/admin/js/nicescroll/jquery.nicescroll.min.js"></script>
	<!-- icheck -->
	<script
		src="/admin/js/icheck/icheck.min.js"></script>

	<script src="/admin/js/custom.js"></script>


	<!-- Datatables -->
	<!-- <script src="js/datatables/js/jquery.dataTables.js"></script>
  <script src="js/datatables/tools/js/dataTables.tableTools.js"></script> -->

	<!-- Datatables-->
	<script
		src="/admin/js/datatables/jquery.dataTables.min.js"></script>
	<script
		src="/admin/js/datatables/dataTables.bootstrap.js"></script>
	<script
		src="/admin/js/datatables/dataTables.buttons.min.js"></script>
	<script
		src="/admin/js/datatables/buttons.bootstrap.min.js"></script>
	<script
		src="/admin/js/datatables/jszip.min.js"></script>
	<script
		src="/admin/js/datatables/pdfmake.min.js"></script>
	<script
		src="/admin/js/datatables/vfs_fonts.js"></script>
	<script
		src="/admin/js/datatables/buttons.html5.min.js"></script>
	<script
		src="/admin/js/datatables/buttons.print.min.js"></script>
	<script
		src="/admin/js/datatables/dataTables.fixedHeader.min.js"></script>
	<script
		src="/admin/js/datatables/dataTables.keyTable.min.js"></script>
	<script
		src="/admin/js/datatables/dataTables.responsive.min.js"></script>
	<script
		src="/admin/js/datatables/responsive.bootstrap.min.js"></script>
	<script
		src="/admin/js/datatables/dataTables.scroller.min.js"></script>


	<!-- pace -->
	<script
		src="/admin/js/pace/pace.min.js"></script>
	<script>
		var handleDataTableButtons = function() {
			"use strict";
			0 !== $("#datatable-buttons").length
					&& $("#datatable-buttons").DataTable({
						dom : "Bfrtip",
						buttons : [ {
							extend : "copy",
							className : "btn-sm"
						}, {
							extend : "csv",
							className : "btn-sm"
						}, {
							extend : "excel",
							className : "btn-sm"
						}, {
							extend : "pdf",
							className : "btn-sm"
						}, {
							extend : "print",
							className : "btn-sm"
						} ],
						responsive : !0
					})
		}, TableManageButtons = function() {
			"use strict";
			return {
				init : function() {
					handleDataTableButtons()
				}
			}
		}();
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#datatable').dataTable();
			$('#datatable-keytable').DataTable({
				keys : true
			});
			$('#datatable-responsive').DataTable();
			$('#datatable-scroller').DataTable({
				ajax : "js/datatables/json/scroller-demo.json",
				deferRender : true,
				scrollY : 380,
				scrollCollapse : true,
				scroller : true
			});
			var table = $('#datatable-fixed-header').DataTable({
				fixedHeader : true
			});
		});
		TableManageButtons.init();
	</script>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script>
		$(document)
				.ready(
						function() {

							var categoryId = $("#category").val();
							var selectedSubCategory = "${item.subCategory.subCategoryId}";

							if (categoryId != "") {

								$
										.ajax({

											url : "/getSubCategories",
											type : "GET",
											data : {
												categoryId : categoryId
											},

											success : function(data) {

												$("#subCategorySelect")
														.html(
																"<option value=''>Select SubCategory</option>");

												$
														.each(
																data,
																function(i, sub) {

																	var selected = "";

																	if (sub.subCategoryId == selectedSubCategory) {
																		selected = "selected";
																	}

																	$(
																			"#subCategorySelect")
																			.append(
																					"<option value='"+sub.subCategoryId+"' "+selected+">"
																							+ sub.subCategoryName
																							+ "</option>");

																});

											}

										});

							}

						});
	</script>
	
</body>

</html>

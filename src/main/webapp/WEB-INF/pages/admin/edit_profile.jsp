<%-- 
    Document   : Add_Banner
    Created on : Jul 31, 2018, 9:50:43 AM
    Author     : APTA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Panel |</title>

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

				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="dashboard_graph">
							<c:if test="${not empty Error}">
								<p style="color: red">${Error }</p>
							</c:if>
							<c:if test="${not empty msg}">
								<p style="color: green">${msg }</p>
							</c:if>

							<div class="row x_title">
								<div class="col-md-6">
									<h3>
										Admin Panel <small><a
											href="/change_Password"><button
													class="btn-lg btn btn-outline btn-success">Change
													Password</button></a></small> <small><a
											href="/Logout"><button
													class="btn-lg btn btn-outline btn-danger">Log Out</button></a></small>

									</h3>
								</div>
								<div class="col-md-6"></div>
							</div>

							<div class="x_panel">
								<div class="x_title">
									<h2>General Information</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>

										<li><a class="close-link"><i class="fa fa-close"></i></a>
										</li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">



									<form action="/editAdmin"
										method="post" class="form-horizontal form-label-left"
										enctype="multipart/form-data" novalidate>

										<span class="section">Personal Info</span>
										<table class="table table-responsive">
											<input type="hidden" name="adminId"
												value="${sessionScope.LoggedInAdmin.adminId}" />
											<tr>
												<td>Name</td>
												<td><input type="text" name="name" id="name"
													pattern="([A-Za-z .])+"
													value="${sessionScope.LoggedInAdmin.name}"
													class="form-control"></td>
											</tr>
											<tr>
												<td>Email</td>
												<td><input type="text" name="email" id="email"
													readonly="true" value="${sessionScope.LoggedInAdmin.email}"
													class="form-control"></td>
											</tr>
											<tr>
												<td>Image</td>
												<td><img
													src="/uploads/${sessionScope.LoggedInAdmin.image}?v=${System.currentTimeMillis()}"
													name="image" style="width: 100px; height: 100px;"></td>
											</tr>
											<tr>
												<td>File Name</td>
												<td><input type="file" name="file"
													value="${sessionScope.LoggedInAdmin.image} class=" form-control"/></td>
											</tr>

											<tr>
												<td>Mobile</td>
												<td><input type="text" id="telephone" name="mobile"
													pattern="[6-9][0-9]{9}"
													value="${sessionScope.LoggedInAdmin.mobile}"
													data-validate-length-range="10" class="form-control"></td>
											</tr>
											<tr>
												<td>Address</td>
												<td><input type="text" id="address" name="address"
													value="${sessionScope.LoggedInAdmin.address}"
													class="form-control"></td>
											</tr>
											<tr>
												<td></td>
												<td>
													<button type="reset" class="btn btn-primary">Reset</button>
													<button id="send" type="submit" class="btn btn-success">Submit</button>
												</td>
											</tr>
										</table>
									</form>

								</div>
							</div>


						</div>
					</div>

					<script type="text/javascript">
						$(document).ready(
								function() {
									$('#birthday').daterangepicker(
											{
												singleDatePicker : true,
												calender_style : "picker_4"
											},
											function(start, end, label) {
												console.log(
														start.toISOString(),
														end.toISOString(),
														label);
											});
								});
					</script>




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
	<!-- pace -->
	<script
		src="/admin/js/pace/pace.min.js"></script>
	<script src="/admin/js/custom.js"></script>
	<!-- form validation -->
	<script
		src="/admin/js/validator/validator.js"></script>
	<script>
		// initialize the validator function
		validator.message['date'] = 'not a real date';

		// validate a field on "blur" event, a 'select' on 'change' event & a '.reuired' classed multifield on 'keyup':
		$('form').on('blur',
				'input[required], input.optional, select.required',
				validator.checkField).on('change', 'select.required',
				validator.checkField).on('keypress',
				'input[required][pattern]', validator.keypress);

		$('.multi.required').on('keyup blur', 'input', function() {
			validator.checkField.apply($(this).siblings().last()[0]);
		});

		// bind the validation to the form submit event
		//$('#send').click('submit');//.prop('disabled', true);

		$('form').submit(function(e) {
			e.preventDefault();
			var submit = true;
			// evaluate the form using generic validaing
			if (!validator.checkAll($(this))) {
				submit = false;
			}

			if (submit)
				this.submit();
			return false;
		});

		/* FOR DEMO ONLY */
		$('#vfields').change(function() {
			$('form').toggleClass('mode2');
		}).prop('checked', false);

		$('#alerts').change(function() {
			validator.defaults.alerts = (this.checked) ? false : true;
			if (this.checked)
				$('form .alert').remove();
		}).prop('checked', false);
	</script>
	<script
		src="/admin/js/bootstrap.min.js"></script>

	<!-- gauge js -->

	<script type="text/javascript"
		src="/admin/js/datepicker/daterangepicker.js"></script>

</body>

</html>

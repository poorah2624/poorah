<%-- 
    Document   : txt
    Created on : Aug 2, 2018, 12:22:15 PM
    Author     : APTA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<link
	href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/admin/fonts/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/admin/css/animate.min.css"
	rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="${pageContext.request.contextPath}/admin/css/custom.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/admin/css/icheck/flat/green.css"
	rel="stylesheet">
<!-- editor -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/admin/css/editor/external/google-code-prettify/prettify.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/admin/css/editor/index.css"
	rel="stylesheet">
<!-- select2 -->
<link
	href="${pageContext.request.contextPath}/admin/css/select/select2.min.css"
	rel="stylesheet">
<!-- switchery -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/admin/css/switchery/switchery.min.css" />

<script src="${pageContext.request.contextPath}/admin/js/jquery.min.js"></script>

<!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

<style>
.panel-body h4 {
	color: gray;
}
</style>

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
							<h3>Testimonial</h3>
						</div>

					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">





							<div class="col-md-12 col-sm-12 col-xs-12">

								<div class="x_panel">
									<div class="x_title">
										<h2>
											Users <small>Testimonial</small>
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
										<table class="table table-bordered">
											<thead>
												<tr>
													<th>Name</th>
													<th>Item</th>
													<th>Rating</th>
													<th>Review</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
											</thead>

											<tbody>
												<c:forEach var="t" items="${reviews}">

													<tr>

														<input type="hidden" name="reviewId"
															value="${t.reviewId }">

														<td>
															<div class="col-md-8">

																<c:choose>
																	<c:when test="${not empty t.user}">
                                                                            ${t.user.userName}
                                                                     </c:when>
																	<c:otherwise>
                                                                          ${t.guestName}
                                                                    </c:otherwise>
																</c:choose>
															</div>
														</td>
														<td>${t.item.itemName} <br /> <small>(ID:
																${t.item.itemId})</small>
														</td>
														<td>
															<div class="col-md-8">${t.rating }</div>
														</td>
														<td>
															<div class="col-md-8">${t.message }></div>
														</td>
														<!-- STATUS -->
														<td><c:choose>
																<c:when test="${t.status == 'approved'}">
																	<span class="btn btn-success btn-xs">Approved</span>
																</c:when>
																<c:otherwise>
																	<span class="btn btn-warning btn-xs">Pending</span>
																</c:otherwise>
															</c:choose></td>

														<!-- ACTION -->
														<td>
															<!-- APPROVE BUTTON --> <c:if
																test="${t.status != 'approved'}">
																<a
																	href="${pageContext.request.contextPath}/activateTestimonial?reviewId=${t.reviewId}">
																	<button class="btn btn-primary btn-xs">Approve</button>
																</a>
															</c:if> <!-- DELETE --> <a
															href="${pageContext.request.contextPath}/deleteReview?reviewId=${t.reviewId}"
															onclick="return confirm('Sure Want?');">
																<button class="btn btn-danger btn-xs">Delete</button>
														</a>

														</td>

													</tr>
												</c:forEach>
											</tbody>

										</table>
									</div>
								</div>


							</div>
							<div class="clearfix"></div>

						</div>
						<br />

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

	</div>

	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script
		src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js"></script>

	<!-- bootstrap progress js -->
	<script
		src="${pageContext.request.contextPath}/admin/js/progressbar/bootstrap-progressbar.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/admin/js/nicescroll/jquery.nicescroll.min.js"></script>
	<!-- icheck -->
	<script
		src="${pageContext.request.contextPath}/admin/js/icheck/icheck.min.js"></script>
	<!-- tags -->
	<script
		src="${pageContext.request.contextPath}/admin/js/tags/jquery.tagsinput.min.js"></script>
	<!-- switchery -->
	<script
		src="${pageContext.request.contextPath}/admin/js/switchery/switchery.min.js"></script>
	<!-- daterangepicker -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/js/moment/moment.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/js/datepicker/daterangepicker.js"></script>
	<!-- richtext editor -->
	<script
		src="${pageContext.request.contextPath}/admin/js/editor/bootstrap-wysiwyg.js"></script>
	<script
		src="${pageContext.request.contextPath}/admin/js/editor/external/jquery.hotkeys.js"></script>
	<script
		src="${pageContext.request.contextPath}/admin/js/editor/external/google-code-prettify/prettify.js"></script>
	<!-- select2 -->
	<script
		src="${pageContext.request.contextPath}/admin/js/select/select2.full.js"></script>
	<!-- form validation -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/js/parsley/parsley.min.js"></script>
	<!-- textarea resize -->
	<script
		src="${pageContext.request.contextPath}/admin/js/textarea/autosize.min.js"></script>
	<script>
		autosize($('.resizable_textarea'));
	</script>
	<!-- Autocomplete -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/js/autocomplete/countries.js"></script>
	<script
		src="${pageContext.request.contextPath}/admin/js/autocomplete/jquery.autocomplete.js"></script>
	<!-- pace -->
	<script
		src="${pageContext.request.contextPath}/admin/js/pace/pace.min.js"></script>
	<script type="text/javascript">
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
	</script>
	<script src="${pageContext.request.contextPath}/admin/js/custom.js"></script>


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
</body>

</html>


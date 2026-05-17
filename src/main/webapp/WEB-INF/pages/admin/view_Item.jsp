<%-- 
    Document   : Add_Banner
    Created on : Jul 31, 2018, 9:50:43 AM
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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Panel | View Items</title>

<!-- Bootstrap core CSS -->
<link href="/admin/css/bootstrap.min.css" rel="stylesheet">
<link href="/admin/fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/animate.min.css" rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="/admin/css/custom.css" rel="stylesheet">
<link href="/admin/css/icheck/flat/green.css" rel="stylesheet">

<link href="/admin/js/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
<link href="/admin/js/datatables/buttons.bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/admin/js/datatables/fixedHeader.bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/admin/js/datatables/responsive.bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/admin/js/datatables/scroller.bootstrap.min.css" rel="stylesheet" type="text/css" />

<script src="/admin/js/jquery.min.js"></script>
</head>

<body class="nav-md">

	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<jsp:include page="include/header.jsp"></jsp:include>
					<!-- sidebar menu -->
					<jsp:include page="include/sidebar.jsp"></jsp:include>
				</div>
			</div>

			<!-- top navigation -->
			<jsp:include page="include/nav.jsp"></jsp:include>

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="dashboard_graph">

							<div class="row x_title">
								<div class="col-md-6">
									<h3>
										View Items <small><a href="/Add_Item"><button class="btn btn-sm btn-success">Add Item</button></a></small>
									</h3>
								</div>
							</div>
							
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>View Items <small>Here</small></h2>
										<div class="clearfix"></div>
									</div>
									<div class="x_content" style="overflow-x: auto; width: 100%;">

										<table id="datatable" class="table table-striped table-bordered">
											<thead>
												<tr>
													<th>Category Name</th>
													<th>Sub-Category Name</th>
													<th>SKU Id</th>
													<th>Item Image</th>
													<th>Item Name</th>
													<th>Price (₹)</th>
													<th>Discount %</th>
													<th>Weight</th>
													<th>Fabric</th>
													<th>Variants & Stock</th>
													<th>Status</th>
													<th>Edit</th>
													<th>Delete</th>
												</tr>
											</thead>

											<tbody>
												<c:forEach var="i" items="${items}">
													<tr>
														<td>${i.category.categoryName}</td>
														<td>${i.subCategory.subCategoryName}</td>
														<td>${i.skuId}</td>
														<td>
															<c:if test="${not empty i.itemImage}">
																<img src="${fn:split(i.itemImage, ',')[0]}" style="width: 60px; height: 60px; object-fit: cover;">
															</c:if>
														</td>
														<td>${i.itemName}</td>
														<td>₹ ${i.itemPrice}/-</td>
														<td>${i.discount}%</td>
														<td>${i.weight}</td>
														<td>${i.fabric}</td>
														
														<!-- VARIANTS DISPLAY COLUMNS FOR STRING STRUCTURE (S:4,M:5...) -->
														<td>
															<c:choose>
																<c:when test="${not empty i.variants}">
																	<c:forEach var="v" items="${i.variants}">
																		<div style="border-bottom: 1px dashed #eee; padding-bottom: 5px; margin-bottom: 5px;">
																			<span class="badge badge-info" style="font-size: 11px;">${v.variantColor}</span>
																			<br/>
																			<c:set var="stockStr" value="${v.variantStock}" />
																			
																			<!-- Parsed Strings display cleanly -->
																			<small>
																				<b>S:</b> ${fn:contains(stockStr, 'S:') ? fn:substringBefore(fn:substringAfter(stockStr, 'S:'), ',M:') : '0'} | 
																				<b>M:</b> ${fn:contains(stockStr, 'M:') ? fn:substringBefore(fn:substringAfter(stockStr, 'M:'), ',L:') : '0'} | 
																				<b>L:</b> ${fn:contains(stockStr, 'L:') ? fn:substringBefore(fn:substringAfter(stockStr, 'L:'), ',XL:') : '0'} | 
																				<b>XL:</b> ${fn:contains(stockStr, 'XL:') ? fn:substringAfter(stockStr, 'XL:') : '0'}
																			</small>
																		</div>
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<span class="text-muted">N/A</span>
																</c:otherwise>
															</c:choose>
														</td>
														
														<td>
															<span class="label ${i.status == 'active' ? 'label-success' : 'label-danger'}">${i.status}</span>
														</td>
														<td>
															<a href="/edit_Item/${i.itemId}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Edit </a>
														</td>
														<td>
															<a href="/Delete_Item/${i.itemId}" class="btn btn-danger btn-xs" onclick="return confirm('Are you sure you want to delete this item?');">
																<i class="fa fa-trash-o"></i> Delete
															</a>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			
			<!-- footer content -->
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
	</div>

	<script src="/admin/js/bootstrap.min.js"></script>
	<script src="/admin/js/progressbar/bootstrap-progressbar.min.js"></script>
	<script src="/admin/js/nicescroll/jquery.nicescroll.min.js"></script>
	<script src="/admin/js/icheck/icheck.min.js"></script>
	<script src="/admin/js/custom.js"></script>

	<!-- Datatables -->
	<script src="/admin/js/datatables/jquery.dataTables.min.js"></script>
	<script src="/admin/js/datatables/dataTables.bootstrap.js"></script>
	<script src="/admin/js/pace/pace.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#datatable').dataTable({
	        "responsive": true,
	        "bStateSave": false, 
	        "order": []
	    });
	});
	</script>
</body>
</html>
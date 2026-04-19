<%-- 
    Document   : Add_Banner
    Created on : Jul 31, 2018, 9:50:43 AM
    Author     : APTA
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

  <link href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/admin/fonts/css/font-awesome.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/css/animate.min.css" rel="stylesheet">

  <!-- Custom styling plus plugins -->
  <link href="${pageContext.request.contextPath}/admin/css/custom.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/css/icheck/flat/green.css" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/admin/js/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/admin/js/datatables/buttons.bootstrap.min.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/admin/js/datatables/fixedHeader.bootstrap.min.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/admin/js/datatables/responsive.bootstrap.min.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/admin/js/datatables/scroller.bootstrap.min.css" rel="stylesheet" type="text/css" />

  <script src="${pageContext.request.contextPath}/admin/js/jquery.min.js"></script>

  <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

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

							<div class="row x_title">
								<div class="col-md-6">
                                                                    <h3>Order Management<small><a href="${pageContext.request.contextPath}/order_History"><button class="btn-lg btn btn-outline btn-success">Order History</button></a></small></h3>
								</div>
								<div class="col-md-6">

								</div>
							</div>
           <div class="col-md-12 col-sm-12 col-xs-12">
               <div class="x_panel">
                <div class="x_title">
                  <h2> Manage Order<small>Here</small></h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="container">
                    <form action="${pageContext.request.contextPath}/updateOrder" method="post" align="center">
                    
                        
                        <input type="hidden" name="orderId" value="${order.id}">
                        
                         <input type="radio" name="status" value="Packed" class="btn btn-danger"><h3>Packed</h3><br>
                        <input type="radio" name="status" value="Shipped" class="btn btn-danger"><h3>Shipped</h3><br>
                        
                        <input type="radio" name="status" value="Out for delivery" class="btn btn-warning"><h3>Out for delivery</h3><br>
                        <input type="radio" name="status" value="Delivered" class="btn btn-success"><h3>Delivered</h3><br>
                        <input type="radio" name="status" value="Cancel" class="btn btn-warning"><h3>Cancel</h3><br>
                        <input type="submit" value="Update" class="btn btn-success">
                       
                       
                    </form>
                    </div>
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
          <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
          </ul>
          <div class="clearfix"></div>
          <div id="notif-group" class="tabbed_notifications"></div>
        </div>

        <script src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js"></script>

        <!-- bootstrap progress js -->
        <script src="${pageContext.request.contextPath}/admin/js/progressbar/bootstrap-progressbar.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/nicescroll/jquery.nicescroll.min.js"></script>
        <!-- icheck -->
        <script src="${pageContext.request.contextPath}/admin/js/icheck/icheck.min.js"></script>

        <script src="${pageContext.request.contextPath}/admin/js/custom.js"></script>


        <!-- Datatables -->
        <!-- <script src="js/datatables/js/jquery.dataTables.js"></script>
  <script src="js/datatables/tools/js/dataTables.tableTools.js"></script> -->

        <!-- Datatables-->
        <script src="${pageContext.request.contextPath}/admin/js/datatables/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.bootstrap.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.buttons.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/buttons.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/jszip.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/pdfmake.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/vfs_fonts.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/buttons.html5.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/buttons.print.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.fixedHeader.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.keyTable.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.responsive.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/responsive.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/datatables/dataTables.scroller.min.js"></script>


        <!-- pace -->
        <script src="${pageContext.request.contextPath}/admin/js/pace/pace.min.js"></script>
        <script>
          var handleDataTableButtons = function() {
              "use strict";
              0 !== $("#datatable-buttons").length && $("#datatable-buttons").DataTable({
                dom: "Bfrtip",
                buttons: [{
                  extend: "copy",
                  className: "btn-sm"
                }, {
                  extend: "csv",
                  className: "btn-sm"
                }, {
                  extend: "excel",
                  className: "btn-sm"
                }, {
                  extend: "pdf",
                  className: "btn-sm"
                }, {
                  extend: "print",
                  className: "btn-sm"
                }],
                responsive: !0
              })
            },
            TableManageButtons = function() {
              "use strict";
              return {
                init: function() {
                  handleDataTableButtons()
                }
              }
            }();
        </script>
        <script type="text/javascript">
          $(document).ready(function() {
            $('#datatable').dataTable();
            $('#datatable-keytable').DataTable({
              keys: true
            });
            $('#datatable-responsive').DataTable();
            $('#datatable-scroller').DataTable({
              ajax: "js/datatables/json/scroller-demo.json",
              deferRender: true,
              scrollY: 380,
              scrollCollapse: true,
              scroller: true
            });
            var table = $('#datatable-fixed-header').DataTable({
              fixedHeader: true
            });
          });
          TableManageButtons.init();
        </script>
</body>

</html>

<%-- 
    Document   : invoice
    Created on : Aug 9, 2018, 12:34:09 PM
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

  <title>Admin Panel | </title>

  <!-- Bootstrap core CSS -->

  <link href="admin/css/bootstrap.min.css" rel="stylesheet">

  <link href="admin/fonts/css/font-awesome.min.css" rel="stylesheet">
  <link href="admin/css/animate.min.css" rel="stylesheet">

  <!-- Custom styling plus plugins -->
  <link href="admin/css/custom.css" rel="stylesheet">
  <link href="admin/css/icheck/flat/green.css" rel="stylesheet">


  <script src="admin/js/jquery.min.js"></script>

  <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

</head>


<body>

  <div class="container body">


    <div class="main_container">


      <!-- top navigation -->
    
      <!-- /top navigation -->

      <!-- page content -->
      <div class="right_col" role="main">

        <div class="">
      
          <div class="clearfix"></div>

          <div class="row">
            <div class="col-md-12">
              <div class="x_panel">
                <div class="x_title">
                    <h2>Invoice<small> <a href="order_History" class="btn btn-success btn-lg"> Go back..!</a></small>
                      <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button>
                       </h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                 
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">

                  <section class="content invoice">
                    <!-- title row -->
                    <div class="row">
                      <div class="col-xs-12 invoice-header">
                        <h1>
                                        <i class="fa fa-globe"></i> Invoice.
                                        <small class="pull-right">Date: 16/08/2018</small>
                                         </h1>
                      </div>
                      <!-- /.col -->
                    </div>
                    <!-- info row -->
                    <div class="row invoice-info">
                      <div class="col-sm-4 invoice-col">
                        From
                        <address>
                                        <strong>xyz Admin, Inc.</strong>
                                        <br>795 Freedom Ave, Suite 600
                                        <br>New Delhi, IN 94107
                                        <br>Phone: 1800-1800-1800
                                        <br>Email: admin.com
                                    </address>
                      </div>
                      <!-- /.col -->
                      <div class="col-sm-4 invoice-col">
                        To
                        <address>
                                        <strong>Maninder Duhan</strong>
                                        <br>795 Freedom Ave, Suite 600
                                        <br>Panipat, Haryana 94107
                                        <br>Phone: +91 999999999
                                        <br>Email: xyz@hsjsh.com
                                    </address>
                      </div>
                      <!-- /.col -->
                      <div class="col-sm-4 invoice-col">
                        <b>Invoice #007612</b>
                        <br>
                        <br>
                        <b>Order ID:</b> 4F3S8J
                        <br>
                        <b>Payment Due:</b> 2/22/2019
                        <br>
                        <b>Account No:</b> 968-34567
                      </div>
                      <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <!-- Table row -->
                    <div class="row">
                      <div class="col-xs-12 table">
                        <table class="table table-striped">
                          <thead>
                            <tr>
                              <th>Quantity</th>
                              <th>Product</th>
                              <th>Product Serial #</th>
                              <th style="width: 59%">Vendor name</th>
                              <th>Subtotal</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td>1</td>
                              <td>Call of Duty</td>
                              <td>455-981-221</td>
                               <td> Micro INC</td>
                            
                              </td>
                              <td>&#8377 64.50</td>
                            </tr>
                            <tr>
                              <td>6</td>
                              <td>Need for Speed IV</td>
                              <td>247-925-726</td>
                                <td>Nokia INC</td>
                            
                              <td>&#8377 50.00</td>
                            </tr>
                            <tr>
                              <td>6</td>
                              <td>Monsters DVD</td>
                              <td>735-845-642</td>
                               <td> Apple INC</td>
                            
                              <td>&#8377 10.70</td>
                            </tr>
                            <tr>
                              <td>1</td>
                              <td>Grown Ups Blue Ray</td>
                              <td>422-568-642</td>
                              <td> Google INC</td>
                              <td>&#8377 25.99</td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                      <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <div class="row">
                      <!-- accepted payments column -->
                   
                      <!-- /.col -->
                      <div class="col-xs-6">
                        <p class="lead">Amount Due 2/22/2019</p>
                        <div class="table-responsive">
                          <table class="table">
                            <tbody>
                              <tr>
                                <th style="width:50%">Subtotal:</th>
                                <td>&#8377 250.30/-</td>
                              </tr>
                              <tr>
                                <th>Tax (9.3%)</th>
                                <td>&#8377 10.34</td>
                              </tr>
                              <tr>
                                <th>Shipping:</th>
                                <td>&#8377 5.80</td>
                              </tr>
                              <tr>
                                <th>Total:</th>
                                <td>&#8377 265.24</td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                      <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <!-- this row will not appear when printing -->
                    <div class="row no-print">
                      <div class="col-xs-12">
                          <a href="order_History.jsp" class="btn btn-success pull-right"><i class="fa fa-credit-card"></i> Go back</a>
                        <button class="btn btn-primary pull-right" onclick="window.print();" style="margin-right: 5px;"><i class="fa fa-download"></i>Print</button>
                      </div>
                    </div>
                  </section>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- footer content -->

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

  <script src="admin/js/bootstrap.min.js"></script>

  <!-- bootstrap progress js -->
  <script src="admin/js/progressbar/bootstrap-progressbar.min.js"></script>
  <script src="admin/js/nicescroll/jquery.nicescroll.min.js"></script>
  <!-- icheck -->
  <script src="admin/js/icheck/icheck.min.js"></script>

  <script src="admin/js/custom.js"></script>

  <!-- pace -->
  <script src="admin/js/pace/pace.min.js"></script>
</body>

</html>

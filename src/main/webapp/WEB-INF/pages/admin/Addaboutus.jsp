<%-- 
    Document   : txt
    Created on : Aug 2, 2018, 12:22:15 PM
    Author     : APTA
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<%@ page import="springStarter.models.AboutUs" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>PooRah Admin Panel </title>

  <!-- Bootstrap core CSS -->

  <link href="/admin/css/bootstrap.min.css" rel="stylesheet">

  <link href="/admin/fonts/css/font-awesome.min.css" rel="stylesheet">
  <link href="/admin/css/animate.min.css" rel="stylesheet">

  <!-- Custom styling plus plugins -->
  <link href="/admin/css/custom.css" rel="stylesheet">
  <link href="/admin/css/icheck/flat/green.css" rel="stylesheet">
  <!-- editor -->
  <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
  <link href="/admin/css/editor/external/google-code-prettify/prettify.css" rel="stylesheet">
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
function fileValidation(){
    var fileInput = document.getElementById('file');
    var filePath = fileInput.value;
    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
    if(!allowedExtensions.exec(filePath)){
        alert('Please upload file having extensions .jpeg/.jpg/.png/.gif only.');
        fileInput.value = '';
        return false;
    }else{
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
              <h3>Update About Us</h3>
            </div>
          
          </div>
          <div class="clearfix"></div>
          <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
              




          <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Update About Us<small>Here</small></h2>
                <ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>
                
                  <li><a class="close-link"><i class="fa fa-close"></i></a>
                  </li>
                </ul>
                <div class="clearfix"></div>
              </div>
              <div class="x_content">
                  <form action ="/UpdateAboutUs" method="post" name="my_form" enctype="multipart/form-data" class="form-horizontal form-label-left" onSubmit="document.my_form.editor_contents.value = $('#editor').html()" >
                    
                    <input type="hidden" name="aId" value="${aboutUs.aId != null ? aboutUs.aId : ''}"/>
                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="title">Page Name <span class="required">*</span>
                      </label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="title" pattern="([A-Za-z .])+" name="aName" title="Enter Words Only" value="${aboutUs.aName }" required="required" placeholder="Enter Title here" class="form-control col-md-7 col-xs-12">
                      </div>
                    </div> 
                      
                      <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="title">Image <span class="required">*</span>
                      </label>
                      <c:if test="${not empty aboutUs.aImage}">
                      <div class="col-md-6 col-sm-6 col-xs-12">
                          <img src="/uploads/${aboutUs.aImage }" name="aImage" style="width:150px;height:150px;"/>
                          <input type="file" id="title" name="aImage"  class="form-control col-md-7 col-xs-12">
                      </div>
                      </c:if>
                    </div> 
                      
                 
                       <!--   <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  for="descr">Add Description below: 
                      </label>
                           <br>
               
                
                <textarea name="aDesc" class="form-control col-md-8">${aboutUs.aDesc }</textarea>
                         </div>-->
                <br />
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

	</div>

	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
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
  <script type="text/javascript" src="/admin/js/datepicker/daterangepicker.js"></script>
  <!-- richtext editor -->
  <script src="/admin/js/editor/bootstrap-wysiwyg.js"></script>
  <script src="/admin/js/editor/external/jquery.hotkeys.js"></script>
  <script src="/admin/js/editor/external/google-code-prettify/prettify.js"></script>
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
  <script type="text/javascript" src="/admin/js/autocomplete/countries.js"></script>
  <script src="/admin/js/autocomplete/jquery.autocomplete.js"></script>
  <!-- pace -->
  <script src="/admin/js/pace/pace.min.js"></script>
  <script type="text/javascript">
    $(function() {
      'use strict';
      var countriesArray = $.map(countries, function(value, key) {
        return {
          value: value,
          data: key
        };
      });
      // Initialize autocomplete with custom appendTo:
      $('#autocomplete-custom-append').autocomplete({
        lookup: countriesArray,
        appendTo: '#autocomplete-container'
      });
    });
  </script>
  <script src="/admin/js/custom.js"></script>


  <!-- select2 -->
  <script>
    $(document).ready(function() {
      $(".select2_single").select2({
        placeholder: "Select a state",
        allowClear: true
      });
      $(".select2_group").select2({});
      $(".select2_multiple").select2({
        maximumSelectionLength: 4,
        placeholder: "With Max Selection limit 4",
        allowClear: true
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
        width: 'auto'
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
    } catch (err) {}
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
        var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
            'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
            'Times New Roman', 'Verdana'
          ],
          fontTarget = $('[title=Font]').siblings('.dropdown-menu');
        $.each(fonts, function(idx, fontName) {
          fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
        });
        $('a[title]').tooltip({
          container: 'body'
        });
        $('.dropdown-menu input').click(function() {
            return false;
          })
          .change(function() {
            $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
          })
          .keydown('esc', function() {
            this.value = '';
            $(this).change();
          });

        $('[data-role=magic-overlay]').each(function() {
          var overlay = $(this),
            target = $(overlay.data('target'));
          overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
        });
        if ("onwebkitspeechchange" in document.createElement("input")) {
          var editorOffset = $('#editor').offset();
          $('#voiceBtn').css('position', 'absolute').offset({
            top: editorOffset.top,
            left: editorOffset.left + $('#editor').innerWidth() - 35
          });
        } else {
          $('#voiceBtn').hide();
        }
      };

      function showErrorAlert(reason, detail) {
        var msg = '';
        if (reason === 'unsupported-file-type') {
          msg = "Unsupported format " + detail;
        } else {
          console.log("error uploading file", reason, detail);
        }
        $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
          '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
      };
      initToolbarBootstrapBindings();
      $('#editor').wysiwyg({
        fileUploadError: showErrorAlert
      });
      window.prettyPrint && prettyPrint();
    });
  </script>
  <!-- /editor -->
</body>

</html>

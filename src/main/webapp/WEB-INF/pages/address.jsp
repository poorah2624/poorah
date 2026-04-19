<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="head.jsp"%>
</head>

<body>

<%@include file="header.jsp"%>



<div class="breadcrumb_dress">
    <div class="container">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/home">
                    <span class="glyphicon glyphicon-home"></span> Home
                </a> 
                <i>/</i>
            </li>
            <li>My Addresses</li>
        </ul>
    </div>
</div>

<br><br>

<div class="user-profile">
    <div class="container">

        <h2 style="text-align:center;">Saved Addresses</h2>

        <!-- ADD NEW ADDRESS BUTTON -->
        <div style="text-align:right; margin-bottom:15px;">
            <a href="${pageContext.request.contextPath}/addAddress"
               class="btn btn-primary">
               + Add New Address
            </a>
        </div>

        <!-- ADDRESS LIST -->
        <c:forEach var="addr" items="${addresses}">

            <div class="col-md-12">
                <table class="table table-bordered">

                    <tr>
                        <th><h4>Name</h4></th>
                        <td><h5>${addr.fullName}</h5></td>
                    </tr>

                    <tr>
                        <th><h4>Mobile</h4></th>
                        <td><h5>${addr.mobile}</h5></td>
                    </tr>

                    <tr>
                        <th><h4>Address</h4></th>
                        <td>
                            <h5>
                                ${addr.houseNo }
                                ${addr.area}, ${addr.city}, 
                                ${addr.state} - ${addr.pincode}
                            </h5>
                        </td>
                    </tr>

                    <tr>
                        <th><h4>Type</h4></th>
                        <td><h5>${addr.addressType}</h5></td>
                    </tr>

                    <!-- ACTION BUTTONS -->
                    <tr>
                        <th></th>
                        <td>
                            <a href="${pageContext.request.contextPath}/editAddress/${addr.addressId}"
                               class="btn btn-success">
                               Edit
                            </a>

                            <a href="${pageContext.request.contextPath}/deleteAddress/${addr.addressId}"
                               class="btn btn-danger"
                               onclick="return confirm('Delete this address?')">
                               Delete
                            </a>
                        </td>
                    </tr>

                </table>
            </div>

        </c:forEach>

        <!-- NO ADDRESS -->
        <c:if test="${empty addresses}">
            <h4 style="text-align:center; color:gray;">
                No address found. Please add one.
            </h4>
        </c:if>

    </div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>
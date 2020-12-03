<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer List Report PDF</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	text-align: left;
	padding: 2px;
	font-size: 10;
}

th {
	background-color: #EA3291;
	color: white;
}
</style>
</head>
<body>

	<h4 align="center">Customer List Report</h4>
	<div align="center">
		<h6>${frName}</h6>
	</div>
	<table width="100%" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr>
				<th style="text-align: center;">Sr no.</th>
				<th style="text-align: center;">Customer Name</th>
				<th style="text-align: center;">Contact Number</th>
				<th style="text-align: center;">Bill Date</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach items="${data}" var="user" varStatus="count">
				<tr>
					<td align="center"><c:out value="${count.index+1}" /></td>

					<td><c:out value="${user.user}" /></td>
					<td><c:out value="${user.mobile}" /></td>
					<td><c:out value="${user.billDate}" /></td>

				</tr>
			</c:forEach>
		</tbody>
	</table>




</body>
</html>
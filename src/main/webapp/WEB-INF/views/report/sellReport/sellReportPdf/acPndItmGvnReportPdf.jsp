<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GVN Report</title>

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
<body onload="myFunction()">
<h4 align="center">A/c Pending Item Wise Grn Gvn Report</h4>
<div align="center"> <h6>  ${frName} &nbsp;&nbsp;&nbsp;&nbsp;From &nbsp; ${fromDate}  &nbsp;To &nbsp; ${toDate}</h6></div>
	<table width="100%" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th style="text-align: center;">Sr no.</th>
				<th style="text-align: center;">GRN GVN SrNo.</th>
				<th style="text-align: center;">Type</th>
				<th style="text-align: center;">GRN GVN Date</th>
				<th style="text-align: center;">Item Name</th>
				<th style="text-align: center;">Qty.</th>
				<th style="text-align: center;">GRN GVN Status</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${report}" var="report" varStatus="count">
				<tr>
					<td align="center"><c:out value="${count.index+1}" /></td>
					<td><c:out value="${report.grngvnSrno}" /></td>
					<td><c:out value="${report.isGrn == 1 ? 'Yes' : 'No'}" /></td>
					<td><c:out value="${report.grngvnDate}" /></td>
					<td><c:out value="${report.itemName}" /></td>
					<td><c:out value="${report.grnGvnQty}" /></td>
					<td><c:out
							value="${report.grngvnStatus == 1 ? 'Pending' : report.grngvnStatus == 2 ? 'Approved By Gate' :
								report.grngvnStatus == 3 ? 'Reject By Gate' : report.grngvnStatus == 4 ? 'Approved By Store' :
								report.grngvnStatus == 5 ? 'Reject By Store' : report.grngvnStatus == 6 ? 'Approved By Acc' :
								report.grngvnStatus == 7 ? 'Reject By Acc' : ''}" /></td>
					



				</tr>
			</c:forEach>

		</tbody>
	</table>


</body>
</html>
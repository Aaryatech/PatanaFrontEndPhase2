<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Monginis</title>
<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>

<script>
	$(function() {
		$("#fromdatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
	$(function() {
		$("#todatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
</script>
<!--datepicker-->
<link href="/ops/resources/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.mCustomScrollbar.css">
	
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/customerBill/chosen.css">
</head>
<body>
	<div class="sidebarOuter"></div>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>
		<div class="fullGrid center">
			<div class="wrapperIn2">

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>
		<form name="frm_search" id="frm_search" method="get"	action="showGrnItem">
				<div class="sidebarright">
		<div class="">
	<br>
		<div class="col1" style="width: 10%;">
		   Search By: 
		</div>
		<c:set var="sts1" value=""/><c:set var="sts2" value=""/>
	   <div class="col1" style="width: 15.333333%">
		   <select name="searchType" style="width: 150px;" required="required" id="searchType" onchange="onTypeChange(this.value)"
			class="chosen-select" data-rule-required="true" data-show-subtext="true" data-live-search="true">
			<option selected value="">Select Type</option>
			<c:choose>
			<c:when test="${searchType==1}">
			   <c:set var="sts2" value="display: none;"/>
			   <option value="1" selected >Expiry Date</option>   
			   <option value="2">Items</option>
			</c:when>
			<c:when test="${searchType==2}">
			  <c:set var="sts1" value="display: none;"/>
			   <option value="1">Expiry Date</option>   
			   <option value="2" selected>Items</option>
			</c:when>
			<c:otherwise>
			   <c:set var="sts1" value="display: none;"/>
			   <c:set var="sts2" value="display: none;"/>
			   <option value="1">Expiry Date</option>   
			   <option value="2">Items</option>
			</c:otherwise>
			</c:choose>
			 
		    </select>
		</div>
		<div class="col1" id="items" style="${sts2}">
			 	<select name="itemId" id="itemId" style=" width:450px;" multiple="multiple"  class="chosen-select"  data-show-subtext="true" data-live-search="true">
								<option value=""style="text-align:left;">Select Items</option>
								
	                            <c:forEach items="${itemList}" var="item" varStatus="count">
	                            <c:set var="status" value="" />
	                            <c:forTokens items="${itemId}" delims="," var="id">
                                  <c:if test="${id==item.id}">
                                  <c:set var="status" value="selected" />
                                  </c:if>
                                </c:forTokens>
	                               <option value="${item.id}" ${status} style="text-align:left;">${item.itemName}</option>
	                            </c:forEach>
					</select>
		</div>
		<div class="col1" id="expDate" style="${sts1}">
		<input id="fromdatepicker"  class="texboxitemcode texboxcal " style=" width:250px;" autocomplete="off" placeholder="Expiry Date"  name="expiry_date" type="text" value="${expiryDate}" >	 
		</div>
		 <div class="col1">
			<input type="submit" name="" class="buttonsaveorder" value="Search" >
							</div>
         </div>
					<div class="cd-tabs">
					<div class="clearfix"></div>
				<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden">
						 </div>
							<div class="table-wrap">
						<table id="table_grid" class="main-table" >
							<thead>
								<tr class="bgpink">
												    <th width="138" style="width: 18px" align="left">No</th>
													<th class="col-md-1">Item Name</th>
													<th class="col-md-1">Invoice No</th>
													<th class="col-md-1">Bill Date</th>
													<th class="col-md-1">Group</th>
													<th class="col-md-1">Order Qty</th>
													<th class="col-md-1">Billed Qty</th>
													<th class="col-md-1">MRP</th>
													<th class="col-md-1">Rate</th>
													<th class="col-md-1">GRN Type</th>
											</tr>
											</thead>				
							<tbody>
								<c:forEach items="${billDetailsList}" var="billDetailsList" varStatus="count">
												<tr>
													<td class="col-md-1" ><c:out value="${count.index+1}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.itemName}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.remark}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.billDate}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.catName}" /></td>
													<td class="col-md-1" ><c:out value="${billDetailsList.orderQty}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.billQty}" /></td>
                                                         <fmt:formatNumber var="formattedmrp" type="number" minFractionDigits="2" maxFractionDigits="2" value="${billDetailsList.mrp}" />
                                                         <c:set var="formattedmrp" value="${formattedmrp}" />
													<td class="col-md-1"><c:out value="${formattedmrp}" /></td>
                                                         <fmt:formatNumber var="formattedrate" type="number" minFractionDigits="2" maxFractionDigits="2" value="${billDetailsList.baseRate}" />
                                                         <c:set var="formattedrate" value="${formattedrate}" />													
													<td class="col-md-1"align="right"><c:out value="${formattedrate}" /></td>
													
								            <td class="col-md-1"align="left">
											<c:choose>
											<c:when test="${billDetailsList.grnType==0}">
										     <c:out value="GRN-1" />
										    </c:when>
											<c:when test="${billDetailsList.grnType==1}">
										     <c:out value="GRN-2" />
										    </c:when>
										    <c:when test="${billDetailsList.grnType==2}">
										     <c:out value="GRN-3" />
										    </c:when>
										    <c:when test="${billDetailsList.grnType==3}">
										     <c:out value="No GRN" />
										    </c:when>
										    <c:when test="${billDetailsList.grnType==4}">
										     <c:out value="GRN-3" />
										    </c:when>
										    </c:choose>
										    </td>
											</tr>
											</c:forEach>
										</tbody>
						</table>
					</div></div>
				    </div>
					</div>
				    </form>							
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/customerBill/chosen.jquery.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/customerBill/init.js"
		type="text/javascript" charset="utf-8"></script>
<script>
(function() {
  var fauxTable = document.getElementById("faux-table");
  var mainTable = document.getElementById("table_grid");
  var clonedElement = table_grid.cloneNode(true);
  var clonedElement2 = table_grid.cloneNode(true);
  clonedElement.id = "";
  clonedElement2.id = "";
  fauxTable.appendChild(clonedElement);
  fauxTable.appendChild(clonedElement2);
})();
</script>
<script type="text/javascript">
function onTypeChange(type)
{
	if(type==1)
		{
		  $("#expDate").show();
		  $("#items").hide();
		}else 	if(type==2)
			{
			 $("#items").show();
			 $("#expDate").hide();
			  document.getElementById("itemId_chosen").style="width:250px";
			}else {
				  $("#expDate").hide();
				  $("#items").hide();
			}
}
</script>
</body>
</html>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />


<%-- <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<title>Monginis</title>


<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/custom.css" rel="stylesheet" type="text/css"/>	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>	
	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--rightNav-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
	
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery("#menuzord").menuzord({
		align:"left"
	});
});
</script>
<!--rightNav-->



</head> --%>

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#todatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#fromdatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
</script>
<style>
.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 5px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button2 {background-color: red;} /* Blue */

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 60%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>
<style>
#overlay {
	position: fixed;
	display: none;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(101, 113, 119, 0.5);
	z-index: 2;
	cursor: pointer;
}

#text {
	position: absolute;
	top: 50%;
	left: 50%;
	font-size: 25px;
	color: white;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
}
</style>
<!--datepicker-->
<body onload="">
	<div id="overlay">
		<div id="text">
			Please Wait...
			<%-- <img id="loading-image1" src="${pageContext.request.contextPath}/resources/images/loader1.gif" alt="Loading..." /> --%>
		</div>
	</div>

	<c:url var="getStocktransferToHeader" value="/getStocktransferToHeader" />
	<c:url var="acceptRejectStock" value="/acceptRejectStock" />
	<c:url value="/getStocktransferHeader" var="getStocktransferHeader"></c:url>
	<div class="sidebarOuter"></div>

	<div class="wrapper">

		<!--topHeader-->

		<jsp:include page="/WEB-INF/views/include/logo.jsp">
			<jsp:param name="frDetails" value="${frDetails}" />

		</jsp:include>

		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<!--leftNav-->

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />

				</jsp:include>


				<!--leftNav-->
				<!--rightSidebar-->

				<!-- Place Actual content of page inside this div -->
				<div class="sidebarright">
				<div class="colOuter">
				 <div class="title_row_one">
					<div class="left_title">
						<h2 class="pageTitle"><i class="fa fa-file-pdf-o"></i> Stock Exchange From Franchisee </h2>
					</div>
					<%--<div class="right_content">
						<div class="date_btn">
							<button class="buttonsaveorder" onclick="searchSellBill()">Search</button>
						</div>
						
						<%
						String frmDate = session.getAttribute("fromSellBillDate").toString();
						String tDate = session.getAttribute("toSellBillDate").toString();
					%>
						<div class="date_sear">
							<div class="date_sear_txt">To Date:-</div>
							<div class="date_sear_int">
								<input id="todatepicker" class="texboxitemcode texboxcal"
								placeholder="DD-MM-YYYY" name="toDate" type="text"
								value="">
							</div>
						</div>
						
						<div class="date_sear">
							<div class="date_sear_txt">From Date:-</div>
							<div class="date_sear_int"><input id="fromdatepicker" class="texboxitemcode texboxcal"
								placeholder="DD-MM-YYYY" name="fromDate" type="text"
								value=""></div>
						</div>
					</div>
				</div> --%>
</div>

					
					<%-- <div class="row">

						<div class="col-md-2 from_date">
							<h4 class="pull-left">From Date:-</h4>
						</div>
						<div class="col-md-2 ">
							<input id="fromdatepicker" class="texboxitemcode texboxcal"
								placeholder="DD-MM-YYYY" name="fromDate" type="text"
								value="<%=frmDate%>">
						</div>
						 <div class="col-md-2">
							<h4 class="pull-left">To Date:-</h4>
						</div>
						<div class="col-md-2 ">
							<input id="todatepicker" class="texboxitemcode texboxcal"
								placeholder="DD-MM-YYYY" name="toDate" type="text"
								value="<%=tDate%>">
						</div> 
						<div class="col-md-2">
							<button class="btn search_btn pull-left"
								onclick="searchSellBill()">Search</button>
						</div> 

					</div> --%>

					<div class="row">
						<div class="col-md-12">
							<!--table-->
							<div class="clearfix"></div>


							<div id="table-scroll" class="table-scroll">
								<div id="" class="" aria="hidden">
								
									<table width="100%" border="1" cellspacing="0" cellpadding="1"
										id="table_grid1" class="main-table">
										<thead>
											<tr class="bgpink">
											<th style="text-align: center;width: 2%">Sr No.</th>
												<th style="text-align: center;">To Franchisee</th>
												<th style="text-align: center;">Date</th>
												<th style="text-align: center;">Total Amt.</th>
												<th style="text-align: center;">Action</th>
												<!-- <th style="text-align: center;">Payable Amount</th>
												<th style="text-align: center;">Paid Amount</th>
												<th style="text-align: center;">Paymode</th>
												<th style="text-align: center;">Action</th> -->
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${headList}" var="Stock" varStatus="cnt">
											<tr>
												<td>${cnt.index+1}</td>
												<td>${Stock.exVar1}</td>
												<td>${Stock.makerDate}</td>
												<td>${Stock.grandTotal}</td>
												<td style="text-align: center;" ><a onclick="editHeader(${Stock.transferId},${Stock.status})"><i class="fa fa-bars" title="Edit" aria-hidden="true"></i>
												</a></td>
											</tr>
										
										</c:forEach>

										</tbody>
									</table>
								</div>
								<div class="table-wrap">

									<!-- <table width="100%" border="1" cellspacing="0" cellpadding="1"
										id="table_grid" class="main-table">
										<thead>
											<tr class="bgpink">
												<th style="text-align: center;">Bill No</th>
												<th style="text-align: center;">Invoice No</th>
												<th style="text-align: center;">Bill Date</th>
												<th style="text-align: center;">Grand Total</th>
												<th style="text-align: center;">Payable Amount</th>
												<th style="text-align: center;">Paid Amount</th>
												<th style="text-align: center;">Paymode</th>
												<th style="text-align: center;">Action</th>
											</tr>
										</thead>
										<tbody>

										</tbody>

									</table> -->

								</div>
							</div>
						</div>
						<!--table end-->
						
			<button style="display: none;" id="myBtn"></button>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
  
    <span class="close">&times;</span>
    						
    						<input  type="hidden" name="tranId" id="tranId">
    						<!-- <input  type="hidden" name="Stockstatus" id="Stockstatus"> -->
    						
   							<table width="100%" border="1" cellspacing="0" cellpadding="1"
										id="table_grid2" class="main-table">
										<thead>
											
											<tr class="bgpink">
											<th style="text-align: center;width: 2%">Sr No.</th>
												<th style="text-align: center;">Item Name</th>
												<th style="text-align: center;">Qty</th>
												<th style="text-align: center;">Total Tax Amt.</th>
												<th style="text-align: center;">Total Amt</th>
												<!-- <th style="text-align: center;">Payable Amount</th>
												<th style="text-align: center;">Paid Amount</th>
												<th style="text-align: center;">Paymode</th>
												<th style="text-align: center;">Action</th> -->
											</tr>
										</thead>
										 <tbody>
										<%-- <c:forEach items="${headList}" var="Stock" varStatus="cnt">
											<tr>
												<td>${cnt.index+1}</td>
												<td>${Stock.exVar1}</td>
												<td>${Stock.makerDate}</td>
												<td>${Stock.grandTotal}</td>
												<td style="text-align: center;" ><a onclick="editHeader(${Stock.transferId})"><i class="fa fa-bars" title="Edit" aria-hidden="true"></i>
												</a></td>
											</tr>
										
										</c:forEach>

										</tbody> --%>
									</table>
										<br>
									
									<div class="center" style="display: none;" id="buttonDiv">
							<button class="button" title="Accept" onclick="acceptRejectClick(2)" ><i class="fa fa-check"></i></button>
							<button class="button button2" title="Reject" onclick="acceptRejectClick(1)" ><i class="fa fa-window-close" aria-hidden="true"></i></button>
							
						</div>
				
								
 	 </div>
  	
<div class="clr"></div>	
</div>

<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
<script type="text/javascript">
function acceptRejectClick(val) {
	//alert(document.getElementById("tranId").value);
	//alert(val);
	var tranId=document.getElementById("tranId").value;
	$.post('${acceptRejectStock}', {
		tranId : tranId,
		status : val,
		ajax : 'true',
	}, function(data) {
		//alert(data);
		if(data==1){
			window.location.reload();
		}
	});
}
</script>


					</div>
				</div>




			</div>
			<!--rightSidebar-->

		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->

	</div>
	<!--wrapper-end-->

	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->
	

	
<script type="text/javascript">
function editHeader(val,val1) {
	
	//alert(val1);
	document.getElementById("tranId").value=val;
	document.getElementById("myBtn").click();
	if(val1==0){
		document.getElementById("buttonDiv").style="block";	
	}
	$.post('${getStocktransferToHeader}', {
		headId : val,
		ajax : 'true',
	}, function(data) {
		//alert(JSON.stringify(data));
		//window.location.reload();
		$('#table_grid2 td').remove();
		
		
		
		
									if (data == "") {
										alert("No records found !!");

									}
									//alert(data);

									$.each(data.stockTransferdetailList,
													function(key, detail) {

														var index = key + 1;

														var tr = $('<tr></tr>');
														tr
																.append($(
																		'<td></td>')
																		.html(
																				key + 1));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				detail.exVar1));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				'&nbsp; <input readonly="readonly" type="Number" id="uQty'+detail.transferDetailId+'" name="uQty'+detail.transferDetailId+'" value="'+
																				detail.qty+'" >'));
														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				detail.itemTax));
														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				detail.grandTotal));
																						
													$('#table_grid2 tbody')
																.append(tr);
														

													})
		
	});
	
}
</script>

	<script type="text/javascript">
		function searchSellBill() {

			var isValid = validate();

			if (isValid) {

				var fromDate = document.getElementById("fromdatepicker").value;
				var toDate = document.getElementById("todatepicker").value;

				$
						.getJSON(
								'${getSellBillHeader}',
								{

									fromDate : fromDate,
									toDate : toDate,
									ajax : 'true',

								},
								function(data) {

									//$('#table_grid td').remove();
									$('#table_grid td').remove();
									if (data == "") {
										alert("No records found !!");

									}
									//alert(data);

									$
											.each(
													data,
													function(key, sellBillData) {

														var index = key + 1;

														var tr = $('<tr></tr>');
														tr
																.append($(
																		'<td></td>')
																		.html(
																				key + 1));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				sellBillData.invoiceNo));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				sellBillData.billDate));
														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				(sellBillData.grandTotal)
																						.toFixed(2)));
														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				(sellBillData.payableAmt)
																						.toFixed(2)));
														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				(sellBillData.paidAmt)
																						.toFixed(2)));
														var payMode = "";
														if (sellBillData.paymentMode == 1)
															payMode = "Cash";
														else if (sellBillData.paymentMode == 2)
															payMode = "Card";
														else if (sellBillData.paymentMode == 3)
															payMode = "Other";

														tr
																.append($(
																		'<td style="text-align:center;"></td>')
																		.html(
																				payMode));
														if (sellBillData.billType == 'S') {

															if (sellBillData.invoiceNo == 0) {
																tr
																		.append($(
																				' <td style="text-align:center;"></td>')
																				.html(
																						'SP &nbsp;  <a href="#"'
																								+ 'title="Generate Bill No." onclick="generateBillNo('
																								+ sellBillData.sellBillNo
																								+ ')"><i class="fa fa-money" aria-hidden="true"></i></a>'));
															} else {
																tr
																		.append($(
																				' <td style="text-align:center;"></td>')
																				.html(
																						'SP &nbsp; <a href="" onclick="return custBillPdf('
																								+ sellBillData.sellBillNo
																								+ ',\''
																								+ sellBillData.billType
																								+ '\');"><abbr title="PDF"><i class="fa fa-file-pdf-o"></i></abbr></a> '));
															}

														} else {
															tr
																	.append($(
																			'<td style="text-align:center;"></td>')
																			.html(
																					"<a href=${pageContext.request.contextPath}/viewBillDetails?sellBillNo="
																							+ sellBillData.sellBillNo
																							+ '&billDate='
																							+ sellBillData.billDate
																							+ ' class="action_btn" name='
																							+ '><abbr title="Details"><i class="fa fa-list"></i></abbr></a> &nbsp; <a href=""onclick="return custBillPdf('
																							+ sellBillData.sellBillNo
																							+ ',\''
																							+ sellBillData.billType
																							+ '\');"><abbr title="PDF"><i class="fa fa-file-pdf-o"></i></abbr></a> '));
														}
														$('#table_grid tbody')
																.append(tr);
														/* var tr = "<tr>";

														

														var sellBillNo = "<td>&nbsp;&nbsp;&nbsp;"
																+ sellBillData.sellBillNo
																+ "</td>";
																var invoiceNo = "<td>&nbsp;&nbsp;&nbsp;"
																	+ sellBillData.invoiceNo
																	+ "</td>";
																	var billDate = "<td>&nbsp;&nbsp;&nbsp;"
																		+ sellBillData.billDate
																		+ "</td>";

																		var grandTotal = "<td style='text-align:right;'>&nbsp;&nbsp;&nbsp;"
																			+ (sellBillData.grandTotal).toFixed(2)
																			+ "</td>";

																			var PayableAmt = "<td style='text-align:right;'>&nbsp;&nbsp;&nbsp;"
																				+ (sellBillData.payableAmt).toFixed(2)
																				+ "</td>";
																				
																				var paidAmt = "<td style='text-align:right;'>&nbsp;&nbsp;&nbsp;"
																					+ (sellBillData.paidAmt).toFixed(2)
																					+ "</td>";
														                        
																			   
																				var paymentMode = "<td>&nbsp;&nbsp;&nbsp;"
																					+ sellBillData.paymentMode
																					+ "</td>";
																					
																					var viewBill = '<td>&nbsp;&nbsp;&nbsp;'
																					+'<a href="${pageContext.request.contextPath}/viewBillDetails?sellBillNo='+ sellBillData.sellBillNo+'&billDate='+sellBillData.billDate+'" class="action_btn" name='+'><abbr title="Details"><i class="fa fa-list"></i></abbr></a>'
																					+ "</td>";



														

														var trclosed = "</tr>";

														$('#table_grid tbody')
																.append(tr);
														$('#table_grid tbody')
																.append(sellBillNo);
														$('#table_grid tbody')
														.append(invoiceNo);
														$('#table_grid tbody')
														.append(billDate);
														$('#table_grid tbody')
														.append(grandTotal);
														$('#table_grid tbody')
														.append(PayableAmt);
														$('#table_grid tbody')
														.append(paidAmt);
														
														$('#table_grid tbody')
														.append(paymentMode);
														
														$('#table_grid tbody')
														.append(viewBill);
														
														$('#table_grid tbody')
														.append(trclosed); */

													})

								});

			}
		}

		function custBillPdf(sellBillNo, type) {

			var loginWindow = window.open('', 'UserLogin');
			if (type == 'S') {
				loginWindow.location.href = '${pageContext.request.contextPath}/printSpCkBillPrint/'
						+ sellBillNo;
			} else {
				loginWindow.location.href = '${pageContext.request.contextPath}/pdfSellBill?billNo='
						+ sellBillNo + '&type=' + type;
			}
		}
	</script>
	<script type="text/javascript">
		function validate() {

			var fromDate = $("#fromdatepicker").val();
			var toDate = $("#todatepicker").val();

			var isValid = true;

			if (fromDate == "" || fromDate == null) {

				isValid = false;
				alert("Please select From Date");
			} else if (toDate == "" || toDate == null) {

				isValid = false;
				alert("Please select To Date");
			}
			return isValid;

		}

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

		function generateBillNo(id) {

			on();
			$.post('${generateBillNo}', {
				id : id,
				ajax : 'true',
			}, function(data) {
				off();
				//window.location.reload();
				searchSellBill();
			});
		}
		function on() {
			document.getElementById("overlay").style.display = "block";
		}

		function off() {
			document.getElementById("overlay").style.display = "none";
		}
	</script>

</body>
</html>

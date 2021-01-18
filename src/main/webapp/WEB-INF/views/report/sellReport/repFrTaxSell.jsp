<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

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

</head>
<body> --%>

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
<!--datepicker-->



<c:url var="getTaxSellReport" value="/getTaxSellReport" />

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
			
			<div class="title_row_one marg_top_btm">
				<div class="left_title">
					<h2 class="pageTitle"><i class="fa fa-file-o"></i> View Sell Tax Report</h2>
				</div>
				<div class="on_off_row extra_margin">
					    
					 <div class="pop_one">
							<div class="pop_one_txt margin_tp"> From  </div>
							<div class="pop_one_inp">
								<input class="texboxitemcode texboxcal" id="fromdatepicker" autocomplete="off" placeholder="Delivery Date" name="from_Date" type="text">
							</div>
					    </div> 
					    
					    <div class="pop_one">
							<div class="pop_one_txt margin_tp"> To  </div>
							<div class="pop_one_inp">
								<input class="texboxitemcode texboxcal" id="todatepicker" autocomplete="off" placeholder="Delivery Date" name="to_Date" type="text">
							</div>
					    </div>
					    
					    <input type="hidden" name="frId" id="frId" value="${frId}">  
					    
					    <div class="buttons_right">
						<button class="buttonsaveorder" onclick="searchSellBill()">HTML View</button>
						<button class="buttonsaveorder" onclick="showChart()">Graph</button>						
						<button class="buttonsaveorder" value="PDF" id="PDFButton" onclick="genPdf()">PDF</button>
					</div>
					
				</div>		
			</div>
				
				<div class="row" id="table">
					<div class="col-md-12">
						<!--table-->
						<div class="clearfix"></div>


						<div id="table-scroll">
							
							<div class="tableFixHead">
								<table id="table_grid">
									<thead>
										<tr class="bgpink">

											<th style="text-align: center;">Sr.No.</th>
											<!-- <th class="col-md-1">Bill No</th> -->
											<th style="text-align: center;">Tax %</th>
											<th style="text-align: center;">Taxable
												Amt</th>
											<th style="text-align: center;">IGST</th>
											<th style="text-align: center;">CGST</th>
											<th style="text-align: center;">SGST</th>
											<th style="text-align: center;">CESS</th>
										</tr>
									</thead>

									<tbody>
									</tbody>

								</table>

							</div>
							<div class="form-group" style="display: none;" id="range">



								<div class="col-sm-12  controls" style="margin: 15px 0;">
									<input type="button" id="expExcel" class="buttonsaveorder"
										value="EXPORT TO Excel" onclick="exportToExcel();"
										disabled="disabled">
								</div>
							</div>
						</div>
						<!--table end-->

					</div>
				</div>

				<div id="chart">
				
				
					<div class="svg_bx">
						<div class="svg_l" id="chart_div" style="overflow-y: scroll;"></div>
						<div class="svg_r">
							<div class="chart_1" id="pieChart_div"></div>
							<div class="chart_1" id="Piechart"></div>
						</div>
					</div>
					
					<div>




						
						
						<!-- <div   id="PieChart_div" style="width:40%%; height:300; float: right;" ></div>  -->
					</div>
					<!-- <hr style="height:1px; width:50%%;" color="black">
			<div class="colOuter" >
			 
				<div   id="PieChart_div" style="width:100%; height:300;" align="center" ></div>
				</div> -->

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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!--easyTabs-->


<script type="text/javascript">
	function searchSellBill() {

		document.getElementById('table').style.display = "block";
		document.getElementById('chart').style = "display:none";
		// document.getElementById('showchart').style.display = "block";
		$('#table_grid td').remove();

		var isValid = validate();

		if (isValid) {

			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			//document.getElementById('btn_pdf').style.display = "block";

			$
					.getJSON(
							'${getTaxSellReport}',
							{

								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								if (data == "") {
									alert("No records found !!");
									document.getElementById("expExcel").disabled = true;
								}

								var taxTotal = 0;
								var igstTotal = 0;
								var cgstTotal = 0;
								var sgstTotal = 0;
								var cessTotal = 0;
								$
										.each(
												data,
												function(key, sellTaxData) {

													document
															.getElementById("expExcel").disabled = false;
													document
															.getElementById('range').style.display = 'block';

													var tr = $('<tr></tr>');

													tr
															.append($(
																	'<td></td>')
																	.html(
																			key + 1));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.tax_per)
																					.toFixed(2)));

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.tax_amount)
																					.toFixed(2)));
													taxTotal = taxTotal
															+ sellTaxData.tax_amount;

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.igst)
																					.toFixed(2)));
													igstTotal = igstTotal
															+ sellTaxData.igst;

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.cgst)
																					.toFixed(2)));
													cgstTotal = cgstTotal
															+ sellTaxData.cgst;

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.sgst)
																					.toFixed(2)));
													sgstTotal = sgstTotal
															+ sellTaxData.sgst;

													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			(sellTaxData.cess)
																					.toFixed(2)));
													cessTotal = cessTotal
															+ sellTaxData.cess;

													$('#table_grid tbody')
															.append(tr);

												})

								var tr = "<tr>";
								var total = "<td >&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								taxTotal = taxTotal.toFixed(2);
								var totalTax = "<td style='text-align:right;'>&nbsp;&nbsp;&nbsp;<b>"
										+ taxTotal + "</b></td>";

								var igst = "<td style='text-align:right;'><b>&nbsp;&nbsp;&nbsp;"
										+ igstTotal.toFixed(2);
								+"</b></td>";
								var cgst = "<td style='text-align:right;'><b>&nbsp;&nbsp;&nbsp;"
										+ cgstTotal.toFixed(2);
								+"</b></td>";
								var sgst = "<td style='text-align:right;'><b>&nbsp;&nbsp;&nbsp;"
										+ sgstTotal.toFixed(2);
								+"</b></td>";
								var cess = "<td style='text-align:right;'><b>&nbsp;&nbsp;&nbsp;"
										+ cessTotal + "</b></td>";

								var trclosed = "</tr>";

								$('#table_grid tbody').append(tr);
								$('#table_grid tbody').append(total);
								$('#table_grid tbody').append(totalTax);
								$('#table_grid tbody').append(igst);
								$('#table_grid tbody').append(cgst);
								$('#table_grid tbody').append(sgst);
								$('#table_grid tbody').append(cess);
								$('#table_grid tbody').append(trclosed);

							});

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
</script>
<script type="text/javascript">
	function showChart() {

		//$("#PieChart_div").empty();
		$("#chart_div").empty();

		document.getElementById('chart').style.display = "block";
		document.getElementById("table").style = "display:none";

		var fromDate = document.getElementById("fromdatepicker").value;
		var toDate = document.getElementById("todatepicker").value;
		var isValid = validate();

		if (isValid) {
			//	document.getElementById('btn_pdf').style.display = "block";
			$
					.getJSON(
							'${getTaxSellReport}',
							{

								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {
								//alert(data);
								if (data == "") {
									alert("No records found !!");

								}
								var i = 0;

								google.charts.load('current', {
									'packages' : [ 'corechart', 'bar' ]
								});
								google.charts.setOnLoadCallback(drawStuff);
								google.charts
										.setOnLoadCallback(drawAmtPieChart);
								google.charts
										.setOnLoadCallback(drawTaxPieChart);

								function drawStuff() {

									var chartDiv = document
											.getElementById('chart_div');
									document.getElementById("chart_div").style.border = "1px solid rgb(204, 204, 204)";
									var dataTable = new google.visualization.DataTable();

									dataTable
											.addColumn('string', 'Tax Percent'); // Implicit domain column.
									dataTable.addColumn('number', 'Amount'); // Implicit data column.
									// dataTable.addColumn({type:'string', role:'interval'});
									//  dataTable.addColumn({type:'string', role:'interval'});
									dataTable.addColumn('number', 'Total Tax');
									$.each(data, function(key, item) {

										//var tax=item.cgst + item.sgst;
										//var date= item.billDate+'\nTax : ' + item.tax_per + '%';
										var totalTax = item.cgst + item.sgst;
										dataTable.addRows([

										[ item.tax_per + ' %', item.tax_amount,
												totalTax, ]

										]);
									})

									var materialOptions = {
										width : 600,
										height : 450,
										chart : {
											title : ' Taxable Amount & Total Tax',
											subtitle : 'Tax percent wise Total Tax & Amount '
										},
										series : {
											0 : {
												axis : 'distance'
											}, // Bind series 0 to an axis named 'distance'.
											1 : {
												axis : 'brightness'
											}
										// Bind series 1 to an axis named 'brightness'.
										},
										axes : {
											y : {
												distance : {
													label : 'Taxable Amount'
												}, // Left y-axis.
												brightness : {
													side : 'right',
													label : 'Total Tax'
												}
											// Right y-axis.
											}
										}
									};
									//  var materialChart = new google.charts.Bar(chartDiv);

									function drawMaterialChart() {
										var materialChart = new google.charts.Bar(
												chartDiv);
										//  google.visualization.events.addListener(materialChart, 'select', selectHandler);    
										materialChart
												.draw(
														dataTable,
														google.charts.Bar
																.convertOptions(materialOptions));
										// button.innerText = 'Change to Classic';
										// button.onclick = drawClassicChart;
									}

									drawMaterialChart();

								}
								;

								function drawAmtPieChart() {

									var chartDiv = document
											.getElementById('pieChart_div');
									document.getElementById("pieChart_div").style.border = "1px solid rgb(204, 204, 204)";
									var dataTable = new google.visualization.DataTable();

									dataTable.addColumn('string', 'Per'); // Implicit domain column.
									dataTable.addColumn('number',
											'Taxable Amount'); // Implicit data column.
									//  dataTable.addColumn({type:'string', role:'interval'});
									//  dataTable.addColumn({type:'string', role:'interval'});
									//dataTable.addColumn('number', 'TaxableAmt');
									$.each(data, function(key, item) {

										var amt = item.tax_amount;
										var per = 'Tax :  ' + item.tax_per
												+ '%';
										//  Taxable Amt :   '+item.tax_amount;

										dataTable.addRows([
										//  [per, tax, item.tax_amount, ]
										[ per, amt, ]

										]);
									})

									var chart = new google.visualization.PieChart(
											document
													.getElementById('pieChart_div'));
									chart.draw(dataTable, {
										width : 400,
										height : 300,
										title : 'Taxable Amount'
									});

								}
								;
								function drawTaxPieChart() {

									var chartDiv = document
											.getElementById('Piechart');
									document.getElementById("Piechart").style.border = "1px solid rgb(204, 204, 204)";
									var dataTable = new google.visualization.DataTable();

									dataTable.addColumn('string', 'Per'); // Implicit domain column.
									dataTable.addColumn('number', 'Total Tax'); // Implicit data column.
									//  dataTable.addColumn({type:'string', role:'interval'});
									//  dataTable.addColumn({type:'string', role:'interval'});
									//dataTable.addColumn('number', 'TaxableAmt');
									$.each(data, function(key, item) {

										var tax = item.cgst + item.sgst;
										var per = 'Tax :  ' + item.tax_per
												+ '%';
										//  Taxable Amt :   '+item.tax_amount;

										dataTable.addRows([
										//  [per, tax, item.tax_amount, ]
										[ per, tax, ]

										]);
									})

									var chart = new google.visualization.PieChart(
											document.getElementById('Piechart'));
									chart.draw(dataTable, {
										width : 400,
										height : 300,
										title : 'Total Tax'
									});

								}
								;

							});
		}
	}
</script>


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

	function exportToExcel() {

		window.open("${pageContext.request.contextPath}/exportToExcel");
		document.getElementById("expExcel").disabled = true;
	}
</script>
<script type="text/javascript">
	function genPdf() {
		var isValid = validate();
		if (isValid == true) {
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			var frId = document.getElementById("frId").value;
			window
					.open('${pageContext.request.contextPath}/pdf?reportURL=pdf/showSellTaxReportpPdf/'
							+ fromDate + '/' + toDate + '/' + frId);
		}
	}
</script>
</body>
</html>
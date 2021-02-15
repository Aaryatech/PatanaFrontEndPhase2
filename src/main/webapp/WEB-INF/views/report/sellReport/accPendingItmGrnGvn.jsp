<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<style>
table, th, td {
    border: 1px solid #9da88d;
}
</style>

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
<body>
 --%>


<!--datepicker-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#todatepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#fromdatepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
 
  </script>
<!--datepicker--> 
<c:url var="getAccPendingItemsGrnGvn" value="/viewAccPendingItemsGrnGvn" />
<c:url var="getDateCatwisellReport" value="/getDateCatwisellsellBillData" />
	
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
				
				<div class="title_row_one">
					<div class="left_title">
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> A/c Pending Item Wise Grn Gvn</h2>
					</div>
					<div class="right_content"></div>
					<div class="clr"></div>
				</div>
				
				<div class="single_row">
				
				<div class="date_sear four_bx">
						<div class="date_sear_txt">From Date</div>
						<div class="date_sear_int inpt_width">
							<input id="fromdatepicker"  placeholder="From Date"  name="from_Date" type="text" class="texboxitemcode texboxcal " autocomplete="off" style="width:100%;">
						</div>
					</div>
					
					<div class="date_sear four_bx">
						<div class="date_sear_txt">To Date</div>
						<div class="date_sear_int inpt_width">
							<input id="todatepicker"  placeholder="To Date"  name="to_Date" type="text" style="width:100%;" class="texboxitemcode texboxcal " autocomplete="off">
						</div>
					</div>					
					
					<div class="date_sear four_bx">
						<div class="date_sear_txt">Select Type</div>
						<div class="date_sear_int inpt_width">
							<select id="isGrn" class="form-control chosen" placeholder="Select Type"  name="isGrn" tabindex="4"    style="width:100%;">
								<option selected value="1">GRN</option>
								<option value="0">GVN</option>
								<option value="2">ALL</option>

							</select>
						</div>
					</div>

					<div class="date_sear four_bx">
						<div class="date_sear_txt">Select Type</div>
						<div class="date_sear_int inpt_width">
							<select id="apprvBy" class="form-control chosen"
								placeholder="Select Type" name="apprvBy" tabindex="4"
								style="width: 100%;">
								<option value="0">A/c Approve Pending</option>
								<option value="1">Credit Note Pending</option>

							</select>
						</div>
					</div>
					<input type="hidden" name="frId" id="frId" value="${frId}">		
				</div>
				
				<br>
				<div class="single_row center_content">
					<div class="date_btn marg_lft">
						<button class="buttonsaveorder" onclick="searchSellBill()">HTML
							View</button>
						<!-- <button class="buttonsaveorder" onclick="showChart()">Graph</button> -->
						<button class="buttonsaveorder" value="PDF" id="PDFButton"
							onclick="genPdf()">PDF</button>
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

									<th class="col-md-1" style="text-align:center;">Sr.No.</th>
									<!-- <th class="col-md-1">Bill No</th> -->
									<th class="col-md-1" style="text-align:center;">GRN GVN SrNo.</th>
									<th class="col-md-1" style="text-align:center;">Type</th>
									<th class="col-md-1" style="text-align:center;">GRN GVN Date</th>
								 	<th class="col-md-1" style="text-align:center;">Item Name</th>
									<th class="col-md-1" style="text-align:center;">Qty</th> 
									<th class="col-md-1" style="text-align:center;">GRN GVN Status</th> 
								  </tr>
								</thead>
								
								 <tbody>
								 </tbody>
								  
								</table>
						 
				</div>
				</div>
		<!--table end-->
		<br>
				 <div class="form-group" style="display: none;" id="range">
								 
											 
											 
											<div class="col-sm-12  controls" style="margin: 0 0 20px 0;">
											 <input type="button" id="expExcel" class="buttonsaveorder" value="EXPORT TO Excel" onclick="exportToExcel();" disabled="disabled">
											</div>
											</div>
			
		 
		</div>	
    </div>

	<div id="chart" style="display: none"><br> <hr>
		<div id="chart_div" style="width:400; height:300" align="center"></div>
				 
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
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<!--easyTabs-->

	
	<script type="text/javascript">
	function searchSellBill()
	{ 
		
		   document.getElementById('chart').style="display:none";
		 //  document.getElementById('btn_pdf').style.display = "block";
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {
			document.getElementById('table').style.display = "block";
			
			var isGrn = $("#isGrn").val();
			var from_date = $("#fromdatepicker").val();
			var to_date = $("#todatepicker").val();
			var apprvBy = $("#apprvBy").val();
			
			var grngvnStat;
			var type;
			
			$.getJSON('${getAccPendingItemsGrnGvn}',
					{
						
						from_date : from_date,
						to_date : to_date,
						apprvBy : apprvBy,
						is_grn : isGrn,
						ajax : 'true'

							},
							function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");
									  document.getElementById("expExcel").disabled=true;
								}
							 

							 
								var amtTotal=0;
								
								var totalQty=0;
								
								$.each(data,function(key, sellBillData) {
									  document.getElementById("expExcel").disabled=false;
										document.getElementById('range').style.display = 'block';

									var tr = $('<tr></tr>');
									
									if (sellBillData.isGrn == 1) {
										type = "GRN"
									} else {
										type = "GVN"
									}
									
									if (sellBillData.grngvnStatus == 1){
										grngvnStat = 'Pending';
									}
									else if (sellBillData.grngvnStatus == 2){
										grngvnStat = 'Approved By Gate';
									}
									else if (sellBillData.grngvnStatus == 3){
										grngvnStat = 'Reject By Gate';
									}
									else if (sellBillData.grngvnStatus == 4){
										grngvnStat = 'Approved By Store';
									}
									else if (sellBillData.grngvnStatus == 5){
										grngvnStat = 'Reject By Store';
									}
									else if (sellBillData.grngvnStatus == 6){
										grngvnStat = 'Approved By Acc'; 
									}
									else{
										grngvnStat = 'Reject By Acc';
									}


								  	tr.append($('<td class ="col-md-1"></td>').html(key+1));
								  	
								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.grngvnSrno));

								  	tr.append($('<td class ="col-md-1"></td>').html(type));
								  									  	
								  	tr.append($('<td class ="col-md-1" style="text-align:center;"></td>').html(sellBillData.grngvnDate));
								  	
								  	tr.append($('<td class ="col-md-1" style="text-align:left;"></td>').html(sellBillData.itemName));
								  	
									tr.append($('<td class ="col-md-1" style="text-align:right;"></td>').html((sellBillData.grnGvnQty).toFixed(2)));
									
								  	tr.append($('<td class ="col-md-1" style="text-align:left;"></td>').html(grngvnStat));
								  	
									$('#table_grid tbody').append(tr);

												})
						
							});

		}
	}
	</script>
	<script type="text/javascript">
	function validate() {
	
	
		var fromDate =$("#fromdatepicker").val();
		var toDate =$("#todatepicker").val();
		

		var isValid = true;

	 if (fromDate == "" || fromDate == null) {

			isValid = false;
			alert("Please select From Date");
		}
	 else if (toDate == "" || toDate == null) {

			isValid = false;
			alert("Please select To Date");
		}
		return isValid;

	}
 
</script>
	<script type="text/javascript">
	 
function showChart(){
		
		document.getElementById('chart').style.display = "block";
		   document.getElementById("table").style="display:none";
		
		   var isValid = validate();
			
			if (isValid) {
				  // document.getElementById('btn_pdf').style.display = "block";
				var fromDate = document.getElementById("fromdatepicker").value;
				var toDate = document.getElementById("todatepicker").value;
				var category=$("#category").val();
				
				
				$.getJSON('${getDateCatwisellReport}',{
					
									fromDate : fromDate,
									toDate : toDate,
									category : category,
									ajax : 'true',

								},
								function(data) {
								// alert(data);
							 if (data == "") {
									alert("No records found !!");

								}
							 var i=0;

							 google.charts.load('current', {'packages':['corechart', 'bar']});
							 google.charts.setOnLoadCallback(drawStuff);

							 function drawStuff() {
 
							   var chartDiv = document.getElementById('chart_div');
							   document.getElementById("chart_div").style.border = "1px solid #CCC"; /* thin dotted red */
						       var dataTable = new google.visualization.DataTable();
						       
						       dataTable.addColumn('string', 'Bill Date'); // Implicit domain column.
						       dataTable.addColumn('number', 'Amount'); // Implicit data column.
						      // dataTable.addColumn({type:'string', role:'interval'});
						     //  dataTable.addColumn({type:'string', role:'interval'});
						       dataTable.addColumn('number', 'Qauntity');
						       $.each(data,function(key, item) {

									//var tax=item.cgst + item.sgst;
									//var date= item.billDate+'\nTax : ' + item.tax_per + '%';
									
								   dataTable.addRows([
									 
								             [item.billDate, item.amount, item.qty, ]
								           
								           ]);
								     }) 
						    
 var materialOptions = {
          width: 600,
          height:450,
          chart: {
            title: ' Qauntity & Amount',
            subtitle: 'Date wise Qauntity & Amount '
          },
          series: {
            0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
            1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
          },
          axes: {
            y: {
              distance: {label: 'Amount'}, // Left y-axis.
              brightness: {side: 'right', label: 'Quantity'} // Right y-axis.
            }
          }
        };
						       var materialChart = new google.charts.Bar(chartDiv);
						       
						       function selectHandler() {
							          var selectedItem = materialChart.getSelection()[0];
							          if (selectedItem) {
							            var topping = dataTable.getValue(selectedItem.row, 0);
							           // alert('The user selected ' + selectedItem.row,0);
							            i=selectedItem.row,0;
							            itemSellBill(data[i].billDate);
							           // google.charts.setOnLoadCallback(drawBarChart);
							          }
							        }
						       
						       function drawMaterialChart() {
						          // var materialChart = new google.charts.Bar(chartDiv);
						           google.visualization.events.addListener(materialChart, 'select', selectHandler);    
						           materialChart.draw(dataTable, google.charts.Bar.convertOptions(materialOptions));
						          // button.innerText = 'Change to Classic';
						          // button.onclick = drawClassicChart;
						         }
						         
						       drawMaterialChart();
						 
							 };
							 
										
							  	});
			}
}
</script>
<script type="text/javascript">
	function itemSellBill(date)
	{ 
		document.getElementById('table').style.display = "block";
		   document.getElementById('chart').style="display:none";

	
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {
			   document.getElementById('btn_pdf').style.display = "block";
			//var fromDate = date;
			//var toDate = date;
			var category=$("#category").val();
			//alert(date);
			var newdate = date.split("-").reverse().join("-");
			
			$.getJSON('${getDateItemwiselReport}',{
				
								fromDate : newdate,
								toDate : newdate,
								category : category,
								ajax : 'true',

							},
							function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");
									 document.getElementById("expExcel").disabled=true;
								}
							 

							 
								var amtTotal=0;
								
								var totalQty=0;
								
								$.each(data,function(key, sellBillData) {

									  document.getElementById("expExcel").disabled=false;
										document.getElementById('range').style.display = 'block';
									var tr = $('<tr></tr>');

								  	tr.append($('<td class ="col-md-1"></td>').html(key+1));
								  	
								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.billDate));

								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.itemName));
								  									  	
								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.catName));
								  	
									tr.append($('<td class ="col-md-1"></td>').html(sellBillData.qty));
									totalQty=totalQty + sellBillData.qty;
								  	
								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.amount));
								  	
								  	amtTotal=amtTotal + sellBillData.amount;
								  	
								  	
								  	

									$('#table_grid tbody').append(tr);

									
													

												})
												
							var tr = "<tr>";
								 var total = "<td colspan='4'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								 
								var totalAmt = "<td>&nbsp;&nbsp;&nbsp;<b>"
									+ amtTotal
									+ "</b></td>";
								 var totalQty = "<td><b>&nbsp;&nbsp;&nbsp;"
									+  totalQty
									+ "</b></td>";
							
									
								
								var trclosed = "</tr>";
								
								
								$('#table_grid tbody')
								.append(tr);
								$('#table_grid tbody')
								.append(total);
								$('#table_grid tbody')
								.append(totalQty);
								 $('#table_grid tbody')
									.append(totalAmt);
								 $('#table_grid tbody')
								 
								$('#table_grid tbody')
								.append(trclosed); 
								 
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

	</script>
	<script type="text/javascript">
	function genPdf() {
		var isGrn = $("#isGrn").val();	
		var selectedFr = $("#frId").val();
		var from_date = $("#fromdatepicker").val();
		var to_date = $("#todatepicker").val();
		var apprvBy = $("#apprvBy").val();			

		window
				.open('${pageContext.request.contextPath}/tSellReport?reportURL=pdf/showPndItemGrnGvnReportPdf/'
						+ from_date
						+ '/'
						+ to_date
						+ '/'
						+ selectedFr
						+ '/' + apprvBy + '/' + isGrn + '/');

	}
	function exportToExcel() {

		window.open("${pageContext.request.contextPath}/exportToExcel");
		document.getElementById("expExcel").disabled = true;
	}

</script>	
</body>
</html>
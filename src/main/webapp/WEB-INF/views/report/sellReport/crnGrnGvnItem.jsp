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
<c:url var="getCreditNoteGrnGvnItmQty" value="/getCreditNoteGrnGvnItmQty" />
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
						<h2 class="pageTitle"><i class="fa fa-file-o"></i>Credit Note GRN GVN</h2>
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
								 	<th class="col-md-1" style="text-align:center;">Item Name</th>
									<th class="col-md-1" style="text-align:center;">Request Qty.</th> 
									<th class="col-md-1" style="text-align:center;">Approve Qty.</th> 
								  </tr>
								</thead>
								
								 <tbody>
								 </tbody>
								  
								</table>
						 
				</div>
				</div>
		<!--table end-->
		<br>
				<!--  <div class="form-group" style="display: none;" id="range">
								 
											 
											 
											<div class="col-sm-12  controls" style="margin: 0 0 20px 0;">
											 <input type="button" id="expExcel" class="buttonsaveorder" value="EXPORT TO Excel" onclick="exportToExcel();" disabled="disabled">
											</div>
											</div> -->
			
		 
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
			
			var grngvnStat;
			var type;
			
			$.getJSON('${getCreditNoteGrnGvnItmQty}',
					{
						
						from_date : from_date,
						to_date : to_date,
						is_grn : isGrn,
						ajax : 'true'

							},
							function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");
									  /* document.getElementById("expExcel").disabled=true; */
								}
							 

							 
								var amtTotal=0;
								
								var totalQty=0;
								
								$.each(data,function(key, sellBillData) {
									  /* document.getElementById("expExcel").disabled=false;
										document.getElementById('range').style.display = 'block'; */

									var tr = $('<tr></tr>');
									
									

								  	tr.append($('<td class ="col-md-1"></td>').html(key+1));
								  	
								  	tr.append($('<td class ="col-md-1"></td>').html(sellBillData.grngvnSrno));								  									  	
								  	
								  	tr.append($('<td class ="col-md-1" style="text-align:left;"></td>').html(sellBillData.itemName));
								  	
									tr.append($('<td class ="col-md-1" style="text-align:right;"></td>').html((sellBillData.reqQty).toFixed(2)));
									
								  	tr.append($('<td class ="col-md-1" style="text-align:left;"></td>').html((sellBillData.aprvQty).toFixed(2)));
								  	
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

		window
				.open('${pageContext.request.contextPath}/pdf/showCrnGrnGvnItemQtyPdf/'
						+ from_date
						+ '/'
						+ to_date
						+ '/'
						+ selectedFr
						+ '/'
						+ isGrn);

	}
	function exportToExcel() {

		window.open("${pageContext.request.contextPath}/exportToExcel");
		document.getElementById("expExcel").disabled = true;
	}

</script>	
</body>
</html>

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

<c:url var="getHeaders" value="/getHeaders" />
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
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> Credit Note Report</h2>
					</div>
					
					<div class="on_off_row extra_margin">
						<form action="" class="form-horizontal" method="get" id="validation-form">						
						<input type="hidden" value="${gstType}" name="type" id="type" />
						
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> From  </div>
							<div class="pop_one_inp">
							<input id="fromdatepicker" autocomplete="off"
								class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" placeholder="Delivery Date"
								name="fromDate" type="text">								
								
							</div>
					    </div>
					    
					    
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> To  </div>
							<div class="pop_one_inp">
							
							<input id="todatepicker" autocomplete="off"
								class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" placeholder="Delivery Date"
								name="toDate" type="text">
							
								
							</div>
					    </div>
					    
					    
					    
					    <div class="buttons_right">
							<input type="button" value="Search" onclick="searchReport()" class="buttonsaveorder">						
						</div>
						</form>
					</div>
				</div>
			
			
			


				

				
					

						
						
						
						
						
					

				

				
					<div class="clearfix"></div>


					<div id="table-scroll">
						
						<div class="tableFixHead">
							<table id="table1">
								<thead>
									<tr class="bgpink">

										<th><input type="checkbox" onClick="selectBillNo(this)" /></th>
										<th >Sr No.</th>
										<th style="text-align: center;">Date</th>
										<th style="text-align: center;">CRN Id</th>

										<th style="text-align: center;">Franchise</th>
										<th style="text-align: center;">Taxable
											Amt</th>
										<th style="text-align: center;">Tax Amt</th>
										<th style="text-align: center;">Amount</th>
										<th >Action</th>
									</tr>

								</thead>
								<tbody>
							</table>

						</div>

					</div>
					<!--table end-->
					
					<div class="col-sm-12 controls" style="margin: 15px 0;">
						<input type="button" value="Generate PDF For Fr"
							onclick="genPdf()" class="buttonsaveorder">
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


<script>
	function genPdf() {
		//alert("Inside Gen Pdf ");
		checkboxes = document.getElementsByName('select_to_agree');
		//alert(checkboxes.length);

		var selArray = 0;

		for (var x = 0; x < checkboxes.length; x++) {
			if (document.getElementById("select_to_agree" + x).checked == true) {
				if (x == 0) {

					selArray = document.getElementById("select_to_agree" + x).value;
					//alert(selArray);
				} else {
					selArray = selArray
							+ ","
							+ document.getElementById("select_to_agree" + x).value;
					//alert(selArray);
				}
			}

		}
		//	alert(selArray);

		window
				.open('${pageContext.request.contextPath}/pdf?url=pdf/getCrnCheckedHeadersNew/'
						+ selArray);

	}
</script>




<script type="text/javascript">
	function searchReport() {

		//	alert("in side get Header ");

		var fromDate = $("#fromdatepicker").val();
		var toDate = $("#todatepicker").val();

		var valid = true;

		if (fromDate == null || fromDate == "") {
			valid = false;
			alert("Please select from date");
		}

		else if (toDate == null || toDate == "") {
			valid = false;
			alert("Please select to date");
		}

		/* if (fromDate > toDate) {
			valid = false;
			alert("from date greater than todate ");
		} */

		if (valid == true) {

			$
					.getJSON(
							'${getHeaders}',
							{
								fromDate : fromDate,
								toDate : toDate,

								ajax : 'true',

							},
							function(data) {
								//alert(data);
								var len = data.length;

								$('#table1 td').remove();

								$
										.each(
												data,
												function(key, headers) {

													var tr = $('<tr></tr>');

													tr
															.append($('<td><input class="chk" type=checkbox name="select_to_agree" id="select_to_agree'+key+'"  value='+headers.crnId+'></td>'));
													tr
															.append($(
																	'<td></td>')
																	.html(
																			key + 1));
													tr
															.append($(
																	'<td style="text-align:center"></td>')
																	.html(
																			headers.crnDate));

													tr
															.append($(
																	'<td style="text-align:center"></td>')
																	.html(
																			headers.crnId));

													tr
															.append($(
																	'<td style="text-align:center"></td>')
																	.html(
																			headers.frName));

													tr
															.append($(
																	'<td style="text-align:right"></td>')
																	.html(
																			(headers.crnTaxableAmt)
																					.toFixed()));

													tr
															.append($(
																	'<td style="text-align:right"></td>')
																	.html(
																			(headers.crnTotalTax)
																					.toFixed(2)));

													tr
															.append($(
																	'<td style="text-align:right"></td>')
																	.html(
																			(headers.crnGrandTotal)
																					.toFixed(2)));

													tr
															.append($('<td style="text-align:center"><a href="#" class="action_btn" onclick="getCrnDetail('
																	+ headers.crnId
																	+ ')"><abbr title="Detail"><i class="fa fa-list"></i></abbr></a> &nbsp;&nbsp;&nbsp;<a href="#" class="action_btn" onclick="genPdfSingle('
																	+ headers.crnId
																	+ ')"><abbr title="Detail"><i class="fa fa-file-pdf-o"></i></abbr></a></td>'));

													$('#table1 tbody').append(
															tr);

												})

							});
		}

	}
</script>

<script type="text/javascript">
	function getCrnDetail(crnId) {
		//alert("HIII");
		//alert("header ID "+headerId)

		//alert("HHHHHH");
		var form = document.getElementById("validation-form");
		form.action = "${pageContext.request.contextPath}/getCrnDetailList/"
				+ crnId;
		form.submit();
	}
</script>

<script>
	function genPdfSingle(selArray) {
		//alert("Inside Gen Pdf ");
		//alert("Inside Gen Pdf " + selArray);

		window
				.open('${pageContext.request.contextPath}/pdf?url=pdf/getCrnCheckedHeadersNew/'
						+ selArray);

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
<script>
	/*
	//  jquery equivalent
	jQuery(document).ready(function() {
	jQuery(".main-table").clone(true).appendTo('#table-scroll .faux-table').addClass('clone');
	jQuery(".main-table.clone").clone(true).appendTo('#table-scroll .faux-table').addClass('clone2'); 
	});
	 */
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

<!-- onclick="var checkedVals = $('.chk:checkbox:checked').map(function() { return this.value;}).get();checkedVals=checkedVals.join(',');if(checkedVals==''){alert('No Rows Selected');return false;	}else{   return confirm('Are you sure want to generate pdf');}"
 -->
</body>
</html>

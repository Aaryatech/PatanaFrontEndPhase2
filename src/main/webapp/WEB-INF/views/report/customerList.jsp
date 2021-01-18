
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
<body>

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

	<c:url var="getCustomerListReport" value="/getCustomerListReport" />

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
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> Customer List Report</h2>
					</div>
					
					<div class="on_off_row extra_margin">
						
						
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> From  </div>
							<div class="pop_one_inp">							
							<input id="fromdatepicker" class="texboxitemcode texboxcal" autocomplete="off" value=${firstDate } placeholder="DD-MM-YYYY" name="from_Date" type="text">							
							</div>
					    </div>
						
						
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> To  </div>
							<div class="pop_one_inp">
							<input id="todatepicker" class="texboxitemcode texboxcal" autocomplete="off" placeholder="DD-MM-YYYY" name="to_Date" type="text"  value=${curDate }>								
							</div>
					    </div>
					    
					    
					    
					    <input type="hidden" name="frId" id="frId" value="${frId}">
					    
					    <div class="buttons_right">
							<button class="buttonsaveorder" onclick="searchSellBill()">HTML View</button>	
						</div>
						
					</div>
				</div>
					
					<div class="row">
						<div class="col-md-12">
							<!--table-->
							<div class="clearfix"></div>


							<div id="table-scroll" ><!-- class="table-scroll" -->
								<!-- <div id="faux-table" class="faux-table" aria="hidden">
									<table id="table_grid" class="main-table">
										<thead>
											<tr class="bgpink">

												<th class="col-sm-1" style="text-align: center;">Sr.No.</th>
												<th class="col-md-2" style="text-align: center;">Customer
													Name</th>
												<th class="col-md-2" style="text-align: center;">Contact
													Number</th>
												<th class="col-md-1" style="text-align: center;">Bill
													Date</th>

											</tr>
										</thead>

										<tbody>

										</tbody>
									</table>
								</div> -->
								<div class="tableFixHead">
									<table id="table_grid">
										<thead>
											<tr class="bgpink">

												<th width="25%" style="text-align: center;">Sr.No.</th>
												<th width="25%" style="text-align: center;">Customer
													Name</th>
												<th width="25%" style="text-align: center;">Contact
													Number</th>
												<th width="25%" style="text-align: center;">Bill
													Date</th>

											</tr>
										</thead>

										<tbody>

											<c:forEach items="${data}" var="user" varStatus="count">
												<tr>
													<td>${count.index+1}</td>
													<td>${user.user}</td>
													<td>${user.mobile}</td>
													<td>${user.billDate}</td>
												</tr>
											</c:forEach>

										</tbody>

									</table>

								</div>

							</div>
							<!--table end-->
							
							<div class="form-group" style="display: none;" id="range">



								<div class="col-sm-12  controls">
								
								
								
									<input type="button" id="expExcel" class="buttonsaveorder"
										value="EXPORT TO Excel" onclick="exportToExcel();"
										disabled="disabled">
								</div>
							</div>
						</div>
						
						<div style="margin: 0 0 20px 0;">
						
						 <button class="buttonsaveorder" value="Excel" id="excelBtn" onclick="exportToExcel()">Excel</button>
						  <button class="buttonsaveorder" value="PDF" id="PDFBtn" onclick="genPdf()">PDF</button>
						
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
	function searchSellBill() {
		
		$('#table_grid td').remove();

		var isValid = validate();

		if (isValid) {
			
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;

			$
					.getJSON(
							'${getCustomerListReport}',
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

								

								$
										.each(
												data,
												function(key, cust) {

													/* document
															.getElementById("expExcel").disabled = false;
													document
															.getElementById('range').style.display = 'block'; */

													var tr = $('<tr></tr>');

													tr.append($('<td></td>')
															.html(key + 1));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:left;"></td>')
																	.html(
																			cust.user));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:center;"></td>')
																	.html(
																			cust.mobile));

													tr
															.append($(
																	'<td class="col-md-1"  style="text-align:center;"></td>')
																	.html(
																			cust.billDate));													

													$('#table_grid tbody')
															.append(tr);

												})								

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
		function 
		genPdf() {
			//window.open('${pageContext.request.contextPath}/pdf?reportURL=pdf/showCustomerListReportPdf/');
			
			window.open('${pageContext.request.contextPath}/getCustListReportPdf');
		}
	</script>
</body>
</html>

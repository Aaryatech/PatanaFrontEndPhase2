<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->
	<c:url var="getSpAdvTaxReport" value="/getSpAdvTaxReport" />
	<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>


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
			<div class="sidebarright">
				<div class="title_row_one extra_margin_top">
					<div class="left_title">
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> Sp Tax Report</h2>
					</div>
					
					<div class="on_off_row extra_margin">
						<form id="validation-form">
					<input type="hidden" value="${gstType}" name="type" id="type" />
						
						
						
						<input type="hidden" value="${gstType}" name="type" id="type" />
						
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> From  </div>
							<div class="pop_one_inp">
							<input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"
								value="${cDate}" autocomplete="off" name="from_Date" type="text">								
								
							</div>
					    </div>
					    
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> To  </div>
							<div class="pop_one_inp">
							<input id="datepicker2" class="texboxitemcode texboxcal" placeholder="Delivery Date"
								value="${cDate}" autocomplete="off" name="to_Date" type="text">
							
								
							</div>
					    </div>
					    
					    
					    
					    <div class="buttons_right">
						<button type="button" class="buttonsaveorder onclick="searchSpTaxAdvRepo()">Search</button>
						<button type="button" class="buttonsaveorder" id='pdf' onclick="genPdf()" disabled>Generate Pdf</button>
						</div>
						
					</div>
				</div>
			
			
			
			
				
				

					

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->

						<div id="table-scroll">
							
							<div class="tableFixHead">
								<table id="table_grid">
									<thead>
										<tr class="bgpink">
											<th>Sr No</th>
											<th>Invoice No</th>
											<th>Item Name</th>
											<th>HsnCode</th>
											<th>Delivery Date</th>
											<th>Base MRP</th>
											<th>CGST %</th>
											<th>SGST %</th>
											<th>CGST Rs</th>
											<th>SGST Rs</th>
											<th>Total</th>
											<th>Advance</th>
											<th>Remaining</th>

										</tr>
									</thead>
									<tbody>
								</table>
							</div>
						</div>
					</div>
					<!--tabNavigation-->
				</form>
			</div>
			<!--rightSidebar-->
		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->
</div>
<!--wrapper-end-->

<script type="text/javascript">
	function searchSpTaxAdvRepo() {
		$('#table_grid td').remove();
		var fromDate = document.getElementById("datepicker").value;
		var toDate = document.getElementById("datepicker2").value;

		$.getJSON('${getSpAdvTaxReport}', {

			fromDate : fromDate,
			toDate : toDate,
			ajax : 'true'

		}, function(data) {

			var baseMrpTotal = 0;

			var cgstTotal = 0;
			var sgstTotal = 0;

			var totalAmt = 0;
			var advanceAmt = 0;
			var totalRemaining = 0;

			$.each(data, function(key, spTax) {

				if (data != null) {
					document.getElementById("pdf").disabled = false;

				}
				var tr = $('<tr></tr>');

				tr.append($('<td></td>').html(key + 1));
				tr
						.append($('<td class="col-md-2"></td>').html(
								spTax.invoiceNo));
				tr.append($('<td></td>').html(spTax.spName));
				tr.append($('<td></td>').html(spTax.spHsncd));
				tr.append($('<td></td>').html(spTax.delDate));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.baseMrp.toFixed(2)));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.tax1));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.tax2));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.tax1Amt));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.tax2Amt));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.total));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.spAdvance));
				tr.append($(
						'<td style="text-align:right"></td>')
						.html(spTax.rmAmount));

				baseMrpTotal = baseMrpTotal + spTax.baseMrp;
				cgstTotal = cgstTotal + spTax.tax1Amt;
				sgstTotal = sgstTotal + spTax.tax2Amt;
				totalAmt = totalAmt + spTax.total;
				advanceAmt = advanceAmt + spTax.spAdvance;
				totalRemaining = totalRemaining + spTax.rmAmount;

				$('#table_grid tbody').append(tr);

			})

			var tr = $('<tr></tr>');

			tr.append($('<td></td>').html(""));
			tr.append($('<td></td>').html(""));
			tr.append($('<td></td>').html(""));
			tr.append($('<td></td>').html(""));
			tr.append($('<td></td>').html("Total"));
			tr.append($('<td style="text-align:right"></td>')
					.html(baseMrpTotal.toFixed(2)));
			tr.append($('<td style="text-align:right"></td>')
					.html(""));
			tr.append($('<td style="text-align:right"></td>')
					.html(""));
			tr.append($('<td style="text-align:right"></td>')
					.html(cgstTotal.toFixed(2)));
			tr.append($('<td style="text-align:right"></td>')
					.html(sgstTotal.toFixed(2)));
			tr.append($('<td style="text-align:right"></td>')
					.html(totalAmt.toFixed(2)));
			tr.append($('<td style="text-align:right"></td>')
					.html(advanceAmt.toFixed(2)));
			tr.append($('<td style="text-align:right"></td>')
					.html(totalRemaining.toFixed(2)));

			$('#table_grid tbody').append(tr);

		});

		//}//if block
	}

	document.getElementById("pdf").disabled = true;
</script>




<script type="text/javascript">
	function validate() {

		var fromDate = $("#datepicker").val();
		var toDate = $("#datepicker2").val();

		var headeIdText = $("#headeIdText").val();
		alert(headeIdText);

		var isValid = true;
		if (headeIdText == "" || headeIdText == null) {
			isValid = false;
		} else if (fromDate == "" || fromDate == null) {

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
</script>

<script>
	function genPdf() {
		window.open('${pageContext.request.contextPath}/getSpAdvTaxPdf');
	}
</script>

</body>
</html>
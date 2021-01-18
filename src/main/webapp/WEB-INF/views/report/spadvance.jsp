<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->
	<c:url var="getSpAdvance" value="/getSpAdvance" />
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
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> Sp Advance Report</h2>
					</div>
					
					<div class="on_off_row extra_margin">
					<form id="validation-form">
						
						
						
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
							<input id="datepicker2" class="texboxitemcode texboxcal" placeholder="Delivery Date" place
								value="${cDate}" autocomplete="off" name="to_Date" type="text">
							
								
							</div>
					    </div>
					    
					    <div class="buttons_right">
						<button type="button" class="buttonsaveorder" onclick="searchSpAdv()">Search</button>
						<button type="button" class="buttonsaveorder" id='pdf' onclick="genPdf()" disabled>Generate Pdf</button>		
						</div>
						
					</div>
				</div>
			
			
			
				
				
					

					

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->

						<div id="table-scroll">
							<!-- <div id="faux-table" class="faux-table" aria="hidden">
								<table id="table_grid" class="main-table" border="1">
									<thead>
										<tr class="bgpink">
											 	<th class="col-md-1">Sr No</th>
											<th  class="col-md-3" align="left">Customer Name</th>
											<th class="col-md-3">Item Name</th>
											<th class="col-md-1">Order Date</th>
											<th class="col-md-1">MRP</th>
											<th class="col-md-2">Advance Amt</th> 
										</tr>
									</thead>
								</table>
							</div> -->
							<div class="tableFixHead">
								<table id="table_grid">
									<thead>
										<tr class="bgpink">
											<th style="text-align: center;">Sr No</th>
											<th style="text-align: center;">Customer
												Name</th>
											<th style="text-align: center;">Item
												Name</th>
											<th style="text-align: center;">Order
												Date</th>
											<th style="text-align: center;">MRP</th>
											<th style="text-align: center;">Advance
												Amt</th>

										</tr>
									</thead>
									<tbody>

										<c:forEach items="${grnList}" var="grnList" varStatus="count">
											<tr>
												<td ><c:out
														value="${grnList.grngvnSrno}" /> <input type="hidden"
													name="headerId" id="headerId"
													value="${grnList.grnGvnHeaderId}"></td>
												<td align="left"><c:out
														value="${grnList.grngvnDate}" /></td>
												<td style="text-align: right"><c:out
														value="${grnList.taxableAmt}" /></td>
												<td style="text-align: right"><c:out
														value="${grnList.taxAmt}" /></td>
												<td style="text-align: right"><c:out
														value="${grnList.totalAmt}" /></td>

												<td style="text-align: right"><fmt:formatNumber
														type="number" minFractionDigits="2" maxFractionDigits="2"
														value="${grnList.apporvedGrandTotal}" /> <%-- <c:out value="${grnList.taxableAmt}" /> --%></td>
												<c:set var="status" value="a"></c:set>
												<c:choose>
													<c:when test="${grnList.grngvnStatus==1}">
														<c:set var="status" value="Pending"></c:set>

													</c:when>
													<c:when test="${grnList.grngvnStatus==2}">
														<c:set var="status" value="Approved From Dispatch"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==3}">
														<c:set var="status" value="Reject From Dispatch"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==4}">
														<c:set var="status" value="Approved From Sales"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==5}">
														<c:set var="status" value="Reject From Sales"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==6}">
														<c:set var="status" value="Approved From Account"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==7}">
														<c:set var="status" value="Reject From Account"></c:set>
													</c:when>

													<c:otherwise>
														<c:set var="status" value="Partially Approved"></c:set>
													</c:otherwise>

												</c:choose>
												<td ><c:out value="${status}"></c:out></td>
												<c:set var="isCredit" value="a"></c:set>

												<c:choose>
													<c:when test="${grnList.isCreditNote==1}">
														<c:set var="isCredit" value="Yes"></c:set>
													</c:when>
													<c:otherwise>
														<c:set var="isCredit" value="No"></c:set>
													</c:otherwise>
												</c:choose>

												<td><c:out value="${isCredit}"></c:out></td>

												<td><c:out
														value="${grnList.creditNoteId}"></c:out></td>

												<td><a href='#' class='action_btn'
													onclick="getGrnDetail(${grnList.grnGvnHeaderId})"><abbr
														title='Detail'><i class='fa fa-list'></i></abbr></a><a
													href='#' class='action_btn'
													onclick="genPdf(${grnList.grnGvnHeaderId})"><abbr
														title='Pdf'><i class='far fa-file-pdf'></i></abbr></a></td>


												<%-- <td class="col-md-1"><a href='#' class='action_btn'
													onclick="genPdf(${grnList.grnGvnHeaderId})"><abbr
														title='Pdf'><i class='fa fa-list'></i></abbr></a></td> --%>

												<%-- <input type="button" onclick="getGrnDetail(${grnList.grnGvnHeaderId})" id="grnDetailButton" value="Detail"></td> --%>

											</tr>
										</c:forEach>



									</tbody>

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
		function searchSpAdv() {

			$('#table_grid td').remove();

				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;
				
				//alert(fromDate + toDate);

				$.getJSON('${getSpAdvance}', {

					fromDate : fromDate,
					toDate : toDate,
					ajax : 'true'

				}, function(data) {
					
					var totalAmt=0;
					var totalMrp=0;

					$.each(data, function(key, spAdv) {
						//alert(data);
						
						if(data!=null){
							 document.getElementById("pdf").disabled = false; 

						}
						var tr = $('<tr></tr>');
						
				
								
						tr.append($('<td ></td>').html(key+1));
						tr.append($('<td ></td>').html(spAdv.custName));
						tr.append($('<td ></td>').html(spAdv.itemName));
						tr.append($('<td ></td>').html(spAdv.orderDate));
						tr.append($('<td style="text-align:right;"></td>').html(spAdv.totalMrp));
						tr.append($('<td style="text-align:right;"></td>').html(spAdv.advAmt));
						totalAmt=totalAmt+spAdv.advAmt;
						totalMrp=totalMrp+spAdv.totalMrp;
						
						
					
$('#table_grid tbody')
	.append(
			tr);
			
})

var tr = $('<tr></tr>');
					
				
						tr.append($('<td></td>').html(""));
						tr.append($('<td></td>').html(""));
						tr.append($('<td></td>').html(""));
						tr.append($('<td></td>').html("Total"));
						tr.append($('<td style="text-align:right;"></td>').html(totalMrp.toFixed(2)));
						tr.append($('<td style="text-align:right;"></td>').html(totalAmt.toFixed(2)));
				
$('#table_grid tbody')
	.append(
			tr);

});
				

			
//}//if block
}
		
document.getElementById("pdf").disabled = true;

	</script>


<script type="text/javascript">

function getGrnDetail(headerId){
			//alert("HIII");
			//alert("header ID "+headerId)
			
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
		    var form = document.getElementById("validation-form");
		    form.action ="getGrnDetailList/"+headerId;
		    form.submit();
		}
</script>

<script type="text/javascript">
		function validate() {
		
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
			
			var headeIdText=$("#headeIdText").val();
		//	alert(headeIdText);
			
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
		//alert("Inside Gen Pdf ");

		

	// window.open('${pageContext.request.contextPath}/pdf?reportURL=pdf/getGrnPdf/'+fromDate+'/'+'/'+toDate+'/'+headerId+'/'+1+'/'+type);
		    
		    window.open('${pageContext.request.contextPath}/getSpAdvPdf');
		   
	}
	</script>

</body>
</html>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<style>
table, th, td {
	border: 1px solid #CCC;
}
</style>

<script>
	$(function() {
		$("#fromdatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
	
</script>
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


			<c:url var="getGrnData" value="/getGrnData" />



			<!--leftNav-->

			<jsp:include page="/WEB-INF/views/include/left.jsp">
				<jsp:param name="myMenu" value="${menuList}" />

			</jsp:include>


			<!--leftNav-->
			<!--rightSidebar-->

			<!-- Place Actual content of page inside this div -->
			<div class="sidebarright">


				<%-- 	<form
								action="${pageContext.request.contextPath}/insertGrnProcess"
								name="validation_form" id="validation_form" method="post">
								
 --%>
				<c:if test="${not empty alert}">
					<!-- here would be a message with a result of processing -->
					<div class="messages messagesErr">${alert}</div>
				</c:if>
				<div class="row">
					<div class="col-md-12">
					
					<div class="title_row_one">
						<div class="title_l_one">
							<h3 class="pageTitle"><i class="fa fa-birthday-cake" aria-hidden="true"></i> Request GRN</h3>
						</div>
						
						<div class="title_r_one">
							
							<form action="${pageContext.request.contextPath}/showGrn"
							name="search_form" id="search_form" method="get">
							<div class='colOuter'>
							
								<div class="top_Search_l">
									<div class="select_date_l">Select Date</div>
									<div class="select_area_l">
										<input id="fromdatepicker" class="texboxitemcode texboxcal" autocomplete="off"
											placeholder="Search Date" name="searchDate" type="text"
											value="${searchDate}">
									</div>
									<div class="select_search_btn">
										<input type="submit" name="" class="buttonsaveorder"
											value="Search">
									</div>								
								</div>
							
								
								
								
								<div class="right_grn_btn">
									<a href='${pageContext.request.contextPath}/showGrn'> <input
										type="button" name="" class="buttonsaveorder"
										value="Todays GRN"></a>
								</div>
							</div>
						</form>
						
						</div>
						<div class="clr"></div>
					</div>
					
					
						
						
					</div>
				</div>

				<div class="clearfix"></div>
				<form action="${pageContext.request.contextPath}/insertGrnProcess"
					onsubmit="submitGrn.disabled = true;return confirm('Do you really want to save ?');"
					name="validation_form" id="validation_form" method="post">


					<div class="title_margin">
					
					<div id="table-scroll">
						
						
							<!--	<table id="table_grid1" class="main-table">
								<thead>
									<tr class="bgpink">
										<th class="col-md-1">Invoice No</th>
										<th class="col-md-3">Name</th>
										<th class="col-md-2">Type</th>
										<th class="col-md-1">QTY</th>
										<th class="col-md-1">Bill Rate</th>
										<th class="col-md-1">Grn Rate</th>
										<th class="col-md-1">Edit Qty</th>
										<th class="col-md-1">Tax %</th>
										<th class="col-md-1">Taxable Amt</th>
										<th class="col-md-1">Tax Amt</th>
										<th class="col-md-1">Total Amt</th>
										<th class="col-md-1">Remark</th>
									</tr>

								</thead>
								<tbody>
							</table>-->
							<div class="tableFixHead">
								<table id="table_grid">
									<thead>
										<tr class="bgpink">
											<th class="col-md-1" style="text-align: center;">Invoice
												No</th>
											<th class="col-md-3" style="text-align: center;">Name</th>
											<th class="col-md-2" style="text-align: center;">Type</th>
											<th class="col-md-1" style="text-align: center;">QTY</th>
											<th class="col-md-1" style="text-align: center;">Rate</th>
											<!-- 	<th class="col-md-1">Grn Rate</th> -->
											<th class="col-md-1" style="text-align: center;">Edit
												Qty</th>
											<th class="col-md-1" style="text-align: center;">Tax %</th>
											<th class="col-md-1" style="text-align: center;">Taxable
												Amt</th>
											<th class="col-md-1" style="text-align: center;">Tax Amt</th>
											<th class="col-md-1" style="text-align: center;">Amount</th>
											<th class="col-md-1" style="text-align: center;">Remark</th>
										</tr>

									</thead>
									<tbody>


										<%-- 	
							<form
								action="${pageContext.request.contextPath}/insertGrnProcess"
								name="grn" id="grn" method="post">
								 --%>

										<c:forEach items="${grnConfList}" var="grnConfList"
											varStatus="count">
											<tr>

												<%-- 	<td>${count.index+1}</td> --%>
												<td class="col-md-1" style="text-align: center;"><c:out
														value="${grnConfList.invoiceNo}"></c:out></td>
												<td class="col-md-3" style="text-align: center;"><c:out
														value="${grnConfList.itemName}"></c:out></td>
														<td class="col-md-1" style="text-align: center;"><c:out
																value="${grnConfList.grnType}"></c:out></td>
												<%--Sac02Feb2021 <c:choose>
													<c:when test="${grnConfList.grnType==0}">
														<td class="col-md-1" style="text-align: center;"><c:out
																value="GRN 1(75%)"></c:out></td>
													</c:when>
													<c:when test="${grnConfList.grnType==1}">
														<td class="col-md-1" style="text-align: center;"><c:out
																value="GRN 2(90%)"></c:out></td>
													</c:when>
													<c:when test="${grnConfList.grnType==2}">
														<td class="col-md-1" style="text-align: center;"><c:out
																value="GRN 3(100%)"></c:out></td>
													</c:when>
													<c:when test="${grnConfList.grnType==3}">
														<td class="col-md-1" style="text-align: center;"><c:out
																value="No GRN"></c:out></td>
													</c:when>

													<c:when test="${grnConfList.grnType==4}">
														<td class="col-md-1" style="text-align: center;"><c:out
																value="GRN 3(100%)"></c:out></td>
													</c:when>
													<c:otherwise>
														<c:out value="No GRN"></c:out>
													</c:otherwise>

												</c:choose> --%>

												<td class="col-md-1" style="text-align: center;"><c:out
														value="${grnConfList.autoGrnQty}"></c:out> <input
													type="hidden" name="grnqty${grnConfList.billDetailNo}"
													id="grnqty${grnConfList.billDetailNo}" size="3"
													readonly="readonly" value="${grnConfList.autoGrnQty}" /></td>

												<td class="col-md-1" style="text-align: center;"
													id="grn_rate${grnConfList.billDetailNo}"><c:out
														value="${grnConfList.rate}"></c:out></td>


												<td class="col-md-1" style="text-align: center;"><input
													type="text" name="grnqtyauto${grnConfList.billDetailNo}"
													value="${grnConfList.autoGrnQty}"
													id='grnqtyauto${grnConfList.billDetailNo}' size="3"
													readonly
													onkeyup="calcGrn(${grnConfList.grnType},${grnConfList.rate},${grnConfList.itemId},
																	${grnConfList.sgstPer},${grnConfList.cgstPer},${grnConfList.autoGrnQty},${grnConfList.billDetailNo})" />


												</td>

												<td class="col-md-1" style="text-align: center;"
													id="tax_per${grnConfList.billDetailNo}"><c:out
														value="${grnConfList.taxPer}"></c:out></td>

												<fmt:formatNumber var="taxableAmt" type="number"
													minFractionDigits="2" maxFractionDigits="2"
													value="${grnConfList.taxableAmt}" />

												<c:set var="taxableAmt" value="${taxableAmt}" />

												<td id='taxable_amt${grnConfList.billDetailNo}'
													style="text-align: center;" class="col-md-1"><c:out
														value="${taxableAmt}"></c:out></td>


												<td style="text-align: center;"
													id='tax_amt${grnConfList.billDetailNo}' class="col-md-1"><c:out
														value="${grnConfList.taxAmt}"></c:out></td>

												<fmt:formatNumber var="grnAmt" type="number"
													minFractionDigits="2" maxFractionDigits="2"
													value="${grnConfList.grnAmt}" />

												<c:set var="grnAmt" value="${grnAmt}" />

												<td style="text-align: center;" class="col-md-1"
													id="grn_amt${grnConfList.billDetailNo}"><c:out
														value="${grnAmt}"></c:out></td>

												<td style="text-align: center;" class="col-md-1"><select
													name="grn_remark${grnConfList.billDetailNo}"
													style="width: 200px" required="required"
													id="grn_remark${grnConfList.billDetailNo}"
													class="form-control"
													onchange="changeQty(${grnConfList.billDetailNo},${grnConfList.autoGrnQty})">
														<option selected value="0">Goods Expired</option>
														<c:forEach items="${remarkList}" var="remarkList">
																${remarkList.remark}
																<option value="${remarkList.remark}">${remarkList.remark}</option>
														</c:forEach>
												</select></td>


											</tr>
										</c:forEach>


									</tbody>

								</table>
							</div>
						
					</div>
				</div>
					<c:if test="${searchDate==null}">
						<button type="submit" class="buttonsaveorder" id="submitGrn">Save</button>

					</c:if>



				</form>
			</div>
			<!--table end-->


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
	
	
	/*  function showEdit(id,itemId,autoGrnQty) {
		
		 var x=$("#is_edit"+itemId).val();
		 
		if(x == 1){
		 
			 $("#grnqtyauto"+itemId).removeAttr("readonly"); 
	    
		}
		if(x== 0)
			{
			$("#grnqtyauto"+itemId).html(autoGrnQty);

			 $("#grnqtyauto" +itemId).setAttr("readonly"); 
			// document.getElementById("grnqtyauto"+itemId).prop="disabled"; 
			
			}
	} */
	</script>

<script type="text/javascript">
	
	function changeQty(billDetailNo,autoQty){
		//alert("HIII "+ itemId);
		
		var remark = document.getElementById("grn_remark"+billDetailNo).value;
	 //	alert(remark);
	 	if(remark==0){
	 		//alert("In remark ==0");
			    document.getElementById("grnqtyauto"+billDetailNo).value=autoQty;
	 	}else{
			 $("#grnqtyauto"+billDetailNo).removeAttr("readonly"); 
	 	}
		 
	}
	
	</script>

<script type="text/javascript">
	
	function calcGrn(grnType,rate,itemId,sgstPer,cgstPer,autoQty,billDetailNo){
		
		
		var baseRate=rate*100/(sgstPer+cgstPer+100);
	
		var grnBaseRate;
		
		var grnRate;
		var grnQty=$("#grnqtyauto"+billDetailNo).val();
		
		if(parseInt(grnQty)>autoQty){
			alert("Edit Quantity can not be greater than Auto Quantity");
			document.getElementById("grnqtyauto"+billDetailNo).value=autoQty;
			//calcGrn(grnType,rate,itemId,sgstPer,cgstPer,autoQty)
		}else{
		
		/* Sac02Feb2021 if(grnType==0){
			var grnRate=$("#grn_rate"+billDetailNo).text();
			grnBaseRate = baseRate * 75 / 100;
			 grnRate=(rate * 75) / 100;
		} */
		var grnRate=$("#grn_rate"+billDetailNo).text();
		grnBaseRate = parseFloat(baseRate) *parseFloat(grnType) / 100;
		 grnRate=(parseFloat(rate) * parseFloat(grnType)) / 100;
		
	/* Sac02Feb2021 if(grnType==1){
			var grnRate=$("#grn_rate"+billDetailNo).text();
			grnBaseRate = baseRate * 90 / 100;
			grnRate=(rate * 90) / 100;
			}
			if(grnType==2){
			var grnRate=$("#grn_rate"+billDetailNo).text();
			grnBaseRate=baseRate;
			grnRate=rate;
			}
			if(grnType==4){
				var grnRate=$("#grn_rate"+billDetailNo).text();
				grnBaseRate=baseRate;
				grnRate=rate;
				} */
			
		var totTaxPer=parseFloat(sgstPer)+parseFloat(cgstPer);
			var taxableAmt=grnBaseRate*grnQty;
			var totalTax=taxableAmt*(cgstPer+sgstPer)/100;
			
			var grandTotal=taxableAmt+totalTax;
			/* alert(taxableAmt);
			alert(totalTax);
			alert(grandTotal);
			 */
		//$("#grn_rate"+itemId).html(baseRate.toFixed(2));

		$("#grn_amt"+billDetailNo).html(grandTotal.toFixed(2));
		$("#tax_per"+billDetailNo).html(totTaxPer.toFixed(2));
		
		$("#taxable_amt"+billDetailNo).html(taxableAmt.toFixed(2));

		$("#tax_amt"+billDetailNo).html(totalTax.toFixed(2));

		/* var x=$("#grn_remark"+itemId).val();
		if(grnQty>0){
		
		if(x ==null ||x == ""){
			alert("Enter Remark");
			
		    document.getElementById("grn_remark"+itemId).focus();
		    
		}
		} */
		
		}//end of else
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
});

	</script>



<script>
		function openNav() {
			document.getElementById("mySidenav").style.width = "100%";
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
		}
		function openNav1() {
			document.getElementById("mySidenav1").style.width = "100%";
		}

		function closeNav1() {
			document.getElementById("mySidenav1").style.width = "0";
		}
		function openNav3() {
			document.getElementById("mySidenav3").style.width = "100%";
		}

		function closeNav3() {
			document.getElementById("mySidenav3").style.width = "0";
		}
	</script>


<script type="text/javascript">

function getGrnData(id){
	
	
	var grnQty=$("#grnqtyauto"+id).val();
	var itemId=id;
	
	alert(grnQty);
	alert(itemId);
	
	$.getJSON('${getGrnData}',
			{
		
			qty:grnQty,
			id:itemId,
				 
				ajax : 'true',

}
);
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
})();}


	</script>

</body>
</html>

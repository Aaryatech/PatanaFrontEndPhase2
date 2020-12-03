

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<style>
.form-control {
	text-align: left !important;
}
</style>

</head>
<body>



	<c:url var="editFrSupplier" value="/editFrSupplier"></c:url>

	<!--datepicker-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
	<script>
		$(function() {
			$("#fromdatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
		$(function() {
			$("#todatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
	<!--datepicker-->

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<c:url var="findAddOnRate" value="/getAddOnRate" />
		<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
		<c:url var="findAllMenus" value="/getAllTypes" />
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



				<div class="sidebarright">

					<form name="frm_search" id="frm_search" method="post"
						action="${pageContext.request.contextPath}/insertSupplier">
						<input type="hidden" name="mod_ser" id="mod_ser"
							value="search_result">


						<div class="col-md- 3">

							<div class="col1title" style="float: left;">
								<h3>Add Supplier</h3>
							</div>
							<div class="col1title" style="float: right;">
								<a href="${pageContext.request.contextPath}/showOtherBill"><input
									type="button" value="Other Purchase Bill" class="btn btn-info">
								</a>
							</div>
						</div>

						<div class="colOuter">
							<div class="col-md-2">
								<div class="col1title" align="left">Supplier Name*:</div>
							</div>
							<div class="col-md-3">
								<input id="suppName" class="form-control alphaAndDotonly"
									autocomplete="off" placeholder="Supplier Name" name="suppName"
									maxlength="50" type="text" required> <input id="suppId"
									class="form-control" name="suppId" type="hidden">

							</div>
							<div class="col-md-1"></div>

							<div class="col-md-2">
								<div class="col1title" align="left">Supplier Address :</div>
							</div>
							<div class="col-md-3">
								<input id="suppAdd" class="form-control" autocomplete="off"
									maxlength="100" placeholder="Supplier Address" name="suppAdd"
									type="text">

							</div>

						</div>

						<div class="colOuter">
							<div class="col-md-2">
								<div class="col1title" align="left">Supplier City :</div>
							</div>
							<div class="col-md-3">
								<input id="city" class="form-control alphaAndDotonly"
									autocomplete="off" placeholder="Supplier City" name="city"
									type="text">

							</div>
							<div class="col-md-1"></div>

							<div class="col-md-2">
								<div class="col1title" align="left">Is Same State*:</div>
							</div>
							<div class="col-md-3">
								<select class="form-control" data-live-search="true"
									title="Please Select" name="isSameState" id="isSameState"
									required>
									<option value="">Select Option</option>
									<option value="1">Yes</option>
									<option value="2">No</option>
								</select>

							</div>

						</div>

						<div class="colOuter">
							<div class="col-md-2">
								<div class="col1title" align="left">Mobile No*:</div>
							</div>
							<div class="col-md-3">
								<input id="mob" class="form-control numbersOnly" maxlength="10"
									autocomplete="off" placeholder="Mobile No" name="mob"
									pattern="^\d{10}$" type="text" title="Enter 10 digit Mobile No"
									required>

							</div>
							<div class="col-md-1"></div>

							<div class="col-md-2">
								<div class="col1title" align="left">E-Mail :</div>
							</div>
							<div class="col-md-3">
								<input id="email" class="form-control" autocomplete="off"
									placeholder="Email" name="email" type="email">

							</div>

						</div>

						<div class="colOuter">
							<div class="col-md-2">
								<div class="col1title" align="left">GSTN No :</div>
							</div>
							<div class="col-md-3">
								<input id="gstnNo" class="alhanumeric form-control "
									maxlength="15" autocomplete="off" placeholder="GSTN No"
									name="gstnNo" style="text-transform: uppercase;" type="text">

							</div>
							<div class="col-md-1"></div>

							<div class="col-md-2">
								<div class="col1title" align="left">Pan No :</div>
							</div>
							<div class="col-md-3">
								<input id="panNo" class="form-control alhanumeric"
									autocomplete="off" maxlength="10"
									pattern="[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}"
									style="text-transform: uppercase;" placeholder="Pan No"
									name="panNo" type="text" title="Enter valid PAN Number">

							</div>

						</div>

						<div class="colOuter">
							<div class="col-md-2">
								<div class="col1title" align="left">FDA Licence :</div>
							</div>
							<div class="col-md-3">
								<input id="liceNo" class="form-control alhanumeric"
									autocomplete="off" placeholder="FDA Licence" name="liceNo"
									type="text">

							</div>
							<div class="col-md-1"></div>

							<div class="col-md-2">
								<div class="col1title" align="left">Credit Days*:</div>
							</div>
							<div class="col-md-3">
								<input id="creditDays" title="Enter  Numeric value"
									class="form-control numbersOnly" maxlength="3"
									autocomplete="off" placeholder="Credit Days" name="creditDays"
									pattern="[+-]?([0-9]*[.])?[0-9]+" type="text" required>

							</div>

						</div>
						<div class="colOuter">
							<div align="center">
								<input name="submit" class="buttonsaveorder" value="Submit"
									type="submit" align="center"> <input type="button"
									class="buttonsaveorder" value="Cancel" id="cancel"
									onclick="cancel1()" disabled>
							</div>

						</div>

						<div id="table-scroll" class="table-scroll">
							<div id="faux-table" class="faux-table" aria="hidden"></div>
							<div class="table-wrap">
								<table id="table_grid" class="main-table" border="1px">

									<thead>
										<tr class="bgpink">

											<th class="col-sm-1" style="text-align: center;">Sr No</th>
											<th class="col-md-2" style="text-align: center;">Name</th>
											<th class="col-md-3" style="text-align: center;">Address</th>
											<th class="col-md-1" style="text-align: center;">City</th>
											<th class="col-md-1" style="text-align: center;">Mobile</th>
											<th class="col-md-1" style="text-align: center;">Email</th>
											<th class="col-md-1" style="text-align: center;">Action</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${supplierList}" var="supplierList"
											varStatus="count">
											<tr>
												<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
												<td class="col-md-2"><c:out
														value="${supplierList.suppName}" /></td>
												<td class="col-md-3"><c:out
														value="${supplierList.suppAddr}" /></td>
												<td class="col-md-1"><c:out
														value="${supplierList.suppCity}" /></td>
												<td class="col-md-1"><c:out
														value="${supplierList.mobileNo}" /></td>
												<td class="col-md-1"><c:out
														value="${supplierList.email}" /></td>
												<td class="col-md-1" style="text-align: center;"><div>
														<abbr title='Edit'><i
															onclick="edit(${supplierList.suppId})" class='fa fa-edit'></i>
														</abbr> <a
															href="${pageContext.request.contextPath}/deleteSupplier/${supplierList.suppId}"
															onClick="return confirm('Are you sure want to delete this record');">
															<abbr title='Delete'><i class='fa fa-trash'></i></abbr>
														</a>

													</div></td>
											</tr>
										</c:forEach>
								</table>

							</div>
						</div>

					</form>


				</div>
				<!--tabNavigation-->
				<!--<div class="order-btn"><a href="#" class="saveOrder">SAVE ORDER</a></div>-->
				<%-- <div class="order-btn textcenter">
						<a
							href="${pageContext.request.contextPath}/showBillDetailProcess/${billNo}"
							class="buttonsaveorder">VIEW DETAILS</a>
						<!--<input name="" class="buttonsaveorder" value="EXPORT TO EXCEL" type="button">-->
					</div> --%>


			</div>
			<!--rightSidebar-->

		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->

	</div>
	<!--wrapper-end-->
	<!--easyTabs-->
	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->
	<script type="text/javascript">

jQuery('.numbersOnly').keyup(function() {
this.value = this.value.replace(/[^0-9\.]/g, '');
});
jQuery('.alphaonly').keyup(function() {
this.value = this.value.replace(/[^a-zA-Z\s]+$/, '');
});
jQuery('.alhanumeric').keyup(function() {
this.value = this.value.replace(/[^a-zA-Z0-9\-\s]+$/, '');
});
jQuery('.dob').keyup(function() {
this.value = this.value.replace(/[^a-zA-Z0-9\-\s]+$/, '');
});

jQuery('.alphaAndDotonly').keyup(function() {
this.value = this.value.replace(/[^a-zA-Z\. s]+$/, '');
});


</script>

	<script>
function edit(suppId) {
 
	  
	$('#loader').show();

	$
			.getJSON(
					'${editFrSupplier}',

					{
						 
						suppId : suppId, 
						ajax : 'true'

					},
					function(data) { 
						
						document.getElementById("suppId").value=data.suppId;
						document.getElementById("suppName").value=data.suppName;  
						document.getElementById("suppAdd").value=data.suppAddr;
						document.getElementById("city").value=data.suppCity;
						document.getElementById("mob").value=data.mobileNo;
						document.getElementById("email").value=data.email;
						document.getElementById("gstnNo").value=data.gstnNo;
						document.getElementById("panNo").value=data.panNo;
						document.getElementById("liceNo").value=data.suppFdaLic;
						document.getElementById("creditDays").value=data.suppCreditDays;
						document.getElementById("isSameState").value=data.isSameState; 
						document.getElementById("cancel").disabled=false;
					});

 
	   

}

function cancel1() {

    //alert("cancel");
	document.getElementById("suppId").value="";
	document.getElementById("suppName").value="";  
	document.getElementById("suppAdd").value="";
	document.getElementById("city").value="";
	document.getElementById("mob").value="";
	document.getElementById("email").value="";
	document.getElementById("gstnNo").value="";
	document.getElementById("panNo").value="";
	document.getElementById("liceNo").value="";
	document.getElementById("creditDays").value="";
	document.getElementById("isSameState").value=""; 
	document.getElementById("cancel").disabled=false;

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


	</script>

</body>
</html>

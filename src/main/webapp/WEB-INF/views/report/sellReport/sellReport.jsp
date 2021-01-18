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
						<h2 class="pageTitle"><i class="fa fa-file-o"></i> Daily Sales Report</h2>
					</div>
					
					<div class="on_off_row extra_margin">
						
						
						<input type="hidden" name="frId" id="frId" value="${frId}">
						<div class="pop_one">
							<div class="pop_one_txt margin_tp"> Date  </div>
							<div class="pop_one_inp">
							<input id="fromdatepicker" autocomplete="off"
								class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" placeholder="Delivery Date"
								name="fromDate" type="text">								
							</div>
					    </div>
					    
					    
					    <div class="buttons_right">
							<button class="buttonsaveorder" value="PDF" id="PDFButton"
							onclick="genPdf()">PDF</button>
							<button class="buttonsaveorder" value="Search" id="Search"
							onclick="genJSP()">Search</button>					
						</div>
					    
						
					</div>
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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!--easyTabs-->


<script type="text/javascript">
	function validate() {

		var date = $("#fromdatepicker").val();
		var isValid = true;

		if (date == "" || date == null) {

			isValid = false;
			alert("Please select Date");
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
		var isValid = validate();
		if (isValid == true) {
			var date = document.getElementById("fromdatepicker").value;

			window
					.open('${pageContext.request.contextPath}/showDailySalesReport/'
							+ date);
		}
	}
</script>


<script type="text/javascript">
	function genJSP() {
		var isValid = validate();
		if (isValid == true) {
			var date = document.getElementById("fromdatepicker").value;

			window
					.open('${pageContext.request.contextPath}/getDailySalesReport/'
							+ date);
		}
	}
</script>
</body>
</html>
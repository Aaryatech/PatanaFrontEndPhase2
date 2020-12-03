<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MONGINIS</title>
<html>
<head>
<!--     <meta charset="UTF-8" />
 -->
<title></title>
<link href="https://fonts.googleapis.com/css?family=Slabo+27px"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.12.0/semantic.min.css" />
<style type="text/css">
.ui.segment {
	position: relative;
	background-color: #fff;
	box-shadow: 0 0 0 0px rgba(0, 0, 0, 0), 0 0px 0px 0 rgba(0, 0, 0, 0);
	margin: 1rem 0;
	padding: 1em;
	border-radius: .2857rem;
	border: none;
}

body {
	font-family: 'Slabo 27px', serif;
	background-color: #ffffff;
}
</style>
</head>
<body>
	<!-- code goes here -->

	<!-- scripts -->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">
		
	</script>
	<script type="text/javascript"
		src="//cdn.rawgit.com/MrRio/jsPDF/master/dist/jspdf.min.js">
		
	</script>
	<script type="text/javascript"
		src="//cdn.rawgit.com/niklasvh/html2canvas/0.5.0-alpha2/dist/html2canvas.min.js">
		
	</script>

	<script type="text/javascript"
		src="<c:url value='/resources/appjs/app.js'/>"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>


	<!-- <script type="text/javascript">


document.body.onload = function()
{
	
	  createPDF2();
}
</script> 
 -->
</head>
<body onload="directPrint()">
	<div class="">
		<div class="wide column">
			<div class="ui segment">
				<!-- <div class="ui button aligned center teal" id="create_pdf">Download PDF</div>
				<div class="ui divider"></div> -->
				<form class="ui form">
					<table width="200" border="0" cellspacing="0" cellpadding="0"
						style="padding: 5px; font-family: verdana; font-size: 10px; border: 1px solid #E7E7E7;">
						<tbody>

							<tr>
								<td colspan="2" align="center"
									style="padding: 5px; border-bottom: 1px solid #E7E7E7;"><img
									src="${pageContext.request.contextPath}/resources/images/monginislogo.png"
									alt="logo" width="150px" height="80px"></td>
							</tr>
							<tr>
								<td colspan="2" align="center"
									style="padding: 10px; border-bottom: 1px solid #E7E7E7; font-size: 12px; font-weight: bold;"><p>ORDER
										MEMO</p></td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="250" border="0" cellspacing="0" cellpadding="0"
										style="padding: 5px; font-family: verdana; font-size: 12px; border: 1px solid #E7E7E7;">
										<tbody>
											<tr>
												<td width="20%" align="left"><strong>&nbsp;&nbsp;Shop:</strong></td>
												<td width="80%" align="left">${shopName}</td>
												<td width="0%"><strong></td>
											</tr>
											<tr>
												<td><strong>&nbsp;&nbsp;Tel:</strong></td>
												<td>${tel}</td>
												<td><strong></td>
											</tr>
											<tr>
												<td><strong>&nbsp;&nbsp;Date:</strong></td>
												<td>${currDate}</td>
												<td><strong></td>
											</tr>
											<tr>
												<td><strong>&nbsp;&nbsp;Time:</strong></td>
												<td>${currTime}</td>
												<td><strong></td>
											</tr>
											<tr>
												<td colspan="3"><table width="100%" border="0"
														cellspacing="0" cellpadding="5" class="tbl-inner">
														<tbody>
															<tr>
																<th align="left" bgcolor="#ECECEC">&nbsp;&nbsp;Name</th>
																<th bgcolor="#ECECEC">Kg.</th>
																<th bgcolor="#ECECEC">Rate</th>
																<th align="center" bgcolor="#ECECEC">Amt</th>
															</tr>
															<tr>
																<td><p style="font-size: 12px">&nbsp;&nbsp;${spCakeOrder.itemId}</p></td>
																<td align="center"><p style="font-size: 12px">${spCakeOrder.spSelectedWeight}</p></td>
																<td align="center"><p style="font-size: 12px">
																<fmt:formatNumber	type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${(spCakeOrder.spSubTotal)/spCakeOrder.spSelectedWeight}" />
																</p></td>
																<td align="right"><p style="font-size: 12px">${spCakeOrder.spSubTotal}&nbsp;&nbsp;</p></td>
															</tr>
															<tr>
																<td><p style="font-size: 12px">&nbsp;&nbsp;${flavourName}</p></td>
																<%--   <td align="center"><p style="font-size:12px"></p>Add Rate:</td>
            <td align="center"><p style="font-size:12px">${spCakeOrder.spTotalAddRate/spCakeOrder.spSelectedWeight}</p></td>
            <td align="right"><p style="font-size:12px">${spCakeOrder.spTotalAddRate}</p></td> --%>
															</tr>

															<!--   <tr>
            <td><p style="font-size:12px">##MESSAGE</p></td>
            <td align="center"><p style="font-size:12px"></p></td>
            <td align="center"><p style="font-size:12px">##FRATE</p></td>
            <td align="right"><p style="font-size:12px">##FAMT</p></td>
            </tr>
            
           
            
            
             -->

															<tr>
																<td><p style="font-size: 12px">&nbsp;&nbsp;${spCakeOrder.spInstructions}</p></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="right"><p style="font-size: 12px"></p></td>

															</tr>
															<tr>

																<td><small style="font-size: 12px;"></small></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="right"><p style="font-size: 12px"></p></td>
															</tr>
															<tr>

																<td><small style="font-size: 12px;"></small></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="center"><p style="font-size: 12px"></p></td>
																<td align="right"><p style="font-size: 12px"></p></td>
															</tr>
															<tr>
																<td rowspan="3">&nbsp;</td>
																<td colspan="2" align="right"><strong>Total
																		:</strong></td>
																<td align="right"><strong><fmt:formatNumber
																			type="number" maxFractionDigits="2"
																			minFractionDigits="2"
																			value="${spCakeOrder.spSubTotal}" /></strong>&nbsp;&nbsp;</td>
															</tr>
															<tr>
																<td colspan="2" align="right"><strong>Advance
																		:</strong></td>
																<td align="right"><strong>${spCakeOrder.spAdvance}&nbsp;&nbsp;</strong></td>
															</tr>
															<tr>
																<td colspan="2" align="right"><strong>Balance
																		:</strong></td>
																<td align="right"><strong>${spCakeOrder.rmAmount}&nbsp;&nbsp;</strong></td>
															</tr>
														</tbody>
													</table></td>
											</tr>
										</tbody>
									</table>


								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="100%" border="0" cellspacing="0" cellpadding="7">

										<tr>
											<td width="200"
												style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"><strong>Delivery
													Date : </strong> ${spCakeOrder.spDeliveryDate}</td>

										</tr>
										<tr>
											<td width="200"
												style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"><strong>Order
													No:</strong> ${spCakeOrder.spDeliveryPlace}</td>
										</tr>

									</table>

								</td>
							</tr>
							<tr>
								<td colspan="2" width="200"
									style="border-top: 1px solid #E7E7E7; border-right: 1px solid #E7E7E7; padding: 5px 7px;"><strong>Customer
										Name : </strong> ${spCakeOrder.spCustName}</td>

							</tr>
							<tr>
								<td colspan="2" width="200"
									style="border-top: 1px solid #E7E7E7; border-right: 1px solid #E7E7E7; padding: 5px 7px;"><strong>Customer
										Phno : </strong> ${spCakeOrder.spCustMobNo}</td>
							</tr>
							<tr>
								<td colspan="2"
									style="border-top: 1px solid #E7E7E7; border-right: 1px solid #E7E7E7; padding: 5px 7px;"><p
										style="font-size: 13px;">While we shall take every care to
										execute your order as per your instruction, We shall not be
										liable for delay/non delivery or for variations in the order
										and decoration due to circumstances beyond our control.</p>
									<p style="font-size: 13px;">Fresh cream items should be
										stored under refrigeration.Please present this receipt at the
										time of delivery. Order once given will not be
										cancelled/reversed at any cost.</p></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- scripts -->
	<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="//cdn.rawgit.com/niklasvh/html2canvas/0.5.0-alpha2/dist/html2canvas.min.js"></script>
	<script type="text/javascript" src="//cdn.rawgit.com/MrRio/jsPDF/master/dist/jspdf.min.js"></script>
	<script type="text/javascript" src="app.js"></script>
	 -->
	<!-- 	<script>
	 function directPrint()
	{
		 
		window.print();
		//window.close();
	} 
	
	</script>  -->
</body>
</html>

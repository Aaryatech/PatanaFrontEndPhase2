<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Current Stock Detail Print</title>
<head>
<meta charset="UTF-8" />
<title></title>
</head>
<style type="text/css">
<!--
.style2 {
	font-size: 14px
}

.style5 {
	font-size: 10px
}

.style6 {
	font-size: 9px
}

.style7 {
	font-size: 12px;
	font-weight: bold;
}

.style8 {
	font-size: 11px;
	font-weight: bold;
}
-->
</style>
</head>

</head>
<body>
<%-- <c:forEach items="${currentStockResponse}" var="frDetails" varStatus="count"> --%>
	<table width="250" border="0" cellspacing="0" cellpadding="0"
		style="padding: 5px; font-family: verdana; font-size: 10px; border: 1px solid #E7E7E7;">

		<tbody>
			<tr>
				<td align="right" style="padding: 0px;"></td>
			</tr>
				<tr>


					<td colspan="2" align="center" style="padding: 1px;"><p>Current Stock</p></td>

				</tr>
				<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-bottom: 1px solid #E7E7E7;"><p
						class="style2">
						<b>${frDetails.frName}</b><br /> <span
							style="font-size: 10px; font-family: Arial;"> </span>
					</p></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 3px; font-family: Arial; border-bottom: 1px solid #E7E7E7; font-size: 12px;"><p
						class="style5">
						<br /> <strong>${sessionScope.frDetails.frAddress}</strong><br /> <br />
						
                GSTIN:<strong>${sessionScope.frDetails.frGstNo}</strong><br/>
                 Phone:<strong>${sessionScope.frDetails.frMob}</strong><br/>
			</tr>
			
			<!-- <tr>
			<td colspan="2" align="center"
					style="padding: 3px; font-family: Arial; border-bottom: 1px solid #E7E7E7; font-size: 12px;"><p
						class="style5">
						<br />To, <strong>DEVOUR FOODS LLP</strong><br /> 
						<br />Village-Fatehpur,Dist-Patna<br /> 
						<br />GSTIN: <strong>10AACFF8396C1ZP</strong><br />
                       
               
                </p>
                </td>
			<tr> -->
			<tr>
				<td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="7">
						<tbody>
							<%-- <tr>
								<td style="font-size: 9px">Invoice No:</td>
								<td style="font-size: 10px"><b>${frDetails.invoiceNo}</b></td>
								<td style="font-size: 9px">Invoice Date:</td>

								<td style="font-size: 10px"><b>${frDetails.billDate}</b></td>
							</tr> --%>
							<%--  <tr>
      <td>Det No</td>
      <td colspan="3">${exBill.sellBillDetailNo}</td>
     
      </tr>  --%>
							<tr>
								<td colspan="4"><table width="100%" border="0"
										cellspacing="0" cellpadding="1" class="tbl-inner"><!--cellpading was 5   -->
										<tbody>
											<tr>
												<th width="30%" align="left" bgcolor="#ECECEC">itemName</th>
												<th width="13%" bgcolor="#ECECEC">Qty</th>
											</tr>
						
										<c:forEach items="${currentStockResponse.currentStockDetailList}" var="stock" varStatus="count">
										<c:set var="currentStock" value="0"/>
										<c:set  value="${stock.currentRegStock}" var="regCurrentStock"/>
												
												<tr>


													<td>
														<%-- <p style="font-size: 10px">${billDetails.itemHsncd}</p> --%>
														<p style="font-size: 10px">${stock.itemName} 
															</p>
													</td>
													
													<c:choose>
														<c:when test="${stType==1}">
															<c:choose>
																<c:when test="${regCurrentStock < 0}">
																	<c:set var="currentStock" value="${0}" />
																</c:when>
																<c:otherwise>
																	<c:set var="currentStock"
																		value="${regCurrentStock}" />
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:when test="${stType==2}">
																<c:choose>
																<c:when test="${regCurrentStock < 0}">
																	<c:set var="currentStock" value="${0}" />
																</c:when>
																<c:otherwise>
																	<c:set var="currentStock"
																		value="${regCurrentStock}" />
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${regCurrentStock < 0}">
																	<c:set var="currentStock" value="${0}" />
																</c:when>
																<c:otherwise>
																	<c:set var="currentStock" value="${regCurrentStock}" />
																</c:otherwise>
															</c:choose>

														</c:otherwise>
													</c:choose>
													
														<td align="center"><p style="font-size: 10px">
																		<p style="font-size: 10px">
																			<fmt:formatNumber type="number" maxFractionDigits="2"
																				value="${currentStock}" />
																		</p></td>
												</tr>
											</c:forEach>
											<%-- <tr>
												<!-- <td rowspan="3">&nbsp;</td> -->
												<td colspan="5" align="right"><span class="style7"><strong>Total
															Qty :</strong></span></td>
												<td align="right"><span class="style5"><strong>${qtySum}</strong></span></td>
											</tr>
											
											
											<tr>
												<td colspan="5" align="right"><span class="style7">
														Taxable Value:</span></td>
												<td align="right"><span class="style7"><fmt:formatNumber
															type="number" maxFractionDigits="2" value="${taxableSum}" /></span></td>
											</tr>
											
											
											<tr>
												<td colspan="5" align="right"><span class="style7">
														Cgst Value:</span></td>
												<td align="right"><span class="style7"><fmt:formatNumber
															type="number" maxFractionDigits="2" value="${cgstValue}" /></span></td>
											</tr>
											
											<tr>
												<td colspan="5" align="right"><span class="style7">
														Sgst Value:</span></td>
												<td align="right"><span class="style7"><fmt:formatNumber
															type="number" maxFractionDigits="2" value="${sgstValue}" /></span></td>
											</tr>
											<tr>
										<!-- 	<td rowspan="3">&nbsp;</td> -->
												<td colspan="5" align="right"><span class="style7">
											Total:</span></td>
												<td align="right"><span class="style7"><fmt:formatNumber
															type="number" maxFractionDigits="2" value="${totalSum}" /></span></td>
											</tr> --%>
										</tbody>
									</table></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			
			<!-- <tr>

				<td style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"
					colspan="6">Goods Received By</span>
				</td>
			</tr>

			<tr></tr>
			<tr>

				<td style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"
					colspan="2">Goods Checked By</span>
				</td>
			</tr> -->
			<tr>

				<td
					style="border-top: 1px solid #E7E7E7; padding: 20px 7px 2px 0px;">Authorised
					Sign</span>
				</td>
				<%-- <td width="100" align="center"
					style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"><strong>For
						${sessionScope.frDetails.frName}</strong></td> --%>


				<td
					style="border-top: 1px solid #E7E7E7; padding: 20px 0px 2px 7px;"><span>${sessionScope.frDetails.frName}</span>
				</td>
			</tr>
		</tbody>
	</table>
	<%-- </c:forEach> --%>
</body>
<body onload="directPrint()">
	<script>
		function directPrint() {

			window.print();
			//window.close();
		}
	</script>
</body>
</html>
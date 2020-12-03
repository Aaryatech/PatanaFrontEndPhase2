<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<!--rightNav
<script type="text/javascript">
jQuery(document).ready(function(){
	
	
	
});
</script>-->



<style>
.main-table tbody>tr:hover {
	background-color: #ffa;
}

.alert {
	padding: 15px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

a:link {
	color: black;
}

a:hover {
	color: black;
}
</style>



<c:url var="qtyValidation" value="/quantityValidation"></c:url>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->


<!--wrapper-start-->
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
			<div class="sidebarright">
				<c:choose>
					<c:when test="${isSameDayApplicable=='2'}">
						<c:if test="${not empty qtyMessage}">
							<div class="alert">
								<span class="closebtn"
									onclick="this.parentElement.style.display='none';">&times;</span>
								<strong>Alert!</strong> ${qtyMessage}
							</div>
						</c:if>
					</c:when>
				</c:choose>
				<div class="order-left">
					<h2 class="pageTitle"><i class="fa fa-birthday-cake" aria-hidden="true"></i> ${menuTitle} 
					
					<span class="sub_order">Order Date : ${orderDate}</span>
					<span class="sub_order">Delivery Date : ${deliveryDate}</span>
					
					</h2>
						
						
					<!-- <h3 class="pageTitle2"></h3> -->

					<input type="hidden" name="menuId" value="${menuId}"> <input
						type="hidden" name="rateCat" value="${frDetails.frRateCat}">
					<input type="hidden" value="${isSameDayApplicable}"
						id="isSameDayApplicable" />

				</div>




				<div class="order-right">
					<%-- <div class="ordermto2px">
						<div class="orderclose">Order Closing Time :</div>
						<div class="ordercloser2">
							<span>${toTime}</span>
						</div>
					</div> --%>
					<div class="ordermto10px">
						<div class="order-price">Total Amount :</div>
						<div class="order-amount">
							INR :
							<fmt:formatNumber type="number" minFractionDigits="2"
								groupingUsed="false" maxFractionDigits="2" value="${grandTotal}" />
						</div>


					</div>
				</div>

				<c:if test="${not empty message}">
					<!-- here would be a message with a result of processing -->
					<div class="messages messagesErr">${message}</div>
				</c:if>











				<form action="${pageContext.request.contextPath}/saveOrder"
					name="form1" method="post">
					<input type="hidden" name="menuTitle" value="${menuTitle}">
					<!-- <div class="col-md-4" style="float: left;"><input type="button" onclick="sortTable()" value="Sort ASC By Name"/>
<input type="button" onclick="reload()" value="Default"/></div> -->

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->
						<nav>
							<ul class="cd-tabs-navigation">

								<c:forEach var="tab" items="${subCatListTitle}" varStatus="loop">


									<c:choose>
										<c:when test='${loop.index==0}'>
											<li><a data-content='${tab.name}' href="#0"
												class="selected"
												onClick="javascript:se_tab_id('${loop.index}')">${tab.header}</a></li>

										</c:when>
										<c:otherwise>
											<li><a data-content='${tab.name}' href="#0"
												onClick="javascript:se_tab_id('${loop.index}')">${tab.header}</a></li>

										</c:otherwise>
									</c:choose>


								</c:forEach>

							</ul>
						</nav>
						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->

							<c:forEach var="tabs" items="${subCatListTitle}" varStatus="loop">


								<c:choose>
									<c:when test='${loop.index==0}'>
										<li data-content='${tabs.name}' class="selected">
									</c:when>
									<c:otherwise>
										<li data-content='${tabs.name}'>
									</c:otherwise>
								</c:choose>



								<div class="clearfix"></div>



								<div id="table-scroll" class="table-scroll">

									<div id="faux-table" class="faux-table" aria="hidden">
										<table id="table_grid" class="main-table" border="1px">
											<thead>
												<tr class="bgpink">
													<th class="col-md-2" style="text-align: center;">Item
														Name</th>
													<th class="col-md-1" style="text-align: center;">Min
														Quantity</th>
													<th class="col-md-1" style="text-align: center;">Quantity</th>
													<th class="col-md-1" style="text-align: center;">MRP</th>
													<th class="col-md-1" style="text-align: center;">Rate</th>
													<th class="col-md-1" style="text-align: center;">Total</th>
													<c:choose>
														<c:when test="${menuIdFc=='67'}">
															<th class="col-md-1">Order1</th>
														</c:when>
													</c:choose>
												</tr>
											</thead>
										</table>

									</div>
									<div class="table-wrap">

										<table id="table_grid1" class="main-table" border="1px">
											<thead>
												<tr class="bgpink">
													<th class="col-md-2" style="text-align: center;">Item
														Name</th>
													<th class="col-md-1" style="text-align: center;">Min
														Quantity</th>
													<th class="col-md-1" style="text-align: center;">Quantity</th>
													<th class="col-md-1" style="text-align: center;">MRP</th>
													<th class="col-md-1" style="text-align: center;">Rate</th>
													<th class="col-md-1" style="text-align: center;">Total</th>
													<c:choose>
														<c:when test="${menuIdFc=='67'}">
															<th class="col-md-1" style="text-align: center;">Order1</th>
														</c:when>
													</c:choose>
												</tr>
											</thead>
											<tbody>


												<c:set var="menuTime" value="${menu.timing}" />


												<c:forEach var="items" items="${itemList}" varStatus="loop">
													<c:if test="${items.subCatName eq tabs.name}">

														<c:choose>
															<c:when test="${frDetails.frRateCat=='1'}">
																<tr>

																	<td class="col-md-2"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1">${items.itemName}
																	</a></td>
																	<td class="col-md-1" style="text-align: right;">
																		<%-- <c:out
																			value='${items.minQty}' /> --%> <fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${items.minQty}" />
																	</td>

																	<td class="col-md-1" style="text-align: center;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<c:set var="itemRate1" value="${items.itemRate3}" />
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}'
																					class="tableInput numbersOnly floatOnly"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${itemRate1}',${items.id})"
																					autocomplete="off">
																			</c:when>
																			<c:otherwise>
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}'
																					class="tableInput numbersOnly floatOnly"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate1}',${items.id})"
																					autocomplete="off">
																			</c:otherwise>
																		</c:choose> <input type="hidden" value="${items.minQty}"
																		id="minqty${items.id}" /></td>
																	<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${items.itemMrp1}" /> <%-- <c:out
																			value='${items.itemMrp1}' /> --%></td>

																	<td class="col-md-1" style="text-align: right;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<fmt:formatNumber type="number" groupingUsed="false"
																					minFractionDigits="2" maxFractionDigits="2"
																					value="${itemRate1}" />
																				<%-- <c:out value='${itemRate1}' /> --%>
																				<c:set var="rate" value="${itemRate1}" />
																			</c:when>
																			<c:otherwise>
																				<fmt:formatNumber type="number"
																					minFractionDigits="2" groupingUsed="false"
																					maxFractionDigits="2" value="${items.itemRate1}" />
																				<%-- <c:out value='${items.itemRate1}' /> --%>
																				<c:set var="rate" value="${items.itemRate1}" />
																			</c:otherwise>
																		</c:choose></td>

																	<c:set var="qty" value="${items.itemQty}" />
																	<td class="col-md-1" id="total${items.id}"
																		style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${rate * qty}" /></td>


																	<c:choose>
																		<c:when test="${menuIdFc=='67'}">

																			<c:choose>
																				<c:when test="${flagRes==1}">
																					<c:set var="orderQty" value="0" />
																					<c:forEach var="orderListRes" items="${orderList}"
																						varStatus="cnt">
																						<c:choose>
																							<c:when test="${orderListRes.id==items.id}">
																								<c:set var="orderQty"
																									value="${orderListRes.orderQty}" />
																							</c:when>

																						</c:choose>

																					</c:forEach>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="${orderQty}" /></td>
																				</c:when>
																				<c:otherwise>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="0" /></td>
																				</c:otherwise>
																			</c:choose>
																		</c:when>
																	</c:choose>

																</tr>
															</c:when>

															<c:when test="${frDetails.frRateCat=='2'}">
																<tr>

																	<td class="col-md-1"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1">${items.itemName}
																	</a></td>
																	<td class="col-md-1"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${minQty}" /></td>
																	<td class="col-md-1" style="text-align: right;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<%-- <c:set var="itemRate2" value="${items.itemRate2+(items.itemRate2*marginPer/100)}"/> --%>
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate3}',${items.id})"
																					autocomplete="off">
																			</c:when>
																			<c:otherwise>
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate2}',${items.id})"
																					autocomplete="off">
																			</c:otherwise>
																		</c:choose> <input type="hidden" value="${items.minQty}"
																		id="minqty${items.id}" /></td>
																	<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${items.itemMrp2}" /></td>

																	<td class="col-md-1" style="text-align: right;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<fmt:formatNumber type="number"
																					minFractionDigits="2" groupingUsed="false"
																					maxFractionDigits="2" value="${itemRate2}" />
																				<c:set var="rate" value="${itemRate2}" />
																			</c:when>
																			<c:otherwise>
																				<fmt:formatNumber type="number"
																					minFractionDigits="2" groupingUsed="false"
																					maxFractionDigits="2" value="${items.itemRate2}" />
																				<c:set var="rate" value="${items.itemRate2}" />
																			</c:otherwise>
																		</c:choose></td>
																	<c:set var="qty" value="${items.itemQty}" />
																	<td id="total${items.id}" style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${rate * qty}" /></td>
																	<c:choose>
																		<c:when test="${menuIdFc=='67'}">
																			<c:choose>
																				<c:when test="${flagRes==1}">
																					<c:set var="orderQty" value="0" />
																					<c:forEach var="orderListRes" items="${orderList}"
																						varStatus="cnt">
																						<c:choose>
																							<c:when test="${orderListRes.id==items.id}">
																								<c:set var="orderQty"
																									value="${orderListRes.orderQty}" />
																							</c:when>

																						</c:choose>

																					</c:forEach>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="${orderQty}" /></td>
																				</c:when>
																				<c:otherwise>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="0" /></td>
																				</c:otherwise>
																			</c:choose>
																		</c:when>
																	</c:choose>

																</tr>
															</c:when>

															<c:when test="${frDetails.frRateCat=='3'}">
																<tr>

																	<td class="col-md-1"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1">${items.itemName}
																	</a></td>
																	<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${items.minQty}" /></td>
																	<td class="col-md-1" style="text-align: right;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<c:set var="itemRate3"
																					value="${items.itemRate3+(items.itemRate3*marginPer/100)}" />
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate3}',${items.id})"
																					autocomplete="off">
																			</c:when>
																			<c:otherwise>
																				<input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate3}',${items.id})"
																					autocomplete="off">
																			</c:otherwise>
																		</c:choose> <input type="hidden" value="${items.minQty}"
																		id="minqty${items.id}" /></td>
																	<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			groupingUsed="false" maxFractionDigits="2"
																			value="${items.itemMrp3}" /></td>

																	<td class="col-md-1" style="text-align: right;"><c:choose>
																			<c:when test="${menuIdFc==lateOrderMenu}">
																				<fmt:formatNumber type="number"
																					minFractionDigits="2" groupingUsed="false"
																					maxFractionDigits="2" value="${itemRate3}" />
																				<c:set var="rate" value="${itemRate3}" />
																			</c:when>
																			<c:otherwise>
																				<fmt:formatNumber type="number"
																					minFractionDigits="2" groupingUsed="false"
																					maxFractionDigits="2" value="${items.itemRate3}" />
																				<c:set var="rate" value="${items.itemRate3}" />
																			</c:otherwise>
																		</c:choose></td>
																	<c:set var="qty" value="${items.itemQty}" />
																	<td class="col-md-1" id="total${items.id}"
																		style="text-align: right;"><fmt:formatNumber
																			groupingUsed="false" type="number"
																			minFractionDigits="2" maxFractionDigits="2"
																			value="${rate * qty}" /></td>

																	<c:choose>
																		<c:when test="${menuIdFc=='67'}">
																			<c:choose>
																				<c:when test="${flagRes==1}">
																					<c:set var="orderQty" value="0" />
																					<c:forEach var="orderListRes" items="${orderList}"
																						varStatus="cnt">
																						<c:choose>
																							<c:when test="${orderListRes.id==items.id}">
																								<c:set var="orderQty"
																									value="${orderListRes.orderQty}" />
																							</c:when>

																						</c:choose>

																					</c:forEach>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="${orderQty}" /></td>
																				</c:when>
																				<c:otherwise>
																					<td class="col-md-1" style="text-align: right;"><fmt:formatNumber
																							type="number" minFractionDigits="2"
																							groupingUsed="false" maxFractionDigits="2"
																							value="0" /></td>
																				</c:otherwise>
																			</c:choose>
																		</c:when>
																	</c:choose>
																</tr>
															</c:when>
														</c:choose>

													</c:if>
												</c:forEach>

											</tbody>

										</table>
									</div>
								</div>






							</c:forEach>


						</ul>
					</div>
					<!--tabNavigation-->

					<!--<div class="order-btn"><a href="#" class="saveOrder">SAVE ORDER</a></div>-->
					<div class="order-btn textcenter">

						<input name="" class="buttonsaveorder" value="SAVE ORDER"
							type="button" ONCLICK="button1()">
					</div>



				</form>

			</div>
			<!--rightSidebar-->

		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->

</div>
<!--wrapper-end-->

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

<!--easyTabs-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<!--easyTabs-->

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
<%-- <div class="modal fade kot-popup" id="confirm">
	<div class="modal-dialog modal-md">
		<!--modal-lg-->
		<div class="modal-content kot_content">
			<button type="button" class="close kot_close" data-dismiss="modal">
				<img
					src="${pageContext.request.contextPath}/resources/assets/img/popup_close.png"
					alt="">
			</button>

			<div class="pop_logo">
				<img
					src="${pageContext.request.contextPath}/resources/assets/img/dashboard_logo.png"
					class="img-fluid" alt="Logo">
			</div>
			<div class="pop_signup" id="popupheading">Are you sure?</div>
			<p class="confirm_txt">It is a long established fact that a
				reader will be distracted by the readable content of a page when
				looking at its layout.</p>
			<div class="pop_btn_cntr">
				<button type="button" data-dismiss="modal"
					class="button_place  popup submitmodel" id="submitOrder">Submit
				</button>
				<button type="button" data-dismiss="modal"
					class="button_place popup" id="cancelOrder">Cancel</button>
			</div>

		</div>
	</div>
</div> --%>
<script type="text/javascript">
$('.floatOnly').bind("cut copy paste",function(e) {
    e.preventDefault();
});
            function button1()
            {

            	 /* $('#popupheading').html("Confirm Save ?"); 
            	 $('#confirm').show();
            	 $('#confirm')
			        .modal({ backdrop: 'static', keyboard: false });
			              
				  $(".submitmodel").unbind().click(function() {
					 
				  }); */
				  form1.submit();
                
    		/* 	if(isSameDayApplicable!=2)
    				{
    				   form1.submit();
    				}
    		else if(isSameDayApplicable==2)
    				{
   			   
    				  $.getJSON(
    							'${qtyValidation}',
    							{
    								
    								ajax : 'true'
    							},
    							function(data) {
    							
    							//	alert(data.error);
        							
   								if (data.error) {
   								//	alert("hii");
    									alert(data.message);
    									 window.location.reload();
    								
    								}
    								else
    								{
    									 form1.submit();
    								
    								}	
    							});
    				}   
 */
            }    
           
        </script>

<script type="text/javascript">
		function onChange(rate,id) {

			//calculate total value  
			var qty = $('#'+id).val();
			 
			if(qty==""){
				 
					 var total =0;
					 
					alert("Please Enter Qty Multiple of Minimum Qty");
					$('#'+id).val('0');
					
					$('#total'+id).html(total);
					$('#'+id).focus();
				 
			}else{
				var minqty = $('#minqty'+id).val();
				
				if(qty % minqty==0){
				    var total = (rate * qty);
				    total=total.toFixed(2);
				   $('#total'+id).html(total);
				}else
				{
					 var total =0;
					 
					alert("Please Enter Qty Multiple of Minimum Qty");
					$('#'+id).val('0');
					
					$('#total'+id).html(total);
					$('#'+id).focus();
				}
			}
			
			
		}
	</script>


<script type="text/javascript">
jQuery('.numbersOnly').keyup(function() {
	 this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
	  var number = ($(this).val().split('.'));
	  if (number[1].length > 2)
	   {
	       var data = parseFloat($(this).val());
	       $(this).val(data.toFixed(2));
	   }
	});
 
		function onKeyDown(id) {
			alert("alert");
			var e = $('#'+id).val();
			
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
		             // Allow: Ctrl/cmd+A
		            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+C
		            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+X
		            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: home, end, left, right
		            (e.keyCode >= 35 && e.keyCode <= 39)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        // Ensure that it is a number and stop the keypress
		        if (((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
		            e.preventDefault();
		        }
		   
			
		}
</script>
<script type="text/javascript">
$(document).ready(function() {
    $("#5").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl/cmd+A
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+C
            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+X
            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if (((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
            e.preventDefault();
        }
    });
});
</script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>

<script>
function sortTable() {
  var table, rows, switching, i, x, y, shouldSwitch;
  table = document.getElementById("table_grid1");
  switching = true;
  /*Make a loop that will continue until
  no switching has been done:*/
  while (switching) {
    //start by saying: no switching is done:
    switching = false;
    rows = table.getElementsByTagName("TR");
    /*Loop through all table rows (except the
    first, which contains table headers):*/
    for (i = 1; i < (rows.length - 1); i++) {
      //start by saying there should be no switching:
      shouldSwitch = false;
      /*Get the two elements you want to compare,
      one from current row and one from the next:*/
      x = rows[i].getElementsByTagName("TD")[0];
      y = rows[i + 1].getElementsByTagName("TD")[0];
      //check if the two rows should switch place:
      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
        //if so, mark as a switch and break the loop:
        shouldSwitch = true;
        break;
      }
    }
    if (shouldSwitch) {
      /*If a switch has been marked, make the switch
      and mark that a switch has been done:*/
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }
}
</script>
<script>
function reload() {
    location.reload();
}
</script>
</body>
</html>

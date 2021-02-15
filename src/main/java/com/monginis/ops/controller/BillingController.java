package com.monginis.ops.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Month;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.billing.GetBillDetail;
import com.monginis.ops.billing.GetBillDetailsResponse;
import com.monginis.ops.billing.GetBillHeader;
import com.monginis.ops.billing.GetBillHeaderResponse;
import com.monginis.ops.billing.Info;
import com.monginis.ops.billing.SellBillDataCommon;
import com.monginis.ops.billing.SellBillDetail;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.AllItemsListResponse;
import com.monginis.ops.model.CategoryList;
import com.monginis.ops.model.CategoryListResponse;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetRepTaxSell;
import com.monginis.ops.model.GetSellBillHeader;
import com.monginis.ops.model.Item;
import com.monginis.ops.model.MCategory;
import com.monginis.ops.model.MCategoryList;
import com.monginis.ops.model.PostFrItemStockHeader;
import com.monginis.ops.model.SellBillDetailList;
import com.monginis.ops.model.SubCategory;
import com.monginis.ops.model.billing.Currency;
import com.monginis.ops.model.billing.FrBillHeaderForPrint;
import com.monginis.ops.model.billing.FrBillPrint;
import com.monginis.ops.model.billing.FranchiseeList;
import com.monginis.ops.model.billing.GetBillDetailPrint;
import com.monginis.ops.model.billing.SlabwiseBillList;


@Controller
@Scope("session")
public class BillingController {
	
	
	public GetBillHeaderResponse billHeadeResponse;
	public List<GetBillDetail> billDetailsList;
	PostFrItemStockHeader frItemStockHeader;
	int runningMonth;
	
	@RequestMapping(value = "/showBill", method = RequestMethod.GET)
	public ModelAndView showBill(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();

		try {
		     HttpSession session = request.getSession();
		     Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		     RestTemplate restTemplate = new RestTemplate();
				//-----------------------Start Of Month Logic------------------------

		 	try {
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", frDetails.getFrId());
				
				com.monginis.ops.model.Info info= restTemplate.postForObject(Constant.URL + "checkIsMonthClosed", map,
						com.monginis.ops.model.Info.class);
				
				
				//System.out.println(" 	"+info.toString() );

			if (info.isError()) {

				
				//System.out.println("need to complete Month End ......" );

				 modelAndView = new ModelAndView("stock/stockdetails");
				modelAndView.addObject("message","Please do month end process first");
				
				List<MCategory> mAllCategoryList = new ArrayList<MCategory>();

				CategoryList categoryList = new CategoryList();
				
				try {
					 map = new LinkedMultiValueMap<String, Object>();
					map.add("frId", frDetails.getFrId());
					
					List<PostFrItemStockHeader> list = restTemplate.postForObject(Constant.URL + "getCurrentMonthOfCatId", map,
							List.class);
					
					//System.out.println("list " + list);

					frItemStockHeader = restTemplate.postForObject(Constant.URL + "getRunningMonth", map,
							PostFrItemStockHeader.class);
					
					//System.out.println("Fr Opening Stock "+frItemStockHeader.toString());
					runningMonth = frItemStockHeader.getMonth();
					
					int monthNumber = runningMonth;
					String mon=Month.of(monthNumber).name();
					
					//System.err.println("Month name "+mon);
					modelAndView.addObject("getMonthList", list);
					

				} catch (Exception e) {
					//System.out.println("Exception in runningMonth" + e.getMessage());
					e.printStackTrace();

				}

				boolean isMonthCloseApplicable = true;

				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				java.util.Date date = new java.util.Date();
				//System.out.println(dateFormat.format(date));

				Calendar cal = Calendar.getInstance();
				cal.setTime(date);

				Integer dayOfMonth = cal.get(Calendar.DATE);

				Integer calCurrentMonth = cal.get(Calendar.MONTH) + 1;
				//System.out.println("Current Cal Month " + calCurrentMonth);

				//System.out.println("Day Of Month is: " + dayOfMonth);

				if (dayOfMonth == Constant.dayOfMonthEnd && runningMonth != calCurrentMonth) {

					isMonthCloseApplicable = true;
					//System.out.println("Day Of Month End ......" );

				}

				try {
 
					categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory", CategoryList.class);

				} catch (Exception e) {
					//System.out.println("Exception in getAllGategory" + e.getMessage());
					e.printStackTrace();

				}

				mAllCategoryList = categoryList.getmCategoryList();

				//System.out.println(" All Category " + mAllCategoryList.toString());

				modelAndView.addObject("category", mAllCategoryList);
				modelAndView.addObject("isMonthCloseApplicable", isMonthCloseApplicable);
				
				return modelAndView;
				
			}
			
			} catch (Exception e) {
				//System.out.println("Exception in runningMonth" + e.getMessage());
				e.printStackTrace();

			}
		//-----------------------End Of Month Logic------------------------
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
				Date date = new Date();				
				//System.out.println(dateFormat.format(date));
				
				
				int frId=frDetails.getFrId();
				
				
				map.add("fromDate", dateFormat.format(date));
				
				map.add("toDate", dateFormat.format(date));
				
				map.add("frId", frId);
				
			
				
				ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
				};
				ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
						HttpMethod.POST, new HttpEntity<>(map), typeRef);
				
				billHeadeResponse = responseEntity.getBody();	

				billHeader = billHeadeResponse.getGetBillHeaders();
				modelAndView.addObject("fromDate", dateFormat.format(date));
				modelAndView.addObject("toDate", dateFormat.format(date));
				
				modelAndView.addObject("billHeader",billHeader);
		}
		catch(Exception e)
		{
			//System.out.println("Exception in showBill"+e.getMessage());
		}
		return modelAndView;

	}
	
	
	@RequestMapping(value = "/showBillProcess", method = RequestMethod.POST)
	public ModelAndView   showBillProcess(HttpServletRequest request,
			HttpServletResponse response) {
		
		//System.out.println("inside show bill process");

		
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();
		
		
		ModelAndView modelAndView = new ModelAndView("billing/showBill");
		
		try {
		
		RestTemplate restTemplate = new RestTemplate();
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		String fromDate= request.getParameter("from_datepicker");
		
		String toDate= request.getParameter("to_datepicker");
		
		modelAndView.addObject("fromDate",fromDate);
		modelAndView.addObject("toDate",toDate);
		
		int frId=frDetails.getFrId();
		
		
		map.add("fromDate", fromDate);
		
		map.add("toDate", toDate);
		
		map.add("frId", frId);
		
	
		
		ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
		};
		ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);
		
		billHeadeResponse = responseEntity.getBody();	

		billHeader = billHeadeResponse.getGetBillHeaders();
		//System.out.println("billHeader"+billHeader.toString());
		modelAndView.addObject("billHeader",billHeader);
		
		}catch (Exception e) {
			
			//System.out.println("ex in getting bills "+e.getMessage());
			e.printStackTrace();
		}
		return modelAndView;
	
	}
	
	
	@RequestMapping(value = "/showBillDetailProcess", method = RequestMethod.GET)
	public ModelAndView   showBillDetailProcess(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/billDetails");
		
		try {
			
		String billNo=request.getParameter("billNo");
		String billDate=request.getParameter("billDate");
		String billStatus=request.getParameter("billStatus");
		String grandTotal=request.getParameter("grandTotal");
		
		String invNo=request.getParameter("Inv");
		//System.out.println("billNo: "+billNo +"  Date : "+billDate +"  billStatus :"+billStatus);
		
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		map.add("billNo", billNo);

		GetBillDetailsResponse billDetailsResponse = restTemplate.postForObject(Constant.URL + "getBillDetails",
				map, GetBillDetailsResponse.class);

		billDetailsList = new ArrayList<GetBillDetail>();
		billDetailsList = billDetailsResponse.getGetBillDetails();
		
		modelAndView.addObject("billDetailsList",billDetailsList);
		
		modelAndView.addObject("billDate", billDate);
		modelAndView.addObject("billNo", billNo);
		modelAndView.addObject("billStatus", billStatus);
		modelAndView.addObject("grandTotal", grandTotal);
		
		modelAndView.addObject("invoiceNo", invNo);
		
		}catch (Exception e) {
		//System.out.println("ex in bill detail "+e.getMessage());
		e.printStackTrace();
		}
		
		
		
	return modelAndView;
	
}
	
	
	
	@RequestMapping(value = "/updateBillStatus", method = RequestMethod.GET)
	public @ResponseBody void updateBillStatus(HttpServletRequest request,
		HttpServletResponse response) {
		
		
		String billNo=request.getParameter("billNo");
		//System.out.println("Bill No : "+ billNo);
		
		try {
			GetBillHeader getBillHeader=new GetBillHeader();
			 List<GetBillHeader> getBillHeaders=billHeadeResponse.getGetBillHeaders();
			 
			 //System.out.println("Header List "+getBillHeaders.toString());
		for(int i=0;i<billHeadeResponse.getGetBillHeaders().size();i++)
		{
			if(billHeadeResponse.getGetBillHeaders().get(i).getBillNo()==Integer.parseInt(billNo))
			{
				getBillHeader=billHeadeResponse.getGetBillHeaders().get(i);
				
			}
		}
		
		getBillHeader.setStatus(2);
		
		SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
		TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
		
		Date d = new Date();
		sdf.setTimeZone(istTimeZone);
		
		String strtime = sdf.format(d);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		//System.out.println("************* Date Time " + dateFormat.format(cal.getTime()));
		
		//getBillHeader.setBillDateTime(dateFormat.format(cal.getTime()));
		getBillHeader.setTime(strtime);
		RestTemplate restTemplate = new RestTemplate();
		try {
			
		Info info = restTemplate.postForObject(Constant.URL + "updateBillStatus", getBillHeader,
					Info.class);

			//System.out.println("Message :   "+info.getMessage());
			//System.out.println("Error  :    "+info.getError());
			if(info.getError()==false) {
			
			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frDetails.getFrId());

			SellBillDataCommon sellBillResponse = restTemplate
					.postForObject(Constant.URL + "/showNotDayClosedRecord", map, SellBillDataCommon.class);

			if (!sellBillResponse.getSellBillHeaderList().isEmpty()) {

				List<SellBillHeader> sellBillHeaderList = sellBillResponse.getSellBillHeaderList();

				int count = sellBillHeaderList.size();
				SellBillHeader billHeader = sellBillResponse.getSellBillHeaderList().get(0);

				map = new LinkedMultiValueMap<String, Object>();

				map.add("billNo", billHeader.getSellBillNo());

				SellBillDetailList sellBillDetailList = restTemplate
						.postForObject(Constant.URL + "/getSellBillDetails", map, SellBillDetailList.class);

				List<SellBillDetail> sellBillDetails = sellBillDetailList.getSellBillDetailList();
				if (sellBillDetails.size() > 0) {

					for (int x = 0; x < sellBillDetails.size(); x++) {

						billHeader
								.setTaxableAmt(billHeader.getTaxableAmt() + sellBillDetails.get(x).getTaxableAmt());

						billHeader.setTotalTax(billHeader.getTotalTax() + sellBillDetails.get(x).getTotalTax());
						billHeader
								.setGrandTotal(sellBillDetails.get(x).getGrandTotal() + billHeader.getGrandTotal());

						// billHeader.setBillDate(billHeader.getBillDate());

						billHeader.setDiscountPer(billHeader.getDiscountPer());

					}
					billHeader.setGrandTotal(Math.round(billHeader.getGrandTotal()));
					billHeader.setPaidAmt(billHeader.getGrandTotal());
					billHeader.setPayableAmt(billHeader.getGrandTotal());

					//System.err.println("bill Header data for Day close " +billHeader.toString());

					String start_dt =billHeader.getBillDate();
					DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy"); 
					Date date = (Date)formatter.parse(start_dt);
				
					SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
					String finalString = newFormat.format(date);
					billHeader.setBillDate(finalString);

						billHeader = restTemplate.postForObject(Constant.URL + "saveSellBillHeader", billHeader,
								SellBillHeader.class);

						//System.out.println("Bill Header Response " + billHeader.toString());
					
				} else {

					// update time
				String	curDateTime = dateFormat.format(cal.getTime());

					map = new LinkedMultiValueMap<String, Object>();

					DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Calendar cal2 = Calendar.getInstance();

					map.add("sellBillNo", billHeader.getSellBillNo());

					java.util.Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(curDateTime);

					Calendar caleInstance = Calendar.getInstance();

					caleInstance.setTime(date);
						caleInstance.set(Calendar.SECOND, (caleInstance.get(Calendar.SECOND) + 5));
						
						String incTime=dateFormat2.format(caleInstance.getTime());

					//System.out.println("*****Calender Gettime == " + caleInstance.getTime());

					//System.out.println("*****Inc time Gettime == " + incTime);

					map.add("timeStamp", incTime);

					Info updateSellBillTimeStamp = restTemplate.postForObject(Constant.URL + "updateSellBillTimeStamp", map,
							Info.class);

				}

			}
			}
	
		}catch (Exception e) {
			//System.out.println(e.getMessage());
		}
	}catch (Exception e) {
		//System.out.println("ex in update bill "+e.getMessage());
		e.printStackTrace();
	}
		
	}

	@RequestMapping(value = "/showGrnItem", method = RequestMethod.GET)
	public ModelAndView   showGrnItems(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/grnItemExpiry");
		
		try {

			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
			RestTemplate restTemplate = new RestTemplate();
			AllItemsListResponse	allItemsListResponse = restTemplate.getForObject(Constant.URL + "getAllItems",
					AllItemsListResponse.class);
			List<Item> itemList=new ArrayList<>();
			for(int i=0;i<allItemsListResponse.getItems().size();i++)
			{
				if(allItemsListResponse.getItems().get(i).getItemGrp1()==1 || allItemsListResponse.getItems().get(i).getItemGrp1()==2 || allItemsListResponse.getItems().get(i).getItemGrp1()==4)
				{
					itemList.add(allItemsListResponse.getItems().get(i));
				}
				
			}
			
			modelAndView.addObject("itemList",itemList);
			String itemIds[] = request.getParameterValues("itemId");
			//System.out.println("itemIds"+itemIds);
			 String itemId = Arrays.toString(itemIds);
			 itemId = itemId.substring(1, itemId.length()-1).replace(" ", ",");
				//System.out.println("itemIds"+itemId);
			String searchType=request.getParameter("searchType");
			if(searchType!=null && searchType!="")
			{
				if(searchType.equals("1"))
				{
					String expiryDate=request.getParameter("expiry_date");
					
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

					map.add("frId", frDetails.getFrId());
					map.add("expiryDate",DateConvertor.convertToYMD(expiryDate));
					List<GetBillDetail> billDetailsResponse = restTemplate.postForObject(Constant.URL + "getGrnItemsByExpiryDate",
							map, List.class);

					modelAndView.addObject("billDetailsList",billDetailsResponse);
					modelAndView.addObject("expiryDate",expiryDate);
					modelAndView.addObject("itemId","");
				}else if(itemId!=null && itemId!="") {
					/*if(itemId.length()>1) {
					    itemId = itemId.substring(1, itemId.length() - 1);
			            itemId = itemId.replaceAll("\"", "");
					}*/
			            MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			            map.add("frId", frDetails.getFrId());
						map.add("ids",itemId);
						List<GetBillDetail> billDetailsResponse = restTemplate.postForObject(Constant.URL + "getGrnItemsByIds",
								map, List.class);
						modelAndView.addObject("billDetailsList",billDetailsResponse);
						modelAndView.addObject("itemId",itemId);
						modelAndView.addObject("expiryDate","");
				}
				
			}
			modelAndView.addObject("searchType",searchType);
		}catch (Exception e) {
		e.printStackTrace();
		}
		
	return modelAndView;
	
}
	
	/****************************************************************************/
	@RequestMapping(value = "/genPurchaseBillPdf", method = RequestMethod.GET)
	public ModelAndView  genPurchaseBillPdf(HttpServletRequest request,
			HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView("billing/matrixBillPdf/purchsBillList");
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();

		try {
		     HttpSession session = request.getSession();
		     Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		     RestTemplate restTemplate = new RestTemplate();
				//-----------------------Start Of Month Logic------------------------

		 	try {
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", frDetails.getFrId());
				
				com.monginis.ops.model.Info info= restTemplate.postForObject(Constant.URL + "checkIsMonthClosed", map,
						com.monginis.ops.model.Info.class);
				
				
				//System.out.println(" 	"+info.toString() );

			if (info.isError()) {

				
				//System.out.println("need to complete Month End ......" );

				 modelAndView = new ModelAndView("stock/stockdetails");
				modelAndView.addObject("message","Please do month end process first");
				
				List<MCategory> mAllCategoryList = new ArrayList<MCategory>();

				CategoryList categoryList = new CategoryList();
				
				try {
					 map = new LinkedMultiValueMap<String, Object>();
					map.add("frId", frDetails.getFrId());
					
					List<PostFrItemStockHeader> list = restTemplate.postForObject(Constant.URL + "getCurrentMonthOfCatId", map,
							List.class);
					
					//System.out.println("list " + list);

					frItemStockHeader = restTemplate.postForObject(Constant.URL + "getRunningMonth", map,
							PostFrItemStockHeader.class);
					
					//System.out.println("Fr Opening Stock "+frItemStockHeader.toString());
					runningMonth = frItemStockHeader.getMonth();
					
					int monthNumber = runningMonth;
					String mon=Month.of(monthNumber).name();
					
					//System.err.println("Month name "+mon);
					modelAndView.addObject("getMonthList", list);
					

				} catch (Exception e) {
					//System.out.println("Exception in runningMonth" + e.getMessage());
					e.printStackTrace();

				}

				boolean isMonthCloseApplicable = true;

				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
				java.util.Date date = new java.util.Date();
				//System.out.println(dateFormat.format(date));

				Calendar cal = Calendar.getInstance();
				cal.setTime(date);

				Integer dayOfMonth = cal.get(Calendar.DATE);

				Integer calCurrentMonth = cal.get(Calendar.MONTH) + 1;
				//System.out.println("Current Cal Month " + calCurrentMonth);

				//System.out.println("Day Of Month is: " + dayOfMonth);

				if (dayOfMonth == Constant.dayOfMonthEnd && runningMonth != calCurrentMonth) {

					isMonthCloseApplicable = true;
					//System.out.println("Day Of Month End ......" );

				}

				try {
 
					categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory", CategoryList.class);

				} catch (Exception e) {
					//System.out.println("Exception in getAllGategory" + e.getMessage());
					e.printStackTrace();

				}

				mAllCategoryList = categoryList.getmCategoryList();

				//System.out.println(" All Category " + mAllCategoryList.toString());

				modelAndView.addObject("category", mAllCategoryList);
				modelAndView.addObject("isMonthCloseApplicable", isMonthCloseApplicable);
				
				return modelAndView;
				
			}
			
			} catch (Exception e) {
				//System.out.println("Exception in runningMonth" + e.getMessage());
				e.printStackTrace();

			}
		//-----------------------End Of Month Logic------------------------
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
				Date date = new Date();				
				//System.out.println(dateFormat.format(date));
				
				
				int frId=frDetails.getFrId();
				
				
				map.add("fromDate", dateFormat.format(date));
				
				map.add("toDate", dateFormat.format(date));
				
				map.add("frId", frId);
				
			
				
				ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
				};
				ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
						HttpMethod.POST, new HttpEntity<>(map), typeRef);
				
				billHeadeResponse = responseEntity.getBody();	

				billHeader = billHeadeResponse.getGetBillHeaders();
				modelAndView.addObject("fromDate", dateFormat.format(date));
				modelAndView.addObject("toDate", dateFormat.format(date));
				
				modelAndView.addObject("billHeader",billHeader);
		}
		catch(Exception e)
		{
			//System.out.println("Exception in showBill"+e.getMessage());
		}
		return modelAndView;

	}
	
	@RequestMapping(value = "/getPurchaseBillPdf", method = RequestMethod.POST)
	public ModelAndView   getPurchaseBillPdf(HttpServletRequest request,
			HttpServletResponse response) {
		
		//System.out.println("inside show bill process");

		
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		
		List<GetBillHeader> billHeader=new ArrayList<GetBillHeader>();
		
		
		ModelAndView modelAndView = new ModelAndView("billing/matrixBillPdf/purchsBillList");
		
		try {
		
		RestTemplate restTemplate = new RestTemplate();
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		String fromDate= request.getParameter("from_datepicker");
		
		String toDate= request.getParameter("to_datepicker");
		
		modelAndView.addObject("fromDate",fromDate);
		modelAndView.addObject("toDate",toDate);
		
		int frId=frDetails.getFrId();
		
		
		map.add("fromDate", fromDate);
		
		map.add("toDate", toDate);
		
		map.add("frId", frId);
		
	
		
		ParameterizedTypeReference<GetBillHeaderResponse> typeRef = new ParameterizedTypeReference<GetBillHeaderResponse>() {
		};
		ResponseEntity<GetBillHeaderResponse> responseEntity = restTemplate.exchange(Constant.URL + "getBillHeader",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);
		
		billHeadeResponse = responseEntity.getBody();	

		billHeader = billHeadeResponse.getGetBillHeaders();
		//System.out.println("billHeader"+billHeader.toString());
		modelAndView.addObject("billHeader",billHeader);
		
		}catch (Exception e) {
			
			//System.out.println("ex in getting bills "+e.getMessage());
			e.printStackTrace();
		}
		return modelAndView;
	
	}
	
	/*-------------------------------------------------------------*/
	public List<FrBillPrint> billPrintList;
	public List<FrBillHeaderForPrint> billHeadersListForPrint = new ArrayList<>();
	public List<GetBillDetailPrint> billDetailsListForPrint;
	@RequestMapping(value = "pdf/purchaseBillMatrixPdf/{transportMode}/{vehicleNo}/{selectedBills}", method = RequestMethod.GET)
	public ModelAndView purchaseBillMatrixPdf(@PathVariable String transportMode, @PathVariable String vehicleNo,
			@PathVariable String[] selectedBills, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("IN Show bill PDF Method :/showBillPdf");
		ModelAndView model = new ModelAndView("billing/matrixBillPdf/purchaseBillPdf");

		billPrintList = new ArrayList<>();

		try {

			// vehicleNo=request.getParameter("vehicle_no");
			// transportMode=request.getParameter("transport_mode");

		//	System.out.println("Vehicle No " + vehicleNo + "Transport Mode = " + transportMode);

		//	System.out.println("Inside new form action ");

			RestTemplate restTemplate = new RestTemplate();

			// String[] selectedBills=request.getParameterValues("select_to_print");
			String billList = new String();

			for (int i = 0; i < selectedBills.length; i++) {
				billList = selectedBills[i] + "," + billList;
			}

			billList = billList.substring(0, billList.length() - 1);

			System.out.println("selected bills for Printing " + billList);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("billNoList", billList);

			ParameterizedTypeReference<List<GetBillDetailPrint>> typeRef = new ParameterizedTypeReference<List<GetBillDetailPrint>>() {
			};
			ResponseEntity<List<GetBillDetailPrint>> responseEntity = restTemplate.exchange(
					Constant.URL + "getBillDetailsForPrint", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			// List<GetBillDetailPrint> billDetailsResponse =new ArrayList<>();

			List<GetBillDetailPrint> billDetailsResponse = responseEntity.getBody();

			List<String> billnos = Arrays.asList(billList.split("\\s*,\\s*"));
			List<SlabwiseBillList> slabwiseBillList = new ArrayList<>();

			for (String billno : billnos) {
				map = new LinkedMultiValueMap<String, Object>();

				map.add("billNoList", billno);
				ParameterizedTypeReference<List<SlabwiseBillList>> typeRef1 = new ParameterizedTypeReference<List<SlabwiseBillList>>() {
				};
				ResponseEntity<List<SlabwiseBillList>> responseEntity1 = restTemplate.exchange(
						Constant.URL + "getSlabwiseBillData", HttpMethod.POST, new HttpEntity<>(map), typeRef1);

				slabwiseBillList.addAll(responseEntity1.getBody());
			}
			System.out.println("slabwiseBillList" + slabwiseBillList.toString());
			System.out.println("bill No in Header " + billHeadersListForPrint.toString());

			System.out.println("selected bills for Printing " + billList);
			System.out.println("Size Here Now  " + billHeadersListForPrint.size());
			billHeadersListForPrint = new ArrayList<>();

			// billHeadersListForPrint=getBillListProcessForPrint(request, response);
			// List<FrBillHeaderForPrint> getBillListProcessForPrint

			/*
			 * List<String> billing=Arrays.asList(billList);
			 * 
			 * for(int a=0;a<billing.size();a++) {
			 * 
			 * if(billHeadersListForPrint.get(a).getBillNo()!=Integer.parseInt(billing.get(a
			 * )) ){
			 * 
			 * System.out.println("billHeader print removing bill"+billHeadersListForPrint.
			 * get(a));
			 * 
			 * billHeadersListForPrint.remove(a);
			 * 
			 * }
			 * 
			 * }
			 */

			/*
			 * List<GetBillDetail> billDetailsResponse =
			 * restTemplate.postForObject(Constants.url + "getBillDetailsForPrint", map,
			 * List.class);
			 * 
			 * 
			 */
			/*
			 * List<FrBillHeaderForPrint> tempList=new ArrayList<>();
			 * tempList=billHeadersListForPrint;
			 * System.out.println("temp List Before"+tempList); for(int
			 * p=0;p<selectedBills.length;p++) { System.out.println("selected Bill List "+p
			 * +""+selectedBills[p]);
			 * if(Integer.parseInt(selectedBills[p])==billHeadersListForPrint.get(p).
			 * getBillNo()) {
			 * 
			 * tempList.remove(p); }
			 * 
			 * } System.out.println("temp List After"+tempList); billHeadersListForPrint=new
			 * ArrayList<>(); billHeadersListForPrint=tempList;
			 */

			map = new LinkedMultiValueMap<String, Object>();

			map.add("billNoList", billList);

			ParameterizedTypeReference<List<FrBillHeaderForPrint>> typeRef2 = new ParameterizedTypeReference<List<FrBillHeaderForPrint>>() {
			};
			ResponseEntity<List<FrBillHeaderForPrint>> responseEntity2 = restTemplate.exchange(
					Constant.URL + "getFrBillHeaderForPrintSelectedBill", HttpMethod.POST, new HttpEntity<>(map),
					typeRef2);
			billHeadersListForPrint = new ArrayList<>();
			// List<GetBillDetail> billDetailsResponse = responseEntity.getBody();
			billHeadersListForPrint = responseEntity2.getBody();

			System.out.println("in new BHLFP" + billHeadersListForPrint.toString());

			CategoryListResponse categoryListResponse = restTemplate.getForObject(Constant.URL + "showAllCategory",
					CategoryListResponse.class);
			List<MCategoryList> categoryList;
			categoryList = categoryListResponse.getmCategoryList();

			SubCategory[] subCatList = restTemplate.getForObject(Constant.URL + "getAllSubCatList",
					SubCategory[].class);

			ArrayList<SubCategory> subCatAList = new ArrayList<SubCategory>(Arrays.asList(subCatList));
			SubCategory subCat = new SubCategory();
			subCat.setCatId(5);
			subCat.setSubCatName("Special Cake");
			subCat.setSubCatId(0);
			subCat.setDelStatus(0);
			subCatAList.add(subCat);

			System.out.println("subCatAList:" + subCatAList.toString());

			// List<MCategoryList> filteredCatList=new ArrayList<MCategoryList>();

			billDetailsListForPrint = new ArrayList<GetBillDetailPrint>();
			billDetailsListForPrint = billDetailsResponse;
		//	System.out.println(" *** get Bill detail for Print response :: " + billDetailsListForPrint.toString());

			System.out.println("Size Here Now  " + billHeadersListForPrint.size());

			FrBillPrint billPrint = null;
			for (int i = 0; i < billHeadersListForPrint.size(); i++) {
				billPrint = new FrBillPrint();
				List<GetBillDetailPrint> billDetails = new ArrayList<>();

				List<SubCategory> filteredSubCat = new ArrayList<SubCategory>();
				for (int j = 0; j < billDetailsListForPrint.size(); j++) {

					if (billHeadersListForPrint.get(i).getBillNo().equals(billDetailsListForPrint.get(j).getBillNo())) {

						System.out.println("Inside If  Bill no  = " + billHeadersListForPrint.get(i).getBillNo());
						billPrint.setAmtInWords(Currency.convertToIndianCurrency(
								String.valueOf(billHeadersListForPrint.get(i).getGrandTotal())));
						billPrint.setBillNo(billHeadersListForPrint.get(i).getBillNo());
						billPrint.setFrAddress(billHeadersListForPrint.get(i).getFrAddress());
						billPrint.setFrId(billHeadersListForPrint.get(i).getFrId());
						billPrint.setFrName(billHeadersListForPrint.get(i).getFrName());
						billPrint.setInvoiceNo(billHeadersListForPrint.get(i).getInvoiceNo());
						billPrint.setIsSameState(billHeadersListForPrint.get(i).getIsSameState());
						billPrint.setBillDate(billHeadersListForPrint.get(i).getBillDate());
						billPrint.setGrandTotal(billHeadersListForPrint.get(i).getGrandTotal());
						billPrint.setPartyName(billHeadersListForPrint.get(i).getPartyName());// new
						billPrint.setPartyAddress(billHeadersListForPrint.get(i).getPartyAddress());// new
						billPrint.setPartyGstin(billHeadersListForPrint.get(i).getPartyGstin());// new

						billPrint.setBillTime(billHeadersListForPrint.get(i).getBillTime());// new on 2july
						billPrint.setVehNo(billHeadersListForPrint.get(i).getVehNo());// new on 2july
						billPrint.setExVarchar1(billHeadersListForPrint.get(i).getExVarchar1());// new on 2july
						billPrint.setExVarchar2(billHeadersListForPrint.get(i).getExVarchar2());// new on 2july

						billPrint.setCompany(billHeadersListForPrint.get(i).getCompany());
						billDetails.add(billDetailsListForPrint.get(j));

						for (int a = 0; a < subCatAList.size(); a++) {

							for (int b = 0; b < billDetails.size(); b++) {

								if (billDetails.get(b).getSubCatId() == subCatAList.get(a).getSubCatId()) {

									if (filteredSubCat.isEmpty())
										filteredSubCat.add(subCatAList.get(a));
									else if (!filteredSubCat.contains(subCatAList.get(a))) {
										filteredSubCat.add(subCatAList.get(a));
									}
								}

							}

						}

						// FrBillTax billTax=new FrBillTax(); not used

					} // end of if

				}
				billPrint.setBillDetailsList(billDetails);
				// billPrintList=new ArrayList<>();
				billPrint.setSubCatList(filteredSubCat);
				if (billPrint != null)
				map.add("frId", billPrint.getFrId());
				restTemplate = new RestTemplate();

				FranchiseeList franchiseeList = restTemplate.getForObject(Constant.URL + "getFranchisee?frId={frId}",
						FranchiseeList.class, billPrint.getFrId());
				billPrint.setFrCity(franchiseeList.getFrCity());
				
				billPrintList.add(billPrint);

			}
			
			System.err.println("sub Cat List  " + billPrint.getSubCatList().toString());
			System.out.println(" after adding detail List : bill Print List " + billPrintList.toString());

			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			Calendar cal = Calendar.getInstance();

			System.out.println("time in Gen Bill PDF ==" + dateFormat.format(cal.getTime()));
			model.addObject("billDetails", billPrintList);
			model.addObject("slabwiseBillList", slabwiseBillList);
			model.addObject("vehicleNo", vehicleNo);
			model.addObject("transportMode", transportMode);
			model.addObject("dateTime", dateFormat.format(cal.getTime()));

			// allFrIdNameList = new AllFrIdNameList();

			// model.addObject("catList",filteredCatList);

			System.out.println("after Data ");

		} catch (Exception e) {

			System.out.println("Ex in getting bill Data for PDF " + e.getMessage());
			e.printStackTrace();
		}
		return model;

	}
}

package com.monginis.ops.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.billing.SellBillDetail;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.AllFrIdNameList;
import com.monginis.ops.model.CategoryList;
import com.monginis.ops.model.CustomerBillItem;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetCurrentStockDetails;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.Item;
import com.monginis.ops.model.ItemResponse;
import com.monginis.ops.model.MCategory;
import com.monginis.ops.model.PostFrItemStockHeader;
import com.monginis.ops.model.StockTransferDetail;
import com.monginis.ops.model.StockTransferHeader;
import com.monginis.ops.model.SubCategory;
import com.monginis.ops.model.TabTitleData;
import com.monginis.ops.model.frsetting.FrSetting;
import com.sun.org.apache.bcel.internal.generic.RET;

@Controller
@Scope("session")
public class StockExchengeController {
	
	
	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	
	

	List<GetCurrentStockDetails> stockMatchList=new ArrayList<>();
	
	List<MCategory> mAllCategoryList = new ArrayList<MCategory>();
	
	ArrayList<FrMenu> menuList;
	
	Integer runningMonth = 0;
	
	List<GetCurrentStockDetails> currentStockDetailList = new ArrayList<GetCurrentStockDetails>();
	
	
	
	public List<Item> newItemsList;
	
	
	@RequestMapping(value="/showStockExchange")
	public ModelAndView showStockExchange(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model=new  ModelAndView("stockExchange/stockExchange");
		System.err.println("In /showStockExchange");
		AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
		try {
			
		
			
			
			
			CategoryList categoryList=null;
			try {
				RestTemplate restTemplate = new RestTemplate();
				allFrIdNameList = restTemplate.getForObject(Constant.URL + "getAllFrIdName", AllFrIdNameList.class);
				
				
				categoryList = restTemplate.getForObject(Constant.URL + "showAllCategory", CategoryList.class);

			} catch (Exception e) {
				System.out.println("Exception in getAllGategory" + e.getMessage());
				e.printStackTrace();

			}

			mAllCategoryList = categoryList.getmCategoryList();

			model.addObject("category", mAllCategoryList);
			model.addObject("frList", allFrIdNameList.getFrIdNamesList());
			
			
		 String catId = request.getParameter("cat_id");
		 //System.err.println("---->All Fr List"+allFrIdNameList);
		 if(catId!=null)
		 {     
			 int frId=Integer.parseInt(request.getParameter("franchisee_id"));
			 
			 
			 
			 HttpSession session = request.getSession();
				Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			
				
				menuList = (ArrayList<FrMenu>) session.getAttribute("allMenuList");
				//System.out.println("Menu List " + menuList.toString());

				
				

				
				List<Integer> menuIdList=null;
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("frId", frDetails.getFrId());
				RestTemplate restTemplate = new RestTemplate();
				
				
				

				ParameterizedTypeReference<List<PostFrItemStockHeader>> typeRef1 = new ParameterizedTypeReference<List<PostFrItemStockHeader>>() {
				};
				ResponseEntity<List<PostFrItemStockHeader>> responseEntity1 = restTemplate
						.exchange(Constant.URL + "getCurrentMonthOfCatId", HttpMethod.POST, new HttpEntity<>(map), typeRef1);
				List<PostFrItemStockHeader> list = responseEntity1.getBody();
				int intCatId = Integer.parseInt(catId);
				System.out.println("## catId" + intCatId);

				if (catId.equalsIgnoreCase("1")) {
					menuIdList =new ArrayList<>();
					for (PostFrItemStockHeader header : list) {

						if (header.getCatId() == intCatId) {
							runningMonth = header.getMonth();
						}

					}

					menuIdList.add(26);

				} else if (catId.equalsIgnoreCase("2")) {
					menuIdList =new ArrayList<>();
				
					for (PostFrItemStockHeader header : list) {

						if (header.getCatId() == intCatId) {
							runningMonth = header.getMonth();
						}

					}
						menuIdList.add(82);
				} else if (catId.equalsIgnoreCase("3")) {
					menuIdList =new ArrayList<>();
					for (PostFrItemStockHeader header : list) {

						if (header.getCatId() == intCatId) {
							runningMonth = header.getMonth();
						}

					}
					menuIdList.add(33);
				} else if (catId.equalsIgnoreCase("4")) {
					menuIdList =new ArrayList<>();
					for (PostFrItemStockHeader header : list) {

						if (header.getCatId() == intCatId) {
							runningMonth = header.getMonth();
						}

					}
					menuIdList.add(34);
				} else if (catId.equalsIgnoreCase("6")) {
					menuIdList =new ArrayList<>();
					for (PostFrItemStockHeader header : list) {

						if (header.getCatId() == intCatId) {
							runningMonth = header.getMonth();
						}

					}
					menuIdList.add(49);
				}
				

				String itemShow = "";

				for (int i = 0; i < menuList.size(); i++) {
					for(int j=0;j<menuIdList.size();j++) {
					if (menuList.get(i).getMenuId() == menuIdList.get(j)) {

						itemShow = menuList.get(i).getItemShow();

					}
					}
				}
				DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				DateFormat yearFormat = new SimpleDateFormat("yyyy");

				Date todaysDate = new Date();
				System.out.println(dateFormat.format(todaysDate));

				Calendar cal = Calendar.getInstance();
				cal.setTime(todaysDate);

				cal.set(Calendar.DAY_OF_MONTH, 1);

				Date firstDay = cal.getTime();


				boolean isMonthCloseApplicable = false;

					map = new LinkedMultiValueMap<String, Object>();

					DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
					Date date = new Date();
					System.out.println(dateFormat1.format(date));

					Calendar cal1 = Calendar.getInstance();
					cal1.setTime(date);

					int calCurrentMonth = cal1.get(Calendar.MONTH) + 1;
					
					if (runningMonth < calCurrentMonth) {

						isMonthCloseApplicable = true;
						System.out.println("Day Of Month End ......");

					} else if (runningMonth == 12 && calCurrentMonth == 1) {
						isMonthCloseApplicable = true;
					}

					if (isMonthCloseApplicable) {
						String strDate;
						int year;
						if (runningMonth == 12) {
							System.err.println("running month =12");
							year = (Calendar.getInstance().getWeekYear() - 1);
							System.err.println("year value " + year);
						} else {
							System.err.println("running month not eq 12");
							year = Calendar.getInstance().getWeekYear();
							System.err.println("year value " + year);
						}

						strDate = year + "/" + runningMonth + "/01";

						map.add("fromDate", strDate);
					} else {

						map.add("fromDate", dateFormat.format(firstDay));

					}

					map.add("frId", frDetails.getFrId());
					map.add("frStockType", frDetails.getStockType());
					map.add("toDate", dateFormat.format(todaysDate));
					map.add("currentMonth", String.valueOf(runningMonth));
					map.add("year", yearFormat.format(todaysDate));
					map.add("catId", catId);
					map.add("itemIdList", itemShow);
					//System.out.println("itemShow : " + itemShow.toString());
					ParameterizedTypeReference<List<GetCurrentStockDetails>> typeRef = new ParameterizedTypeReference<List<GetCurrentStockDetails>>() {
					};
					ResponseEntity<List<GetCurrentStockDetails>> responseEntity = restTemplate
							.exchange(Constant.URL + "getCurrentStock", HttpMethod.POST, new HttpEntity<>(map), typeRef);

					currentStockDetailList = responseEntity.getBody();

				
				SubCategory[] subCatList = restTemplate.getForObject(Constant.URL + "getAllSubCatList",
						SubCategory[].class);

				ArrayList<SubCategory> subCatAList = new ArrayList<SubCategory>(Arrays.asList(subCatList));
				
				map = new LinkedMultiValueMap<String, Object>();
				map.add("itemGrp1", catId);
				Item[] itemList = restTemplate.postForObject(Constant.URL + "getItemsByCatId",
					map,Item[].class);
				ArrayList<Item> itemListRes = new ArrayList<Item>(Arrays.asList(itemList));
				newItemsList=itemListRes;
				
				List<TabTitleData> subCatListWithQtyTotal = new ArrayList<>();
               for(SubCategory subCat:subCatAList) {
            	   if(subCat.getCatId()==Integer.parseInt(catId)) {
				TabTitleData tabTitleData=new TabTitleData();
				tabTitleData.setHeader(""+subCat.getSubCatId());
				tabTitleData.setName(subCat.getSubCatName());
				subCatListWithQtyTotal.add(tabTitleData);
            	   }
               }
            	   for(int i=0;i<currentStockDetailList.size();i++)
            	   {
            		   for(Item item:itemListRes)
            		   {
            			   if(currentStockDetailList.get(i).getId()==item.getId())
            			   {
            				   currentStockDetailList.get(i).setSubCatId(item.getItemGrp2());
            			   }
            		   }
            	   }
					//System.out.println("Current Stock Details : " + currentStockDetailList.toString());
					stockMatchList=currentStockDetailList;
   			   // System.err.println("currentStockDetailList"+currentStockDetailList.toString());
   			    //System.err.println("subCatListWithQtyTotal"+subCatListWithQtyTotal.toString());
				model.addObject("stockDetailList", currentStockDetailList);
				model.addObject("subCatListTitle", subCatListWithQtyTotal);
				model.addObject("frId", frId);
				
				
				
				
				
		}

		 model.addObject("catId", catId);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	
	
	
	  
	
	
	@RequestMapping(value = "/addSellBill", method = RequestMethod.POST)
	public  String addSellBill(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		SellBillHeader sellBillHeaderRes = new SellBillHeader();
		List<StockTransferDetail> tranferDetailList=new  ArrayList<>();
		StockTransferHeader transferHeader=new StockTransferHeader();
		
		try {
		
			
			int frId=Integer.parseInt(request.getParameter("frId"));
			System.err.println("Selected Franchisee-->"+frId);
			
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.now();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String date = sdf.format(new Date());
			SellBillHeader sellBillHeader = new SellBillHeader();

			List<SellBillDetail> sellBillDetailList = new ArrayList<SellBillDetail>();
			List<CustomerBillItem> customerBillItemList = new ArrayList<CustomerBillItem>();
			RestTemplate restTemplate = new RestTemplate();
			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
			Franchisee franchisee = restTemplate.getForObject(Constant.URL + "getFranchisee?frId="+frId,Franchisee.class);
			
			//System.err.println("To Franc--->"+franchisee);
			
			

			customerBillItemList = new ArrayList<CustomerBillItem>();

			for (int i = 0; i < newItemsList.size(); i++) {

				Item item = newItemsList.get(i);
				String stQty=request.getParameter("qty"+item.getId());
				
				if(stQty!=null && stQty!="") {
                int qty=Integer.parseInt(stQty);
                if(qty>0) {
				CustomerBillItem customerBillItem = new CustomerBillItem();
				customerBillItem.setCatId(item.getItemGrp1());
				customerBillItem.setId(Integer.parseInt(item.getItemId()));
				customerBillItem.setItemId(item.getItemId());
				customerBillItem.setItemName(item.getItemName());
				customerBillItem.setHsnCode(item.getItemImage());//hsn code from itemImage --query
				customerBillItem.setQty(qty);
				customerBillItem.setItemTax1(item.getItemTax1());
				customerBillItem.setItemTax2(item.getItemTax2());
				customerBillItem.setItemTax3(item.getItemTax3());

				if (frDetails.getFrRateCat() == 1) {
					customerBillItem.setMrp(item.getItemMrp1());
					customerBillItem.setRate(item.getItemRate1());
				}  else if (frDetails.getFrRateCat() == 3) {
					customerBillItem.setMrp(item.getItemMrp3());

					customerBillItem.setRate(item.getItemRate3());
				}
				customerBillItem.setBillStockType(1);//1 means regular Stock
				customerBillItemList.add(customerBillItem);
                }
				}
			}
			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0, sumMrp = 0;
		
			for (int i = 0; i < customerBillItemList.size(); i++) {
				System.out.println("dddd");

				SellBillDetail sellBillDetail = new SellBillDetail();

				Float rate = (float) customerBillItemList.get(i).getMrp();

				Float tax1 = (float) customerBillItemList.get(i).getItemTax1();
				Float tax2 = (float) customerBillItemList.get(i).getItemTax2();
				Float tax3 = (float) customerBillItemList.get(i).getItemTax3();

				int qty = customerBillItemList.get(i).getQty();

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float discAmt = ((taxableAmt * 0) / 100);
				taxableAmt = taxableAmt - discAmt;

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);

				sellBillDetail.setCatId(customerBillItemList.get(i).getCatId());
				sellBillDetail.setSgstPer(tax1);
				sellBillDetail.setSgstRs(sgstRs);
				sellBillDetail.setCgstPer(tax2);
				sellBillDetail.setCgstRs(cgstRs);
				sellBillDetail.setDelStatus(0);
				sellBillDetail.setGrandTotal(grandTotal);
				sellBillDetail.setIgstPer(tax3);
				sellBillDetail.setIgstRs(igstRs);
				sellBillDetail.setItemId(customerBillItemList.get(i).getId());
				sellBillDetail.setMrp(rate);
				sellBillDetail.setMrpBaseRate(mrpBaseRate);
				sellBillDetail.setQty(customerBillItemList.get(i).getQty());
				sellBillDetail.setRemark(customerBillItemList.get(i).getHsnCode());//hsncode --new
				sellBillDetail.setSellBillDetailNo(0);
				sellBillDetail.setSellBillNo(0);
				sellBillDetail.setBillStockType(customerBillItemList.get(i).getBillStockType());

				sumMrp = sumMrp + (rate * qty);
				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;

				sellBillDetail.setTaxableAmt(taxableAmt);
				sellBillDetail.setTotalTax(totalTax);

				sellBillDetailList.add(sellBillDetail);
				
				StockTransferDetail transferDetail=new StockTransferDetail();
				
				
				
				transferDetail.setTransferDetailId(0);
				transferDetail.setTransferId(0);
				transferDetail.setItemId(customerBillItemList.get(i).getId());
				transferDetail.setItemMrp(sellBillDetail.getMrp());
				transferDetail.setItemRate(sellBillDetail.getMrpBaseRate());
				transferDetail.setItemTax(sellBillDetail.getTotalTax());
				transferDetail.setCgst(sellBillDetail.getCgstPer());
				transferDetail.setIgst(sellBillDetail.getIgstPer());
				transferDetail.setSgst(sellBillDetail.getSgstPer());
				transferDetail.setCgstAmt(sellBillDetail.getCgstRs());
				transferDetail.setIgstAmt(sellBillDetail.getIgstRs());
				transferDetail.setSgstAmt(sellBillDetail.getSgstRs());
				transferDetail.setDiscount(0);
				transferDetail.setExtraCharges(0);
				transferDetail.setGrandTotal(sellBillDetail.getGrandTotal());
				transferDetail.setTaxAmt(sellBillDetail.getTaxableAmt());
				transferDetail.setExInt1(0);
				transferDetail.setExInt2(0);
				transferDetail.setExFloat1(0);
				transferDetail.setExFloat2(0);
				transferDetail.setQty(qty);
				
				tranferDetailList.add(transferDetail);
				
			}

			sellBillHeader.setFrId(frDetails.getFrId());
			sellBillHeader.setFrCode(frDetails.getFrCode());
			sellBillHeader.setDelStatus(0);
			sellBillHeader.setUserName(franchisee.getFrName());
			sellBillHeader.setBillDate(dtf.format(localDate));

			sellBillHeader.setInvoiceNo(getInvoiceNoForStkMatch(request,response));
			sellBillHeader.setPaymentMode(1);
			sellBillHeader.setBillType('P');
			sellBillHeader.setSellBillNo(0);
			sellBillHeader.setUserGstNo(franchisee.getFrGstNo());
     		sellBillHeader.setUserPhone(franchisee.getFrMob());

			System.out.println("Sell Bill Header: " + sellBillHeader.toString());
			
			
			sellBillHeader.setTaxableAmt(sumTaxableAmt);
			sellBillHeader.setDiscountPer(0);
		
			float payableAmt = sumGrandTotal;
			sellBillHeader.setPaidAmt(Math.round(payableAmt));
			payableAmt = roundUp(payableAmt);

			sellBillHeader.setDiscountAmt(sumMrp);
			sellBillHeader.setPayableAmt(Math.round(payableAmt));
			System.out.println("Payable amt  : " + payableAmt);
			sellBillHeader.setTotalTax(sumTotalTax);
			sellBillHeader.setGrandTotal(Math.round(sumGrandTotal));
            sellBillHeader.setRemainingAmt(0);
			sellBillHeader.setStatus(1);
			

			sellBillHeader.setSellBillDetailsList(sellBillDetailList);
			System.out.println("Sell Bill Detail: " + sellBillHeader.toString());
			sellBillHeaderRes = restTemplate.postForObject(Constant.URL + "insertSellBillData", sellBillHeader,
					SellBillHeader.class);

			System.out.println("info :" + sellBillHeaderRes.toString());
			
			
			transferHeader.setTransferId(0);
			transferHeader.setFromFrId(frDetails.getFrId());
			transferHeader.setToFrId(franchisee.getFrId());
			transferHeader.setMakerDate(dtf.format(localDate));
			transferHeader.setMakerDatetime(date);
			transferHeader.setTaxableAmt(sellBillHeader.getTaxableAmt());
			transferHeader.setTax(sellBillHeader.getTotalTax());
			transferHeader.setRateTotal(Math.round(sellBillHeader.getPayableAmt()));
			transferHeader.setStatus(0);
			transferHeader.setDelStatus(0);
			transferHeader.setAdditionalCharges(0);
			transferHeader.setGrandTotal(sellBillHeader.getGrandTotal());
			transferHeader.setExInt1(sellBillHeaderRes.getSellBillNo());
			transferHeader.setExInt2(0);
			transferHeader.setStockTransferdetailList(tranferDetailList);
			
			
			System.err.println("Final Transfer Header Obj-->"+transferHeader.toString());
			
			StockTransferHeader resp=restTemplate.postForObject(Constant.URL+"saveStockTransferHeader", transferHeader, StockTransferHeader.class);
			
			
			
			
			

			if (sellBillHeaderRes != null) {

				map = new LinkedMultiValueMap<String, Object>();
				map = new LinkedMultiValueMap<String, Object>();

				map.add("frId", frDetails.getFrId());
				FrSetting frSetting = restTemplate.postForObject(Constant.URL + "getFrSettingValue", map,
						FrSetting.class);

				int sellBillNo = frSetting.getSellBillNo();

				sellBillNo = sellBillNo + 1;

				map = new LinkedMultiValueMap<String, Object>();

				map.add("frId", frDetails.getFrId());
				map.add("sellBillNo", sellBillNo);

				Info info = restTemplate.postForObject(Constant.URL + "updateFrSettingBillNo", map, Info.class);

			}
			
		} catch (Exception e) {

			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();

		}
		System.out.println("Order Response:" + sellBillHeaderRes.toString());

		return "redirect:/getFromFranchiseeList";

	}

	public String getInvoiceNoForStkMatch(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		RestTemplate restTemplate = new RestTemplate();


		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

		int frId = frDetails.getFrId();

		// String frCode = frDetails.getFrCode();

		map.add("frId", frId);
		FrSetting frSetting = restTemplate.postForObject(Constant.URL + "getFrSettingValue", map, FrSetting.class);

		int billNo = frSetting.getSellBillNo();

		int settingValue =billNo;

		System.out.println("Setting Value Received " + settingValue);
		int year = Year.now().getValue();
		String curStrYear = String.valueOf(year);
		curStrYear = curStrYear.substring(2);

		int preMarchYear = Year.now().getValue() - 1;
		String preMarchStrYear = String.valueOf(preMarchYear);
		preMarchStrYear = preMarchStrYear.substring(2);

		System.out.println("Pre MArch year ===" + preMarchStrYear);

		int nextYear = Year.now().getValue() + 1;
		String nextStrYear = String.valueOf(nextYear);
		nextStrYear = nextStrYear.substring(2);

		System.out.println("Next  year ===" + nextStrYear);

		int postAprilYear = nextYear + 1;
		String postAprilStrYear = String.valueOf(postAprilYear);
		postAprilStrYear = postAprilStrYear.substring(2);

		System.out.println("Post April   year ===" + postAprilStrYear);

		java.util.Date date = new Date();
		Calendar cale = Calendar.getInstance();
		cale.setTime(date);
		int month = cale.get(Calendar.MONTH);
		
		month=month+1;

		if (month <= 3) {

			curStrYear = preMarchStrYear + curStrYear;
			System.out.println("Month <= 3::Cur Str Year " + curStrYear);
		} else if (month >= 4) {

			curStrYear = curStrYear + nextStrYear;
			System.out.println("Month >=4::Cur Str Year " + curStrYear);
		}

		////

		int length = String.valueOf(settingValue).length();

		String invoiceNo = null;

		if (length == 1)

			invoiceNo = curStrYear + "-" + "0000" + settingValue;
		if (length == 2)

			invoiceNo = curStrYear + "-" + "000" + settingValue;

		if (length == 3)

			invoiceNo = curStrYear + "-" + "00" + settingValue;

		if (length == 4)

			invoiceNo = curStrYear + "-" + "0" + settingValue;

		invoiceNo=frDetails.getFrCode()+invoiceNo;
		System.out.println("*** settingValue= " + settingValue);
		return invoiceNo;

	}
	List<StockTransferHeader> headerList=new ArrayList<>();
	
	
	
	@RequestMapping(value="/getFromFranchiseeList",method=RequestMethod.GET)
	public ModelAndView getFromFranchiseeList(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model=new ModelAndView("stockExchange/toFrList");
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		headerList.clear();
		RestTemplate restTemplate=new RestTemplate();
		MultiValueMap<String, Object> map=new LinkedMultiValueMap<>();
		try {
			map.add("fromFrId", frDetails.getFrId());
			StockTransferHeader[] headrArr=restTemplate.postForObject(Constant.URL+"getAllStockTransferHeadByFromFrId", map, StockTransferHeader[].class);
			headerList=new ArrayList<>(Arrays.asList(headrArr));
			model.addObject("headList",headerList);
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occuered In /getFromFranchiseeList");
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value="/getStocktransferHeader",method=RequestMethod.POST)
	public @ResponseBody StockTransferHeader getStocktransferHeader(HttpServletRequest request,HttpServletResponse response) {
		System.err.println("in /getStocktransferHeader");
		StockTransferHeader header=new StockTransferHeader();
		try {
			int tranferId=Integer.parseInt(request.getParameter("headId"));
			for(StockTransferHeader Shead : headerList) {
				if(Shead.getTransferId()==tranferId) {
					header=Shead;
				}
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occured In /getStocktransferHeader");
			e.printStackTrace();
		}
		return header;
	}
	
	

	@RequestMapping(value="/UpdateDetail",method=RequestMethod.POST)
	public String UpdateDetail(HttpServletRequest request,HttpServletResponse response){
		System.err.println("In /UpdateDetail");
		SellBillHeader editSellHeader=new SellBillHeader();
		StockTransferHeader editTransferHeader=new StockTransferHeader();
		RestTemplate restTemplate=new RestTemplate();
		MultiValueMap<String, Object> map=new LinkedMultiValueMap<>();
		
		try {
			int transferId=Integer.parseInt(request.getParameter("tranId"));
			System.err.println(transferId);
			System.err.println("HeaderList-->"+headerList.toString());
			for(StockTransferHeader header : headerList) {
				if(header.getTransferId() == transferId) {
					System.err.println("in If");
					editTransferHeader=header;
				}
				//System.err.println("edit Transfer Header-->"+editTransferHeader.toString());
				
				
			}
			map.add("sellBillNo", editTransferHeader.getExInt1());
			editSellHeader=restTemplate.postForObject(Constant.URL+"getSellBillHeaderBySellBillNo", map, SellBillHeader.class);
			//System.err.println("Edit Sell Header-->"+editSellHeader.toString());
			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0, sumMrp = 0;
			for(int i=0;i<editTransferHeader.getStockTransferdetailList().size();i++) {
				String qId="uQty"+editTransferHeader.getStockTransferdetailList().get(i).getTransferDetailId();
				System.err.println(request.getParameter(qId));
				
				Float rate = (float) editTransferHeader.getStockTransferdetailList().get(i).getItemMrp();

				Float tax1 = (float) editTransferHeader.getStockTransferdetailList().get(i).getCgst();
				Float tax2 = (float) editTransferHeader.getStockTransferdetailList().get(i).getIgst();
				Float tax3 = (float) editTransferHeader.getStockTransferdetailList().get(i).getSgst();

				int qty = Integer.parseInt(request.getParameter(qId));

				Float mrpBaseRate = (rate * 100) / (100 + (tax1 + tax2));
				mrpBaseRate = roundUp(mrpBaseRate);

				System.out.println("Mrp: " + rate);
				System.out.println("Tax1 : " + tax1);
				System.out.println("tax2 : " + tax2);

				Float taxableAmt = (float) (mrpBaseRate * qty);
				taxableAmt = roundUp(taxableAmt);

				// -----------------------------------------

				float discAmt = ((taxableAmt * 0) / 100);
				taxableAmt = taxableAmt - discAmt;

				float sgstRs = (taxableAmt * tax1) / 100;
				float cgstRs = (taxableAmt * tax2) / 100;
				float igstRs = (taxableAmt * tax3) / 100;

				sgstRs = roundUp(sgstRs);
				cgstRs = roundUp(cgstRs);
				igstRs = roundUp(igstRs);

				Float totalTax = sgstRs + cgstRs;
				totalTax = roundUp(totalTax);

				Float grandTotal = totalTax + taxableAmt;
				grandTotal = roundUp(grandTotal);
				
				editTransferHeader.getStockTransferdetailList().get(i).setQty(qty);
				editTransferHeader.getStockTransferdetailList().get(i).setItemRate(mrpBaseRate);
				editTransferHeader.getStockTransferdetailList().get(i).setItemTax(totalTax);
				editTransferHeader.getStockTransferdetailList().get(i).setCgstAmt(cgstRs);
				editTransferHeader.getStockTransferdetailList().get(i).setIgstAmt(igstRs);
				editTransferHeader.getStockTransferdetailList().get(i).setSgstAmt(sgstRs);
				editTransferHeader.getStockTransferdetailList().get(i).setGrandTotal(grandTotal);
				editTransferHeader.getStockTransferdetailList().get(i).setTaxAmt(taxableAmt);
				
				editSellHeader.getSellBillDetailsList().get(i).setQty(qty);
				editSellHeader.getSellBillDetailsList().get(i).setMrpBaseRate(mrpBaseRate);
				editSellHeader.getSellBillDetailsList().get(i).setMrp(editTransferHeader.getStockTransferdetailList().get(i).getItemMrp());
				editSellHeader.getSellBillDetailsList().get(i).setTaxableAmt(taxableAmt);
				editSellHeader.getSellBillDetailsList().get(i).setCgstRs(cgstRs);
				editSellHeader.getSellBillDetailsList().get(i).setSgstRs(sgstRs);
				editSellHeader.getSellBillDetailsList().get(i).setIgstRs(igstRs);
				editSellHeader.getSellBillDetailsList().get(i).setTotalTax(totalTax);
				editSellHeader.getSellBillDetailsList().get(i).setGrandTotal(grandTotal);
				
				sumMrp = sumMrp + (rate * qty);
				sumTaxableAmt = sumTaxableAmt + taxableAmt;
				sumTotalTax = sumTotalTax + totalTax;
				sumGrandTotal = sumGrandTotal + grandTotal;
			}
			

			editSellHeader.setTaxableAmt(sumTaxableAmt);
			editSellHeader.setDiscountPer(0);
		
			float payableAmt = sumGrandTotal;
			editSellHeader.setPaidAmt(Math.round(payableAmt));
			payableAmt = roundUp(payableAmt);

			editSellHeader.setDiscountAmt(sumMrp);
			editSellHeader.setPayableAmt(Math.round(payableAmt));
			System.out.println("Payable amt  : " + payableAmt);
			editSellHeader.setTotalTax(sumTotalTax);
			editSellHeader.setGrandTotal(Math.round(sumGrandTotal));
            editSellHeader.setRemainingAmt(0);
			editSellHeader.setStatus(1);
			

			
			//System.out.println("Sell Bill Detail: " + editSellHeader.toString());
			SellBillHeader editSellHeaderRes = restTemplate.postForObject(Constant.URL + "updateSellBillHeader", editSellHeader,
				SellBillHeader.class);

			//System.out.println("info :" + editSellHeaderRes.toString());
			
	
			editTransferHeader.setTaxableAmt(editSellHeader.getTaxableAmt());
			editTransferHeader.setTax(editSellHeader.getTotalTax());
			editTransferHeader.setRateTotal(Math.round(editSellHeader.getPayableAmt()));
			editTransferHeader.setGrandTotal(editSellHeader.getGrandTotal());
		
			
			
			StockTransferHeader resp=restTemplate.postForObject(Constant.URL+"saveStockTransferHeader", editTransferHeader, StockTransferHeader.class);
			
			
			//System.err.println("Final Sell Header Object"+editSellHeader.toString());
			//System.err.println("Final Transfer Header Object"+editTransferHeader.toString());
			
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occured In /UpdateDetail");
			e.printStackTrace();
		}
		return "redirect:/getFromFranchiseeList";
	}
	
	
	
	@RequestMapping(value="/getToFranchiseeList",method=RequestMethod.GET)
	public ModelAndView getToFranchiseeList(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model=new ModelAndView("stockExchange/fromFrList");
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		headerList.clear();
		RestTemplate restTemplate=new RestTemplate();
		MultiValueMap<String, Object> map=new LinkedMultiValueMap<>();
		try {
			map.add("toFrId", frDetails.getFrId());
			StockTransferHeader[] headrArr=restTemplate.postForObject(Constant.URL+"getAllStockTransferHeadByToFrId", map, StockTransferHeader[].class);
			headerList=new ArrayList<>(Arrays.asList(headrArr));
			model.addObject("headList",headerList);
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occuered In /getFromFranchiseeList");
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value="/getStocktransferToHeader",method=RequestMethod.POST)
	public @ResponseBody StockTransferHeader getStocktransferToHeader(HttpServletRequest request,HttpServletResponse response) {
		System.err.println("in /getStocktransferHeader");
		StockTransferHeader header=new StockTransferHeader();
		try {
			int tranferId=Integer.parseInt(request.getParameter("headId"));
			for(StockTransferHeader Shead : headerList) {
				if(Shead.getTransferId()==tranferId) {
					header=Shead;
				}
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occured In /getStocktransferHeader");
			e.printStackTrace();
		}
		return header;
	}
	
	
	
	@RequestMapping(value="/acceptRejectStock",method=RequestMethod.POST)
	public @ResponseBody int acceptRejectStock(HttpServletRequest request,HttpServletResponse response) {
		System.err.println("In /acceptRejectStock");
		RestTemplate restTemplate=new RestTemplate();
		MultiValueMap<String,Object> map=new LinkedMultiValueMap<>();
		int flag=0;
		try {
			int tranId=Integer.parseInt(request.getParameter("tranId"));
			int status=Integer.parseInt(request.getParameter("status"));
			int sellBillHeaderId=0;
			for(StockTransferHeader head : headerList ) {
				if(head.getTransferId()==tranId) {
					
					sellBillHeaderId=head.getExInt1();
			}
			}if(status==1) {
				map.add("tranId", tranId);
				map.add("status", status);
				Info stockInfo=restTemplate.postForObject(Constant.URL+"updateHeaderStatus", map, Info.class);
				
				map.clear();
				map.add("sellBillNo", sellBillHeaderId);
				
				Info sellHeaderInfo=restTemplate.postForObject(Constant.URL+"deleteSellBillHeaderBySellBillNo", map, Info.class);
				if(!stockInfo.isError() && !sellHeaderInfo.isError()) {
					flag=1;
				}
				
				
			}else if(status==2) {
				map.add("tranId", tranId);
				map.add("status", status);
				Info stockInfo=restTemplate.postForObject(Constant.URL+"updateHeaderStatus", map, Info.class);
				if(!stockInfo.isError()) {
					flag=1;
				}
			}
			
			
			
			//System.err.println("Sellbill Header Id-->"+sellBillHeaderId);
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println("Exception Occuerd In /acceptRejectStock");
			e.printStackTrace();
		}
		
		return flag;
	}
	
	
	
	
	
	
}

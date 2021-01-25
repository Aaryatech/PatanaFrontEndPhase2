package com.monginis.ops.common;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrMenu;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetFrItem;
import com.monginis.ops.model.Orders;

public class SetOrderDataCommon {

	public MultiValueMap<String, Object> map;

	public Orders setOrderData(Orders order,FrMenu menu,int menuId,int frId,int orderQty,HttpServletRequest request) {
		System.err.println("in setOrderData"); 
		List<GetFrItem> frItemList = new ArrayList<>();
		// FrMenu menu=new FrMenu();
		try {
		 map = new LinkedMultiValueMap<String, Object>();

		map.add("items", order.getItemId());
		map.add("frId", frId);
		map.add("date", "");
		map.add("menuId", menuId);
		map.add("isSameDayApplicable", 0);

		RestTemplate restTemplate = new RestTemplate();

		ParameterizedTypeReference<List<GetFrItem>> typeRef = new ParameterizedTypeReference<List<GetFrItem>>() {
		};
		ResponseEntity<List<GetFrItem>> responseEntity = restTemplate.exchange(Constant.URL + "/getFrItems",
				HttpMethod.POST, new HttpEntity<>(map), typeRef);

		frItemList = responseEntity.getBody();
		
		order.setOrderType(Integer.parseInt(frItemList.get(0).getItemGrp1()));//ie catId
		order.setOrderSubType(Integer.parseInt(frItemList.get(0).getItemGrp2()));//ie subCatId
		order.setOrderQty(orderQty);
		
		String fromTime = menu.getFromTime();
		String toTime = menu.getToTime();

		String orderDate = "";
		String productionDate = "";
		String deliveryDate = "";
		
		ZoneId z = ZoneId.of("Asia/Calcutta");
		LocalTime now = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

		LocalTime fromTimeLocalTime = LocalTime.parse(fromTime);
		LocalTime toTimeLocalTIme = LocalTime.parse(toTime);

		Boolean isLate = now.isAfter(toTimeLocalTIme);
		Boolean isEarly = now.isBefore(fromTimeLocalTime);

		Boolean isSameDay = fromTimeLocalTime.isBefore(toTimeLocalTIme);
		Boolean isValid = false;
		
		String todaysDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		if (fromTimeLocalTime.isBefore(toTimeLocalTIme)) {
			orderDate = todaysDate;
			//productionDate = todaysDate;
			productionDate = incrementDate(todaysDate,menu.getProdDays());
			deliveryDate = incrementDate(todaysDate, menu.getDelDays());
		} else {
			if (now.isAfter(fromTimeLocalTime)) {
				orderDate = todaysDate;
				productionDate = incrementDate(todaysDate, menu.getProdDays()+1);
				deliveryDate = incrementDate(todaysDate, menu.getDelDays()+1);
			} else {
				orderDate = todaysDate;
				productionDate = incrementDate(todaysDate,menu.getProdDays());
				deliveryDate = incrementDate(todaysDate, menu.getDelDays());
			}
		}
		int rateCat=menu.getRateSettingType();
		float mrp=0;
		float profitPer=0;
		
		if (rateCat == 1) {
			mrp=(float) frItemList.get(0).getItemMrp1();
		}else if(rateCat == 2) {
			mrp=(float) frItemList.get(0).getItemMrp2();
		}else {
			mrp=(float) frItemList.get(0).getItemMrp3();
		}
		profitPer=menu.getProfitPer();
		float rate=(mrp-(mrp*profitPer)/100);      
		order.setDeliveryDate(Common.stringToSqlDate(deliveryDate));
		order.setOrderDate(Common.stringToSqlDate(orderDate));
		order.setOrderDatetime(todaysDate);
		order.setProductionDate(Common.stringToSqlDate(productionDate));
		
		order.setOrderMrp(mrp);
		order.setOrderRate(rate);
		order.setGrnType(menu.getGrnPer());
		order.setIsPositive((int)menu.getDiscPer());//set discPer
		System.err.println("order Here " +order.toString());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return order;
		
	}
	
	public String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(sdf.parse(date));

		} catch (ParseException e) {
			// System.out.println("Exception while incrementing date " + e.getMessage());
			e.printStackTrace();
		}
		c.add(Calendar.DATE, day); // number of days to add

		date = sdf.format(c.getTime());

		return date;

	}
	
}

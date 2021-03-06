package com.monginis.ops.controller;

import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ExportToExcel;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GrnGvnReport;
import com.monginis.ops.model.SalesReportFranchisee;
import com.monginis.ops.model.TSellReport;
import com.monginis.ops.model.grngvn.CreditNoteGrnGvnItemWise;
import com.monginis.ops.model.grngvn.PendingGrnGvnItemWise;

@Controller
@Scope("session")
public class SellReport {
	
	@RequestMapping(value = "/hsnWiseReport", method = RequestMethod.GET)
	public ModelAndView hsnWiseReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/hsnWiseReport");
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			 
			model.addObject("frId", frDetails.getFrId());
			model.addObject("frName", frDetails.getFrName());
			 
			return model;			
	}
	
	@RequestMapping(value = "/getHsnWiseReport", method = RequestMethod.GET)
	@ResponseBody
	public List<TSellReport> getHsnWiseReport(HttpServletRequest request,
				HttpServletResponse response) {

		List<TSellReport> tSellReport = new ArrayList<TSellReport>();
			try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			
			RestTemplate rest = new RestTemplate();
			TSellReport tSellReportList[] = rest.postForObject(Constant.URL + "/tSellReport",map,
					TSellReport[].class);
			
			//System.out.println("tSellReport " + tSellReport);
			
			tSellReport = new ArrayList<>(Arrays.asList(tSellReportList));
			 List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
		 		
		 		ExportToExcel expoExcel=new ExportToExcel();
		 		List<String> rowData=new ArrayList<String>();
		 		 
		 		rowData.add("Sr No");
		 		rowData.add("Item Name");
		 		rowData.add("HSN Code");
		 		rowData.add("CGST"); 
		 		rowData.add("SGST");
		 		rowData.add("IGST");
		 		rowData.add("Taxable Amt");
		 		rowData.add("Tax Amt");
		 		rowData.add("Grand Total");
		 		expoExcel.setRowData(rowData);
		 		
		 		exportToExcelList.add(expoExcel);
		 		
		 		for(int i=0;i<tSellReport.size();i++)
		 		{
		 			  expoExcel=new ExportToExcel();
		 			 rowData=new ArrayList<String>();
		 			 
		 			 rowData.add(""+(i+1));
		 			 rowData.add(""+tSellReport.get(i).getItemName());
		 			 rowData.add(""+tSellReport.get(i).getHsnNo());
		 			 rowData.add(""+roundUp(tSellReport.get(i).getCgst()));
		 			 rowData.add(""+roundUp(tSellReport.get(i).getSgst())); 
		 			 rowData.add(""+roundUp(tSellReport.get(i).getIgst()));
		 			 rowData.add(""+roundUp(tSellReport.get(i).getTaxableAmt()));
		 			 rowData.add(""+roundUp(tSellReport.get(i).getTotalTax()));
		 			 rowData.add(""+roundUp(tSellReport.get(i).getGrandTotal()));
  
		 			expoExcel.setRowData(rowData);
		 			exportToExcelList.add(expoExcel);
		 			 
		 		}
		 		
		 		
				HttpSession session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "TSellReport");
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			return tSellReport;			
	}
	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "pdf/getHsnWiseReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView getHsnWiseReportPdf(@PathVariable String fromDate,@PathVariable String toDate,@PathVariable int frId,HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/hscCodeWisePdf");
		try {
			List<TSellReport> tSellReport = new ArrayList<TSellReport>();
			  
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			
			RestTemplate rest = new RestTemplate();
			tSellReport = rest.postForObject(Constant.URL + "/tSellReport",map,
					List.class);
			
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = rest.getForObject(Constant.URL + "getFranchisee?frId={frId}",
							Franchisee.class, frId);
			 
			//System.out.println("tSellReport " + tSellReport);
			 model.addObject("reportList",tSellReport);
			 model.addObject("fromDate",fromDate);
			 model.addObject("toDate",toDate);
			 model.addObject("frName", franchisee.getFrName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}
	
	@RequestMapping(value = "/grnReport", method = RequestMethod.GET)
	public ModelAndView grnGvnReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/grnReport");
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			 
			model.addObject("frId", frDetails.getFrId());
			model.addObject("frName", frDetails.getFrName());
			 
			return model;			
	}
	
	@RequestMapping(value = "/getgrnReport", method = RequestMethod.GET)
	@ResponseBody
	public List<GrnGvnReport> getgrnReport(HttpServletRequest request,
				HttpServletResponse response) {

		List<GrnGvnReport> getgrnReport = new ArrayList<GrnGvnReport>();
			try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String isGrn="1";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("isGrn", isGrn);
			//System.out.println("map " + map);
			RestTemplate rest = new RestTemplate();
			GrnGvnReport grnGvnReportList[] = rest.postForObject(Constant.URL + "/grnGvnReport",map,
					GrnGvnReport[].class);
			 
			getgrnReport = new ArrayList<>(Arrays.asList(grnGvnReportList));
			//System.out.println("getgrnReport " +getgrnReport);
			//System.out.println("grnGvnReportList " +grnGvnReportList);
			 List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
		 		
		 		ExportToExcel expoExcel=new ExportToExcel();
		 		List<String> rowData=new ArrayList<String>();
		 		 
		 		rowData.add("Sr No");
		 		rowData.add("Grn Gvn Date");
		 		rowData.add("Item Name");
		 		rowData.add("Tax Rate");
		 		rowData.add("Taxable Amt"); 
		 		rowData.add("Total Tax");
		 		rowData.add("Grn Gvn Amt");
		 		rowData.add("Approved Taxable Amt");
		 		rowData.add("Approved CGST Amt");
		 		rowData.add("Approved SGST Amt");
		 		rowData.add("Approved IGST Amt");
		 		rowData.add("Approved Grand Total");
		 		expoExcel.setRowData(rowData);
		 		
		 		exportToExcelList.add(expoExcel);
		 		
		 		for(int i=0;i<getgrnReport.size();i++)
		 		{
		 			  expoExcel=new ExportToExcel();
		 			 rowData=new ArrayList<String>();
		 			 
		 			 rowData.add(""+(i+1));
		 			 rowData.add(""+getgrnReport.get(i).getGrnGvnDate());
		 			 rowData.add(""+getgrnReport.get(i).getItemName());
		 			 rowData.add(""+getgrnReport.get(i).getTaxRate());
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getTaxableAmt()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getTotalTax())); 
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getGrnGvnAmt()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getAprTaxableAmt()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getAprCgstRs()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getAprSgstRs()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getAprIgstRs()));
		 			 rowData.add(""+roundUp(getgrnReport.get(i).getAprGrandTotal()));
		 			 
		 			expoExcel.setRowData(rowData);
		 			exportToExcelList.add(expoExcel);
		 			 
		 		}
		 		
		 		
				HttpSession session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "GrnGvnReport");
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			return getgrnReport;			
	}
	
	@RequestMapping(value = "pdf/getgrnReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView getgrnReportPdf(@PathVariable String fromDate,@PathVariable String toDate,@PathVariable int frId,HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/grnReportPdf");
		try {
			List<GrnGvnReport> getgrnReport = new ArrayList<GrnGvnReport>();
			  String isGrn="1";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("isGrn", isGrn);
			RestTemplate rest = new RestTemplate();
			getgrnReport = rest.postForObject(Constant.URL + "/grnGvnReport",map,
					List.class);
			
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = rest.getForObject(Constant.URL + "getFranchisee?frId={frId}",
							Franchisee.class, frId);
			 
			//System.out.println("getgrnReport " + getgrnReport);
			 model.addObject("reportList",getgrnReport);
			 model.addObject("fromDate",fromDate);
			 model.addObject("toDate",toDate);
			 model.addObject("frName", franchisee.getFrName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}
	
	@RequestMapping(value = "/gvnReport", method = RequestMethod.GET)
	public ModelAndView gvnReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/gvnReport");
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			 
			model.addObject("frId", frDetails.getFrId());
			model.addObject("frName", frDetails.getFrName());
			 
			return model;			
	}
	
	@RequestMapping(value = "/getgvnReport", method = RequestMethod.GET)
	@ResponseBody
	public List<GrnGvnReport> getgvnReport(HttpServletRequest request,
				HttpServletResponse response) {

		List<GrnGvnReport> getgrnReport = new ArrayList<GrnGvnReport>();
			try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String isGrn="0,2";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("isGrn", isGrn);
			//System.out.println("map " + map);
			RestTemplate rest = new RestTemplate();
			GrnGvnReport[] grnGvnReportList = rest.postForObject(Constant.URL + "/grnGvnReport",map,
					GrnGvnReport[].class);
			 
			getgrnReport = new ArrayList<GrnGvnReport>(Arrays.asList(grnGvnReportList));
			//System.out.println("getgrnReport " +getgrnReport);
			//System.out.println("grnGvnReportList " +grnGvnReportList);
			 List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
		 		
		 		ExportToExcel expoExcel=new ExportToExcel();
		 		List<String> rowData=new ArrayList<String>();
		 		 
		 		rowData.add("Sr No");
		 		rowData.add("Grn Gvn Date");
		 		rowData.add("Item Name");
		 		rowData.add("Tax Rate");
		 		rowData.add("Taxable Amt"); 
		 		rowData.add("Total Tax");
		 		rowData.add("Grn Gvn Amt");
		 		rowData.add("Approved Taxable Amt");
		 		rowData.add("Approved CGST Amt");
		 		rowData.add("Approved SGST Amt");
		 		rowData.add("Approved IGST Amt");
		 		rowData.add("Approved Grand Total");
		 		expoExcel.setRowData(rowData);
		 		
		 		exportToExcelList.add(expoExcel);
		 		
		 		for(int i=0;i<getgrnReport.size();i++)
		 		{
		 			  expoExcel=new ExportToExcel();
		 			 rowData=new ArrayList<String>();
		 			 
		 			 rowData.add(""+(i+1));
		 			 rowData.add(""+getgrnReport.get(i).getGrnGvnDate());
		 			 rowData.add(""+getgrnReport.get(i).getItemName());
		 			 rowData.add(""+getgrnReport.get(i).getTaxRate());
		 			 rowData.add(""+getgrnReport.get(i).getTaxableAmt());
		 			 rowData.add(""+getgrnReport.get(i).getTotalTax()); 
		 			 rowData.add(""+getgrnReport.get(i).getGrnGvnAmt());
		 			 rowData.add(""+getgrnReport.get(i).getAprTaxableAmt());
		 			 rowData.add(""+getgrnReport.get(i).getAprCgstRs());
		 			 rowData.add(""+getgrnReport.get(i).getAprSgstRs());
		 			 rowData.add(""+getgrnReport.get(i).getAprIgstRs());
		 			 rowData.add(""+getgrnReport.get(i).getAprGrandTotal());
		 			 
		 			expoExcel.setRowData(rowData);
		 			exportToExcelList.add(expoExcel);
		 			 
		 		}
		 		
		 		
				HttpSession session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "GrnGvnReport");
			//System.err.println("exportToExcelList"+exportToExcelList.toString());
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			return getgrnReport;			
	}
	
	@RequestMapping(value = "pdf/getgvnReportPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView getgvnReportPdf(@PathVariable String fromDate,@PathVariable String toDate,@PathVariable int frId,HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/gvnReportPdf");
		try {
			List<GrnGvnReport> getgrnReport = new ArrayList<GrnGvnReport>();
			  String isGrn="0,2";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("isGrn", isGrn);
			RestTemplate rest = new RestTemplate();
			getgrnReport = rest.postForObject(Constant.URL + "/grnGvnReport",map,
					List.class);
			
			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			Franchisee franchisee = rest.getForObject(Constant.URL + "getFranchisee?frId={frId}",
							Franchisee.class, frId);
			 
			//System.out.println("getgrnReport " + getgrnReport);
			 model.addObject("reportList",getgrnReport);
			 model.addObject("fromDate",fromDate);
			 model.addObject("toDate",toDate);
			 model.addObject("frName", franchisee.getFrName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}
	
	
	private Dimension format = PD4Constants.A4;
	private boolean landscapeValue = false;
	private int topValue = 8;
	private int leftValue = 0;
	private int rightValue = 0;
	private int bottomValue = 8;
	private String unitsValue = "m";
	private String proxyHost = "";
	private int proxyPort = 0;

	private int userSpaceWidth = 750;
	private static  int BUFFER_SIZE = 1024;
	
	@RequestMapping(value = "/tSellReport", method = RequestMethod.GET)
	public void showPDF(HttpServletRequest request, HttpServletResponse response) {

		String url=request.getParameter("reportURL");
		 
		File f = new File("/home/devour/apache-tomcat-9.0.12/webapps/uploads/ordermemo.pdf");
		//File f = new File("C:/pdf/ordermemo221.pdf");
		try {
			runConverter(Constant.ReportURL+url, f,request,response);
		} catch (IOException e) {
			// TODO Auto-generated catch block

			//System.out.println("Pdf conversion exception " + e.getMessage());
		}

		// get absolute path of the application
		ServletContext context = request.getSession().getServletContext();
		String appPath = context.getRealPath("");
		String filename = "ordermemo221.pdf";
		//String filePath = "/opt/tomcat-latest/webapps/uploads/ordermemo.pdf";
		String filePath = "/home/devour/apache-tomcat-9.0.12/webapps/uploads/ordermemo.pdf";
		//String filePath = "C:/pdf/ordermemo221.pdf";

		// construct the complete absolute path of the file
		String fullPath = appPath + filePath;
		File downloadFile = new File(filePath);
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(downloadFile);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			// get MIME type of the file
			String mimeType = context.getMimeType(fullPath);
			if (mimeType == null) {
				// set to binary type if MIME mapping not found
				mimeType = "application/pdf";
			}
			//System.out.println("MIME type: " + mimeType);

			String headerKey = "Content-Disposition";

			// response.addHeader("Content-Disposition", "attachment;filename=report.pdf");
			response.setContentType("application/pdf");

			// get output stream of the response
			OutputStream outStream;

			outStream = response.getOutputStream();

			byte[] buffer = new byte[BUFFER_SIZE];
			int bytesRead = -1;

			// write bytes read from the input stream into the output stream

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			inputStream.close();
			outStream.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void runConverter(String urlstring, File output, HttpServletRequest request, HttpServletResponse response ) throws IOException {

		if (urlstring.length() > 0) {
			if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
				urlstring = "http://" + urlstring;
			}
			//System.out.println("PDF URL " + urlstring);
			java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

			PD4ML pd4ml = new PD4ML();
		
			try {

				Dimension landscapeA4 = pd4ml.changePageOrientation(PD4Constants.A4);
				pd4ml.setPageSize(landscapeA4);
			
				PD4PageMark footer = new PD4PageMark();  
				
	            footer.setPageNumberTemplate("Page $[page] of $[total]");  
	            footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);  
	            footer.setFontSize(10);  
	            footer.setAreaHeight(20);     
	            
	            pd4ml.setPageFooter(footer); 
				
			} catch (Exception e) {
				//System.out.println("Pdf conversion method excep " + e.getMessage());
			}

			if (unitsValue.equals("mm")) {
				pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
			} else {
				pd4ml.setPageInsets(new Insets(topValue, leftValue, bottomValue, rightValue));
			}

			pd4ml.setHtmlWidth(userSpaceWidth);

			pd4ml.render(urlstring, fos);
		}
	}
	
	@RequestMapping(value = "/viewAccPndngItmReport", method = RequestMethod.GET)
	public ModelAndView viewAccPndngItmReport(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/accPendingItmGrnGvn");
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			 
			model.addObject("frId", frDetails.getFrId());
			model.addObject("frName", frDetails.getFrName());
			 
			return model;			
	}
	List<PendingGrnGvnItemWise> grnAcGvnList = new ArrayList<PendingGrnGvnItemWise>();
	@RequestMapping(value = "/viewAccPendingItemsGrnGvn", method = RequestMethod.GET)
	@ResponseBody
	public List<PendingGrnGvnItemWise> getAccPendingItemsGrnGvn(HttpServletRequest request, HttpServletResponse response) {
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			RestTemplate restTemplate = new RestTemplate();
			
			System.out.println("inside getAccPendingItemsGrnGvn ajax call");

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("from_date");
			String toDate = request.getParameter("to_date");
			String isGrn = request.getParameter("is_grn");
			int aprvBy = Integer.parseInt(request.getParameter("apprvBy"));
		//	int grnStatus = Integer.parseInt(request.getParameter("grnStatus"));
			int grnStatus = 6;

			map = new LinkedMultiValueMap<String, Object>();
			
			String grnType = null;
			if (isGrn.equalsIgnoreCase("2")) {
				grnType = "1" + "," + "0";

				map.add("isGrn", grnType);
			} else {
			//	System.err.println("Is Grn not =2");
				grnType = isGrn;
				map.add("isGrn", grnType);
			}
			
			
			map.add("frIdList", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate",  DateConvertor.convertToYMD(toDate));
			map.add("grnStatus", grnStatus);
			map.add("aprvBy", aprvBy);
			
			System.out.println(frDetails.getFrId()+" / "+fromDate+" / "+toDate+" / "+grnStatus+" / "+aprvBy+" / "+grnType);
			
			
			ParameterizedTypeReference<List<PendingGrnGvnItemWise>> typeRef = new ParameterizedTypeReference<List<PendingGrnGvnItemWise>>() {
			};
			ResponseEntity<List<PendingGrnGvnItemWise>> responseEntity = null;
			try {
			responseEntity = restTemplate
					.exchange(Constant.URL + "getAcPendingItemGrnGvnReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			}catch (HttpClientErrorException e) {
				System.out.println(e.getResponseBodyAsString());
			}
			grnAcGvnList = responseEntity.getBody();
			

		//	System.err.println("A/c Pending grnGvnList ------------------- " + grnAcGvnList);

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No.");
			rowData.add("GRN GVN SrNo.");
			rowData.add("Type");
			rowData.add("GRN GVN Date");
			rowData.add("Item Name");
			rowData.add("Qty");	
			rowData.add("GRN GVN Status");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			List<PendingGrnGvnItemWise> excelItems = grnAcGvnList;
			for (int i = 0; i < excelItems.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("" + (i + 1));				
				
				rowData.add(excelItems.get(i).getGrngvnDate());
				rowData.add(excelItems.get(i).getIsGrn()==1 ? "GRN" : "GVN");
				rowData.add("" + excelItems.get(i).getGrngvnDate());
				rowData.add(excelItems.get(i).getItemName());
				rowData.add("" + excelItems.get(i).getGrnGvnQty());
				
				String grnGvnstatus = null;
				if (excelItems.get(i).getGrngvnStatus() == 1)
					grnGvnstatus = "Pending";
				else if (excelItems.get(i).getGrngvnStatus() == 2)
					grnGvnstatus = "Approved By Gate";
				else if (excelItems.get(i).getGrngvnStatus() == 3)
					grnGvnstatus = "Reject By Gate";
				else if (excelItems.get(i).getGrngvnStatus() == 4)
					grnGvnstatus = "Approved By Store";
				else if (excelItems.get(i).getGrngvnStatus() == 5)
					grnGvnstatus = "Reject By Store";
				else if (excelItems.get(i).getGrngvnStatus() == 6)
					grnGvnstatus = "Approved By Acc";
				else
					grnGvnstatus = "Reject By Acc";

				rowData.add(grnGvnstatus);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "A/c Pending Item Wise Grn Gvn");

		} catch (Exception e) {

			System.out.println("Ex in getting /getGrnGvnPendingItems List  Ajax call" + e.getMessage());
			e.printStackTrace();
		}

		return grnAcGvnList;

	}
	
	@RequestMapping(value = "pdf/showPndItemGrnGvnReportPdf/{fromDate}/{toDate}/{frIds}/{aprvBy}/{isGrn}", method = RequestMethod.GET)
	public ModelAndView showPndItemGrnGvnReportPdf(@PathVariable("fromDate") String fromDate, @PathVariable("toDate") String toDate,
			@PathVariable("frIds") String frIds,
			@PathVariable("aprvBy") int aprvBy , @PathVariable("isGrn") String isGrn, HttpServletRequest request, HttpServletResponse response)
			throws FileNotFoundException {
		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/acPndItmGvnReportPdf");
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			RestTemplate restTemplate = new RestTemplate();
			String grnType=null;
			if (isGrn.equalsIgnoreCase("2")) {
				grnType = "1" + "," + "0";

				map.add("isGrn", grnType);
			} else {
			//	System.err.println("Is Grn not =2");
				grnType = isGrn;
				map.add("isGrn", grnType);
			}
			int grnStatus = 6;
			
			map.add("frIdList", frIds);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate",  DateConvertor.convertToYMD(toDate));
			map.add("grnStatus", grnStatus);
			map.add("aprvBy", aprvBy);

			ParameterizedTypeReference<List<PendingGrnGvnItemWise>> typeRef = new ParameterizedTypeReference<List<PendingGrnGvnItemWise>>() {
			};
			ResponseEntity<List<PendingGrnGvnItemWise>> responseEntity = null;
			try {
			responseEntity = restTemplate
					.exchange(Constant.URL + "getAcPendingItemGrnGvnReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			}catch (HttpClientErrorException e) {
				System.out.println(e.getResponseBodyAsString());
			}
			grnAcGvnList = responseEntity.getBody();
			
			model.addObject("report", grnAcGvnList);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		model.addObject("report", grnAcGvnList);
		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);
		model.addObject("isGrn", isGrn);
		
		return model;
		
	}
	
	@RequestMapping(value = "/viewCrnGrnGvnItemQty", method = RequestMethod.GET)
	public ModelAndView viewCrnGrnGvnItemQty(HttpServletRequest request,
				HttpServletResponse response) {

			ModelAndView model = new ModelAndView("report/sellReport/crnGrnGvnItem");
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			 
			model.addObject("frId", frDetails.getFrId());
			model.addObject("frName", frDetails.getFrName());
			 
			return model;			
	}
	
	
	@RequestMapping(value = "/getCreditNoteGrnGvnItmQty", method = RequestMethod.GET)
	@ResponseBody
	public List<CreditNoteGrnGvnItemWise> getCreditNoteGrnGvnItmQty(HttpServletRequest request, HttpServletResponse response) {
		List<CreditNoteGrnGvnItemWise> grnAcGvnList = new ArrayList<CreditNoteGrnGvnItemWise>();
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			RestTemplate restTemplate = new RestTemplate();
			
			System.out.println("inside getAccPendingItemsGrnGvn ajax call");

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			String fromDate = request.getParameter("from_date");
			String toDate = request.getParameter("to_date");
			String isGrn = request.getParameter("is_grn");

			map = new LinkedMultiValueMap<String, Object>();
			
			String grnType = null;
			if (isGrn.equalsIgnoreCase("2")) {
				grnType = "1" + "," + "0";

				map.add("isGrn", grnType);
			} else {
				System.err.println("Is Grn not =2");
				grnType = isGrn;
				map.add("isGrn", grnType);
			}
			
			
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate",  DateConvertor.convertToYMD(toDate));			
			
			
			ParameterizedTypeReference<List<CreditNoteGrnGvnItemWise>> typeRef = new ParameterizedTypeReference<List<CreditNoteGrnGvnItemWise>>() {
			};
			ResponseEntity<List<CreditNoteGrnGvnItemWise>> responseEntity = null;
			try {
			responseEntity = restTemplate
					.exchange(Constant.URL + "getCrnItemGrnGvnReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			}catch (HttpClientErrorException e) {
				System.out.println(e.getResponseBodyAsString());
			}
			grnAcGvnList = responseEntity.getBody();
			

			//System.err.println("A/c Pending grnGvnList ------------------- " + grnAcGvnList);

			

		} catch (Exception e) {

			System.out.println("Ex in getting /getCreditNoteGrnGvnItmQty List  Ajax call" + e.getMessage());
			e.printStackTrace();
		}

		return grnAcGvnList;

	}
	
	@RequestMapping(value = "pdf/showCrnGrnGvnItemQtyPdf/{fromDate}/{toDate}/{frIds}/{isGrn}", method = RequestMethod.GET)
	public ModelAndView showPndItemGrnGvnReportPdf(@PathVariable("fromDate") String fromDate, @PathVariable("toDate") String toDate,
			@PathVariable("frIds") String frIds,  @PathVariable("isGrn") String isGrn, HttpServletRequest request, HttpServletResponse response)
			throws FileNotFoundException {
		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/crnGrnGvnItemQtyPdf");
		List<CreditNoteGrnGvnItemWise> grnAcGvnList = new ArrayList<CreditNoteGrnGvnItemWise>();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			RestTemplate restTemplate = new RestTemplate();
			String grnType=null;
			if (isGrn.equalsIgnoreCase("2")) {
				grnType = "1" + "," + "0";

				map.add("isGrn", grnType);
			} else {
				System.err.println("Is Grn not =2");
				grnType = isGrn;
				map.add("isGrn", grnType);
			}
			int grnStatus = 6;
			
			map.add("frId", frIds);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate",  DateConvertor.convertToYMD(toDate));			
			
			
			ParameterizedTypeReference<List<CreditNoteGrnGvnItemWise>> typeRef = new ParameterizedTypeReference<List<CreditNoteGrnGvnItemWise>>() {
			};
			ResponseEntity<List<CreditNoteGrnGvnItemWise>> responseEntity = null;
			try {
			responseEntity = restTemplate
					.exchange(Constant.URL + "getCrnItemGrnGvnReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			}catch (HttpClientErrorException e) {
				System.out.println(e.getResponseBodyAsString());
			}
			grnAcGvnList = responseEntity.getBody();
			
			model.addObject("report", grnAcGvnList);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		model.addObject("report", grnAcGvnList);
		model.addObject("fromDate", fromDate);
		model.addObject("toDate", toDate);
		model.addObject("isGrn", isGrn);
		
		return model;
		
	}
	
	@RequestMapping(value = "/showFranchiseeSummaryReport", method = RequestMethod.GET)
	public ModelAndView showFranchiseeWiseBillReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		model = new ModelAndView("report/sellReport/frwiseSummeryReport");

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			String todaysDate = date.format(formatters);
			
			Franchisee frDetasessionils = (Franchisee) session.getAttribute("frDetails");
			model.addObject("frId", frDetasessionils.getFrId());
			
		} catch (Exception e) {

			System.out.println("Exc in show sales report bill wise  " + e.getMessage());
			e.printStackTrace();

		}
		return model;

	}
	
	@RequestMapping(value = "/getSaleFrwiseReport", method = RequestMethod.GET)
	public @ResponseBody List<SalesReportFranchisee> getSaleFrwiseReport(HttpServletRequest request,
			HttpServletResponse response) {

		List<SalesReportFranchisee> saleList = new ArrayList<>();
		String fromDate = "";
		String toDate = "";
		try {

			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			System.out.println("************************" + frDetails.getFrId());

			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			RestTemplate restTemplate = new RestTemplate();

			System.out.println("Inside If all fr Selected "); 
			
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("frIdList", frDetails.getFrId());

			ParameterizedTypeReference<List<SalesReportFranchisee>> typeRef = new ParameterizedTypeReference<List<SalesReportFranchisee>>() {
			};
			ResponseEntity<List<SalesReportFranchisee>> responseEntity = restTemplate.exchange(
					Constant.URL + "getSaleReportFrwiseSummery", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			saleList = responseEntity.getBody();

			System.out.println("saleList*********************************************" + saleList.toString());

		} catch (

		Exception e) {
			System.out.println("get sale Report Bill Wise " + e.getMessage());
			e.printStackTrace();

		}

		// exportToExcel
		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sr");
		rowData.add("Date");
		rowData.add("Type");
		rowData.add("Document");
		rowData.add("Order Ref");
		rowData.add("Dr Amt");
		rowData.add("Cr Amt");
		rowData.add("Balance");

		expoExcel.setRowData(rowData);
		int srno = 1;
		exportToExcelList.add(expoExcel);
		float drTotalAmt = 0.0f;
		float crTotalAmt = 0.0f;
		float bal = 0.0f;
		
		for (int i = 0; i < saleList.size(); i++) {

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("" + srno);
			rowData.add(saleList.get(i).getBillDate());
			rowData.add(saleList.get(i).getType());
			rowData.add(saleList.get(i).getInvoiceNo());
			rowData.add(saleList.get(i).getOrderRef());

			if (saleList.get(i).getType().equals("INV")) {

				bal = bal + saleList.get(i).getGrandTotal();
				
				drTotalAmt = drTotalAmt + saleList.get(i).getGrandTotal();
				rowData.add("" +saleList.get(i).getGrandTotal());
				rowData.add("0");
				
			}else if (saleList.get(i).getType().equals("RET")) {
				
				bal = bal - saleList.get(i).getGrandTotal();
				crTotalAmt = crTotalAmt + saleList.get(i).getGrandTotal();
				rowData.add("0");
				rowData.add("" +saleList.get(i).getGrandTotal());
				
			}else if (saleList.get(i).getType().equals("VER")) {
				
				bal = bal - saleList.get(i).getGrandTotal();
				crTotalAmt = crTotalAmt + saleList.get(i).getGrandTotal();
				rowData.add("0");
				rowData.add("" +saleList.get(i).getGrandTotal());
				
			} else {
				rowData.add("0");
				rowData.add("0");
			}

			rowData.add("" +bal);
			srno = srno + 1;

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}
		expoExcel = new ExportToExcel();
		rowData = new ArrayList<String>();

		rowData.add("");
		rowData.add("");
		rowData.add("");
		rowData.add("");
		rowData.add("Total");

		rowData.add("" + roundUp(drTotalAmt));
		rowData.add("" + roundUp(crTotalAmt));
		rowData.add("" + roundUp(drTotalAmt - crTotalAmt));

		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelListNew", exportToExcelList);
		session.setAttribute("excelNameNew", "SaleBillWiseDate");
		session.setAttribute("reportNameNew", "Bill-wise Report");
		session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
		session.setAttribute("mergeUpto1", "$A$1:$G$1");
		session.setAttribute("mergeUpto2", "$A$2:$G$2");

		return saleList;
	}
	
//Normal Pdf for Franchise Summary Report
//----------------------------------------------
//	@RequestMapping(value = "pdf/showSummeryFrByFrPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
//	public ModelAndView showSummeryFrByFrPdf(@PathVariable String fromDate, @PathVariable String toDate,
//			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {
//		ModelAndView model = new ModelAndView("sellReport/sellReportPdf/frwiseSummeryPdf");
//
//		List<SalesReportFranchisee> saleList = new ArrayList<>();
//
//		try {
//			HttpSession ses = request.getSession();
//			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
//
//			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
//			RestTemplate restTemplate = new RestTemplate();
//			map.add("fromDate", fromDate );
//			map.add("toDate", toDate);
//			map.add("frIdList", frId);
//
//			System.out.println(map);
//			
//			ParameterizedTypeReference<List<SalesReportFranchisee>> typeRef = new ParameterizedTypeReference<List<SalesReportFranchisee>>() {
//			};
//			ResponseEntity<List<SalesReportFranchisee>> responseEntity = restTemplate.exchange(
//					Constant.URL + "getSaleReportFrwiseSummery", HttpMethod.POST, new HttpEntity<>(map), typeRef);
//			saleList = responseEntity.getBody();
//			model.addObject("salesRepFrList", saleList);
//			model.addObject("FACTORYNAME", Constant.FACTORYNAME);
//			model.addObject("FACTORYADDRESS", Constant.FACTORYADDRESS);
//			model.addObject("fromDate", fromDate);
//			model.addObject("toDate", toDate);
//		} catch (
//
//		Exception e) {
//			System.out.println("get sale Report Bill Wise " + e.getMessage());
//			e.printStackTrace();
//		}
//		return model;
//	}
	
	//-Matrix Pdf for Franchise Summary Report
	@RequestMapping(value = "pdf/viewSummeryFrByFrPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView showSummeryFrByFrPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable int frId, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("report/sellReport/sellReportPdf/frSumryMatPdf");

		List<SalesReportFranchisee> saleList = new ArrayList<>();

		try {
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			RestTemplate restTemplate = new RestTemplate();
			map.add("fromDate", fromDate );
			map.add("toDate", toDate);
			map.add("frIdList", frId);

			System.out.println(map);
			
			ParameterizedTypeReference<List<SalesReportFranchisee>> typeRef = new ParameterizedTypeReference<List<SalesReportFranchisee>>() {
			};
			ResponseEntity<List<SalesReportFranchisee>> responseEntity = restTemplate.exchange(
					Constant.URL + "getSaleReportFrwiseSummery", HttpMethod.POST, new HttpEntity<>(map), typeRef);
			saleList = responseEntity.getBody();
			model.addObject("salesRepFrList", saleList);
			model.addObject("FACTORYNAME", Constant.FACTORYNAME);
			model.addObject("FACTORYADDRESS", Constant.FACTORYADDRESS);
			model.addObject("fromDate", fromDate);
			model.addObject("toDate", toDate);
		} catch (

		Exception e) {
			System.out.println("get sale Report Bill Wise " + e.getMessage());
			e.printStackTrace();
		}
		return model;
	}
	
}

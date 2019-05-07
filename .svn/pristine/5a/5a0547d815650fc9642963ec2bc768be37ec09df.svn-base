<%--  
描述：文档导出
作者：邱炼
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.tjy.device.dao.Impl.DevAccountInfoDaoImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.dao.DevAccountInfoDao"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.*"%>
<%@page import="jxl.Workbook"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="application/octet-stream; charset=utf-8"%>
<%
	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	String path =  FileUtil.getAppContextPath() + CacheCommonManageProxy.getSystemParam("personholder_tempExcelFilePath");//根据实际情况写路径
	File file = new File(path + "Excel.xls");

	try {
		if (!file.exists()) {
			file.createNewFile();
		}
		//文件下载数据
		String sortName = request.getParameter("sidx");
		String sortOrder = request.getParameter("sord");
		String sJson = request.getParameter("sJson");
		
		if (!StringUtil.isBlank(sJson) ) {
			sJson = Escape.unescape(DataControlUtil.replaceStr(sJson));
		}

		DevAccountInfoDao devaccountinfodao = new DevAccountInfoDaoImpl();
		Connection conn = DbManager.getInstance().getTransactionConnection();
		
		List<Map<String, String>> list = null;
		PagingBean pb = null;
		pb= devaccountinfodao.selDevAccountList(sJson,"arrive_time","asc",0,1000000);
		list = (List<Map<String, String>>) pb.getList();
		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			String filename = new String("仪器设备台帐资料".getBytes("GBK"),"iso8859-1");
			
			response.setContentType("application/octet-stream;");
			response.addHeader("Content-disposition",
					"attachment; filename=" + filename +".xls");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("设备台帐信息", 0);
			//设置列宽
			ws.setColumnView(0, 10);//序号
			ws.setColumnView(1, 15);//设备编号
			ws.setColumnView(2, 20);//设备标题
			ws.setColumnView(3, 20);//使用部门
			ws.setColumnView(4, 20);//保管人
			ws.setColumnView(5, 20);//规格型号
			ws.setColumnView(6, 20);//制造厂商
			ws.setColumnView(7, 20);//生产日期
			ws.setColumnView(8, 20);//出厂编号
			ws.setColumnView(9, 20);//到货日期
			ws.setColumnView(10, 20);//供应商名称
			ws.setColumnView(11, 20);//库存状态
			ws.setColumnView(12, 20);//登记人
			ws.setColumnView(13, 20);//登记时间
			ws.setColumnView(14, 20);//金额
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(6, 1, "设备台帐", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			//设置标题区域的表格
			WritableFont w_title = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.BOLD);
			WritableCellFormat wc_title = new WritableCellFormat(w_title);
			wc_title.setBorder(Border.ALL,BorderLineStyle.THIN);
			
			Label lab3 = new Label(0, 2, "序号",wc_title);
			Label lab4 = new Label(1, 2, "设备编号",wc_title);
			Label lab5 = new Label(2, 2, "名称",wc_title);
			Label lab6 = new Label(3, 2, "使用部门",wc_title);
			Label lab7 = new Label(4, 2, "保管人",wc_title);
			Label lab8 = new Label(5, 2, "规格型号",wc_title);
			Label lab9 = new Label(6, 2, "制造厂商",wc_title);
			Label lab10 = new Label(7, 2, "生产日期",wc_title);
			Label lab11 = new Label(8, 2, "出厂编号",wc_title);
			Label lab12 = new Label(9, 2, "到货日期",wc_title);
			Label lab13 = new Label(10, 2, "供应商名称",wc_title);
			Label lab14 = new Label(11, 2, "库存状态",wc_title);
			Label lab15 = new Label(12, 2, "登记人",wc_title);
			Label lab16 = new Label(13, 2, "登记时间",wc_title);
			Label lab17 = new Label(14, 2, "金额",wc_title);
			
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			ws.addCell(lab10);
			ws.addCell(lab11);
			ws.addCell(lab12);
			ws.addCell(lab13);
			ws.addCell(lab14);
			ws.addCell(lab15);
			ws.addCell(lab16);
			ws.addCell(lab17);
			//设置列表数据中的表格
			WritableFont w_cols = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.NO_BOLD);
			WritableCellFormat wc_cols = new WritableCellFormat(w_cols);
			wc_cols.setBorder(Border.ALL,BorderLineStyle.THIN);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21  = new Label(0 , i, String.valueOf(i-2),wc_cols);
				Label lab22  = new Label(1 , i, list.get(i - 3).get("dev_code"),wc_cols);
				Label lab23  = new Label(2 , i, list.get(i - 3).get("dev_name"),wc_cols);
				Label lab24  = new Label(3 , i, list.get(i - 3).get("user_orgname"),wc_cols);
				Label lab25  = new Label(4 , i, list.get(i - 3).get("custos_username"),wc_cols);
				Label lab26  = new Label(5 , i, list.get(i - 3).get("type"),wc_cols);
				Label lab27  = new Label(6 , i, list.get(i - 3).get("make_users"),wc_cols);
				Label lab28  = new Label(7 , i, list.get(i - 3).get("creat_date"),wc_cols);
				Label lab29  = new Label(8 , i, list.get(i - 3).get("factory_no"),wc_cols);
				Label lab30  = new Label(9 , i, list.get(i - 3).get("arrive_time"),wc_cols);
				Label lab31  = new Label(10, i, list.get(i - 3).get("devsup_mc"),wc_cols);
				//库存状态
				String dev_stockflag = list.get(i - 3).get("dev_stockflag");
				//使用完好状态
				String dev_state =list.get(i - 3).get("dev_state");
				String dev_stockflag1="";
				if(("1").equals(dev_stockflag)){
					dev_stockflag1 = "在库";
				} else if(("2").equals(dev_stockflag)){
					dev_stockflag1="借出";
				} else if(("3").equals(dev_stockflag)){
					dev_stockflag1="出租";
				} else {
					dev_stockflag1="";
				}
				String dev_state1 ="";
             	//设备完好状态  1:完好2:在修 3:报废 4:损耗
				if(("1").equals(dev_state)){
					dev_state1 = "完好";
				} else if(("2").equals(dev_state)){
					dev_state1="在修";
				} else if(("3").equals(dev_state)){
					dev_state1="报废";
				} else if(("4").equals(dev_state)){
					dev_state1="损耗";
				} else if("5".equals(dev_state)){
					dev_state1="停用";
				} else {
					dev_state1="";
				}
				
				Label lab32  = new Label(11, i, dev_stockflag1+"/"+dev_state1,wc_cols); //库存状态
				Label lab33  = new Label(12, i, list.get(i - 3).get("creater_username"),wc_cols);
				Label lab34  = new Label(13, i, list.get(i - 3).get("creat_time"),wc_cols);
				Label lab35  = new Label(14, i, list.get(i - 3).get("price"),wc_cols);
				
				ws.addCell(lab21);
				ws.addCell(lab22);
				ws.addCell(lab23);
				ws.addCell(lab24);
				ws.addCell(lab25);
				ws.addCell(lab26);
				ws.addCell(lab27);
				ws.addCell(lab28);
				ws.addCell(lab29);
				ws.addCell(lab30);
				ws.addCell(lab31);
				ws.addCell(lab32);
				ws.addCell(lab33);
				ws.addCell(lab34);
				ws.addCell(lab35);
				
			}
			wwk.write();
			wwk.close();
			fos.flush();
			fos.close();

			obis = (InputStream) (new FileInputStream(path
					+ "Excel.xls"));

			byte[] b = new byte[1024];
			int i = 0;
			while ((i = obis.read(b)) > 0) {
				output.write(b, 0, i);
			}

			output.flush();
			out.clear();
			out = pageContext.pushBody();
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (file.exists()) {
			file.delete();
		}
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if (obis != null) {
			obis.close();
			obis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>

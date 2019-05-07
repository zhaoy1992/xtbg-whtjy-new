<%--  
描述：文档导出
作者：邱炼
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.dao.Impl.LandHouseInfoDaoImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.dao.LandHouseInfoDao"%>
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

		LandHouseInfoDao dao = new LandHouseInfoDaoImpl();
		Connection conn = DbManager.getInstance().getTransactionConnection();
		
		List<Map<String, String>> list = null;
		PagingBean pb = null;
		pb= dao.getDataList(sJson,"lh_create_time","desc",0,1000000);
		list = (List<Map<String, String>>) pb.getList();
		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			String filename = new String("土地房屋资料".getBytes("GBK"),"iso8859-1");
			response.setContentType("application/octet-stream;");
			response.addHeader("Content-disposition",
					"attachment; filename=" + filename +".xls");
			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("土地房屋信息", 0);
			//设置列宽
			ws.setColumnView(0, 10);//序号
			ws.setColumnView(1, 15);//编号
			ws.setColumnView(2, 20);//名称
			ws.setColumnView(3, 20);//面积
			ws.setColumnView(4, 20);//地点
			ws.setColumnView(5, 20);//证号
			ws.setColumnView(6, 20);//日期
			ws.setColumnView(7, 20);//金额
			ws.setColumnView(8, 20);//备注
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(4, 1, "设备台帐", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			//设置标题区域的表格
			WritableFont w_title = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.BOLD);
			WritableCellFormat wc_title = new WritableCellFormat(w_title);
			wc_title.setBorder(Border.ALL,BorderLineStyle.THIN);
			Label lab3 = new Label(0, 2, "序号",wc_title);
			Label lab4 = new Label(1, 2, "编号",wc_title);
			Label lab5 = new Label(2, 2, "名称",wc_title);
			Label lab6 = new Label(3, 2, "面积",wc_title);
			Label lab7 = new Label(4, 2, "地点",wc_title);
			Label lab8 = new Label(5, 2, "证号",wc_title);
			Label lab9 = new Label(6, 2, "日期",wc_title);
			Label lab10 = new Label(7, 2, "金额",wc_title);
			Label lab11 = new Label(8, 2, "备注",wc_title);
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			ws.addCell(lab10);
			ws.addCell(lab11);
			//设置列表数据中的表格
			WritableFont w_cols = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.NO_BOLD);
			WritableCellFormat wc_cols = new WritableCellFormat(w_cols);
			wc_cols.setBorder(Border.ALL,BorderLineStyle.THIN);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21  = new Label(0 , i, String.valueOf(i-2),wc_cols);
				Label lab22  = new Label(1 , i, list.get(i - 3).get("lh_number"),wc_cols);
				Label lab23  = new Label(2 , i, list.get(i - 3).get("lh_name"),wc_cols);
				Label lab24  = new Label(3 , i, list.get(i - 3).get("lh_area"),wc_cols);
				Label lab25  = new Label(4 , i, list.get(i - 3).get("lh_location"),wc_cols);
				Label lab26  = new Label(5 , i, list.get(i - 3).get("lh_identify_code"),wc_cols);
				Label lab27  = new Label(6 , i, list.get(i - 3).get("lh_date"),wc_cols);
				Label lab28  = new Label(7 , i, list.get(i - 3).get("lh_money"),wc_cols);
				Label lab29  = new Label(8 , i, list.get(i - 3).get("lh_remarks"),wc_cols);
				ws.addCell(lab21);
				ws.addCell(lab22);
				ws.addCell(lab23);
				ws.addCell(lab24);
				ws.addCell(lab25);
				ws.addCell(lab26);
				ws.addCell(lab27);
				ws.addCell(lab28);
				ws.addCell(lab29);
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

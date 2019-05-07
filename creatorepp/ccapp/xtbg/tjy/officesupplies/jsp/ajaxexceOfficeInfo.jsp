<%--  
描述：文档导出
作者：邱炼
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OsHavaObjectDaoImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.dao.OsHavaObjectDao"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
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
		OsHavaObjectDao dao = new OsHavaObjectDaoImpl();
		Connection conn = DbManager.getInstance().getTransactionConnection();
		
		List<Map<String, String>> list = null;
		PagingBean pb = null;
		pb= dao.findOsHavaList(sJson,"t_ha_buydate","asc",0,1000000);
		list = (List<Map<String, String>>) pb.getList();
		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			String filename = new String("办公用品易耗品库存".getBytes("GBK"),"iso8859-1");
			
			response.setContentType("application/octet-stream;");
			response.addHeader("Content-disposition",
					"attachment; filename=" + filename +".xls");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("办公用品易耗品库存信息", 0);
			//设置列宽
			ws.setColumnView(0, 10);//序号
			ws.setColumnView(1, 15);//物品名称
			ws.setColumnView(2, 20);//物品类型名称
			ws.setColumnView(3, 20);//规格名称
			ws.setColumnView(4, 20);//单价
			ws.setColumnView(5, 20);//数量
			ws.setColumnView(6, 20);//入库时间
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);
			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(3, 1, "易耗品库存", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			//设置标题区域的表格
			WritableFont w_title = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.BOLD);
			WritableCellFormat wc_title = new WritableCellFormat(w_title);
			wc_title.setBorder(Border.ALL,BorderLineStyle.THIN);
			
			Label lab3 = new Label(0, 2, "序号",wc_title);
			Label lab4 = new Label(1, 2, "物品名称",wc_title);
			Label lab5 = new Label(2, 2, "物品类型名称",wc_title);
			Label lab6 = new Label(3, 2, "规格名称",wc_title);
			Label lab7 = new Label(4, 2, "单价",wc_title);
			Label lab8 = new Label(5, 2, "数量",wc_title);
			Label lab9 = new Label(6, 2, "入库时间",wc_title);
			
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			
			//设置列表数据中的表格
			WritableFont w_cols = new WritableFont(WritableFont.ARIAL, 10,
					WritableFont.NO_BOLD);
			WritableCellFormat wc_cols = new WritableCellFormat(w_cols);
			wc_cols.setBorder(Border.ALL,BorderLineStyle.THIN);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21  = new Label(0 , i, String.valueOf(i-2),wc_cols);
				Label lab22  = new Label(1 , i, list.get(i - 3).get("ofustype_name"),wc_cols);
				Label lab23  = new Label(2 , i, list.get(i - 3).get("oftype_name"),wc_cols);
				Label lab24  = new Label(3 , i, list.get(i - 3).get("it_name"),wc_cols);
				Label lab25  = new Label(4 , i, list.get(i - 3).get("t_ha_dj"),wc_cols);
				Label lab26  = new Label(5 , i, list.get(i - 3).get("t_ha_no"),wc_cols);
				Label lab27  = new Label(6 , i, list.get(i - 3).get("t_ha_buydate"),wc_cols);
				
				ws.addCell(lab21);
				ws.addCell(lab22);
				ws.addCell(lab23);
				ws.addCell(lab24);
				ws.addCell(lab25);
				ws.addCell(lab26);
				ws.addCell(lab27);
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

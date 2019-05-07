<%--  
描述：督查事项统计导出
作者：肖杰
版本：1.0
日期：2013-10-06
--%>
<%@page import="com.chinacreator.xtbg.core.inspect.dao.InspectManageDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
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
	String path = request.getContextPath();//根据实际情况写路径
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

		InspectManageDao dao = (InspectManageDao)LoadSpringContext.getApplicationContext().getBean("InspectManageDaoImpl");		
		List<Map<String, String>> list = null;
		PagingBean pb = null;
		pb= dao.selInspectCountList(sJson,"org_name","",0,5000);
		list=(List<Map<String, String>>)pb.getList();
		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "督查事项统计清单.xls");
			output = response.getOutputStream();
			String filename="督查事项统计清单.xls";
			filename = new String(filename.getBytes("GBK"), "ISO8859_1");
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename=\""+ filename + "\"");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("督查事项统计清单", 0);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(4, 1, "督查事项统计清单", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			WritableFont wf1 = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
			WritableCellFormat wcf1 = new WritableCellFormat(wf1);
			Label lab3 = new Label(1, 2, "序号",wcf1);
			Label lab4 = new Label(2, 2, "单位名称",wcf1);
			Label lab5 = new Label(3, 2, "任务数量",wcf1);
			Label lab6 = new Label(4, 2, "反馈数量",wcf1);
			Label lab7 = new Label(5, 2, "完成数量",wcf1);
			Label lab8 = new Label(6, 2, "未完成数量",wcf1);
			Label lab9 = new Label(7, 2, "办理中数量",wcf1);
			ws.setColumnView(1, 10);
			ws.setColumnView(2, 40);
			ws.setColumnView(3, 20);
			ws.setColumnView(4, 20);
			ws.setColumnView(5, 20);
			ws.setColumnView(6, 20);
			ws.setColumnView(7, 20);
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21  = new Label(1 , i, String.valueOf(i-2));
				Label lab22  = new Label(2 , i, list.get(i - 3).get("org_name"));
				Label lab23  = new Label(3 , i, list.get(i - 3).get("count1"));
				Label lab24  = new Label(4 , i, list.get(i - 3).get("count2"));
				Label lab25  = new Label(5 , i, list.get(i - 3).get("count3"));
				Label lab26  = new Label(6 , i, list.get(i - 3).get("count4"));
				Label lab27  = new Label(7 , i, list.get(i - 3).get("count5"));
				
				
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
					+ "督查事项统计清单.xls"));

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

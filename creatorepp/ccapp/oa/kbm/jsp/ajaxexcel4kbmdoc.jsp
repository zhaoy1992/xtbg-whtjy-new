<%--  
描述：文档导出
作者：黄海
版本：1.0
日期：2013-08-11
--%>
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
<%@page import="com.chinacreator.xtbg.core.kbm.service.*" %>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.*" %>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.*" %>
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
		
		KbmDocBean model = null;
		if (!StringUtil.isBlank(sJson) ) {
			sJson = Escape.unescape(DataControlUtil.replaceStr(sJson));
			model = (KbmDocBean) JSONObject.parseObject(sJson, KbmDocBean.class);
		}

		KbmDocDao dao = (KbmDocDao)LoadSpringContext.getApplicationContext().getBean("kbmDocDaoImpl");
		List<Map<String, String>> list = null;
		PagingBean pb = null;
		pb= dao.queryKbmDocList(model,"k_create_time","desc",0,5000);
		list=(List<Map<String, String>>) pb.getList();
		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			String filename="文档资料目录清单.xls";
			filename = new String(filename.getBytes("GBK"), "ISO8859_1");
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename=\""+ filename + "\"");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("文档资料目录清单", 0);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(4, 1, "文档资料目录清单", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			WritableFont wf1 = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
			WritableCellFormat wcf1 = new WritableCellFormat(wf1);
			Label lab3 = new Label(1, 2, "序号",wcf1);
			Label lab4 = new Label(2, 2, "编号",wcf1);
			Label lab5 = new Label(3, 2, "标题",wcf1);
			Label lab6 = new Label(4, 2, "所属分类",wcf1);
			Label lab7 = new Label(5, 2, "发布单位",wcf1);
			Label lab8 = new Label(6, 2, "密级",wcf1);
			Label lab9 = new Label(7, 2, "发布日期",wcf1);
			Label lab10 = new Label(8, 2, "所属部门",wcf1);
			Label lab11 = new Label(9, 2, "上传人",wcf1);
			Label lab12 = new Label(10, 2, "上传日期",wcf1);
			Label lab13 = new Label(11, 2, "备注",wcf1);
			ws.setColumnView(1, 10);
			ws.setColumnView(2, 20);
			ws.setColumnView(3, 50);
			ws.setColumnView(4, 30);
			ws.setColumnView(5, 20);
			ws.setColumnView(6, 10);
			ws.setColumnView(7, 20);
			ws.setColumnView(8, 20);
			ws.setColumnView(9, 10);
			ws.setColumnView(10, 20);
			ws.setColumnView(11, 50);
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
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21  = new Label(1 , i, String.valueOf(i-2));
				Label lab22  = new Label(2 , i, list.get(i - 3).get("k_code"));
				Label lab23  = new Label(3 , i, list.get(i - 3).get("k_title"));
				Label lab24  = new Label(4 , i, list.get(i - 3).get("k_type_name"));
				Label lab25  = new Label(5 , i, list.get(i - 3).get("k_unit_name"));
				Label lab26  = new Label(6 , i, list.get(i - 3).get("k_secrecy_name"));
				Label lab27  = new Label(7 , i, list.get(i - 3).get("k_create_time"));
				Label lab28  = new Label(8 , i, list.get(i - 3).get("k_dept_name"));
				Label lab29  = new Label(9 , i, list.get(i - 3).get("k_create_user_name"));
				Label lab30  = new Label(10, i, list.get(i - 3).get("k_create_time"));
				Label lab31  = new Label(10, i, list.get(i - 3).get("k_remark"));
				
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

<%--  
描述：会议签到表
作者：黄海
版本：1.0
日期：2013-07-30
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
<%@page import="com.chinacreator.xtbg.core.meeting.service.*" %>
<%@page import="com.chinacreator.xtbg.core.meeting.dao.*" %>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*" %>
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
		String m_notice_id = request.getParameter("m_notice_id");

		PagingBean pb = null;
		Map<String, String> map = new HashMap<String, String>();
		MeetingDao meetingDao = (MeetingDao) LoadSpringContext
				.getApplicationContext().getBean("meetingDaoImpl");
		Connection conn = DbManager.getInstance().getTransactionConnection();
		map = meetingDao.getMeetingNoticeBean(m_notice_id,conn);

		MeetingAttenderDao dao = (MeetingAttenderDao) LoadSpringContext
				.getApplicationContext().getBean(
						"meetingAttenderDaoImpl");
		List<Map<String, String>> list = dao.getMeetingAttenderList(map);

		response.reset();
		ByteArrayInputStream bais = null;
		FileOutputStream fos = null;
		if (list.size() > 0) {
			fos = new FileOutputStream(path + "Excel.xls");
			output = response.getOutputStream();
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename=Excel.xls");

			WritableWorkbook wwk = Workbook.createWorkbook(fos);
			WritableSheet ws = wwk.createSheet("会议签到表", 0);
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 16,
					WritableFont.BOLD);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setAlignment(Alignment.CENTRE);

			ws.mergeCells(0, 4, 0, 0);
			Label lab1 = new Label(1, 0, "", wcf);
			Label lab2 = new Label(4, 1, "会议签到表", wcf);
			ws.addCell(lab1);
			ws.addCell(lab2);
			Label lab3 = new Label(1, 2, "序号");
			Label lab4 = new Label(2, 2, "姓名");
			Label lab5 = new Label(3, 2, "单位");
			Label lab6 = new Label(4, 2, "职务");
			Label lab7 = new Label(5, 2, "联系电话");
			Label lab8 = new Label(6, 2, "签到");
			Label lab9 = new Label(7, 2, "备注");
			ws.addCell(lab3);
			ws.addCell(lab4);
			ws.addCell(lab5);
			ws.addCell(lab6);
			ws.addCell(lab7);
			ws.addCell(lab8);
			ws.addCell(lab9);
			for (int i = 3; i < list.size() + 3; i++) {
				Label lab21 = new Label(1, i, list.get(i - 3).get(
						"id"));
				Label lab22 = new Label(2, i, list.get(i - 3).get(
						"username"));
				Label lab23 = new Label(3, i, list.get(i - 3).get(
						"userunit"));
				Label lab24 = new Label(4, i, list.get(i - 3).get(
						"userposition"));
				Label lab25 = new Label(5, i, list.get(i - 3).get(
						"usertel"));
				ws.addCell(lab21);
				ws.addCell(lab22);
				ws.addCell(lab23);
				ws.addCell(lab24);
				ws.addCell(lab25);
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

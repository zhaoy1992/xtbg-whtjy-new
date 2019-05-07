<%--
描述：系统文件下载页面
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.FilePathUtil"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.Escape"%>
<%@ page language="java" contentType="application/octet-stream; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*"%>
<%
	OutputStream output = null;
	FileInputStream fis = null;
	try {
		String hrefPath = request.getParameter("hrefPath");
		String salarytype = request.getParameter("salarytype");
		FilePathUtil fileUtil = new FilePathUtil();
		fileUtil.initialize(pageContext);
		String dir = fileUtil.getPhysicalPath(hrefPath, 0);
		String zwName = "";
		if("tx".equals(salarytype)){
			zwName = "通讯录导入模板.xls";
		} else {
			zwName = "个人通讯录模板.xls";
		}
		String filelocation = dir + zwName;
		String displayname = zwName;
		displayname = new String(displayname.getBytes("gbk"),
				"ISO8859_1");
		response.reset();

		output = response.getOutputStream();
		File file = new File(filelocation);
		if (file.exists()) {
			response.setContentType("application/octet-stream");
			response.addHeader("Content-disposition",
					"attachment; filename=\"" + displayname + "\"");
			fis = new FileInputStream(file);
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = fis.read(b)) > 0) {
				output.write(b, 0, i);
			}
		}
		output.flush();
		out.clear();
		out = pageContext.pushBody();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>


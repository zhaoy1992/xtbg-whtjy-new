<%--
描述：导出excel模版(通用）
作者：夏天
版本：1.0
日期：2014-03-10
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.FileUtil"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.core.common.util.FilePathUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="application/octet-stream; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*"%>
<%
	OutputStream output = null;
	FileInputStream fis = null;
	try {
		String excelTemplateFilePath = request.getParameter("excelTemplateFilePath");
		String modelPath = request.getParameter("modelPath");
		FilePathUtil fileUtil = new FilePathUtil();
		fileUtil.initialize(pageContext);
		String dir = "";
		if(StringUtil.nullOrBlank(modelPath)){
			dir = FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam(excelTemplateFilePath);
		}else{
			dir = FileUtil.getAppContextPath()+modelPath;
		}
		
		File file = new File(dir);
		String displayname = file.getName();
		displayname = new String(displayname.getBytes("gbk"),
				"ISO8859_1");
		response.reset();

		output = response.getOutputStream();
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


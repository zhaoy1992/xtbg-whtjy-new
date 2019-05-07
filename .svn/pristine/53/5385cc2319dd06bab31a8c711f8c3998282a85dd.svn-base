<%--  
描述：人员信息导出功能
作者：夏天
版本：1.0
日期：2014-03-10
--%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.pub.excel.ifc.BusiExcelToData"%>
<%@page import="com.chinacreator.xtbg.core.directory.data.DirectoryExcelToData"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="application/octet-stream; charset=utf-8"%>


<%!
	public static String toChinese(String strvalue) {
		try {
			if (strvalue == null)
				return null;
			else {
				strvalue = new String(strvalue.getBytes("GBK"), "ISO8859_1");
				return strvalue;
			}
		} catch (Exception e) {
			return null;
		}
	}
	
	%>
<%
	//文件下载数据
	// excel文件名
	String params = request.getParameter("params");
	String excelname = request.getParameter("excelname");
	String excelImplClass = request.getParameter("excelImplClass");
	String excelTemplateFilePath = request.getParameter("excelTemplateFilePath");
	
	Map<String, String> bean = RequestBeanUtils.getValueMapByRequest(request);
	response.reset();

	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	ByteArrayInputStream bais = null;
	FileOutputStream fos = null;
	BusiExcelToData busiExcelToData = (BusiExcelToData) LoadSpringContext
			.getApplicationContext().getBean(excelImplClass);//指定导入导出实现类
	busiExcelToData.setExportTemplateFilePath(FileUtil.getAppContextPath()+ CacheCommonManageProxy.getSystemParam(excelTemplateFilePath));
	File tempExportFile = null;
	try {
		String exportTempFilePath = busiExcelToData.exportExcelToData(bean);
		tempExportFile = new File(exportTempFilePath);
		if (tempExportFile.exists()) {
			output = response.getOutputStream();
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename="+toChinese(excelname+".xls"));

			obis = (InputStream) (new FileInputStream(tempExportFile));

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
		tempExportFile.delete();
	}
%>

<%--  
描述：人员持证-培训信息导出功能
作者：邱炼
版本：1.0
日期：2014-03-12
--%>
<%@page import="com.chinacreator.xtbg.core.personholder.data.PersonTrainExcelToData"%>
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


<%!public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("utf-8");
				} catch (Exception ex) {
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}

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
	String userids = request.getParameter("userids");

	response.reset();

	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	ByteArrayInputStream bais = null;
	FileOutputStream fos = null;
	PersonTrainExcelToData persontrainexceltodata = new PersonTrainExcelToData();
	File tempExportFile = null;
	try {
		String exportTempFilePath = persontrainexceltodata.printExcelToData(userids);
		tempExportFile = new File(exportTempFilePath);
		if (tempExportFile.exists()) {
			
			output = response.getOutputStream();
			response.setContentType("application/octet-stream;charset=gb2312");
			response.addHeader("Content-disposition",
					"attachment; filename="+toChinese("人员持证-培训打印信息.xls"));

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
		persontrainexceltodata.deleteExportTempFile(tempExportFile);
	}
%>

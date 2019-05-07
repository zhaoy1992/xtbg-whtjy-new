<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>
<%@ page import="com.chinacreator.epp.reportmanage.RunReportUtil" %>
<%@ page import="com.chinacreator.epp.reportmanage.service.ReportManage"%>

<%@ page import="org.apache.log4j.Logger" %>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<%
	Logger logger = Logger.getLogger("子资源下载页面");
	//下载报表设计文件
	//获得报表文件的ID

	response.setHeader("Cache-Control", null);
	response.setHeader("Pragma", null);
 	response.setDateHeader("Expires", 0);
	response.setDateHeader("max-age", 0);
	
	String resource_id = request.getParameter("resource_id");
	String resource_suffix= request.getParameter("resource_suffix");
	String resource_type= request.getParameter("resource_type");
	StringBuffer sb= new StringBuffer();
	sb.append(resource_id);sb.append(".");sb.append(resource_suffix);
	
	String filePath = this.getServletContext().getRealPath(ReportUtil.REPORT_FILE_PATH)+"\\";
	
	File resourceFile = new File(filePath+resource_id+"."+resource_suffix);
	ReportUtil util = new ReportUtil();	
	ReportManage rm = ReportBeanFactory.getReportManager();
	byte[] bytes = rm.getSubReportFileBytes(resource_id,resource_type);
	if(!resourceFile.exists())
	{
		RunReportUtil rUtil= new RunReportUtil();
		if(ReportUtil.SUB_JRXML.equals(resource_type)) {
			rUtil.saveByteArrayToFile(bytes,resourceFile);
		}else if(ReportUtil.SUB_IMG.equals(resource_type)) {
			rUtil.saveByteArrayToFile(bytes,resourceFile.getAbsolutePath());
		}
	}
	response.setContentType("application/x-download");
	response.setHeader("Content-Disposition", "attachment;filename=\""+sb.toString()+"\"");
	response.setContentLength(bytes.length);
	OutputStream os = response.getOutputStream(); 
	os.write(bytes);
	os.flush(); 
	os.close(); 
	//request.getRequestDispatcher("/test.jsp").forward(request,response);
%>

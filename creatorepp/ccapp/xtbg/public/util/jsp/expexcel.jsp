<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page language="java"  import="java.util.*,
     org.apache.poi.hssf.usermodel.HSSFWorkbook,
     org.apache.poi.hssf.usermodel.HSSFSheet,org.apache.poi.hssf.usermodel.HSSFRow,
     org.apache.poi.hssf.usermodel.HSSFCell,java.text.DecimalFormat"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.util.Region"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.chinacreator.xtbg.pub.common.ExpExcel"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%
	response.reset();
    String paramHead = request.getParameter("paramHead");
    String sql = request.getParameter("sql");
    HSSFWorkbook wbook = new HSSFWorkbook();
    String title = request.getParameter("title");
    if(paramHead != null) {
    	paramHead = java.net.URLDecoder.decode(paramHead,"UTF-8");
	}
    if(title != null) {
    	title = java.net.URLDecoder.decode(title,"UTF-8");
	}
    if(sql != null) {
    	//中文解码，同时替换解码不了的 ' 和 ','
    	//sql = java.net.URLDecoder.decode(sql , "UTF-8").replace("chr(39)","'").replace("chr(43)","','");
    	sql = StringUtil.replaceAllNew(java.net.URLDecoder.decode(sql , "UTF-8"));
	}
    String columnWidth = request.getParameter("columnWidth");
    ExpExcel service = new ExpExcel();
    service.getExcel(wbook,paramHead,sql,title,columnWidth);  
    response.setContentType("application/msexcel");
    response.setHeader("Content-disposition","attachment;filename="+new String(title.getBytes("GBK"),"iso8859-1")+".xls");//定义文件名
    DecimalFormat f = new DecimalFormat("#,##0.00");
    OutputStream os = response.getOutputStream();
    wbook.write(os);
    os.flush();
	os.close();
	out.clear();
    out = pageContext.pushBody();
%>
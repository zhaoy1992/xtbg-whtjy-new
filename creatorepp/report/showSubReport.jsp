<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*" %>
<%@page import="com.chinacreator.epp.reportmanage.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.cache.*" %>
<%@taglib prefix="c" uri="/WEB-INF/reportconfig/c.tld"%>
<%
	String openUrlKey= (String)request.getParameter("openUrlKey");
	//JasperPrint jasperPrint = (JasperPrint)session.getAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE);
	JasperPrint jasperPrint = (JasperPrint)ReportCacheManager.getInstance().getObject(openUrlKey+"...");
	//jasperPrint.setName("${subreport.resource_name}");
	ReportPageBean rpb= new ReportPageBean();
	pageContext.setAttribute("rpb",rpb);
	String sbuffer= (rpb.pageReport(jasperPrint,request.getParameter("page"))).toString();
	pageContext.setAttribute("sbu",sbuffer);	
	
	String openUrl= (String)ReportCacheManager.getInstance().getObject(openUrlKey);
%>

	<html>
	
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<head>
	  <style type="text/css">
	    a {text-decoration: none}
	  </style>
	  <title>${subreport.resource_name} HTML报表展示</title>
	</head>
	
	
	<body text="#000000" link="#000000" alink="#000000" vlink="#000000" onload="">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	  <td width="20%">&nbsp;</td>
	  <td align="left">
	    <hr size="1" color="#000000">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
	      <tr>
	        <td>
	        </td>
	        <td>
	        	<a href="showJasperReport.jsp?jasperprintkey=<%=openUrlKey%>&reload=true&raq=${subreport.resource_id}"><img src="reportImages/reload.GIF" border="0"></a>
	        </td>
	        <td>
	        	&nbsp;<a href="../jasperreport/xls?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name }"><img src="reportImages/newexcel.gif" border="0" title="导出为excel"></a>
	        </td>
	        <td>
	        	&nbsp;<a href="../jasperreport/pdf?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name }"><img src="reportImages/newpdf.gif" border="0" title="导出为PDF"></a>
	        </td>
	         <td>
	        	&nbsp;<a href="../jasperreport/rtf?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name }"><img src="reportImages/newword.gif" border="0" title="导出为WORD"></a>
	        </td>
	        <td>
	        &nbsp;<a href="#" onclick="openprinter()"><img src="reportImages/newprint.gif" border="0" title="打印"></a>
	        </td>
	        <td>&nbsp;&nbsp;&nbsp;</td>
	        <c:choose>
	        <c:when test="${rpb.pageIndex>0}">
	        	 <td><a href="showJasperReport.jsp?openUrlKey=<%=openUrlKey %>&page=0&raq=${subreport.resource_id }&filename=${subreport.resource_name }"><img src="reportImages/first.GIF" border="0"></a></td>
	        	<td><a href="showJasperReport.jsp?openUrlKey=<%=openUrlKey %>&page=${rpb.pageIndex - 1}&raq=${subreport.resource_id }&filename=${subreport.resource_name }"><img src="reportImages/previous.GIF" border="0"></a></td>
	        </c:when>
	        <c:otherwise>
	        	<td><img src="reportImages/first_grey.GIF" border="0"></td>
	        	<td><img src="reportImages/previous_grey.GIF" border="0"></td>
	        </c:otherwise>
	        </c:choose>
	        <c:choose>
	        <c:when test="${rpb.pageIndex < rpb.lastPageIndex}">
	         	 <td><a href="showJasperReport.jsp?openUrlKey=<%=openUrlKey %>&page=${rpb.pageIndex + 1 }&raq=${subreport.resource_id }&filename=${subreport.resource_name }"><img src="reportImages/next.GIF" border="0"></a></td>
	        	<td><a href="showJasperReport.jsp?openUrlKey=<%=openUrlKey %>&page=${rpb.lastPageIndex }&raq=${subreport.resource_id }&filename=${subreport.resource_name }"><img src="reportImages/last.GIF" border="0"></a></td>
	        </c:when>
	        <c:otherwise>
	        	<td><img src="reportImages/next_grey.GIF" border="0"></td>
	       		 <td><img src="reportImages/last_grey.GIF" border="0"></td>
	        </c:otherwise>
			</c:choose>
	        <td width="100%">&nbsp;</td>
	        <td width="100%"></td>
	      </tr>

	    </table>
	    <hr size="1" color="#000000">
	  </td>
	  <td width="20%">&nbsp;</td>
	</tr>
	<tr>
	  <td width="20%">&nbsp;</td>
	  <td align="center">
		${sbu}
	  </td>
	  <td width="20%">&nbsp;</td>
	</tr>
	</table>
	
	</body>
	<script type="text/javascript">
	function openprinter(){
		window.open("<%=openUrl%>");
	}
	</script>
	</html>
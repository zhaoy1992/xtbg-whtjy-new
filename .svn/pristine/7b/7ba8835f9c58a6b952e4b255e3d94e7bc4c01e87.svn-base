<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page errorPage="error.jsp" %>
<%@ page import="com.chinacreator.epp.reportmanage.cache.*" %>
<%@ page import="java.util.*" %>
<%
	String openUrlKey= (String)request.getParameter("openUrlKey");
	
	String openUrl= (String)ReportCacheManager.getInstance().getObject(openUrlKey);
 %>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<head>
	  <style type="text/css">
	    a {text-decoration: none}
	  </style>
	  <title>${subreport.resource_name} FLASH报表展示</title>
	</head>
	<body text="#000000" link="#000000" alink="#000000" vlink="#000000" background="red">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	  <td align="right">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
	      <tr>
	        <td>
	     
	        </td>

	        <td>
	        	<a href="../jasperreport/xls?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name}"><img src="reportImages/newexcel.gif" border="0" title="导出为excel"></a>
	        </td>
	         <td>
	        	&nbsp;<a href="../jasperreport/rtf?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name}"><img src="reportImages/newword.gif" border="0" title="导出为word"></a>
	        </td>
	        <td>
	        	&nbsp;<a href="../jasperreport/pdf?jasperprintkey=<%=openUrlKey%>&filename=${subreport.resource_name}"><img src="reportImages/newpdf.gif" border="0" title="导出为PDF"></a>
	        </td>
	        <td>
	        	
	         &nbsp;<a href="#" onclick="openprinter()"><img src="reportImages/newprint.gif" border="0" title="打印"></a>
	        </td>
	        <td>&nbsp;&nbsp;&nbsp;</td>

	        <td width="100%"><br><br></td>
	      </tr>
	    </table>

	  </td>

	</tr>

	</table>
	<div align="center">
	<object width="100%" height="95%">
	  <param name="movie" value="jasperreports-flash-3.0.0.swf"/>
	  <embed src="jasperreports-flash-3.0.0.swf"
	    FlashVars="jrpxml=../jasperreport/xml?jasperprintkey=<%=openUrlKey %>&randtimes=<%=new Date().getTime() %>"
	    width="100%" height="95%">
	  </embed>
	</object>
	</div>
	
	</body>
	<script type="text/javascript">
	function openprinter(){
		window.open("<%=openUrl%>");
	}
	</script>
	</html>
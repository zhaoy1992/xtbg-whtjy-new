<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.DefaulXmlBuilder"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.CurrentDataSourceType"%>
<%
String path = request.getContextPath();
String fullname = request.getParameter("idname");

DefaulXmlBuilder builder = new DefaulXmlBuilder(CurrentDataSourceType.getType());
String type = fullname.indexOf("_")==-1?fullname:FusionUtil.getChartType(fullname);
builder.setFullname(fullname);
builder.setType(type);
String xml = builder.preview();

xml = xml==null?"":xml.replaceAll("\n","");

pageContext.setAttribute("path",path);
pageContext.setAttribute("type",type);
pageContext.setAttribute("xml",xml);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Êý¾ÝÔ¤ÀÀ <%=fullname %></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link rel="stylesheet" href="${path}/FusionCharts/Contents/Style.css" type="text/css" />
		<script language="JavaScript" src="${path}/FusionCharts/JSClass/FusionCharts.js"></script>
		<script language="JavaScript" src="${path}/FusionCharts/JSClass/FusionChartsExportComponent.js"></script>
	</head>

	<body bgcolor="#ffffff">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td valign="top" class="text" align="center">
					<div id="chartdiv" align="center">
						FusionCharts.
					</div>
					<script type="text/javascript">
		  			    var chart = new FusionCharts('${path}/FusionCharts/Charts/${type}.swf', 'ChartId', '600', '350', '0', '0');
		   				chart.setDataXML("${xml}");		   
		   				chart.render("chartdiv");
					</script>
				</td>
			</tr>
		</table>
		
		<table border="0" cellspacing="0" align="center"> <tr><td><input type="button" value="----¹Ø±Õ----" onclick="javascript:window.close();"/></td></tr>  </table>
	</body>
</html>
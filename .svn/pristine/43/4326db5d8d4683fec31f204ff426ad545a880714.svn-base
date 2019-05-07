<%@ page language="java" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.XmlDatasourceRunningChart"%>
<%@page import="com.chinacreator.fusionchart.web.FusionDispacher"%>
<%@page import="com.chinacreator.fusionchart.FusionChartXMLBuilder"%>
<%@page import="com.chinacreator.fusionchart.model.XmlModel"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.File"%>
<%
try{
String path = request.getContextPath(); 

String fusionid = FusionUtil.getParameterString(request,"fusionid");
String dataurl = FusionUtil.getParameterString(request,"dataurl");

FusionDispacher fdispacher = new FusionDispacher();
fdispacher.initFusionContext(request, response, this.getServletContext());

String xmlContent = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><fieldData><field en_name=\"aa\" ch_name=\"地区\"><value>北京</value><value>上海</value><value>广州</value><value>深圳</value><value>长沙</value><value>重庆</value></field><field en_name=\"bb\" ch_name=\"本月值\"><value>1000.2</value><value>2132.3</value><value>2123.2</value><value>1242.4</value><value>1244.2</value><value>2514.3</value></field><field en_name=\"cc\" ch_name=\"上月值\"><value>1222.2</value><value>2172.3</value><value>2123.2</value><value>1242.4</value><value>1444.2</value><value>2114.3</value></field><field en_name=\"dd\" ch_name=\"比上月增减\"><value>23</value><value>32</value><value>12</value><value>23</value><value>43</value><value>12</value></field></fieldData>";
XmlDatasourceRunningChart datasource = new XmlDatasourceRunningChart(fusionid,new XmlModel(new File("D:\\workspace\\app3\\src\\testdata.txt")));
String xml = datasource.getFusionXml();
fdispacher.removeContext();
System.out.println(xml);
xml = xml.replaceAll("\n","");
String type = datasource.getType();

pageContext.setAttribute("path",path);
pageContext.setAttribute("type",type);
pageContext.setAttribute("xml",xml);
pageContext.setAttribute("chart_width","500");
pageContext.setAttribute("chart_height","230");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link rel="stylesheet" href="${path}/FusionCharts/Contents/Style.css" type="text/css" />
		<script language="JavaScript" src="${path}/FusionCharts/JSClass/FusionCharts.js"></script>
		<script language="JavaScript" src="${path}/FusionCharts/JSClass/FusionChartsExportComponent.js"></script>
	</head>

	<body>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td valign="top" class="text" align="center">
					<div id="chartdiv" align="center">
						FusionCharts.
					</div>
					<script type="text/javascript">
		  			 var chart = new FusionCharts('${path}/FusionCharts/Charts/${type}.swf', 'ChartId', '${chart_width}', '${chart_height}', '0', '0');
		   				chart.setDataXML("${xml}");		   
		   				chart.render("chartdiv");
					</script>
				</td>
			</tr>
		</table>
	</body>
</html>
<%
}catch(Throwable t){
	t.printStackTrace();
	t.getMessage();
}
%>

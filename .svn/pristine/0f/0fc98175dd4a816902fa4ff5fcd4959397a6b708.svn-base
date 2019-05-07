<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.PreviewChart"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="org.apache.commons.lang.math.NumberUtils"%>
<%
	String path = request.getContextPath();
	pageContext.setAttribute("path",path);
	String chart_width = request.getParameter("chart_width");
	String chart_height = request.getParameter("chart_height");
	if(!NumberUtils.isNumber(chart_width)){
		chart_width = "500";
	}
	
	if(!NumberUtils.isNumber(chart_height)){
		chart_height = "230";
	}
	pageContext.setAttribute("chart_width",chart_width);
	pageContext.setAttribute("chart_height",chart_height);
	
	String chart_action = request.getParameter("chart_action");
	if(FusionStaticField.ACTION_SAVE_MODEL.equals(chart_action)){
		//±£´æ²Ù×÷
		if("1".equals(request.getParameter("isfirstload"))){
			if(session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"))==null){
				out.print("");
				return;
			}
		}
		
		getServletContext().getRequestDispatcher("/fusionchar").forward(request,response);
		return;
		
	}

	PreviewChart p = new PreviewChart(request, response);
	String xml = p.getFusionXml();
	
	System.out.println(xml);
	xml = xml.replaceAll("\n","");
	String type = p.getType();
	pageContext.setAttribute("type",type);
	pageContext.setAttribute("xml",xml);
	
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
		<script type="text/javascript">
		function myf(){
			alert(123);
		}
		</script>
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

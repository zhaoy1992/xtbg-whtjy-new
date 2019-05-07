<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String fusionid = FusionUtil.getParameterString(request,"fusionid");
String dataurl = FusionUtil.getParameterString(request,"dataurl");

String runUrl = basePath + "FusionCharts/xmlrunning.jsp?fusionid="+fusionid+"&dataurl="+dataurl;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>success</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
  <body>
    <br>
    <br>
    <h3>
    配置成功你可以点击以下链接运行  <br>    
    </h3>
    
    <a href="<%=runUrl %>"><%=runUrl %></a>
  </body>
</html>

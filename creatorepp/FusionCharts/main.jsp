<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.CurrentDataSourceType"%>
<%@page import="com.chinacreator.fusionchart.DataSourceType"%>
<%

//main 函数为切入页面，也可称之为接口界面，在这个更页面需要对datatype 进行初始化
String datasourcetype = FusionUtil.getParameterString(request,"datasourcetype");
String dataurl = FusionUtil.getParameterString(request,"dataurl");

//dataurl="http://172.16.17.23:8080/app/FusionCharts/test_data.xml";
//datasourcetype = "xml";
String fusionidname = FusionUtil.getParameterString(request,"fusionidname");
String fusionid = request.getParameter("fusionid");	
String fusiontype= FusionUtil.getParameterString(request,"fusiontype");
if(StringUtils.isBlank(datasourcetype)){
	CurrentDataSourceType.setType(DataSourceType.EFORM);
}else if("eform".equalsIgnoreCase(datasourcetype)){
	CurrentDataSourceType.setType(DataSourceType.EFORM);
}else if("xml".equalsIgnoreCase(datasourcetype)){
	CurrentDataSourceType.setType(DataSourceType.XML);
	if(!StringUtils.isBlank(fusionidname)){
		fusiontype = FusionUtil.getChartType(fusionidname);
		fusionid = FusionUtil.getChartId(fusionidname);
	}
}

String divw = request.getParameter("divw");
String divh = request.getParameter("divh");
String divtop = request.getParameter("divtop");
String divleft = request.getParameter("divleft");
String flocation = request.getParameter("flocation");



String modelCode = FusionUtil.getChartType(fusiontype);
String modelType = FusionUtil.getTemplateChartType(fusiontype);

pageContext.setAttribute("datasourcetype",datasourcetype);
pageContext.setAttribute("dataurl",dataurl);

pageContext.setAttribute("modelcode",modelCode);
pageContext.setAttribute("modeltype",modelType);
pageContext.setAttribute("fusiontype",fusiontype);
pageContext.setAttribute("fusionid",fusionid);

pageContext.setAttribute("divw",divw);
pageContext.setAttribute("divh",divh);
pageContext.setAttribute("divtop",divtop);
pageContext.setAttribute("divleft",divleft);
pageContext.setAttribute("flocation",flocation);
%>
<html>
  <head>

    
    <title>图形属性配置(${fusionid})</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
  </head>
  
  <body>
  <iframe name="mainiframe" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes" src="editorproperties.jsp?fusionid=${fusionid}&fusiontype=${fusiontype}&modelcode=${modelcode}&modeltype=${modeltype}&divw=${divw}&divh=${divh}&divtop=${divtop}&divleft=${divleft}&flocation=${flocation}&datasourcetype=${datasourcetype}&dataurl=${dataurl}">
  </iframe>
  </body>
</html>

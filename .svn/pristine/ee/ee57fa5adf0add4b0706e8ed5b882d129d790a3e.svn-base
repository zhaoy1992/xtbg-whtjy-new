<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>
<%
String businesscode = request.getParameter("businesscode");

if("testmethod".equals(businesscode)){
//javabean 数据源测试方法

String classname = request.getParameter("classname");
String methodname = request.getParameter("methodname");

	if(StringUtils.isBlank(classname) || StringUtils.isBlank(methodname)){
		out.print("类或者方法名不能为空");
		return;
	}
	
	try{
	ReportUtil.invokeJavaBeanMethod(classname,methodname,null);
	out.print("success");
	}catch(Exception e){
	e.printStackTrace();
	out.print("测试失败:"+e.getMessage());
	}
	return;
}
%>

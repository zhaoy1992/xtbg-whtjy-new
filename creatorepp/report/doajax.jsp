<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>
<%
String businesscode = request.getParameter("businesscode");

if("testmethod".equals(businesscode)){
//javabean ����Դ���Է���

String classname = request.getParameter("classname");
String methodname = request.getParameter("methodname");

	if(StringUtils.isBlank(classname) || StringUtils.isBlank(methodname)){
		out.print("����߷���������Ϊ��");
		return;
	}
	
	try{
	ReportUtil.invokeJavaBeanMethod(classname,methodname,null);
	out.print("success");
	}catch(Exception e){
	e.printStackTrace();
	out.print("����ʧ��:"+e.getMessage());
	}
	return;
}
%>

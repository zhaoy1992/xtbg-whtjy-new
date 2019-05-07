<%--
　　描述：表单元素界面
　　作者：肖杰
　　版本：1.0
　　日期：2013-7-31
--%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.ColStautsContorlServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.ColStautsContorlServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	boolean flag = true;
	ColStautsContorlServiceIfc cscsi=new ColStautsContorlServiceImpl();
	try{
		cscsi.saveColStatusForm(jsonparam);
	}catch(Exception e){
		flag = false;
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("data",flag);
	out.print(jsonObj);
%>

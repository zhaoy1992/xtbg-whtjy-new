<%--
　　描述：保存新增/修改 表字段的表单
　　作者：黄海
　　版本：1.0
　　日期：2013-06-07
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	String updatetype = request.getParameter("updatetype");
	String flag1 = "";
	boolean flag=false;
	JSONObject json = new JSONObject();
	MdServiceIfc service = new MdServiceImpl();
	flag1 = service.saveMdColumnsForm(jsonparam,updatetype);
	if("true".equals(flag1)){
		flag=true;
	}
	json.put("flag",flag);
	json.put("info",flag1);
	out.print(json);
%>

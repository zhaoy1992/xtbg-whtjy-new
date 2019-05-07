<%--  
描述：将公共通讯录的人员信息绑定到个人通讯录
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String userid = request.getParameter("userid");
	String directoryids = request.getParameter("directoryids");
	
	//将公共通讯人员绑定到个人通讯录
	PersonInfoServiceIfc service = new PersonInfoServiceImpl();
	boolean flag = service.setPersonalDirectoryRelationship(userid,directoryids);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("ok","ok");
	if(flag){
		jsonObj.put("flag",true);
		jsonObj.put("msg","操作成功");
	}else{
		jsonObj.put("flag",false);
        jsonObj.put("msg","操作失败");
	}
	out.print(jsonObj);

%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WorkCountService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WorkCountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
	
	String action = request.getParameter("action");
	WorkCountService workcountservice = new WorkCountServiceImpl();
	if("sendToFileByIns".equals(action)){
		String ids = request.getParameter("ids");
		boolean falg = workcountservice.sendToFileByInsId(userid,ids);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("flag",falg);
		out.print(jsonObj);
	}
	
%>


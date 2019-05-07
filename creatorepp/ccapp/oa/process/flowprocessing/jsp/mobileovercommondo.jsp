<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.ArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.OvercommonServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.CircularizeDao"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.impl.CircularizeDaoImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>

<%
	//String path = request.getContextPath();
	//AccessControl control = AccessControl.getInstance();
	//control.checkAccess(request, response);
	
	String circularize_id = request.getParameter("circularize_id");
	
	Map<String,Object> returnMap  = new HashMap<String,Object>();
	
	ArchiveService oFlowServlet = new OvercommonServiceImpl();
	CircularizeDao dao = new CircularizeDaoImpl();
	dao.updateDone(circularize_id);
	returnMap  = oFlowServlet.handler(request, response);
	
	ResultMap<AResultCode,Object> result = new ResultMap<AResultCode,Object>();
	result.setCode(AResultCode.OK);
	result.setResult("");
	out.write(JSON.toJSONString(result,true));
	
%>

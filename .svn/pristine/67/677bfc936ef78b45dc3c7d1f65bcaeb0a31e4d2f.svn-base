<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.ResManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>

<%
ResManager resMan = new ResManagerImpl();
String type = (String)request.getParameter("type");
	 resMan.delRedundance(type);
	 System.out.println("É¾³ýÈßÓà³É¹¦£¡");
%>

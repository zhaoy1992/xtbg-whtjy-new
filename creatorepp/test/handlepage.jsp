<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.frameworkset.event.Event"%>
<%@page import="org.frameworkset.event.EventTarget"%>
<%@page import="org.frameworkset.event.EventImpl"%>
<%@page import="com.chinacreator.iWebOffice2006.WebOfficeEventType"%>
<%@page import="org.frameworkset.event.EventHandle"%>
<%@page import="com.chinacreator.iWebOffice2006.AttachEventType"%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String appId = request.getParameter("appId");
	String dbName = request.getParameter("dbName");
	String eventType = request.getParameter("eventType");
	String recordId = request.getParameter("recordId");
	

	
	String indexProtocol=ConfigManager.getInstance().getConfigValue("index.event.protocol");
	String indexServer = ConfigManager.getInstance().getConfigValue("index.event.server");
	int indexPort=ConfigManager.getInstance().getConfigIntValue("index.event.port");
	System.out.println(appId);
	System.out.println(dbName);
	System.out.println(eventType);
	System.out.println(appId);
	
	System.out.println(indexProtocol);
	System.out.println(indexServer);
	System.out.println(indexPort);
	Map<String, String> map = new HashMap<String, String>();
	map.put("appId", appId);
	map.put("attachId", recordId);
	map.put("dbName", dbName);
	
	EventTarget eventTarget = new EventTarget(indexProtocol, indexServer,
			indexPort);
	Event event = null;
	if (eventType.equals("")) {
	 event = new EventImpl(map, WebOfficeEventType.CREATEALL_EVENT,eventTarget, Event.REMOTE);
	} else {
	 event = new EventImpl(map, AttachEventType.CREATAALL_TYPE,eventTarget, Event.REMOTE);
	}
		EventHandle.getInstance().change(event, false);
%>
<html>
	<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>

	</body>
</html>

<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<% 
AccessControl accesscontroler = AccessControl.getInstance();
String chlikurl = request.getParameter("chlikurl");
String submittedinfoId = request.getParameter("submittedinfoId");
String state = request.getParameter("state");
String windowId=request.getParameter("windowId");
String url = chlikurl + "?submittedinfoId=" + submittedinfoId + "&state=" + state+"&windowId="+windowId;
response.sendRedirect(url);
%>


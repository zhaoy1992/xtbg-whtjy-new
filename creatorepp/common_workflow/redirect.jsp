<%@ page contentType="text/html; charset=gb2312" language="java"  errorPage="" %>
<%@ page import="com.frameworkset.util.StringUtil" %>
<html>
<head>
<title>�ޱ����ĵ�</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
  <%
  
  String url = StringUtil.replaceNull((String)request.getAttribute("url"));
  String isError = StringUtil.replaceNull((String) request.getAttribute("isError"));
  String message = StringUtil.replaceNull((String) request.getAttribute("message"));
  if(isError == null)
  {
  	isError = "";
  }
  if(message.equals("")){
	  message = "�����ɹ���";
  }
  url = request.getContextPath()+url;
  System.out.println(url);
  
  out.println("<script language=\"javascript\">alert(\""+message+"\");location.href=\""+url+"\";</script>");
  %>
</body>
</html>

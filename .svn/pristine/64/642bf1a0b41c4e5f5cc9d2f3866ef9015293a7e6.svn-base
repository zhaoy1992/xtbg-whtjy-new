<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.*"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String docid = request.getParameter("docid");
	
%>
<html>
<head>
<title>.::::::::::文档版本管理::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::..</title>
</head>
<!--<body>-->
<frameset rows="20%,*" border=0>
<frame src="query_doc_version.jsp?docid=<%=docid%>"  border=1 scrolling="no" id="docVerQueryFrame" name="docVerQueryFrame" ></frame>
<frame src="manage_doc_version.jsp?docid=<%=docid%>"  border=0 scrolling="no" id="docVerListFrame" name="docVerListFrame" ></frame>
</frameset>
<!--</body>-->
</html>
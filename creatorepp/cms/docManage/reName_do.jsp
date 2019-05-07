<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.templatemanager.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body>
<% 
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String pathContext = (String)session.getAttribute("pathContext");
	String uri = request.getParameter("uri");
	String fileName = request.getParameter("fileName");
	String oldFileName = request.getParameter("oldFileName");
	File old_file = new File(pathContext+"/"+uri+"/"+oldFileName);
	File new_file = new File(pathContext+"/"+uri+"/"+fileName);
	old_file.renameTo(new_file);
}catch(Exception e){
%>
	<script type="text/javascript">
		alert("给文件(文件夹)改名时发生异常,<%=e.getMessage()%>");
	</script>	
<%	e.printStackTrace();
	return;
}

%>
<script type="text/javascript">
	alert("给文件(文件夹)改名成功!");
	parent.window.dialogArguments.document.forms[0].submit();
    parent.window.close();
</script>
</body>
</html>
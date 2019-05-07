<%@ page language="java" pageEncoding="GBK" import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta content="text/html; charset=gb2312" http-equiv=Content-Type>
<link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
<script src="xtree/dtree.js" type=text/javascript></SCRIPT>
<title>资源管理树</title>
<meta content="MSHTML 5.00.2920.0" name=GENERATOR></head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
<div class=dtree><br>
<script type=text/javascript>
<!--
d = new dTree('d');
d.add(0,-1,'站内邮件');
d.add(1,0,'收件箱','showMessage.jsp?box=receive_box','','showMessage');
d.add(2,0,'已发送邮件箱','showMessage.jsp?box=send_box','','showMessage');
d.add(3,0,'草稿箱','showMessage.jsp?box=nosend_box','','showMessage');
d.add(4,0,'已删除邮件箱','showMessage.jsp?box=receive_deleted_box','','showMessage');
document.write(d);
/*
结构:(id, pid, name, url, title, target, icon, iconOpen, open)
*/
//-->
</SCRIPT>
<br></div>
</body>
</html>
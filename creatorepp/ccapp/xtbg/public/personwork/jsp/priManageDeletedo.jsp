
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.PriManageServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.PriManageServiceImpl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String flowids = request.getParameter("flowids");
	PriManageServiceIfc priManageService=new PriManageServiceImpl();
	boolean flag=priManageService.priManageDelete(flowids);
%>
	<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "�����ɹ�"; 
	bool = false;
	parent.refreshGrid4FlowInfo ();
}else{
	mes = "����ʧ��"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</head>
<body>
</body> 
</html>
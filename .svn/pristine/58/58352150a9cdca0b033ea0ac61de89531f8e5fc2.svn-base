
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.PGroupServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.PGroupServiceImpl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>JGRID</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	PGroupServiceIfc pg=new PGroupServiceImpl();
	boolean isexsitGroup = pg.queryExist(paramjosn);
	boolean flag = false;
	if(isexsitGroup){
		flag=pg.pGroupAdd(paramjosn);
	}
%>
	<!-- 引入jQuery -->
	<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<link href="../../../resources/plug/ifrom/css/ifrom-ui-core.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/layer.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/style.css" rel="stylesheet" type="text/css" />	

<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=!isexsitGroup%>){
	mes = "已经存在分组！";
	bool = false;
}else if(<%=flag%>){
	mes = "操作成功"; 
	bool = false;
	parent.location.href = parent.location.href;
	//parent.parent.refreshGrid4FlowInfo ();
	//window.parent.parent.JqueryDialog.Close();
}else{
	mes = "操作失败"	;
	bool = false;
}
alert(mes);
//window.parent.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</head>
<body>
</body> 
</html>
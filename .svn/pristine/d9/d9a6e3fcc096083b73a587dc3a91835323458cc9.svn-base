<%--  
描述：添加分组信息
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.PGroupServiceImpl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%@page import="com.chinacreator.xtbg.core.personwork.entity.PGroupBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%><html>
<head>
<title>JGRID</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	PGroupBean pGroupBean = new PGroupBean();
	pGroupBean = (PGroupBean)RequestBeanUtils.getValuesByRequest(request,pGroupBean);
	PGroupServiceIfc pg=new PGroupServiceImpl();
	boolean isexsitGroup = pg.queryExist(pGroupBean);  
	boolean flag = false;
	if(isexsitGroup){
		flag=pg.pGroupAdd(pGroupBean);
	}
%>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
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
}else{
	mes = "操作失败"	;
	bool = false;
}
alert(mes);
</script>
</head>
<body>
</body> 
</html>
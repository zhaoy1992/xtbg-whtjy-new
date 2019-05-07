<%--
　　描述：删除表
　　作者：黄海
　　版本：1.0
　　日期：2013-6-6
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%><html>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl" %>
<%@page import="java.sql.Connection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>删除表</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag =false;
	String table_id = request.getParameter("md_table_id");
	String table_code = request.getParameter("table_code");
	MdServiceIfc service = new MdServiceImpl();
	System.out.println(table_id+table_code);
	flag=service.deleteMdTables(table_id,table_code);
%>
</head>
<body>
<script type="text/javascript">
	var mes = "";
	if(<%=flag%>){
		mes = "操作成功!";
		window.parent.openAfterTableUpdated();//把右边的列表要初始化一次
		window.parent.location.reload();
	}else{
		window.parent.location.reload();
		mes = "操作失败.";
	}
	alert(mes);
</script>
</body>
</html>
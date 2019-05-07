<%--
描述：外部子系统使用情况主页面
作者：夏天
版本：1.0
日期：2013-4-28
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemManageDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String orgid="";
	String orgname="";
	String creatorid=accesscontroler.getUserID();
	String creator=accesscontroler.getUserName();
	String username="";
	String paramjosns = "";

	String sys_id = request.getParameter("sys_id");//外部子系统管理主键id
	String status=request.getParameter("status");//获得该子系统所属的状态
	String listtype = request.getParameter("listtype");//列表类别
	String currentDateTime1 = new Date().getTime()+"";

	String subid=request.getParameter("subid");
	
	SubSystemManageDao subSystemManageDao = (SubSystemManageDao)LoadSpringContext.getApplicationContext().getBean("subSystemManageDaoImpl");
	Map<String,String> viewMap = subSystemManageDao.findSubSystemInfo(sys_id);
	
%>
<title>JGRID</title>
<link rel="stylesheet" href="../resources/css/sub_sys.css" type="text/css"/>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-remote.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/sub_system_useinfo.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var sys_id = "<%=sys_id%>";
var listtype = "<%=listtype%>";



</script>
</head>
<input type="hidden" class="initload" submitKey="select" actionId="subSystemManageDaoImpl" methodName="findSubSystemList" successful="initsucessful"/>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',85)">
	<div id="sub_sys_main" class="sub_sys_main"></div>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>

</html>
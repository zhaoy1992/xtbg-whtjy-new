<%--
�������ⲿ��ϵͳ��¼��ҳ��
���ߣ�����
�汾��1.0
���ڣ�2013-4-28
--%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.chinacreator.xtbg.pub.subSystemManage.dao.SubSystemManageDao"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String orgid="";
	String orgname="";
	String userId=accesscontroler.getUserID();
	String creator=accesscontroler.getUserName();
	String username="";
	String paramjosns = "";

	String sys_id = request.getParameter("sys_id");//�ⲿ��ϵͳ��������id
	String status=request.getParameter("status");//��ø���ϵͳ������״̬
	String listtype = request.getParameter("listtype");//�б����
	String currentDateTime1 = new Date().getTime()+"";

	String subid=request.getParameter("subid");
	
	SubSystemManageDao subSystemManageDao = (SubSystemManageDao)DaoImplClassUtil.getDaoImplClass("subSystemManageDao");
	Map<String,String> viewMap = subSystemManageDao.findSubSystemInfo(sys_id);
	
%>
<title>JGRID</title>
<link rel="stylesheet" href="../resources/css/sub_sys.css" type="text/css"/>

<!-- ����jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- ����jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- �������� -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-remote.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/sub_system_login.js" charset="utf-8"></script>
<!-- �����������ý��� -->
<script type="text/javascript">
var sys_id = "<%=sys_id%>";
var listtype = "<%=listtype%>";



</script>
</head>
<input type="hidden" class="initload" submitKey="select" actionId="subSystemManage" methodName="findSubSystemListByUserId" successful="initsucessful"/>
<body style="overflow-y:hidden;" >
	<div id="sub_sys_show_main" class="sub_sys_show_main"></div>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>

</html>
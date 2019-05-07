<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ taglib   uri="../../../WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib   uri="../../../WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<html>
<head><title></title>
<LINK href="../../../css.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
.STYLE2  {	color: #263F77;
	font-weight: bold;
}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response); //ҳ���¼����
	String curOrgId = accessControl.getChargeOrgId();
	String curUserId = accessControl.getUserID(); 
%>
<% 
		RoleType rt = new RoleType();
		rt.setTypeName(request.getParameter("roletype"));
		rt.setTypeDesc(request.getParameter("typedesc"));
		rt.setCreatorUserId(curUserId);
		rt.setCreatorOrgId(curOrgId);
		RoleTypeManager rtm = new RoleTypeManager();
		boolean flag = rtm.isRoleTypeExist(rt);
		System.out.println(flag);
		if(!flag)
		{
		if(rtm.addRoleType(rt))
		{
%>
		<script language="javascript">
		window.alert("������ɫ���ͳɹ�!");
		window.dialogArguments.location="roletype_list.jsp";
		window.close();  
		</script>
<%
		}
		}
		else
		{
%>
<script language="javascript">
		window.alert("������ɫ�Ѿ�����!");  
		</script>
		<%
		}
		%>
</body>
</html>

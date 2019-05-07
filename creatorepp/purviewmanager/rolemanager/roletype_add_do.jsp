<%
/**
 * <p>Title: 新增角色类型处理页面</p>
 * <p>Description: 新增角色类型处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib   uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib   uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>

<% 
	AccessControl accessControl =AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String curUserId = accessControl.getUserID();
	String curOrgId = accessControl.getChargeOrgId();
%>
<html>
<head><title></title>
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
		RoleType rt = new RoleType();
		rt.setTypeName(request.getParameter("roletype").trim());
		rt.setTypeDesc(request.getParameter("typedesc"));
		rt.setCreatorOrgId(curOrgId);
		rt.setCreatorUserId(curUserId);
		RoleTypeManager rtm = new RoleTypeManager();
		boolean flag = rtm.isRoleTypeExist(rt);
		//System.out.println(flag);
		if(!flag)
		{
		if(rtm.addRoleType(rt))
		{
%>
		<script language="javascript">
		window.alert("操作成功!");
		</script>
<%
		}
		}
		else
		{
%>
<script language="javascript">
		window.alert("角色类型名称已经存在!");  
		</script>
		<%
		}
		%>
</body>
</html>
<script>
    window.onload = function prompt()
    {   
        parent.document.all.Submit4.disabled=false;
	    parent.document.all.btn_close.disabled=false;
        parent.divProcessing.style.display="none";
    }
</script>

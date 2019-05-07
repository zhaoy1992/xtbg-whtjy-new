<%
/**
 * <p>Title: 角色删除页面</p>
 * <p>Description: 角色删除</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<html>
<head>
<title>角色删除</title>

<style type="text/css">
<!--
.STYLE2 {	color: #263F77;
	font-weight: bold;
}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%			
			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response); //页面登录保护

			boolean tag = true;
			String notice = "";

			//删除操作
			RoleTypeManager rtm = new RoleTypeManager();
			String id = request.getParameter("role_id");			
			
			if ((id != null) && (id.length() > 0)) {
				String[] ids = id.split(";");
					
				RoleManager roleManager = SecurityDatabase.getRoleManager();
				
				//--角色管理写操作日志	
				String operSource=accessControl.getMachinedID();
    			String openModle="角色管理";
				String operContent="删除角色,角色id： " + id; 						
				String description="";
				LogManager logManager = SecurityDatabase.getLogManager(); 
				logManager.log(accessControl.getUserAccount(),operContent,openModle,operSource,description);       
				//--
					
				tag = roleManager.deleteRoles(ids);
				if(tag)
				{
					notice = "删除成功！";
				}
				else
				{
					notice= "删除失败！";
				}
			}

		%>
</body>
</html>
<script language="javascript">
	window.alert("<%=notice%>");
    window.onload = function prompt()
    {        	
        //parent.divProcessing.style.display="none";
        //parent.location.reload();
        document.location.assign("role.jsp");
    }
</script>

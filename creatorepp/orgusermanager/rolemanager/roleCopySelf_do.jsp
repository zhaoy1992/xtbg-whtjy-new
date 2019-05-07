<%
/*
 * <p>Title: 将其它角色复制给该角色处理页面</p>
 * <p>Description: 将其它角色复制给该角色处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.LogManager"%>


<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="角色管理";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager(); 		
	//---------------END
    
	String rolecopyId = request.getParameter("rolecopyId");
	String checks = request.getParameter("checks");
	String roleName = request.getParameter("roleName");
	String[] id = checks.split(",");
	request.setAttribute("roleId", rolecopyId);
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	boolean state = roleManager.copyResOfRoleSelf(rolecopyId,id);
	
	//--角色管理写操作日志	
	operContent="复制角色: "+	roleName;			
	description="";
	
	logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
%>

<script language="javascript">
	<%
		if(state)
		{
	%>
			alert("复制权限成功！");
			parent.window.location.reload();
	<%
		}
		else
		{
	%>
		alert("复制权限失败！");
    <%
    	}
    %>
    	parent.document.getElementById("copy").disabled = false ;
    	parent.document.getElementById("back").disabled = false ;
	    parent.document.all.divProcessing.style.display = "none";
</script>
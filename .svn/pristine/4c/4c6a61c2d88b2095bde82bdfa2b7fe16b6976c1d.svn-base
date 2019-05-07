<%--
描述：新增角色处理页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	boolean sucess = false;
	try {
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String rolename = StringUtil.deNull(request.getParameter("role_name"));
		String roledesc = StringUtil.deNull(request.getParameter("role_desc"));
		String roletype = StringUtil.deNull(request.getParameter("role_type"));
		
		RoleManager roleManager = SecurityDatabase.getRoleManager();
		Role role = new Role();
		role.setRoleDesc(roledesc);
		role.setRoleName(rolename);
		role.setOwner_id(Integer.parseInt(control.getUserID()));
		role.setRoleType(roletype);
		roleManager.insertRole(role);
		
		//增加日志 2009.7.22
		String operContent = "";
		String operSource = control.getMachinedID();
		String openModle = "角色管理";
		String userName = control.getUserName();
		String description = "";
		LogManager logManager = SecurityDatabase.getLogManager();
		operContent = userName + " 新增了角色 " + role.getRoleName();
		description = "";
		logManager.log(control.getUserAccount(),operContent, openModle, operSource, description);
		
		sucess = true;
	} catch (Exception e) {
		sucess = false;
		e.printStackTrace();
	}
%>
<script type="text/javascript">
	var mes;	
	var bool = true;
	if(<%=sucess %>){
		mes = "新增角色成功！";
	}else{
		bool = false;
		mes = "新增角色失败！";
	}
	
	var ok=function(){
		window.parent.location.reload();
	}
	if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("windowsId"))%>',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok});
		}else{
			window.top.alert(mes);
		}
	}
</script>
<%--
描述：角色修改处理页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	boolean sucess = false;
	try{
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String role_id = request.getParameter("role_id");
		String role_name = request.getParameter("role_name");
		String role_type = request.getParameter("role_type");
		String role_desc = request.getParameter("role_desc");
		
		RoleManager roleManager = SecurityDatabase.getRoleManager();
		Role role = new Role();
		role.setRoleId(role_id);		
		role.setRoleDesc(role_desc);
		role.setRoleName(role_name);
		role.setRoleType(role_type);
		sucess = roleManager.storeRole(role);
		
	}catch (Exception e){
		sucess = false;
		e.printStackTrace();
	}
%>
<script type="text/javascript">
	var mes;	
	var bool = true;
	if(<%=sucess %>){
		mes = "修改角色成功！";
	}else{
		bool = false;
		mes = "修改角色失败！";
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

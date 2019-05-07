<%--
描述：新增角色类型处理页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<% 
	boolean sucess = false;
	try{
		AccessControl accessControl =AccessControl.getInstance();
		accessControl.checkManagerAccess(request,response);
		String curUserId = accessControl.getUserID();
		String curOrgId = accessControl.getChargeOrgId();
		String type_name = StringUtil.deNull(request.getParameter("type_name"));
		String type_desc = StringUtil.deNull(request.getParameter("type_desc"));
		
		RoleType rt = new RoleType();
		rt.setCreatorOrgId(curOrgId);
		rt.setCreatorUserId(curUserId);
		rt.setTypeName(type_name);
		rt.setTypeDesc(type_desc);
		
		RoleTypeManager rtm = new RoleTypeManager();
		sucess = rtm.addRoleType(rt);
		
	}catch(Exception e){
		sucess = false;
		e.printStackTrace();
	}
%>
<script type="text/javascript">
	var mes;	
	var bool = true;
	if(<%=sucess %>){
		mes = "新增角色类型成功！";
	}else{
		bool = false;
		mes = "新增角色类型失败！";
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

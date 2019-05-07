<%--
描述：角色类型修改处理页面
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
		AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkManagerAccess(request,response);  //页面登录保护
		RoleType rt = new RoleType();
		rt.setRoleTypeID(StringUtil.deNull(request.getParameter("type_id")));
		rt.setTypeName(StringUtil.deNull(request.getParameter("type_name")));
		rt.setTypeDesc(StringUtil.deNull(request.getParameter("type_desc")));
		RoleTypeManager rtm = new RoleTypeManager();
		sucess = rtm.modifyRoleType(rt);
	}catch(Exception e){
		sucess = false;
		e.printStackTrace();
	}
	
%>
<script type="text/javascript">
	var mes;	
	var bool = true;
	if(<%=sucess %>){
		mes = "修改角色类型成功！";
	}else{
		bool = false;
		mes = "修改角色类型失败！";
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

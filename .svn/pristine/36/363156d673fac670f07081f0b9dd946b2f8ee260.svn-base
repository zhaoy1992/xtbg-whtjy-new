<%--
描述：删除角色
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%			
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response); //页面登录保护
	boolean tag = true;

	try{
		//删除操作
		RoleTypeManager rtm = new RoleTypeManager();
		String id = request.getParameter("role_ids");			
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
			//--日志结束
				
			tag = roleManager.deleteRoles(ids);
		}
	}catch(Exception e){
		e.printStackTrace();
		tag = false;
	}
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=tag%>){
	 mes = "删除成功！";	
} else {
  	mes = "删除失败！";
	bool = false;
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
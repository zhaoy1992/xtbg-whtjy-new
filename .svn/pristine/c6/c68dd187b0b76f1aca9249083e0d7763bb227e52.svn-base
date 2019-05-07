<%-- 
	描述：角色授予用户的处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.db.RoleManagerImpl,
				com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<%
	
		
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
	
		String roleId = request.getParameter("roleId");
		String userId = request.getParameter("userId");
		String orgId = request.getParameter("orgId");
		String tag = request.getParameter("tag"); 
		
		//---------------START--角色管理写操作日志
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="角色管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" 对角色  "+ roleName_log+"  对应的用户进行了操作"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");          
		//---------------END
		
		//if(userId!=null){
		//	String userIds[] =userId.split("\\,");
		//	out.print(RoleManagerAction.storeRoleUserAjax(roleId,userIds,orgId));	
	 	//}
	 	
	 	// 权限是否关联机构
		// 彭盛 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	 	
		RoleManager roleManager = new RoleManagerImpl(); 
		String msg = "";
		boolean success = false;
    	if(tag.equals("add")){
    		String[] uids = userId.split(",");
    		try
    		{
    			// 彭盛 2011-3-15 
    			if(isrolerelatedorg){
    				roleManager.grantRoleToUsers(uids,roleId,control.getUserID(),orgId);
    			}else{
    				roleManager.grantRoleToUsers(uids,roleId);
    			}
				success = true;
			}
			catch(Exception e){
				msg = "操作失败：" + e.getMessage();
			}
		}
		
		if(tag.equals("delete")){
			String[] uids = userId.split(",");
			try{
				// 彭盛 2011-3-15 
    			if(isrolerelatedorg){
					success = roleManager.deleteUsersOfRole(uids,roleId,orgId);
				}else{
					success = roleManager.deleteUsersOfRole(uids,roleId);
				}
				if(!success)
				{
					msg = "操作失败";
				}
				
			}catch(Exception e){
				msg = e.getMessage();
			}
		}
%>
<script>
var bool = false;
	<%
		if(success) {
	%>
		bool = true;
	<%
		}
	%>
	
    window.onload = function prompt(){
    	<%
    	if(!msg.equals(""))
    	{
    	%>
	        alert("<%=msg%>");
        <%
        }
        %>
       parent.divProcessing.style.display="none";
       
       parent.document.all("button1").disabled = false;
	   parent.document.all("button2").disabled = false;
	   parent.document.all("button3").disabled = false;
	   parent.document.all("button4").disabled = false;
	   
	   parent.document.all("back").disabled = false;

	   if(bool) {
			mes = "操作成功";
			alert(mes);
		} else {
			alert("操作失败");
		}
	   
    }
</script>
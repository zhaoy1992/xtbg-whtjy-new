<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
	
		//---------------START--
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="用户管理";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
	
		String roleId = request.getParameter("roleId");	
		String id = request.getParameter("id");	
		String orgId = request.getParameter("orgId");	
		// System.out.println("id" + id);
		//System.out.println("roleId" + roleId);
		if(roleId!=null){
			String roleIds[] =roleId.split("\\,") ;
			String idso[] =id.split("\\,") ;
			UserManager userManager = SecurityDatabase.getUserManager();
			//--
			String userNames_log = LogGetNameById.getUserNamesByUserIds(idso);
			String roleNames_log = LogGetNameById.getRoleNamesByRoleIds(roleIds);
			String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
			operContent="给用户："+userNames_log+" 在机构:"+orgName_log+"  授予角色："+roleNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
			userManager.storeAlotUserRole(idso,roleIds);
			
		 }
    
	
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.RoleManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
	
		//---------------START--
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��λ����";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END

		String resTypeId = request.getParameter("resTypeId");
		String resId = request.getParameter("resId");
		String opId = request.getParameter("opId");
		String roleId = request.getParameter("roleId");
		String Flag = request.getParameter("flag");
		String isRecursion = request.getParameter("isRecursion");
		String resName=request.getParameter("resName");
		String menuPath  = request.getParameter("menuPath");
		String role_type = request.getParameter("role_type");
		String roleIds[] =roleId.split("\\,");
		
		//--
		//String resName_log = SecurityDatabase.getResourceManager().getRes("resId","").getRestypeName();
		String roleNames_log = LogGetNameById.getRoleNamesByRoleIds(roleIds);
		operContent="��Դ��������-�˵���Ȩ,��Դ����:"+resName+",��ɫ��"+roleNames_log; 						
		description="";
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
		//--	end	 --
			
		out.print(RoleManagerAction.storeColumnAjax(resId,resTypeId,opId,roleIds,Flag,isRecursion,resName,menuPath,role_type));	
	 
%>
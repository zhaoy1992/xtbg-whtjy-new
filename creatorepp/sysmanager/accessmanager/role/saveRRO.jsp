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
		String resName=request.getParameter("resName");
		String role_type=request.getParameter("role_type");
		//--
		String resName_log = LogGetNameById.getResNameByResId(resId);
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent="�޸Ľ�ɫ��Դ,��Դ��"+resName_log+" ��ɫ��"+ roleName_log;						
		description="";
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
		//--	end	 --
		out.print(RoleManagerAction.storeOperListAjax(resId,resTypeId,opId,roleId,Flag,resName,role_type));	
	 
%>
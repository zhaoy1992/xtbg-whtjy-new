<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgManAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager,com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%	  
		
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
	
		String resTypeId = request.getParameter("resTypeId");
		String resId = request.getParameter("resId");
		String opId = request.getParameter("opId");
	
		String checked = request.getParameter("checked");
		String title = request.getParameter("title");
		String isRecursion = request.getParameter("isRecursion");
		//---------------START--机构管理写操作日志
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		Organization  org = orgManager.getOrgById(resId);
		String operContent=control.getUserName()+" 对机构: "+ org.getOrgName()+" 进行了授权";        
        String operSource=control.getMachinedID();
        String openModle="机构管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager();
        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");		
		//---------------END
	
		out.println(OrgManAction.editRoleOper(resId,resTypeId,opId,checked,title,isRecursion));
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgManAction,com.frameworkset.util.StringUtil" %>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgManAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		
		String jobId = request.getParameter("jobId");
		String userId = request.getParameter("userId");
		String orgId = request.getParameter("orgId");
		String flag = request.getParameter("flag");
		
		//---------------START--��������д������־	
		String jobName_log = LogGetNameById.getJobNameByJobId(jobId);
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);			
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��������";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager();
    	operContent=userName+" �Ի����� "+orgName_log+" �ĸ�λ�� "+jobName_log+" ��������Ա����"; 	
	    logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");       
		//---------------END
	
	if(userId!=null){
		String userIds[] = StringUtil.split(userId,"\\,");
		if(flag.equals("1")){
			out.print(OrgManAction.storeUJOAjax(jobId,userIds,orgId));	
		}
		if(flag.equals("0")){
			out.print(OrgManAction.deleteUJOAjax(jobId,userIds,orgId));
	
		}
	}
	
    
	
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.JobManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
	
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��λ����";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		String jobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		
		if(orgId!=null){
			String orgIds[] =orgId.split("\\,");
			//--�û������д������־	
			String orgNames_log = LogGetNameById.getOrgNamesByOrgIds(orgIds);
			String jobName_log = LogGetNameById.getJobNameByJobId(jobId);
			System.out.println("----------------��λ��ţ�"+jobId);
			operContent="�޸ĸ�λ����,��λ��"+jobName_log+" ������"+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);       
			//--	end	 --
			out.print(JobManagerAction.storeJobOrgAjax(jobId,orgIds));	
		 }
	
    
	
%>
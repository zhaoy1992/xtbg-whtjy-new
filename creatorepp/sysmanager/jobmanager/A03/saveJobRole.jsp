<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%
	  
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String currentUserId = control.getUserID();
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��λ����";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		String jobId = request.getParameter("jobId");
		String roleId = request.getParameter("roleId");
		String orgId = request.getParameter("orgId");
		boolean state = false;
		if(roleId!=null){
			String roleIds[] =roleId.split("\\,");
			//--�û������д������־	
			String orgNames_log = LogGetNameById.getOrgNamesByOrgIds(roleIds);
			String jobName_log = LogGetNameById.getJobNameByJobId(jobId);
			//System.out.println("----------------��λ��ţ�"+jobId);
			operContent="�޸ĸ�λ��ɫ,��λ��"+jobName_log+" ��ɫ��"+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);       
			//--	end	 --
			
			
			JobManager jobManager = SecurityDatabase.getJobManager();
			
			if(jobId != null && !jobId.equals("")){
				//jobManager.deleteJobroleByJobId(jobId, orgId);
				//�ݹ����
				state = jobManager.deleteJobroleByJobId(jobId, orgId);
				if(roleIds[0] != null && !roleIds[0].equals("")){
					//jobManager.addJobroleMap(jobId, orgId, roleIds);
					//��¼�ݹ������ϵ
					state = jobManager.addJobroleMap(jobId, orgId, roleIds);
				}
			}
			//System.out.println(JobManagerAction.storeAndDeleteJobRoleAjax(jobId,roleIds));	
		 }
	
    
	
%>
<script language="Javascript">
alert("ddd");
parent.document.all.divProcessing.style.display="none";
</script>
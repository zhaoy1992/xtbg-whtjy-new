<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
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
        String openModle="��������";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		
		String orgId = request.getParameter("orgId");
		
		//�����ƶ�λ��
		String jobId1 = request.getParameter("jobId1");
		String jobId2 = request.getParameter("jobId2");		
		String jobSn = request.getParameter("jobSn");
		
		//upall or downall
		String jobId3 = request.getParameter("jobId0");		
		if(jobId3 == null)
		{
			jobId3 = "";
		}
		String[] jobId =null;
		if(jobId3 != ""){
			jobId = jobId3.split(",");
		}
		
		//�������֣���־��¼ʹ��
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
		
		if(jobId != null && jobId.length > 0){
		
			//--�û������д������־	
			String jobNames_log = LogGetNameById.getJobNamesByJobIds(jobId);
			operContent="�����¸�λ����,������"+orgName_log+",��λ��˳��"+jobNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
		    OrgJobAction.allOrgJobSnChangeAjax(orgId,jobId);
		}else{
			//--�û������д������־	
			String jobName1_log = LogGetNameById.getJobNameByJobId(jobId1);
			String jobName2_log = LogGetNameById.getJobNameByJobId(jobId2);
			operContent="�����¸�λ����,������"+orgName_log+",����λ:"+jobName1_log+"��������λ:"+jobName2_log+"��ǰ�档"; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
			OrgJobAction.orgJobSnChangeAjax(orgId,jobId1,jobId2,jobSn);
		}
%>
<script>
    window.onload = function prompt(){
        //alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
    }
</script>
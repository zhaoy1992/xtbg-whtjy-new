<%
/*
 * <p>Title: Ϊ��λѡ������ı��洦��ҳ��</p>
 * <p>Description:Ϊ��λѡ������ı��洦��ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById,
                 com.chinacreator.sysmgrcore.manager.OrgManager,
                 com.chinacreator.sysmgrcore.manager.JobManager,
                 com.chinacreator.sysmgrcore.entity.Job,
                 com.chinacreator.sysmgrcore.entity.Organization,
                 com.chinacreator.sysmgrcore.entity.Orgjob"%>
<%
	
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��λ����";
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        OrgManager orgManager = SecurityDatabase.getOrgManager(); 		
		//---------------END
		String jobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		//1Ϊ���ӻ�����λ��ϵ��0Ϊɾ��������λ��ϵ
		String flag = request.getParameter("flag");
		
		String orgIds[] =orgId.split("\\,");
		//--�û������д������־	
		String orgNames_log = LogGetNameById.getOrgNamesByOrgIds(orgIds);
		String jobName_log = LogGetNameById.getJobNameByJobId(jobId);
		String[] arr_jobid = {jobId};
		if("0".equals(flag)){
			//System.out.println("----------------��λ��ţ�"+jobId);
			operContent="�޸ĸ�λ����,��λ��"+jobName_log+" ������"+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
			
			for(int i = 0; i < orgIds.length; i++){
				orgManager.deleteOrgjob(orgIds[i],arr_jobid);
			}
		}else{
		//System.out.println("----------------��λ��ţ�"+jobId);
			operContent="�޸ĸ�λ����,��λ��"+jobName_log+" ������"+orgNames_log; 						
			description="";
			logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
			
			for(int i = 0; i < orgIds.length; i++){
				orgManager.addOrgjob(orgIds[i],arr_jobid,"1");
			}
		}
		
%>
<script>
    window.onload = function prompt(){
        alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
        parent.document.getElementById("button1").disabled = false;
        parent.document.getElementById("button2").disabled = false;
        parent.document.getElementById("button3").disabled = false;
        parent.document.getElementById("button4").disabled = false;
        parent.document.getElementById("button5").disabled = false;
    }
</script>


<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>

<%
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��������";
        String userName = control.getUserAccount();//getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		//���jobId
		String mutijobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		String jobSn = request.getParameter("jobSn");
		String[] arr_jobid = mutijobId.split(",");
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		String jobName_log = "";
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);			
		if(jobSn == null)//�ݹ� �Ѹ�λ���õ��ӻ���
		{
			//--�û������д������־	
			operContent="�ݹ���ӻ�������λ�Ĺ�ϵ,��λ��"+jobName_log+"��������"+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
			String jobIds = request.getParameter("jobIds");
			orgManager.addSubOrgjob(orgId,jobIds.split(","));		   
		}
		else if(jobSn.equals("-1"))//ɾ����λ
			{
			//--�û������д������־	
			operContent="ɾ����������λ�Ĺ�ϵ,��λ��"+jobName_log+"��������"+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --
			orgManager.deleteOrgjob(orgId,arr_jobid);
		}
		else if(jobSn.equals("-2"))//�ݹ�ɾ����λ
			{
			//--�û������д������־	
			operContent="�ݹ�ɾ����������λ�Ĺ�ϵ,��λ��"+jobName_log+"��������"+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --
			orgManager.deleteSubOrgjob(orgId,arr_jobid);
		}
		else{//���Ӹ�λ
			//--�û������д������־	
			operContent="��ӻ�������λ�Ĺ�ϵ,��λ��"+jobName_log+"��������"+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
		    orgManager.addOrgjob(orgId,arr_jobid,jobSn);
		}
%>
<script>
    window.onload = function prompt()
    {
        alert("�����ɹ�!");
        
        parent.divProcessing.style.display="none";
        
        parent.document.all("button1").disabled = false;
		parent.document.all("button2").disabled = false;
		parent.document.all("button3").disabled = false;
		parent.document.all("button4").disabled = false;
		
		//parent.document.all("button11").disabled = false;
		//parent.document.all("button22").disabled = false;
		//parent.document.all("button33").disabled = false;
		//parent.document.all("button44").disabled = false;
		
		parent.document.all("butn").disabled = false;
    }
</script>
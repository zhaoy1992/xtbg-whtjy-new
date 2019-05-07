<%
/*
 * <p>Title: ��λ��������ҳ��</p>
 * <p>Description: ��λ��������ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.exception.ManagerException"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>


<%
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			int curUserId = Integer.parseInt(control.getUserID());
			
			boolean tag = true;
			
			String notice = "���ʧ�ܣ�\\n";
			
			
			//---------------START--��λ����д������־
			String operContent="";        
	        String operSource=control.getMachinedID();
	        String openModle="��λ����";
	        String userName = control.getUserName();
	        String description="";  
	        LogManager logManager = SecurityDatabase.getLogManager();
			//---------------END
			
			
			String jobName = StringUtil.replaceNull(request.getParameter("jobname"));
			String jobDesc = StringUtil.replaceNull(request.getParameter("jobdesc"));
			String jobFunction = StringUtil.replaceNull(request.getParameter("jobFunction"));
			String jobAmount = StringUtil.replaceNull(request.getParameter("jobAmount"));
			String jobNumber = StringUtil.replaceNull(request.getParameter("jobNumber"));
			String jobCondition = StringUtil.replaceNull(request.getParameter("jobCondition"));
			String jobRank = StringUtil.replaceNull(request.getParameter("jobRank"));
			
			boolean b1 = false;
			boolean b2 = false;
			
			JobManager jobMgr = SecurityDatabase.getJobManager();
			
			try
			{
				b1 = jobMgr.isJobExist(jobName.trim());
				if(null!=jobNumber && !jobNumber.trim().equals("")){
	 				b2 = jobMgr.isJobNumber(jobNumber.trim());
				}else{
					b2 = false;
				}
			} 
			catch (ManagerException e1) 
			{
				tag  = false;
			}
	
			Job job = new Job();
			
			
			if (b1 == false && b2==false) 
			{
				job.setJobName(jobName);
				job.setJobDesc(jobDesc);
				job.setJobFunction(jobFunction);
				job.setJobAmount(jobAmount);
				job.setJobNumber(jobNumber);
				job.setJobCondition(jobCondition);
				job.setJobRank(jobRank);
				job.setOwner_id(curUserId);
			} 
			else
			{
				if(b1)
				{
					tag = false;
					notice = notice + "��λ�����Ѿ����ڣ�\\n";
				}
				if(b2)
				{
					tag = false;
					notice = notice + "��λ����Ѿ����ڣ�\\n";
				}
			}
			
			if(tag)
			{
				try {
					jobMgr.saveJob(job);
					
					//--��λ����д������־	
					operContent="������λ��"+job.getJobName(); 						
					description="";
					logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);       
					//--
					
				} 
				catch (ManagerException e) 
				{
					tag = false;
				}
			}
			
			if(tag)
			{
		%>
				<script>
				    alert("��ӳɹ���");
				</script>
				<%
			}
			else
			{
		%>
				<script>
				    alert("<%=notice%>");
				</script>
		<%
			}
		%>
		
<script>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        
        parent.document.all.Submit.disabled = false;
		parent.document.all.Reset.disabled = false;
		parent.document.all.BackButton.disabled = false;
    }
</script>
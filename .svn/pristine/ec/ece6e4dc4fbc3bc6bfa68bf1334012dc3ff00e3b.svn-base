<%
/*
 * <p>Title: 岗位修改处理页面</p>
 * <p>Description: 岗位修改处理页面</p>
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
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
				
<%
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			boolean tag = true;
			String notice = "修改失败！\\n";
			
			String oldJobName = request.getParameter("oldJobName");
			String oldJobNumber = request.getParameter("oldJobNumber")==null?"":request.getParameter("oldJobNumber");
			
			//---------------START--岗位管理写操作日志
			
			String operContent="";        
	        String operSource=control.getMachinedID();
	        String openModle="岗位管理";
	        String userName = control.getUserName();
	        String description="";
	        LogManager logManager = SecurityDatabase.getLogManager(); 		
			//---------------END
			
			
			String jobName = StringUtil.replaceNull(request.getParameter("jobName"));
			String jobDesc = StringUtil.replaceNull(request.getParameter("jobDesc"));
			String jobFunction = StringUtil.replaceNull(request.getParameter("jobFunction"));
			String jobAmount = StringUtil.replaceNull(request.getParameter("jobAmount"));
			String jobNumber = StringUtil.replaceNull(request.getParameter("jobNumber"));
			String jobCondition = StringUtil.replaceNull(request.getParameter("jobCondition"));
			String jobRank = StringUtil.replaceNull(request.getParameter("jobRank"));
			String jobId = StringUtil.replaceNull(request.getParameter("jobId"));
			
			JobManager jobManager = SecurityDatabase.getJobManager();	
			
			if(!"".equals(oldJobNumber) && null!=jobNumber && !jobNumber.trim().equals("")){
				if(!jobNumber.equals(oldJobNumber)){
					boolean isNumber = jobManager.isJobNumber(jobNumber);
					if(isNumber){
						tag = false;
						notice += "存在相同岗位编号！\\n";
					}
				}
			}
			if(!oldJobName.equals(jobName)){
				boolean isJob = jobManager.isJobExist(jobName);
				if(isJob){
					tag = false;
					notice += "存在相同岗位名称！";
				}
			}
			
			if(tag){
				try
				{
					Job job = new Job();
					job.setJobName(jobName);
					job.setJobDesc(jobDesc);
					job.setJobFunction(jobFunction);
					job.setJobAmount(jobAmount);
					job.setJobNumber(jobNumber);
					job.setJobCondition(jobCondition);
					job.setJobRank(jobRank);
					job.setJobId(jobId);
					
					jobManager.storeJob(job);
					
					//--岗位管理写操作日志	
					operContent="修改岗位："+job.getJobName(); 						
					description="";
					logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);       
					//--
				}
				catch(Exception e)
				{
					tag = false;
				}
			}
			
			if(tag)
			{
		%>
				<script>
				    alert("修改成功！");
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
	        parent.document.getElementById("Submit").disabled = false;
	        parent.document.getElementById("Submit3").disabled = false;
	    }
	</script>
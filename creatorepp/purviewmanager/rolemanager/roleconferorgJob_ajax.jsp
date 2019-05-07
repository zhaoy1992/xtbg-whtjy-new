<%
/*
 * <p>Title: 角色隶属机构的操作页面</p>
 * <p>Description: 角色隶属机构的操作页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.sysmgrcore.manager.OrgManager,
				com.chinacreator.sysmgrcore.manager.JobManager,
				com.chinacreator.sysmgrcore.entity.Organization,
				com.frameworkset.common.poolman.DBUtil"%>

<%@ page import="com.chinacreator.sysmgrcore.entity.User,
				 com.chinacreator.sysmgrcore.entity.Job,
				 java.util.List,
				 java.util.ArrayList"%>

<%@ page import="com.chinacreator.security.AccessControl"%>


<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);


			String roleId = (String) request.getParameter("roleId");				
			String orgId = request.getParameter("orgId");

		
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			JobManager jobManager = SecurityDatabase.getJobManager();
			
			//获取机构下的所有岗位
			Organization org = orgManager.getOrgById(orgId);
			List allJobsofOrg = jobManager.getJobList(org);
			
			
			String sql = "select ojr.JOB_ID,j.JOB_NAME " 
							+ "from TD_SM_ORGJOBROLE ojr , TD_SM_JOB j where ojr.JOB_ID = j.JOB_ID " 
							+ " and ojr.ORG_ID = '" + orgId 
							+ "' and ojr.ROLE_ID ='" + roleId+"'" ;
																	
			List existjobsofOrg = new ArrayList();
			
			try
			{							
				DBUtil db = new DBUtil();
				db.executeSelect(sql);
				if(db.size()>0)
				{
					for(int i=0; i< db.size(); i++)
					{
						String jobId =  db.getString(i,"JOB_ID");
						String jobName = db.getString(i,"JOB_NAME");
						
						Job job = new Job();
						job.setJobId(jobId);
						job.setJobName(jobName);
						if(accesscontroler.checkPermission(jobId,"jobset",AccessControl.JOB_RESOURCE)){				
							existjobsofOrg.add(job);
						}
					}
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			List jobSetAlljobsofOrg = null;
			if(allJobsofOrg != null && allJobsofOrg.size() > 0){
				jobSetAlljobsofOrg = new ArrayList();
				for(int i = 0; i < allJobsofOrg.size(); i++){
					Job jobAll = (Job)allJobsofOrg.get(i);
					if(accesscontroler.checkPermission(jobAll.getJobId(),"jobset",AccessControl.JOB_RESOURCE)){
						jobSetAlljobsofOrg.add(jobAll);
					}
				}
			}
							
			request.setAttribute("existjobsofOrg", existjobsofOrg);
			//request.setAttribute("allJobsofOrg", allJobsofOrg);
			request.setAttribute("allJobsofOrg", jobSetAlljobsofOrg);

			%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<SCRIPT LANGUAGE="JavaScript"> 
			function addOrg()
			{	
			  var n=document.all("orgId").options.length-1;
			  var jobIds = "";
			  for(var i=0;i<document.all("allist").options.length;i++)
			  {
			    var op=document.all("allist").options[i];
			    if(op.selected)
			    {
			        addone(op.text,op.value,n);
			        if(jobIds =="") jobIds = jobIds + op.value;
			        else jobIds = jobIds + "," + op.value;
			    }
			  }
			  
		   	if(jobIds != "")
		    {
		    	send_request('saveRoleOrgJobs.jsp?orgId=<%=orgId%>&roleId='+<%=roleId%>+'&jobIds='+jobIds+'&tag=add');
		    }
			
		}
			
		function addone(name,value,n)
		{
		
		   for(var i=n;i>=0;i--)
		   {
				if(value==document.all("orgId").options[i].value)
				{
				  return;
				}
			}
		   var op=new Option(name,value);
		   document.all("orgId").add(op);
		}
			
		function deleteall()
		{
		 	var jobIds = "";
			for (var m=document.all("orgId").options.length-1;m>=0;m--)
			{
				if(jobIds =="") jobIds = jobIds + document.all("orgId").options[m].value;
		        else jobIds = jobIds + "," + document.all("orgId").options[m].value;
				
		   		document.all("orgId").options[m]=null
			}    
			 if(jobIds != "")
		    {
		    	send_request('saveRoleOrgJobs.jsp?orgId=<%=orgId%>&roleId='+<%=roleId%>+'&jobIds='+jobIds+'&tag=delete');
		    }
		  
		}
	      
		function addall()
		{
			var n=document.all("orgId").options.length-1;
			var p=document.all("allist").options.length-1;	
			
			var jobIds = "";
					  
		    for(var i=0;i<document.all("allist").options.length;i++){
		        var op=document.all("allist").options[i];
		        addone(op.text,op.value,n);  
		        if(jobIds =="") jobIds = jobIds + op.value;
			    else jobIds = jobIds + "," + op.value;
		    }
		    if(jobIds != "")
		    {
		    	send_request('saveRoleOrgJobs.jsp?orgId=<%=orgId%>&roleId='+<%=roleId%>+'&jobIds='+jobIds+'&tag=add');
		    }	  
		    
		   
		}
			
		function deleteorg()
		{ 
		 	var jobIds = "";		
		    for (var m=document.all("orgId").options.length-1;m>=0;m--)
		    {
			    if(document.all("orgId").options[m].selected)
			    {
		      	    var op = document.all("orgId").options[m]
		      	    if(jobIds =="") jobIds = jobIds + op.value;
			        else jobIds = jobIds + "," + op.value;
			        document.all("orgId").options[m]=null;
		        }
		    }
			if(jobIds != "")
		    {
		    	send_request('saveRoleOrgJobs.jsp?orgId=<%=orgId%>&roleId='+<%=roleId%>+'&jobIds='+jobIds+'&tag=delete');
		    }	
		}
			
	
		function send_request(url)
		{						
			document.all.divProcessing.style.display = "block";
			
			document.all("button1").disabled = true;
			document.all("button2").disabled = true;
			document.all("button3").disabled = true;
			document.all("button4").disabled = true;
			document.all("back").disabled = true;
			
			document.RoleOrgForm.action = url;
			
			document.RoleOrgForm.target = "hiddenFrame";
			document.RoleOrgForm.submit();
		}
	</SCRIPT>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
	
		<div id="contentborder">
			<center>
				<form name="RoleOrgForm" action="" method="post">
					<table width="100%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tabletop">
							<td width="45%" align="center">
								&nbsp;
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tabletop">
							<td width="45%" align="center">
								可选岗位
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								已授予岗位
							</td>
						</tr>
						<tr class="tabletop">
							<td width="45%" align="center">
								&nbsp;
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="right">
								<select name="allist" multiple style="width:100%" onDBLclick="addOrg()" size="18">
									<pg:list requestKey="allJobsofOrg">
										<option value="<pg:cell colName="jobId"/>">
											<pg:cell colName="jobName" />
										</option>
									</pg:list>
								</select>
							</td>

							<td align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addOrg()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button4" type="button" class="input" value="&lt;" onclick="deleteorg()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td>
								<select name="orgId" multiple style="width:100%" onDBLclick="deleteorg()" size="18">
									<pg:list requestKey="existjobsofOrg">
										<option value="<pg:cell colName="jobId"/>">
											<pg:cell colName="jobName"/>
										</option>
									</pg:list>
								</select>

							</td>

						</tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>

						</tr>
						<tr>
							<td colspan="3" align="center">
								<input type="button" name="back" class="input" value="返回" onclick="window.close()"/>
							</td>
						</tr>
					</table>

					<input type="hidden" name="roleId" value="<%=roleId%>" />
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:170px;top:400px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

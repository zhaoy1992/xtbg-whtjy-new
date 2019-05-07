<%
/*
 * <p>Title: �û�������λҳ��</p>
 * <p>Description: �û�������λҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-22
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User,
				com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.db.OrgCacheManager,
				java.util.ArrayList,
				java.util.List"%>


<%
			response.setHeader("Cache-Control", "no-cache"); 
			response.setHeader("Pragma", "no-cache"); 
			response.setDateHeader("Expires", -1);  
			response.setDateHeader("max-age", 0); 

			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response);
			
			JobManager jobManager = SecurityDatabase.getJobManager();
			Job noJob = jobManager.getJobById("1");
			String jobName = "";
			String jobid = "";
			if (noJob != null) {
				jobid = noJob.getJobId();
				jobName = noJob.getJobName();
			}
			String userId = request.getParameter("userId");
			String orgId = request.getParameter("orgId");
			session.setAttribute("userId", userId);
			UserManager userManager = SecurityDatabase.getUserManager();
			User user = userManager.getUserById(userId);
			Organization org = OrgCacheManager.getInstance().getOrganization(orgId);
				
			List existJob = jobManager.getJobList(org,user);//�û��ڵ�ǰ�����µĸ�λ
			List allJob = jobManager.getJobList(org);
			//Ȩ�޹��ˣ� �ܽ��и�λ����ĸ�λ�����ǣ���ǰ��¼�û����������Ź���Ա���������Щ��λ�л������õ�Ȩ�ޡ�	
			List list1 = new ArrayList();
		    if(existJob != null)
		    {
		    	for(int i=0;i<existJob.size();i++)
		    	{
		    		Job job = (Job)existJob.get(i);
		    		list1.add(job);
		    	}
		    }
		    List list2 = new ArrayList();
		    if(allJob != null)
		    {
		    	for(int i=0;i<allJob.size();i++)
		    	{
		    		Job job = (Job)allJob.get(i);
		    		//�û��Լ�����������Ȩ�����õĸ�λ
		    		if(accessControl.checkPermission(job.getJobId(), "jobset", AccessControl.JOB_RESOURCE))
		    		{
		    			list2.add(job);
		    		}
		    	}
		    }
			request.setAttribute("existJob", list1);
			request.setAttribute("allJob", list2);
			String myOrgId = orgId;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head> 
		<title>My JSP 'changeJob_ajax.jsp' starting page</title>
		<script language="JavaScript" src="../../scripts/ajax.js" type="text/javascript"></script>
		<script language="javascript" src="../../../include/dragdiv.js"></script>
		<script language="JavaScript" src="../../../include/querySelect.js" type="text/javascript"></script>
		
	<SCRIPT LANGUAGE="JavaScript"> 
	  
		function createjob(){
			var orgId = document.all("orgId").value;
			var url = "../jobmanager/A03/addjob.jsp?fromtype=user&orgId=" + orgId;  
			showModalDialog(url,window,"dialogWidth:"+780+"px;dialogHeight:"+580+"px;help:no;scroll:auto;status:no");
		}
		
		var win ;
		function imp()
		{
			var orgId = document.all("orgId").value;
			var url = "lusersys_ajax.jsp?orgId=" + orgId;  
			win = window.showModalDialog(url,window,"dialogWidth:"+660+"px;dialogHeight:"+580+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0;");
			if(win == "ok"){
			    window.location.href = "userjoborg.jsp?userId=<%=userId%>&orgId=<%=myOrgId%>";
			}
		}
		function addone(name,value,n){
		   for(var i=n;i>=0;i--){
				if(value==document.all("jobId").options[i].value){
				  return;
				}
			}
		   var op=new Option(name,value);
		   document.all("jobId").add(op);
		}
		function addjob(){	
			//�Ѿ����õĸ�λ
			var alreadyJobArr = document.all("jobId");
		   //��ӵ�����λ
		   var jobIds = "";
		   var n=document.all("jobId").options.length-1;   	
		   var orgId = document.all("orgId").value;
		   var flag = "1";	
		   var alreadyJobs = "";
		   for(var i=0;i<document.all("allist").options.length;i++){
		   	   var op=document.all("allist").options[i];   
			   if(op.selected){
			   		var flag2 = false;
			   		for(var j = 0; j < alreadyJobArr.length; j++){
			   			if(op.text==alreadyJobArr.options[j].text){
			   				flag2 = true;
			   			}
			   		}
			   		if(!flag2){
				   		if(jobIds==""){ 
				   			jobIds = op.value;
				   		}else {
				   			jobIds += "," + op.value;
				   		}
				   		addone(op.text,op.value,n);		
			   		}else{
			   			if(alreadyJobs == ""){
			   				alreadyJobs = op.text;
			   			}else{
			   				alreadyJobs += "\n" + op.text;
			   			}
			   		}   	
			   }	
		   }
		   //ÿ����ӱ���Ҫѡ��һ����λ,weida
		   if(jobIds != ""){
		   		send_request('savaUserOrgJob.jsp?userId=<%=userId%>&orgId='+orgId+'&jobId='+jobIds+'&flag='+flag);  
		   }else if(alreadyJobs != ""){
		   		alert("���¸�λ�Ѿ����ã�\n" + alreadyJobs);
	  			return;
		   }else{
		   		alert("��ѡ��Ҫ��ӵĸ�λ����!");
		   		return;
		   }	
		}
		
		function addall(){
			//�Ѿ����õĸ�λ
			var alreadyJobArr = document.all("jobId");
			//������и�λ
			var jobIds = "";	
			var n=document.all("jobId").options.length-1;
			var p=document.all("allist").options.length-1;
			var alreadyJobs = "";		  
		    for(var i=0;i<document.all("allist").options.length;i++){
			    var op=document.all("allist").options[i];
			    var flag = false;
			    for(var j = 0; j < alreadyJobArr.length; j++){
			    	if(op.text==alreadyJobArr.options[j].text){
			    		flag = true;
			    	}
			    }			
			    if(!flag){
			    	if(jobIds == ""){
			    		jobIds = op.value;	
			    	}else{
						jobIds += "," + op.value;
					}
			    	addone(op.text,op.value,n);
			    }else{
			    	if(alreadyJobs == ""){
			    		alreadyJobs = op.text;
			    	}else{
			    		alreadyJobs += "\n" + op.text;
			    	}
			    }	     
		   }
		   var orgId = document.all("orgId").value;
		   var flag = "1";
		   if(jobIds != "")
		   {
		   		send_request('savaUserOrgJob.jsp?userId=<%=userId%>&orgId='+orgId+'&jobId='+jobIds+'&flag='+flag);	  
		   }else if(alreadyJobs != ""){
		   		alert("���¸�λ�Ѿ����ã�\n" + alreadyJobs);
	  			return;
		   }
		   
		}
		function deletejob(){	
			//�������ٱ���һ����λ,weida
			//var len=document.all("jobId").options.length;
			//if(len == 1){
			//    alert("�������ٱ���һ����λ��");
			//    return;
			//}	
			if(document.all("jobId").options.length < 1){
				alert("û�п�ѡ�ĸ�λ��");
				return;
			}
			if(document.all("jobId").selectedIndex==-1){
				alert("��ѡ��Ҫɾ���ĸ�λ��");
				return;
			}
			var jobId = "";
			//var selectedCount = 0;
			//for (var m=document.all("jobId").options.length-1;m>=0;m--){
			//    if(document.all("jobId").options[m].selected){
			//        selectedCount = selectedCount + 1;
			//    }
			//}
			//if(selectedCount==len){
			//    alert("�������ٱ���һ����λ��");
			//	return;
			//}
			//��Ȩ�޵ĸ�λ����
			var havePurviewCount = document.all("allist").options.length-1;
			var orgId = document.all("orgId").value;
		    var flag = "0";
		    var jobIds = "";
		    var noPurviewJob = "";
			for (var m=document.all("jobId").options.length-1;m>=0;m--){
				var option = document.all("jobId").options[m];
			    if(document.all("jobId").options[m].selected){
			    	var flag1 = false;
			    	for(var n=havePurviewCount; n>=0; n--){
			    		if(document.all("allist").options[n].value==option.value){
					      	jobId = option.value;
					      	if(jobIds==""){
					      		jobIds = jobId;
					      	}else{
					      		jobIds = jobIds + "," + jobId;
					      	}
					        document.all("jobId").options[m]=null;
					        flag1 = true;
					    }
			        }
			        if(!flag1){
			        	if(noPurviewJob==""){
				    		noPurviewJob = "�����¸�λû��Ȩ�ޣ�\n" + option.text;
				    	}else{
				    		noPurviewJob += "\n" + option.text;
				    	}
			        }
			    }
		    }
		    if(jobIds != ""){
		    	send_request('savaUserOrgJob.jsp?userId=<%=userId%>&orgId='+orgId+'&jobId='+jobIds+'&flag='+flag);	
		    }else{
			    if(noPurviewJob!=""){
			    	alert(noPurviewJob);
			    }else{
		    		return ;
		    	}
		    }
		    
		}
		//������
		function deleteall(){
			//weida,��ֹȫ��������λ
			//alert("Ҫ����ȫ����λ,��ֱ�����б���ɾ���û�!");
			//return;
			if(document.all("jobId").options.length < 1){
				alert("û�п�ѡ�ĸ�λ��");
			}
			//��Ȩ�޵ĸ�λ����
			var havePurviewCount = document.all("allist").options.length-1;
			var orgId = document.all("orgId").value;
		    var flag = "0";
		    var jobIds = "";
		    var noPurviewJob = "";
			for (var m=document.all("jobId").options.length-1;m>=0;m--){
				var option = document.all("jobId").options[m];
		    	var flag1 = false;
		    	for(var n=havePurviewCount; n>=0; n--){
		    		if(document.all("allist").options[n].value==option.value){
				      	jobId = option.value;
				      	if(jobIds==""){
				      		jobIds = jobId;
				      	}else{
				      		jobIds = jobIds + "," + jobId;
				      	}
				        document.all("jobId").options[m]=null;
				        flag1 = true;
				    }
		        }
		        if(!flag1){
		        	if(noPurviewJob==""){
			    		noPurviewJob = "�����¸�λû��Ȩ�ޣ�\n" + option.text;
			    	}else{
			    		noPurviewJob += "\n" + option.text;
			    	}
		        }
		    }
		    if(jobIds != ""){
		    	send_request('savaUserOrgJob.jsp?userId=<%=userId%>&orgId='+orgId+'&jobId='+jobIds+'&flag='+flag);
		    }else{
			    if(noPurviewJob!=""){
			    	alert(noPurviewJob);
			    }else{
		    		return ;
		    	}
		    }
			//ɾ�����и�λ		
		}      
	
		
	//---------------------------------------
		var http_request = false;
		function send_request(url){
			document.all.divProcessing.style.display = "block";
			
			document.all("button1").disabled = true;
			document.all("button2").disabled = true;
			document.all("button3").disabled = true;
			document.all("button4").disabled = true;
			document.all("butn").disabled = true;
			document.all("butn2").disabled = true;
			
			document.OrgJobForm.target="hiddenFrame";
			document.OrgJobForm.action = url;
			document.OrgJobForm.submit();
		}
						
		function changebox(){				 
			var len=document.all("jobId").options.length;			  	 	
		    var orgId = document.all("orgId").value;
		    var jobId=new Array(len)
		    for (var i=0;i<len;i++){	      
		        jobId[i]=document.all("jobId").options[i].value;
		     }           		
			send_request('savaUserOrgJob.jsp?userId=<%=userId%>&orgId='+orgId+'&jobId='+jobId);
		}
		
		function closed(){
			parent.window.close();
			parent.window.returnValue="ok";
		}
	</SCRIPT>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
	
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="loadDragDiv()">
		<div id="contentborder">
			<center>
				<input name="userId" value="<%=userId%>" type="hidden">
				<input name="orgId" value="<%=orgId%>" type="hidden">
				<form name="OrgJobForm" target="hiddenFrame" action="" method="post">
					<table width="80%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tabletop">
							<td width="40%" align="left">
								���������λ
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="right">
								�û�<%=user.getUserRealname()%>
								����½��:
								<%=user.getUserName()%>
								���ڸû������������λ
							</td>
						</tr>
						 <tr>
						  	<td width="40%" align="left">
						  		<input name="selectRoles" type="text" value="" onkeydown="enterKeydowngo()" onpropertychange="onBlurryQueryChange()" ondblclick=""  />
						  		<input name="que" type="button" value="��ѯ" onclick="blurryQuary()" class="input" />
						  		<input name="nextQue" style="display:none" type="button" value="������һ��" onclick="nextQuery()" class="input" />
						  	</td>
						    <td width="20%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						    <td width="40%" align="right">
						    	
						    </td>
						  </tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>
							<td width="20%" align="center">
								&nbsp;
							</td>
							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="lrft">
							<div class="win" id="dd_1" align="left" title="����ѡ�����ұ߱߿���������϶�">
								<select name="allist" multiple style="width:98%" onDBLclick="addjob()" size="18" title="����ѡ�����ұ߱߿���������϶�">
									<pg:list requestKey="allJob">
										<option value="<pg:cell colName="jobId"/>">
											<pg:cell colName="jobName" />
										</option>
									</pg:list>
								</select>
								</div>
							</td>

							<td align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center">
											<input name="button1" type="button" class="input" value="&gt;" onClick="addjob()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onClick="addall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onClick="deleteall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button4" type="button" class="input" value="&lt;" onClick="deletejob()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td><div class="win" id="dd_2" align="right" title="����ѡ�����ұ߱߿���������϶�">
								<select name="jobId" multiple style="width:98%"  onDBLclick="deletejob()" size="18" title="����ѡ�����ұ߱߿���������϶�">
									<pg:list requestKey="existJob">
										<option value="<pg:cell colName="jobId"/>">
											<pg:cell colName="jobName" />
										</option>
									</pg:list>
								</select>
							</div>
							</td>

						</tr>
						<tr>
							<td>
								<br/>
								<br/>
								<br/>
								<br/>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="4">
								<!--input name="butn" type="button" class="input" value="������λ" onClick="createjob()"-->
								<%
								 if (accessControl.checkPermission(myOrgId, "orgjobset", AccessControl.ORGUNIT_RESOURCE))
								 //if(accessControl.isAdmin())
					            {%>
								<input name="butn" type="button" class="input" value="���û�����λ" onClick="imp()">
								<%}%>
								<input name="butn2" type="button" class="input" value="����" onclick="closed();">
							</td>
						</tr>
						<tr class="tabletop">

							<td width="40%" align="center">
								&nbsp;
							</td>
						</tr>

					</table>
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:300px;top:350px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
			    <tr>
				    <td bgcolor=#3A6EA5>
					    <marquee align="middle" behavior="alternate" scrollamount="5">
						    <font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

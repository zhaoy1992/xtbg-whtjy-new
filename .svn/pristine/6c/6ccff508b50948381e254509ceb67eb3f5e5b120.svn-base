<%
/*
 * <p>Title: 岗位修改页面</p>
 * <p>Description: 岗位修改页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	

	String jobId = StringUtil.replaceNull(request.getParameter("jobId"));
			
	JobManager jobManager = SecurityDatabase.getJobManager();
	UserManager userManager=SecurityDatabase.getUserManager();
	Job job = jobManager.getJobById(jobId);
	
	//旧的岗位名称与岗位编号，修改的岗位名称与岗位编号不能相同
	String oldJobName = job.getJobName();
	String oldJobNumber = job.getJobNumber(); 
	
	request.setAttribute("Job", job);
	
	String jobFunction="";
	String jobDesc="";
	String jobCondition=""; 
	String userName="";
	String userRealName="";
	
if(job != null){
		jobFunction = job.getJobFunction() ;
		jobFunction = jobFunction == null ? "" : jobFunction.trim() ;
		
		jobDesc = job.getJobDesc();
		jobDesc = jobDesc  == null ? "": jobDesc.trim() ;
		
		jobCondition = job.getJobCondition();
		jobCondition = jobCondition == null ? "" : jobCondition.trim();	
		
	    String roleOwnerId=String.valueOf(job.getOwner_id());
		User user=userManager.getUserById(roleOwnerId);
		userName=user.getUserName();
	    userRealName=user.getUserRealname();	
				
  	}
%>
<html>
	<head>
		<title>岗位信息修改</title>
		<SCRIPT language="JavaScript" SRC="../include/validateForm.js"></SCRIPT>
		<script language="JavaScript">
			 function trim(string)
			 {
			  var temp="";
			  string = ''+string;
			  splitstring = string.split(" ");
			  for(i=0;i<splitstring.length;i++)
			  {
			    temp += splitstring[i];
			  } 
			  return temp;
			 }
		  
		  	// 计算字符串的长度，汉字占两个字符
			function StringLength(str)
			{
			    // replace将符合此正则的字符串替换成指定字符 然后在计算长度
			    return str.replace(/[^\x00-\xff]/g,"**").length
			}
			
			function updatejob()
			{
				var form = document.forms[0];
				var jobName= document.forms[0].jobName.value;
				var jobNumber=form.jobNumber.value;
				var jobRank=form.jobRank.value;
				var jobAmount=form.jobAmount.value;
				var jobFunction=form.jobFunction.value;
				var jobDesc=form.jobDesc.value;
				var jobCondition=form.jobCondition.value;
				
				if (trim(jobName).length == 0 )
				{
				    alert("请录入岗位名称！"); 
				    return false;
			    }
			    
			    //if (trim(jobNumber).length == 0 )
			    //{
				//    alert("请录入岗位编号！"); 
				//    return false;
			    //}
			      
			    if(jobName.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			    {
					alert("岗位名称不能有\\/|:*?<>\"'!等特殊字符");
					form.jobName.focus();
					return;
				}
				if(jobNumber.search(/\W/g)!=-1 )
				{
					alert("岗位编号只能为数字、字母和下划线!");
					form.jobNumber.focus();
					return false;
				}
				if(jobRank.search(/[\\\/\|:\*\?<>"']/g)!=-1)
				{
					alert("岗位等级不能有\\/|:*?<>\"'!等特殊字符");
					form.jobRank.focus();
					return;
				}
				if(jobAmount.search(/[\\\/\|:\*\?<>"']/g)!=-1)
				{
					alert("岗位编制不能有\\/|:*?<>\"'!等特殊字符");
					form.jobAmount.focus();
					return;
				} 
		
				if(StringLength(jobName)>100)
				{
					alert("岗位名称过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobNumber)>100)
				{
					alert("岗位编号过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobRank)>100)
				{
					alert("岗位等级过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobAmount)>100)
				{
					alert("岗位编制过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobFunction)>100)
				{
					alert("岗位职责过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobDesc)>100)
				{
					alert("岗位描述过长,限制在100字符以内!");
					return;
				}
				if(StringLength(jobCondition)>100)
				{
					alert("岗位任职条件过长,限制在100字符以内!");
					return;
				}
				document.all.divProcessing.style.display = "block";
				
				document.all.Submit.disabled = true;
				document.all.Submit3.disabled = true;
			
			  	form.action = "modifyjob_do.jsp";
				form.target = "hiddenFrame";
				form.submit();
			}
						
			function back()
			{
				window.returnValue = true;
				window.close();
			}
			

	</script>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			<!--
			.style1 {color: #CC0000}
			-->
		</style>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  scroll="no">
		<div id="contentborder" align="center">
			
			<form action="form1" method="post">
				<pg:beaninfo requestKey="Job">
					<input name="jobId" type="hidden" value="<pg:cell colName="jobId" defaultValue=""/>">
					<table width="100%" height="85" border="0" cellpadding="0" cellspacing="1" class="thin">
					<input name="oldJobName" type="hidden" value="<%=oldJobName %>" />
					<input name="oldJobNumber" type="hidden" value="<%=oldJobNumber %>" />
						<tr>
							<td height="35" align=center colspan=5>
								<b>修改岗位信息</b>
							</td>
						</tr>

						<tr>
							<td class="detailtitle" height="35">
								岗位名称 <span class="style1">*</span>
							</td>
							<td class="detailcontent">
								<input name="jobName" type="text" size="40" maxlength="20" value='<pg:cell colName="jobName"  defaultValue=""/>'>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" height="35">
								岗位编号
							</td>
							<td class="detailcontent">
								<input name="jobNumber"  type="text" size="40" maxlength="20" value='<pg:cell colName="jobNumber"  defaultValue=""/>'>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" height="35">
								岗位等级
							</td>
							<td class="detailcontent">
								<input name="jobRank" type="text" size="40" maxlength="20" value='<pg:cell colName="jobRank"  defaultValue=""/>'>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" height="35">
								岗位编制
							</td>
							<td class="detailcontent">
								<input name="jobAmount" type="text" size="40" maxlength="20" value='<pg:cell colName="jobAmount"  defaultValue=""/>'>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" height="35">
								岗位职责
							</td>
							<td class="detailcontent">
								<textarea name="jobFunction" cols="50" rows="4"><%=jobFunction%></textarea>
							</td>
						</tr>

						<tr>
							<td class="detailtitle" height="35">
								岗位描述
							</td>
							<td class="detailcontent">
								<textarea name="jobDesc" cols="50" rows="4"><%=jobDesc%></textarea>
							</td>
						</tr>

						<tr>
							<td class="detailtitle" height="35">
								岗位任职条件
							</td>
							<td class="detailcontent">
								<textarea name="jobCondition" cols="50" rows="4"><%=jobCondition%></textarea>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" height="35">
								创建人信息
							</td>
							<td class="detailcontent">
								<input disabled=true name="creatorName" type="text" size="40" value='<%=userName%>【<%=userRealName%>】'>
							</td>
						</tr>
					</table>

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<table width="26%" border="0" align="center" cellpadding="0" cellspacing="0">

									<tr>
										<%if (!jobId.equals("0")) 
											{
										%>
										<%
												if (accessControl.checkPermission(jobId, "edit",AccessControl.JOB_RESOURCE)) 
												{
										%>
										<td>
											<div align="center">
												<input name="Submit" type="button" class="input" value="修改" onclick="updatejob()">
											</div>
										</td>
										<%
												}
										%>
										<td>
											<div align="center">
												<input name="Submit3" name="Submit3" type="button" class="input" value="返回" onclick="back()">
											</div>
										</td>
										<%
										}
										%>
									</tr>

								</table>
							</td>
						</tr>
					</table>
				</pg:beaninfo>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
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
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>

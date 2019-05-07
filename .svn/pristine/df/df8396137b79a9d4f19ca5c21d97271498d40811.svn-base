<%
/*
 * <p>Title: 用户任职人员查看页面</p>
 * <p>Description: 用户任职查看页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author baowen.liu
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl,
				 com.chinacreator.sysmgrcore.entity.Job,
				 com.chinacreator.sysmgrcore.manager.JobManager,
				 com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String jobId = request.getParameter("jobId");
	JobManager jobManager = SecurityDatabase.getJobManager();
	Job job = jobManager.getJobById(jobId);
	String jobName = job.getJobName();
	
	//在职查看
	String queryUserName = "";
	if(request.getParameter("userName")!=null){
		queryUserName = request.getParameter("userName");
	}
	String queryOrgName = "";
	if(request.getParameter("orgname") != null){
		queryOrgName = request.getParameter("orgname");
	}
	//历史查看
	String queryUser_Name = "";
	if(request.getParameter("user_Name") != null){
		queryUser_Name = request.getParameter("user_Name");
	}
	String queryOrg_Name = "";
	if(request.getParameter("org_name") != null){
		queryOrg_Name = request.getParameter("org_name");
	}
	
%>
<html >
<head>
   <title>用户任职情况</title>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">					
	<tab:tabConfig/>
	<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
	<script language="JavaScript" src="../pager.js" type="text/javascript"></script>
	<script language="javascript">
		
		//查询在职人员信息		
		function queryUser()
		{	
		    var username= document.userList.userName.value;
		    var orgname1=document.userList.orgname.value;
			var tablesFrame= document.getElementsByName("currentjob");
			//alert(tablesFrame[0].src);
			//if(document.userList.userName.value.length < 1 && document.userList.orgname.value.length < 1 ){
			//	alert("用户姓名和所在机构必须输入一个!!!");
			//	return;
			//}
			tablesFrame[0].src= "currentjob.jsp?jobId=<%=jobId%>&userName=" + username + "&orgname=" + orgname1;
			
		}
		
		//查询所有在职人员信息
		//function queryUserall()
		//{	
		 //   var tablesFrame= document.getElementsByName("currentjob");
			
		//	tablesFrame[0].src="currentjob.jsp?jobId=<%=jobId%>"
				
		//}
		
		//查询历史人员信息
		function queryUserHistory()
		{	
		    var username= document.userHistoryList.user_Name.value;
		    var orgname=document.userHistoryList.org_name.value;
		    var tablesFrame= document.getElementsByName("historyjob");
			//if(document.userHistoryList.user_Name.value.length < 1 && document.userHistoryList.org_name.value.length < 1 ){
			//	alert("用户姓名和所在机构必须输入一个!!!");
			//	return;
			//}
			tablesFrame[0].src= "historyjob.jsp?jobId=<%=jobId%>&user_Name=" + username + "&org_name=" + orgname;
		}
		
		//查询所有历史人员信息
		//function queryUserHistoryall()
		//{	
		//	var tablesFrame= document.getElementsByName("historyjob");
		//	tablesFrame[0].src="historyjob.jsp?jobId=<%=jobId%>"
		//}	
			
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
  <tab:tabContainer id="foo-job-container" selectedTabPaneId="job_foo">
	<tab:tabPane id="job_foo" tabTitle="在职查看" >
		<form name="userList" method="post" >
					<input name="jobId" value="<%=jobId%>" type="hidden">
					<table width=98% border="0" cellpadding="0" cellspacing="1" class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="6">&nbsp;<strong>【<%=jobName%>】在职情况列表</strong></td>
         				</tr>
         				<tr >
           					
           					<td height='30'valign='middle' align="left" colspan="5">
           					用户姓名：<input type="text" name="userName" value="<%=queryUserName%>" >&nbsp;&nbsp;&nbsp;&nbsp;
           					所在机构：<input type="text" name="orgname" value="<%=queryOrgName%>" >
           					</td>
                   <!--  <td height='30'valign='middle' align="center" colspan="2">所属岗位：<input type="text" name="jobname" >-->
                    <!-- </td>-->
           					<td height='30' valign='middle' align="left" >
           						<input name="search" type="button" class="input" value="查询" onClick="queryUser()">
           						<input name="search1" type="reset" class="input" value="清空" >
           				   </td>
           				 
           				</tr>
                          

		  </table>
		  
			<iframe name="currentjob" src="currentjob.jsp?jobId=<%=jobId%>" style="width:98%" height="70%" frameborder="0" marginwidth="1" marginheight="1"></iframe>
			
		  
	</form>
	</tab:tabPane>
	<!-- ---------------------------------------------------------------------------------------------------------- -->
	<tab:tabPane id="job_bar" tabTitle="历史职位查看">
		<form name="userHistoryList" method="post" >
					<input name="jobId" value="<%=jobId%>" type="hidden">
					<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="7">&nbsp;<strong>【<%=jobName%>】历史任职列表</strong></td>
         				</tr>
         				<tr >
           					
           					<td height='30'valign='middle' align="left" colspan="5" >
           					    用户姓名：<input type="text" name="user_Name" value="<%=queryUser_Name%>" >&nbsp;&nbsp;&nbsp;&nbsp;
							    所在机构：<input type="text" name="org_name" value="<%=queryOrg_Name%>" >
							</td>
							<td height='30'valign='middle' align="left" colspan="2">
           						<input name="search" type="button" class="input" value="查询" onClick="queryUserHistory()">
								<input name="search1" type="reset" class="input" value="清空" >           					
           					</td>
           				</tr>						
					</table>
				  
					  	<iframe name="historyjob" src="historyjob.jsp?jobId=<%=jobId%>" style="width:98%" height="70%" frameborder="0" marginwidth="1" marginheight="1"></iframe>
					
	  </form>
	</tab:tabPane>
</tab:tabContainer>

</body>
</html>

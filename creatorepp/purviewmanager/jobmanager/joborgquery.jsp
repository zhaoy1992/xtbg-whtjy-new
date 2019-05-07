<%
/*
 * <p>Title: 岗位所属机构查询</p>
 * <p>Description:岗位所属机构查询</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkManagerAccess(request,response);

		String jobId = request.getParameter("jobId");
		
		JobManager jm = SecurityDatabase.getJobManager();
		Job job = jm.getJobById(jobId);

		String orgName = request.getParameter("orgName");
		String orgnumber = request.getParameter("orgnumber");
		if (orgName == null) 
		{
			orgName = "";
		}
		
		if (orgnumber == null) 
		{
			orgnumber = "";
		}
%>
<html>
	<head>
		<TITLE>岗位隶属机构查询</TITLE>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>

		<script language="JavaScript">
		
			function sub()
			{
				var orgName = document.all("orgName").value;
				var orgnumber = document.all("orgnumber").value;
				var jobId = document.all("jobId").value;
				document.all.orgJobList.src="joborglist.jsp?orgName="+orgName+"&orgnumber="+orgnumber+"&jobId="+<%=jobId%>;
			}

			function userResList(orgId)
			{
				var url = "jobList_ajax.jsp?jobId=<%=jobId%>&orgId=" + orgId;
				//alert(url);
				window.showModalDialog(url,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
			}

			function resetForm()
			{
				document.all("orgName").value = "";
				document.all("orgnumber").value = "";
			}
		</script>	
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<form name="joborgForm" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<input type="hidden" name="jobId" value="<%=jobId%>" />
					<tr class="labeltable_middle_td">
						<td height='20' class="tablecells" align=center>
							机构名称:
							<input type="text" name="orgName" value="<%=orgName%>" />
						</td>
						<td height='20' class="tablecells" align=center>
							机构编号:
							<input type="text" name="orgnumber" value="<%=orgnumber%>" />
						</td>
						<td height='20' class="tablecells" align=center>
							<input name="search" type="button" class="input" value="查询" onClick="sub()">
							<input name="reset" type="button" class="input" value="清空" onClick="resetForm()">
							<input name="reset" type="button" class="input" value="返回" onClick="window.close();">
						</td>
					</tr>
				</table>
				<hr />
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<iframe width="100%" height=410px frameborder=0 noResize scrolling="false" marginWidth=0 name="orgJobList" src="joborglist.jsp?jobId=<%=jobId%>"></iframe>
				</table>
			</form>
		</div>
	</body>
</html>

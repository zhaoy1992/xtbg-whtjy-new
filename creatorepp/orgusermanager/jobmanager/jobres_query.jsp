<%
/*
 * <p>Title: ��ԴȨ�޲�ѯ</p>
 * <p>Description: ��ԴȨ�޲�ѯ</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.config.ResourceInfoQueue"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,
								 com.chinacreator.config.model.Operation,
								 com.chinacreator.resource.ResourceManager,
								 com.chinacreator.sysmgrcore.entity.Job,
								 com.chinacreator.sysmgrcore.manager.JobManager,
								 com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkManagerAccess(request,response);

String jobId = (String)request.getParameter("jobId");
JobManager jm = SecurityDatabase.getJobManager();
String jobName = null;
if(jobId != null && !jobId.equals("")){
	Job job = jm.getJobById(jobId);
	jobName = job.getJobName();
}

List resQueue = null;
ResourceManager resManager = new ResourceManager();
resQueue = resManager.getResourceInfos();
 for(int i = 0; i < resQueue.size(); i ++)
        {
			
            ResourceInfo res = (ResourceInfo)resQueue.get(i);
            if(!res.isUsed())
                continue;
            String listId = res.getId();
            String listName = res.getName();
            
            //if(listName.equals("��Դ����Դ")||listName.equals("�û���Դ")||listName.equals("�û�����Դ")||listName.equals("�ֵ���Դ"))
            	//resQueue.remove(i);
			
		 }

request.setAttribute("resList",resQueue);

%>

<html>
<head>    
 <title>��λ��<%=jobName%>����ԴȨ�޲�ѯ</title>
<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
 

function sub(){
	jobreslist.action="jobres_querylist.jsp";
	jobreslist.submit();
}

function getOperateType(id){

    getopergroup.location.href = "resChange.jsp?resTypeId="+id;

}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<link href="../css/treeview.css" rel="stylesheet" type="text/css">
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no">
<div id="contentborder" align="center">
	<form name = "jobreslist" method="post" target="forDocList">
	<input type="hidden" name="jobId" value="<%=jobId%>">
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
			
			<tr>
				<td height='20'>
					��Դ���ƣ�<input type="text" name="resName"/>
					��Դ��ʶ��<input type="text" name="resid"/>
				    <select class="select" name="resTypeId" onchange="getOperateType(this.options[this.selectedIndex].value)">
				      	<option value="">--��ѡ����Դ����--</option>
				      	<pg:list requestKey="resList" needClear="false">
					    	<option value="<pg:cell colName="id"/>">
					        	<pg:cell colName="name"/>
							</option>
						</pg:list>
					</select>
					<select class="select" name="opId" id="opId">
				      	<option value="">--��ѡ����Դ����--</option>
								
					</select>
				</td>
				<td>
					<input name="search" type="button" class="input" value="��ѯ" onClick="sub()">
					<input name="reset" type="reset" class="input" value="����">
				</td>
				</tr>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>

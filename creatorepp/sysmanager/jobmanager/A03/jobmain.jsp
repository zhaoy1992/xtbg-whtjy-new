<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.JobManager,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.entity.Job"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

JobManager jobManager = SecurityDatabase.getJobManager();
String selectedJobId = request.getParameter("jobId");
Job job = jobManager.getJobById(selectedJobId);
request.setAttribute("Job", job);

String oldJobName = job.getJobName();
String oldjobnumber = job.getJobNumber();

String jobId = request.getParameter("jobId");

%>
<html>
<head>

<title>ϵͳ����</title>
<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
<SCRIPT language="JavaScript" SRC="../sysmanager/scripts/validateForm.js"></SCRIPT>
<script language="JavaScript">
function updateAfter(){
getNavigatorContent().location.href ="../sysmanager/jobmanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session"; 
}

function deletejob(){
	if(window.confirm("��ȷ��Ҫɾ���˸�λ��(ɾ���󲻿ɻָ�)")){
		document.forms[0].target="updateJob";
		document.forms[0].action="delJob.jsp";
		document.forms[0].submit();
	}
}

 function trim(string){
  var temp="";
  string = ''+string;
  splitstring = string.split(" ");
  for(i=0;i<splitstring.length;i++){
    temp += splitstring[i];
  } 
  return temp;
 }

function updatejob(){
	var form = document.forms[0];
	var jobName= document.forms[0].jobName.value;
	var jobNumber=form.jobNumber.value;
	var jobRank=form.jobRank.value;
	var jobAmount=form.jobAmount.value;
	var jobFunction=form.jobFunction.value;
	var jobDesc=form.jobDesc.value;
	var jobCondition=form.jobCondition.value;
	if (trim(jobName).length == 0 ){
    alert("��¼���λ���ƣ�"); 
    return false;
    }
    if(jobName.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
		form.jobName.focus();
		return;
	}
	if(jobNumber.search(/\W/g)!=-1 ){
		alert("��λ���ֻ��Ϊ���֡���ĸ���»���!");
		form.jobNumber.focus();
		return false;
	}
	if(jobRank.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("��λ�ȼ�������\\/|:*?<>\"'!�������ַ�");
		form.jobRank.focus();
		return;
	}
	if(jobAmount.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
		form.jobAmount.focus();
		return;
	} 

	if(jobName.length>100)
	{
		alert("��λ���ƹ���,������100�ַ�����!");
		return;
	}
	if(jobNumber.length>100)
	{
		alert("��λ��Ź���,������100�ַ�����!");
		return;
	}
	if(jobRank.length>100)
	{
		alert("��λ�ȼ�����,������100�ַ�����!");
		return;
	}
	if(jobAmount.length>100)
	{
		alert("��λ���ƹ���,������100�ַ�����!");
		return;
	}
	if(jobFunction.length>200)
	{
		alert("��λְ�����,������200�ַ�����!");
		return;
	}
	if(jobDesc.length>200)
	{
		alert("��λ��������,������200�ַ�����!");
		return;
	}
	if(jobCondition.length>200)
	{
		alert("��λ��ְ��������,������200�ַ�����!");
		return;
	}
	form.target="updateJob";
	form.action="updateJob.jsp";
	form.submit();
	
}
function createjob()
{
	getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/addjob.jsp";   
}
	
function back()
	{
		document.forms[0].action="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobinfo.jsp?flag=1"; 
		document.forms[0].submit();  
	}
</script>
</head>

  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
  
  <%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
  <div id="contentborder" align="center">
  <br>
  

<form  action="form1" method="post"  >	
<pg:beaninfo requestKey="Job">
 		
<table width="100%" height="85" border="0" cellpadding="0" cellspacing="1" class="thin">
 <tr><td height="35" align=center colspan=5><P><B>��λ��Ϣ�鿴</B></P>
     </td></tr> 

  <tr>
    <td class="detailtitle" height="35">����λ���� <span class="style1">*</span></td>
    <td class="detailcontent">
    <input name="jobName" type="text" size="40" value="<pg:cell colName="jobName"  defaultValue=""/>"></td>
  </tr>
  <tr>
     <td class="detailtitle" height="35">����λ���</td>
     <td class="detailcontent"><input name="jobNumber" type="text" size="40"
				value="<pg:cell colName="jobNumber"  defaultValue=""/>"></td>
   </tr>
    <tr>
     <td class="detailtitle" height="35">����λ�ȼ�</td>
     <td class="detailcontent"><input name="jobRank" type="text" size="40"
				value="<pg:cell colName="jobRank"  defaultValue=""/>"></td>
   </tr>
    <tr>
     <td class="detailtitle" height="35">����λ����</td>
     <td class="detailcontent"><input name="jobAmount" type="text" size="40"
				value="<pg:cell colName="jobAmount"  defaultValue=""/>" ></td>
   </tr>
   <tr>
    <td class="detailtitle" height="35">����λְ��</td>
    <td class="detailcontent"><textarea name="jobFunction" cols="50" rows="4" defaultValue=""><pg:cell colName="jobFunction" defaultValue=""/></textarea></td>
   </tr>
   
   <tr>
    <td class="detailtitle" height="35">����λ����</td>
    <td class="detailcontent"><textarea name="jobDesc"  cols="50" rows="4" defaultValue=""><pg:cell colName="jobDesc" defaultValue=""/></textarea></td>
   </tr>
  
  
  <tr>
    <td class="detailtitle" height="35">����λ��ְ����</td>
    <td class="detailcontent"><textarea name="jobCondition" cols="50" rows="4" defaultValue=""><pg:cell colName="jobCondition"  defaultValue=""/></textarea></td>
  </tr>
  <tr>    
    <td class="detailcontent">
    	<input name="jobId"  type="hidden" value="<pg:cell colName="jobId"  defaultValue=""/>">
    	<input name="oldjobname" type="hidden" value="<%=oldJobName%>" />
    	<input name="oldjobnumber" type="hidden" value="<%=oldjobnumber%>" />
    </td>
    <td>&nbsp;</td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
    <td><table width="35%" border="0" align="right" cellpadding="0" cellspacing="0" >
    
        <tr>
	       <%if(!jobId.equals("0")){ %> 
	       <%
		   if (accessControl.checkPermission(jobId,
	       		"edit", AccessControl.JOB_RESOURCE))
	       {%>
          <td><div align="center">
              
              <pg:notequal colName="jobId" value="1">
					<input name="Submit" type="button" class="input" value="�޸�" onclick="updatejob()">  						
				</pg:notequal>
				
				<pg:equal colName="jobId" value="1">
					<input name="Submit" type="button" class="input" value="�޸�" onclick="updatejob()" disabled="disabled">				
				</pg:equal>   
          </div></td>
          <%}%>
          <%
		  if (accessControl.checkPermission(jobId,
	      		"delete", AccessControl.JOB_RESOURCE))
	      {%>
          <td>
	          <div align="center">
	             <pg:notequal colName="jobId" value="1">
					<input name="Submit2" type="button" class="input" value="ɾ��" onclick="deletejob()">  						
				</pg:notequal>
				
				<pg:equal colName="jobId" value="1">
					<input name="Submit2" type="button" class="input" value="ɾ��" onclick="deletejob()" disabled="disabled">  					
				</pg:equal>      
			  </div>
		  </td>
		  <%}%>
		  <td>
	          <div align="center">
	             <input name="Submit3" type="button" class="input" value="����" onclick="back()">        
			  </div>
		  </td>
         <%}%>     
        </tr>
      
    </table></td>
  </tr>
</table>
</pg:beaninfo>

</form>
<iframe name="updateJob" width="0" height="0"></iframe>
</div>
</body>
</html>
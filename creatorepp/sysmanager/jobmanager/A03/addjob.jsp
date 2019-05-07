<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job,
			com.chinacreator.security.AccessControl,
			com.chinacreator.sysmgrcore.manager.SecurityDatabase,
			com.chinacreator.sysmgrcore.manager.JobManager" %>
<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	String fromtype = request.getParameter("fromtype") == null?"":request.getParameter("fromtype");
	
	String jobId = request.getParameter("jobId");
	if(jobId != null){
		JobManager jobManager = SecurityDatabase.getJobManager();
		Job job = jobManager.getJobById(jobId);
		request.setAttribute("jobForm",job);
	}
	
	String status = request.getParameter("status");
	String orgId = request.getParameter("orgId");
	String isJobExist = "false";
	if ( request.getAttribute("isJobExist") != null){
		isJobExist = "true";
	}
	String isJobNumber = "false";
	if ( request.getAttribute("isJobNumber") != null){
		isJobNumber = "true";
	}
	
%><head>
<title>ϵͳ����</title>
<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
<link href="../../css/windows.css" rel="stylesheet" type="text/css">
<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
</head>
<html:html>
<SCRIPT LANGUAGE="JavaScript"> 

	var isJobExist = "<%=isJobExist%>";
	var isJobNumber = "<%=isJobNumber%>";
	var status = "<%=status%>";
	
	function trim(string){
	  var temp="";
	  string = ''+string;
	  splitstring = string.split(" ");
	  for(i=0;i<splitstring.length;i++){
	    temp += splitstring[i];
	  } 
	  return temp;
	}
	
	if ( isJobExist == "true" || isJobNumber == "true" ){
		alert("��λ���ƻ��λ����Ѵ��ڣ�����������!");
	}
	
	if (status == "ok"){
		alert("�����ɹ���");
		window.dialogArguments.parent.document.location.href = window.dialogArguments.parent.document.location.href;
		window.close();
	}
	
	function savejob() {
				var form = document.forms[0];
				var jobname=form.jobName.value;
				var jobNumber=form.jobNumber.value;
				var jobRank=form.jobRank.value;
				var jobAmount=form.jobAmount.value;
				var jobFunction=form.jobFunction.value;
				var jobDesc=form.jobDesc.value;
				var jobCondition=form.jobCondition.value;
				if (trim(jobname).length == 0 ){
			    alert("��¼���λ���ƣ�"); 
			    return false;
			    } 
			    if(jobname.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("��λ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
					form.jobname.focus();
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
				
				if(jobname.length>100)
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
			    
				var fromtype = "<%=fromtype%>";
				var form = document.forms[0];
				form.target = "addjob";
				form.action = "saveJob.jsp";
				form.submit();
			}
			
		function back()
		{
			var fromtype = "<%=fromtype%>";
			if(fromtype != "")
			{
				window.close();
			}
			else
			{
				document.forms[0].action="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobinfo.jsp"; 
				document.forms[0].submit();  
			}
		}
</SCRIPT>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder" align="center">
<form action="" name="jobform" method="post">  
<pg:beaninfo requestKey="jobForm">
<input type="hidden" name="fromtype" value="<%=fromtype%>">
<input type="hidden" name="orgId" value="<%=orgId%>">
<table width="100%" height="223" border="0" align="center" cellpadding="0" cellspacing="1" class="thin">
  <tr>
    <td height="35" align=center colspan=5><b>������λ</b></td>
  </tr>
  <tr>
    <td width="" height="35" class="detailtitle"> ��λ���� <span class="style1">*</span></td>
    <td width="" class="detailcontent">
    	<input name="jobName" value='<pg:cell colName="jobName" defaultValue="" />' type="text" />
    </td>
  </tr>
  <tr>
    <td height="35" class="detailtitle"> ��λ��� </td>
    <td class="detailcontent">
    	<input name="jobNumber" value='<pg:cell colName="jobNumber" defaultValue="" />' type="text" size="40" />
	</td>
  </tr>
   <tr>
    <td height="35" class="detailtitle"> ��λ�ȼ� </td>
    <td class="detailcontent">
    	<input name="jobRank" value='<pg:cell colName="jobRank" defaultValue="" />' type="text" size="40" />
    </td>
  </tr>
   <tr>
    <td height="35" class="detailtitle"> ��λ���� </td>
    <td class="detailcontent">
    	<input name="jobAmount" value='<pg:cell colName="jobAmount" defaultValue="" />' type="text" size="40" />
    </td>
  </tr>
  <tr>
    <td height="34" class="detailtitle"> ��λְ�� </td>
    <td class="detailcontent">
    	<textarea cols="50" rows="4" name="jobFunction"><pg:cell colName="jobFunction" defaultValue="" /></textarea>
    </td>
  </tr>
  <tr>
    <td height="35" class="detailtitle"> ��λ���� </td>
    <td class="detailcontent">
    	<textarea cols="50" rows="4" name="jobDesc"><pg:cell colName="jobDesc" defaultValue="" /></textarea>
    </td>
  </tr>
  <tr>
    <td height="35" class="detailtitle"> ��λ��ְ���� </td>
    <td class="detailcontent">
    	<textarea cols="50" rows="4" name="jobCondition"><pg:cell colName="jobCondition" defaultValue="" /></textarea>
    </td>
     </tr>
  <div align="center">
    <table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td>
	        <div align="center">
	            <input name="Submit" type="button" class="input" value="����" onClick="savejob()">
	        </div>
        </td>
        <td>
	        <div align="left">
	         <html:reset styleClass="input" value="����" /> 
	        </div>
        </td>
        <td>
	        <div align="left"> 
	        	<input name="Submit" type="button" class="input" value="����" onClick="back()"> 
	        </div>
        </td>
      </tr>
    </table>
  </div>
</table>
</form>
</pg:beaninfo>
<iframe name="addjob" width="0" height="0"></iframe>
<p>&nbsp;</p>
</div>
</body>
</html:html>

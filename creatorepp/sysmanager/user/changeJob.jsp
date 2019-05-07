
<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
	JobManager jobManager = SecurityDatabase.getJobManager();
	Job noJob = jobManager.getJobById("1");
	String jobName = "";
	String jobid = "";
	if(noJob != null){
		jobid = noJob.getJobId();
		jobName = noJob.getJobName();
	}
	Integer userId = (Integer) session.getAttribute("currUserId");
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId.toString());
%>
<html>
<head>    
  <title>��������</title>
<SCRIPT LANGUAGE="JavaScript"> 
function addjob(){	
   var n=document.all("jobId").options.length-1;	 	
   for(var i=0;i<document.all("allist").options.length;i++){
   var op=document.all("allist").options[i];
   if(op.selected)
   addone(op.text,op.value,n);
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
function deleteall(){
	for (var m=document.all("jobId").options.length-1;m>=0;m--)
    document.all("jobId").options[m]=null;
    //�Զ���Ӵ���
    var op=new Option("<%=jobName%>","<%=jobid%>");
   	document.all("jobId").add(op);
}
      
function addall(){
	var n=document.all("jobId").options.length-1;
	var p=document.all("allist").options.length-1;		  
     for(var i=0;i<document.all("allist").options.length;i++){
     var op=document.all("allist").options[i];
     addone(op.text,op.value,n);  
   }
}
function deletejob(){
	var l=document.all("jobId").options.length;	
	//û�и�λ�˾���Ӵ���
	if(l ==1){
		var op=new Option("<%=jobName%>","<%=jobid%>");
   		document.all("jobId").add(op);
	}
	
	//��������Ҫһ����λ
	//if(l == 1){
	  // 	alert("����Ҫ��һ����λ");
	   //	return;
     //}
 for (var m=document.all("jobId").options.length-1;m>=0;m--)
	     
	      if(document.all("jobId").options[m].selected)
         document.all("jobId").options[m]=null;
}
function okadd(){
var len=document.all("jobId").options.length;
	for (var i=0;i<len;i++){	      
         document.all("jobId").options[i].selected="true";
         }
         document.forms[0].action="../user/userJob.do?method=storeUserJob";
         document.forms[0].submit();
}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
<center>
<form name="OrgJobForm" action="" method="post" >
<table width="80%" border="0" cellpadding="0" cellspacing="1">
<tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">���������λ</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center"><%=user.getUserRealname()%>(<%=user.getUserName()%>)�������λ</td>
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    <td width="20%" align="center">&nbsp;</td>
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr >
     <td align="right" >
     <select name="allist"  multiple style="width:80%" onDBLclick="addjob()" size="18">
				  <pg:list requestKey="allJob">
					<option value="<pg:cell colName="jobId"/>"><pg:cell colName="jobName"/></option>
				  </pg:list>			
	</select>
	</td>				  
		  	
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onClick="addjob()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onClick="addall()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onClick="deleteall()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onClick="deletejob()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
    </table></td>
    <td >
     <select name="jobId"  multiple style="width:80%" onDBLclick="deletejob()" size="18">
				  <pg:list requestKey="existJob">
					<option value="<pg:cell colName="jobId"/>"><pg:cell colName="jobName"/></option>
				  </pg:list>			
	 </select>				
					
	</td>				 
				  
  </tr>
  <tr class="tabletop">
    
    <td width="40%" align="center">&nbsp;</td>
  </tr>
  <tr><td colspan="3" align="center">
  <input name="add" type="button" class="input" value="ȷ��" onClick="okadd()" >
  
  </td> </tr>
</table>
<pg:beaninfo requestKey="userJobForm">
<input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>"/>
<input type="hidden"  name="uid" value="<pg:cell colName="userId"  defaultValue=""/>"/>
</pg:beaninfo>
</form>
</center>
</div>
<%@ include file="../sysMsg.jsp"%>
</body>
</html>

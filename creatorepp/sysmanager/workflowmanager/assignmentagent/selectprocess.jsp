<%@ page language="java" contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
           <title>ί������</title>
    <script language="JavaScript" src="../../scripts/selectTime.js" type="text/javascript"></script>
      <link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.util.StringUtil,java.util.Date"%>
  <%
    String procDefId=request.getParameter("procDefId");
    String procDefName=request.getParameter("procDefName");
       System.out.println("procDefName"+procDefName);
       System.out.println("procDefId"+procDefId);
       AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();
			 Date date = new Date();
	 String dateStr = StringUtil.getFormatDate(date,"yyyy-MM-dd HH:mm:ss");
    %>  
<script language="JavaScript">
	function adduser(){	    	

	  window.open('<%=request.getContextPath()%>/sysmanager/schedularmanage/orgtwouser.jsp?displayNameInput=agentName&displayValueInput=agentID','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
	}
function validateForm(){	

   if(document.all("agentname").value.length<1){
   		alert("��ѡ����Ա��");
   		return;
   }  
   
    if(document.all("startTime").value.length<1){
   		alert("��ѡ����ʼʱ�䣡");
   		return;
   }   
 
    if(document.all("endTime").value.length<1){
   		alert("��ѡ�����ʱ�䣡");
   		return;
   		}
     
 	if(document.all.item("startTime").value > document.all.item("endTime").value)
   	{
	   	alert("����ʱ����������ʼʱ��");
	   	return;
   	}
   	if(document.all.item("endTime").value < "<%=dateStr%>")
		{
			alert("ί�н���ʱ�䲻��С�ڵ�ǰʱ��");
    		return;
    	}
      
   document.devolveForm.action="<%=request.getContextPath()%>/sysmanager/workflowmanager/assignmentagent/assignmentdevolve.do?method=AssignmentDevolve";
   document.devolveForm.submit();
}

</script>
      
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body >
    <form name="devolveForm" method="post">
<table width="100%" border="0">
  <tr> 
    <td class="detailtitle">ί������</td>
    <td>
    <input type="text" name="procDefName" value="<%=procDefName%>" readonly="true">
    <input type="hidden" name="procDefId" value="<%=procDefId%>"></td>
    <td class="detailtitle">ָ��������</td>
    <td>
       <input name="agentId" type="hidden" >
	   	<input name="agentName" type="text"  readonly="true">
				<input type="button" value="ѡ������" onclick="adduser()">
				<input type="hidden" value="<%=userId%>" name="clientId">
   </td>
  </tr>
  <tr> 
    <td class="detailtitle">ί�����ڴ�</td>
    <td>	<input name="startTime" id="startTime" readonly="true" type="text">
							<INPUT type="button" value="ʱ��" onclick="selectTime('devolveForm.startTime',0)"></td>
    <td class="detailtitle">ί�����ڵ�</td>
    <td><input name="endTime" id="endTime" readonly="true" type="text">
							<INPUT type="button" value="ʱ��" onclick="selectTime('devolveForm.endTime',0)"></td>
  </tr>
  <tr align="center"> 
    <td colspan="4"><input type="button" name="Submit" value="�ύ" onclick="validateForm()">
      <input type="reset" name="Submit2" value="����"></td>
  </tr>
</table>
</form>
  </body>
</html>

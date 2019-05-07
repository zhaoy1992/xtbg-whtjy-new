<%@ page language="java" contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
           <title>委托流程</title>
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
   		alert("请选择人员！");
   		return;
   }  
   
    if(document.all("startTime").value.length<1){
   		alert("请选择起始时间！");
   		return;
   }   
 
    if(document.all("endTime").value.length<1){
   		alert("请选择结束时间！");
   		return;
   		}
     
 	if(document.all.item("startTime").value > document.all.item("endTime").value)
   	{
	   	alert("结束时间必须大于起始时间");
	   	return;
   	}
   	if(document.all.item("endTime").value < "<%=dateStr%>")
		{
			alert("委托结束时间不能小于当前时间");
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
    <td class="detailtitle">委托流程</td>
    <td>
    <input type="text" name="procDefName" value="<%=procDefName%>" readonly="true">
    <input type="hidden" name="procDefId" value="<%=procDefId%>"></td>
    <td class="detailtitle">指定代理人</td>
    <td>
       <input name="agentId" type="hidden" >
	   	<input name="agentName" type="text"  readonly="true">
				<input type="button" value="选安排人" onclick="adduser()">
				<input type="hidden" value="<%=userId%>" name="clientId">
   </td>
  </tr>
  <tr> 
    <td class="detailtitle">委托日期从</td>
    <td>	<input name="startTime" id="startTime" readonly="true" type="text">
							<INPUT type="button" value="时间" onclick="selectTime('devolveForm.startTime',0)"></td>
    <td class="detailtitle">委托日期到</td>
    <td><input name="endTime" id="endTime" readonly="true" type="text">
							<INPUT type="button" value="时间" onclick="selectTime('devolveForm.endTime',0)"></td>
  </tr>
  <tr align="center"> 
    <td colspan="4"><input type="button" name="Submit" value="提交" onclick="validateForm()">
      <input type="reset" name="Submit2" value="重置"></td>
  </tr>
</table>
</form>
  </body>
</html>

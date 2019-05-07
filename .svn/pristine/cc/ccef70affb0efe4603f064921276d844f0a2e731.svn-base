<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%	        AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();
	        Date date = new Date();
	        String dateStr = StringUtil.getFormatDate(date,"yyyy-MM-dd HH:mm:ss");
	
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/schedularmanage/My97DatePicker/WdatePicker.js" ></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo4</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {
	font-size: medium;
	font-family: Tahoma, Verdana, Arial, Helvetica;
}
-->
        </style>
</head>

<script language="JavaScript">
	function goBack(){	
		document.location.href="<%=rootpath%>/sysmanager/schedularmanage/noticList.jsp";
	}
	function adduser(){	    	
	    	window.open('<%=rootpath%>/sysmanager/schedularmanage/org2user.jsp?displayNameInput=executorName&displayValueInput=executors','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
	}	
	
	function submitSD(){
	
	     
	    if(document.all.item("topic").value == "" )
		{
			alert("请填写主题!!!");
			return;
		}
		
		if(document.all.item("beginTime").value >= document.all.item("endTime").value)
		{
			alert("开始时间大于结束时间");
    		return;
    	}
    	if(document.all.item("beginTime").value <= "<%=dateStr%>")
		{
			alert("开始时间小于当前时间");
    		return;
    	}
    	else
		{
			document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/notic.do?method=addNotic";
		}
		document.forms[0].submit();	
	}	
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info" scrolling="no">

		<form name="noticForm" method="post" action="">
			<input type="hidden" name="plannerID" value="<%=userId%>" >
			<p align="center" class="detailtitle style2"><strong><br>
		    增加通知</strong></p>
			<pg:beaninfo requestKey="notic">
			
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2">
				<tr>
					<td height="25" class="detailtitle" width="25%"><strong> 开始时间</strong></td>					
			    	<td height="25" width="25%">
					<input type="text" name="beginTime"  value="<pg:cell colName="beginTime"  defaultValue=""/>" 
					onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					<!--<INPUT type="button" value="Time" onclick="selectTime('noticForm.beginTime',0)">
					--></td>

					<td height="25" class="detailtitle" width="25%"><strong> 结束时间</strong></td>
					<td height="25" width="25%">
					<input type="text" name="endTime"  value="<pg:cell colName="endTime"  defaultValue=""/>" 
					onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					<!--<INPUT type="button" value="Time" onclick="selectTime('noticForm.endTime',0)">
					--></td>
					<td>&nbsp; </td>
				</tr>	
				<tr>
					<td height="25" class="detailtitle" width="25%"><strong> 主题</strong></td>
					<td height="25" width="25%">
					<input type="text" name="topic"  value="<pg:cell colName="topic"  defaultValue=""/>" >
					</td>
					<td height="25" class="detailtitle" width="25%"><strong> 地点</strong></td>
					<td height="25" width="25%">
					<input type="text" name="place"  value="<pg:cell colName="place"  defaultValue=""/>" >
					</td>
					
					<td>&nbsp; </td>
				</tr>	
				<tr>
					<td height="25" class="detailtitle" width="25%"><strong> 通知来源</strong></td>
					<td height="25" width="25%">
					<input type="text" name="source"  value="<pg:cell colName="source"  defaultValue=""/>" >
					</td>
					
					<td>&nbsp; </td>
				</tr>
				<tr>
					<td height="25" class="detailtitle" width="25%"><strong> 通知内容</strong></td>
					<td height="25" width="25%">
					<TEXTAREA cols="30" name="content" rows="6"><pg:cell colName="content"  defaultValue=""/></TEXTAREA>
					</td>
					<td> </td>
				</tr>				
				<tr>
					<td height="23" class="detailtitle" width="20%">
							<strong> 通知执行人</strong>
						</td>

						<td height="23" width="20%">
							<input name="executors" type="hidden" value="<pg:cell colName="executors"  defaultValue=""/>">
							<textarea name="executorName" cols="30" rows="6" value="<pg:cell colName="executorName"  defaultValue=""/>" readonly="true">
							</textarea>
							<INPUT type="button" value="选执行人" onclick="adduser()">
						</td>
					</tr>
		    </table>
			</pg:beaninfo>
		</form>

		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<INPUT type="button"  value="提交" onclick="submitSD()">				
					<INPUT type="button" value="返回" onclick="goBack()">
				</td>
			</tr>
		</table>
			<%@include file="sysMsg.jsp" %>
	</body>
</html>
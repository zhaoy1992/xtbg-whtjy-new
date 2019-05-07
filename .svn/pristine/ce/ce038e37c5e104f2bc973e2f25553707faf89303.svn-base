<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@page import="com.chinacreator.epp.message.dbmanager.MessageResourceManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tabpane-taglib.tld" prefix="tab"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.message.dbmanager.UserMessageResourceManager,
                 com.chinacreator.epp.message.vo.MessageResource,
                 com.chinacreator.message.util.MessageTools,
                 com.chinacreator.message.factory.MessageDaoFactory"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String user_id = control.getUserID();
	String app_id = control.getCurrentSystemID();

	//	判断平台应用中短信是否启用
	boolean isSms = MessageTools.MessageisOpen("sms");
	//	判断平台应用中邮件是否启用
	boolean isSys = MessageTools.MessageisOpen("sys");
	//	判断平台应用中rtx是否启用
	boolean isRtx = MessageTools.MessageisOpen("rtx");

	boolean r_sms = false;
	boolean r_sys = false;
	boolean r_rtx = false;

	String r_id = request.getParameter("r_id");
	String r_state = request.getParameter("r_state");
	System.err.println("#######################################"+r_state);
	UserMessageResourceManager userMessageResourceManager = new UserMessageResourceManager();
	MessageResource messageResource = userMessageResourceManager.getMessageResourceById(r_id, r_state, user_id);
	
	MessageResource messageResource_orl = new MessageResourceManager().getMessageResourceById(r_id);
	

    r_sms = "1".equals(messageResource.getR_sms()) ? true : false;
    r_sys = "1".equals(messageResource.getR_sys()) ? true : false;
    r_rtx = "1".equals(messageResource.getR_rtx()) ? true : false;
	
   	boolean r_sms_orl = "1".equals(messageResource_orl.getR_sms()) ? true : false;
    boolean r_sys_orl = "1".equals(messageResource_orl.getR_sys()) ? true : false;
    boolean r_rtx_orl = "1".equals(messageResource_orl.getR_rtx()) ? true : false;
    
    String [][] dictNoStr =MessageDaoFactory.getMessageDict().getDictNo();
    String userMsgTypes = messageResource.getR_sms();
    String userMsgTypes_or1 = messageResource_orl.getR_sms();
    
    
    

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>消息资源配置</title>
			<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/windows.css">
			<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/treeview.css">

		<SCRIPT LANGUAGE="JavaScript">
			var my_windowOpener = window.dialogArguments;  //把该窗口作为模态窗口打开时，从父窗口传过来的参数window。
			function editUserMessageResource() {
				if(validateFormValue())	{
					var form = document.forms[0];
					document.all.update.readonly = true;
					//document.all.divProcessing.style.display = "block";
				  	form.action = "editusermessageresource_do.jsp";
					form.target = "hiddenFrame";
					form.submit();
				}
			}

			function checkLength(e) {
				var elength = e.value.length;
				var v = e.value;
				if(elength >= 50) {
					e.value = v.substring(0,50);
				}
			}

			function validateFormValue() {

				var form = document.forms[0];

				var class_name = form.r_name.value;

				var remark = form.r_desc.value;

				if (class_name.length < 1 || class_name.replace(/\s/g,"")=="") {
					alert("请填写消息资源名称！");
					return false;
				}
				if(class_name.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("消息资源名称不能有\\/|:*?<>\"'!等特殊字符");
					return false;
				}
				if (remark.length < 1 || remark.replace(/\s/g,"")=="") {
					alert("请填写消息资源描述！");
					return false;
				}
				return true;
			}

</SCRIPT>
	</head>
<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<br>
			<br>
			<form method="post" name="messageResourceForm" action="addmessageresource_do.jsp">
				<input type=hidden name="r_id" value="<%=r_id %>"/>
				<input type=hidden name="r_state" value="<%=r_state %>"/>
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">用户消息资源名称<font color="red">*</font>：</td>
						<td height="25">
							<input type=text name="r_name" style="width=50%" maxlength="100" readonly
							 value="<%=messageResource.getR_name() %>"/>
						</td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">消息资源描述<font color="red">*</font>：</td>
						<td height="25">
							<textarea name="r_desc" rows="4" cols="40" rows="5" readonly onkeyup="checkLength(this)"><%=messageResource.getR_desc() %></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">消息管理配置<font color="red">*</font>：</td>
						<td height="25" class="detailtitle" align="left">
						
						
						<%
						boolean isOpen =false;
						boolean isUsed =false; //	是否使用
						boolean isUsed_or1= false;
						for(String[] no : dictNoStr){
							isOpen = MessageTools.MessageisOpen(no[0]);
							isUsed = userMsgTypes.indexOf(no[0])!=-1;
							isUsed_or1 = userMsgTypes_or1.indexOf(no[0])!=-1;
							if (isOpen && isUsed_or1) {
						%>
						<input type="checkbox" name="msgType" value="<%=no[0]%>" <%if (isUsed) {%>checked<%} %> />
						<%=no[1] %>
						<%
							} else {
						%>
						<input onclick="return false;"  style="background-color:#CCCCCC" type="checkbox" name="msgType" value="<%=no[0]%>" <%if (isUsed) {%>checked<%} %> />
						<%=no[1] %>
						<%
							}
						}
						%>

			
						</td>
					</tr>
			</table>
            <hr width="100%">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">
							<input name="update" type="button" onClick="editUserMessageResource()" class="input" value="保存">
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
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
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tabpane-taglib.tld" prefix="tab"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.message.dbmanager.MessageResourceManager,
                 com.chinacreator.epp.message.vo.MessageResource,
                 com.chinacreator.message.util.MessageTools,
                 com.chinacreator.message.factory.MessageDaoFactory
                 "%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String app_id = control.getCurrentSystemID();
	
	
	//	判断平台应用中短信是否启用
	boolean isSms = MessageTools.MessageisOpen("sms");
	//	判断平台应用中邮件是否启用
	boolean isSys = MessageTools.MessageisOpen("sys");
	//	判断平台应用中rtx是否启用
	boolean isRtx = MessageTools.MessageisOpen("rtx");

	boolean isEdit = false;
	if (request.getParameter("action")!=null&&request.getParameter("action").equals("edit")) {
	    isEdit = true;
	} else {
	    isEdit = false;
	}

	MessageResource messageResource = new MessageResource();
	boolean r_sms = false;
	boolean r_sys = false;
	boolean r_rtx = false;
	if (isEdit) {
		String r_id = request.getParameter("r_id");
		MessageResourceManager messageResourceManager = new MessageResourceManager();
	    messageResource = messageResourceManager.getMessageResourceById(r_id);
	    r_sms = "1".equals(messageResource.getR_sms()) ? true : false;
	    r_sys = "1".equals(messageResource.getR_sys()) ? true : false;
	    r_rtx = "1".equals(messageResource.getR_rtx()) ? true : false;
	}
%>
<html>
	<head>
	<script language="javascript">
      function keyDown() 
      { 
            if(event.keyCode==13) 
             { 
                  if(document.activeElement.name=='r_name')
                  {
                  	return false; 
                  }
                 
             } 
      } 

document.onkeydown=keyDown;
</script>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title><%if(isEdit){ %>
		              修改消息资源
		       <%}else{%>
		              新增消息资源
		       <%} %>
		</title>

<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">

		<SCRIPT LANGUAGE="JavaScript">
			var my_windowOpener = window.dialogArguments;  //把该窗口作为模态窗口打开时，从父窗口传过来的参数window。
			function saveMessageResource() {
				if(validateFormValue())	{
					var form = document.forms[0];
					document.all.update.readonly=true;
					//document.all.divProcessing.style.display = "block";
				  	form.action = "addmessageresource_do.jsp";
					form.target = "hiddenFrame";
					if(<%=isEdit%>) form.action = "addmessageresource_do.jsp?isEdit=true";
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
			
			function getL(remarksss){
			  var   valueLen   =   0;   
                  for   (i   =   0;   i   <   remarksss.length;   i   ++)   
                  {   
                          var   code   =   escape(remarksss.charAt(i));   
                          if   ((code.length   >=   4)   &&   (code   <   '%uFF60'   ||   code   >   '%uFF9F'))   
                          {   
                                  valueLen   +=   2;   
                          }   
                          else   
                          {   
                                  valueLen   ++;   
                          }   
                  }  
                  return valueLen;
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
				
				if(getL(class_name)>50){
					alert("资源名称长度不能超过50个字符(汉字占2个字符)");
					return false;
				}
         
				if(getL(remark)>50){
					alert("资源描述长度不能超过50个字符(汉字占2个字符)");
					return false;
				}
				
				var msgTypes = document.getElementsByName("msgType");
				var  flag = false;
				
				for(i=0;i<msgTypes.length;i++){
					if(msgTypes[i].checked)
					flag=true;
				}
				/*var r_sms = document.getElementById('r_sms');
				var r_sys = document.getElementById('r_sys');
				var r_rtx = document.getElementById('r_rtx');*/

				/*var r_sms_flag = !r_sms.getAttribute('onlyberead') && r_sms.checked;
				var r_sys_flag = !r_sys.getAttribute('onlyberead') && r_sys.checked;
				var r_rtx_flag = !r_rtx.getAttribute('onlyberead') && r_rtx.checked;*/

				if (!flag) {
					alert("请至少选择一种消息类型！");
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
				<input type=hidden name="r_id" value="<%=isEdit?messageResource.getR_id():"" %>"/>
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">消息资源名称<font color="red">*</font>：</td>
						<td height="25">
							<input type=text name="r_name" style="width=50%" maxlength="100"
							 <% if (isEdit) { %>readonly<% } %>
							 value="<%=isEdit?messageResource.getR_name():"" %>"/>
						</td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">消息资源描述<font color="red">*</font>：</td>
						<td height="25">
							<textarea name="r_desc" rows="4" cols="40" rows="5" onkeyup="checkLength(this)"><%=isEdit?messageResource.getR_desc():"" %></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">消息管理配置<font color="red">*</font>：</td>
						<td height="25" class="detailtitle" align="left">
						
						<%
						
						String [][] dictNoStr =MessageDaoFactory.getMessageDict().getDictNo();
						boolean isOpen =false; //	判断平台应用中是否启用
						boolean isUsed =false; //	是否使用
						for(String[] no : dictNoStr){
						isOpen= MessageTools.MessageisOpen(no[0]);
						if(isEdit){
							String myTypes = messageResource.getR_sms();
							isUsed = myTypes.indexOf(no[0])!=-1;
								if(isOpen){
						%>
						<input type="checkbox" id=<%=no[0]%>  name="msgType" value="<%=no[0]%>" <%if (isUsed) {%>checked<%} %> /><%=no[1]%>
						<% 
							    }else {
						%>
						<input onclick="return false;" id=<%=no[0]%> onlyberead=true style="background-color:#CCCCCC" type="checkbox" name="msgType" value="<%=no[0]%>" <%if (isUsed) {%>checked<%} %> /><%=no[1]%>
						<% 
							 
						  		}
						  	 }else if(isOpen){
						 %>
						 <input type="checkbox" id=<%=no[0]%>  name="msgType" value="<%=no[0]%>"  /><%=no[1]%>
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
							<input name="update" type="button" onClick="saveMessageResource()" class="input" value="保存">
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
	
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
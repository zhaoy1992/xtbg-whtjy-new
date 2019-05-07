<%@ page pageEncoding="GBK" import="com.chinacreator.message.Message
				,com.chinacreator.security.AccessControl
				,com.chinacreator.message.util.MsgConfig" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
	String app_id =	accesscontroler.getCurrentSystemID();
%>
<html>
  <head> 
    <title>新建邮件</title>
    <link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
    <script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
	var sysReciverLimit = <%=MsgConfig.getProperties("SYS_RECIVER_LIMIT") %>;

    function saveDraft(){
    	// 验证表单
		if (isSpace($('receiver_name').value)) {
			$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
			return;
		}
		if ($('receiver_name').value.length > sysReciverLimit) {
			$("returnnotify").innerHTML = "<font color=red>收件人太多，超过限制!!!</font>";
			return;
		}
		if (isSpace($('title').value)) {
			$("returnnotify").innerHTML = "<font color=red>主题必须填写!!!</font>";
			return;
		}

    	document.form1.action = "saveDraft.jsp";
    	document.form1.submit();
    }
    /*
    function saveDraft1(){
		var XmlHttp = new ActiveXObject("Microsoft.XMLHTTP")
    	var  SearchPageName="saveDraft.jsp";
		XmlHttp.open("POST",SearchPageName,false)
     	XmlHttp.setRequestHeader("Content-Type","text/xml");
	 	XmlHttp.send("");
	 	if(XmlHttp.responseText.indexOf("error")>=0){
	   		document.all.draftId.value="error";	 
	   		alert("保存草稿失败，请稍后再试！");  
	 	}else{
	 		document.all.draftId.value = XmlHttp.responseText.substring(XmlHttp.responseText.indexOf("<%@ include file="/epp/css/cssControl.jsp"%><body>")+6,XmlHttp.responseText.indexOf("</body>"));
	        alert("保存草稿成功！");
	 	}
	 	alert(document.all.draftId.value);
	}
	*/
    
    function goSend(){
    	// 验证表单
		if (isSpace($('receiver_name').value)) {
			$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
			return;
		}
		if ($('receiver_name').value.length > sysReciverLimit) {
			$("returnnotify").innerHTML = "<font color=red>收件人太多，超过限制!!!</font>";
			return;
		}
		if (isSpace($('title').value)) {
			$("returnnotify").innerHTML = "<font color=red>主题必须填写!!!</font>";
			return;
		}		

    	document.form1.action = "sendMessage.jsp";
    	document.form1.submit();
    }
    
    function isSpace(strMain) {
		var strComp = strMain;
		if (strComp=="　" || strComp=="" || strComp==" " || strComp==null || strComp=="null" || strComp.length==0 || typeof strMain == "undefined" || strMain == "undefined" ) {
			return true;
		}
		else {
			return false;
		}
	}
	
	function $() {
		var elements = new Array();
		
		for (var i = 0; i < arguments.length; i++) {
			var element = arguments[i];
			if (typeof element == 'string')
				element = document.getElementById(element);
			
			if (arguments.length == 1)
				return element;
			
			elements.push(element);
		}
	
		return elements;
	}
	function openMyTree(){
		  users=document.getElementById("receiver_name").value;
		
		  openWin('<%=request.getContextPath()%>/message/orgusertree.jsp?type=1&app_id=<%=app_id%>&email=true&users='+users,window,500,600);
	}
    </script>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body>
  <div class="over_div">
   <form name="form1" method="post">
   <!--  input type="hidden" name="content"/>
   <input type="hidden" name="receiver_id" value="1,"/>
   <input type="hidden" name="draftId" value=""/>-->
   <fieldset style="width:100%;height:100%;">
	<LEGEND align=center>
		<FONT size="2">站内邮件-->新建邮件</FONT>
	</LEGEND>
   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="total_tab">
   		<tr>
   			<td align="right">
   				<span style="float:left;margin-left:20px;" id="returnnotify"></span>
   				<input type="button" name="savecaogao" value="保存草稿" onclick="saveDraft()" class="button_bg"/>
   				<input type="button" name="save" value="发送" onclick="goSend()" class="button_bg"/>   			
   				<input type="reset" name="res" value="重置" class="button_bg"/>
   				<!-- input type="reset" name="go_back" value="返回" onclick="history.back()" class="button_bg"/> -->
   			</td>
   		</tr>
   </table>
   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list_tab">
   		<tr>
   			<td width="20%" align="center">收件人：</td>
   			<td width="80%">
   			<span id="recname" style="width:400px;height:20px;white-space:normal;word-break:break-all;border:1px solid #7F9DB9;font-size:12px;padding:2px;"></span>
			<textarea id="receiver_name" name="receiver_name" readonly="readonly" style="display:none;"></textarea>
			<textarea id="recnames" name="recnames" readonly="readonly" style="display:none;"></textarea>
			<img title="选择收件人" alt="选择收件人" src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_2.gif" style="cursor:hand" 
			onclick="openMyTree()" />
			</td>
   		</tr>
   		<tr>
   			<td align="center">主题：</td><td><input type="text" name="title" size="80" maxlength="<%=Math.abs(Integer.parseInt(MsgConfig.getProperties("RTX_TITLE_LIMIT")))>500?250:Math.abs(Integer.parseInt(MsgConfig.getProperties("SYS_TITLE_LIMIT")))/2%>" /></td>
   		</tr>
   		<tr>
			<td colspan="2">
				<div><textarea name="content" style="display:none"></textarea>
					<IFRAME ID="eWebEditor1" src="<%=request.getContextPath()%>/message/eWebEditor/ewebeditor.htm?id=content&style=blue&cusdir=a/b" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>
				</div>
			</td>
		</tr>
  </table>
  </fieldset>
  </form>
  </div>
  </body>
</html>
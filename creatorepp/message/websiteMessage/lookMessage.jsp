<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.message.website.WebsiteMessageBusiness,com.chinacreator.message.website.WebsiteMessageForm,
				 com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
	String app_id =	accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
    <%
    String box = request.getParameter("box");   
    String home = request.getParameter("home");
    String reply = request.getParameter("reply");
    String id = request.getParameter("id");
    String mode = "VIEW";
    if(reply!=null && reply.equals("reply") || box!=null && box.equals("nosend_box")){
    	mode = "EDIT";
    }
    %>
    <title>查看来信</title>
    <script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">    
   	function reply_message1(){
   		// 验证表单
		if (isSpace($('receiver_name').value)) {
			$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
			return;
		}
		if (isSpace($('title').value)) {
			$("returnnotify").innerHTML = "<font color=red>主题必须填写!!!</font>";
			return;
		}

   		document.form1.reply.value ="reply";
   		document.action = "";
   		document.form1.submit();
   	}    	 
    
    function saveDraft(){
    	// 验证表单
		if (isSpace($('receiver_name').value)) {
			$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
			return;
		}
		if (isSpace($('title').value)) {
			$("returnnotify").innerHTML = "<font color=red>主题必须填写!!!</font>";
			return;
		}
    	document.form1.action = "saveDraft.jsp";
    	document.form1.submit();
    }

    function goSend(){
    	// 验证表单
		if (isSpace($('receiver_name').value)) {
			$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
			return;
		}
		if (isSpace($('title').value)) {
			$("returnnotify").innerHTML = "<font color=red>主题必须填写!!!</font>";
			return;
		}
    	document.form1.action = "sendMessage.jsp";
    	document.form1.submit();
    }
    
    function go_back(){    	
    	window.location.href="showMessage.jsp?box=<%=box%>";
    }
    
    function setView1(mode){ 	    	
    	eWebEditor2.setMode(mode);
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
	
	function openMyTree(){
		  users=document.getElementById("receiver_name").value;
		
		  openWin('<%=request.getContextPath()%>/message/orgusertree.jsp?type=1&app_id=<%=app_id%>&email=true&users='+users,window,500,600);
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
    </script>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body scroll="no" onload="setView1('<%=mode%>')">
  <div class="over_div">
   <%

   WebsiteMessageBusiness messageBusiness = new WebsiteMessageBusiness();
   WebsiteMessageForm form = new WebsiteMessageForm();
   form = messageBusiness.getMessage(id,box);
   
   String title = form.getTitle();
   String content = form.getContent();
   String sender_id = form.getSender_id();
   String sender_name = form.getSender_name();
   String receiver_id = form.getReceiver_id();
   String receiver_name = form.getReceiver_name();
   String send_time = form.getSend_time();
   String isread = form.getIsread();
   if(isread!=null && isread.equals("未读")){
   		boolean flag = messageBusiness.update_isread(id);
   		//System.out.println("update_isread result:"+flag);
   }
   
   StringBuffer stringBuffer = new StringBuffer();
   if(reply!=null && reply.equals("reply")){
   		stringBuffer.append("<br><br><br><br><br><br><br><br><br><br><br>");
   }
   stringBuffer.append(content);
   stringBuffer.append("<br><br>_______________________________<br><br>");
   stringBuffer.append(sender_name);
   stringBuffer.append("<br>");
   stringBuffer.append(send_time);
   content = stringBuffer.toString();   
   
   if(reply!=null && reply.equals("reply")){
   		title = "Re:"+title;
   		String temp_id = sender_id;
   		String temp_name = sender_name;
   		sender_id = receiver_id;
  		sender_name = receiver_name;
   		receiver_id = temp_id;
   		receiver_name = temp_name;
   		receiver_id = SecurityDatabase.getUserManager().getUserById(receiver_id).getUserName();
   		send_time = "";  
   }
   %>
   	<form name="form1" method="post" action="">
   	<input type="hidden" name="id" value="<%=id%>"/>
	<input type="hidden" name="box" value="<%=box%>"/>
	<input type="hidden" name="sender_id" value="<%=sender_id%>"/>
	<input type="hidden" name="receiver_id" value="<%=receiver_id%>"/>
	<input type="hidden" name="reply" value=""/>
	<fieldset style="width:100%;height:100%;">
	<LEGEND align=center>
		<FONT size="2">站内邮件-->查看邮件</FONT>
	</LEGEND>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="total_tab">
   		<tr><td align="right"><div align="left" id="returnnotify"></div>  					
   			<%if(reply!=null && reply.equals("reply")){%>
   				<input type="button" name="savecaogao" value="保存草稿" onclick="saveDraft()" class="button_bg"/>
   				<input type="button" name="save" value="发送" onclick="goSend()" class="button_bg"/>
   			<%}else if(box!=null && (box.equals("receive_box") || box.equals("receive_deleted_box"))){%>
   				<!-- a href="javascript:reply_message()" class="button_bg"><font color="#FFFFFF">回复&nbsp&nbsp</font></a-->
   				<input type="button" name="reply_message" value="回复" onclick="reply_message1()" class="button_bg"/>
   			<%}else if(box!=null && box.equals("nosend_box")){%>
   				<input type="button" name="savecaogao" value="保存草稿" onclick="saveDraft()" class="button_bg"/>
   				<input type="button" name="save" value="发送" onclick="goSend()" class="button_bg"/>
   			<%}else if(box!=null && box.equals("send_box")){%>
   				<input type="button" name="savecaogao" value="保存草稿" onclick="saveDraft()" class="button_bg"/>   				
   			<%}%>   			 
   			<input type="button" name="go_backButton" value="返回" onclick="go_back()" class="button_bg"/>
   			</td>
   		</tr>
   </table>
   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list_tab">
   		<tr>
   			<td width="20%" align="center">发件人：</td>
   			<td width="80%"><input type = "text" name = "sender_id" value="<%=sender_name%>" readonly/>
   			<input type = "text" name = "sender_name" value="<%=sender_id%>" readonly  style="display:none" />
   			</td>
   		</tr>
   		<tr>
   			<td width="20%" align="center">收件人：</td>
   			<td width="80%"><textarea id="recnames" name="recnames" readonly="readonly" cols="60" rows="1"><%=receiver_name%></textarea>
   			<textarea id="receiver_name" name="receiver_name" readonly="readonly" cols="60" rows="1" style="display:none"><%=receiver_id%></textarea>
   			<%if(box!=null && box.equals("nosend_box")){%>
			<img title="选择收件人" alt="选择收件人" src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_2.gif" style="cursor:hand" 
			onclick="openMyTree();" />
			<%}%></td>
   		</tr>
   		<tr>
   			<td align="center">主题：</td><td><input type="text" name="title" size="80" value="<%=title%>"
   			<%if(box!=null && (box.equals("receive_box") && (reply==null || reply.equals(""))) || (box.equals("receive_deleted_box") && (reply==null || reply.equals(""))) || box.equals("send_box")){%> readonly<%} %>/></td>
   		</tr>
   		<tr>
   			<td align="center"><%if(box.equals("nosend_box")){%>保存时间:<%}else{%>发送时间：<%}%></td>
   			<td><textarea name="content" style="display:none"><%=content%></textarea><input type="text" name="send_time" size="80" value="<%=send_time%>" readonly/></td>
   		</tr>
   		<tr>
			<td colspan="2">
				<div>
					<IFRAME ID="eWebEditor2" src="<%=request.getContextPath()%>/message/eWebEditor/ewebeditor.htm?id=content&style=blue&cusdir=a/b" frameborder="0" scrolling="no" width="100%" height="380"></IFRAME>
				</div>
			</td>
		</tr>			
  </table>
  </fieldset>
  </form>
  </div>
  </body>
</html>

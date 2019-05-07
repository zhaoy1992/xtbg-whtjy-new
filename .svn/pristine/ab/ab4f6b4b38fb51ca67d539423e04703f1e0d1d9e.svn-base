<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%--
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
--%>

<html>
	<head>
	<title>机构用户树</title>

	<link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">

	<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/sysmanager/scripts/validateForm.js"></SCRIPT>
	<script language="javascript" type="text/javascript"> 
	//应用ID
	<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String app_id =	control.getCurrentSystemID();
		

		String type = request.getParameter("type");

	%>

	var app_id = "<%=app_id%>";	

	var http_request_account = false;
	var flag = true;
		
	//关闭模态窗口并刷新父页面
	function winClose(){
		window.close();
		window.returnValue="refresh";
	}
	
	function getReceivers() {		
		var receivers = document.getElementsByName('orguser');
		var len = receivers.length;
		var recistr = "";

		for (var i=0; i<len; i++) {
			if (receivers[i].checked && (receivers[i].value.indexOf("user")!=-1)) {
				var temp = receivers[i].value.substring(receivers[i].value.indexOf("/")+1, 
							receivers[i].value.length);				
				recistr += temp + ",";
			}
		}
		
		if (recistr != null && recistr != "") {
			convert(recistr.substring(0, recistr.length-1));			
		}
	}
	
	function convert(ids) {
		<%if(type!=null && type.equals("1")) {%>
		var url = "uidtounameajax.jsp?ids=" + ids;
		<%}%>
		<%if(type!=null && type.equals("2")) {%>
		var url = "mobilenoticeajax.jsp?ids=" + ids;
		<%}%>
		// alert(url);
		send_request_account(url);
	}

	//初始化，指定处理的函数，发送请求的函数
	function send_request_account(url){
		if(!flag)
		   return ;
		http_request_account = false;
		//开始初始化XMLHttpRequest对象
		if(window.XMLHttpRequest){//Mozilla
			http_request_account = new XMLHttpRequest();
			if(http_request_account.overrideMimeType){//设置MIME类别
				http_request_account.overrideMimeType("text/xml");						
			}
		}
		else if(window.ActiveXObject){//IE
			try{
				http_request_account = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				try{
					http_request_account = new ActiveXObject("Microsoft.XMLHTTP");							
				}catch(e){
				}
			}
		}
		if(!http_request_account){
			alert("不能创建XMLHttpRequest对象");
			return false;
		}
		
		
		http_request_account.onreadystatechange = processRequest_account;
		var urlArr=url.split("?");
		url=urlArr[0];
		var para=urlArr[1];

		http_request_account.open("POST",url,true);
	    http_request_account.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		http_request_account.send(para);
		
	}
	
	function processRequest_account(){
		var win = window.dialogArguments;
		if(http_request_account.readyState == 4){
			if(http_request_account.status == 200){
				var returnVal = http_request_account.responseText.trim();
				var arr = returnVal.split(",");
				var realname = "";
				var accountname = "";
				for (var i=0; i<arr.length; i++) {
					var username = arr[i].split(":");
					accountname += username[0] + ",";
					realname += username[1] + ",";
				}
				
				if (accountname) {
					accountname = accountname.substring(0, accountname.length-1);
				}
				if (realname) {
					realname = realname.substring(0, realname.length-1);
				}
				try{
				win.document.getElementById('receiver_name').value = accountname;}catch(e){};
				try{win.document.getElementById('recnames').value = realname;}catch(e){};
				try{win.document.getElementById('recname').innerHTML = realname;}catch(e){};
				window.close();
			}
			else{
				alert("对不起，服务器错误");
			}
		}
	}
	
	// add by yaohui.luo	2008-5-29 from mootools core.js
	String.prototype.trim=function() {
		return this.replace(/(^\s*)|(\s*$)/g,"");
	}

	</SCRIPT></head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form action="" method="post">
				<pg:beaninfo requestKey="Apply">
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">机构用户</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"
							cellpadding="0" cellspacing="1" class="table">							
							<tr>
								<td width="26%" height="26" class="detailtitle">
									<strong>选择消息接受用户：</strong>
								</td>
							</tr>
							<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="message_org_user_tree"
										node="message_org_user_tree.node"
										imageFolder="../sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" mode="static">
										<tree:param name="users" ></tree:param>
										<tree:param name="app_id" ></tree:param>
										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />

										<tree:treedata
											treetype="com.chinacreator.message.MessageOrgUserTree"
											scope="request" rootid="0" rootName="消息机构用户树" expandLevel="1"
											showRootHref="false" needObserver="false" />

									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="确定"
											onClick="getReceivers()">
									</div>
								</td>								
								<td>								
									<div align="left">
										<input name="rsset" type="reset" class="input" value="重置">
									</div>
								</td>
								<td>
									<div align="left">
										<input name="button" type="button" class="input" value="取消"
											onClick="winClose()">
									</div>
								</td>
							</tr>
						</table>
					</div>
				</pg:beaninfo>
			</form>
		</div>
	</body>
</html>
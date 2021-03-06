<%@ page pageEncoding="GBK" import="com.chinacreator.message.Message
				,com.chinacreator.security.AccessControl
				,com.chinacreator.message.util.MessageTools
				,com.chinacreator.message.util.MessageAppDao
				,com.chinacreator.message.util.MsgConfig
				,com.chinacreator.message.factory.MessageDaoFactory"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%--
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
--%>
<%

    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
	String app_id =	accesscontroler.getCurrentSystemID();
	
	
	String[][] Resource=MessageDaoFactory.getMessageSourceManager().getAllMsgResource();
	
	int smsLimit = Integer.parseInt(MsgConfig.getProperties("SMS_CONTENT_LIMIT"));
	int rtxLimit = Integer.parseInt(MsgConfig.getProperties("RTX_CONTENT_LIMIT"));
	int sysLimit = Integer.parseInt(MsgConfig.getProperties("SYS_CONTENT_LIMIT"));
   	// 平台开关
	boolean switchRtx = MessageTools.MessageisExistFromXML("rtx");
	boolean switchSms = MessageTools.MessageisExistFromXML("sms");
	boolean switchSys = MessageTools.MessageisExistFromXML("sys");

	boolean switchMsgCenter = true;
	boolean isModule = app_id.equals("module");
	
	
	// 应用开关
	/*if (!app_id.equals("module")) {
		switchMsgCenter = MessageTools.MessageisShow(app_id);
		boolean appSwitchRtx = MessageTools.MessageisExistFromDB(
		app_id, "rtx");
		boolean appSwitchSms = MessageTools.MessageisExistFromDB(
		app_id, "sms");
		boolean appSwitchSys = MessageTools.MessageisExistFromDB(
		app_id, "sys");

		// 根据平台开关、应用开关最后判定是否使用
		sRtx = switchRtx && appSwitchRtx;
		sSms = switchSms && appSwitchSms;
		sSys = switchSys && appSwitchSys;

	} else {
		sRtx = switchRtx;
		sSms = switchSms;
		sSys = switchSys;
	}*/

%>
<html>
	<head>
	<title>发送消息</title>
	<link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="./eWebEditor/js/pageGrey.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/sysmanager/scripts/validateForm.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
	<!--
		var rtxTitleLimit = <%=MsgConfig.getProperties("RTX_TITLE_LIMIT")%>;
		var sysTitleLimit = <%=MsgConfig.getProperties("SYS_TITLE_LIMIT")%>;
		var smsContentLimit = <%=MsgConfig.getProperties("SMS_CONTENT_LIMIT")%>;
		var rtxContentLimit = <%=MsgConfig.getProperties("RTX_CONTENT_LIMIT")%>;
		var sysContentLimit = <%=MsgConfig.getProperties("SYS_CONTENT_LIMIT")%>;
		//var contentLength = smsContentLimit <= rtxContentLimit ? smsContentLimit : rtxContentLimit;
		var contentLength = 0;
        var users="";
        //var sendType;
        var titleLimit;
		//关闭模态窗口并刷新父页面
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}

		//去除字符串空格
		function trim(string){
			var temp="";
			string = ''+string;
			splitstring = string.split(" ");
			for(i=0;i<splitstring.length;i++){
				temp += splitstring[i];
			}
			return temp;
		}
		
		function getSendtype(){
			var sendType=new Array();
			var types = document.getElementsByName("types");
			var k = 0;
			for(i =0;i<types.length;i++){
				if(types[i].checked){
					sendType[k] = types[i].value;
					k++;
				}
			}
			return sendType;
		}

		function checkLimit() {
			var smsFlag = false;
			var rtxFlag = false;
			var sysFlag = false;
			
			// 验证表单
			/*var sendType;
			var types = document.getElementsByName("types");
			for(i =0;i<types.length;i++){
				if(types[i].checked){
					sendType+=types[i].value.split(",");
				}
			}*/
			var sendType = getSendtype();
			for(i =0;i<sendType.length;i++){
				if("sms"==sendType[i]){
					smsFlag = true;
				}
				if("rtx"==sendType[i]){
					rtxFlag = true;
				}
				if("sys"==sendType[i]){
					sysFlag = true;
				}
			}
			if(smsFlag&&!rtxFlag &&!rtxFlag ){
				contentLength = smsContentLimit;
			}
			if(!smsFlag&&rtxFlag &&!sysFlag ){
				contentLength = rtxContentLimit;
				titleLimit = rtxTitleLimit;
			}
			if(!smsFlag&&!rtxFlag &&sysFlag ){
				contentLength = sysContentLimit;
				titleLimit = sysTitleLimit;
			}
			if(smsFlag&&rtxFlag &&sysFlag ){
				contentLength =  smsContentLimit <= rtxContentLimit ? smsContentLimit : rtxContentLimit;
				contentLength =  contentLength<=sysContentLimit?contentLength:sysContentLimit;
				titleLimit = sysTitleLimit<=rtxTitleLimit?sysTitleLimit:rtxTitleLimit;
			}
			if(smsFlag&&rtxFlag &&!sysFlag ){
				contentLength = smsContentLimit <= rtxContentLimit ? smsContentLimit : rtxContentLimit;
				titleLimit = rtxTitleLimit;
			}
			if(!smsFlag&&rtxFlag &&sysFlag ){
				contentLength = sysContentLimit <= rtxContentLimit ? sysContentLimit : rtxContentLimit;
				titleLimit = sysTitleLimit<=rtxTitleLimit?sysTitleLimit:rtxTitleLimit;
			}
			if(smsFlag&&!rtxFlag &&sysFlag ){
				contentLength = sysContentLimit <= smsContentLimit ? sysContentLimit : smsContentLimit;
				titleLimit = sysTitleLimit;
			}
			
			/*
			if (rtxFlag && !smsFlag) {
				contentLength = rtxContentLimit;
			} else if (!rtxFlag && smsFlag) {
				contentLength = smsContentLimit;
			} else if (rtxFlag && smsFlag) {
				contentLength = smsContentLimit<=rtxContentLimit?smsContentLimit:rtxContentLimit;
			}*/
			setTimeout('countOfChar()', 10);
		}
		//匹配字母数字英文标点
		var reg=/[A-Za-z0-9]|\!|\"|\#|\$|\%|\&|\'|\(|\)|\*|\+|\,|\-|\.|\/|\:|\;|\<|\=|\>|\?|\@|\[|\\|\]|\^|\_|\`|\{|\||\}|\~/g;
		//计算字符串的字符长度 例 "1!a测试" 的字符长度为 7
		function getCharLength(str){
			var count = str.replace(reg,"").length;
			return str.length+count;
		}
		var contentValid = true;
		
		function countOfChar() {
			checkLimit();
			var str = $('content').value;
			var len = getCharLength(str);
			var charLen = contentLength-len;
			
			$('charnotify').innerText = "还可以输入" + charLen + "个字符";
			if(charLen<0){
				contentValid = false;
			}else{
				contentValid = true;
			}
		}
		
		function calContent(event) {
			var e = window.event || event;
			$("returnnotify").innerHTML = "";
			if (getCharLength($('content').value)>=contentLength && !(e.keyCode==8)) {
				event.returnValue = false;
				return;
			}
			contentValid = true;
			setTimeout('countOfChar()', 10);
		}

		var http_request_account = false;
		var flag = true;
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
			http_request_account.open("GET",url,true);
			http_request_account.send(null);
		}

		function processRequest_account(){
			if(http_request_account.readyState == 4){
				if(http_request_account.status == 200){
					var returnVal = http_request_account.responseText;
					// 服务器端返回字符串格式：sms:1rtx:0sys:0
					if (isSpace(returnVal)) {
						return;
					}
					if (returnVal.indexOf("sms:") != -1) {
						var sms = returnVal.substr(returnVal.indexOf("sms:")+4,1);
					}
					if (returnVal.indexOf("rtx:") != -1) {
						var rtx = returnVal.substr(returnVal.indexOf("rtx:")+4,1);
					}
					if (returnVal.indexOf("sys:") != -1) {
						var sys = returnVal.substr(returnVal.indexOf("sys:")+4,1);
					}

					$("returnnotify").innerHTML = "";
					
					if (rtx == 0) {
						$("returnnotify").innerHTML += "<font color=blue>RTX消息发送成功!!!</font>";
					} else if (rtx == 1) {
						$("returnnotify").innerHTML += "<font color=red>发送标题不能为空!!!</font>";
					} else if (rtx == 2) {
						$("returnnotify").innerHTML = "<font color=red>发送标题不能超过" + rtxTitleLimit + "个字符</font>";
					} else if (rtx == 3) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能为空!!!</font>";
					} else if (rtx == 4) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能超过" + contentLength + "个字符</font>";
					} else if (rtx == 5) {
						$("returnnotify").innerHTML += "<font color=red>RTX消息发送失败!!!</font>";
					}
					if (sms == 0) {
						$("returnnotify").innerHTML += "<font color=blue>短信发送成功!!!</font>";
					} else if (sms == 1) {
						$("returnnotify").innerHTML += "<font color=red>您的手机号码没有填写或者接收者的手机号码没有填写!!!</font>";
					} else if (sms == 2) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能为空!!!</font>";
					} else if (sms == 3) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能超过" + contentLength + "个字符</font>";
					} else if (sms == 4) {
						$("returnnotify").innerHTML += "<font color=red>短信发送失败!!!</font>";
					}
					
					if (sys == 0) {
						$("returnnotify").innerHTML += "<font color=blue>邮件发送成功!!!</font>";
					} else if (sys == 1) {
						$("returnnotify").innerHTML += "<font color=red>发送标题不能为空!!!</font>";
					} else if (sys == 2) {
						$("returnnotify").innerHTML = "<font color=red>发送标题不能超过" + sysTitleLimit + "个字符</font>";
					} else if (sys == 3) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能为空!!!</font>";
					} else if (sys == 4) {
						$("returnnotify").innerHTML = "<font color=red>发送内容不能超过" + contentLength + "个字符</font>";
					} else if (sys == 5) {
						$("returnnotify").innerHTML += "<font color=red>邮件发送失败!!!</font>";
					}
				}
				else{
					alert("对不起，服务器错误");
				}
				cancelSign();  //隐藏显示进度层 added by wen.zhu 20100925
			}
		}

		function sendMessage() {
			if(!contentValid){
				$("returnnotify").innerHTML = "<font color=red>发送内容长度超出限制，请修改!!!</font>";
				return;
			}
			$("returnnotify").innerHTML = "";
			var smsFlag = false;
			var rtxFlag = false;
			var sysFlag = false;
			var checkedFlag = false;
			// 验证表单
			var sendType = getSendtype();
			if(typeof sendType =="undefined" || sendType.length==0){
				$("returnnotify").innerHTML = "<font color=red>请选择一种发送方式!!!</font>";
				return;
			}
			
			var types="";
			for(i =0;i<sendType.length;i++){
				if("sms"==sendType[i]){
					smsFlag = true;
				}
				if("rtx"==sendType[i]){
					rtxFlag = true;
				}
				if("sys"==sendType[i]){
					sysFlag = true;
				}
				types +=sendType[i]+",";
			}
			types  = types.substring(0,types.length-1);
			
			if (isSpace($('title').value) &&( rtxFlag||sysFlag) ) {
				$("returnnotify").innerHTML = "<font color=red>发送即时消息或邮件时，标题必须填写!!!</font>";
				return;
			}
			if ((sysFlag||rtxFlag) && $('title').value.length > titleLimit) {
				$("returnnotify").innerHTML = "<font color=red>发送标题长度不能大于" + titleLimit + "!!!</font>";
				return;
			}
			if (isSpace($('receiver_name').value)) {
				$("returnnotify").innerHTML = "<font color=red>必须选择收件人!!!</font>";
				return;
			}
			if (isSpace($('content').value)) {
				$("returnnotify").innerHTML = "<font color=red>发送内容必须填写!!!</font>";
				return;
			}
			if ($('content').value.length > contentLength) {
				$("returnnotify").innerHTML = "<font color=red>发送内容长度不能大于" + contentLength + "!!!</font>";
				return;
			}
			/*if (!rtxFlag && smsFlag && $('content').value.length > smsContentLimit) {
				$("returnnotify").innerHTML = "<font color=red>发送内容长度不能大于" + smsContentLimit + "!!!</font>";
				return;
			}
			if (rtxFlag && smsFlag && $('content').value.length > (contentLength = smsContentLimit<=rtxContentLimit?smsContentLimit:rtxContentLimit)) {
				$("returnnotify").innerHTML = "<font color=red>发送内容长度不能大于" + contentLength + "!!!</font>";
				return;
			}*/

			var url = "sendmessageajax.jsp?title=" + $('title').value
						+ "&receiver_name=" + $('receiver_name').value
						+ "&content=" + $('content').value
						+ "&sendType=" + types;

			send_request_account(url);
			popCoverDiv(); //弹出显示进度层 added by wen.zhu 20100925
  		    popSign(1);  
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
		  users=$("receiver_name").value;

		  openWin('<%=request.getContextPath()%>/message/orgusertree.jsp?type=2&app_id=<%=app_id%>&users='+users,window,500,600);
		}

//-->
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
	<br />
	<br />
	<div align="center">
		<form action="sendmessageajax.jsp" method="post">
			<pg:beaninfo requestKey="Apply">
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2"> 发送消息</FONT>
					</LEGEND>
					<br />
					<table width="85%" border="0" align="center" cellpadding="0" cellspacing="1" class="thin">
						<tr>
							<td width="20%" height="35" class="detailtitle">
								标题
							</td>
							<td nowrap="NOWRAP" class="detailcontent">
								<input name="title" type="text" size="64" maxlength="<%=MsgConfig.getProperties("RTX_TITLE_LIMIT")%>" />	短信可不填写标题
							</td>
						</tr>
						<tr>
							<td width="20%" height="35" class="detailtitle">
								收件人
							</td>
							<td class="detailcontent">
								<span id="recname" style="width:400px;height:20px;white-space:normal;word-break:break-all;border:1px solid #7F9DB9;font-size:12px;padding:2px;"></span>
								<textarea id="receiver_name" name="receiver_name" readonly="readonly" style="display:none;"></textarea>
								<img title="选择收件人" alt="选择收件人" src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_2.gif" style="cursor:hand"
								onclick="openMyTree();" />
								<div>标记为红色表示该用户没有填写手机号</div>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<textarea name="content" id="content" rows="10" cols="80" onkeydown="calContent(event);"></textarea>
								<span name="notify" style="color:#FF0000;" id="charnotify"></span>
							</td>
						</tr>
					</table>
					<br />
					<br />
				</fieldset>
				<br />
				<div align="center">
					<table border="0" align="right" cellpadding="0"	cellspacing="0">
						<tr>
							<td>
								<div align="left" id="returnnotify"></div>
							</td>
							<td>
								<div align="left">
								<%
									boolean switchMsg = false;
									boolean appSwitchMsg = false;
									String functionList = MessageAppDao.getInstance().getFunctionList(app_id);
									String[] functionArr = functionList.split(MsgConfig.getProperties("delim"));
									String [][] dictNoStr =MessageDaoFactory.getMessageDict().getDictNo();
									for(String[] no : dictNoStr){
										switchMsg = MessageTools.MessageisExistFromXML(no[0]);
										//modyfy by wen.zhu
										//平台使用消息配置
										//appSwitchMsg =isModule ?true:MessageTools.MessageisExistFromDB(app_id, no[0]);
										appSwitchMsg =MessageTools.MessageisExistFromDB(app_id, no[0]);
										if(switchMsg&&appSwitchMsg){
								 %>
											<span style="margin-right:5px;">
											<input name="types" id="<%=no[0]%>" type="checkbox" value = "<%=no[0]%>" class="" onclick="checkLimit()"><%=no[1]%>
											</span>
								 <%			
										}
									}
								%>
								</div>
							</td>
							<td style="padding-right:5px;">
								<div align="left">
									<input name="send" type="button" class="input" value="发送" onclick="sendMessage();">
									<!-- <input name="send" type="submit" class="input" value="发送">  -->
								</div>
							</td>
							<td style="padding-right:5px;">
								<div align="left">
									<input name="button" type="button" class="input" value="取消" onClick="winClose()">
								</div>
							</td>
							<td width=50>
							</td>
						</tr>
					</table>
				</div>
			</pg:beaninfo>
		</form>
	</div>
</body>
</html>
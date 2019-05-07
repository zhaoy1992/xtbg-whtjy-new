<%@page contentType="text/html;charset=GBK"%>
<%@page	import="com.chinacreator.security.AccessControl
	,com.chinacreator.message.MessageManager
	,com.chinacreator.message.util.MessageTools
	"%>
<%@page import="com.chinacreator.message.impl.MessageManagerImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.epp.shortcutmenu.dbmanager.Shorcut_menuManager"%>
<%@page import="com.chinacreator.framework.Item"%>
<%@page import="com.chinacreator.framework.MenuHelper"%>
<%@page import="com.chinacreator.framework.Framework"%>
<%@page import="java.util.Map"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String app_id = accesscontroler.getCurrentSystemID();
	//System.out.println("app:"+app_id);
	// 平台开关
	boolean switchRtx = MessageTools.MessageisExistFromXML("rtx");
	boolean switchSms = MessageTools.MessageisExistFromXML("sms");
	boolean switchSys = MessageTools.MessageisExistFromXML("sys");
	//System.out.println(switchRtx+":"+switchSms+":"+switchSys);
	boolean switchMsgCenter = true;
	boolean sRtx = false;
	boolean sSms = false;
	boolean sSys = false;

	// 应用开关
	//modify by wen.zhu 
	//平台工具栏也使用配置
	//if (!app_id.equals("module")) {
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

	/*} else {
		sRtx = switchRtx;
		sSms = switchSms;
		sSys = switchSys;
	}*/

	int noReadMsgCount = 0;

	MessageManager message = new MessageManagerImpl();

	if (message != null ) {
		String id = accesscontroler.getUserID();
		//System.out.println(id);
		noReadMsgCount = message.getNoReadMsgCount(id);
	}
%>
<script language="javascript">


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

			var conts  = http_request_account.responseText;
			var returnVal = conts.split(";");
			//count_object = document.getElementById("user_counts");
			//alert(conts);
			//count_object.innerHTML = "<font color=#ffffff>在线用户数"+returnVal[0] +"(人)</font>&nbsp;";

			<%
			if (switchMsgCenter && (sRtx || sSms || sSys)) {
			%>
			if (!isNaN(returnVal[1])) {
				document.getElementById('noreadmsgcount').innerHTML = returnVal[1];
			}
			<%
			}
			%>
		}
		else{
			//alert("对不起，服务器错误");
		}
	}
}
function logout()
{
    parent.location='logout.jsp';
    flag = false;
}
function list()
{
   //parent.location='sysmanager/onLineUser.jsp';
   window.open('sysmanager/onLineUser.jsp','onlineUser','menubar=no,status=no,toolbar=no,width=800,height=400');

}
function personal()
{
	var url = "person/personinfo.jsp";
	var stylee = "dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no";
	//window.open(url);
	win = window.showModalDialog(url,window,stylee);
}

function msgcenter() {
	var url = "message/messagecenter.jsp";
	var stylee = "dialogWidth:"+(820)+"px;dialogHeight:"+(600)+"px;help:no;scroll:no;status:no";
	//window.open(url);
	win = window.showModalDialog(url,window,stylee);
}

function startRtx() {
	var url = "message/rtx.jsp";
	window.open(url,'rtxPage','');
}

//window.setInterval("send_request_account('sysmanager/count.jsp')",60*1000);
function setcss(){
	var url = "setcss.jsp";
	var stylee = "dialogWidth:"+(820)+"px;dialogHeight:"+(600)+"px;help:no;scroll:no;status:no";
	win = window.showModalDialog(url,window,stylee);
	if("ok"==win){
		top.location.reload(); 
	}
}
</script>
<iframe id="rtxPage" name="rtxPage" width="0" height="0"></iframe>
<table width="100%" height=16 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="right" width=* height=25></td>
		<!--td valign="middle" align="center" width=25 height=25><img alt="用户在线状况" title="用户在线状况"
			class="normal" src="sysmanager/images/online-users.gif"></td-->
		<td valign="middle" align="right" width="140" height=25 nowrap>
			&nbsp;
		</td>
		<td class=normal valign="middle" align="center" 
			height=25 onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)" onclick="setcss()">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						<img src="epp/eppTemplate/images/cssreplace.gif">
						<font color="#ffffff">样式切换</font>
						&nbsp;
					</td>
				</tr>
			</table>
		</td>
		<td class=normal valign="middle" align="center" 
			height=25 onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<a href="<%=MenuHelper.getPerspectiveContentUrl(
				request.getContextPath(), Framework.getInstance().getPublicItem().getPath(),
				(Map) null) %>" target="perspective_content"><img alt="首页" title="首页"
							src="<%=request.getContextPath()%>/sysmanager/bbs/images/home.gif"
							><font color="#ffffff">首页</font></a>
						&nbsp;
					</td>
				</tr>
			</table>
		</td>
		<%
		if (switchMsgCenter && sRtx ) {
		%>
		<td class=normal valign="middle" align="center" onclick="startRtx()"
			height=25 onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="启动RTX" title="启动RTX"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/startrtx.gif"
							>
						&nbsp;
					</td>
				</tr>
			</table>
		</td>
		<%
		}
		%>
		<%
		if (switchMsgCenter && (sRtx || sSms || sSys )) {
		%>
		<td class=normal valign="middle" align="center" onclick="msgcenter()"
			height=25 onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="消息中心" title="消息中心"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/message.gif"
							>
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap" id="messagecenter">
						<font color="#ffffff">
						消息中心
						<%
						if (switchMsgCenter && sSys) {
						%>
						(<span id="noreadmsgcount"><%=noReadMsgCount%></span>)
						<%
						}
						%>
						</font>&nbsp;
					</td>
				</tr>
			</table>
		</td>
		<%
		}
		%>

		<!-- <td class=normal valign="middle" align="center" onclick="list()"
			height=25 onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="在线用户数" title="在线用户数"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_2.gif"
							>
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap" id="user_counts">
						<font color="#ffffff"> 在线用户数<%=accesscontroler.getLoginUserCount()%>(人)</font>&nbsp;
					</td>
				</tr>
			</table>
		</td> -->

		<td class=normal valign="middle" align="center" onclick="personal()"
			width=80 height=25 onmousedown="mousedown(this)"
			onmouseout="mouseout(this)" onmouseover="mouseover(this)"
			onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="当前用户" title="当前用户"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_3.gif"
							>
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap">
						<font color="#ffffff"> <%=accesscontroler.getUserName()%>(<%=accesscontroler.getUserAccount()%>)</font>&nbsp;
					</td>
				</tr>
			</table>
		</td>

		<!-- <td style="display:all" class=normal valign="middle" align="center"
			width=80 height=25 onclick="" onmousedown="mousedown(this)"
			onmouseout="mouseout(this)" onmouseover="mouseover(this)"
			onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr style="display:all">
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="科创应用支撑平台帮助" title="科创应用支撑平台帮助"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_4.gif"
							align="top" >
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap">
						<font color="#ffffff">帮助&nbsp;</font>
					</td>
				</tr>
			</table>
		</td>
		<td class=normal valign="middle" align="center" width=80 height=25
			onmousedown="mousedown(this)" onmouseout="mouseout(this)"
			onmouseover="mouseover(this)" onmouseup="mouseup(this)"
			style="display: all;">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr style="display:all">
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img alt="关于科创应用支撑平台" title="关于科创应用支撑平台"
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_5.gif"
							align="top" >
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap">
						<font color="#ffffff">关于&nbsp;</font>
					</td>
				</tr>
			</table>
		</td> -->

		<td class=normal valign="middle" align="center" width=80 height=20
			title="退出" onclick="logout()" onmousedown="mousedown(this)"
			onmouseout="mouseout(this)" onmouseover="mouseover(this);cursor=1"
			onmouseup="mouseup(this)">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td valign="middle" align="center" nowrap="nowrap">
						&nbsp;
						<img
							src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_6.gif"
							align="top" >
						&nbsp;
					</td>
					<td valign="middle" nowrap="nowrap">
						<font color="#ffffff">退出&nbsp;</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

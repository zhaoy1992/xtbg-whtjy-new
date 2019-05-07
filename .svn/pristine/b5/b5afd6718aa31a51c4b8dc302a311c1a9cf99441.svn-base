<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js" defer></script>
		<script src="../../fceform/js/ccapp_pub.js" defer></script>		
		<script src="../../../eformsys/gaeditor/js/gaeditor.js" defer></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js" defer></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			var _my_namespace_js = "<script src='"+stylePath+"js/namespace.js"+"'></"+"script>";
			window.document.write(_my_namespace_js);		
		</script>
		<%@ include file="../../../iWebOffice2006/js/iWebOffice2006Event.jsp"%>
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/style_right.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all-debug.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script><script language='vbscript' src='../../fceform/js/fcmask.vbs'></script><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<script>/*
 * 作者：黄琪
 * 日期：2009-07-14
 */
function init()
{
  var insCode = window.dialogArguments;
  var taskInfoSql = new Array();
  
  taskInfoSql.push("select i.item_insname,");
  taskInfoSql.push("t.action_name,t.handler,t.org_name,");
  taskInfoSql.push("t.handle_result,t.handle_idea,t.finish_time");
  taskInfoSql.push("  from app_5.ta_sp_instance i join app_5.ta_sp_tasklist t");
  taskInfoSql.push(" on i.item_insid=t.item_insid");
  taskInfoSql.push(" where i.instance_code = '"+insCode+"'");

  taskInfo.Open(taskInfoSql.join(""));
}

function goBack()
{
  this.close();
}</script><DIV id=SKbillsheet toolbar="不带工具栏" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090825142958890821" type="ZW" billtaborder="<root><taborder>txtHandleIdea</taborder><taborder>txtItemInsName</taborder><taborder>txtActionName</taborder><taborder>txtHandler</taborder><taborder>txtOrgName</taborder><taborder>txtHandleResult</taborder><taborder>txtDealTime</taborder></root>" testDbName dj_sn="20090826091235500903" caption="处理意见详细页" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth posheight isfile="否" OtherSave="否" creator_csslib="style_right.css" idtype="1" version="1.0" creator_pagination controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" contxml="<root><textarea><id>txtHandleIdea</id></textarea><text><id>txtItemInsName</id><id>txtActionName</id><id>txtHandler</id><id>txtOrgName</id><id>txtHandleResult</id><id>txtDealTime</id></text><dataset><id>taskInfo</id></dataset></root>"><TABLE style="WIDTH: 100%; POSITION: static; HEIGHT: 123px" cellSpacing=2 cellPadding=1 align=left <TBODY border0&gt;>
<TBODY>
<TR>
<TD>
<TABLE class=table_sidle style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
<TBODY>
<TR>
<TD class=all_title>审批意见详细信息</TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD>
<TABLE class=table_function style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
<TBODY>
<TR>
<TD class=color width="15%">项目名称</TD>
<TD align=left colSpan=3><INPUT id=txtItemInsName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ITEM_INSNAME" dataset="taskInfo" china="ITEM_INSNAME"></TD></TR>
<TR>
<TD class=color width="15%">环节名称</TD>
<TD align=left width="35%"><INPUT id=txtActionName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ACTION_NAME" dataset="taskInfo" china="ACTION_NAME"></TD>
<TD class=color width="15%">办理人</TD>
<TD align=left width="35%"><INPUT id=txtHandler style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="HANDLER" dataset="taskInfo" china="HANDLER"></TD></TR>
<TR>
<TD class=color width="15%">办理单位</TD>
<TD align=left width="35%"><INPUT id=txtOrgName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ORG_NAME" dataset="taskInfo" china="ORG_NAME"></TD>
<TD class=color width="15%">处理结果</TD>
<TD align=left width="35%"><INPUT id=txtHandleResult style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="HANDLE_RESULT" dataset="taskInfo" china="HANDLE_RESULT"></TD></TR>
<TR>
<TD class=color width="15%">处理意见</TD>
<TD style="HEIGHT: 150px" colSpan=3><TEXTAREA id=txtHandleIdea style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 95%" onmovestart=moveStart() readOnly controltype="textarea" field="HANDLE_IDEA" dataset="taskInfo" china="HANDLE_IDEA" induce="否" value="textarea1"></TEXTAREA></TD></TR>
<TR>
<TD class=color width="15%">处理时间</TD>
<TD colSpan=3><INPUT id=txtDealTime style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="FINISH_TIME" dataset="taskInfo" china="FINISH_TIME"></TD></TR></TBODY></TABLE></TD></TR></TBODY>
<TBODY>
<TR>
<TD align=middle colSpan=4>&nbsp;</TD></TR>
<TR>
<TD align=middle colSpan=4><BUTTON class=btn onclick=goBack()>关 闭</BUTTON></TD></TR></TBODY></TABLE><?xml:namespace prefix = fc /><fc:dataset id=taskInfo opensortno="1" temptable="TMP_TASKINFO" multiResult="否" onValid='bill_ondatasetvalid("<dsid><ITEM_INSNAME></ITEM_INSNAME><ACTION_NAME></ACTION_NAME><FINISH_TIME></FINISH_TIME><HANDLER></HANDLER><HANDLE_IDEA></HANDLE_IDEA><HANDLE_RESULT></HANDLE_RESULT><ORG_NAME></ORG_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ITEM_INSNAME></ITEM_INSNAME><ACTION_NAME></ACTION_NAME><FINISH_TIME></FINISH_TIME><HANDLER></HANDLER><HANDLE_IDEA></HANDLE_IDEA><HANDLE_RESULT></HANDLE_RESULT><ORG_NAME></ORG_NAME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><ITEM_INSNAME></ITEM_INSNAME><ACTION_NAME></ACTION_NAME><FINISH_TIME></FINISH_TIME><HANDLER></HANDLER><HANDLE_IDEA></HANDLE_IDEA><HANDLE_RESULT></HANDLE_RESULT><ORG_NAME></ORG_NAME></dsid>")' format="<fields><field><fieldname>ITEM_INSNAME</fieldname><datatype>字符</datatype><displaylabel>ITEM_INSNAME</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACTION_NAME</fieldname><datatype>字符</datatype><displaylabel>ACTION_NAME</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FINISH_TIME</fieldname><datatype>日期</datatype><displaylabel>FINISH_TIME</displaylabel><size>7</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HANDLER</fieldname><datatype>字符</datatype><displaylabel>HANDLER</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HANDLE_IDEA</fieldname><datatype>字符</datatype><displaylabel>HANDLE_IDEA</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HANDLE_RESULT</fieldname><datatype>字符</datatype><displaylabel>HANDLE_RESULT</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORG_NAME</fieldname><datatype>字符</datatype><displaylabel>ORG_NAME</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset></DIV></body></html>
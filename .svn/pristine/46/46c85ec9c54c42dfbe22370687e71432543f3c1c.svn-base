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
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/>
<script></script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090810102954968085" type="ZW" contxml="<root><button><id>button1</id></button><text><id>text1</id><id>text2</id></text></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:0;DsMain_field:0;a:0;button:1;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" billtaborder="<root><taborder>button1</taborder><taborder>text1</taborder><taborder>text2</taborder></root>" creator_pagination version="1.0" idtype="1" creator_csslib OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();" keyfield codeheader="BBB" creatorStyle="creatorBlue" mkbh caption="测试ext树控件" dj_sn="20090810103058671836" testDbName toolbar="不带工具栏"><BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" onclick="bill_onclick(&quot;openTree('org',text1,text2,true)&quot;)" controltype="button">树控件</BUTTON><INPUT id=text1 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"><INPUT id=text2 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></DIV></body></html>
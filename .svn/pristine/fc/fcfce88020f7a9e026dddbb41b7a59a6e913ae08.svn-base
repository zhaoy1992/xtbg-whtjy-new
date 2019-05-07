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
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<script></script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090810102954968085" type="ZW" toolbar="不带工具栏" creator_pagination version="1.0" creator_csslib isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark="fdsafdas" BLONclose="UnLoadWebOffice();" creatorStyle="creatorBlue" testDbName="test" idtype="1" OtherSave="否" isfile="否" keyfield postop posleft window="当前窗口" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:4;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" posheight poswidth entertype="修改" codeheader="BBB" mkbh caption="测试数据源动态指定" dj_sn="20090813111925468882" billtaborder="<root><taborder>text1</taborder><taborder>text2</taborder><taborder>button3</taborder><taborder>button4</taborder></root>" contxml="<root><button><id>button3</id><id>button4</id></button><text><id>text1</id><id>text2</id></text><dataset><id>dataset1</id></dataset></root>" BLONopen="setAuthority();"><?xml:namespace prefix = fc /><fc:dataset id=dataset1 multiResult="否" saveastable="TA_ABC" temptable="TMP_DATASET1" opensortno="1" onValid='bill_ondatasetvalid("<dsid><AA></AA><BB></BB></dsid>")' onGetText='bill_ondatasetgettext("<dsid><AA></AA><BB></BB></dsid>")' onSetText='bill_ondatasetsettext("<dsid><AA></AA><BB></BB></dsid>")' sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%B6%90%CC%90%92%94" format="<fields><field><fieldname>AA</fieldname><datatype>字符</datatype><displaylabel>AA</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BB</fieldname><datatype>字符</datatype><displaylabel>BB</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset><INPUT id=text1 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="AA" dataset="dataset1" china="AA"><INPUT id=text2 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="BB" dataset="dataset1" china="BB"><BUTTON id=button3 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('启动流程',true,true,'../../../common_workflow/main.jsp')&quot;)">启动流程</BUTTON><BUTTON id=button4 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp')&quot;)">完成活动</BUTTON></DIV></body></html>
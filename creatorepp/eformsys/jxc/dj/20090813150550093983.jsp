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
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script><script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script><script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script><script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script><script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script><script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>
<script></script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090810102954968085" type="ZW" toolbar="不带工具栏" creator_pagination version="1.0" creator_csslib isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark BLONclose="UnLoadWebOffice();" creatorStyle="creatorBlue" testDbName="test" idtype="1" OtherSave="否" isfile="否" keyfield postop posleft window="当前窗口" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0" posheight poswidth entertype="修改" codeheader="BBB" mkbh caption="测试表单数据源" dj_sn="20090813150550093983" billtaborder="<root></root>" contxml="<root><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" BLONopen="setAuthority();"><?xml:namespace prefix = fc /><fc:dataset id=dataset1 multiResult="否" saveastable="TA_ABC" temptable="TMP_DATASET1" opensortno="1" onValid='bill_ondatasetvalid("<dsid><AA></AA><BB></BB></dsid>")' onGetText='bill_ondatasetgettext("<dsid><AA></AA><BB></BB></dsid>")' onSetText='bill_ondatasetsettext("<dsid><AA></AA><BB></BB></dsid>")' sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%B6%90%CC%90%92%94" format="<fields><field><fieldname>AA</fieldname><datatype>字符</datatype><displaylabel>AA</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BB</fieldname><datatype>字符</datatype><displaylabel>BB</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27true%27%2Cshowtype%3A%27%3Cspan%20style%3D%22color%3Ared%22%3E%24%7Bbb%7D%3C/span%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" columnWidth1Xml="undefined" columnHeight1Xml="undefined" showtypeXml="<root><showType><name>BB</name><showRule>%5B%7BRule%3A%27true%27%2Cshowtype%3A%27%3Cspan%20style%3D%22color%3Ared%22%3E%24%7Bbb%7D%3C/span%3E%27%7D%5D</showRule></showType></root>"></fc:dataset>&nbsp;
<DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
<SCRIPT type=text/javascript>Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';var ExtGrid1_retint = 0;var ExtGrid1_onReady = function(){var dataset = document.getElementById("dataset1");try{var temp = dataset .Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =-1;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("dataset1"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_ExtGrid1',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:435,        height:231,		split: true,		region: 'north',		title:'test',		frame:true    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
grid.render();store.load();if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'ExtGrid1',obj:grid,dataset:'dataset1',isEdit:'false'});};ExtGrid1_onReady();</SCRIPT>
</DIV></body></html>
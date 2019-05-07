<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  if(!accesscontroler.checkAccess(request, response)){
  		return;
  }
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
<script>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/style_right.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script><script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script><script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script><script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script><script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script><script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>
<script>
/**
 * 初始化：如果还没产生实例，则查询收费基本信息表；否则，查询收费实例表
 */
function init(){
    var cc_form_instanceid = parent.PageParms.ccFormId;
        var chargeInsSql = new Array();
    chargeInsSql.push("select c.CHARGE_ID,c.CHARGE_NAME,c.CHARGE_TYPE,c.STANDARD,c.NUM,c.TOTAL_MONEY");
    chargeInsSql.push(" from ta_sp_chargeinstance c where c.cc_form_instanceid='");
    chargeInsSql.push(cc_form_instanceid);
    chargeInsSql.push("'");
    chargeDataset.Open(chargeInsSql.join(""));
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090825142932109877" type="ZW" toolbar="不带工具栏" billtaborder="<root></root>" testDbName="xzsp" dj_sn="20090826084543218899" caption="收费信息（只读）" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth posheight isfile="否" OtherSave="否" creator_csslib="style_right.css" idtype="1" version="1.0" creator_pagination controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" contxml="<root><dataset><id>chargeDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>"><?xml:namespace prefix = fc /><fc:dataset id=chargeDataset opensortno="1" temptable="TMP_DATASET1" multiResult="否" onValid='bill_ondatasetvalid("<dsid><CHARGE_NAME></CHARGE_NAME><CHARGE_TYPE></CHARGE_TYPE><STANDARD></STANDARD><ORGNAME></ORGNAME><NUM></NUM><TOTAL_MONEY></TOTAL_MONEY><CHARGE_ID></CHARGE_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CHARGE_NAME></CHARGE_NAME><CHARGE_TYPE></CHARGE_TYPE><STANDARD></STANDARD><ORGNAME></ORGNAME><NUM></NUM><TOTAL_MONEY></TOTAL_MONEY><CHARGE_ID></CHARGE_ID></dsid>")' onSetText='bill_ondatasetsettext("<dsid><CHARGE_NAME></CHARGE_NAME><CHARGE_TYPE></CHARGE_TYPE><STANDARD></STANDARD><ORGNAME></ORGNAME><NUM></NUM><TOTAL_MONEY></TOTAL_MONEY><CHARGE_ID></CHARGE_ID></dsid>")' format="<fields><field><fieldname>CHARGE_NAME</fieldname><datatype>字符</datatype><displaylabel>收费项名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CHARGE_TYPE</fieldname><datatype>实数</datatype><displaylabel>收费类型</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STANDARD</fieldname><datatype>字符</datatype><displaylabel>收费标准</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORGNAME</fieldname><datatype>字符</datatype><displaylabel>收费单位</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NUM</fieldname><datatype>实数</datatype><displaylabel>数量</displaylabel><size></size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TOTAL_MONEY</fieldname><datatype>实数</datatype><displaylabel>总金额</displaylabel><size></size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CHARGE_ID</fieldname><datatype>实数</datatype><displaylabel>CHARGE_ID</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset> 
<TABLE width="96%">
<TBODY>
<TR>
<TD></TD></TR></TBODY></TABLE>&nbsp;
<DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
<SCRIPT type=text/javascript>Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';var ExtGrid1_retint = 0;var ExtGrid1_onReady = function(){var dataset = document.getElementById("chargeDataset");try{var temp = dataset .Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =5;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("chargeDataset"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_ExtGrid1',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:1015,        height:140,		split: true,		region: 'north',		title:'收费',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
cm.setHidden(7,true); 
grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'ExtGrid1',obj:grid,dataset:'chargeDataset',isEdit:'false'});if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);};ExtGrid1_onReady();</SCRIPT>
</DIV></body></html>
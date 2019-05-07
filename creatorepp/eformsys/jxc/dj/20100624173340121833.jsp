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
	<script type="text/javascript" src="../../../cachloader/pre_load.js"></script>	
	<script language="javascript">
		var __dj_win_flag__ = true;
		function load_over(){
			document.getElementById("preloadView").style.display="none";
			document.getElementById("SKbillsheet").style.visibility="visible";
		}
	
		function optmGetUsdatObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(userDataWrObj) != "undefined") && userDataWrObj.isCanUse()) return userDataWrObj;
			return null;			
		}
		
		function optmGetFlashObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(flashWrObj) != "undefined") && flashWrObj.isCanUse()) return flashWrObj;
			return null;
		}
		
		function ex_prePageInit()
		{	
			var bSucced = __pre_loadjsFrame();
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js frame failure!</font>";
				return;
			}
			
			mtJsFileArray("eformsys/fceform/js/fcpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcvalid.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceformext/js/usertb.js", true, optmGetUsdatObj());			
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);
					
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
         mtJsFileArray("eformsys/fceform/js/Ext/css/ext-all.css", true, optmGetUsdatObj());
			s=1;
		
			bSucced = prePageInit(false, true);
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js file failure!</font>";
				return;
			}
			
			pub_djhtm();
			fcpubdata.creatorStyle='creatorBlue';
		}
		
		//根据应用确定样式的目录
		var stylePath = "../../../ccapp/<%=appPath%>/";			
	</script>
		
	</HEAD>
	<body  onload="load_over();pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<DIV style="Z-INDEX: 1000; BACKGROUND: #e0e0e0; FILTER: alpha(opacity=80); LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%" id="preloadView">
		   <TABLE style="VERTICAL-ALIGN: middle; WIDTH: 100%; HEIGHT: 100%; TEXT-ALIGN: center">
		      <TBODY>
		         <TR>
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
		         </TR>
		      </TBODY>
		   </TABLE>
		</DIV>
		
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
			var pubdjbh=parent.sOpenDjNo;
			var pubEdit=false;
			var pubDataSet=null;
			var pubRequest=parent.oRequest;
			var pubEformEnterStatus="OK"; 
			ex_prePageInit();
		</script>

<!-- 提示：以下为页面的JS&CSS内容 -->
<%
 String iWebOfficeVersion  = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("iWebOfficeVersion", "7,8,0,4");
String strDgMode = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("file.upload.jsdgmode");
boolean bDgMode = !((strDgMode == null) || !strDgMode.equals("1"));
%><script language='javascript'>
<%if(bDgMode){%>  var myhead = document.getElementsByTagName('head')[0];
  var mylink = document.createElement("link");
  mylink.setAttribute("type","text/css");
  mylink.setAttribute("rel","stylesheet");
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css//allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css//allStyle.css');
<%}%>  fcpubdata.creatorStyle='';
</script>
<%
if(!bDgMode) out.println("<script language='javascript'>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcwebgrid.js');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
function add(x, y)
{
    return x + y;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><combobox><id>combobox1</id></combobox><dropdownlist><id>dropdownlist1</id></dropdownlist><grid><id>grid1</id></grid><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid><ExtTree><id>ExtTree1</id></ExtTree></root>" billtaborder="<root><taborder>grid1</taborder><taborder>combobox1</taborder><taborder>dropdownlist1</taborder></root>" dj_sn="20100624173340121833" caption="mxthontest" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:1;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:1;Fusionchar:1" window="当前窗口" posleft="101" postop="101" keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination="grid1,dataset1,;" type="ZW" creatorType="20090810102954968085" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" center="居中">

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>ACTDEF_ID</fieldname><datatype>字符</datatype><displaylabel>ACTDEF_ID</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACTDEF_NAME</fieldname><datatype>字符</datatype><displaylabel>ACTDEF_NAME</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACTDEF_ORDER</fieldname><datatype>字符</datatype><displaylabel>ACTDEF_ORDER</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACTDEF_VALUE</fieldname><datatype>字符</datatype><displaylabel>ACTDEF_VALUE</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PARENT_ID</fieldname><datatype>字符</datatype><displaylabel>PARENT_ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%F6%D0%CC%EE%D0%F2%D0%E8%CC%D0%D4%F6%D6%D8%DA" onSetText='bill_ondatasetsettext("<dsid><ACTDEF_ID></ACTDEF_ID><ACTDEF_NAME></ACTDEF_NAME><ACTDEF_ORDER></ACTDEF_ORDER><ACTDEF_VALUE></ACTDEF_VALUE><PARENT_ID></PARENT_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ACTDEF_ID></ACTDEF_ID><ACTDEF_NAME></ACTDEF_NAME><ACTDEF_ORDER></ACTDEF_ORDER><ACTDEF_VALUE></ACTDEF_VALUE><PARENT_ID></PARENT_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><ACTDEF_ID></ACTDEF_ID><ACTDEF_NAME></ACTDEF_NAME><ACTDEF_ORDER></ACTDEF_ORDER><ACTDEF_VALUE></ACTDEF_VALUE><PARENT_ID></PARENT_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>

<fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col><col></col></grid1>")' top="0" width="300px" height="123" format="<cols><col><fname>ACTDEF_ID</fname><cname>ACTDEF_ID</cname><width>22</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>ACTDEF_NAME</fname><cname>ACTDEF_NAME</cname><width>50</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>ACTDEF_ORDER</fname><cname>ACTDEF_ORDER</cname><width>22</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>ACTDEF_VALUE</fname><cname>ACTDEF_VALUE</cname><width>10</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>PARENT_ID</fname><cname>PARENT_ID</cname><width>10</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" dataset="dataset1" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="否" hideHscroll="否" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
   <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
      <TBODY>
         <TR class=fcGridFirstRow>
            <TD></TD>
         </TR>
      </TBODY>
   </TABLE>
</fc:webgrid>

&nbsp;

<IMG style="DISPLAY: none" src="undefined">

<DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>

<SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("undefined");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =-1;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("undefined"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid1 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid1',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
		width:0,      height:0,		split: true,
		region: 'north',
		title:'undefined',
		frame:true
    });
    var grid=ExtGrid1;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

ExtGrid1.render();
store.load();
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'undefined',isEdit:'undefined'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT>

&nbsp;

<DIV id=ExtTreeDiv_ExtTree1 style="BORDER-RIGHT: #c3daf9 1px solid; BORDER-TOP: #c3daf9 1px solid; LEFT: 611px; OVERFLOW: auto; BORDER-LEFT: #c3daf9 1px solid; BORDER-BOTTOM: #c3daf9 1px solid; POSITION: absolute; TOP: 1px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>var tree;Ext.onReady(function(){	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';    tree = new Ext.tree.TreePanel({		el:'ExtTreeDiv_ExtTree1',		title:'树',		frame:true,	height:303,	width:250,		autoScroll:'true',		loader:new Ext.tree.TreeLoader({		}),		tbar:[			new Ext.form.TextField({				emptyText:'输入过滤字符',				allowBlank:true,				listeners:{					render:function(f){						   f.el.on('keydown', filterTree, f, {								buffer: 350						   });					}				}			})		]	});	var root = new Ext.tree.AsyncTreeNode({text:"treeItem",qtip:"treeItem",id:"",leaf:true});	tree.setRootNode(root);/**
使用说明                      
1.注释不要用 //。
2.这里可以操作此控件的tree（Ext.tree.TreePanel）对象和root（Ext.tree.AsyncTreeNode）对象
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
	tree.render();	root.expand();	var filter = new Ext.tree.TreeFilter(tree, {		clearBlank: true,		autoClear: true	});	function filterTree(e){		var text = e.target.value;		var re = new RegExp(Ext.escapeRe(text), 'i');		filter.filterBy(function(n){			return !n.isLeaf() || re.test(n.text);		});	}	Ext.QuickTips.init();if(Ext.isIE6){var nodes = null;tree.on('beforecollapsenode',function(node){nodes = tree.getChecked();});tree.on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}creator_pt_trees.push({id:'ExtTree1',obj:tree});});</SCRIPT>

<SELECT id=combobox1 style="LEFT: 88px; WIDTH: 192px; POSITION: absolute; TOP: 171px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" sql></SELECT>

<fc:fc_code id=dropdownlist1 top="262" width="178px" height="0" align="" format="" sqltrans="" field="" dataset="" blninput="是" blnempty="否" addrow="否" multiselect="否" xml="" visible="是" left="127" sql2="" fontweight="" color="" backgroundcolor="" fontfamily="" fontstyle="" fontsize="" position="absolute" enabled="false"></fc:fc_code>

<TABLE style="LEFT: 332px; POSITION: absolute; TOP: 284px" cellSpacing=2 cellPadding=1 width=100 align=left border=1>
   <TBODY>
      <TR>
         <TD>abcd</TD>
         <TD>eft</TD>
      </TR>
      <TR>
         <TD>123</TD>
         <TD>456</TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
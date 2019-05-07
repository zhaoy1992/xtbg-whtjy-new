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

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
function aaa(){
alert(111);
}
function test(){
alert("关闭成功");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><ExtTree><id>ExtTree1</id><id>ExtTree2</id></ExtTree></root>" billtaborder="<root></root>" dj_sn="20100507094618859552" caption="testtree" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:2;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100430111825238919" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

&nbsp;

<DIV id=ExtTreeDiv_ExtTree1 style="BORDER-RIGHT: #c3daf9 1px solid; BORDER-TOP: #c3daf9 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: #c3daf9 1px solid; BORDER-BOTTOM: #c3daf9 1px solid; POSITION: static; TOP: 0px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>var tree;Ext.onReady(function(){	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';    tree = new Ext.tree.TreePanel({		el:'ExtTreeDiv_ExtTree1',		title:'树',		frame:true,	height:351,	width:262,		autoScroll:'true',		loader:new Ext.tree.TreeLoader({			baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI } 		}),		checkModel: 'single', 		onlyLeafCheckable : false,		tbar:[			new Ext.form.TextField({				emptyText:'输入过滤字符',				allowBlank:true,				listeners:{					render:function(f){						   f.el.on('keydown', filterTree, f, {								buffer: 350						   });					}				}			})		]	});	var root = new Ext.tree.AsyncTreeNode({text:"根节点",qtip:"treeItem",id:"",children:[{text:"增加节点",qtip:"增加节点",id:"",children:[{text:"增加节点",qtip:"增加节点",id:"",children:[{text:"test",qtip:"test",id:"",leaf:true},{text:"增加节点",qtip:"增加节点",id:"",leaf:true}]},{text:"增加节点",qtip:"增加节点",id:"",leaf:true},{text:"增加节点",qtip:"增加节点",id:"",leaf:true}]},{text:"增加节点",qtip:"增加节点",id:"",leaf:true},{text:"增加节点",qtip:"增加节点",id:"",leaf:true}]});	new Ext.tree.TreeSorter(tree, {folderSort:true,property:'id',dir:'desc',leafAttr:'false',caseSensitive:true});	tree.setRootNode(root);/**
使用说明                      
1.注释不要用 //。
2.这里可以操作此控件的tree（Ext.tree.TreePanel）对象和root（Ext.tree.AsyncTreeNode）对象
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
	tree.render();	tree.on('click',aaa);	var filter = new Ext.tree.TreeFilter(tree, {		clearBlank: true,		autoClear: true	});	function filterTree(e){		var text = e.target.value;		var re = new RegExp(Ext.escapeRe(text), 'i');		filter.filterBy(function(n){			return !n.isLeaf() || re.test(n.text);		});	}	Ext.QuickTips.init();if(Ext.isIE6){var nodes = null;tree.on('beforecollapsenode',function(node){nodes = tree.getChecked();});tree.on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}creator_pt_trees.push({id:'ExtTree1',obj:tree});});</SCRIPT>

&nbsp;

<DIV id=ExtTreeDiv_ExtTree2 style="BORDER-RIGHT: #c3daf9 1px solid; BORDER-TOP: #c3daf9 1px solid; OVERFLOW: auto; BORDER-LEFT: #c3daf9 1px solid; BORDER-BOTTOM: #c3daf9 1px solid"></DIV>

&nbsp;

<SCRIPT type=text/javascript>var tree;Ext.onReady(function(){	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';    tree = new Ext.tree.TreePanel({		el:'ExtTreeDiv_ExtTree2',		title:'树',		frame:true,		autoScroll:'true',		loader:new Ext.tree.TreeLoader({		}),		tbar:[			new Ext.form.TextField({				emptyText:'输入过滤字符',				allowBlank:true,				listeners:{					render:function(f){						   f.el.on('keydown', filterTree, f, {								buffer: 350						   });					}				}			})		]	});	var root = new Ext.tree.AsyncTreeNode({
id: 4,
        text: 'A folder Node',
children: [
{
        id: 1,
        text: 'A leaf Node',
        leaf: true
    },{
        id: 2,
        text: 'A folder Node',
        children: [{
            id: 3,
            text: 'A child Node',
            leaf: true
        }]
   }]
}
);	new Ext.tree.TreeSorter(tree, {folderSort:true,property:'id',dir:'desc',leafAttr:'false',caseSensitive:true});	tree.setRootNode(root);/**
使用说明                      
1.注释不要用 //。
2.这里可以操作此控件的tree（Ext.tree.TreePanel）对象和root（Ext.tree.AsyncTreeNode）对象
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
	tree.render();	root.expand();var win = new Ext.Window({		title		: '对话窗',		layout      : 'fit',		width       : 328,		height      : 337,		closeAction :'hide',		plain       : true,		items       : tree,		buttons: [{			text     : '确认',			handler  : test		},{			text     : '取消',			handler  : function(){				win.hide();			}		}]    });win.show();	var filter = new Ext.tree.TreeFilter(tree, {		clearBlank: true,		autoClear: true	});	function filterTree(e){		var text = e.target.value;		var re = new RegExp(Ext.escapeRe(text), 'i');		filter.filterBy(function(n){			return !n.isLeaf() || re.test(n.text);		});	}	Ext.QuickTips.init();if(Ext.isIE6){var nodes = null;tree.on('beforecollapsenode',function(node){nodes = tree.getChecked();});tree.on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}creator_pt_trees.push({id:'ExtTree2',obj:tree});});</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
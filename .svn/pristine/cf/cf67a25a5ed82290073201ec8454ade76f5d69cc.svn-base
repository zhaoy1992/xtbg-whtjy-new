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
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);			
			
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
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
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			var _my_namespace_js = "<script src='"+stylePath+"js/namespace.js"+"'></"+"script>";
			window.document.write(_my_namespace_js);
	</script>
		
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
			ex_prePageInit();
		</script>
<link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" />
<!-- 以下为页面的JS&CSS内容 -->
<script>
  mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');
  var myhead = document.getElementsByTagName('head')[0];
  myhead.appendChild(mylink);
  fcpubdata.creatorStyle='creatorBlue';
</script>

<script language='javascript'>
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');
</script>
<link href='../../fceform/css/tabstyle.css' type='text/css' rel='stylesheet'/>
<script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/creatorBlue/test.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script>
<link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/>
<link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/>
<script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
<script src='../../fceform/js/fcdataset.js'></script>
<script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>

<script>
function init() {
    $("text1").className = "input_out";    
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js" creatorType="20100830162418046027" type="ZW" contxml="<root><button><id>buttonQuery</id><id>buttonReset</id><id>buttonNew</id><id>buttonModify</id><id>buttonDelete</id></button><text><id>text1</id></text><dataset><id>datasetQuery</id></dataset><ExtGrid><id>ExtGridData</id></ExtGrid></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" billtaborder="<root><taborder>buttonQuery</taborder><taborder>buttonReset</taborder><taborder>buttonNew</taborder><taborder>buttonModify</taborder><taborder>buttonDelete</taborder><taborder>text1</taborder></root>" creator_pagination version="1.0" idtype="1" creator_csslib="test.css" OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();init();" keyfield codeheader="BBB" creatorStyle="creatorBlue" mkbh caption="模板样式" dj_sn="20100902173823984039" testDbName="app_xzcf" toolbar="不带工具栏">

<TABLE border=0 cellSpacing=0 cellPadding=0 width="90%" align=center>
<TBODY>
<TR>
<TD>
<TABLE class=Ctable border=0 cellSpacing=0 cellPadding=0 width="100%">
<TBODY>
<TR>
<TD class=taobox colSpan=4>表单查询标题</TD>
</TR>
<TR>
<TD class=c2 width="15%">输入字段</TD>
<TD width="35%"></TD>
<TD class=c2 width="15%">单选字段</TD>
<TD></TD>
</TR>
<TR>
<TD class=c2 width="15%">下拉类别字段</TD>
<TD width="35%">
<INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 110px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=text1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="text">
</TD>
<TD class=c2 width="15%"></TD>
<TD></TD>
</TR>
<TR>
<TD class=c2 width="15%">时间控件字段</TD>
<TD width="35%"></TD>
<TD class=c2 width="15%"></TD>
<TD></TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
<TR>
<TD>
<DIV class=box2 align=center>
<BUTTON onresizeend=resizeEnd() id=buttonQuery class=button onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">查询</BUTTON>

&nbsp;
<BUTTON onresizeend=resizeEnd() id=buttonReset class=button onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">重置</BUTTON>
</DIV>
</TD>
</TR>
<TR>
<TD>
<DIV align=right>
<BUTTON onresizeend=resizeEnd() id=buttonNew class=addbutton1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">新增</BUTTON>

&nbsp;
<BUTTON onresizeend=resizeEnd() id=buttonModify class=xbutton1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">修改</BUTTON>

&nbsp;
<BUTTON onresizeend=resizeEnd() id=buttonDelete class=sbutton1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">删除</BUTTON>
</DIV>
</TD>
</TR>
<TR>
<TD>&nbsp;

<DIV style="POSITION: static; TOP: 0px; LEFT: 0px" id=div_ExtGridData></DIV>
<SCRIPT type=text/javascript>Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';var ExtGridData_retint = 0;var ExtGridData_onReady = function(){var dataset = document.getElementById("datasetQuery");try{var temp = dataset .Fields.Field.length;}catch(e){if(ExtGridData_retint==0) ExtGridData_retint = setInterval(ExtGridData_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(ExtGridData_retint);ExtGridData_retint = null ;var pagesize =20;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("datasetQuery"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_ExtGridData',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:760,        height:300,		split: true,		region: 'north',		title:'查询结果',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'ExtGridData',obj:grid,dataset:'datasetQuery',isEdit:'false'});if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);};ExtGridData_onReady();</SCRIPT>
</TD>
</TR>
<TR>
<TD>
<TABLE border=0 cellSpacing=0 cellPadding=0 width=760>
<TBODY>
<TR>
<TD></TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=datasetQuery opensortno="1" temptable="TMP_DATASET1" multiResult="否" onValid='bill_ondatasetvalid("<dsid><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><a></a></dsid>")' onSetText='bill_ondatasetsettext("<dsid><a></a></dsid>")' format="<fields><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset>

</DIV>
</body></html>
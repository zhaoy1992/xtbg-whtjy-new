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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var mbId = creator_getQueryString("mbId");

function init() {
    queryWordTemplete();
}

/*
     函数:   queryWordTemplete
     说明:   查询word模板
      参数:   
     返回值: 无
*/
var temp;
function queryWordTemplete(){
    var mbMc = $('MB_MC').value;
    var sql = PunishInsConfig.queryWordTemplete(mbMc);
    wordMBDataset.Open(sql);
    reloadExtGrid();
    var temp = window.setInterval("initWordMb()",1000); 
}

function initWordMb(){
    if(!IsSpace(mbId)){
        for(var i = 0; i < grid.getStore().getCount(); i++){
             var obj = grid.getView().getCell(i, 0);
             var MBID = document.createElement(obj.firstChild.innerHTML).value;
             if(MBID == mbId) {
                 document.all("id")[i].checked=true;
                 break;
             }
        }
    }
}

function checkradio(){
    initBunissUnit();
}

function chooseBusinessUnit(){
    var grid = creator_pt_grids[0].obj;
    var rows = grid.getSelectionModel().getSelections();
    var ids = new Array();
    var buName = new Array();
    for(var i = 0; i < rows.length; i++){
       var fieldId = rows[i].get('bu_id');
       var fieldName = rows[i].get('bu_name');
       ids[ids.length] = fieldId;
       buName[buName.length] = fieldName.trim();     
    }
    if(ids.length==0){    
       alert("请选择要执法主体");
    }else{
        window.returnValue = ids+"___"+buName;
        window.close();
    }
}

function reset(){
    $('MB_MC').value = "";
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>btnQuery</id><id>btnReset</id><id>chooseUnit</id><id>btnClose</id></button><text><id>MB_MC</id></text><dataset><id>wordMBDataset</id></dataset><ExtGrid><id>ExtGrid2</id></ExtGrid></root>" billtaborder="<root><taborder>chooseUnit</taborder><taborder>btnClose</taborder><taborder>btnQuery</taborder><taborder>btnReset</taborder><taborder>MB_MC</taborder></root>" dj_sn="20101122160201968682" caption="选择word模板" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:2;password:0;upload:1;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:5;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="seq_tb_sm_inputtype" isfile="否" OtherSave="否" idtype="3" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101117093013703020" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInsConfig.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js" djid="20100919154302600260">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=c2 width="15%">文书模板名称</TD>
                     <TD width="35%"><INPUT class=input_out id=MB_MC style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD width="15%"></TD>
                     <TD width="35%"></TD>
                  </TR>
                  <TR>
                     <TD align=middle colSpan=4><BUTTON class=button id=btnQuery style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("queryWordTemplete();")'>查询</BUTTON><BUTTON class=button id=btnReset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("reset();")'>重置</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid2 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid2;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid2_retint = 0;
var ExtGrid2_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("wordMBDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid2_retint==0) ExtGrid2_retint = setInterval(ExtGrid2_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid2_retint);ExtGrid2_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("wordMBDataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid2 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid2',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('80%')))/100,
		split: true,
		region: 'north',
		title:'查询结果列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid2;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
cm.setHidden(2,true);
ExtGrid2.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid2',obj:ExtGrid2,dataset:'wordMBDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid2_onReady();window.onresize=function(){try{ExtGrid2.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=chooseUnit style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("chooseBusinessUnit();")'>选择</BUTTON><BUTTON class=button id=btnClose style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("window.close();")'>关闭</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=wordMBDataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3D%22sex%22/%3E%27%7D%5D</showRule></showType><showType><name>BU_ID</name><showRule></showRule></showType><showType><name>radio</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3Did%20value%3D%24%7Bbu_id%7D%20/%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>a</name><columnWidth2>10%25</columnWidth2></columnWidth1><columnWidth1><name>checked</name><columnWidth2>5%25</columnWidth2></columnWidth1><columnWidth1><name>BU_NAME</name><columnWidth2>50%25</columnWidth2></columnWidth1><columnWidth1><name>BU_BRIEF_CODE</name><columnWidth2>45%25</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>radio</fieldname><datatype>字符</datatype><displaylabel>单选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3Did%20value%3D%24%7Bbu_id%7D%20/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MB_MC</fieldname><datatype>字符</datatype><displaylabel>模板名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MB_ID</fieldname><datatype>字符</datatype><displaylabel>模板主键</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><radio></radio><MB_MC></MB_MC><MB_ID></MB_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><radio></radio><MB_MC></MB_MC><MB_ID></MB_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><radio></radio><MB_MC></MB_MC><MB_ID></MB_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
</SCRIPT>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
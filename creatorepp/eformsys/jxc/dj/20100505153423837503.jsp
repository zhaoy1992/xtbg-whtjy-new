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
user_name = "";

function init(){

}
function query(){
user_name = $('text1').value;
ExtGrid1.store.load();
${'dataset1'}.Open();
creator_pt_grids[0].obj.store.reload();
}

function test(){
alert('按钮测试');
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><label><id>label1</id></label><button><id>button1</id></button><text><id>text1</id></text><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>text1</taborder><taborder>button1</taborder></root>" dj_sn="20100505153423837503" caption="表单demo" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100430111825238919" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<IMG style="DISPLAY: none" src="undefined">

<DIV id=div_ExtGrid1 style="LEFT: 207px; POSITION: absolute; TOP: 161px"></DIV>

<SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset1"), 
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
		title:'用户列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid1;
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
//grid.on('dblclick',function(){alert(123);});
//cm.setHidden('2',true);
//function rowdblclickFn(grid, rowIndex, e){//双击事件   
//var row = grid.store.getById(grid.store.data.items[rowIndex].id);alert(row.get("user_name"));   
//}
//grid.addListener('rowdblclick', rowdblclickFn); 
//cm.setRenderer('2', function(){alert()});
ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'dataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 showtypeXml="<root><showType><name>SEX</name><showRule>%5B%7BRule%3A%27%24%7Bsex%7D%3D%3D0%27%2Cshowtype%3A%27%u7537%27%7D%2C%7BRule%3A%27%24%7Bsex%7D%3D%3D1%27%2Cshowtype%3A%27%u5973%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>user_id</name><showRule>%5B%7BRule%3A%27%24%7Brole_name%7D%3D%3D%22%22%27%2Cshowtype%3A%27%3Ca%20style%3D%22color%3Ared%22%3E%24%7Buser_id%7D%3C/a%3E%27%7D%5D</showRule></showType><showType><name>role_name</name><showRule>%5B%7BRule%3A%27%24%7Brole_name%7D%3D%3D%22%22%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u6309%u94AE%u6D4B%u8BD5%22%20onclick%3D%22test%28%29%22%3E%3C/input%3E%27%7D%5D</showRule></showType><showType><name>user_sex</name><showRule>%5B%7BRule%3A%27%24%7Buser_sex%7D%3D%3D%22M%22%27%2Cshowtype%3A%22%u7537%22%7D%2C%7BRule%3A%27%24%7Buser_sex%7D%3D%3D%22F%22%27%2Cshowtype%3A%22%u5973%22%7D%5D</showRule></showType><showType><name>img</name><showRule>%5B%7BRule%3A%27true%27%2Cshowtype%3A%27%3Cimg%20src%3D%22http%3A//www.d9soft.com/upload/2009/2/16/2009021678991097.gif%22%20width%3D50%20height%3D50%3E%3C/img%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>user_id</fieldname><datatype>字符</datatype><displaylabel>用户ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7Brole_name%7D%3D%3D%22%22%27%2Cshowtype%3A%27%3Ca%20style%3D%22color%3Ared%22%3E%24%7Buser_id%7D%3C/a%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>user_name</fieldname><datatype>字符</datatype><displaylabel>用户名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>user_realname</fieldname><datatype>字符</datatype><displaylabel>用户真实名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>role_name</fieldname><datatype>字符</datatype><displaylabel>角色名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7Brole_name%7D%3D%3D%22%22%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u6309%u94AE%u6D4B%u8BD5%22%20onclick%3D%22test%28%29%22%3E%3C/input%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>user_sex</fieldname><datatype>字符</datatype><displaylabel>用户性别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7Buser_sex%7D%3D%3D%22M%22%27%2Cshowtype%3A%22%u7537%22%7D%2C%7BRule%3A%27%24%7Buser_sex%7D%3D%3D%22F%22%27%2Cshowtype%3A%22%u5973%22%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>img</fieldname><datatype>字符</datatype><displaylabel>图片</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27true%27%2Cshowtype%3A%27%3Cimg%20src%3D%22http%3A//www.d9soft.com/upload/2009/2/16/2009021678991097.gif%22%20width%3D50%20height%3D50%3E%3C/img%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%D0j%F8%F4%D8%F2%CC%E0%D6Xr%94%D0j%F8%F4%D8%F2%CC%F4%D8%FEXr%94%D0j%F8%F4%D8%F2%CC%EA%D0%E8%D8Xr%94%D0j%F8%F4%D8%F2%CC%F2%D8%D0%E6%EA%D0%E8%D8Xr%94%D4j%F2%EC%E6%D8%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%F8%F4%D8%F2Xrn%D0Xrn%E6%D8%DA%F6Xrn%E2%EC%E0%EAXrn%F6%D6%CC%F4%E8%CC%F8%F4%D8%F2%F2%EC%E6%D8Xrn%D2Xrn%EC%EAXrn%D0j%F8%F4%D8%F2%CC%E0%D6XrnXt%96Xrn%D2j%F8%F4%D8%F2%CC%E0%D6Xrn%E6%D8%DA%F6Xrn%E2%EC%E0%EAXrn%F6%D6%CC%F4%E8%CC%F2%EC%E6%D8Xrn%D4Xrn%EC%EAXrn%D4j%F2%EC%E6%D8%CC%E0%D6XrnXt%96Xrn%D2j%F2%EC%E6%D8%CC%E0%D6Xrn%FC%DE%D8%F2%D8Xrn%F8%F4%D8%F2%CC%EA%D0%E8%D8Xrn%E6%E0%E4%D8XrnXr%7CXrxXt%90Xrv%F8%F4%D8%F2%CC%EA%D0%E8%D8XrxXr%7C" onSetText='bill_ondatasetsettext("<dsid><user_id></user_id><user_name></user_name><user_realname></user_realname><role_name></role_name><user_sex></user_sex><img></img></dsid>")' onGetText='bill_ondatasetgettext("<dsid><user_id></user_id><user_name></user_name><user_realname></user_realname><role_name></role_name><user_sex></user_sex><img></img></dsid>")' onValid='bill_ondatasetvalid("<dsid><user_id></user_id><user_name></user_name><user_realname></user_realname><role_name></role_name><user_sex></user_sex><img></img></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>

<INPUT id=text1 style="LEFT: 297px; WIDTH: 110px; POSITION: absolute; TOP: 112px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">

<DIV id=label1 style="LEFT: 201px; WIDTH: 65px; POSITION: absolute; TOP: 116px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label1">用户名称:</DIV>

<BUTTON id=button1 style="LEFT: 637px; WIDTH: 75px; POSITION: absolute; TOP: 108px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("query()")'>查询</BUTTON>
</DIV>
<div id='grid_tip'></div></body></html>
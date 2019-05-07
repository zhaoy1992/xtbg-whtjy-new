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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordReport.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordReport.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js'></script>");
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
var mb_ID = creator_getQueryString("mb_id");//获取模板ID

/*
    描述：初始化方法
*/
function init() {
    //得到所有模板列表
    var sql = WordReport.getWordReportSql("");
    dataset1.Open(sql);
    reloadExtGrid();
    //var temp = window.setInterval("initBunissUnit()",1000); 
}
/*
function initBunissUnit(){
    if(!IsSpace(mb_ID)){
        for(var i = 0; i < grid.getStore().getCount(); i++){
             var obj = grid.getView().getCell(i, 0);
             var MB_ID = document.createElement(obj.firstChild.innerHTML).value;
             if(MB_ID == mb_ID) {
                 document.all("id")[i].checked=true;
                 break;
             }
        }
    }
}*/

//预览word文档
function updateMB(grid,rowIndex,e) {
    var row = grid.store.getById(grid.store.data.items[rowIndex].id);
    var mb_id = row.get("mb_id");
    var url = "../../../eformsys/jxc/dj/20101124143257625133.jsp?mb_id="+mb_id;
    //var url = "../../../eformsys/jxc/dj/20101110145308843964.jsp?mb_id="+mb_id;
    url += "&status=write";
    //var url = "../../../ccapp/app_xzcf/jsp/wordedit/wordedit_index.jsp?mb_id="+mb_id+"";
    var height = window.screen.availHeight;
    var width = window.screen.availWidth;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
    //window.open(url,'window',tempPara);
    //window.open(url,'newwindow','height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no')
    reloadExtGrid();
}

/*
    描述：选择模板，返回模板ID
*/
function chooseMB(){
    var grid = creator_pt_grids[0].obj;
    var rows = grid.getSelectionModel().getSelections();
    if (rows=="") {
        alert("请选择word模板");
        return false;
    }
    var MB_id = rows[0].get('mb_id');    
    var MB_name = rows[0].get('mb_mc');
    /*var MB_id = "";
    if(mb_ID == 0){
        var grid = creator_pt_grids[0].obj;
        var rows = grid.getSelectionModel().getSelections();
        if(IsSpace(rows)){
            alert("请选择模板");
            return false;
        }
        MB_id = rows[0].get('mb_id');
    }     
    if(mb_ID != 0){
        try{
            var grid = creator_pt_grids[0].obj;
            var rows = grid.getSelectionModel().getSelections();
            MB_id = rows[0].get('mb_id');    
            MB_name = rows[0].get('mb_mc');
        }catch(e){
            MB_id = mb_ID;         
        }
    }*/
    //var row = grid.store.getById(grid.store.data.items[rowIndex].id);
    //var mb_id = row.get("mb_id");
    var rtnValue = new Object();
    rtnValue.mb_id = MB_id;
    rtnValue.mb_name = MB_name;
    window.returnValue = rtnValue;
    closeSelectWindow();
}

/*
    描述：关闭选择窗口
*/
function closeSelectWindow(){
    window.close();
}

/*
    描述：查询模版
*/
function queryMB() {
    var mb_mc = $("mb_mc").value;
    var sql = WordReport.getWordReportSql(mb_mc);
    dataset1.Open(sql);
    reloadExtGrid();
}

/*
    描述：重置查询条件
*/
function resetMB() {
    $("mb_mc").value = "";
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>btnQuery</id><id>btnReset</id><id>chooseButton</id><id>button2</id></button><text><id>mb_mc</id></text><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>btnQuery</taborder><taborder>btnReset</taborder><taborder>mb_mc</taborder><taborder>chooseButton</taborder><taborder>button2</taborder></root>" dj_sn="20101209094954046862" caption="word模板查询选择列表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101027105323156235" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/WordReport.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=2>WORD模版列表</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">模版名称</TD>
                     <TD width="85%"><INPUT id=mb_mc style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=btnQuery style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("queryMB();")'>查询</BUTTON><BUTTON class=button id=btnReset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetMB();")'>重置</BUTTON></TD>
      </TR>
      <TR>
         <TD><?xml:namespace prefix = fc /><fc:dataset id=dataset1 showtypeXml="<root><showType><name>checked</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3Did%20value%3D%24%7Bmb_id%7D%20/%3E%27%7D%5D</showRule></showType><showType><name>radio</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3Did%20value%3D%24%7Bmb_id%7D%20/%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>checked</name><columnWidth2>20</columnWidth2></columnWidth1><columnWidth1><name>sjj_mc</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>sjj_sql</name><columnWidth2>100</columnWidth2></columnWidth1><columnWidth1><name>sjj_ms</name><columnWidth2>100</columnWidth2></columnWidth1><columnWidth1><name>mb_mc</name><columnWidth2>100</columnWidth2></columnWidth1><columnWidth1><name>mb_cjsj</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>mb_cjz</name><columnWidth2>50</columnWidth2></columnWidth1><columnWidth1><name>mb_remark</name><columnWidth2>100</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>radio</fieldname><datatype>字符</datatype><displaylabel>单选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dradio%20name%3Did%20value%3D%24%7Bmb_id%7D%20/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mb_id</fieldname><datatype>字符</datatype><displaylabel>模版ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mb_mc</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>100</columnWidth2></columnWidth1></field><field><fieldname>mb_cjsj</fieldname><datatype>字符</datatype><displaylabel>创建时间</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field><field><fieldname>mb_cjz_id</fieldname><datatype>字符</datatype><displaylabel>创建者ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mb_cjz</fieldname><datatype>字符</datatype><displaylabel>创建者</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>50</columnWidth2></columnWidth1></field><field><fieldname>mb_zhxgsj</fieldname><datatype>字符</datatype><displaylabel>最后修改时间</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mb_remark</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>100</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><radio></radio><mb_id></mb_id><mb_mc></mb_mc><mb_cjsj></mb_cjsj><mb_cjz_id></mb_cjz_id><mb_cjz></mb_cjz><mb_zhxgsj></mb_zhxgsj><mb_remark></mb_remark></dsid>")' onGetText='bill_ondatasetgettext("<dsid><radio></radio><mb_id></mb_id><mb_mc></mb_mc><mb_cjsj></mb_cjsj><mb_cjz_id></mb_cjz_id><mb_cjz></mb_cjz><mb_zhxgsj></mb_zhxgsj><mb_remark></mb_remark></dsid>")' onValid='bill_ondatasetvalid("<dsid><radio></radio><mb_id></mb_id><mb_mc></mb_mc><mb_cjsj></mb_cjsj><mb_cjz_id></mb_cjz_id><mb_cjz></mb_cjz><mb_zhxgsj></mb_zhxgsj><mb_remark></mb_remark></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =2;
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
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
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
cm.setHidden(1,true);
cm.setHidden(4,true);
cm.setHidden(6,true);
grid.addListener('rowdblclick', updateMB); ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'dataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=chooseButton style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("chooseMB()")'>选择</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeSelectWindow()")'>关闭</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
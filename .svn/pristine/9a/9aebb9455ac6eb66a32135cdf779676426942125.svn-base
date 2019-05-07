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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/FindWorkflowTicket.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/FindWorkflowTicket.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/FindWorkflowTicketDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/FindWorkflowTicketDao.js'></script>");
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
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String queryName = "";
if (!"1".equals(accesscontroler.getUserID())) {
    queryName = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID()) ;
} else {
    queryName = orgAccess.getAllBuIds();
}
String idTmp = "";
String nameTmp = "";
if("".equals(idName)){
    idTmp = "";
    nameTmp = "";
}else{
    String[] tmps = idName.split("_");
    idTmp = tmps[0];
    nameTmp = tmps[1];
}
%>

var wft_id =creator_getQueryString("wft_id"); //违法实例ID
var pi_id =creator_getQueryString("pi_id"); //事项ID
var ndp_id =creator_getQueryString("ndp_id"); //当前阶段ID
var bu_id =creator_getQueryString("bu_id"); //执法主体ID
var bu_name =creator_getQueryString("bu_name"); //执法主体名称
var readOnlyFlag =creator_getQueryString("readOnlyFlag"); // 是否只读
var user_id = getSysElement("userid");


//初始化
function init(){
    $("WFT_PLACED_ON_FILE_TIME").readOnly = true ;
    $("WFT_PLACED_ON_FILE_TIME1").readOnly = true ;
    $("BU_ID").readOnly = true;
    findWorkflowTicket();
    $("BU_ID").value = "<%=idTmp %>";
    $("buNames").value = "<%=nameTmp %>";
    $("orgNames").value = $("buNames").value ;
    $("orgIds").value = $("BU_ID").value ; 
}

//查询方法
function findWorkflowTicket(){
     var queryPId = "";
     if (user_id==1){
         queryIds = FindWorkflowTicket.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
         queryPId = FindWorkflowTicket.getPIds(user_id);
     }
     if (queryIds=="") {
         queryIds="0";
     }
    var BU_ID = $("BU_ID").value;//执法主体
     var MIS_ID = $("MIS_ID").value;//案件状态
     var LTT_NAME = $("LTT_NAME").value;//当事人(单位)名称
     var LTT_CODE = $("LTT_CODE").value;//证件号码
     var WFT_BUSINESS_NUMBER = $("WFT_BUSINESS_NUMBER").value;//案件编号
     var WFT_PLACED_ON_FILE_TIME = $("WFT_PLACED_ON_FILE_TIME").value;//立案开始时间
     var WFT_PLACED_ON_FILE_TIME1 = $("WFT_PLACED_ON_FILE_TIME1").value;//立案结束时间
     if(validateTiem()){
        //将页面元素封装成joso对象
         var pagePrams= { 
              BU_ID:BU_ID,
              MIS_ID:MIS_ID,
              LTT_NAME:LTT_NAME,
              LTT_CODE:LTT_CODE,
              WFT_BUSINESS_NUMBER:WFT_BUSINESS_NUMBER,
              WFT_PLACED_ON_FILE_TIME:WFT_PLACED_ON_FILE_TIME,
              WFT_PLACED_ON_FILE_TIME1:WFT_PLACED_ON_FILE_TIME1,
              queryName:queryIds,
              queryPid:queryPId     
         }
        var sql = FindWorkflowTicket.findWorkflowTicket(pagePrams);
        findCaseInfoDataset.Open(sql);
        reloadExtGrid();
    }     
}

//跳转至调查取证查询页面
function loadWorkflowTicket(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var wftId= row.get("wft_id");
    bu_id= row.get("bu_id");
    var num = FindWorkflowTicket.findZDXXBiz(wftId);
    var k = FindWorkflowTicket.isReadOper(wftId);
    if(num>0 || k>0){
        readOnlyFlag = "readOnly" ;
    }
    var tempPara="dialogWidth:800px;dialogHeight:800px";
    var tempURL="20101012142629296004.jsp?eflag=0"+"&wft_id="+wftId+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag ;
    window.location.href(tempURL);
    reloadExtGrid();
}

//重置方法
function resetWorkflowTicket(){
    $("BU_ID").value = "" ;
    $("buNames").value = "" ;
    $("orgNames").value = "" ;
    $("orgIds").value = "" ;
    $("MIS_ID").value = '-1' ;
    $("LTT_NAME").value = "" ;
    $("LTT_CODE").value = "" ;
    $("WFT_BUSINESS_NUMBER").value = "" ;
    $("WFT_PLACED_ON_FILE_TIME").value = "" ;
    $("WFT_PLACED_ON_FILE_TIME1").value= "" ; 
}

//验证时间方法
function validateTiem(){
    var flag = true ;
    var WFT_PLACED_ON_FILE_TIME = $("WFT_PLACED_ON_FILE_TIME").value;//立案开始时间
     var WFT_PLACED_ON_FILE_TIME1 = $("WFT_PLACED_ON_FILE_TIME1").value;//立案结束时间
     if(!IsSpace(WFT_PLACED_ON_FILE_TIME) && !IsSpace(WFT_PLACED_ON_FILE_TIME1)){
         if(WFT_PLACED_ON_FILE_TIME>WFT_PLACED_ON_FILE_TIME1){
             alert("立案起始时间不能大于终止时间");
             flag = false ;
         }else{
             flag = true ;
         }
     }
     return flag ;
}

//打开执法主体的选择
function openOrgTree1(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("buNames").value ;
    $("orgIds").value = $("BU_ID").value ; 
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("buNames").value = $("orgNames").value ;
    $("BU_ID").value = $("orgIds").value ;

}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>MIS_ID</id></combobox><button><id>queryButton</id><id>queryReset</id></button><text><id>orgNames</id><id>orgIds</id><id>buNames</id><id>BU_ID</id><id>LTT_NAME</id><id>WFT_BUSINESS_NUMBER</id><id>LTT_CODE</id><id>WFT_PLACED_ON_FILE_TIME</id><id>WFT_PLACED_ON_FILE_TIME1</id></text><dataset><id>findCaseInfoDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>queryButton</taborder><taborder>queryReset</taborder><taborder>MIS_ID</taborder><taborder>LTT_NAME</taborder><taborder>LTT_CODE</taborder><taborder>WFT_BUSINESS_NUMBER</taborder><taborder>WFT_PLACED_ON_FILE_TIME</taborder><taborder>WFT_PLACED_ON_FILE_TIME1</taborder><taborder>buNames</taborder><taborder>BU_ID</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100918105821975107" caption="调查取证查询" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:5;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:11;hr:0;checkboxlist:0;radiolist:0;dropdownlist:1;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/FindWorkflowTicket.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/FindWorkflowTicketDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>&nbsp;</TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4><SPAN class=STYLE1>案件信息查询</SPAN><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=18 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">执法主体</TD>
                     <TD align=left width="35%"><INPUT class=input_image id=buNames style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openOrgTree1();")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 4%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                     <TD class=c2 align=right width="15%">当事人(单位)名称</TD>
                     <TD align=left width="35%"><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">案件编号</TD>
                     <TD align=left width="35%"><INPUT class=input_out id=WFT_BUSINESS_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input3 controltype="text"></TD>
                     <TD class=c2 align=right width="15%" taobox>证件号码</TD>
                     <TD align=left><INPUT class=input_out id=LTT_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input2 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">案件状态</TD>
                     <TD align=left width="35%"><SELECT id=MIS_ID style="LEFT: 0px; WIDTH: 70%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() name=select sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A8%A0%B4%CC%A0%96Xr%94%A8%A0%B4%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A8%90%B6%B6%98%B2%B4%CC%A0%AA%B4%B6%90%AA%94%98%CC%B4%B6%90%B6%B8%B4Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%A8%A0%B4%CC%A0%96" controltype="combobox" tempvalue="-1" temptext="---请选择---" sql check="1"><OPTION value=-1 selected>---请选择---</OPTION></SELECT></TD>
                     <TD class=c2 align=right width="15%">立案时间</TD>
                     <TD align=left width="35%"><INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME style="LEFT: 0px; WIDTH: 44%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input4 controltype="text" onclick='bill_onclick("SelectDate()")'>&nbsp;至&nbsp;<INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME1 style="LEFT: 0px; WIDTH: 44%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input5 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD align=middle colSpan=4>&nbsp;<BUTTON class=button id=queryButton style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("findWorkflowTicket()")'>查询</BUTTON><BUTTON class=button id=queryReset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetWorkflowTicket()")'>重置</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <IMG style="DISPLAY: none" src="undefined">
            <DIV id=div_ExtGrid1 style="LEFT: 28px; POSITION: static; TOP: 218px"></DIV>
            <SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("findCaseInfoDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("findCaseInfoDataset"), 
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
					height: eval(document.body.clientHeight*(parseFloat('65%')))/100,
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
cm.setHidden(9,true);
cm.setHidden(10,true);
cm.setHidden(11,true);
//cm.setHidden(8,true);
grid.addListener('rowdblclick',loadWorkflowTicket);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'findCaseInfoDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT>
         </TD>
      </TR>
      <TR>
         <TD></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
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

<fc:dataset id=findCaseInfoDataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checked%27%7D%5D</showRule></showType><showType><name>checkBox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>字符</datatype><displaylabel>案件编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mis_name</fieldname><datatype>字符</datatype><displaylabel>案件实例状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>Ltt_Code</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>Wft_Date_Return_Receive</fieldname><datatype>字符</datatype><displaylabel>受理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>Wft_Placed_On_File_Time</fieldname><datatype>字符</datatype><displaylabel>立案时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ndp_name</fieldname><datatype>字符</datatype><displaylabel>当前阶段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>Wft_End_Date</fieldname><datatype>字符</datatype><displaylabel>结案时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ltt_name</fieldname><datatype>字符</datatype><displaylabel>当事人(单位)名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_id</fieldname><datatype>字符</datatype><displaylabel>处罚事项流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><bu_name></bu_name><mis_name></mis_name><Ltt_Code></Ltt_Code><Wft_Date_Return_Receive></Wft_Date_Return_Receive><Wft_Placed_On_File_Time></Wft_Placed_On_File_Time><ndp_name></ndp_name><Wft_End_Date></Wft_End_Date><BU_ID></BU_ID><ltt_name></ltt_name><wft_id></wft_id></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><bu_name></bu_name><mis_name></mis_name><Ltt_Code></Ltt_Code><Wft_Date_Return_Receive></Wft_Date_Return_Receive><Wft_Placed_On_File_Time></Wft_Placed_On_File_Time><ndp_name></ndp_name><Wft_End_Date></Wft_End_Date><BU_ID></BU_ID><ltt_name></ltt_name><wft_id></wft_id></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><bu_name></bu_name><mis_name></mis_name><Ltt_Code></Ltt_Code><Wft_Date_Return_Receive></Wft_Date_Return_Receive><Wft_Placed_On_File_Time></Wft_Placed_On_File_Time><ndp_name></ndp_name><Wft_End_Date></Wft_End_Date><BU_ID></BU_ID><ltt_name></ltt_name><wft_id></wft_id></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
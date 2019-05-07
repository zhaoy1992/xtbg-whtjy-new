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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishMent.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishMent.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishMentDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishMentDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
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
var user_id = getSysElement("userid");
var queryIds = "0";

function init(){
    $("BU_ID").value = "<%=idTmp %>";
    $("BU_NAME").value = "<%=nameTmp %>";
    queryPunishMent();
    
}

/*
     函数:   queryPunishment
     说明:   处罚事项查询
      参数:   无
      返回值: 无
*/
function queryPunishMent() {
    var buId = $("BU_ID").value;//执法主体ID
    var buName = $("BU_NAME").value.trim();//执法主体名称
    var piName = $("PI_NAME").value.trim();//事项名称
    var piCode = $("PI_CODE").value.trim();//事项编码
    var piState = FormUtil.getRadioGroupValue('PI_STATUS');//状态
    var icName = $("IC_NAME").value;//事项类别
    if (user_id==1){
         queryIds = PunishMent.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
    if(icName=='-1') {
        icName = "";
    }
    if(piState == '-1'){
        piState = "";
    }
    var parms = {
        buId : buId,
        buName : buName,
        piName : piName,
        piCode : piCode,
        piState : piState,
        icName  : icName,
        queryName:queryIds
    }

    var sql = PunishMent.queryPunishMent(parms);
    punishMentDataset.Open(sql);
    reloadExtGrid();
   
}

function addPunishMent() {

   var url="20100906171617015620.jsp";
   window.location.href = url;
   
}

function updatePunishMent(grid, rowIndex, e) {

   var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
   var pi_id = row.get("pi_id");
   var url="20100906171617015620.jsp?pi_id="+pi_id;
   window.location.href = url;
   
}

function delPunishMent() {
    
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds('PI_ID', grid);
    if(ids.length==0){
       alert("请选择要删除的记录！");
    }else{
       if(!confirm("确定要删除选择的事项吗？")){
             return;
       }
       var punishArr = PunishMent.checkIsPunishMent(ids);
       if(punishArr.length > 0) {
           var msg = "如下原因导致删除失败！\n\n";
           for(var i = 0; i < punishArr.length; i++) {
               msg += "["+punishArr[i][1]+"] 已经产生办件实例 \n";
           }
           alert(msg);
       } else {
           var rv = PunishMent.delPunishMent(ids);
           if(rv){
              alert("删除数据信息成功！");
           }else{
               alert("删除数据信息失败！");
           }
       }
    }
    reloadExtGrid();
   
}

function chooseBunissUnit(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    $("orgNames").value = $("BU_NAME").value ;
    $("orgIds").value = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAME").value = $("orgNames").value ;
    $("BU_ID").value  = $("orgIds").value ;
}

function resetAll() {

    $("BU_ID").value = "<%=idTmp %>";
    $("BU_NAME").value = "<%=nameTmp %>";
    $("PI_NAME").value = "";
    $("PI_CODE").value = "";
    FormUtil.setRadioGroupValue('PI_STATUS','1');
    $("IC_NAME").value = "-1";
    
}

function excelExport(){
    var title = "处罚事项信息";//标题
     var bu_NAME="执法主体";
    var pi_NAME="事项名称";
    var pi_CODE="事项编码";
    var ic_NAME="事项类别";
    var pi_BRIEF="处罚事项描述";
    var pi_STATUS="状态";
    var id = "PunishMentExport";
  
    var buNames = $("BU_NAME").value.trim();//执法主体名称
    var piNames = $("PI_NAME").value.trim();//事项名称
    var piCodes = $("PI_CODE").value.trim();//事项编码
    var piStates = FormUtil.getRadioGroupValue('PI_STATUS');//状态
    var icNames = $("IC_NAME").value;//事项类别
    if (user_id==1){
         queryIds = PunishMent.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
var queryName = queryIds ;

  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&bu_NAME="+bu_NAME+"&pi_NAME="+pi_NAME+"&pi_CODE="+pi_CODE;
  url+="&ic_NAME="+ic_NAME+"&pi_BRIEF="+pi_BRIEF+"&pi_STATUS="+pi_STATUS+"&id="+id+"&buNames="+buNames;
  url+="&piNames="+piNames+"&piCodes="+piCodes+"&piStates="+piStates+"&icNames="+icNames+"&queryName="+queryName;
  alert(url);
  window.location.href=url;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>IC_NAME</id></combobox><button><id>btnSel</id><id>reset</id><id>btnDCExcel</id><id>btnAdd</id><id>btnDel</id></button><text><id>BU_ID</id><id>BU_NAME</id><id>PI_NAME</id><id>PI_CODE</id><id>orgNames</id><id>orgIds</id></text><dataset><id>punishMentDataset</id></dataset><ExtGrid><id>ExtGrid3</id></ExtGrid></root>" billtaborder="<root><taborder>BU_NAME</taborder><taborder>PI_NAME</taborder><taborder>PI_CODE</taborder><taborder>IC_NAME</taborder><taborder>btnSel</taborder><taborder>reset</taborder><taborder>btnDCExcel</taborder><taborder>btnAdd</taborder><taborder>btnDel</taborder><taborder>BU_ID</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100906165347656127" caption="处罚事项管理" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:8;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:3;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181609484868" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishMent.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishMentDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>处罚事项信息查询</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法主体<INPUT class=input_out id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("chooseBunissUnit();")'></TD>
                     <TD class=c2 width="15%">事项名称</TD>
                     <TD width="35%"><INPUT class=input_out id=PI_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">事项编码</TD>
                     <TD width="35%"><INPUT class=input_out id=PI_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 width="15%">事项类别</TD>
                     <TD vAlign=top width="35%"><DIV id=tm2008style><P><SELECT id=IC_NAME style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%94%CC%A0%96Xr%94%A0%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%B6%98%A8%CC%94%90%B6%98%9C%AC%B2%C0" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></P></DIV></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">是否有效</TD>
                     <TD id=PI_STATUS width="35%" colSpan=3><INPUT type=radio CHECKED value=1 name=RGPI_STATUS text="有效"><SPAN onclick=RGPI_STATUS[0].checked=true;PI_STATUS.value=RGPI_STATUS[0].value;RGPI_STATUS[0].focus();>有效</SPAN>&nbsp;<INPUT type=radio value=0 name=RGPI_STATUS text="无效"><SPAN onclick=RGPI_STATUS[1].checked=true;PI_STATUS.value=RGPI_STATUS[1].value;RGPI_STATUS[1].focus();>无效</SPAN>&nbsp;<INPUT type=radio value="" name=RGPI_STATUS text="全部"><SPAN onclick=RGPI_STATUS[2].checked=true;PI_STATUS.value=RGPI_STATUS[2].value;RGPI_STATUS[2].focus();>全部</SPAN>&nbsp;</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=btnSel style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("queryPunishMent();")'>查询</BUTTON>&nbsp;<BUTTON class=button id=reset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetAll();")'>重置</BUTTON>&nbsp;<BUTTON class=button id=btnDCExcel style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("excelExport();")'>导出excel</BUTTON><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 29px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=addbutton1 id=btnAdd style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addPunishMent();")'>新增</BUTTON>&nbsp;<BUTTON class=sbutton1 id=btnDel style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delPunishMent();")'>删除</BUTTON></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid3 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid3;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid3_retint = 0;
var ExtGrid3_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("punishMentDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid3_retint==0) ExtGrid3_retint = setInterval(ExtGrid3_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid3_retint);ExtGrid3_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("punishMentDataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid3 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid3',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
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
    var grid=ExtGrid3;
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
cm.setHidden(7,true);
cm.setHidden(8,true);
cm.setHidden(9,true);

grid.addListener('rowdblclick', updatePunishMent); ExtGrid3.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid3',obj:ExtGrid3,dataset:'punishMentDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid3_onReady();window.onresize=function(){try{ExtGrid3.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=punishMentDataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>BU_NAME</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>PI_NAME</name><columnWidth2>40</columnWidth2></columnWidth1><columnWidth1><name>IC_NAME</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>PI_BRIEF</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>PI_STATUS</name><columnWidth2>6</columnWidth2></columnWidth1><columnWidth1><name>checked</name><columnWidth2>8</columnWidth2></columnWidth1><columnWidth1><name>PI_CODE</name><columnWidth2>16</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>8</columnWidth2></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>PI_NAME</fieldname><datatype>字符</datatype><displaylabel>事项名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>PI_CODE</fieldname><datatype>字符</datatype><displaylabel>事项编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>16</columnWidth2></columnWidth1></field><field><fieldname>IC_NAME</fieldname><datatype>字符</datatype><displaylabel>事项类别</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>PI_BRIEF</fieldname><datatype>字符</datatype><displaylabel>处罚事项描述</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>PI_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>6</columnWidth2></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IC_ID</fieldname><datatype>字符</datatype><displaylabel>事项类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><BU_NAME></BU_NAME><PI_NAME></PI_NAME><PI_CODE></PI_CODE><IC_NAME></IC_NAME><PI_BRIEF></PI_BRIEF><PI_STATUS></PI_STATUS><PI_ID></PI_ID><BU_ID></BU_ID><IC_ID></IC_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><BU_NAME></BU_NAME><PI_NAME></PI_NAME><PI_CODE></PI_CODE><IC_NAME></IC_NAME><PI_BRIEF></PI_BRIEF><PI_STATUS></PI_STATUS><PI_ID></PI_ID><BU_ID></BU_ID><IC_ID></IC_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><BU_NAME></BU_NAME><PI_NAME></PI_NAME><PI_CODE></PI_CODE><IC_NAME></IC_NAME><PI_BRIEF></PI_BRIEF><PI_STATUS></PI_STATUS><PI_ID></PI_ID><BU_ID></BU_ID><IC_ID></IC_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
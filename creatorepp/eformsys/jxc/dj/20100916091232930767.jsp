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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/SimpleCase.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/SimpleCase.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimpleCaseDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimpleCaseDao.js'></script>");
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
String allZfztId = "";
if (!"1".equals(accesscontroler.getUserID())) {
    allZfztId = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID());
} else {
    allZfztId = orgAccess.getAllBuIds();
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

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

var temp = "";

function init(){
    $('orgIds').value = "<%=idTmp %>";
    $('orgNames').value = "<%=nameTmp %>";
    $("BU_ID").value = $("orgIds").value;
    $("BU_NAME").value = $("orgNames").value;
    temp = $('orgIds').value;
    if(IsSpace(temp)){//当前用户所属部门不是执法主体
        temp = "<%=allZfztId %>";//所有可以访问的执法主体ID
    }
    if(IsSpace(temp)){
        alert("当前用户没有查询权限");
        return;
    }
    //cf_queryCaseList();
    var BU_ID = temp;
        var LTT_NAME = $('LTT_NAME').value.trim();
        var WFT_APPLICATION_NUMBER = $('WFT_APPLICATION_NUMBER').value.trim();
        var LTT_CODE = $('LTT_CODE').value.trim();
        var timeMin = $('timeMin').value;
        var timeMax = $('timeMax').value;
        var pageParms = {
            bu_id : BU_ID,
            ltt_name : LTT_NAME,
            wft_application_number : WFT_APPLICATION_NUMBER,
            ltt_code : LTT_CODE,
            timemin : timeMin,
            timemax : timeMax
        }
            var sql = SimpleCase.findCaseList(pageParms);
            casedataset.Open(sql);
            reloadExtGrid();
}
//查询案件列表
function cf_queryCaseList(){
    if(checkWord()){
        var BU_ID = temp;
        var LTT_NAME = $('LTT_NAME').value.trim();
        var WFT_APPLICATION_NUMBER = $('WFT_APPLICATION_NUMBER').value.trim();
        var LTT_CODE = $('LTT_CODE').value.trim();
        var timeMin = $('timeMin').value;
        var timeMax = $('timeMax').value;
        var pageParms = {
            bu_id : BU_ID,
            ltt_name : LTT_NAME,
            wft_application_number : WFT_APPLICATION_NUMBER,
            ltt_code : LTT_CODE,
            timemin : timeMin,
            timemax : timeMax
        }
            var sql = SimpleCase.findCaseList(pageParms);
            var grid = creator_pt_grids[0].obj;
            GtjjGridOpen(casedataset, sql, 1, 10, grid, ExtGrid2);
            //casedataset.Open(sql);
            //reloadExtGrid();
    } else {
        alert("受理结束时间不能小于受理开始时间");
    }
}

//重置查询条件
function cf_reset(){
    $('orgIds').value = "<%=idTmp %>";
    $('orgNames').value = "<%=nameTmp %>";
    $("BU_ID").value = $("orgIds").value;
    $("BU_NAME").value = $("orgNames").value;
    temp = $('orgIds').value;
    if(IsSpace(temp)){//当前用户所属部门不是执法主体
        temp = "<%=allZfztId %>";//所有可以访问的执法主体ID
    }
    if(IsSpace(temp)){
        alert("当前用户没有查询权限");
        return;
    }

    ${'LTT_NAME'}.value = "";
    ${'WFT_APPLICATION_NUMBER'}.value = "";
    ${'LTT_CODE'}.value = "";
    ${'timeMin'}.value = "";
    ${'timeMax'}.value = "";
}

//数据验证
function checkWord(){
    var flag = false;
    if($('timeMin').value > $('timeMax').value && !IsSpace($('timeMin').value) && !IsSpace($('timeMax').value)){
        flag = false;
    } else {
        flag = true;
    }
    return flag;
}

//跳转到简易程序卷宗界面
function toSimpleCase(grid, rowIndex, e){
   var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
   var wft_Id = row.get("wft_id");
   var bu_id = row.get("bu_id");
   var bu_name = row.get("bu_name");
   var tempPara = "dialogWidth:780px,dialogHeight:250px;";
   var tempURL = "20101011151356812780.jsp?wft_id="+wft_Id+"&flag=1&bu_id=" + bu_id + "&bu_name=" + bu_name;
   window.location.href(tempURL);
   //showModalDialog(tempURL, "window", tempPara);
   reloadExtGrid();
}

//新增
function addJycx(){
    window.location.href = "20100915160103321538.jsp";
}

//打开执法主体资源树
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp?";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_ID").value = $("orgIds").value;
    $("BU_NAME").value = $("orgNames").value;
    temp = $("BU_ID").value;
   }

//分页查询重新回到第一页
/*ExtGrid查询方法
*参数: datasetobj--dataset对象;
      select_sql--查询语句;
      grid_sfcz--是否重置标示(1为重置);
      grid_myhs--每页显示行数;
      gridobj--grid对象
       gridID--grid控件的ID
*返回值: 无
*/
function GtjjGridOpen(datasetobj,select_sql,grid_sfcz,grid_myhs,gridobj,gridID){
    if (grid_sfcz == 1){
        gridID.store.load({params:{start:0, limit:grid_myhs}});//重新定位grid 开始位置
    }
    datasetobj.Open(select_sql);
    reloadExtGrid();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>queryList</id><id>cfreset</id><id>newBtn</id></button><text><id>BU_NAME</id><id>BU_ID</id><id>orgNames</id><id>orgIds</id><id>LTT_NAME</id><id>WFT_APPLICATION_NUMBER</id><id>LTT_CODE</id><id>timeMin</id><id>timeMax</id></text><dataset><id>casedataset</id></dataset><ExtGrid><id>ExtGrid2</id></ExtGrid></root>" billtaborder="<root><taborder>queryList</taborder><taborder>cfreset</taborder><taborder>LTT_NAME</taborder><taborder>WFT_APPLICATION_NUMBER</taborder><taborder>LTT_CODE</taborder><taborder>timeMin</taborder><taborder>timeMax</taborder><taborder>newBtn</taborder><taborder>BU_NAME</taborder><taborder>BU_ID</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100916091232930767" caption="简易程序查询" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:4;text:6;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SimpleCase.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SimpleCaseDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>简易程序案件查询</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法主体</TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=22 controltype="text" onclick='bill_onclick("openUserTree()")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 29px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 23px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=3 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 30px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     <TD class=c2 width="15%">当事人(单位)名称</TD>
                     <TD width="35%"><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">案件编号</TD>
                     <TD width="35%"><INPUT class=input_out id=WFT_APPLICATION_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 width="15%">证件号码</TD>
                     <TD width="35%"><INPUT class=input_out id=LTT_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">受理时间</TD>
                     <TD colSpan=3><INPUT class=its_out id=timeMin style="LEFT: 0px; WIDTH: 125px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" onclick='bill_onclick("SelectDate()")'>&nbsp;至<INPUT class=its_out id=timeMax style="LEFT: 0px; WIDTH: 125px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=queryList style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_queryCaseList()")'>查询</BUTTON><BUTTON class=button id=cfreset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_reset()")'>重置</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV align=right><BUTTON class=addbutton1 id=newBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addJycx()")'>新增</BUTTON></DIV></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid2 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid2;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid2_retint = 0;
var ExtGrid2_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("casedataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid2_retint==0) ExtGrid2_retint = setInterval(ExtGrid2_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid2_retint);ExtGrid2_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("casedataset"), 
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
cm.setHidden(1,true);
cm.setHidden(2,true);
cm.setHidden(8,true);
cm.setHidden(11,true);
grid.addListener('rowdblclick', toSimpleCase);ExtGrid2.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid2',obj:ExtGrid2,dataset:'casedataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid2_onReady();window.onresize=function(){try{ExtGrid2.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD>&nbsp;</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=casedataset format="<fields><field><fieldname>WFT_APPLICATION_NUMBER</fieldname><datatype>字符</datatype><displaylabel>案件编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为</displaylabel><size>255</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>受理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>当事人</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_ID</fieldname><datatype>字符</datatype><displaylabel>阶段ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_NAME</fieldname><datatype>字符</datatype><displaylabel>阶段名称</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_END_DATE</fieldname><datatype>字符</datatype><displaylabel>结案时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_ID</fieldname><datatype>字符</datatype><displaylabel>事项实例状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_ID></WFT_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><RMD_NAME></RMD_NAME><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><NDP_ID></NDP_ID><NDP_NAME></NDP_NAME><WFT_END_DATE></WFT_END_DATE><MIS_ID></MIS_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_ID></WFT_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><RMD_NAME></RMD_NAME><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><NDP_ID></NDP_ID><NDP_NAME></NDP_NAME><WFT_END_DATE></WFT_END_DATE><MIS_ID></MIS_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_ID></WFT_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><RMD_NAME></RMD_NAME><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><NDP_ID></NDP_ID><NDP_NAME></NDP_NAME><WFT_END_DATE></WFT_END_DATE><MIS_ID></MIS_ID></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
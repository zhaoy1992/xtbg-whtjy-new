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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wftId = creator_getQueryString("wft_id");//事项实例ID;
var piId = creator_getQueryString("pi_id");//事项ID
var bu_id = creator_getQueryString("bu_id"); //执法主体ID
var read_only = creator_getQueryString("readOnlyFlag");
var ndpId = parent.ndpId;
var status = "";

/**
 * 初始化函数
 */
function init() {
    loadCheckUserTable();
    initInstrumentsList();
    checkBig();
    initHiddenPage();
}

function wslbReload() {
    location.reload();
}

//查询文书列表
function initInstrumentsList() {
    var sql = PunishInformed.queryInstrumentsList(wftId, ndpId);
    InstrumentsDataset.Open(sql);
}

/**
 * 当事人详细
 * return:checkUserListHtml-String
 */
 function loadCheckUserTable() {
    var parties = PunishInformed.queryPunishParties(wftId, ndpId);
    var tr = null;
    var tdCount = 4;
    document.getElementById("$template1$").style.display = "none";
    document.getElementById("$template2$").style.display = "none";
    for(var i = 0; i < parties.length; i++) {
        if (i % tdCount == 0) {
            tr = HTMLUtil.cloneReplaceElement(document.getElementById("$template1$"), {
                template1 : "tr_id_" + i
            });
        }
        var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
            $INFORMEDUSERID$ : parties[i][0],
            $CHECKEDS$ : "",
            $INFORMEDUSERNAME$ : parties[i][1]
        });
        td.style.display = "block";
        tr.appendChild(td);
        if (i % tdCount == 0) {
            tr.style.display = "block";
            document.getElementById("container").appendChild(tr);
        }
    }
    var count = 0;
    var tempCount = parties.length % tdCount;
    if(tempCount == 0) {
        count = 0;
    } else {
        count = tdCount - tempCount;
    }
    for (var i = 0; i < count; i++) {
        var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
            $INFORMEDUSERID$ : " ",
            $CHECKEDS$ : " ",
            $INFORMEDUSERNAME$ : " "
        });
        td.style.display = "block";
        tr.appendChild(td);
    }
 }
 
function icb(element) {
    if (IsSpace(element.id)) {
        element.style.display = "none";
    }
}

function checkIsInstruments() {
    var userArr = PunishInformed.queryPunishParties(wftId, ndpId);
    var userNameObj = document.getElementsByName("USERNAME");
    for(var i = 0; i < userNameObj.length; i++) {
        userNameObj[i].disabled = false;
        for(var j = 0; j < userArr.length; j++) {
            if(userArr[j][2] == userNameObj[i].id) {
                userNameObj[i].disabled = true;
                userNameObj[i].checked = false;
                break;
            } 
        }
    }
}

//打开选择文书列表
function openWordList(a){
    var url = "../../../eformsys/jxc/dj/20101216090615718050.jsp?wft_id=" + wftId;
    url += "&pi_id=" + piId + "&ndp_id=" + ndpId + "&bu_id=" + bu_id + "&ltt_id=" + a;
    var height = window.screen.availHeight;
    var width = window.screen.availWidth;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    //window.open(url, window,'height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
    var wsObj = showModalDialog(url, window,'height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');   
    return wsObj;
}

//生成文书
function generationInstruments() {
    var flag = false;
    //查询当前事项下当前阶段的所有文书模板
    var templeteArr = PunishInformed.getInstrumentsTemp(piId, ndpId);
    if(templeteArr.length <= 0) {
        alert("处罚事项当前阶段没有配置文书,请配置后再生成文书");
        return;
    }
    //新建所有当事人对象数组
    var userNameObj = document.getElementsByName("USERNAME");
    //新建一个当事人ID数组
    var userIds = new Array();
    for(var i = 0; i < userNameObj.length; i++) {
        if(userNameObj[i].checked == true) {
            userIds[userIds.length] = userNameObj[i].id;
        }
    }
    //没有勾选当事人
    if(userIds.length == 0) {
        if(!confirm("确定要分别生成文书吗？")){
            alert("请选择当事人");
            return;
        }
        flag = true;
        //查询该处罚事项实例当前阶段中所有的当事人是否已生成全部文书
        var userArr = PunishInformed.queryPunishParties(wftId, ndpId);
        for(var j = 0; j < userArr.length; j++){
            userIds[userIds.length] = userArr[j][0];
        }
        
        /*var k = 0;
        for(var j = 0; j < userArr.length; j ++) {
            if(IsSpace(userArr[j][2])) {
                userIds[userIds.length] = userArr[j][0];
                k++;
            }
        }
        if(k == 0) {
            alert("所有的当事人都已生成文书,不要再生成文书");
            return;
        }*/
    }
    //打开选择文书界面
    var WenShuObj = openWordList(userIds);//文书对象
    if(IsSpace(WenShuObj)){
        return;
    }
    /*WenShuObj.rfl_id//文书ID数组
    WenShuObj.rfl_name//文书名称数组
    WenShuObj.rfl_brief_name//文书简称数组
    WenShuObj.mb_id//模板ID数组
    WenShuObj.isTemplate//是否有模板
    WenShuObj.rflTsm//模板存储方式
    */
    var rv = PunishInformed.generationInstruments(piId, wftId, userIds, ndpId, flag, "", WenShuObj);
    if(rv) {
        alert("生成文书成功");
        reloadExtGrid();
        checkBig();
    }    
}

//删除文书
function delInstruments() {
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds('RLD_ID', grid);
    if(ids.length==0){
       alert("请选择要删除的记录！");
    }else{
        if(!confirm("确定要删除选择的文书吗？")){
            return;
        }
        var rv = PunishInformed.delInstruments(ids);
        if(rv){
            alert("删除文书信息成功！");
            reloadExtGrid();
            checkBig();
        }else{
            alert("删除文书信息失败！");
        }
    }
}

function initHiddenPage() {
    if(read_only == "readOnly") {
        $("btnScWs").disabled = true;
        $("delBtn").disabled = true;
    }
}

//打印文书
function printInstruments() {
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds('RLD_ID', grid);
    if(ids.length==0){
       alert("请选择要打印的文书！");
    }else{
    
    }
}

//预览文书20101110145308843964 
                 //文书流水，当事人姓名，当事人ID
function readWenShu(rld_id, ltt_Names, ltt_Ids){

    var nowDate = getNowDate();//获取当前日期

    //查询当前记录的文书号
    var result = PunishInformed.findRld_Instrument_NoByRld_id(rld_id);
    var WenShuNumber = result[0][0];
    var mbId = result[0][1];
    //查询word实例ID
    var wordInstanceId = PunishInformed.QueryWordInstanceId(rld_id);
    if(read_only == "readOnly"){
        status = "readOnly";
    }
    if(!IsSpace(wordInstanceId)){//已生成word实例
        var url = "20101110145308843964.jsp?wft_id="+wftId+"&wordInstanceId="+wordInstanceId;
        url += "&mb_id="+mbId+"&status=" + status;
        var width = window.screen.availWidth;
        var height = window.screen.availHeight;
        var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
        window.showModalDialog(url,window,tempPara);
        return;
    }

    var url = "20101110145308843964.jsp?wft_id="+wftId+"&mb_id="+mbId;
    //文书编号，当事人ID，当事人姓名 
    
     url += "&WenShuNumber="+WenShuNumber+"&bl_ltt_Info="+ltt_Names+"@@@"+ltt_Ids;
    url += "&bl_NowDate="+nowDate;
    url += "&status=write&WenShuLiuShui="+rld_id+"&wordInstanceId="+wordInstanceId;

    var width = window.screen.availWidth;
    var height = window.screen.availHeight;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
    reloadExtGrid();
}

//获取当前服务器时间
function getNowDate(){
    var nowYear = FormUtil.getServerYear();//获取当前服务器年
    var nowMonth = FormUtil.getServerMonth();//获取当前服务器月
    var nowDay = FormUtil.getServerDay();//获取当前服务器日
    if(parseInt(nowMonth) < 10){
        nowMonth = "0" + nowMonth;
    }
    if(parseInt(nowDay) < 10){
        nowDay = "0" + nowDay;
    }
    var nowDate = nowYear + "年" + nowMonth + "月" + nowDay + "日";
    return nowDate;
}

//判断可选文书数量与当事人已选文书数量的大小
function checkBig(){
    var canChoose = PunishInformed.countRldByNdp_id(wftId, ndpId);//可选数量
    var alreadyChoose = PunishInformed.countRldByLttAndNdp(wftId, ndpId);//已选数量
    var userNameObj = document.getElementsByName("USERNAME");
    for(var i = 0; i < userNameObj.length; i++) {
        userNameObj[i].disabled = false;
        for(var j = 0; j < alreadyChoose.length; j++) {
            //已生成了所有文书
            if(alreadyChoose[j][0] == userNameObj[i].id && alreadyChoose[j][1] == canChoose) {
                userNameObj[i].disabled = true;
                userNameObj[i].checked = false;
                break;
            } 
        }
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><div><id>div1</id></div><button><id>btnScWs</id><id>delBtn</id></button><dataset><id>InstrumentsDataset</id></dataset><ExtGrid><id>ExtGrid2</id></ExtGrid></root>" billtaborder="<root><taborder>btnScWs</taborder><taborder>delBtn</taborder></root>" dj_sn="20100914162139543666" caption="文书列表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:1;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:3;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:1;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInformed.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE style="WIDTH: 100%; POSITION: static; HEIGHT: 397px" cellSpacing=2 cellPadding=1 width=870 align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=3>生成案件对应文书</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">当事人</TD>
                     <TD width="65%">
                        <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                           <TBODY id=container>
                              <TR id=$template1$>
                                 <TD id=$template2$ align=middle width="25%"><INPUT id=$INFORMEDUSERID$ type=checkbox value=$INFORMEDUSERNAME$ name=USERNAME callback="icb" $CHECKEDS$></INPUT>$INFORMEDUSERNAME$</TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </TD>
                  <TD width="20%"><BUTTON class=button id=btnScWs style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("generationInstruments();")'>生成文书</BUTTON><BUTTON class=button id=delBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delInstruments();")'>删除文书</BUTTON></TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
   <TR>
      <TD><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 338px" onmovestart=moveStart() controltype="div" NotBg="否"><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid2 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid2;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid2_retint = 0;
var ExtGrid2_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("InstrumentsDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid2_retint==0) ExtGrid2_retint = setInterval(ExtGrid2_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid2_retint);ExtGrid2_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("InstrumentsDataset"), 
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
					height: eval(parseFloat(document.getElementById('div1').style.height)*(parseFloat('100%')))/100-60,
		split: true,
		region: 'north',
		title:'文书列表',
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
cm.setHidden(4,true);
cm.setHidden(5,true);
ExtGrid2.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid2',obj:ExtGrid2,dataset:'InstrumentsDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid2_onReady();</SCRIPT></DIV></TD>
   </TR>
</TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=InstrumentsDataset showtypeXml="<root><showType><name>RLD_ID</name><showRule>undefined</showRule></showType><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7BRule%3A%27%24%7Bsdf%7D%3D%3D%22bb%22%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u201D%u6309%u94AE%u201D%20/%3E%27%7D%5D</showRule></showType><showType><name>baocun</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20v1%3D%24%7Brld_id%7D%20v2%3D%24%7Bltt_name%7D%20v3%3D%24%7Bltt_id%7D%20onclick%3DreadWenShu%28this.v1%2Cthis.v2%2Cthis.v3%29%20/%3E%27%7D%5D</showRule></showType><showType><name>dayin</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20/%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>RLD_TITLE</name><columnWidth2>40</columnWidth2></columnWidth1><columnWidth1><name>RLD_INSTRUMENT_NO</name><columnWidth2>40</columnWidth2></columnWidth1><columnWidth1><name>checked</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>LTT_NAME</name><columnWidth2>40</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>RLD_TITLE</fieldname><datatype>字符</datatype><displaylabel>文书名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>RLD_INSTRUMENT_NO</fieldname><datatype>字符</datatype><displaylabel>文书编号</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>对应当事人</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>RLD_ID</fieldname><datatype>字符</datatype><displaylabel>发布文书流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>字符</datatype><displaylabel>对应当事人ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>baocun</fieldname><datatype>字符</datatype><displaylabel>打印文书</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20v1%3D%24%7Brld_id%7D%20v2%3D%24%7Bltt_name%7D%20v3%3D%24%7Bltt_id%7D%20onclick%3DreadWenShu%28this.v1%2Cthis.v2%2Cthis.v3%29%20/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
					
			s=0;
			mtJsFileArray("iWebOffice2006/js/iWebOffice2006.js", true, eppDataWrObj);
		
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

<!-- 提示：以下为WebOffice事件处理代码 --><%@ include file="../../../iWebOffice2006/js/iWebOffice2006Event.jsp"%>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordControl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordControl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/VariableDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/VariableDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var iWebOffice = null;
var mb_id = creator_getQueryString("mb_id")== "null"?"":creator_getQueryString("mb_id");//模版ID
window.attachEvent("onload", function () {
    $("WebOffice1").attachEvent("onresize", function() {
        var WebOfficeDiv = $("WebOffice1");
        WebOfficeDiv.firstChild.style.height = parseInt(WebOfficeDiv.offsetHeight) - parseInt(WebOfficeDiv.firstChild.style.top) - 1 + "px";
        WebOfficeDiv.firstChild.style.width = parseInt(WebOfficeDiv.offsetWidth) + "px";
    });
    init();
});
var appUserName = "";
function init() {
    iWebOffice = document.getElementsByName("WebOffice")[0];
    iWebOffice.WebUrl = fcpubdata.mServerUrl; //设置控件与服务器交互的url地址
    iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
    iWebOffice.EditType = "1,0"; //设置编辑状态
    iWebOffice.ShowType = "1"; //设置显示状态
    iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
    iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
    iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
    iWebOffice.Language="CH"; //设置界面显示语言
    iWebOffice.UserName = getSysElement("userName"); //设置用户名
    var currentSystemID = creator_getSession("subsystem_id"); //设置应用id
    if (!IsSpace(currentSystemID) && currentSystemID != "module") {
        appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
    }
    //查询Word报表实例是否存在
    if(IsSpace(appUserName)){
        appUserName = "dzzwpt.";
    }
    var mbCount = DBUtil.SqlToField("select count(recordid) from " + appUserName + "td_octl_template_file where recordid='word"+mb_id+"'");
    if(mbCount == 0) {
        createOrUpdateWordReport();
    } else {
        combakTemplet();
    }    
}

function combakTemplet() {
    iWebOffice.Template = "word"+mb_id; //这是模板id
    iWebOffice.WebOpen();
}

/**
 * 给变量赋值
 */
function giveVariablesValue() {
    if(mb_id == "") {
        mb_id = parent.frames["rightFrame"].$("mb_id").value;
    }
    return mb_id;
}

/**
 * 给一个新文档
 */
function createOrUpdateWordReport() {
    if (!iWebOffice.WebLoadTemplate()) { //加载对应的Word模板
        iWebOffice.CreateFile(); //容错处理，默认创建一个文档
    }
}

/**
 * 保存文档
 */
function saveTemplet() {
    giveVariablesValue();
    if(mb_id == "" || mb_id == "null") {
        alert("模版基本信息未保存，请先保存");
        return;
    }
    iWebOffice.Template = "word"+mb_id; //这是模板id
    iWebOffice.FileName = mb_id+ ".doc"; //设置文件名
     var msg = iWebOffice.WebSaveTemplate(true);//平台方法
    if(msg) {
        alert("模版保存成功");
    } else {
        alert("模版保存失败");
    }
}

/**
 * 预览文档
 */
function checkTemplet() {
    var mbId = giveVariablesValue(); //模版基础信息ID
    if(IsSpace(mbId)){
        alert("请先保存模板");
        return;
    }
    var url = "20101124143257625133.jsp?mb_id="+mbId+"";
    url += "&abc=1507,1508,1509";
    var width = window.screen.availWidth;
    var height = window.screen.availHeight;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
}

function close_window(){
    window.close();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><button><id>saveBtn</id><id>btnCheck</id><id>btnClose</id></button></root>" billtaborder="<root><taborder>saveBtn</taborder><taborder>btnCheck</taborder><taborder>btnClose</taborder></root>" dj_sn="20101115101610484158" caption="word模版编辑器main" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:4;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101027105323156235" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Variable.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Dataset.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/WordControl.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/VariableDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid>item0</iframeid><index>1</index><gridid></gridid><iframeid>item1</iframeid><index>2</index><gridid></gridid><iframeid>item2</iframeid></content></tab></tabs>">

<TABLE height="100%" width="100%" border=1>
   <TBODY>
      <TR>
         <TD><DIV id=WebOffice1 style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; TOP: 0px; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="WebOffice"><OBJECT id=WebOffice_WebOffice1 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: -22px; HEIGHT: 100%" codeBase=../../../iWebOffice2006/iWebOffice2006.cab#version=<%=iWebOfficeVersion%> classid=clsid:8B23EA28-723C-402F-92C4-59BE0E063499 name=WebOffice><PARAM NAME="Visible" VALUE="-1"><PARAM NAME="Caption" VALUE="HandWriteCtrl"><PARAM NAME="Color" VALUE="4278190095"><PARAM NAME="Font" VALUE="MS Sans Serif"><PARAM NAME="HelpFile" VALUE=""><PARAM NAME="Enabled" VALUE="-1"><PARAM NAME="RecordID" VALUE=""><PARAM NAME="UserName" VALUE="未定义"><PARAM NAME="EditType" VALUE=""><PARAM NAME="PenColor" VALUE="#FF0000"><PARAM NAME="PenWidth" VALUE="2"><PARAM NAME="Print" VALUE="0"><PARAM NAME="WebUrl" VALUE="http://172.16.17.229:7000/creatorepp/eformsys/fceform/design/"><PARAM NAME="ExtParam" VALUE=""><PARAM NAME="ShowTools" VALUE="-1"><PARAM NAME="HideName" VALUE=""><PARAM NAME="Template" VALUE=""><PARAM NAME="FileName" VALUE=""><PARAM NAME="FileType" VALUE=".doc"><PARAM NAME="Status" VALUE=""><PARAM NAME="Copyright" VALUE="iWebOffice 9.2.0.0-1tDRttPKtefXydGvyei8xtS609DP3rmry75b16jTw10gICAguv7Ez7/GtLTQxc+iW7y8yvXWp7PWXTs7RVg9Q1VTVE9NRVJfVUNfNDtWUD1GYWxzZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPUZhbHNlO0ZDPTQ7"><PARAM NAME="ShowMenu" VALUE="-1"><PARAM NAME="Modify" VALUE="0"><PARAM NAME="CopyType" VALUE="-1"><PARAM NAME="ShowToolBar" VALUE="-1"><PARAM NAME="ShowTitle" VALUE="-1"><PARAM NAME="BodyStyle" VALUE="1"><PARAM NAME="InputText" VALUE=""><PARAM NAME="Zoom" VALUE="100"><PARAM NAME="ClearType" VALUE="0"><PARAM NAME="EnablePrint" VALUE="-1"><PARAM NAME="ShowType" VALUE="1"><PARAM NAME="ToolsSpace" VALUE="-1"><PARAM NAME="ClearPages" VALUE="-1"><PARAM NAME="Compressed" VALUE="0"><PARAM NAME="MaxFileSize" VALUE="8192"><PARAM NAME="ShowUsers" VALUE="-1"><PARAM NAME="ShowWindow" VALUE="0"><PARAM NAME="ShowAllUsers" VALUE="-1"><PARAM NAME="Office2007Ribbon" VALUE="-1"><PARAM NAME="RibbonUIXml" VALUE=""><PARAM NAME="ShortCutKey" VALUE="CTRL+S"><PARAM NAME="ChangeSize" VALUE="-1"><PARAM NAME="Encrypted" VALUE="0"><PARAM NAME="Binary" VALUE=""><PARAM NAME="PopInputWindow" VALUE="0"><PARAM NAME="FontName" VALUE="宋体"><PARAM NAME="FontSize" VALUE="12"><PARAM NAME="FontColor" VALUE="255"><PARAM NAME="ShowPages" VALUE=""></OBJECT></DIV></TD>
      </TR>
      <TR>
         <TD height=40><DIV align=center><BUTTON id=saveBtn style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveTemplet()")'>保存模板</BUTTON><BUTTON id=btnCheck style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("checkTemplet();")'>预览</BUTTON><BUTTON id=btnClose style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("close_window()")'>关闭</BUTTON></DIV></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
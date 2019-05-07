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
var mb_id = creator_getQueryString("mb_id")== "null"?"":creator_getQueryString("mb_id");//模版ID
var FINGERPRINT = "74826222436241851208";
autoUrlParam(); //解析Url传递的参数

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
    var appUserName = ""; //应用名称
    if (!IsSpace(currentSystemID) && currentSystemID != "module") {
        appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
    }
    //查询Word报表实例是否存在
    if(IsSpace(appUserName)){
        appUserName = "dzzwpt.";
    }
    var sql = "select count(recordid) from " + appUserName + "td_octl_template_file where recordid='word"+trim(mb_id)+"'";
    var mbCount = DBUtil.SqlToField(sql);
    if(mbCount == 0) {
        //createOrUpdateWordReport();
    } else {
        combakTemplet();
    }  
    checkTemplet();  
}

function combakTemplet() {
    iWebOffice.Template = "word"+trim(mb_id); //这是模板id
    iWebOffice.WebOpen();
}

/**
 * 预览文档
 */
function checkTemplet() {
    var sql_result = WordControl.selectWordControl("all", trim(mb_id));
    var wcResult = DBUtil.getQueryArray(sql_result, 0, -1); //模版控件信息
    for(var i=0; i<wcResult.length; i++) {
        var kj_name = wcResult[i][1];
        var value = wcResult[i][3];
        var value_type = wcResult[i][4];
        var kj_type = wcResult[i][7];
        var bl_value = "";
        var name = "";
        if(kj_type == "autoText") { //如果控件是自动文本
              if(value_type =="变量") {
                //通过变量ID得到变量名称
                  bl_name = Variable.getVariablesNameByBLId(value);
                bl_value = "    ";
                name = "at_"+kj_name;
            } else if (value_type =="数据集") {
                var bl_sql = Dataset.getDatasetValueByBLId(value);
                bl_value = DBUtil.SqlToField(bl_sql); 
                name = "at_"+kj_name;
            }
            setAutoTextValue(iWebOffice.WebObject,name,bl_value); //设置自动填写文本域的值
         }
        if(kj_type == "orderlyTable") { //如果控件是有序表格
              if(value_type =="变量") {
                //通过变量ID得到变量名称
                  bl_name = Variable.getVariablesNameByBLId(value);
                bl_value = "     ";   
                name = "ot_"+kj_name;
            } else if (value_type =="数据集") {
                var bl_sql = Dataset.getDatasetValueByBLId(value);
                bl_value = DBUtil.getQueryArray(bl_sql, 0, -1); 
                name = "ot_"+kj_name;
            }
            setAutoOrderlyTable(iWebOffice.WebObject,name,bl_value); //设置有序表格的值
         }
        if(kj_type == "textInput") { //如果控件是输入文本
              if(value_type =="变量") {
                //通过变量ID得到变量名称
                  bl_name = Variable.getVariablesNameByBLId(value);
                bl_value = "     ";                 
                name = "ti_"+kj_name;
            } else if (value_type =="数据集") {
                var bl_sql = Dataset.getDatasetValueByBLId(value);
                bl_value = DBUtil.SqlToField(bl_sql); 
                name = "ti_"+kj_name;
            }
            setTextInputValue(iWebOffice.WebObject,name,bl_value); //设置输入文本域的值
         }
        if(kj_type == "dropDown") { //如果控件是下拉列表
              if(value_type =="变量") {
                //通过变量ID得到变量名称
                  bl_name = Variable.getVariablesNameByBLId(value);
                bl_value = "     ";    
                name = "dd_"+kj_name;
            } else if (value_type =="数据集") {
                var bl_sql = Dataset.getDatasetValueByBLId(value);
                bl_value = DBUtil.SqlToField(bl_sql); 
                name = "dd_"+kj_name;
            }
            setDropDownValue(iWebOffice.WebObject,name,bl_value); //设置下拉框Selected域的值
         }
    }
    documentProtect(iWebOffice.WebObject, FINGERPRINT);
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>btnClose</id></button></root>" billtaborder="<root><taborder>btnClose</taborder></root>" dj_sn="20101124143257625133" caption="WORD预览" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101027105323156235" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Variable.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Dataset.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/WordControl.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/VariableDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js">

<TABLE height="100%" width="100%" border=1>
   <TBODY>
      <TR>
         <TD><DIV id=WebOffice1 style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; TOP: 0px; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="WebOffice"><OBJECT id=WebOffice_WebOffice1 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: -22px; HEIGHT: 100%" codeBase=../../../iWebOffice2006/iWebOffice2006.cab#version=<%=iWebOfficeVersion%> classid=clsid:8B23EA28-723C-402F-92C4-59BE0E063499 name=WebOffice><PARAM NAME="Visible" VALUE="-1"><PARAM NAME="Caption" VALUE="HandWriteCtrl"><PARAM NAME="Color" VALUE="4278190095"><PARAM NAME="Font" VALUE="MS Sans Serif"><PARAM NAME="HelpFile" VALUE=""><PARAM NAME="Enabled" VALUE="-1"><PARAM NAME="RecordID" VALUE=""><PARAM NAME="UserName" VALUE="未定义"><PARAM NAME="EditType" VALUE=""><PARAM NAME="PenColor" VALUE="#FF0000"><PARAM NAME="PenWidth" VALUE="2"><PARAM NAME="Print" VALUE="0"><PARAM NAME="WebUrl" VALUE="http://172.16.17.229:7000/creatorepp/eformsys/fceform/design/"><PARAM NAME="ExtParam" VALUE=""><PARAM NAME="ShowTools" VALUE="-1"><PARAM NAME="HideName" VALUE=""><PARAM NAME="Template" VALUE=""><PARAM NAME="FileName" VALUE=""><PARAM NAME="FileType" VALUE=".doc"><PARAM NAME="Status" VALUE=""><PARAM NAME="Copyright" VALUE="iWebOffice 9.2.0.0-1tDRttPKtefXydGvyei8xtS609DP3rmry75b16jTw10gICAguv7Ez7/GtLTQxc+iW7y8yvXWp7PWXTs7RVg9Q1VTVE9NRVJfVUNfNDtWUD1GYWxzZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPUZhbHNlO0ZDPTQ7"><PARAM NAME="ShowMenu" VALUE="-1"><PARAM NAME="Modify" VALUE="0"><PARAM NAME="CopyType" VALUE="-1"><PARAM NAME="ShowToolBar" VALUE="-1"><PARAM NAME="ShowTitle" VALUE="-1"><PARAM NAME="BodyStyle" VALUE="1"><PARAM NAME="InputText" VALUE=""><PARAM NAME="Zoom" VALUE="100"><PARAM NAME="ClearType" VALUE="0"><PARAM NAME="EnablePrint" VALUE="-1"><PARAM NAME="ShowType" VALUE="1"><PARAM NAME="ToolsSpace" VALUE="-1"><PARAM NAME="ClearPages" VALUE="-1"><PARAM NAME="Compressed" VALUE="0"><PARAM NAME="MaxFileSize" VALUE="8192"><PARAM NAME="ShowUsers" VALUE="-1"><PARAM NAME="ShowWindow" VALUE="0"><PARAM NAME="ShowAllUsers" VALUE="-1"><PARAM NAME="Office2007Ribbon" VALUE="-1"><PARAM NAME="RibbonUIXml" VALUE=""><PARAM NAME="ShortCutKey" VALUE="CTRL+S"><PARAM NAME="ChangeSize" VALUE="-1"><PARAM NAME="Encrypted" VALUE="0"><PARAM NAME="Binary" VALUE=""><PARAM NAME="PopInputWindow" VALUE="0"><PARAM NAME="FontName" VALUE="宋体"><PARAM NAME="FontSize" VALUE="12"><PARAM NAME="FontColor" VALUE="255"><PARAM NAME="ShowPages" VALUE=""></OBJECT></DIV></TD>
      </TR>
      <TR>
         <TD height=40><DIV align=center><BUTTON id=btnClose style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("window.close();")'>关闭</BUTTON></DIV></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
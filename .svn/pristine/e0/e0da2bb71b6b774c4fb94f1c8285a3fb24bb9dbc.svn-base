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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordReport.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordReport.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var mb_id = "25";//creator_getQueryString("mb_id");//模版ID

/*
    描述：初始化
*/
function init() {
    if(mb_id != "") {
        getTempLateInfo(); //如果是编辑，取模版
    }
    //默认加载第一个TAB
    item0.location.href="../../jxc/dj/20101109154944703248.jsp?mb_id="+mb_id;
}

/*
    描述：得到word模版信息
*/
function getTempLateInfo() {
    var template_result =  WordReport.getWordReport(mb_id);
    $("module_name").value = template_result[0][1];
    $("module_remark").value = template_result[0][2];
}

/*
    描述：添加/修改模版
*/
function saveWordReport() {
    var module_name = $("module_name").value;
    var module_remark = $("module_remark").value;
    if(!validate()){
        return;
    }
    var returnValue = WordReport.addWordReport(module_name,module_remark);
    if(returnValue == true) {
        alert("保存成功");
    } else {
        alert("保存失败");
    }
}

function validate() {
    var module_name = $("module_name").value;
    if(mb_id == "") {
        var num = WordReport.isWordReportOnlyOne(module_name);
        if(parseInt(num) != 0) {
            alert("WORD模版名称相同，请重新输入");
            return false;
        }
    }
    return true;
}

/*
    描述：动态改变TAB的URL
*/
function PubClickPageControl(index) {
    if (!PubClickPageControl["$" + index]) {
        var djbh = objDjbh();
        var obj= {item : "item"+index+""};
        eval(obj.item).location.href="../../jxc/dj/"+djbh[index]+".jsp?mb_id="+mb_id;
        PubClickPageControl["$" + index] = true;
    }
}

function objDjbh() {
    var djbh = [];
    djbh.add('20101109154944703248'); //规则项
    djbh.add('20101027115126187507'); //变量
    djbh.add('20101027140900921017'); //数据集
    return djbh;
}

//autoText属性对话框
function autoTextWindow() {
    var webOffice = document.getElementsByName("WebOffice")[0];
    var url = "20101109103344984109.jsp?mb_id="+mb_id+"&kj_type=autoText&webOffice="+webOffice+"";
    features = "dialogWidth:400px;dialogHeight:250px;";
    var returnValue = window.showModalDialog(url,window,features);
    if(returnValue) {
         item0.kjQueryOut("autoText",mb_id);
    }
}

//orderlyTable属性对话框
function orderlyTableWindow() {
    var url = "20101109103344984109.jsp?mb_id="+mb_id+"&kj_type=orderlyTable";
    features = "dialogWidth:400px;dialogHeight:250px;";
    var returnValue = window.showModalDialog(url,window,features);
    if(returnValue) {
        item0.kjQueryOut("orderlyTable",mb_id);
    }
}

//textInput属性对话框
function textInputWindow() {
    var url = "20101109103344984109.jsp?mb_id="+mb_id+"&kj_type=textInput";
    features = "dialogWidth:400px;dialogHeight:350px;";
    var returnValue = window.showModalDialog(url,window,features);
    if(returnValue) {
        item0.kjQueryOut("textInput",mb_id);
    }
}

//dropDown属性对话框
function dropDownWindow() {
    var url = "20101109103344984109.jsp?mb_id="+mb_id+"&kj_type=dropDown";
    features = "dialogWidth:400px;dialogHeight:350px;";
    var returnValue = window.showModalDialog(url,window,features);
    if(returnValue) {
        item0.kjQueryOut("dropDown",mb_id);
    }
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>module_remark</id></textarea><img><id>img1</id><id>img2</id><id>img3</id><id>img4</id></img><tab><id>tab1</id></tab><div><id>div1</id></div><button><id>btnSave</id></button><text><id>module_name</id></text><creatorSubForm><id>item0</id><id>item1</id><id>item2</id></creatorSubForm></root>" billtaborder="<root><taborder>module_remark</taborder><taborder>module_name</taborder><taborder>btnSave</taborder></root>" dj_sn="20101027105537984958" caption="word模版编辑器" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:4;SKBILLgrid:0;shape:0;tab:1;div:0;DsMain_field:0;a:0;button:1;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101027105323156235" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Dataset.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Variable.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/WordReport.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/WordReportDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid>item0</iframeid><index>1</index><gridid></gridid><iframeid>item1</iframeid><index>2</index><gridid></gridid><iframeid>item2</iframeid></content></tab></tabs>">

<TABLE height="100%" width="100%" border=1>
   <TBODY>
      <TR>
         <TD height=20>word模版编辑器</TD>
      </TR>
      <TR height="100%">
         <TD>
            <TABLE height="100%" width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD colSpan=3><IMG id=img1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="" controltype="img" onclick='bill_onclick("autoTextWindow();")' cover="9" srcsk><IMG id=img2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="" controltype="img" onclick='bill_onclick("orderlyTableWindow();")' cover="9" srcsk><IMG id=img3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="" controltype="img" onclick='bill_onclick("textInputWindow();")' cover="9" srcsk><IMG id=img4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="" controltype="img" onclick='bill_onclick("dropDownWindow();")' cover="9" srcsk></TD>
                  </TR>
                  <TR>
                     <TD width="60%" rowSpan=6><DIV id=WebOffice2 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 10px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 100%; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 71px; HEIGHT: 500px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="WebOffice"><OBJECT id=WebOffice_WebOffice2 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 1px; HEIGHT: 100%" codeBase=../../../iWebOffice2006/iWebOffice2006.cab#version=<%=iWebOfficeVersion%> classid=clsid:8B23EA28-723C-402F-92C4-59BE0E063499 name=WebOffice><PARAM NAME="Visible" VALUE="-1"><PARAM NAME="Caption" VALUE="HandWriteCtrl"><PARAM NAME="Color" VALUE="4278190095"><PARAM NAME="Font" VALUE="MS Sans Serif"><PARAM NAME="HelpFile" VALUE=""><PARAM NAME="Enabled" VALUE="-1"><PARAM NAME="RecordID" VALUE=""><PARAM NAME="UserName" VALUE="未定义"><PARAM NAME="EditType" VALUE=""><PARAM NAME="PenColor" VALUE="#FF0000"><PARAM NAME="PenWidth" VALUE="2"><PARAM NAME="Print" VALUE="0"><PARAM NAME="WebUrl" VALUE="http://172.16.17.229:7000/creatorepp/eformsys/fceform/design/"><PARAM NAME="ExtParam" VALUE=""><PARAM NAME="ShowTools" VALUE="-1"><PARAM NAME="HideName" VALUE=""><PARAM NAME="Template" VALUE=""><PARAM NAME="FileName" VALUE=""><PARAM NAME="FileType" VALUE=".doc"><PARAM NAME="Status" VALUE=""><PARAM NAME="Copyright" VALUE="iWebOffice 9.2.0.0-1tDRttPKtefXydGvyei8xtS609DP3rmry75b16jTw10gICAguv7Ez7/GtLTQxc+iW7y8yvXWp7PWXTs7RVg9Q1VTVE9NRVJfVUNfNDtWUD1GYWxzZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPUZhbHNlO0ZDPTQ7"><PARAM NAME="ShowMenu" VALUE="-1"><PARAM NAME="Modify" VALUE="0"><PARAM NAME="CopyType" VALUE="-1"><PARAM NAME="ShowToolBar" VALUE="-1"><PARAM NAME="ShowTitle" VALUE="-1"><PARAM NAME="BodyStyle" VALUE="1"><PARAM NAME="InputText" VALUE=""><PARAM NAME="Zoom" VALUE="100"><PARAM NAME="ClearType" VALUE="0"><PARAM NAME="EnablePrint" VALUE="-1"><PARAM NAME="ShowType" VALUE="1"><PARAM NAME="ToolsSpace" VALUE="-1"><PARAM NAME="ClearPages" VALUE="-1"><PARAM NAME="Compressed" VALUE="0"><PARAM NAME="MaxFileSize" VALUE="8192"><PARAM NAME="ShowUsers" VALUE="-1"><PARAM NAME="ShowWindow" VALUE="0"><PARAM NAME="ShowAllUsers" VALUE="-1"><PARAM NAME="Office2007Ribbon" VALUE="-1"><PARAM NAME="RibbonUIXml" VALUE=""><PARAM NAME="ShortCutKey" VALUE="CTRL+S"><PARAM NAME="ChangeSize" VALUE="-1"><PARAM NAME="Encrypted" VALUE="0"><PARAM NAME="Binary" VALUE=""><PARAM NAME="PopInputWindow" VALUE="0"><PARAM NAME="FontName" VALUE="宋体"><PARAM NAME="FontSize" VALUE="12"><PARAM NAME="FontColor" VALUE="255"><PARAM NAME="ShowPages" VALUE=""></OBJECT></DIV></TD>
                     <TD width="40%" colSpan=2>模版基本信息</TD>
                  </TR>
                  <TR>
                     <TD width="15%">模版名称<FONT color=red>*</FONT></TD>
                     <TD width="25%"><INPUT id=module_name style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD>描述</TD>
                     <TD><TEXTAREA id=module_remark style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD align=right colSpan=2><BUTTON id=btnSave style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveWordReport();")'>保存</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>模版定义信息</TD>
                  </TR>
                  <TR>
                     <TD colSpan=2 height=400><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: auto; LEFT: 0px; OVERFLOW-X: auto; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 400px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab1 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 345px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 327px"><H2 class=tab>规则项</H2><IFRAME id=item0 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load="3" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/201009.jsp?1=1&amp;name=&amp;"></IFRAME></DIV><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 327px"><H2 class=tab>变量</H2><IFRAME id=item1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url="../../jxc/dj/20101027115126187507.jsp?1=1&amp;name=&amp;"></IFRAME></DIV><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 327px"><H2 class=tab>数据集</H2><IFRAME id=item2 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url="../../jxc/dj/20101027140900921017.jsp?1=1&amp;name=&amp;"></IFRAME></DIV></DIV><SCRIPT>var tab1 = new WebFXTabPane( document.getElementById( "tab1" ) );</SCRIPT></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD colSpan=3>
            <TABLE width=750 border=1>
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
</DIV>
<div id='grid_tip'></div></body></html>
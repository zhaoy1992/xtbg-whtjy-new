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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/xtbg/js/PubFun.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/xtbg/js/PubFun.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/xtbg/js/Validate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/xtbg/js/Validate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
function prevOperation(source) {
	for (var i = 0; i < source.length; i++) {
		source[i] = source[i].substring(1,source[i].length - 1);
	}
}
function addOptions(selectId,values,innerTexts) {
	if (values.length != innerTexts.length)
		return;
	for (var i = 0; i < values.length; i++) {
		var option = document.createElement("OPTION");
		selectId.options.add(option);
		option.innerText = innerTexts[i];
		option.value = values[i];
	}
}
function setInnerHTML(id,value) {
	document.getElementById(id).innerHTML = value;
}
function init() {
	var businessType = dialogArguments.businessType;
	var userId = dialogArguments.userId;
	setInnerHTML('man',dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditManCaptionIndex]);
	setInnerHTML('time',dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditTimeCaptionIndex]);
	setInnerHTML('idea',dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditIdeaCaptionIndex]);
	auditIdea.value = dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditIdeaIndex];
	if (auditIdea.value == "$null$")
		auditIdea.value = "";
	textMan.value = dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditManIndex];
	textTime.value = dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditTimeIndex];
}
function setAuditIdea() {
	if (auditIdea.value.length == 0)
		auditIdea.value = "$null$";
	if (!checkInputIdea(auditIdea.value))
	{
		return;
	}
	if (auditIdea.value.lengthCH() > 500) {
		alert("您填写的意见长度不能超过500个字符！");
		return;
	}
	dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditIdeaIndex] = auditIdea.value;
	dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditManIndex] = textMan.value;
	dialogArguments.contextInfo[dialogArguments.currentIndex][dialogArguments.auditTimeIndex] = textTime.value;
	CloseBill();
}
function addIdea() {
	auditIdea.value = auditIdea.value + combobox1.value;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>auditIdea</id></textarea><combobox><id>combobox1</id></combobox><button><id>button2</id></button><text><id>textMan</id><id>textTime</id></text></root>" billtaborder="<root><taborder>auditIdea</taborder><taborder>combobox1</taborder><taborder>button2</taborder><taborder>textMan</taborder><taborder>textTime</taborder></root>" dj_sn="20090903160143250478" caption="公用意见处理" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue1" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090901175633734792" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;../../../ccapp/xtbg/js/PubFun.js&#13;&#10;../../../ccapp/xtbg/js/Validate.js&#13;&#10;fcdate.js">

<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD><DIV align=center>
               <TABLE cellSpacing=0 cellPadding=0 width=400 border=0>
                  <TBODY>
                     <TR>
                        <TD>
                           <TABLE class=formtable cellSpacing=0 cellPadding=0 width="100%" border=1>
                              <TBODY>
                                 <TR>
                                    <TD class=tdLabel id=man width="20%"></TD>
                                    <TD width="20%"><INPUT class=nolinetext id=textMan style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                                    <TD class=tdLabel id=time width="20%"></TD>
                                    <TD colSpan=2><INPUT class=nolinetext id=textTime style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                                 </TR>
                                 <TR>
                                    <TD class=tdLabel id=idea colSpan=5></TD>
                                 </TR>
                                 <TR>
                                    <TD colSpan=5><TEXTAREA id=auditIdea style="LEFT: 329px; WIDTH: 399px; POSITION: static; TOP: 112px; HEIGHT: 165px" onmovestart=moveStart() rows=3 cols=78 controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                                 </TR>
                                 <TR>
                                    <TD class=tdLabel width="20%">常用意见</TD>
                                    <TD colSpan=4><SELECT id=combobox1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("addIdea();")' sqltrans controltype="combobox" tempvalue="同意&#13;&#10;不同意&#13;&#10;请尽快处理" temptext="同意&#13;&#10;不同意&#13;&#10;请尽快处理" sql check="1"><OPTION value=同意 selected>同意</OPTION><OPTION value=不同意>不同意</OPTION><OPTION value=请尽快处理>请尽快处理</OPTION></SELECT></TD>
                                 </TR>
                              </TBODY>
                           </TABLE>
                        </TD>
                     </TR>
                     <TR>
                        <TD vAlign=center height=40><DIV align=right><BUTTON class=button1 id=button2 style="LEFT: 97px; WIDTH: 75px; POSITION: static; TOP: 199px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("setAuditIdea();")'><DIV align=center>确定</DIV></BUTTON></DIV></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </DIV>
         </TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
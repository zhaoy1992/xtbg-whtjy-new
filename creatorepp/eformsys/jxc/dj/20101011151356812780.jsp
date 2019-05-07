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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/JycxajIndex.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/JycxajIndex.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wft_id = creator_getQueryString("wft_id");
var readOnlyFlag = creator_getQueryString("readOnly");
var bu_id = creator_getQueryString("bu_id");
var bu_name = creator_getQueryString("bu_name");
var orderNum = "1";
var ndp_id = "";
var thisOneCaseType = "";

function init() {
    ndp_id = Simply.getNdp_IdByWft_Id(wft_id);
    var djbh = objDjbh(wft_id);
    var order = "0";
    var misId = JycxajIndex.judgeNdpByWftId(wft_id);
    if (misId == 2 || misId == 6){//已受理 或 处罚决定中
        order = "2";
    } else if (misId == 16 || misId == 11 || misId == 13){//结案归档中 或 已处罚决定 或 已结案归档
        order = "3";
    }
    thisOneCaseType = JycxajIndex.selectCaseType(wft_id);//查询该案件类别
    var num = parseInt(order)+1;
    var obj= {item : "item"+num+""};
    eval(obj.item).location.href="../../jxc/dj/"+djbh[order]+".jsp?wft_id="+wft_id+"&readOnlyFlag="+readOnlyFlag+"&thisOneCaseType="+thisOneCaseType+"&bu_id="+bu_id+"&bu_name="+bu_name;
    div1.setSelectedIndex(order);
    controlTabName(order);
}


</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><tab><id>div1</id></tab><creatorSubForm><id>item1</id><id>item2</id><id>item3</id><id>item4</id></creatorSubForm></root>" billtaborder="<root></root>" dj_sn="20101011151356812780" caption="简易程序宗卷" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/business/JycxajIndex.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Simply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SimplyDao.js" creator_allTab="<tabs><tab><id>div1</id><content><index>0</index><gridid></gridid><iframeid>item1</iframeid><index>1</index><gridid></gridid><iframeid>item2</iframeid><index>2</index><gridid></gridid><iframeid>item3</iframeid><index>3</index><gridid></gridid><iframeid>item4</iframeid></content></tab></tabs>">

<DIV class=tab-pane id=div1 style="LEFT: 0%; WIDTH: 100%; POSITION: absolute; TOP: 1px; HEIGHT: 500px" showtype="luna" IsHideTitle="否">
   <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 482px">
      <H2 class=tab>封面</H2>
      <TABLE width="100%">
         <TBODY>
            <TR>
               <TD></TD>
            </TR>
            <TR>
               <TD><IFRAME id=item1 style="WIDTH: 100%; POSITION: static; HEIGHT: 450px" onclick=test(); onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url=""></IFRAME></TD>
            </TR>
         </TBODY>
      </TABLE>
   </DIV>
   <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 482px">
      <H2 class=tab>受理</H2>
      <TABLE width="100%">
         <TBODY>
            <TR>
               <TD></TD>
            </TR>
            <TR>
               <TD><IFRAME id=item2 style="WIDTH: 100%; HEIGHT: 450px" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME></TD>
            </TR>
         </TBODY>
      </TABLE>
   </DIV>
   <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 482px">
      <H2 class=tab>处罚决定</H2>
      <TABLE width="100%">
         <TBODY>
            <TR>
               <TD></TD>
            </TR>
            <TR>
               <TD><IFRAME id=item3 style="WIDTH: 100%; HEIGHT: 450px" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME></TD>
            </TR>
         </TBODY>
      </TABLE>
   </DIV>
   <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 482px">
      <H2 class=tab>结案归档</H2>
      <TABLE width="100%">
         <TBODY>
            <TR>
               <TD></TD>
            </TR>
            <TR>
               <TD><IFRAME id=item4 style="WIDTH: 100%; HEIGHT: 450px" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME></TD>
            </TR>
         </TBODY>
      </TABLE>
   </DIV>
</DIV>

<SCRIPT>var div1 = new WebFXTabPane( document.getElementById( "div1" ) );</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
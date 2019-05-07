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
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
<%}%>  fcpubdata.creatorStyle='creatorBlue';
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
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
<%
String actDefId = request.getParameter("actDefId");
String userId= accesscontroler.getUserID();
%>
function init()
{
var actDefId = "<%=actDefId %>";   
    var userId = "<%=userId%>";
   if(actDefId == "testPart_wp1_act1"){
      var sql = "select ujb.org_id,tso.org_name from td_sm_userjoborg ujb,td_sm_organization tso where ujb.org_id=tso.org_id and ujb.user_id='<%=userId%>' and ujb.user_id not in(select user_id from td_sm_userchangeorg_data ud where ud.org_id=ujb.org_id and ud.change_type=1 and ud.cache_type=1)";
      var obj = document.getElementById("combobox1");
      SqlCombo(combobox1,sql);
   }
}

function setLoginOrgId(){
    var orgId = document.getElementById("combobox1").value;
    alert(orgId);
    fcpubdata.login_orgid=orgId;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20091219104852735215" type="ZW" contxml="<root><label><id>label1</id></label><combobox><id>workflowControl_selectAct</id><id>combobox1</id></combobox><div><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_tempSaveForm</id><id>workflowControl_backToPrior</id></div><button><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_wchd</id><id>button_ht</id><id>button_hs</id><id>button_zc</id><id>workflowControl_result</id></button><text><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id></text></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" billtaborder="<root><taborder>workflowControl_selectAct</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zc</taborder><taborder>workflowControl_result</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>combobox1</taborder></root>" creator_pagination version="1.0" idtype="1" creator_csslib OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();init();" keyfield codeheader="BBB" creatorStyle="creatorBlue" mkbh caption="测试兼职人员" dj_sn="10050512155421094900" testDbName toolbar="不带工具栏">

<DIV onresizeend=resizeEnd() style="POSITION: static; WIDTH: 264px; HEIGHT: 24px; TOP: 0px; LEFT: 0px" id=label1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() noWrap NotBg="否" controltype="label" value="label1">测试兼职人员</DIV>

<DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 100%; HEIGHT: 171.66%; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="workflowControl">
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 215px; FLOAT: left; HEIGHT: 30px; FONT-SIZE: 12px; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px; auto: " id=workflowControl_selectAct_div onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">请选择活动：
      <SELECT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 120px; HEIGHT: 25px; TOP: 33px; LEFT: 58px" id=workflowControl_selectAct onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() onchange='bill_onclick("changeSelectActor()")' controltype="combobox" sql temptext tempvalue check="1" sqltrans></SELECT>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 340px; FLOAT: left; HEIGHT: 30px; FONT-SIZE: 12px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_selectUser onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">请选择执行人：
      <INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 150px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=DYNAMICPERFORMER_NAME onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() readOnly size=25 controltype="text">
      <INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 5px; DISPLAY: none; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=DYNAMICPERFORMER onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() size=2 controltype="text">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_xzxr class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick='bill_onclick("adduser();")'>选执行人</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 380px; FLOAT: left; HEIGHT: 30px; FONT-SIZE: 12px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_selectAndUser onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">请选择执行人：
      <INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 150px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=ANDSPLITUSERS_ACTNAME onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() readOnly size=25 controltype="text">
      <INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 5px; DISPLAY: none; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=ANDSPLITUSERS onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() size=2 controltype="text">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 115px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_yfzxzxr class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick='bill_onclick("addAndUser();")'>与分支选执行人</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_start onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_qdlc class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;setLoginOrgId();creator_djsave('启动流程',true,true,'../../../common_workflow/main.jsp')&quot;)">启动流程</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_complete onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_wchd class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp')&quot;)">完成活动</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_back onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_ht class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('回退',false,true,'../../../common_workflow/main.jsp')&quot;)">回退</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_recycle onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_hs class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)">收回</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_tempSaveForm onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=button_zc class=button1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick="bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)">暂存</BUTTON>
   </DIV>
   <DIV onresizeend=resizeEnd() style="BORDER-BOTTOM: 0px; POSITION: static; BORDER-LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW-Y: hidden; WIDTH: 84px; FLOAT: left; HEIGHT: 30px; OVERFLOW: auto; BORDER-TOP: 0px; TOP: 0px; BORDER-RIGHT: 0px; LEFT: 0px" id=workflowControl_backToPrior onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() NotBg="是" controltype="div">
      <BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=workflowControl_result onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">返回</BUTTON>
   </DIV>
</DIV>

<SELECT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 120px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=combobox1 onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="combobox" sql temptext tempvalue check="2" sqltrans></SELECT>
</DIV>
<div id='grid_tip'></div></body></html>
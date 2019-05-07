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
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script></script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><combobox><id>supervise_type_code</id><id>feedback_state</id><id>reply_state</id><id>supervise_result_code</id></combobox><img><id>img1</id></img><button><id>button1</id><id>button2</id></button><text><id>text1</id><id>approve_name</id><id>item_name</id><id>feedback_begin_time</id><id>feedback_end_time</id></text></root>" billtaborder="<root><taborder>supervise_type_code</taborder><taborder>feedback_state</taborder><taborder>reply_state</taborder><taborder>supervise_result_code</taborder><taborder>approve_name</taborder><taborder>item_name</taborder><taborder>feedback_begin_time</taborder><taborder>feedback_end_time</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>text1</taborder></root>" dj_sn="20100127123317156039" caption="预警反馈查询" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:1;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20091219104852735215" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<TABLE id=tableline style="WIDTH: 100%; TEXT-ALIGN: center" cellSpacing=0 cellPadding=0 border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=tab_4 style="WIDTH: 100%; TEXT-ALIGN: center" cellSpacing=0 cellPadding=0>
               <TBODY>
                  <TR>
                     <TD class=le5 width="13.3%">受理单位</TD>
                     <TD align=left width="20%"><INPUT id=text1 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"><IMG id=img1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../fceformext/res/search12.gif" controltype="img" onclick="bill_onclick(&quot;chooseOrg(getAreaCode(),'org_code','org_name');&quot;)" cover="9" srcsk="../../fceformext/res/search12.gif"></TD>
                     <TD class=le5 width="13.3%">事项名称</TD>
                     <TD width="20%"><INPUT class=input_search id=approve_name style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onclick=findSP();showSel(true);spAlert(); onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=le5 width="13.3%">项目名称</TD>
                     <TD width="20%"><INPUT id=item_name style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=le5 width="13.3%">监察类型</TD>
                     <TD width="20%"><SELECT id=supervise_type_code style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="0&#13;&#10;1&#13;&#10;2&#13;&#10;3" temptext="全部&#13;&#10;事前&#13;&#10;事中&#13;&#10;事后" sql check="1"><OPTION value=0 selected>全部</OPTION><OPTION value=1>事前</OPTION><OPTION value=2>事中</OPTION><OPTION value=3>事后</OPTION></SELECT></TD>
                     <TD class=le5 width="13.3%">反馈状态</TD>
                     <TD width="20%"><SELECT id=feedback_state style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="0&#13;&#10;Y&#13;&#10;N" temptext="全部&#13;&#10;已反馈&#13;&#10;未反馈" sql check="1"><OPTION value=0 selected>全部</OPTION><OPTION value=Y>已反馈</OPTION><OPTION value=N>未反馈</OPTION></SELECT></TD>
                     <TD class=le5 width="13.3%">回复状态</TD>
                     <TD width="20%"><SELECT id=reply_state style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="0&#13;&#10;Y&#13;&#10;N" temptext="全部&#13;&#10;已回复&#13;&#10;未回复" sql check="1"><OPTION value=0 selected>全部</OPTION><OPTION value=Y>已回复</OPTION><OPTION value=N>未回复</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=le5 width="13.3%">监察结果</TD>
                     <TD width="20%"><SELECT id=supervise_result_code style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F4%F8%EE%D8%F2%FA%E0%F4%D8%CC%F2%D8%F4%F8%E6%F6%CC%D4%EC%D6%D8Xr%94%F4%F8%EE%D8%F2%FA%E0%F4%D8%CC%F2%D8%F4%F8%E6%F6%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%D0%EE%EE%CCpj%F6%D0%CC%D6%E0%D4%CC%F4%F8%EE%D8%F2%FA%E0%F4%D8%CC%F2%D8%F4%F8%E6%F6Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F4%F6%D0%F6%D8XrnXt%96Xr%7C%C0Xr%7CXrn%D0%EA%D6Xrn%F6j%F4%F8%EE%D8%F2%FA%E0%F4%D8%CC%F2%D8%F4%F8%E6%F6%CC%D4%EC%D6%D8XrnXrpXt%96Xr%7CnXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F4%F8%EE%D8%F2%FA%E0%F4%D8%CC%F2%D8%F4%F8%E6%F6%CC%D4%EC%D6%D8" controltype="combobox" tempvalue="100" temptext="全部" sql check="1"><OPTION value=100 selected>全部</OPTION></SELECT></TD>
                     <TD class=le5 width="13.3%">开始时间</TD>
                     <TD width="20%"><INPUT class=input_date id=feedback_begin_time style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=28 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=le5 width="13.3%">结束时间</TD>
                     <TD align=left width="20%"><INPUT class=input_date id=feedback_end_time style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">查询</BUTTON>

<BUTTON id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">重置</BUTTON>
</DIV>
<div id='grid_tip'></div></body></html>
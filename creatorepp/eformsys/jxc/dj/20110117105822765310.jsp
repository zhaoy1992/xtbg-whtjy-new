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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
/**
 *模块：简易程序
 *作者：zefeng.yu
 *时间：2010-11-8
 *状态：update
 **/
var djbh = "<%=request.getParameter("djbh")%>" 
var wft_id= "<%=request.getParameter("wft_id")%>"
var flag= "<%=request.getParameter("flag")%>"
var user_id = getSysElement("userid");
var temp_rmdId = "";

function init(){
    document.getElementById('bu_id').value="";
    document.getElementById('RMD_ID').value="";
    document.getElementById('ad_id').value="";
    $('WFT_ID').value=wft_id;
    initInfo();
    
}

/**
 *函数：initInfo
 *描述：初始化界面信息
 *作者：zefeng.yu
**/
function initInfo(){
    $('is_id').value = -1 ;
    $('ad_id').value = -1 ;
    $('CT_ID').value = -1 ;
    $('RMD_ID').value = -1 ;
    if(!IsSpace(wft_id)){
        var sql =  Simply.findJYInfoBiz(wft_id);
        insertOrUpdateDateset.Open(sql);
        temp_rmdId = insertOrUpdateDateset.Fields.Field['RMD_ID'].Value;
        $('WFT_ID').value=wft_id;
        wfaction();
    } else {
        $("orTheLaw").style.display = "none";
        $("orRule").style.display = "none";
    }
}

//执法主体变化违法行为也变化
function wfaction(){
    var wfxwSql = Simply.initWfxwAction($("BU_ID").value);
    SqlCombo(document.getElementById("RMD_ID"),wfxwSql);
    $("RMD_ID").value = temp_rmdId;
    /*var oOption = document.createElement("OPTION");
    document.getElementById("RMD_ID").options.add(oOption);
    oOption.innerText = "--请选择--";
    oOption.value = "-1";
    document.getElementById("RMD_ID").value = -1;*/
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>LTT_ATTRI</id></radio><textarea><id>WFT_BRIEF</id><id>OR_BRIEF</id></textarea><combobox><id>IS_ID</id><id>AD_ID</id><id>CT_ID</id><id>RMD_ID</id></combobox><text><id>WFT_APPLICATION_NUMBER</id><id>WFT_TITLE</id><id>WFT_ADDRESS</id><id>WFT_DATE</id><id>BU_ID</id><id>ORG_ID</id><id>WFT_ID</id><id>WFT_DATE_RETURN_RECEIVE</id><id>BU_NAME</id><id>orgNames</id><id>orgIds</id><id>LTT_NAME</id><id>LTT_CODE</id><id>LTT_CORPORATE_COMMISSARY</id></text><dataset><id>insertOrUpdateDateset</id></dataset></root>" billtaborder="<root><taborder>LTT_ATTRI</taborder><taborder>WFT_BRIEF</taborder><taborder>OR_BRIEF</taborder><taborder>IS_ID</taborder><taborder>AD_ID</taborder><taborder>CT_ID</taborder><taborder>RMD_ID</taborder><taborder>WFT_APPLICATION_NUMBER</taborder><taborder>WFT_TITLE</taborder><taborder>WFT_ADDRESS</taborder><taborder>WFT_DATE</taborder><taborder>BU_ID</taborder><taborder>ORG_ID</taborder><taborder>WFT_DATE_RETURN_RECEIVE</taborder><taborder>BU_NAME</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder><taborder>LTT_NAME</taborder><taborder>LTT_CODE</taborder><taborder>LTT_CORPORATE_COMMISSARY</taborder><taborder>WFT_ID</taborder></root>" dj_sn="20110117105822765310" caption="简易程序受理" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SimplyVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Simply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SimplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable id=NUM1 cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>简易程序案件信息</TD>
                     <TR>
                        <TD class=c2 width="15%">案件受理编号<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT id=WFT_APPLICATION_NUMBER style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="WFT_APPLICATION_NUMBER" china="受理编号" dataset="insertOrUpdateDateset"></TD>
                        <TD class=c2 width="15%">案件来源<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=IS_ID style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%B4%CC%A0%96Xr%94%A0%B4%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%AA%9A%AC%CC%B4%AC%B8%B2%94%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%A0%B4%CC%AC%B2%96%98%B2" controltype="combobox" field="IS_ID" china="消息来源" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案件标题<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%" colSpan=3><INPUT id=WFT_TITLE style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=42 controltype="text" field="WFT_TITLE" china="案件标题" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案发地址<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%" colSpan=3><SELECT id=AD_ID style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D0%D6%CC%E0%D6Xr%94%F6j%D0%D6%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%D0%D6%E8%E0%EA%E0%F4%F6%F2%D0%F6%E0%FA%D8%CC%D6%E0%FA%E0%F4%E0%EC%EA%F4Xrn%F6" controltype="combobox" field="AD_ID" china="行政区域" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT><INPUT id=WFT_ADDRESS style="LEFT: 0px; WIDTH: 59%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=85 controltype="text" field="WFT_ADDRESS" china="案件地址" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案发时间<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%" colSpan=3><INPUT id=WFT_DATE style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=28 controltype="text" field="WFT_DATE" china="案发时间" dataset="insertOrUpdateDateset" onclick='bill_onclick("SelectDate()")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 26px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text" field="BU_ID" china="执法主体" dataset="insertOrUpdateDateset"><INPUT id=ORG_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 26px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text"><INPUT id=WFT_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 57px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" field="WFT_ID" china="处罚事项实例id" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">受理时间<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT id=WFT_DATE_RETURN_RECEIVE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=69 name=Input controltype="text" field="WFT_DATE_RETURN_RECEIVE" china="受理时间" dataset="insertOrUpdateDateset" onclick='bill_onclick("SelectDate()")'></TD>
                        <TD class=c2 width="15%">执法主体<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD vAlign=top width="35%"><INPUT id=BU_NAME style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly onchange='bill_onclick("wfaction()")' controltype="text" field="BU_NAME" china="执法主体名称" dataset="insertOrUpdateDateset" onclick='bill_onclick("openOrgTree();")'><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 42px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=7 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 51px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=7 controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">简要案件内容</TD>
                        <TD width="85%" colSpan=3><TEXTAREA id=WFT_BRIEF style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 111px" onmovestart=moveStart() cols=76 controltype="textarea" field="WFT_BRIEF" china="案件描述" dataset="insertOrUpdateDateset" value="textarea1" induce="否" algin="left"></TEXTAREA></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <?xml:namespace prefix = fc />
               <fc:dataset id=insertOrUpdateDateset format="<fields><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例id</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_APPLICATION_NUMBER</fieldname><datatype>字符</datatype><displaylabel>受理编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_ID</fieldname><datatype>字符</datatype><displaylabel>消息来源</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_TITLE</fieldname><datatype>字符</datatype><displaylabel>案件标题</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>字符</datatype><displaylabel>行政区域</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ADDRESS</fieldname><datatype>字符</datatype><displaylabel>案件地址</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE</fieldname><datatype>字符</datatype><displaylabel>案发时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>受理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BRIEF</fieldname><datatype>字符</datatype><displaylabel>案件描述</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>字符</datatype><displaylabel>当事人流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ATTRI</fieldname><datatype>字符</datatype><displaylabel>公民或法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CT_ID</fieldname><datatype>字符</datatype><displaylabel>证件类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>字符</datatype><displaylabel>证件编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CORPORATE_COMMISSARY</fieldname><datatype>字符</datatype><displaylabel>法人代表</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_ID</fieldname><datatype>字符</datatype><displaylabel>裁量细则流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_BRIEF_OF_CASE</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_ID</fieldname><datatype>字符</datatype><displaylabel>违法记录流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_THE_LAW</fieldname><datatype>字符</datatype><displaylabel>执法依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_RULE</fieldname><datatype>字符</datatype><displaylabel>处罚依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_BRIEF</fieldname><datatype>字符</datatype><displaylabel>违法情况</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ID</fieldname><datatype>字符</datatype><displaylabel>执行明细流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DATE</fieldname><datatype>字符</datatype><displaylabel>处罚日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_VOUCHER_NUMBER</fieldname><datatype>字符</datatype><displaylabel>发票编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PENALTY_SUM</fieldname><datatype>字符</datatype><displaylabel>罚款金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ID</fieldname><datatype>字符</datatype><displaylabel>材料清单流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_BODY</fieldname><datatype>字符</datatype><displaylabel>处罚决定内容</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_STATUS</fieldname><datatype>字符</datatype><displaylabel>存档还是草稿</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_EMY</fieldname><datatype>字符</datatype><displaylabel>执法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT1_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例编号2</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ACCESSORIES_BODY</fieldname><datatype>字符</datatype><displaylabel>材料体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET5" multiResult="否"></fc:dataset>
            </TD>
         </TR>
         <TR>
            <TD>
               <TABLE class=Ctable id=NUM2 cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=4>当事人(单位)信息</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">当事人/单位</TD>
                        <TD width="35%"><FIELDSET id=LTT_ATTRI contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 60%; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 18px" onmovestart=moveStart() controltype="radio" field="LTT_ATTRI" china="公民或法人" dataset="insertOrUpdateDateset" tempvalue="1&#13;&#10;2&#13;&#10;3" temptext="公民&#13;&#10;法人&#13;&#10;其他" aspect="横向" legend NotBg="否" value="1"><INPUT type=radio CHECKED value=1 name=RGLTT_ATTRI text="公民"><SPAN onclick=RGLTT_ATTRI[0].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[0].value;RGLTT_ATTRI[0].focus();>公民</SPAN>&nbsp;<INPUT type=radio value=2 name=RGLTT_ATTRI text="法人"><SPAN onclick=RGLTT_ATTRI[1].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[1].value;RGLTT_ATTRI[1].focus();>法人</SPAN>&nbsp;<INPUT type=radio value=3 name=RGLTT_ATTRI text="其他"><SPAN onclick=RGLTT_ATTRI[2].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[2].value;RGLTT_ATTRI[2].focus();>其他</SPAN>&nbsp;</FIELDSET></TD>
                        <TD class=c2 width="15%">当事人/单位名称<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT id=LTT_NAME style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=59 controltype="text" field="LTT_NAME" china="名称" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">证件类型<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=CT_ID style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D4%F6%CC%E0%D6Xr%94%F6j%D4%F6%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%D4%D8%F2%F6%F6%u0100%EE%D8Xrn%F6" controltype="combobox" field="CT_ID" china="证件类型" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                        <TD width="15%"></TD>
                        <TD width="35%"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">证件号码</TD>
                        <TD width="35%"><INPUT id=LTT_CODE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=52 controltype="text" field="LTT_CODE" china="证件编号" dataset="insertOrUpdateDateset"></TD>
                        <TD class=c2 width="15%">法人代表</TD>
                        <TD width="35%"><INPUT id=LTT_CORPORATE_COMMISSARY style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=58 controltype="text" field="LTT_CORPORATE_COMMISSARY" china="法人代表" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD>
               <TABLE class=Ctable id=NUM3 cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=2>违法信息</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法行为名称<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%"><SELECT id=RMD_ID style="LEFT: 0px; WIDTH: 24%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("offence_degree()")' sqltrans controltype="combobox" field="RMD_ID" china="违法行为ID" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法情况<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%"><TEXTAREA id=OR_BRIEF style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=117 controltype="textarea" field="OR_BRIEF" china="违法情况" dataset="insertOrUpdateDateset" value="textarea3" induce="否"></TEXTAREA></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
      </TBODY>
   </TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
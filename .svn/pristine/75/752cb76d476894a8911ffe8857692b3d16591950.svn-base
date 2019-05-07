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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishMent.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishMent.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishMentDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishMentDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var piId = creator_getQueryString("piId");
var rflId = creator_getQueryString("rflId");

//初始化
function init(){
    $("PI_ID").value = piId;
    $("RIL_ID").value = rflId;
    if(!IsSpace(rflId)){
        var sql = PunishMent.initAttachByRFLId(rflId);
        dataset1.Open(sql);
        $('addOrUpdateFlag').value = "update";
    } else {
        $('addOrUpdateFlag').value = "add";
        $("RIL_ID").value = DBUtil.getSeq("SEQ_REF_INFO_LIST");
    }
    isTemplate();
}

//保存
function saveData(){
    if(!validate()){
        return;
    }
    var pmObj = new PunishMentVo.AttachMent();
    var pmVo = DBUtil.getVoFromPage(pmObj);
        pmObj.RIL_ID = $("RIL_ID").value;
        pmObj.addOrUpdateFlag = $('addOrUpdateFlag').value;
        pmObj.BU_ID = "";
        pmObj.RIL_FORMAT = "1";//??格式
         pmObj.RIL_TBODY = "";
        pmObj.RIL_TSM = "3";
        pmObj.RIL_ORDER = "";
        
        pmObj.ISR_ORDER = "";
        pmObj.ISR_REFER_ATTRI = FormUtil.getRadioGroupValue('ISR_REFER_ATTRI');
        pmObj.RIL_ISTEMPLATE = FormUtil.getRadioGroupValue('RIL_ISTEMPLATE');
        pmObj.RIL_STATUS = FormUtil.getRadioGroupValue('RIL_STATUS');    
    var rv = PunishMent.saveAttach(pmVo);
    if(rv){
        alert("保存材料成功");
        closeWin();
    }else{
        alert("保存材料失败");
    }
}

function isTemplate(){
    var template = FormUtil.getRadioGroupValue('RIL_ISTEMPLATE');
    if(template == "1") {
        $('choose_fc_attach').disabled = false;
    } else {
        $('choose_fc_attach').disabled = true;
    }
}

//效验
function validate(){
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'RIL_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RIL_NAME'}.value]},
            MESSAGE : "材料名称不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'NDP_ID'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'NDP_ID'}.value]},
            MESSAGE : "提交材料阶段不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'ISR_AMT'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ISR_AMT'}.value]},
            MESSAGE : "材料份数不能为空!"
        }, true);
    }
    if (flag) {
        var reg = /^[1-9]\d*$/;
        if (!reg.test(${'ISR_AMT'}.value)) {
            alert("份数请输入正整数！");
            flag = false;
        }    
    }
    
    return flag;
}

//关闭
function closeWin(){
   window.close();
}

//附件
function chooseFcAttach(){
   openUploadAndDownView();
}

/* 打开上传下载页面 */
function openUploadAndDownView(){
    var id = rflId;
    if(IsSpace(id)) {
        id = $("RIL_ID").value;
    }
    var isAllowDelete = true ;
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +"&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    
    return rtn ;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>RIL_ISTEMPLATE</id><id>ISR_REFER_ATTRI</id><id>RIL_STATUS</id></radio><combobox><id>NDP_ID</id></combobox><button><id>choose_fc_attach</id><id>save_btn</id><id>close_btn</id></button><text><id>RIL_NAME</id><id>ISR_AMT</id><id>PI_ID</id><id>RIL_ID</id><id>addOrUpdateFlag</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>save_btn</taborder><taborder>close_btn</taborder><taborder>choose_fc_attach</taborder><taborder>RIL_NAME</taborder><taborder>ISR_REFER_ATTRI</taborder><taborder>NDP_ID</taborder><taborder>PI_ID</taborder><taborder>ISR_AMT</taborder><taborder>RIL_ID</taborder><taborder>RIL_ISTEMPLATE</taborder><taborder>RIL_STATUS</taborder><taborder>addOrUpdateFlag</taborder></root>" dj_sn="20100911094117796429" caption="新增事项材料" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:1;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:6;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:1;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181609484868" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishMent.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishMentDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMentVo.js">

<TABLE class=Ttable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=center border=1>
   <TBODY>
      <TR>
         <TD>
            <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=B1 width="20%">材料名称<FONT color=red>*</FONT></TD>
                     <TD width="30%" colSpan=3><INPUT class=input_out id=RIL_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RIL_NAME" china="材料名称" dataset="dataset1"></TD>
                  </TR>
                  <TR>
                     <TD class=B1 width="15%">提交材料阶段<FONT color=red>*</FONT></TD>
                     <TD width="35%"><SELECT id=NDP_ID style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AA%96%AE%CC%A0%96Xr%94%AA%96%AE%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AA%AC%B2%A8%90%A6%CC%96%A0%B4%94%A0%AE%A6%A0%AA%90%B2%C0%CC%AE%B2%AC%94Xrn%FC%DE%D8%F2%D8Xrn%EA%D6%EE%CC%E0%D6Xrn%E0%EAXrnXr%7EpXr%94rXr%94tXr%94vXr%94xXr%80Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AA%96%AE%CC%AC%B2%96%98%B2" controltype="combobox" field="ndp_id" china="提交阶段" dataset="dataset1" tempvalue temptext sql check="2"></SELECT></TD>
                     <TD class=B1 width="10%">份数<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=ISR_AMT style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() value=1 controltype="text" field="ISR_AMT" china="材料份数" dataset="dataset1"></TD>
                  </TR>
                  <TR>
                     <TD class=B1>是否有模板</TD>
                     <TD><FIELDSET id=RIL_ISTEMPLATE contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 14px" onmovestart=moveStart() controltype="radio" field="RIL_ISTEMPLATE" china="有模板" dataset="dataset1" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="1" onclick='bill_onclick("isTemplate();")'><INPUT type=radio CHECKED value=1 name=RGRIL_ISTEMPLATE text="是"><SPAN onclick=RGRIL_ISTEMPLATE[0].checked=true;RIL_ISTEMPLATE.value=RGRIL_ISTEMPLATE[0].value;RGRIL_ISTEMPLATE[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=0 name=RGRIL_ISTEMPLATE text="否"><SPAN onclick=RGRIL_ISTEMPLATE[1].checked=true;RIL_ISTEMPLATE.value=RGRIL_ISTEMPLATE[1].value;RGRIL_ISTEMPLATE[1].focus();>否</SPAN>&nbsp;</FIELDSET></TD>
                     <TD class=B1>附件</TD>
                     <TD><BUTTON class=button id=choose_fc_attach style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("chooseFcAttach()")'>上传与下载</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD class=B1>是否必交</TD>
                     <TD><FIELDSET id=ISR_REFER_ATTRI contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 14px" onmovestart=moveStart() controltype="radio" field="ISR_REFER_ATTRI" china="是否必交" dataset="dataset1" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="1"><INPUT type=radio CHECKED value=1 name=RGISR_REFER_ATTRI text="是"><SPAN onclick=RGISR_REFER_ATTRI[0].checked=true;ISR_REFER_ATTRI.value=RGISR_REFER_ATTRI[0].value;RGISR_REFER_ATTRI[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=0 name=RGISR_REFER_ATTRI text="否"><SPAN onclick=RGISR_REFER_ATTRI[1].checked=true;ISR_REFER_ATTRI.value=RGISR_REFER_ATTRI[1].value;RGISR_REFER_ATTRI[1].focus();>否</SPAN>&nbsp;</FIELDSET></TD>
                     <TD>状态</TD>
                     <TD><FIELDSET id=RIL_STATUS contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 14px" onmovestart=moveStart() controltype="radio" field="RIL_STATUS" china="状态" dataset="dataset1" tempvalue="1&#13;&#10;0" temptext="启用&#13;&#10;停用" aspect="横向" legend NotBg="否" value="1"><INPUT type=radio CHECKED value=1 name=RGRIL_STATUS text="启用"><SPAN onclick=RGRIL_STATUS[0].checked=true;RIL_STATUS.value=RGRIL_STATUS[0].value;RGRIL_STATUS[0].focus();>启用</SPAN>&nbsp;<INPUT type=radio value=0 name=RGRIL_STATUS text="停用"><SPAN onclick=RGRIL_STATUS[1].checked=true;RIL_STATUS.value=RGRIL_STATUS[1].value;RGRIL_STATUS[1].focus();>停用</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD class=B2 align=middle><BUTTON class=button id=save_btn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveData()")'>保存</BUTTON><BUTTON class=button id=close_btn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeWin()")'>关闭</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>RIL_ID</fieldname><datatype>字符</datatype><displaylabel>材料ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_NAME</fieldname><datatype>字符</datatype><displaylabel>材料名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ISR_REFER_ATTRI</fieldname><datatype>字符</datatype><displaylabel>是否必交</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_ID</fieldname><datatype>字符</datatype><displaylabel>提交阶段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ISR_AMT</fieldname><datatype>字符</datatype><displaylabel>材料份数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_ISTEMPLATE</fieldname><datatype>字符</datatype><displaylabel>有模板</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><RIL_ID></RIL_ID><RIL_NAME></RIL_NAME><ISR_REFER_ATTRI></ISR_REFER_ATTRI><NDP_ID></NDP_ID><ISR_AMT></ISR_AMT><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_STATUS></RIL_STATUS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><RIL_ID></RIL_ID><RIL_NAME></RIL_NAME><ISR_REFER_ATTRI></ISR_REFER_ATTRI><NDP_ID></NDP_ID><ISR_AMT></ISR_AMT><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_STATUS></RIL_STATUS></dsid>")' onValid='bill_ondatasetvalid("<dsid><RIL_ID></RIL_ID><RIL_NAME></RIL_NAME><ISR_REFER_ATTRI></ISR_REFER_ATTRI><NDP_ID></NDP_ID><ISR_AMT></ISR_AMT><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_STATUS></RIL_STATUS></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 29px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text">

<INPUT id=RIL_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 39px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text" field="RIL_ID" china="材料ID" dataset="dataset1">

<INPUT id=addOrUpdateFlag style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
</DIV>
<div id='grid_tip'></div></body></html>
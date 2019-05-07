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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var piId=creator_getQueryString("pi_id");
var checkBoxIds = "";

function init() {
    initPunishMent();
}

function initPunishMent() {

    initPuinshProgram();
    if(IsSpace(piId)) {
        $('punishItemDetal').style.display = 'none';
        $('HCU_ID').value = "1";
        $('IC_ID').value = "-1";
    } else {
        $('itemName').innerHTML = "修改处罚事项";
        var sql = PunishMent.initUpdatePunishMent(piId);
        punishMentDataset.Open(sql);
        $('PI_CODE').disabled = true;
        $("BU_NAME").disabled = true;
      }

}
/*
     函数:   initPuinshProgram
     说明:   初始化一般处罚程序
      参数:   无
      返回值: 无
*/
function initPuinshProgram() {

        var checkBoxStr = PunishMent.queryPuinshProgramStr(piId);
        $('punishProgram').innerHTML = checkBoxStr;
    
}

function chooseBunissUnit(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    $("orgNames").value = $("BU_NAME").value ;
    $("orgIds").value = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAME").value = $("orgNames").value ;
    $("BU_ID").value  = $("orgIds").value ;
}

function savePunishMent(){
    if(!validate()){
        return;
    }
    
    var pmObj = new PunishMentVo.PunishMent();
    var pmVo = DBUtil.getVoFromPage(pmObj);
    pmObj.PI_STATUS = FormUtil.getRadioGroupValue('PI_STATUS');
    pmObj.PI_SUMMARY = FormUtil.getRadioGroupValue('PI_SUMMARY');
    pmObj.PI_NO_CHARGE = FormUtil.getRadioGroupValue('PI_NO_CHARGE');
    pmObj.PI_SP = FormUtil.getRadioGroupValue('PI_SP');
    pmObj.CHECKBOXIDS = checkBoxIds;
    checkBoxIds = "";
    
    var rv = PunishMent.savePunishMent(pmVo);
    
    if(!IsSpace(rv)){
        if(IsSpace($('PI_ID').value)) {
            $('PI_ID').value = rv;
            piId = rv;
            $('punishItemDetal').style.display = "";
            initPuinshProgram();
        } else {
        
        }
        alert("保存数据信息成功！");
        ${'oldPI_HANDLING_TIME'}.value = ${'PI_HANDLING_TIME'}.value;
        ${'oldPI_SUMMARY'}.value = FormUtil.getRadioGroupValue('PI_SUMMARY');
        $('itemName').innerHTML = "修改处罚事项";
        window.frames["RMDInfoSub"].init();
    }else{
        alert("保存数据信息失败！");
    }
    
}

function validate() {
    var flag = true;
    var testNum = /^[0-9]{1,3}$/;
    if (flag) {
        flag = SValidator.validate(${'PI_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'PI_NAME'}.value]},
            MESSAGE : "事项名称不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [200],maxlength : 200},
            MESSAGE : "事项名称最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'PI_CODE'}.value]},
            MESSAGE : "事项编码不能为空!"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("PI_CODE").value)){
            flag = false;
            alert("事项编码不能包含汉字！");
        }            
    }

    if (flag) {
        flag = SValidator.validate(${'PI_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "事项编码最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_BRIEF_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'PI_BRIEF_NAME'}.value]},
            MESSAGE : "事项简称不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_BRIEF_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [200],maxlength : 200},
            MESSAGE : "事项简称最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_BRIEF_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'PI_BRIEF_NAME'}.value]},
            MESSAGE : "事项简称不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [200],maxlength : 200},
            MESSAGE : "事项简称最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'PI_HANDLING_TIME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'PI_HANDLING_TIME'}.value]},
            MESSAGE : "事项时限不能为空!"
        }, true);
    }
    
    if (flag) {
        if (!testNum.test(${'PI_HANDLING_TIME'}.value)) {
            flag = false;
            alert("事项时限请输入3位以内正整数!");
        }
    }
    
    if (flag) {
        if (${'IC_ID'}.value==-1) {
            alert("请选择事项类别!");
            flag = false;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'HCU_ID'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'HCU_ID'}.value]},
            MESSAGE : "时限单不能为空!"
        }, true);
    }
    
    if(IsSpace($('PI_ID').value)){
        if (flag) {
            flag = checkPiCodeOnlyOne();
            if (!flag) {
                alert('事项编码已存在,请重新填写!');
            }
        }
    }
    if(!IsSpace($('PI_ID').value)) {
        var piNoCharge = FormUtil.getRadioGroupValue('PI_NO_CHARGE');
        if (flag) {
            flag = PunishMent.velidateIsCharge(piId,piNoCharge);
            if(!flag) {
                if(piNoCharge == "0") {
                    alert('处罚事项修改为不收费事项,与所添加的违法行为是收费的,请删除违法行为后再保存!');
                }
            }
        }   
    }
    
    if (flag) {
        flag = validateCheckBox();
        if (!flag) {
            alert('请选择一般处罚程序!');
        }
    }
    return flag;
    
}

//验证是否选择了一般处罚程序
function validateCheckBox() {
    
    var chflag = false;
    var checkBox = document.getElementsByName("puishCsId");
    for(var i = 0; i < checkBox.length; i++) {
        if(checkBox[i].value!='6'){
            if(checkBox[i].checked == true) {
                chflag = true;
                checkBoxIds += "," + checkBox[i].value;
                if(checkBox[i].value=='2'){
                    checkBoxIds += ",6";
                }
                if(checkBox[i].value=='3'){
                    checkBoxIds += ",7,8,9,10";
                }
            }
        }
    }
    checkBoxIds = checkBoxIds.substring(1);
    return chflag;
    
}

//验证事项编码唯一
function checkPiCodeOnlyOne() {

     return PunishMent.checkPiCodeOnlyOne($('PI_CODE').value);
     
 }

//配置阶段信息
function addNDPMent(NDPId) {
    if (NDPId==-1) {
        alert("请先保存当前处罚事项信息!");
        return false;
    }
    var url = "20100909091811906298.jsp?piId="+piId+"&NDPId="+NDPId+"&buId="+$('BU_ID').value;
    var features = "dialogWith:900px;dialogHeight:400px;scroll:no;status:no";
    window.showModalDialog(url,window,features);
    
}

function backUpPage(){
    window.history.go(-1);
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>PI_STATUS</id><id>PI_SUMMARY</id><id>PI_NO_CHARGE</id><id>PI_SP</id></radio><textarea><id>PI_BRIEF</id></textarea><combobox><id>HCU_ID</id><id>IC_ID</id></combobox><tab><id>tab1</id></tab><div><id>div1</id></div><button><id>button1</id><id>btnBack</id></button><text><id>BU_ID</id><id>PI_ID</id><id>BU_NAME</id><id>PI_NAME</id><id>PI_CODE</id><id>PI_BRIEF_NAME</id><id>PI_HANDLING_TIME</id><id>oldPI_HANDLING_TIME</id><id>oldPI_SUMMARY</id><id>orgIds</id><id>orgNames</id></text><dataset><id>punishMentDataset</id></dataset><creatorSubForm><id>RMDInfoSub</id><id>attachInfoSub</id></creatorSubForm></root>" billtaborder="<root><taborder>BU_NAME</taborder><taborder>PI_NAME</taborder><taborder>BU_ID</taborder><taborder>PI_ID</taborder><taborder>PI_CODE</taborder><taborder>PI_BRIEF_NAME</taborder><taborder>PI_STATUS</taborder><taborder>HCU_ID</taborder><taborder>PI_HANDLING_TIME</taborder><taborder>oldPI_HANDLING_TIME</taborder><taborder>PI_SUMMARY</taborder><taborder>IC_ID</taborder><taborder>oldPI_SUMMARY</taborder><taborder>PI_NO_CHARGE</taborder><taborder>PI_SP</taborder><taborder>PI_BRIEF</taborder><taborder>button1</taborder><taborder>btnBack</taborder><taborder>orgIds</taborder><taborder>orgNames</taborder></root>" dj_sn="20100906171617015620" caption="新增(修改)事项" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:5;label:0;radio:7;listbox:1;textarea:1;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:1;DsMain_field:0;a:0;button:4;text:11;hr:0;checkboxlist:0;radiolist:0;dropdownlist:1;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181609484868" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishMent.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishMentDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMentVo.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid>RMDInfoSub</iframeid><index>1</index><gridid></gridid><iframeid>attachInfoSub</iframeid></content></tab></tabs>">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=itemName colSpan=4>新增处罚事项</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法主体<INPUT class=input_out id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="BU_ID" china="执法主体ID" dataset="punishMentDataset"><INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="PI_ID" china="事项ID" dataset="punishMentDataset"></TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="BU_NAME" china="执法主体名称" dataset="punishMentDataset" onclick='bill_onclick("chooseBunissUnit();")'></TD>
                     <TD class=c2 width="15%">事项名称<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=PI_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="PI_NAME" china="名称" dataset="punishMentDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">事项编码<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=PI_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="PI_CODE" china="编码" dataset="punishMentDataset"></TD>
                     <TD class=c2 width="15%">事项简称<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=PI_BRIEF_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="PI_BRIEF_NAME" china="简称" dataset="punishMentDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">事项时限<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=PI_HANDLING_TIME style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="PI_HANDLING_TIME" china="时限" dataset="punishMentDataset"><INPUT id=oldPI_HANDLING_TIME style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="PI_HANDLING_TIME" china="时限" dataset="punishMentDataset"><SELECT id=HCU_ID style="LEFT: 0px; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%DE%D4%F8%CC%E0%D6Xr%94%DE%D4%F8%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%9E%90%AA%96%A6%A0%AA%9C%CC%94%C0%94%A6%98%CC%B8%AA%A0%B6%B4Xrn%F6" controltype="combobox" field="HCU_ID" china="时限单位" dataset="punishMentDataset" tempvalue temptext sql check="2"></SELECT></TD>
                     <TD class=c2 width="15%">是否有效</TD>
                     <TD width="35%"><FIELDSET id=PI_STATUS contentEditable=false style="LEFT: 0px; WIDTH: 152px; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="radio" field="PI_STATUS" china="状态" dataset="punishMentDataset" tempvalue="1&#13;&#10;0" temptext="有效&#13;&#10;无效" aspect="横向" legend NotBg="否" value="1"><INPUT class=Ct style="WIDTH: 20px" type=radio CHECKED value=1 name=RGPI_STATUS text="有效"><SPAN onclick=RGPI_STATUS[0].checked=true;PI_STATUS.value=RGPI_STATUS[0].value;RGPI_STATUS[0].focus();>有效</SPAN>&nbsp;<INPUT class=Ct style="WIDTH: 20px" type=radio value=0 name=RGPI_STATUS text="无效"><SPAN onclick=RGPI_STATUS[1].checked=true;PI_STATUS.value=RGPI_STATUS[1].value;RGPI_STATUS[1].focus();>无效</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">事项类别<FONT color=red>*</FONT></TD>
                     <TD width="35%"><SELECT id=IC_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%94%CC%A0%96Xr%94%A0%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%B6%98%A8%CC%94%90%B6%98%9C%AC%B2%C0" controltype="combobox" field="IC_ID" china="事项类别" dataset="punishMentDataset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">是否适用简易程序</TD>
                     <TD width="35%"><FIELDSET id=PI_SUMMARY contentEditable=false style="LEFT: 0px; WIDTH: 152px; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="radio" field="PI_SUMMARY" china="适用简易程序" dataset="punishMentDataset" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="0"><INPUT class=Ct style="WIDTH: 20px" type=radio CHECKED value=1 name=RGPI_SUMMARY text="是"><SPAN onclick=RGPI_SUMMARY[0].checked=true;PI_SUMMARY.value=RGPI_SUMMARY[0].value;RGPI_SUMMARY[0].focus();>是</SPAN>&nbsp;<INPUT class=Ct style="WIDTH: 20px" type=radio value=0 name=RGPI_SUMMARY text="否"><SPAN onclick=RGPI_SUMMARY[1].checked=true;PI_SUMMARY.value=RGPI_SUMMARY[1].value;RGPI_SUMMARY[1].focus();>否</SPAN>&nbsp;</FIELDSET><INPUT id=oldPI_SUMMARY style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="PI_SUMMARY" china="适用简易程序" dataset="punishMentDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">是否收费</TD>
                     <TD width="35%"><FIELDSET id=PI_NO_CHARGE contentEditable=false style="LEFT: 0px; WIDTH: 152px; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 8px" onmovestart=moveStart() controltype="radio" field="PI_NO_CHARGE" china="收费否" dataset="punishMentDataset" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="1"><INPUT class=Ct style="WIDTH: 20px" type=radio CHECKED value=1 name=RGPI_NO_CHARGE text="是"><SPAN onclick=RGPI_NO_CHARGE[0].checked=true;PI_NO_CHARGE.value=RGPI_NO_CHARGE[0].value;RGPI_NO_CHARGE[0].focus();>是</SPAN>&nbsp;<INPUT class=Ct style="WIDTH: 20px" type=radio value=0 name=RGPI_NO_CHARGE text="否"><SPAN onclick=RGPI_NO_CHARGE[1].checked=true;PI_NO_CHARGE.value=RGPI_NO_CHARGE[1].value;RGPI_NO_CHARGE[1].focus();>否</SPAN>&nbsp;</FIELDSET></TD>
                     <TD class=c2 width="15%">是否公示</TD>
                     <TD width="35%"><FIELDSET id=PI_SP contentEditable=false style="LEFT: 0px; WIDTH: 152px; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 17px" onmovestart=moveStart() controltype="radio" field="PI_SP" china="可公示" dataset="punishMentDataset" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="1"><INPUT class=Ct style="WIDTH: 20px" type=radio CHECKED value=1 name=RGPI_SP text="是"><SPAN onclick=RGPI_SP[0].checked=true;PI_SP.value=RGPI_SP[0].value;RGPI_SP[0].focus();>是</SPAN>&nbsp;<INPUT class=Ct style="WIDTH: 20px" type=radio value=0 name=RGPI_SP text="否"><SPAN onclick=RGPI_SP[1].checked=true;PI_SP.value=RGPI_SP[1].value;RGPI_SP[1].focus();>否</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚事项描述</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=PI_BRIEF style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="PI_BRIEF" china="事项描述" dataset="punishMentDataset" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">一般处罚程序</TD>
                     <TD id=punishProgram colSpan=3></TD>
                  </TR>
                  <TR>
                     <TD align=middle colSpan=4><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("savePunishMent();")'>保存</BUTTON>&nbsp;<BUTTON class=button id=btnBack style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("backUpPage();")'>返回</BUTTON><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 34px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 29px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle></TD>
      </TR>
      <TR id=punishItemDetal>
         <TD><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: auto; LEFT: 0px; OVERFLOW-X: auto; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 400px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab1 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 345px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 327px"><H2 class=tab>违法行为</H2><IFRAME id=RMDInfoSub style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load="3" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/20100910084221515585.jsp?1=1&amp;name=&amp;"></IFRAME></DIV><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 327px"><H2 class=tab>材料信息</H2><IFRAME id=attachInfoSub style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url="../../jxc/dj/20100910222031687373.jsp?1=1&amp;name=&amp;"></IFRAME></DIV></DIV><SCRIPT>var tab1 = new WebFXTabPane( document.getElementById( "tab1" ) );</SCRIPT><DIV></DIV></DIV></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=punishMentDataset format="<fields><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_NAME</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_CODE</fieldname><datatype>字符</datatype><displaylabel>编码</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_BRIEF_NAME</fieldname><datatype>字符</datatype><displaylabel>简称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_HANDLING_TIME</fieldname><datatype>字符</datatype><displaylabel>时限</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_SUMMARY</fieldname><datatype>字符</datatype><displaylabel>适用简易程序</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_NO_CHARGE</fieldname><datatype>字符</datatype><displaylabel>收费否</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_SP</fieldname><datatype>字符</datatype><displaylabel>可公示</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_BRIEF</fieldname><datatype>文本</datatype><displaylabel>事项描述</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项ID</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ATTRI</fieldname><datatype>字符</datatype><displaylabel>事项属性</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_HELP_CODE</fieldname><datatype>字符</datatype><displaylabel>拼音助记码</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_HELP_CODE_WB</fieldname><datatype>字符</datatype><displaylabel>笔划助记码</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ORDER</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IC_ID</fieldname><datatype>字符</datatype><displaylabel>事项类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HCU_ID</fieldname><datatype>字符</datatype><displaylabel>时限单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><BU_ID></BU_ID><PI_NAME></PI_NAME><PI_CODE></PI_CODE><PI_BRIEF_NAME></PI_BRIEF_NAME><PI_HANDLING_TIME></PI_HANDLING_TIME><PI_STATUS></PI_STATUS><PI_SUMMARY></PI_SUMMARY><PI_NO_CHARGE></PI_NO_CHARGE><PI_SP></PI_SP><PI_BRIEF></PI_BRIEF><PI_ID></PI_ID><PI_ATTRI></PI_ATTRI><PI_HELP_CODE></PI_HELP_CODE><PI_HELP_CODE_WB></PI_HELP_CODE_WB><PI_ORDER></PI_ORDER><IC_ID></IC_ID><BU_NAME></BU_NAME><HCU_ID></HCU_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><BU_ID></BU_ID><PI_NAME></PI_NAME><PI_CODE></PI_CODE><PI_BRIEF_NAME></PI_BRIEF_NAME><PI_HANDLING_TIME></PI_HANDLING_TIME><PI_STATUS></PI_STATUS><PI_SUMMARY></PI_SUMMARY><PI_NO_CHARGE></PI_NO_CHARGE><PI_SP></PI_SP><PI_BRIEF></PI_BRIEF><PI_ID></PI_ID><PI_ATTRI></PI_ATTRI><PI_HELP_CODE></PI_HELP_CODE><PI_HELP_CODE_WB></PI_HELP_CODE_WB><PI_ORDER></PI_ORDER><IC_ID></IC_ID><BU_NAME></BU_NAME><HCU_ID></HCU_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><BU_ID></BU_ID><PI_NAME></PI_NAME><PI_CODE></PI_CODE><PI_BRIEF_NAME></PI_BRIEF_NAME><PI_HANDLING_TIME></PI_HANDLING_TIME><PI_STATUS></PI_STATUS><PI_SUMMARY></PI_SUMMARY><PI_NO_CHARGE></PI_NO_CHARGE><PI_SP></PI_SP><PI_BRIEF></PI_BRIEF><PI_ID></PI_ID><PI_ATTRI></PI_ATTRI><PI_HELP_CODE></PI_HELP_CODE><PI_HELP_CODE_WB></PI_HELP_CODE_WB><PI_ORDER></PI_ORDER><IC_ID></IC_ID><BU_NAME></BU_NAME><HCU_ID></HCU_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
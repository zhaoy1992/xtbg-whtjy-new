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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMentVo.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var piId = creator_getQueryString("piId");
var NDPId = creator_getQueryString("NDPId");
var buId =  creator_getQueryString("buId");

//初始化
function init() {
    piId = IsSpace(piId)?"":piId;
    NDPId = IsSpace(NDPId)?"":NDPId;
    var sql = PunishMent.initNDPMent(piId,NDPId);
    dataset1.Open(sql);
    if (IsSpace(dataset1.Fields.Field['HCU_ID'].Value)) {
        $("HCU_ID").value =1;
    }
    if (IsSpace(dataset1.Fields.Field['istage_time_limit'].Value)) {
        $("ISTAGE_TIME_LIMIT").value =0;
    }
    /*var opernread = dataset1.Fields.Field['istage_emy_role'].Value;
    var opernread_split = "";
    if (opernread!="") {
        opernread_split = opernread.split("+-+");
        $("ISTAGE_EMY_ROLE").value = opernread_split[0];
        if (opernread_split.length < 2) {
            opernread_split[1] = "";
        }
        $("ISREAD_ROLE").value = opernread_split[1];
    }*/
    var specialApply = document.getElementsByName("RGSPECIAL_PROCEDURES_APPLY");
    if (dataset1.Fields.Field['special_procedures_apply'].Value==1) {
        specialApply[0].checked = true;
    } else {
        specialApply[1].checked = true;
    }
    var sqlUser = PunishMent.getUserIdByNDPId(piId,NDPId);
    var sqlRole = PunishMent.getRoleIdByNDPId(piId,NDPId);
    var sqlReadUser = PunishMent.getReadUserIdByNDPId(piId,NDPId);
    var sqlReadRole = PunishMent.getReadRoleIdByNDPId(piId,NDPId);
    var sqlPi = PunishMent.getPiNameByNDPId(NDPId);
    
    $("ISTAGE_EMY_ID").value = SqlToField(sqlUser).trim();
    $("ISTAGE_ROLE_ID").value = SqlToField(sqlRole).trim();
    var emyStage = SqlToField(PunishMent.getUserNameByUserId($("ISTAGE_EMY_ID").value));
    var roleStage = SqlToField(PunishMent.getRoleNameByRoleId($("ISTAGE_ROLE_ID").value));
    var operators = "";
    if (!isSpace(emyStage)) {
        operators = emyStage;
    }
    if (!isSpace(operators)) {
        if (!isSpace(roleStage)) {
            operators = operators + "," + roleStage;
        }
    } else {
        if (!isSpace(roleStage)) {
            operators = roleStage;
        }
    }
    $("ISTAGE_EMY_ROLE").value = operators;//操作人员
    $("ISREAD_ID").value = SqlToField(sqlReadUser).trim();
    $("ISREAD_ROLE_ID").value = SqlToField(sqlReadRole).trim();
    var emyRead = SqlToField(PunishMent.getUserNameByUserId($("ISREAD_ID").value));
    var roleRead = SqlToField(PunishMent.getRoleNameByRoleId($("ISREAD_ROLE_ID").value));
    var readers = "";
    if (!isSpace(emyRead)) {
        readers = emyRead;
    }
    if (!isSpace(readers)) {
        if (!isSpace(roleRead)) {
            readers = readers + "," + roleRead;
        }
    } else {
        if (!isSpace(roleRead)) {
            readers = roleRead;
        }
    }
    $("ISREAD_ROLE").value = readers;//只读人员
    $("NDP_NAME").value = SqlToField(sqlPi).trim();
    $("NDP_ID").value = NDPId;
    $("PI_ID").value = piId;
    
}

//新增文书模版
function add(){
//alert("sorry");
}

//保存
function savaData(){
    if(!validate()){
        return false;
    }
    var pmObj = new PunishMentVo.NDPMent();
    var pmVo = DBUtil.getVoFromPage(pmObj);
    pmObj.SPECIAL_PROCEDURES_APPLY = FormUtil.getRadioGroupValue('SPECIAL_PROCEDURES_APPLY');  
    pmObj.ISTAGE_EMY_ROLE = $("ISTAGE_EMY_ROLE").value; 
    pmObj.ISREAD_ROLE = $("ISREAD_ROLE").value; 
    pmObj.PACKAGE_ID = "";
    pmObj.FLOW_VERSION = "";
    pmObj.PROCESS_ID = "";
    pmObj.ISTAGE_ORDER = "1";
    var rv = PunishMent.saveNDPMent(pmVo);
    if(rv){
        alert("保存数据信息成功！");
        closeWin(1);
    }else{
        alert("保存数据信息失败！");
    }
}

//效验
function validate(){
    var testNum = /^[0-9]{1,3}$/;
    var flag = true;  
    if (flag) {
        flag = SValidator.validate(${'NDP_NAME'}.value.trim(), {CHECK_TYPE : "required", ARGUMENT : {placeholders : [${'NDP_NAME'}.value]},MESSAGE : "阶段名称不能为空!"}, true);
    }
    if (flag) {
        if (!testNum.test(${'ISTAGE_TIME_LIMIT'}.value)) {
            flag = false;
            alert("时限请输入3位以内正整数！");
        }
    }
    if (flag) {
        flag = SValidator.validate(${'ISTAGE_EMY_ROLE'}.value, {CHECK_TYPE : "required", ARGUMENT : {placeholders : [${'ISTAGE_EMY_ROLE'}.value]},MESSAGE : "操作人员和角色不能为空!"}, true);
    }
    return flag;
}

//选择只读人员和角色
function chooseIsReadRole(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseUsersTree.jsp?bu_id="+buId+"&unChUserId="+$("ISTAGE_EMY_ID").value+"&unChRoleId="+$("ISTAGE_ROLE_ID").value;
    getReadUsers();
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
//window.open(url,"_blank");
    if(!IsSpace(chooseUsers)){
        var showName = "";
        if(!IsSpace(chooseUsers.users.name)){
            showName = chooseUsers.users.name;
            if(!IsSpace(chooseUsers.roles.name)){
                showName = showName + ",";
            }           
        }
        if(!IsSpace(chooseUsers.roles.name)){
            showName = showName + chooseUsers.roles.name;
        }
        $("ISREAD_ROLE").value = showName;
        $("ISREAD_ID").value = chooseUsers.users.id;
        $("ISREAD_ROLE_ID").value = chooseUsers.roles.id;
    }
}

function getReadUsers(){
    document.getElementById("userIds").value = $("ISREAD_ID").value;
    document.getElementById("userNames").value = $("ISREAD_ROLE").value;
    document.getElementById("roleIds").value = $("ISREAD_ROLE_ID").value;
}

//选择操作人员和角色
function chooseIstageEmyRole(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseUsersTree.jsp?bu_id="+buId+"&unChUserId="+$("ISREAD_ID").value+"&unChRoleId="+$("ISREAD_ROLE_ID").value;
    getActUsers();
    
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
//window.open(url,"_blank");
    if(!IsSpace(chooseUsers)){
        var showName = "";
        if(!IsSpace(chooseUsers.users.name)){
            showName = chooseUsers.users.name;
            if(!IsSpace(chooseUsers.roles.name)){
                showName = showName + ",";
            }           
        }
        if(!IsSpace(chooseUsers.roles.name)){
            showName = showName + chooseUsers.roles.name;
        }
        $("ISTAGE_EMY_ROLE").value = showName;
        $("ISTAGE_EMY_ID").value = chooseUsers.users.id;
        $("ISTAGE_ROLE_ID").value = chooseUsers.roles.id;
    }
}

function getActUsers(){
    document.getElementById("userIds").value = $("ISTAGE_EMY_ID").value;
    document.getElementById("userNames").value = $("ISTAGE_EMY_ROLE").value;
    document.getElementById("roleIds").value = $("ISTAGE_ROLE_ID").value;
}


//关闭
function closeWin(flag){
    if(flag != 1) {
        if(confirm("是否保存信息?")){
            var saveFlag = savaData();
            if(!saveFlag){
             return;
            }
        }
    }
    window.close();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>SPECIAL_PROCEDURES_APPLY</id></radio><textarea><id>ISREAD_ROLE</id><id>ISTAGE_EMY_ROLE</id></textarea><combobox><id>HCU_ID</id></combobox><button><id>save_btn</id><id>close_btn</id></button><text><id>NDP_NAME</id><id>ISTAGE_TIME_LIMIT</id><id>ISTAGE_EMY_ID</id><id>ISTAGE_ROLE_ID</id><id>NDP_ID</id><id>PI_ID</id><id>ISREAD_ID</id><id>ISREAD_ROLE_ID</id><id>userIds</id><id>userNames</id><id>roleIds</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>SPECIAL_PROCEDURES_APPLY</taborder><taborder>NDP_NAME</taborder><taborder>ISTAGE_TIME_LIMIT</taborder><taborder>ISTAGE_EMY_ROLE</taborder><taborder>save_btn</taborder><taborder>close_btn</taborder><taborder>PI_ID</taborder><taborder>NDP_ID</taborder><taborder>ISTAGE_EMY_ID</taborder><taborder>ISTAGE_ROLE_ID</taborder><taborder>HCU_ID</taborder><taborder>ISREAD_ROLE</taborder><taborder>ISREAD_ID</taborder><taborder>ISREAD_ROLE_ID</taborder><taborder>userIds</taborder><taborder>userNames</taborder><taborder>roleIds</taborder></root>" dj_sn="20100909091811906298" caption="事项阶段受理" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:1;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:13;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181609484868" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishMent.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishMentDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMentVo.js">

<TABLE class=Ttable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD width="100%">
            <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=B1 width="30%">阶段名称<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=input_out id=NDP_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ndp_name" china="新建字段" dataset="dataset1"></TD>
                     <TD class=B1 width="10%">时限</TD>
                     <TD width="30%"><INPUT class=input_out id=ISTAGE_TIME_LIMIT style="LEFT: 0px; WIDTH: 45%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="istage_time_limit" china="新建字段" dataset="dataset1"><SELECT id=HCU_ID style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="HCU_ID" china="新建字段" dataset="dataset1" tempvalue="1&#13;&#10;2" temptext="工作日&#13;&#10;工作时" sql check="1"><OPTION value=1 selected>工作日</OPTION><OPTION value=2>工作时</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=B1>是否可特别程序申请</TD>
                     <TD colSpan=3><FIELDSET id=SPECIAL_PROCEDURES_APPLY contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 17px" onmovestart=moveStart() controltype="radio" field="special_procedures_apply" china="新建字段" dataset="dataset1" tempvalue="1&#13;&#10;0" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="0"><INPUT class=Ct style="WIDTH: 20px" type=radio value=1 name=RGSPECIAL_PROCEDURES_APPLY text="是"><SPAN onclick=RGSPECIAL_PROCEDURES_APPLY[0].checked=true;SPECIAL_PROCEDURES_APPLY.value=RGSPECIAL_PROCEDURES_APPLY[0].value;RGSPECIAL_PROCEDURES_APPLY[0].focus();>是</SPAN>&nbsp;<INPUT class=Ct style="WIDTH: 20px" type=radio CHECKED value=0 name=RGSPECIAL_PROCEDURES_APPLY text="否"><SPAN onclick=RGSPECIAL_PROCEDURES_APPLY[1].checked=true;SPECIAL_PROCEDURES_APPLY.value=RGSPECIAL_PROCEDURES_APPLY[1].value;RGSPECIAL_PROCEDURES_APPLY[1].focus();>否</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=B1>只读人员和角色</TD>
                     <TD colSpan=3><TEXTAREA id=ISREAD_ROLE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 99px; TEXT-ALIGN: left" onmovestart=moveStart() readOnly align="left" controltype="textarea" field="isread_role" china="新建字段" dataset="dataset1" value="textarea1" onclick='bill_onclick("chooseIsReadRole()")' induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=B1>操作人员和角色<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA id=ISTAGE_EMY_ROLE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 99px; TEXT-ALIGN: left" onmovestart=moveStart() readOnly align="left" controltype="textarea" value="textarea1" onclick='bill_onclick("chooseIstageEmyRole()")' induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD class=B2 align=middle><BUTTON class=button id=save_btn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("savaData()")'>保存</BUTTON><BUTTON class=button id=close_btn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeWin()")'>关闭</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<DIV style="WIDTH: 95%" align=center>&nbsp;</DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>pi_id</fieldname><datatype>字符</datatype><displaylabel>事项ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ndp_id</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ndp_name</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>special_procedures_apply</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>istage_time_limit</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>istage_emy_role</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>package_id</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>flow_version</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>process_id</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>istage_order</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HCU_ID</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>isread_role</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><pi_id></pi_id><ndp_id></ndp_id><ndp_name></ndp_name><special_procedures_apply></special_procedures_apply><istage_time_limit></istage_time_limit><istage_emy_role></istage_emy_role><package_id></package_id><flow_version></flow_version><process_id></process_id><istage_order></istage_order><HCU_ID></HCU_ID><isread_role></isread_role></dsid>")' onGetText='bill_ondatasetgettext("<dsid><pi_id></pi_id><ndp_id></ndp_id><ndp_name></ndp_name><special_procedures_apply></special_procedures_apply><istage_time_limit></istage_time_limit><istage_emy_role></istage_emy_role><package_id></package_id><flow_version></flow_version><process_id></process_id><istage_order></istage_order><HCU_ID></HCU_ID><isread_role></isread_role></dsid>")' onValid='bill_ondatasetvalid("<dsid><pi_id></pi_id><ndp_id></ndp_id><ndp_name></ndp_name><special_procedures_apply></special_procedures_apply><istage_time_limit></istage_time_limit><istage_emy_role></istage_emy_role><package_id></package_id><flow_version></flow_version><process_id></process_id><istage_order></istage_order><HCU_ID></HCU_ID><isread_role></isread_role></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<INPUT id=ISTAGE_EMY_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 15px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=2 controltype="text">

<INPUT id=ISTAGE_ROLE_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 19px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=3 controltype="text">

<INPUT id=NDP_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 27px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text" field="ndp_id" china="新建字段" dataset="dataset1">

<INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 28px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text" field="pi_id" china="事项ID" dataset="dataset1">

<INPUT id=ISREAD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 33px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text">

&nbsp;

<INPUT id=ISREAD_ROLE_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 21px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=3 controltype="text">

&nbsp;

<INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 39px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text">

&nbsp;

<INPUT id=userNames style="DISPLAY: none; LEFT: 0px; WIDTH: 36px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text">

&nbsp;

<INPUT id=roleIds style="DISPLAY: none; LEFT: 0px; WIDTH: 27px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text">
</DIV>
<div id='grid_tip'></div></body></html>
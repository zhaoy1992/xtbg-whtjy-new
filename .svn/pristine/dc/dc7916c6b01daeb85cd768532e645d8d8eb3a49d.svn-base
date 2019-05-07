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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/SendPunishData.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/SendPunishData.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SendPunishDataDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SendPunishDataDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SendPunishDataVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SendPunishDataVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
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

/**
 * <p> 移送业务操作
 * <p>Copyright: Copyright (C)  </p>
 * @creator xianlu.lu on 2010-09-28
 * @version 1.0  
 */
var wft_id = parent.wftId;
var ndp_id = parent.NdpId;
var pi_id = parent.PiId;
var user_id = getSysElement("userid");
var rfl_id = 0; 
/**
 *  函数:   init
 *  说明:   初始化函数
 *  参数:   
 *  返回值: 
 */
function init() {
    if (parent.readOnlyFlag=="readOnly") {
        $("btnYs").style.display="none";
        rfl_id = SendPunishData.getRilIdByWftIdAndNdpId(wft_id, 2);
    }
    pubdjbh=wft_id;
    var querySql = SendPunishData.getPunishInstanceNewUnitInfo(wft_id);
    dataset2.Open(querySql);
    var rowcount=dataset2.RecordCount;
    dataset2.MoveFirst();
    var bu_id = "";
    var wft_referral_unit = "";
    for(i=1;i<=rowcount;i++){
         bu_id = dataset2.Fields.Field['bu_id'].Value;
         wft_referral_unit =  dataset2.Fields.Field['wft_referral_unit'].Value;
         dataset2.MoveNext();
    }   
    $('org_id').value = bu_id;
    $('receive_deptname').value = wft_referral_unit;
    
    var querySql = SendPunishData.selectPunishInstanceOpinion(wft_id);
    $('punishIdea').value = DBUtil.SqlToField(querySql);
    
}

/**
 *  函数:   saveSendPunishDataInfo
 *  说明:   保存移送相关信息
 *  步骤:  (1)、插入执法主体变更历史表
            (2)、更新处罚事项实例表移送至单位字段
            (3)、插入行政处罚意见
            (4)、保存移送资料附件（查询）
 *  参数:   
 *  返回值: 
 */
function saveSendPunishDataInfo() {
    if (confirm("是否移送案件？")) {
        if (validate()) {
            var ysObj = new SendPunishDataVo.SendData();
            var ysVo = DBUtil.getVoFromPage(ysObj);
            ysVo.WFT_REFERRAL_UNIT = $("receive_deptname").value;
            ysVo.BU_ID = $("org_id").value;
            ysVo.SUH_DATE = FormUtil.getServerDate();
            ysVo.MD_EDIT_DATE = FormUtil.getServerDate();
            ysVo.WFT_ID = wft_id;
            ysVo.NDP_ID = ndp_id;
            ysVo.PI_ID = pi_id;
            ysVo.TP_EMY = user_id;
            ysVo.MD_FILE = rfl_id;
            ysVo.IS_ID = "4";//消息来源之移送
              var sqlTmp =SendPunishData.selectPunishInstanceOldUnit(wft_id);
            ysVo.SU_ID_OLD = SqlToField(sqlTmp);
            ysVo.MD_TITLE = "行政处罚意见";
            ysVo.MD_BODY = $("punishIdea").value;
            var returnValue = SendPunishData.saveSendPunishDataInfo(ysVo);
            if(returnValue){
                alert("案件移送成功！");
                parent.parent.window.location.href = "20100929153136375631.jsp";
            }else{
                alert("案件移送失败！");
            }
        }
    }
}

function validate(){
    var flag = true;
    if (flag) {
        if (IsSpace($("receive_deptname").value)) {
            alert("请选择接收单位！");
            flag = false;
        }
    }
    $("punishIdea").value = $("punishIdea").value.trim();
    if (flag) {
        if (IsSpace($("punishIdea").value)) {
            alert("行政处罚意见不能为空！");
            flag = false;
        }
    }
    return flag;
}

/* 打开上传下载页面 */
function openUploadAndDownView(){
    if (IsSpace(rfl_id)) {
        rfl_id = DBUtil.getSeq("SEQ_REF_INFO_LIST");
    }
    var isAllowDelete = true ;
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+rfl_id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+rfl_id +"&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

//打开执法主体的选择
function openOrgTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseAllZfztSingle.jsp";
    $("orgNames").value = $("receive_deptname").value ;
    $("orgIds").value = $("org_id").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("receive_deptname").value = $("orgNames").value ;
    $("org_id").value  = $("orgIds").value ;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>punishIdea</id></textarea><img><id>img0</id></img><button><id>btnUpload</id><id>btnYs</id></button><text><id>org_id</id><id>orgNames</id><id>orgIds</id><id>receive_deptname</id></text><dataset><id>dataset1</id><id>dataset2</id></dataset></root>" billtaborder="<root><taborder>punishIdea</taborder><taborder>receive_deptname</taborder><taborder>org_id</taborder><taborder>btnYs</taborder><taborder>btnUpload</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100911150617625282" caption="移送" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:1;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/common/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SendPunishData.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SendPunishDataDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SendPunishDataVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE class=Ctable height="40%" width="100%" align=center border=1>
   <TBODY>
      <TR>
         <TD class=taobox align=middle colSpan=2>移送</TD>
      </TR>
      <TR>
         <TD class=c2>接收单位<INPUT id=org_id style="DISPLAY: none; LEFT: 60px; WIDTH: 110px; POSITION: static; TOP: 26px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 52px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=9 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 42px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text"></TD>
         <TD><INPUT id=receive_deptname style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openOrgTree()")'><IMG id=img0 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/app_xzcf/images/search12.gif" controltype="img" onclick='bill_onclick("openOrgTree()")' cover="9" srcsk="../../../ccapp/app_xzcf/images/search12.gif"></TD>
      </TR>
      <TR>
         <TD class=c2 height=92>行政处罚意见</TD>
         <TD><TEXTAREA id=punishIdea style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() cols=135 controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD class=c2>移送资料</TD>
         <TD><BUTTON class=button id=btnUpload style="LEFT: 302px; POSITION: static; TOP: 143px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>附件上传</BUTTON></TD>
      </TR>
      <TR>
         <TD align=middle colSpan=2><BUTTON class=button id=btnYs style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveSendPunishDataInfo();")'>移送</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>wft_id</fieldname><datatype>字符</datatype><displaylabel>违法事项实例ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ID</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" saveastable="TA_DOCUMENT_MULTI" multiResult="否"></fc:dataset>

<fc:dataset id=dataset2 format="<fields><field><fieldname>bu_id</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_referral_unit</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
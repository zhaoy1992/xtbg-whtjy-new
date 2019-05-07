<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js" defer></script>
		<script src="../../fceform/js/ccapp_pub.js" defer></script>		
		<script src="../../../eformsys/gaeditor/js/gaeditor.js" defer></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js" defer></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			var _my_namespace_js = "<script src='"+stylePath+"js/namespace.js"+"'></"+"script>";
			window.document.write(_my_namespace_js);		
		</script>
		<%@ include file="../../../iWebOffice2006/js/iWebOffice2006Event.jsp"%>
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/Namespace.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/commonOperation.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/util/public.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/vo/vo.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/workflow.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/style_right.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all-debug.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script><script language='vbscript' src='../../fceform/js/fcmask.vbs'></script><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<script>document.write("<script type='text/javascript' src='<%=request.getContextPath()%>/dwrxzsp/interface/InstanceManager.js'><\/script>");
document.write("<script type='text/javascript' src='<%=request.getContextPath()%>/dwrxzsp/engine.js'><\/script>");
document.write("<script type='text/javascript' src='<%=request.getContextPath()%>/dwrxzsp/util.js'><\/script>");

top.document.title = "不予受理";


//==============================================全局对象变量定义=========================================
var PageParms = {
    ccFormId :IsSpace(creator_getQueryString("cc_form_instanceid"))? "":creator_getQueryString("cc_form_instanceid"),
    ecId :IsSpace(creator_getQueryString("ec_id"))? "":creator_getQueryString("ec_id"),//得到项目基本信息ID
    applyType :IsSpace(creator_getQueryString("apply_type"))? "":creator_getQueryString("apply_type"),//申请者类别
    tmpAttachList : new Array(),
    instanceOpener : window.dialogArguments
}


/**
 * 初始化：显示项目名称及申请者信息
 * 根据实际情况，决定是显示申请单位名称还是申请人姓名
 */
function init(){
    initDisplayFields();
}


//将带过来的参数值赋给界面元素
function initDisplayFields(){
    $('txtItemInsName').value = creator_getQueryString("item_insname");
    $('applyNameTD').innerHTML = (PageParms.applyType=="1")?"申请单位名称":"申请人姓名";
    $('txtApplyName').value =  creator_getQueryString("apply_name");
    $('txtInstanceCode').value = creator_getQueryString("instance_code");
}


//判断是否输入了不予受理原因
function isMemoEntered(){
    if(IsSpace($('NOTACCEPT_REASON').value)){
        alert("请输入不予受理原因");
        $('NOTACCEPT_REASON').focus();
        return false;
    }
    return true;
}


/**
 * 打印不予受理通知书
 */
function printNotAccept(){
    if(!isMemoEntered()){ //如果还没输入不予受理原因，则返回
        return;
    }
    var flowId = creator_getQueryString("flow_id");
    var actDefId = creator_getQueryString("actdef_id");
    var reportId = xzsp.api.BaseService2InstanceAPI.getReportId(flowId,actDefId,"02");
    if(IsSpace(reportId)){
        reportId = getDefaultReportId("02");
    }
  //  printReportByRaqId(reportId);
    $('btnNotAccept').disabled = false;
}


//覆盖workflow.js中的函数
function getReprotParam(){
    var reportParam = new Array();
    reportParam.push("&instance_code=");
    reportParam.push(creator_getQueryString("instance_code"));
    reportParam.push("&apply_name=");
    reportParam.push(creator_getQueryString("apply_name"));
    reportParam.push("&accept_time=");
    reportParam.push(getChnFormat(getCrntDateFmt1FromDB())); //取当前日期
    reportParam.push("&item_insname=");
    reportParam.push(creator_getQueryString("item_insname"));
    reportParam.push("&item_name=");
    reportParam.push(creator_getQueryString("item_name"));
    reportParam.push("&apply_year=");
    reportParam.push(creator_getQueryString("apply_year"));
    reportParam.push("&apply_month=");
    reportParam.push(creator_getQueryString("apply_month"));
    reportParam.push("&apply_day=");
    reportParam.push(creator_getQueryString("apply_day"));
    return reportParam.join("");
}


/**
 * 不予受理
 * 从受理表单获取各种项目信息、材料信息等数据
 * 从本表单获取不予受理信息
 * 调用业务逻辑：不必执行流程操作，将项目状态update为“不予受理”
 */
function doNotAccept(){
    if(!isMemoEntered()){ //如果还没输入不予受理原因，则返回
        return;
    }
    if(IsSpace(creator_getSession("cc_form_instanceid")) || (creator_getSession("cc_form_instanceid")=="clear")){
        PageParms.ccFormId = getNewCc_form_instanceid("true"); //生成一个新的业务ID
        creator_setSession("cc_form_instanceid",PageParms.ccFormId);
    }
    var inputDatas = PageParms.instanceOpener.getInputData();
    var notAcceptVO = xzsp.util.DBUtil.getVoFromPage(new xzsp.vo.NotAccept());
    notAcceptVO.cc_form_instanceid = creator_getSession("cc_form_instanceid");
    if(confirm("您确定要不予受理吗？")){
        createOverlayDIV();
        InstanceManager.doNotAccept(inputDatas[0],inputDatas[1],inputDatas[2],
                                inputDatas[3],notAcceptVO,defaultCallbackForOpenWin);
    }
}
</script><DIV id=SKbillsheet toolbar="不带工具栏" billtaborder="<root><taborder>NOTACCEPT_REASON</taborder><taborder>btnPrtNotAccept</taborder><taborder>btnNotAccept</taborder><taborder>btnClose</taborder><taborder>txtItemInsName</taborder><taborder>txtApplyName</taborder><taborder>txtInstanceCode</taborder></root>" testDbName dj_sn="20090827153049468594" caption="不予受理办件" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth posheight isfile="否" OtherSave="否" creator_csslib="style_right.css" idtype="1" version="1.0" creator_pagination controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" contxml="<root><textarea><id>NOTACCEPT_REASON</id></textarea><button><id>btnPrtNotAccept</id><id>btnNotAccept</id><id>btnClose</id></button><text><id>txtItemInsName</id><id>txtApplyName</id><id>txtInstanceCode</id></text><dataset><id>notAcceptDataset</id></dataset></root>" type="ZW" creatorType="20090825142958890821" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js&#13;&#10;../../../ccapp/app_5/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/workflow.js&#13;&#10;../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js"><TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width=750 align=left border=0>
<TBODY>
<TR>
<TD>
<TABLE class=table_function width="100%">
<TBODY>
<TR>
<TD class=color width="15%">项目名称</TD>
<TD><INPUT id=txtItemInsName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD></TR>
<TR>
<TD class=color id=applyNameTD></TD>
<TD><INPUT id=txtApplyName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
<TR>
<TD class=color>受理流水号</TD>
<TD><INPUT id=txtInstanceCode style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD></TR>
<TR>
<TD class=color><FONT color=red>*</FONT>不予受理原因</TD>
<TD><TEXTAREA id=NOTACCEPT_REASON style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 118px" onmovestart=moveStart() cols=106 controltype="textarea" field="NOTACCEPT_REASON" dataset="notAcceptDataset" china="不予受理原因" induce="否" value="textarea1"></TEXTAREA></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD vAlign=top align=middle><BUTTON class=btn_long id=btnPrtNotAccept onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("printNotAccept()")'>打印不予受理通知书</BUTTON><BUTTON class=btn id=btnNotAccept disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doNotAccept()")'>不予受理</BUTTON><BUTTON class=btn id=btnClose onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("window.close();")'>关闭</BUTTON></TD></TR></TBODY></TABLE><?xml:namespace prefix = fc /><fc:dataset id=notAcceptDataset onValid='bill_ondatasetvalid("<dsid><NOTACCEPT_REASON></NOTACCEPT_REASON><REMARK></REMARK></dsid>")' onGetText='bill_ondatasetgettext("<dsid><NOTACCEPT_REASON></NOTACCEPT_REASON><REMARK></REMARK></dsid>")' onSetText='bill_ondatasetsettext("<dsid><NOTACCEPT_REASON></NOTACCEPT_REASON><REMARK></REMARK></dsid>")' format="<fields><field><fieldname>NOTACCEPT_REASON</fieldname><datatype>字符</datatype><displaylabel>不予受理原因</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>REMARK</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" multiResult="否" temptable="TMP_DATASET1" opensortno="1"></fc:dataset></DIV></body></html>
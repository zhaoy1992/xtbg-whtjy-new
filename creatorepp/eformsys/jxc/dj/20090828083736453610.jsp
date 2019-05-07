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
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/prototype.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/Namespace.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/util/public.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/vo/vo.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/util/public.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/BaseDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/BaseinfoDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/ExtrainfoDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/LawsDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/LawsItemDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/WfactionDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/ChargeDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/BaseAttachDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/business/ChargeManage.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/business/BaseInfoManage.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/business/BaseAttachManage.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/business/LawsManage.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/dao/FlowInfoDao.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/business/FlowInfoManage.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/style_right.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all-debug.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script><script language='vbscript' src='../../fceform/js/fcmask.vbs'></script><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script><script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script><script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script><script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script><script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script><script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>
<script>var ec_id='<%=request.getParameter("ec_id")%>';  
var baseinfo = null;
var flManager = null;
ec_id=1341;
function init()   //初使化表单数据
{  
    baseinfo = new xzsp.business.BaseInfoManage();
    flManager = new xzsp.business.FlowInfoManage();
    $("EC_ID").value = ec_id;
    baseinfo.queryBaseByEcId(baseInfoDataset,ec_id);
    initFLFG();
}

function initAttachInfo(){
    var map = new xzsp.util.Map();
    map.put("ds",attachDataset);
    map.put("ec_id",ec_id);
    xzsp.business.BaseAttachManage.queryProBaseAttch(map);
}

function initChargeInfo(){
    xzsp.business.ChargeManage.queryChargeByECID(chargeDataset,ec_id);
}

////==初始化材料信息===
function initFlowInfo(){

    //获取所有流程信息
    flManager.queryFlowInfo(flowInfoDataset,ec_id);
    //获取当前流程信息
    getCurrentFlowInfo();
    flManager.queryCurentWfAction(wfActionDataset,ec_id);

    //获取当前流程环节列表信息
}

// 初始化法律法规
function initFLFG(){
    baseinfo.queryExtraByEcId(extraInfoDataset,ec_id);   
    xzsp.business.LawsManage.queryLawsByecid(flfgDataset,ec_id);
}

function chooseWorkFlow(){

 var wfInfo= window.showModalDialog("../../../jawe/jawe_tree/jaweTree.jsp","center:yes");
   if(wfInfo){
       $("MGRNAME").value = wfInfo;
      
   }else{
      return;
   }
}

function useFlowInfo(){
    var flowId=flowInfoDataset.Fields.Field["FLOW_ID"].Value;
    var btn = event.srcElement;
 
    if(flManager.useHistoryFlowInfo(ec_id,flowId)){
        initFlowInfo();
        getCurrentFlowInfo();
        alert("启用成功！");
    }else{
        alert("启用失败！");
    }
   //  flManager.addWfAction(flowId,packageId,processId,version);
    
}

function getCurrentFlowInfo(){
    var rowcount = flowInfoGrid.Rows;
    flowInfoDataset.MoveFirst();
    rowcount =  rowcount - 1;
    for(i=1;i<=rowcount;i++){
       if(flowInfoDataset.Fields.Field['IS_VALID'].Value=="Y"){
             $("currentProcessNameText").value = flowInfoDataset.Fields.Field['PROCESS_ID'].Value;
             $("currentVersion").value = flowInfoDataset.Fields.Field['FLOW_VERSION'].Value;
             return;
         }
       flowInfoDataset.MoveNext();
     }


}


function saveFlowInfo(){
    //ec_id=$("ec_id").value;
        
	var flowInfo=$("MGRNAME").value;

	if(IsSpace(flowInfo)){
	    alert("请选择发布的流程信息");
	    return;
	}
	var packageId=flowInfo.split("%23")[0];
	var version=flowInfo.split("%23")[1];
	var processId=flowInfo.split("%23")[2];
	var flowId = flManager.saveFlowInfo(packageId,processId,ec_id,version);

	if(flowId ){
               flManager.addWfAction(flowId,packageId,processId,version);
               initFlowInfo();
           }
}

function queryFlowWfAction(){
    var flowId = flowInfoDataset.Fields.Field['FLOW_ID'].Value;
    flManager.queryFlowWfAction(wfActionDataset,flowId );

}
 
 
/* 去选择法律法规 */
function toAddFlfg() {
    var para = null;
    para = new Array(ec_id,'22');		
    window.showModalDialog("20090430085245593670.jsp",para,"dialogWidth:540px;");
    initFLFG();
}
 

function openAddChargePage(){    //去添加收费信息
    var org_id=$("ORGID").value;;
    var url = "20090504114309562547.jsp?ec_id="+ec_id+"&org_id="+org_id+"&condition=true";
    window.showModalDialog(url,"","dialogWidth:800px,dialogHeight:500px;");
    initChargeInfo();
}

function savaBaseInfo(){        
    if(!checkInput()){
        return false;
    } 
    baseinfo.updateBase(); 
    saveExtraInfo();

}
function saveExtraInfo() { 
    var extid = baseinfo.saveExtra();
   if(extid ){
       $("EXTRA_ID").value=extid ;  
      // alert("保存高级信息成功");
   }       
}

/*   删除法律法规  */
function DeleteFLFG(){
 
    if(!confirm("是否要删除选中信息？")){
         return;
    } 
    var rowcount = flfgDataset.RecordCount;
    var ids = new Array();
    flfgDataset.MoveFirst();
    for(i=0;i<=rowcount;i++){
       if(flfgDataset.Fields.Field['check_flag'].Value=="是") 
        {
             var id=flfgDataset.Fields.Field['id'].Value;
             ids[ids.length]=id;  
        }
        flfgDataset.MoveNext();
     }
    if(baseinfo.delPrjLaws(ec_id,ids)){
        initFLFG();
        alert("删除成功！");
    }else{
        alert("删除失败！");
    }
}


function DeleteDatum(){   //删除选中材料

    if(!confirm("是否要删除选中信息？")){
         return;
    }
    var rowcount = attachGrid.Rows;
    attachDataset.MoveFirst();
    rowcount =  rowcount - 1;
    for(i=1;i<=rowcount;i++){
       if(attachDataset.Fields.Field['check_flag'].Value=="是") 
         {
             var id=attachDataset.Fields.Field['ATTACH_ID'].Value;
             var sql="delete  APP_5.ta_sp_baseattach where ATTACH_ID="+id;
             var s=InsertSql(sql);
         }
       attachDataset.MoveNext();
     }
     initAttachInfo();
    
 }

 
 

//************  流程定义   双击事件

function clickActoinRecord() {
 var org_id=document.all.ORGID.value;
    var ACTION_ID= wfActionDataset.Fields.Field['ACTION_ID'].Value;
    var action_defid = wfActionDataset.Fields.Field['action_defid'].Value;
    if (IsSpace(ACTION_ID)) {
        alert ("请选择一条记录");
        return;
    }   
        // 打开页面
    window.location.href="20090430173316875178.jsp?ec_id="+ec_id+"&ACTION_ID="+ ACTION_ID+"&condition=true&action_defid="+action_defid; 
}
//********************************* 检查用户输入信息是否合法
function checkInput(){/*
   if(IsSpace($("ITEM_NAME").value)){
     alert("项目名称不能为空");
     return false;
   }
    if(IsSpace($("ITEM_CODE").value)){ 
     alert("项目编号不能为空");
     return false;
   }
   reg = /^\d{12}$/
   if(!reg.test( trim($("ITEM_CODE").value))){
     alert("项目编码格式不对，应为12位数字字符");
     return false;
   }*/
   return true;
}


//************  材料信息   双击事件

function openWindowAttach() {
 var org_id=document.all.ORGID.value;
    var ATTACH_ID= attachDataset.Fields.Field['ATTACH_ID'].Value;
    if (IsSpace(ATTACH_ID)) {
        alert ("请选择一条记录");
        return;
    }     
        // 打开页面
    var url ="20090429103847546184.jsp?ec_id="+ec_id+"&attach_id="+ ATTACH_ID+"&condition=true";
    window.showModalDialog(url,"","dialogWidth:800px,dialogHeight:500px;");
    initAttachInfo();
}

function openWindowAttach4Add() {
    var org_id= $("ORGID").value;
    // 打开页面
    var url ="20090429103847546184.jsp?ec_id="+ec_id+"&condition=true";
    window.showModalDialog(url,"","dialogWidth:800px,dialogHeight:500px;");
    initAttachInfo();
}
 

function openCatalogPage(){
    var url = "../../../ccapp/app_5/jsp/baseservice/chooseCalalog.jsp?valid=true";
    var catlogObj = {};
    catlogObj.id= $("SERVICE_TYPEID").value;
    catlogObj.name= $("SERVICE_TYPENAME").value;
    catlogObj = window.showModalDialog(url,catlogObj, "dialogWidth=800px;dialogHeight=600px");
    if(catlogObj){
         $("SERVICE_TYPEID").value = catlogObj.id;
         $("SERVICE_TYPENAME").value = catlogObj.name;
    }
}

//-=========打开证件管理管理页面=============
function openCertManagerPage(){
    var url ="20090505093843453935.jsp?ec_id="+ec_id;
    window.showModalDialog(url,"","dialogWidth:800px,dialogHeight:500px;");
}

function openBaseInfoChargeManager(){
    var orgId = $("ORGID").value;
    var url ="20090505111422093877.jsp?ec_id="+ec_id+"&orgId="+orgId;
    window.showModalDialog(url,"","dialogWidth:800px,dialogHeight:500px;");
}

/**
 * 选择项目基本信息的机构
 *
****/
function chooseOrg(){
    var url = "../../../ccapp/app_5/jsp/baseservice/orgTree.jsp"
    var orgObj= null;
    orgObj = window.showModalDialog(url,"", "dialogWidth=800px;dialogHeight=600px");
    if(orgObj){
         $("ORGID").value = orgObj.id;
         $("ORGNAME").value = orgObj.name;
    }
}
</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/prototype.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/dao/BaseDao.js&#13;&#10;../../../ccapp/app_5/js/dao/BaseinfoDao.js&#13;&#10;../../../ccapp/app_5/js/dao/ExtrainfoDao.js&#13;&#10;../../../ccapp/app_5/js/dao/LawsDao.js&#13;&#10;../../../ccapp/app_5/js/dao/LawsItemDao.js&#13;&#10;../../../ccapp/app_5/js/dao/WfactionDao.js&#13;&#10;../../../ccapp/app_5/js/dao/ChargeDao.js&#13;&#10;../../../ccapp/app_5/js/dao/BaseAttachDao.js&#13;&#10;../../../ccapp/app_5/js/business/ChargeManage.js&#13;&#10;../../../ccapp/app_5/js/business/BaseInfoManage.js&#13;&#10;../../../ccapp/app_5/js/business/BaseAttachManage.js&#13;&#10;../../../ccapp/app_5/js/business/LawsManage.js&#13;&#10;../../../ccapp/app_5/js/dao/FlowInfoDao.js&#13;&#10;../../../ccapp/app_5/js/business/FlowInfoManage.js&#13;&#10;" creatorType="20090825142958890821" type="ZW" toolbar="不带工具栏" billtaborder="<root><taborder>REMARK</taborder><taborder>WORK_GUIDE</taborder><taborder>WORK_FLOW</taborder><taborder>TRANSTYPE</taborder><taborder>ITEM_TYPE</taborder><taborder>ISCHARGE</taborder><taborder>IS_CERTIFY</taborder><taborder>IS_VALID</taborder><taborder>IS_OUTERAPPLY</taborder><taborder>ITEM_NAME</taborder><taborder>ITEM_CODE</taborder><taborder>SERVICE_TYPENAME</taborder><taborder>ITEM_LIMIT</taborder><taborder>ITEM_ORDER</taborder><taborder>ORGNAME</taborder><taborder>EC_ID</taborder><taborder>PARENT_ID</taborder><taborder>ORGID</taborder><taborder>EXTRA_ID</taborder><taborder>SERVICE_TYPEID</taborder><taborder>SHENPI_URL</taborder><taborder>flowId</taborder><taborder>SHENPI_JC</taborder></root>" testDbName="xzsp" dj_sn="20090828083638078024" caption="审批规范" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth="600" posheight="500" isfile="否" OtherSave="否" creator_csslib="style_right.css" idtype="1" version="1.0" creator_pagination controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:5;ExtUpload:0;ExtTree:0" contxml="<root><textarea><id>REMARK</id><id>WORK_GUIDE</id><id>WORK_FLOW</id></textarea><combobox><id>TRANSTYPE</id><id>ITEM_TYPE</id><id>ISCHARGE</id><id>IS_CERTIFY</id><id>IS_VALID</id><id>IS_OUTERAPPLY</id></combobox><text><id>ITEM_NAME</id><id>ITEM_CODE</id><id>SERVICE_TYPENAME</id><id>ITEM_LIMIT</id><id>ITEM_ORDER</id><id>ORGNAME</id><id>EC_ID</id><id>PARENT_ID</id><id>ORGID</id><id>EXTRA_ID</id><id>SERVICE_TYPEID</id><id>SHENPI_URL</id><id>flowId</id><id>SHENPI_JC</id></text><dataset><id>baseInfoDataset</id><id>extraInfoDataset</id><id>flfgDataset</id><id>attachDataset</id></dataset><ExtGrid><id>ExtGrid5</id></ExtGrid></root>"><TABLE style="WIDTH: 100%; POSITION: static; HEIGHT: 577px" cellSpacing=2 cellPadding=1 align=center border=0>
<TBODY>
<TR>
<TD class=all_title vAlign=top align=left colSpan=6>审批事项详情</TD></TR>
<TR>
<TD vAlign=top align=right colSpan=6>
<TABLE class=table_function style="WIDTH: 100%; HEIGHT: 169px" cellSpacing=0 cellPadding=0 align=center border=0>
<TBODY>
<TR>
<TD class=color>事项名称</TD>
<TD colSpan=3><INPUT class=nolinetext id=ITEM_NAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=65 controltype="text" field="ITEM_NAME" dataset="baseInfoDataset" china="审批项目名称"></TD></TR>
<TR>
<TD class=color width="15%">事项编码 </TD>
<TD width="35%"><INPUT class=nolinetext id=ITEM_CODE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=22 controltype="text" field="ITEM_CODE" dataset="baseInfoDataset" china="审批项目编号"></TD>
<TD class=color width="15%">事项类型</TD>
<TD><SELECT id=TRANSTYPE style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="TRANSTYPE" dataset="baseInfoDataset" china="项目类型" temptext tempvalue check="2" sql backheight="25" backwidth="120" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6%F2%D0%EA%F4%F6%u0100%EE%D8%CC%E0%D6Xr%94Xrn%F6%F2%D0%EA%F4%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%90%AE%AE%CCxj%F6%D0%CC%EE%D0%F2%D0%E8%CC%F6%F2%D0%EA%F4%F6%u0100%EE%D8"></SELECT></TD></TR>
<TR>
<TD class=color>事项类别</TD>
<TD><SELECT id=ITEM_TYPE style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="ITEM_TYPE" dataset="baseInfoDataset" china="项目类别" temptext tempvalue check="2" sql backheight="25" backwidth="120" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%B6%98%A8%B6%C0%AE%98%CC%BA%90%A6%B8%98Xr%94%A0%F6%D8%E8%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%90%AE%AE%CCxj%F6%D0%CC%EE%D0%F2%D0%E8%CC%A0%F6%D8%E8%F6%u0100%EE%D8"></SELECT></TD>
<TD class=color>服务类型</TD>
<TD><INPUT id=SERVICE_TYPENAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=16 controltype="text" field="SERVICE_TYPENAME" dataset="baseInfoDataset" china="SERVICE_TYPENAME"></TD></TR>
<TR>
<TD class=color>收费类型</TD>
<TD><SELECT id=ISCHARGE style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="ISCHARGE" dataset="baseInfoDataset" china="收费类型" temptext="不收费&#13;&#10;收费" tempvalue="N&#13;&#10;Y" check="1" sql backheight="25" backwidth="120" sqltrans><OPTION value=N selected>不收费</OPTION><OPTION value=Y>收费</OPTION></SELECT></TD>
<TD class=color>是否颁证</TD>
<TD><SELECT id=IS_CERTIFY style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="IS_CERTIFY" dataset="baseInfoDataset" china="证件颁证" temptext="是&#13;&#10;否" tempvalue="Y&#13;&#10;N" check="1" sql backheight="25" backwidth="120" sqltrans><OPTION value=Y selected>是</OPTION><OPTION value=N>否</OPTION></SELECT></TD></TR>
<TR>
<TD class=color>是否有效</TD>
<TD><SELECT id=IS_VALID style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="IS_VALID" dataset="baseInfoDataset" china="是否有效" temptext="有效&#13;&#10;无效" tempvalue="Y&#13;&#10;N" check="1" sql backheight="25" backwidth="122" sqltrans><OPTION value=Y selected>有效</OPTION><OPTION value=N>无效</OPTION></SELECT></TD>
<TD class=color>是否可外网预受理</TD>
<TD><SELECT id=IS_OUTERAPPLY style="WIDTH: 100%; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="combobox" field="IS_OUTERAPPLY" dataset="baseInfoDataset" china="IS_OUTERAPPLY" temptext="是&#13;&#10;否" tempvalue="Y&#13;&#10;N" check="1" sql backheight="25" backwidth="120" sqltrans><OPTION value=Y selected>是</OPTION><OPTION value=N>否</OPTION></SELECT></TD></TR>
<TR>
<TD class=color>事项时限</TD>
<TD><INPUT class=nolinetext id=ITEM_LIMIT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 60px; BORDER-BOTTOM: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" field="ITEM_LIMIT" dataset="baseInfoDataset" china="ITEM_LIMIT">工作日</TD>
<TD class=color>顺序号</TD>
<TD><INPUT class=nolinetext id=ITEM_ORDER style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=16 controltype="text" field="ITEM_ORDER" dataset="baseInfoDataset" china="审批顺序"></TD></TR>
<TR>
<TD class=color>受理单位</TD>
<TD colSpan=3><INPUT class=nolinetext id=ORGNAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="ORGNAME" dataset="baseInfoDataset" china="ORGNAME"></TD></TR>
<TR>
<TD class=color>备注</TD>
<TD colSpan=3><TEXTAREA id=REMARK style="WIDTH: 100%; HEIGHT: 29px" onmovestart=moveStart() rows=1 readOnly cols=86 controltype="textarea" field="REMARK" dataset="baseInfoDataset" china="描述" induce="否" value="textarea2"></TEXTAREA></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD vAlign=top align=right colSpan=6>
<TABLE width="100%">
<TBODY>
<TR>
<TD class=all_title>许可规范</TD></TR>
<TR>
<TD vAlign=top align=right>
<TABLE class=table_function width="100%">
<TBODY>
<TR>
<TD class=color width="15%">办事指南</TD>
<TD><TEXTAREA id=WORK_GUIDE style="WIDTH: 100%; HEIGHT: 67px" rows=5 readOnly controltype="textarea" field="WORK_GUIDE" dataset="extraInfoDataset" china="WORK_GUIDE" induce="否" value="textarea1" HEIGHT: WIDTH:>      </TEXTAREA></TD></TR>
<TR>
<TD class=color>办事流程</TD>
<TD><TEXTAREA id=WORK_FLOW style="WIDTH: 100%; HEIGHT: 58px" rows=1 readOnly controltype="textarea" field="WORK_FLOW" dataset="extraInfoDataset" china="WORK_FLOW" induce="否" value="textarea3" HEIGHT: WIDTH:>       </TEXTAREA> </TD></TR>
<TR>
<TD class=color>法律法规</TD>
<TD></TD></TR>
<TR>
<TD colSpan=2>&nbsp;
<DIV id=div_ExtGrid5 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
<SCRIPT type=text/javascript>var ExtGrid5_retint = 0;var ExtGrid5_onReady = function(){var dataset = document.getElementById("flfgDataset");try{var temp = dataset .Fields.Field.length;}catch(e){if(ExtGrid5_retint==0) ExtGrid5_retint = setInterval(ExtGrid5_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(ExtGrid5_retint);ExtGrid5_retint = null ;var pagesize =5;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("flfgDataset"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_ExtGrid5',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:709,        height:161,		split: true,		region: 'north',		title:'法律法规',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
cm.setHidden(0,true); 
cm.setHidden(1,true); 
cm.setHidden(5,true); 




grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'ExtGrid5',obj:grid,dataset:'flfgDataset',isEdit:'false'});};ExtGrid5_onReady();</SCRIPT>
 </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE style="WIDTH: 727px; HEIGHT: 44px" cellSpacing=0 cellPadding=0 width=727 align=center border=0>
<TBODY>
<TR>
<TD>
<TABLE style="DISPLAY: none; WIDTH: 405px; POSITION: static; HEIGHT: 29px" cellSpacing=2 cellPadding=1 width=405 align=left border=1>
<TBODY>
<TR>
<TD>基本信息</TD>
<TD>高级信息</TD>
<TD>法律法规</TD>
<TD>材料信息</TD>
<TD></TD>
<TD>流程信息</TD>
<TD>活动信息</TD>
<TD></TD></TR>
<TR>
<TD><?xml:namespace prefix = fc /><fc:dataset id=baseInfoDataset opensortno="1" temptable="TMP_DATASET2" multiResult="是" saveastable="APP_5.TA_SP_BASEINFO" onValid='bill_ondatasetvalid("<dsid><DATASOURCE></DATASOURCE><EC_ID></EC_ID><ISCHARGE></ISCHARGE><IS_CERTIFY></IS_CERTIFY><IS_OUTERAPPLY></IS_OUTERAPPLY><IS_VALID></IS_VALID><ITEM_CODE></ITEM_CODE><ITEM_LIMIT></ITEM_LIMIT><ITEM_NAME></ITEM_NAME><ITEM_ORDER></ITEM_ORDER><ITEM_SHORTENING></ITEM_SHORTENING><ITEM_TYPE></ITEM_TYPE><LASTMODIFIEDTIME></LASTMODIFIEDTIME><ORGID></ORGID><ORGNAME></ORGNAME><PARENT_ID></PARENT_ID><PREWARN_TIME></PREWARN_TIME><REMARK></REMARK><SERVICE_TYPEID></SERVICE_TYPEID><TRANSTYPE></TRANSTYPE><SERVICE_TYPENAME></SERVICE_TYPENAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><DATASOURCE></DATASOURCE><EC_ID></EC_ID><ISCHARGE></ISCHARGE><IS_CERTIFY></IS_CERTIFY><IS_OUTERAPPLY></IS_OUTERAPPLY><IS_VALID></IS_VALID><ITEM_CODE></ITEM_CODE><ITEM_LIMIT></ITEM_LIMIT><ITEM_NAME></ITEM_NAME><ITEM_ORDER></ITEM_ORDER><ITEM_SHORTENING></ITEM_SHORTENING><ITEM_TYPE></ITEM_TYPE><LASTMODIFIEDTIME></LASTMODIFIEDTIME><ORGID></ORGID><ORGNAME></ORGNAME><PARENT_ID></PARENT_ID><PREWARN_TIME></PREWARN_TIME><REMARK></REMARK><SERVICE_TYPEID></SERVICE_TYPEID><TRANSTYPE></TRANSTYPE><SERVICE_TYPENAME></SERVICE_TYPENAME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><DATASOURCE></DATASOURCE><EC_ID></EC_ID><ISCHARGE></ISCHARGE><IS_CERTIFY></IS_CERTIFY><IS_OUTERAPPLY></IS_OUTERAPPLY><IS_VALID></IS_VALID><ITEM_CODE></ITEM_CODE><ITEM_LIMIT></ITEM_LIMIT><ITEM_NAME></ITEM_NAME><ITEM_ORDER></ITEM_ORDER><ITEM_SHORTENING></ITEM_SHORTENING><ITEM_TYPE></ITEM_TYPE><LASTMODIFIEDTIME></LASTMODIFIEDTIME><ORGID></ORGID><ORGNAME></ORGNAME><PARENT_ID></PARENT_ID><PREWARN_TIME></PREWARN_TIME><REMARK></REMARK><SERVICE_TYPEID></SERVICE_TYPEID><TRANSTYPE></TRANSTYPE><SERVICE_TYPENAME></SERVICE_TYPENAME></dsid>")' format="<fields><field><fieldname>DATASOURCE</fieldname><datatype>字符</datatype><displaylabel>DATASOURCE</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EC_ID</fieldname><datatype>字符</datatype><displaylabel>EC_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ISCHARGE</fieldname><datatype>字符</datatype><displaylabel>ISCHARGE</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_CERTIFY</fieldname><datatype>字符</datatype><displaylabel>IS_CERTIFY</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_OUTERAPPLY</fieldname><datatype>字符</datatype><displaylabel>IS_OUTERAPPLY</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_VALID</fieldname><datatype>字符</datatype><displaylabel>IS_VALID</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_CODE</fieldname><datatype>字符</datatype><displaylabel>ITEM_CODE</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_LIMIT</fieldname><datatype>字符</datatype><displaylabel>ITEM_LIMIT</displaylabel><size>18</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_NAME</fieldname><datatype>字符</datatype><displaylabel>ITEM_NAME</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_ORDER</fieldname><datatype>字符</datatype><displaylabel>ITEM_ORDER</displaylabel><size></size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_SHORTENING</fieldname><datatype>字符</datatype><displaylabel>ITEM_SHORTENING</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_TYPE</fieldname><datatype>字符</datatype><displaylabel>ITEM_TYPE</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LASTMODIFIEDTIME</fieldname><datatype>日期</datatype><displaylabel>LASTMODIFIEDTIME</displaylabel><size>7</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORGID</fieldname><datatype>字符</datatype><displaylabel>ORGID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORGNAME</fieldname><datatype>字符</datatype><displaylabel>ORGNAME</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PARENT_ID</fieldname><datatype>字符</datatype><displaylabel>PARENT_ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PREWARN_TIME</fieldname><datatype>实数</datatype><displaylabel>PREWARN_TIME</displaylabel><size>18</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>REMARK</fieldname><datatype>字符</datatype><displaylabel>REMARK</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SERVICE_TYPEID</fieldname><datatype>字符</datatype><displaylabel>SERVICE_TYPEID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TRANSTYPE</fieldname><datatype>字符</datatype><displaylabel>TRANSTYPE</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SERVICE_TYPENAME</fieldname><datatype>字符</datatype><displaylabel>服务名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset></TD>
<TD><fc:dataset id=extraInfoDataset opensortno="1" temptable="TMP_DATASET3" multiResult="是" saveastable="APP_5.TA_SP_EXTRAINFO" onValid='bill_ondatasetvalid("<dsid><EC_ID></EC_ID><EXTRA_ID></EXTRA_ID><LASTMODIFIEDTIME></LASTMODIFIEDTIME><WORK_FLOW></WORK_FLOW><WORK_GUIDE></WORK_GUIDE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><EC_ID></EC_ID><EXTRA_ID></EXTRA_ID><LASTMODIFIEDTIME></LASTMODIFIEDTIME><WORK_FLOW></WORK_FLOW><WORK_GUIDE></WORK_GUIDE></dsid>")' onSetText='bill_ondatasetsettext("<dsid><EC_ID></EC_ID><EXTRA_ID></EXTRA_ID><LASTMODIFIEDTIME></LASTMODIFIEDTIME><WORK_FLOW></WORK_FLOW><WORK_GUIDE></WORK_GUIDE></dsid>")' format="<fields><field><fieldname>EC_ID</fieldname><datatype>字符</datatype><displaylabel>EC_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXTRA_ID</fieldname><datatype>字符</datatype><displaylabel>EXTRA_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LASTMODIFIEDTIME</fieldname><datatype>日期</datatype><displaylabel>LASTMODIFIEDTIME</displaylabel><size>7</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WORK_FLOW</fieldname><datatype>字符</datatype><displaylabel>WORK_FLOW</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WORK_GUIDE</fieldname><datatype>字符</datatype><displaylabel>WORK_GUIDE</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset></TD>
<TD><fc:dataset id=flfgDataset opensortno="1" temptable="TMP_DATASET2" multiResult="是" onValid='bill_ondatasetvalid("<dsid><check_flag></check_flag><ID></ID><NO></NO><NAME></NAME><DEPT_NAME></DEPT_NAME><STATE></STATE><TYPE></TYPE><remark></remark></dsid>")' onGetText='bill_ondatasetgettext("<dsid><check_flag></check_flag><ID></ID><NO></NO><NAME></NAME><DEPT_NAME></DEPT_NAME><STATE></STATE><TYPE></TYPE><remark></remark></dsid>")' onSetText='bill_ondatasetsettext("<dsid><check_flag></check_flag><ID></ID><NO></NO><NAME></NAME><DEPT_NAME></DEPT_NAME><STATE></STATE><TYPE></TYPE><remark></remark></dsid>")' format="<fields><field><fieldname>check_flag</fieldname><datatype>字符</datatype><displaylabel>勾选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ID</fieldname><datatype>实数</datatype><displaylabel>ID</displaylabel><size>12</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2></columnWidth2></columnWidth1></field><field><fieldname>NO</fieldname><datatype>字符</datatype><displaylabel>编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>NAME</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27gggg%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40%25</columnWidth2></columnWidth1></field><field><fieldname>DEPT_NAME</fieldname><datatype>字符</datatype><displaylabel>发布部门</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>STATE</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TYPE</fieldname><datatype>字符</datatype><displaylabel>类型</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>remark</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field></fields>" columnWidth1Xml="<root><columnWidth1><name>ID</name><columnWidth2></columnWidth2></columnWidth1><columnWidth1><name>NO</name><columnWidth2>15%25</columnWidth2></columnWidth1><columnWidth1><name>NAME</name><columnWidth2>40%25</columnWidth2></columnWidth1><columnWidth1><name>DEPT_NAME</name><columnWidth2>15%25</columnWidth2></columnWidth1><columnWidth1><name>TYPE</name><columnWidth2>10%25</columnWidth2></columnWidth1><columnWidth1><name>remark</name><columnWidth2>20%25</columnWidth2></columnWidth1></root>" columnHeight1Xml="undefined" showtypeXml="<root><showType><name>check_flag</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>NAME</name><showRule>%5B%7Bshowtype%3A%27gggg%27%7D%5D</showRule></showType></root>"></fc:dataset></TD>
<TD><fc:dataset id=attachDataset opensortno="1" temptable="TMP_DATASET3" multiResult="否" onValid='bill_ondatasetvalid("<dsid><check_flag></check_flag><ATTACH_ID></ATTACH_ID><ATTACH_NAME></ATTACH_NAME><ATTACH_CODE></ATTACH_CODE><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_NUMBER></ATTACH_NUMBER></dsid>")' onGetText='bill_ondatasetgettext("<dsid><check_flag></check_flag><ATTACH_ID></ATTACH_ID><ATTACH_NAME></ATTACH_NAME><ATTACH_CODE></ATTACH_CODE><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_NUMBER></ATTACH_NUMBER></dsid>")' onSetText='bill_ondatasetsettext("<dsid><check_flag></check_flag><ATTACH_ID></ATTACH_ID><ATTACH_NAME></ATTACH_NAME><ATTACH_CODE></ATTACH_CODE><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_NUMBER></ATTACH_NUMBER></dsid>")' format="<fields><field><fieldname>check_flag</fieldname><datatype>字符</datatype><displaylabel>勾选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_ID</fieldname><datatype>字符</datatype><displaylabel>ATTACH_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_NAME</fieldname><datatype>字符</datatype><displaylabel>材料名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_CODE</fieldname><datatype>字符</datatype><displaylabel>处理编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_TRANSACT</fieldname><datatype>字符</datatype><displaylabel>处理方式</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_NUMBER</fieldname><datatype>字符</datatype><displaylabel>份数</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR></TBODY></TABLE>
<TABLE style="DISPLAY: none; WIDTH: 324px; POSITION: static; HEIGHT: 75px" cellSpacing=2 cellPadding=1 width=324 align=left border=1>
<TBODY>
<TR>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR>
<TR>
<TD><INPUT id=EC_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=9 controltype="text" field="EC_ID" dataset="baseInfoDataset" china="审批基本信息ID"></TD>
<TD><INPUT id=PARENT_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=9 controltype="text" field="PARENT_ID" dataset="baseInfoDataset" china="PARENT_ID"></TD>
<TD></TD>
<TD><INPUT class=nolinetext id=ORGID style="DISPLAY: none; WIDTH: 22px; HEIGHT: 20px" disabled onmovestart=moveStart() readOnly size=2 controltype="text" field="ORGID" dataset="baseInfoDataset" china="ORGID"></TD>
<TD><INPUT id=EXTRA_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 56px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=10 controltype="text" field="EXTRA_ID" dataset="extraInfoDataset" china="EXTRA_ID"></TD>
<TD><INPUT class=nolinetext id=SERVICE_TYPEID style="DISPLAY: none; WIDTH: 17.07%; HEIGHT: 20px" onmovestart=moveStart() size=4 controltype="text" field="SERVICE_TYPEID" dataset="baseInfoDataset" china="服务类型"></TD>
<TD></TD>
<TD><INPUT id=SHENPI_URL style="DISPLAY: none; LEFT: 51px; WIDTH: 37px; POSITION: static; TOP: 443px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD>
<TD><INPUT id=flowId style="DISPLAY: none; LEFT: 51px; WIDTH: 37px; POSITION: static; TOP: 443px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text" field="FLOW_ID" dataset="flowInfoDataset" china="FLOW_ID"></TD>
<TD><INPUT id=SHENPI_JC style="DISPLAY: none; LEFT: 51px; WIDTH: 37px; POSITION: static; TOP: 443px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV></body></html>
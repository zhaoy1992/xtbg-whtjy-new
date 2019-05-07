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

top.document.title = "补交告知";


//==============================================全局对象变量定义=========================================
var PageParms = {
    ccFormId :IsSpace(creator_getQueryString("cc_form_instanceid"))? "":creator_getQueryString("cc_form_instanceid"),
    ecId :IsSpace(creator_getQueryString("ec_id"))? "":creator_getQueryString("ec_id"),//得到项目基本信息ID
    itemInsName :IsSpace(creator_getQueryString("item_insname"))? "":creator_getQueryString("item_insname"),//项目名称
    applyType :IsSpace(creator_getQueryString("apply_type"))? "":creator_getQueryString("apply_type"),//申请者类别
    applyName :IsSpace(creator_getQueryString("apply_name"))? "":creator_getQueryString("apply_name"),//申请者名称
    instanceCode :IsSpace(creator_getQueryString("instance_code"))? "":creator_getQueryString("instance_code"),//受理号
    tmpAttachList : new Array(),
    instanceOpener : window.dialogArguments || window.opener
}


/**
 * 初始化：显示项目名称及申请者信息
 * 根据实际情况，决定是显示申请单位名称还是申请人姓名
 */
function init(){
    var attachList = PageParms.instanceOpener.getNotSubmittedList();
    if(attachList.length == 0){
        alert("申请材料已全部提交齐全，不能做补交告知处理");
        window.close();
    }
    initDisplayFields();
    initCreateAttachTable(attachList); //生成补交告知材料清单的表格
}


//将带过来的参数值赋给界面元素
function initDisplayFields(){
    $('txtItemInsName').value = PageParms.itemInsName;
    $('applyNameTD').innerHTML = (PageParms.applyType=="1")?"申请单位名称":"申请人姓名";
    $('txtApplyName').value =  PageParms.applyName;
    $('txtInstanceCode').value = PageParms.instanceCode;
}


//生成补交告知材料清单的表格
function initCreateAttachTable(attachList){
    var oTable = initCreateEmptyTable();
    initCreateAttachHead(oTable);
    var wrapperDIV = document.createElement("div");
    wrapperDIV.style.overflowY = "scroll";
    wrapperDIV.style.wdith = "88%";
    wrapperDIV.style.height = "200px";   
    wrapperDIV.appendChild(oTable);
    var iLen = attachList.length;
    for(var i=0; i<iLen; i++){
        initCreateAttachRow(oTable,attachList[i]);
    }
    initCreateAttachBtnRow(oTable);
    document.getElementById("attachTD").appendChild(wrapperDIV);
}


//生成一个空TABLE
function initCreateEmptyTable(){
    var emptyTable = document.createElement("table");
    emptyTable.width = "96%";
    emptyTable.className = "table_function_other";
    var oTBody = document.createElement("tbody");
    emptyTable.appendChild(oTBody);
    return emptyTable;
}


//生成一个头部
function initCreateAttachHead(oTable){
    var oTR = document.createElement("tr");
    var oTD1 = document.createElement("td");
    var oTD2 = document.createElement("td");
    var oTD3 = document.createElement("td");
    oTD1.innerHTML = "全选";
    oTD1.width="20%";
    oTD1.onclick=function(){checkAll();}
    oTD2.innerHTML = "材料名称";
    oTD3.innerHTML = "份数";
    oTR.appendChild(oTD1);
    oTR.appendChild(oTD2);
    oTR.appendChild(oTD3);
    oTable.childNodes[0].appendChild(oTR);
}


//生成一个ROW
function initCreateAttachRow(oTable, attachInstance){
    var oTR = document.createElement("tr");
    var oTD1 = document.createElement("td");
    var oTD2 = document.createElement("td");
    var oTD3 = document.createElement("td");
    //生成第一个单元格：复选框
    var oCheckBox = document.createElement("input");
    oCheckBox = createInputElement("checkbox","xzsp_box");
    oCheckBox.value = attachInstance.attach_id;
    oTD1.appendChild(oCheckBox);
    //生成第二个单元格：材料名称
    oTD2.innerHTML = attachInstance.attach_name;
    //生成第三个单元格：份数
    oTD3.innerHTML = attachInstance.attach_number;
    oTR.appendChild(oTD1);
    oTR.appendChild(oTD2);
    oTR.appendChild(oTD3);
    oTable.childNodes[0].appendChild(oTR);
}


//生成一个ROW
function initCreateAttachBtnRow(oTable){
    var oTR = document.createElement("tr");
    var oTD = document.createElement("td");
    oTD.colSpan = 3;
    oTD.style.textAlign= "right"; 
    var oDelBtn = document.createElement("input");
    oDelBtn.type = "button";
    oDelBtn.name = "btnDel";
    oDelBtn.className = "sub_btn";
    oDelBtn.value = "删除";  
    oDelBtn.attachEvent("onclick", delAttach);  
    oTD.appendChild(oDelBtn);       
    oTR.appendChild(oTD);   
    oTable.childNodes[0].appendChild(oTR);          
}

//删除附件
function delAttach(){
    var oTable = document.getElementById("attachTD").childNodes[0].childNodes[0];
    var boxes = document.getElementsByName("xzsp_box");
    var iItem = boxes.length;
    for(var i=0; i<iItem; i++){
        if(boxes[i].checked){  //选中
            var attachItem = new Array();
            var oRow = oTable.rows[i+1];//去掉表头一行
            attachItem[0] = oRow.cells[1].innerHTML;
            attachItem[1] = oRow.cells[2].innerHTML;  
            PageParms.tmpAttachList.push(attachItem);          
            oTable.deleteRow(i+1); 
            i = i-1;
            iItem = iItem - 1;
        }
    }
}


//覆盖workflow.js中的函数
function getReprotParam(){
    var reportParam = new Array();
    reportParam.push("&ec_id=");
    reportParam.push(PageParms.instanceOpener.PageParms.ecId);
    reportParam.push("&attach_id=");
    var attachIdList = getSupplyAttachIdList();
    if(attachIdList.length == 0){
        alert("申请材料已全部提交齐全，不能做补交告知处理");
        window.close();
    }
    var chrAttachIdList = new Array();
    for(var i=0; i<attachIdList.length; i++){
        chrAttachIdList[i] = "'"+attachIdList[i]+"'";
    }
    reportParam.push("("+chrAttachIdList.join(",")+")");
    reportParam.push("&instance_code=");
    reportParam.push(creator_getQueryString("instance_code"));
    reportParam.push("&apply_time=");
    reportParam.push(creator_getQueryString("apply_time"));
    //reportParam.push("&apply_name=");
    //reportParam.push(creator_getQueryString("apply_name"));
    //reportParam.push("&accept_time=");
    //reportParam.push(getdate()); //取当前日期(客户端时间)
    reportParam.push("&item_insname=");
    reportParam.push(creator_getQueryString("item_insname"));
    reportParam.push("&item_name=");
    reportParam.push(creator_getQueryString("item_name"));
    reportParam.push("&time_limit=");
    reportParam.push(getChnFormat($('INFORM_TIME').value));
    reportParam.push("&apply_year=");
    reportParam.push(creator_getQueryString("apply_year"));
    reportParam.push("&apply_month=");
    reportParam.push(creator_getQueryString("apply_month"));
    reportParam.push("&apply_day=");
    reportParam.push(creator_getQueryString("apply_day"));
    return reportParam.join("");
}

/**
 * 打印补交告知通知书
 */
function printSupplyInform(){
    if(!checkBeforSubmit()){
        return;
    }
    var flowId = creator_getQueryString("flow_id");
    var actDefId = creator_getQueryString("actdef_id");
    var reportId = xzsp.api.BaseService2InstanceAPI.getReportId(flowId,actDefId,"03");
    if(IsSpace(reportId)){
        reportId = getDefaultReportId("03");
    }
    //printReportByRaqId(reportId);
    $('btnSupply').disabled = false;
}


//判断是否输入了项目信息
function checkBeforSubmit(){
    if(IsSpace($('INFORM_REASON').value)){
        alert("请输入补交告知原因");
        $('INFORM_REASON').focus();
        return false;
    }
    if(IsSpace($('INFORM_TIME').value)){
        alert("请输入补交告知期限");
        $('INFORM_TIME').focus();
        return false;
    }
    if($('INFORM_TIME').value <= getdate()){
        alert("补交告知期限必须大于受理时间("+getdate()+")");
        $('INFORM_TIME').focus();
        return false;
    }
    return true;
}


/**
 * 补交告知
 * 从受理表单获取各种项目信息、材料信息等数据
 * 从本表单获取不予受理信息
 * 调用业务逻辑，调用流程暂存操作，将项目状态update为“补交告知”
 */
function doSupplyInform(){
    if(!checkBeforSubmit()){
        return;
    }
    if(IsSpace(creator_getSession("cc_form_instanceid")) || (creator_getSession("cc_form_instanceid")=="clear")){
        PageParms.ccFormId = getNewCc_form_instanceid("true"); //生成一个新的业务ID
        creator_setSession("cc_form_instanceid",PageParms.ccFormId);
    }
    var flowData = PageParms.instanceOpener.getFlowData();  //获取流程相关数据
    var inputDatas = PageParms.instanceOpener.getInputData(); //获取用户输入的相关数据
    var supplyInformVO = new xzsp.vo.SupplyInform();
    supplyInformVO.inform_reason = $('INFORM_REASON').value;
    supplyInformVO.inform_time = getLongFormat($('INFORM_TIME').value); 
    supplyInformVO.cc_form_instanceid = creator_getSession("cc_form_instanceid");
    var supplyAttachList = getSupplyAttachIdList();
    if(confirm("您确定要补交告知吗？")){
        createOverlayDIV();
        InstanceManager.doSupplyInform(flowData,inputDatas[0],inputDatas[1],inputDatas[2],inputDatas[3],
                                 supplyInformVO,supplyAttachList,defaultCallbackForOpenWin);
    }
}


//取得补交告知材料ID清单（取材料基本信息），
//在入库时：先插入项目实例信息、材料实例信息、补交告知信息等，
//再根据item_insid和attach_id去查attach_insid，然后根据attach_insid入库补交告知材料表
function getSupplyAttachIdList(){
    var boxes = document.getElementsByName("xzsp_box");
    var supplyAttachIdList = new Array();
    for(var i=0; i<boxes.length; i++){
        supplyAttachIdList[i] = boxes[i].value;     
    }
    return supplyAttachIdList;
}

/**
 * 勾选所有
 */
function checkAll()
{
    var srcObj=window.event.srcElement;
    var tableObj=srcObj.parentNode.parentNode;
    var trObjArray=tableObj.getElementsByTagName("tr");
    for(var i=1;i<trObjArray.length-1;i++)
    {
        var inputObj=trObjArray[i].firstChild.firstChild;
        if(srcObj.innerHTML=="全选"){
            inputObj.checked=true;
        }else{
            inputObj.checked=false;
        }
    }
    if(srcObj.innerHTML=="全选"){
        srcObj.innerHTML="取消全选";
    }else{
        srcObj.innerHTML="全选"
    }
    
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js&#13;&#10;../../../ccapp/app_5/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/workflow.js&#13;&#10;../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js" creatorType="20090825142958890821" type="ZW" contxml="<root><textarea><id>INFORM_REASON</id></textarea><button><id>btnPrtSupply</id><id>btnSupply</id><id>btnClose</id></button><text><id>txtItemInsName</id><id>txtApplyName</id><id>txtInstanceCode</id><id>INFORM_TIME</id></text><dataset><id>supplyInformDataset</id></dataset></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0" creator_pagination version="1.0" idtype="1" creator_csslib="style_right.css" OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();init();" keyfield codeheader="BBB" creatorStyle="creatorBlue" mkbh caption="补交告知办件" dj_sn="20090827152725593083" testDbName="xzsp" billtaborder="<root><taborder>INFORM_REASON</taborder><taborder>btnPrtSupply</taborder><taborder>btnSupply</taborder><taborder>btnClose</taborder><taborder>txtItemInsName</taborder><taborder>txtApplyName</taborder><taborder>txtInstanceCode</taborder><taborder>INFORM_TIME</taborder></root>" toolbar="不带工具栏"><TABLE width="100%" align=center>
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
<TD><INPUT id=txtApplyName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD></TR>
<TR>
<TD class=color>受理流水号</TD>
<TD><INPUT id=txtInstanceCode style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD></TR>
<TR>
<TD class=color><FONT color=red>*</FONT>补交告知原因</TD>
<TD><TEXTAREA id=INFORM_REASON style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=106 controltype="textarea" value="textarea1" induce="否" china="补交告知原因" dataset="supplyInformDataset" field="INFORM_REASON"></TEXTAREA></TD></TR>
<TR>
<TD class=color><FONT color=red>*</FONT>补交告知期限</TD>
<TD><INPUT id=INFORM_TIME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="补交告知期限" dataset="supplyInformDataset" field="INFORM_TIME" onclick='bill_onclick("SelectDate()")'></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD id=attachTD></TD></TR>
<TR>
<TD vAlign=top align=middle><BUTTON class=btn id=btnPrtSupply onmovestart=moveStart() controltype="button" onclick='bill_onclick("printSupplyInform()")' dropstyle="否">打印补交告知通知书</BUTTON><BUTTON class=btn id=btnSupply disabled onmovestart=moveStart() controltype="button" onclick='bill_onclick("doSupplyInform()")' dropstyle="否">补交告知</BUTTON><BUTTON class=btn id=btnClose onmovestart=moveStart() controltype="button" onclick='bill_onclick("window.close();")' dropstyle="否">关闭</BUTTON></TD></TR></TBODY></TABLE><?xml:namespace prefix = fc /><fc:dataset id=supplyInformDataset opensortno="1" temptable="TMP_DATASET1" multiResult="否" onValid='bill_ondatasetvalid("<dsid><INFORM_REASON></INFORM_REASON><INFORM_TIME></INFORM_TIME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><INFORM_REASON></INFORM_REASON><INFORM_TIME></INFORM_TIME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><INFORM_REASON></INFORM_REASON><INFORM_TIME></INFORM_TIME></dsid>")' format="<fields><field><fieldname>INFORM_REASON</fieldname><datatype>字符</datatype><displaylabel>补交告知原因</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>INFORM_TIME</fieldname><datatype>日期</datatype><displaylabel>补交告知期限</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset></DIV></body></html>
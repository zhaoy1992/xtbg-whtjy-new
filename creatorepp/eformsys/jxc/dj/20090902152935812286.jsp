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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
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
<%
	String userId = accesscontroler.getUserID();
	String orgName = accesscontroler.getChargeOrgName();
	String cc_form_instanceid = request.getParameter("cc_form_instanceid");
	java.util.Date date = new java.util.Date();	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String currentDateTime = sdf.format(date);
	//request.setAttribute('djbh',cc_form_instanceid);
%>
//客户端全局变量
var userName = getSysElement("userName"); //当前用户的用户名
var userId = "<%=userId%>";
var cc_form_instanceid = "<%=cc_form_instanceid%>"; //业务流程ID
var orgName = "<%=orgName%>"; //当前用户所在部门的名称
var currentUser = userId; //当前的参与者
var businessType = "发文管理"; //业务类别
var currentDateTime = "<%=currentDateTime%>";
var actionInfo = workflow_operation('getActObject');
if (actionInfo == "false")
	actionInfo = "fwgls_wp1_act1||拟稿||<%=currentDateTime%>";
var actionInfos = actionInfo.split("||");
var actionName = actionInfos[1]; //当前活动名称
var actionId = actionInfos[0];
var actionStartFlag = "fwgls_wp1_act1";
var attachId = ""; //附件上传使用的临时ID
var editType = "1,0";
var showType = "1";
var taohong = "0";
var mark = "false";
var str_Hint = "0";
var mark_GWCS = "false";
var ztcIsError = false;
var wjh = new Array();
var hiddenFlag ; 
var contextInfo = new Array(new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_qfyj","","","","签发人","签发时间","签发意见",true,""),new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_hqyj","","","","会签人","会签时间","会签意见",true,""),new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_hgyj","","<%=currentDateTime%>",userName,"核稿人","核稿时间","核稿意见",true,""));
var currentIndex = 0;
//查询业务数据
var sel_sql = "select LCSLID,YWLB,WJZ,WJN,WJH,NGDW,LXR,LXDH,to_char(NGRQ,'yyyy-mm-dd') NGRQ,MJ,HJ,FS,ZTC,ZS,CS,FWBT,FWZW,FJ,HGYJ,JDR,DZR,HQYJ,QFYJ,WJZT,to_char(FWRQ,'yyyy-mm-dd') FWRQ,CC_FORM_INSTANCEID,LCCYR,ssdw,qcglid from APP_4.TA_FWGL where cc_form_instanceid='<%=cc_form_instanceid%>'"; 
//主键
var primaryKey = "lcslid";

//未填数据,则清空
function handle()
{
		var lwwh_ = parseInt(text_wjh.value);
		if(lwwh_ == 0)
		{
			text_wjh.value = "";
		}
		var fs_ =parseInt(text_fs.value);
		if(fs_ == 0)
		{
			text_fs.value = "";
		}
		var lxdh_ =parseInt(text_lxdh.value);
		if(lxdh_ == 0)
		{
			text_lxdh.value = "";
		}
}

//电话号码查询
function QueryNum()
{	
	var num_query_sql = "select user_mobiletel1 from dzzwpt.td_sm_user where user_id ='" + userId + "'";
	var num_query_result = executeSelect(num_query_sql,1,1);
	return num_query_result;
}
//加载业务数据
function initBusinessData() {
	var os = new Array(ToInt(GetDate().substring(0,4)) - 1 + "", GetDate().substring(0,4), ToInt(GetDate().substring(0,4)) + 1 + "");
	addOptions(text_wjn, os, os);
	os = null;
	var sql = "select wjzid, wjzmc, wjh from APP_4.TA_WJZWH where ssdw = '0'";
	wjh = executeSelect(sql,1,SqlToField("select count(*) from APP_4.TA_WJZWH where ssdw = '0'"));
	os = new Array();
	if (wjh.length != 0) {
		for (var i = 0; i < wjh.length; i++) {
			os[i] = wjh[i][1];
		}
	}
	addOptions(text_wjz, os, os);
	//是否从数据库中加载数据
	if (loadDateFromDB(cc_form_instanceid))  //从数据库中加载数据
	{	
		//加载业务数据
		dataset1.Open(sel_sql);
		handle();
		//设置pubdjbh值
		pubdjbh = dataset1.Fields.Field[primaryKey].Value;
		currentIndex = 0;	
		checkAudited();
		getAllAuditIdeaFromDB();
		currentIndex = 1;
		checkAudited();
		getAllAuditIdeaFromDB();
		currentIndex = 2;
		checkAudited();         
		getAllAuditIdeaFromDB();
		var v_lccyr = dataset1.Fields.Field["lccyr"].Value;
		var v_arry = v_lccyr.split(",");
		if(v_arry[0].substring(1,v_arry[0].length -1) != userId)
		{
			button_zzlc.style.display = "none";
		}
	}
	else
	{
		text_lxdh.value = QueryNum();
		$("text_ywlb").value = businessType;  //业务类别
		$("text_ngrq").value = GetDate();  //获取服务器时间
		$("combobox_mj").options[0].selected = true; //密级程度
		$("combobox_hj").options[0].selected = true; //缓急程度	
		text_ngdw.value = "<%=orgName%>";
		textarea_zs.value = "各区、县（市）人民政府，市直机关各单位：";
		textarea_cs.value = "市委各部门，长沙警备区。\r\n市人大常委会办公厅，市政协办公厅，市人民检察院，市中级人民法院。\r\n各民主党派市委。";
		text_lxr.value = userName;
		text_wjn.value = GetDate().substring(0,4);
		text_ssdw.value = 0;
		pubdjbh = getTempAttachId();
		attachId = pubdjbh;
		if (wjh.length != 0) {
			text_wjh.value = wjh[0][2];
		}
	}
	//修改文件状态信息
	$('text_wjzt').value = actionName;	
	if(actionId == "fwgls_wp1_act3")  //校对
	{
		$("text_jdr").value = userName + "  " + GetDate();
	}
	if(actionId == "fwgls_wp1_act6")  //签阅
	{
		$("text_fwrq").value = GetDate();
	}
	if(actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5")
	{
		str_Hint = "1";
		if(IsSpace(text_fwrq.value))
		{
			text_fwrq.value = GetDate();
		}
		//installScanner();
	}
	if (actionId == "fwgls_wp1_act5" && isScanned()) {
		button_look.disabled = false;
	}
	if (actionId == "fwgls_wp1_act10"/* || actionId == "fwgls_wp1_act8"|| actionId == "fwgls_wp1_act15"|| actionId == "fwgls_wp1_act11"*/) {
		lookAttach("530",pubdjbh,"fj");}
	changeWordStatus();
	if (showType == "1" && editType == "0,0") {
		button16.innerText = "查看正文";
	}
	//changeWorkflowControlStatus();
	DisplayButton(actionId,actionStartFlag,workflowControl_terminate);
}
//如果是流程未启动则对表单上设置的权限不起作用，所以需要做权限控制
function setPurview() {	
	//button_qfyj.style.display="none";
	//textarea_qfyj.disabled=true;
	button_hqyj.style.display = "none";
	//textarea_hqyj.disabled = true;
	button_hgyj.style.display = "none";
	//textarea_hgyj.disabled = true;
	text_fwrq.disabled = true;
	text_fs.disabled = true;
	text_jdr.disabled = true;
	button_sendGWCS.style.display="none";
	divPrintFWGZ.style.display="none";
	divSendGWCS.style.display="none";
	divScanFWGZ.style.display="none";
	divLookFWGZ.style.display="none";
}
//取签呈单
function openQCD(){
	var tmp = creator_getSession("cc_form_instanceid");
	//获取签呈单id
	jlid = showModalDialog(getOpenUrlByDjid("20090427170135343147"),window,"dialogWidth:850px;dialogHeight:680px;status:no;resizable:yes;;unadorne:yes");
	if(!IsSpace(jlid)){
		text_qcglid.value = jlid;
	}
	creator_setSession("cc_form_instanceid",tmp);
}
function getDetailPage() {
	if (IsSpace(text_qcglid.value)) {
		alert("没有与之关联的签呈单！");
		return;
	}
	var tmp = creator_getSession("cc_form_instanceid");
	var sqlx = "select cc_form_instanceid from app_4.TA_QCGL where lcslid='" + text_qcglid.value + "' ";
	var other = executeSelect(sqlx,1,1);
	var url = getOpenUrlByDjid('306') + "&cc_form_instanceid=" + other + "&lcslid=" + text_qcglid.value;
	showModalDialog(url,window,"center:yes;status:no;resizable:yes;;unadorne:yes");
	creator_setSession("cc_form_instanceid",tmp);
}
function validate() {
	if (!notEmpty(text45.value,true,"文件标题不能为空！")) {
		return false;
	}
	if (!notEmpty(text_ngdw.value,true,"拟稿单位不能为空！")) {
		return false;
	}
	if (!notEmpty(text_ngrq.value,true,"拟稿日期不能为空！")) {
		return false;
	}
	if(ztcIsError) {
		alert('主题词存在错误！');
		return false;
	}
	var wordHint = "您还没有编辑正文！";
	if (showType == "1" && editType == "0,0") {
		wordHint = "您还没有查看正文！";
	}
	if (actionId == "fwgls_wp1_act1") {  //拟稿
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act3") {  //校对	
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act13") {  //处室核对
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act4") {  //审核
		if (!contextInfo[2][2]) {
			alert("请填写核稿意见！");
			return false;
		}
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act6") {  //签阅
		if (!contextInfo[0][2]) {
			alert("请填写签发意见！");
			return false;
		}
		if(mark == "false")
		{
			alert("您还没有对正文进行手写批注!");
			return false;
		}
	} else if (actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") {  //编号
		var result = parseInt(text_fs.value);
		if (isNaN(result) || result == "" || result < 1) {
			alert("请填写份数，份数必须为大于等于1的整数！");
			return false;
		} else {
			text_fs.value = result;
		}
		result = parseInt(text_wjh.value);
		if (isNaN(result) || result == "" || result < 1) {
			alert("请填写文件号，文件号必须为大于等于1的整数！");
			return false;
		} else {
			text_wjh.value = result;
		}		
	} else if (actionId == "fwgls_wp1_act15") {  //转送
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act2" || actionId == "fwgls_wp1_act11") {  //部门会签 领导审签
		if (!contextInfo[1][2]) {
			alert("请填写会签意见！");
			return false;
		}
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	}
	return true;
}
//编号环节回写文件号
function updateWJH() {
	if (actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") {
		if (wjh.length != 0) {
			var sql = "update APP_4.TA_WJZWH set wjh = " + (ToInt(text_wjh.value) + 1) + " where wjzid = '" + wjh[text_wjz.selectedIndex][0] + "'";
			if (!IsSpace(creator_update(sql))) {
				alert("更新文件号失败！");
			}
		}
	}	
}
//保存业务数据
function saveBusinessDate(dataset,type) {
	//设置主数据集 主要用表单上存在多个数据集的情况
	fcpubvar.DsMain = "" + dataset;
	//流程开始要清空临时使用的pubdjbh
	var b = isTempAttachId(pubdjbh);
	if (b) {
		pubdjbh = "";	
	}
	//修改参与人
	var lccyr = $("text_lccyr").value;
	var rowlccyr = lccyr;
	if (type == 1) {		
		if (lccyr.length == 0)
			lccyr = "@" + currentUser + "@";
		else
			lccyr = lccyr + ",@" + currentUser + "@";
		
	} else if (type == 2) {
		if (lccyr.length == 0)
			lccyr = "$" + currentUser + "$";
		else
			lccyr = lccyr + ",$" + currentUser + "$";
	} else if (type == 3) {  //送公文传输
	}
	$("text_lccyr").value = lccyr;
	//保存数据
	var result = DjSave();
	if (result == "") {
		if (b)
			updateAttachId(pubdjbh,attachId);
		return true;
	} else {
		alert("保存数据失败！");
		if (pubdjbh == "")
			pubdjbh = attachId;
		$("text_lccyr").value = rowlccyr;
		return false;
	}
}
//表单加载时调用的函数
function init() {
	if(creator_iframeIsCompleted()=="false"){      
      setTimeout("init()",100);
      return;
    }
    /*
	document.getElementById("fjframe").src="20090828105536609657.jsp?cc_form_instanceid="+cc_form_instanceid+"&djbh=11";
	alert(document.getElementById("fjframe").src);*/
	hiddenFlag = creator_hasElementSwitch();
	//初始化业务数据
	//initBusinessData();
	//流程开始需要手动控制权限
	
	$("text_wjzt").value=actionName;
	$("text_fwrq").value=actionInfos[2];
	if (actionId == actionStartFlag)
	{
		//设置权限
		//setPurview();
	} else {
		button_xzqcd.style.display="none";
		if(IsSpace(text_qcglid.value))
		{
			button_ckqcd.style.display="none";
		}
	}
	if(hiddenFlag){
		creator_elementAuthority();  //办结列表权限控制回调函数
	} else {
		var result = creator_getElementAuthority(actionId,"530");
		var ids = result.readonlyId.split(",");
		var styles = result.readonlyStyle.split(",");
		for (var i = 0, count = ids.length; i < count; i++) {
			if (ids[i] != "") {
				var style = (styles[i] == "") ? "nolinetext_xtbg" : styles[i];
				elementReadOnlyPro($(ids[i]),style);
			}
		}
	}
}
function changeWordStatus() {
	showType = "1";
	editType = "1,0";
	if (actionId == "fwgls_wp1_act1") {  //拟稿
		showType = "1";
		editType = "1,0";
	} else if (actionId == "fwgls_wp1_act13") {  //部门确认
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act3") {  //校对
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act4") {  //审核
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act2") {  //部门会签
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act6") {  //签阅
		showType = "2";
		editType = "3,1";
	} else if (actionId == "fwgls_wp1_act8") {  //编号
		showType = "0";
		editType = "1,0";
		taohong = "1";
	} else if (actionId == "fwgls_wp1_act15") {  //转送
		showType = "0";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act10") {  //分发
		showType = "1";
		editType = "0,0";
	} else if (actionId == "fwgls_wp1_act11") {  //会签
		showType = "2";
		editType = "3,1";
	} else if (actionId == "fwgls_wp1_act5") {  //转送编号
		showType = "0";
		editType = "1,0";
		taohong = "1";
	}
}
//打开正文编辑
function openEdit() {
	//如果为套红则需要先保存数据
	if ((actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") && !hiddenFlag) {
		if (!confirm("在编辑word之前请您确认所有信息都完整填写，您是否确定继续？")) {
			return;
		}
		if (!saveDateForTaoHong()) {
			return;
		}
	}
	var cc = cc_form_instanceid;
	if (cc_form_instanceid == "clear")
		cc = creator_getSession("cc_form_instanceid");
	showModalDialog(getOpenUrlByDjid('20090827085359250127') + "&cc_form_instanceid=" + cc +"&taohong=" + taohong+"&str_Hint="+str_Hint,window,"status:yes;resizable:yes;;unadorne:yes;center:yes");
}
function preProcess(raw) {
	raw = raw.replace(/(^\s*)|(\s*$)/g, "");
	raw = raw.split(" ");
	raw.uniq();
	var result = "";
	for(var i = 0; i < raw.length; i++) {
		result = result + raw[i] + " ";
	}
	result = result.substring(0,result.length - 1);
	return result;
}
var ztcname = "";
function openKey() {	
	window.showModalDialog("/"+fcpubdata.mAppName+"/ccapp/app_4/jsp/ZTCTree.jsp",window);
	if (ztcname == "" || ztcname == undefined)
		return;
	var raw = text_ztc.value;
	if (raw == "") {
		text_ztc.value = ztcname;
		return;
	} else {		
		raw = raw + " " + ztcname;
	}
	text_ztc.value = preProcess(raw);
	checkZTC();
}
function changeWJZ() {
	if (wjh.length != 0) {
		text_wjh.value = wjh[text_wjz.selectedIndex][2];
	}
}
function validateZTC(ztc) {
	return true; //暂时屏蔽主题词检验
	if (ztc == "")
		return true;
	var ztcs = ztc.split(" ");
	var result = "";
	for (var i = 0; i < ztcs.length; i++) {
		var tmp = ztcs[i];
		if (tmp.indexOf("△") == (tmp.length - 1) || tmp.indexOf("▲") == (tmp.length - 1))
			tmp = tmp.substring(0,tmp.length - 1);
		result = result + "'" + tmp + "',";
	}
	result = result.substring(0,result.length - 1);
	var sel_sql = "select count(*) from APP_4.TA_ZTCWH where ssdw = '0' and ztcmc in (" + result + ")";
	var count = executeSelect(sel_sql,1,1)[0][0];
	if (count != ztcs.length)
		return false;
	else 
		return true;
}
function checkZTC(){
	text_ztc.value = preProcess(text_ztc.value);
	ztcIsError = !validateZTC(text_ztc.value);
	if(ztcIsError)
		alert('主题词存在错误！');
}
var send_result = "2";
function sendGWCS() {
	if (!validate() ||!validateLength()|| !saveBusinessDate(dataset1,3))
	{
		return false;
	}
	send_result = "2";
	if (!confirm("您确定将此公文送公文传输吗？")) {
		return;
	}
	window.showModalDialog("/"+fcpubdata.mAppName+"/ccapp/app_4/jsp/SendGWCS.jsp?id=" + pubdjbh + "&djsn=530",window,"dialogHeight:600px;dialogWidth:800px;center:yes");
	if (send_result == "0") {
		alert("送公文传输失败！");
	} else if (send_result == "1") {
		mark_GWCS = "true";
		alert("发送成功！");
	}
}

function checkGWCS()
{
	if(actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5")
	{
			if(mark_GWCS == "false")
			{
				return false;
			}else{
				return true;
			}
	}else {
		return true;
	}	
}

function saveDateForTaoHong() {
	//数据验证
	if (!validate()||!validateLength()) {
		return false;
	}
	if(!saveFromDate('完成活动',dataset1)){
		return false;
	}
	return true;
}

function myNextAction(dataset,flag,_location) {
	if (flag == "启动流程" || flag == "完成活动" || flag == "回退" || flag == "暂存")
	{
		//数据验证
		if (!validate()||!validateLength())
		{
			return false;
		}
		if(!checkGWCS())
		{
			if(!confirm("您还没有送公文传输,是否继续?"))
			{
				return false;
			}

		}
		
}	

	//选择执行人
	if (!hasSelectUser(flag)) {
		alert("请您选择执行人！");
		return false;
	}
	var result = true;
	//工作流接口 完成活动
	if (flag == "启动流程") {
			if(IsSpace(text_qcglid.value)) {
				if(!confirm("您没有选择签呈单,是否继续?")) {
					return false;
				}
			}
			if (confirm("您是否确定启动流程？")) {
				if(!saveFromDate(flag,dataset)){
		  	     return false;
		             }
		             text_fs.value = "";
				result = creator_djsave('启动流程',false,false);
				if (result != "false") {
					alert("您已经成功的启动流程！");
				} else {
					alert("您启动流程失败！");
					return false;
				}
			} else{
			    return false;
			}
	} else if (flag == "完成活动") {
			if (confirm("您是否确定完成活动？")) {
		             if(!saveFromDate(flag,dataset)){
		  	     return false;
		             }
					 updateWJH();
				result = creator_djsave('完成活动',false,false);
				if (result != "false") {
					alert("您已经成功的完成活动！");
				} else {
					alert("您完成活动失败！");
					return false;
				}
			} else{
			    return false;
			}
	} else if (flag == "回退") {
		if (confirm("您是否确定回退？")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('回退',false,false);
			if (result != "false") {
				alert("您已经成功的进行回退操作！");
			} else {
				alert("您进行的回退操作失败！");
				return false;
			}
		} else{
			    return false;
		}
	} else if (flag == "收回") {
		if (confirm("您是否确定收回？")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('收回',false,false);
			if (result != "false") {
				alert("您已经成功的进行收回操作！");
			} else {
				alert("您进行的收回操作失败！");
				return false;
			}
		} else{
			    return false;
		}
	} else if (flag == "终止流程") {
		if (confirm("您是否确定终止流程？")) {
		          /* if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }*/
			result = creator_djsave('终止流程',false,false);
			if (result != "false") {
				var del_s = "delete from app_4.TA_FWGLCLYJ where lcslid = '" + pubdjbh + "'";
				var del_sel = "delete from app_4.TA_FWGL where lcslid = '" + pubdjbh + "'";
				if (IsSpace(InsertSql(del_s)) && IsSpace(InsertSql(del_sel))&&delWordByCcFormInstanceid(cc_form_instanceid,"app_4")&&delAttachByBh(pubdjbh,530,"app_4")) {
					alert("您已经成功的终止流程！");
				} else {
					alert("您终止流程失败！");
					return false;
				}
			} else {
				alert("您终止流程失败！");
				return false;
			}
		} else {
			return false;
		}
	} else if (flag == "暂存") {
		if (confirm("您是否确定暂存？")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('暂存',false,false);
			if (result != "false") {
				alert("您暂存数据成功！");
			} else {
				alert("您暂存数据失败！");
				return false;
			}
		} else{
			    return false;
		}
	}
	//页面需要跳转
	/*portlet*/
	window.open(getLocation(),"base_properties_content");
	/*portlet*/
//	}
}
function selectActors() {
	adduser();
}
function selectAndActors() {
	addAndUser();
}
/*
function changeWorkflowControlStatus() {
	workflowControl_selectAct_div.style.display = workflowControl_selectAct.style.display;
}
function changeSelectActor() {
	DYNAMICPERFORMER.value = "";
	DYNAMICPERFORMER_NAME.value = "";
}
*/
function creator_elementAuthority(){
	//text_wjzt.readOnly=true;
	elementReadOnly(text_wjzt,'nolinetext_xtbg');
	//text_fwrq.readOnly=true;
	//text_fwrq.disabled=true;
	elementReadOnly(text_fwrq,'nolinetext_xtbg');
	elementReadOnly(text_wjz,'nolinetext_xtbg');
	elementReadOnly(text_wjn,'nolinetext_xtbg');
	elementReadOnly(text_wjh,'nolinetext_xtbg');
	text_wjz.disabled=true;
	//text_wjn.disabled=true;
	//text_wjh.readOnly=true;
	//combobox_hj.disabled=true;
	elementReadOnly(combobox_hj,'nolinetext_xtbg');
	//combobox_mj.disabled=true;
	elementReadOnly(combobox_mj,'nolinetext_xtbg');
	elementReadOnly(combobox_hj,'nolinetext_xtbg');
	elementReadOnly(combobox_mj,'nolinetext_xtbg');
	//text_fs.readOnly="none";
	elementReadOnly(text_fs,'nolinetext_xtbg');
	button_qfyj.style.display="none";
	button_xzqcd.style.display="none";
	textarea_qfyj.readOnly=true;
	//textarea_qfyj.disabled=false;
	button_hqyj.style.display="none";
	textarea_hqyj.readOnly=true;
	//textarea_hqyj.disabled=false;
	//text_ngdw.readOnly=true;
	elementReadOnly(text_ngdw,'nolinetext_xtbg');
	button20.style.display="none";
	button_hgyj.style.display="none";
	textarea_hgyj.readOnly=true;
	//textarea_hgyj.disabled=false;
	//text_lxr.readOnly=true;
	elementReadOnly(text_lxr,'nolinetext_xtbg');
	//text_lxdh.readOnly=true;
	elementReadOnly(text_lxdh,'nolinetext_xtbg');
	//text_ngrq.readOnly=true;
	//text_ngrq.disabled=true;
	elementReadOnly(text_ngrq,'nolinetext_xtbg');
	//text_jdr.readOnly=true;
	elementReadOnly(text_jdr,'nolinetext_xtbg');
	//text45.readOnly=true;
	elementReadOnly(text45,'nolinetext_xtbg');
	//text_ztc.readOnly=true;
	elementReadOnly(text_ztc,'nolinetext_xtbg');
	button_ztc.style.display="none";
	textarea_zs.readOnly=true;
	button14.style.display="none";
	textarea_cs.readOnly=true;
	button15.style.display="none";
	divPrintFWGZ.style.display = "none";
	divScanFWGZ.style.display = "none";
	button16.innerText="查看正文";
	editType="0,0";
	showType="1";
	lookAttach("530",pubdjbh,"fj");
	button_sendGWCS.style.display="none";
}

function saveFromDate(flag,dataset){
	var result = true;
	//业务数据保存
	if (flag == "启动流程" || flag == "完成活动") {
		result = saveBusinessDate(dataset,1);
	} else if (flag == "终止流程") {
		//result = saveBusinessDate(dataset,2);
	} else {
		result = saveBusinessDate(dataset,1);
	}
	return result;
}
function changeWJH() {
	var result = parseInt(text_wjh.value);
	text_wjh.value = (!isNaN(result) ? result : "");
}

function changeFS() {
	var result = parseInt(text_fs.value);
	text_fs.value = (!isNaN(result) ? result : "");
}
function cleanup(text_id)
{
	text_id.value="";
}
function validateLength()
{
	return true;
	if(!checkLength(text_fs.value,6,"份数长度不能大于6!"))
	{
		return false;
	}
	if(checkSpecial(text_ngdw.value)){
		if(!checkLength(text_ngdw.value,100,"拟稿单位长度不能大于100!"))
		{
			return false;
		}
	} else	{
			text_ngdw.value = "";
			text_ngdw.focus();
			return false;
	}	
		
	if(!checkLength(text45.value,200,"文件标题长度不能大于200!"))
	{
		return false;
	}
	if(!checkLength(textarea_zs.value,1024,"主送长度不能大于1024!"))
	{
		return false;
	}
	if(!checkLength(textarea_cs.value,1024,"抄送长度不能大于1024!"))
	{
		return false;
	}
	//验证电话号码
	if(!validatePhoneCode(text_lxdh.value)){
		alert("联系电话不正确！");
		return false;
	}
	if(!checkLength(text_ztc.value,50,"主题词长度不能大于50!"))
	{
		return false;
	}else {
			return true;
	}
}
var paraFWGZ = {type : "common", id : pubdjbh, flag : "print", template : "1246955415468", fillDataFun : "fillFWGZ"};
function printFWGZ() {
	openWord(paraFWGZ);
}
function fillFWGZ(wordApplication) {
	var word = new SimpleWord(wordApplication);
	var array = new Array(text_wjz,text_wjn,text_wjh,combobox_hj,combobox_mj,text_fs,textarea_qfyj,textarea_hqyj,text_ngdw,text_lxr,textarea_hgyj,text_lxdh,text_ngrq,text_jdr,text45,text_ztc,textarea_zs,textarea_cs);
	var arraySet = new Array();
	for(var i=0;i<array.length;i++) {
		arraySet[i] = array[i].value;	
	}
	var wjMsg = arraySet[0] + "〔" + arraySet[1] + "〕" + arraySet[2] + "号";
	var values = [1,wjMsg,3,arraySet[3],5,arraySet[4],7,arraySet[5],
		10,arraySet[6],11,arraySet[7],13,arraySet[8],
		16,arraySet[9],17,arraySet[10],19,arraySet[11],
		21,arraySet[12],23,arraySet[13], 25,arraySet[14],
		27,arraySet[15],29,arraySet[16],31,arraySet[17]];
	word.setCellValueByIndex("data", values);
	word = null;
}
function getIETempPath() {
	var WshShell = new ActiveXObject("WScript.Shell");
	return WshShell.RegRead("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Cache\\Paths\\Directory"); 
}
var scanResult = {};
function scanFWGZ() {
	var scanner = null;
	try {
		scanner = new ActiveXObject("MYSCANNER.MyScannerCtrl.1");
		if (!!scanner) {
			var tmpPath = "";
			var result = scanner.ShowScan(tmpPath); //返回值 <0 出现错误; 0=点击了完成; 1=取消. >1 其他错误信息
			if (result == 1) {
				scanResult.count = scanner.GetImageCount(); //返回数量
				scanResult.baseFilePath = scanner.GetSavePath(); //返回路径, 路径最后位置不带'\'; 返回空, 创建目录不成功;
				if (scanResult.count) {
					var paraFWGZScanned = {type : "common", id : pubdjbh + "s", flag : "edit", showType : "1", editType : "1,0", template : "1247455804062", loadType : "force", fillDataFun : "fillScanFWGZ", remoteFun : "remoteFunctionName"};
					openWord(paraFWGZScanned);
					if (isScanned()) {
						button_look.disabled = false;
					}
				}
			} else if (result < 0) {
				alert("出现错误！");
			}
			scanResult = {};
			scanner.DeleteImage(); //返回1成功, 其他失败
			scanner = null;
			return;
		}
	} catch (e) {		
		alert("请安装科创Web扫描控件！然后重试。");
		scanner = null;
		return;
	}
}
function fillScanFWGZ(wordApplication) {
	if (!!scanResult.count && !!scanResult.baseFilePath) {
		var word = new SimpleWord(wordApplication);
		for (var i = 0; i < scanResult.count; i++) {
			var filePath = scanResult.baseFilePath + "\\" + (scanResult.count - i) + ".jpg";
			word.insertPicture("fwgz", filePath);
		}		
		word = null;
	}
}
function lookFWGZ() {
	var paraFWGZScanned = {type : "common", id : pubdjbh + "s", flag : "show"};
	openWord(paraFWGZScanned);
}
function isScanned() {
	return !!parseInt(executeSelect("select count(*) from app_4.TD_OCTL_DOCUMENT_FILE t where t.recordid = 'w" + pubdjbh + "s" + "w'", 1, 1)[0][0]);
}
function installScanner() {
	try {
		var test = new ActiveXObject("MYSCANNER.MyScannerCtrl.1");
		delete test;
	} catch (e) {
		var version = "8,8,8,8";
		var body = document.getElementsByTagName("BODY")[0];
		var div = document.createElement("DIV");
		div.innerHTML = '<OBJECT id=MyScanner style="LEFT: 0px; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px" codeBase=../../../ccapp/app_4/other/MyScanner.cab#version=' + version + ' classid=clsid:3082F03D-B139-43E6-92BC-F8DBF9642E09 name=WebOffice><PARAM NAME="_Version" VALUE="65536"><PARAM NAME="_ExtentX" VALUE="0"><PARAM NAME="_ExtentY" VALUE="0"><PARAM NAME="_StockProps" VALUE="0"></OBJECT>';
		body.appendChild(div);
	}
}
/*
修改记录:
2009-7-2
1.领导审签和签发改成纸质
2.转送、领导审签、签发以及编号合并成同一环节转送
3.原活动id记录：
	转送		fwgls_wp1_act15		User：songmin
	领导审签	fwgls_wp1_act11		Role：22,21
	签发		fwgls_wp1_act6		Role：22,21
	编号		fwgls_wp1_act8		User：songmin
4.合并后的转送：
	转送		fwgls_wp1_act5		User：songmin
*/
function editFJ()
{
	document.getElementById("fjframe").src="20090828105536609657.jsp?cc_form_instanceid="+cc_form_instanceid+"&djbh=11";
	
}
function openExtTree(type){
alert(cc);
	showModalDialog(getOpenUrlByDjid('20090827142924296034') ,window,"status:yes;resizable:yes;;unadorne:yes;center:yes");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><textarea><id>textarea_qfyj</id><id>textarea_hqyj</id><id>textarea_hgyj</id><id>textarea_zs</id><id>textarea_cs</id></textarea><combobox><id>text_wjn</id><id>combobox_hj</id><id>combobox_mj</id><id>workflowControl_selectAct</id></combobox><div><id>div5</id><id>div6</id><id>div7</id><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_terminate</id><id>workflowControl_tempSaveForm</id></div><button><id>button20</id><id>button14</id><id>button15</id><id>button16</id><id>button1</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_wchd</id><id>button_ht</id><id>button_hs</id><id>button_zzlc</id><id>button_zc</id></button><text><id>text_wjzt</id><id>text_ywlb</id><id>text_lccyr</id><id>text_ssdw</id><id>text_qcglid</id><id>text_fwrq</id><id>text_wjh</id><id>text_fs</id><id>text_ngdw</id><id>text1</id><id>text_ngr</id><id>text_hgr</id><id>text48</id><id>text49</id><id>text_ztc</id><id>text45</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>textarea_qfyj</taborder><taborder>textarea_hqyj</taborder><taborder>textarea_hgyj</taborder><taborder>textarea_zs</taborder><taborder>textarea_cs</taborder><taborder>text_wjn</taborder><taborder>combobox_hj</taborder><taborder>combobox_mj</taborder><taborder>workflowControl_selectAct</taborder><taborder>button20</taborder><taborder>button14</taborder><taborder>button15</taborder><taborder>button16</taborder><taborder>button1</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zzlc</taborder><taborder>button_zc</taborder><taborder>text_wjzt</taborder><taborder>text_ywlb</taborder><taborder>text_lccyr</taborder><taborder>text_ssdw</taborder><taborder>text_qcglid</taborder><taborder>text_fwrq</taborder><taborder>text_wjh</taborder><taborder>text_fs</taborder><taborder>text_ngdw</taborder><taborder>text1</taborder><taborder>text_ngr</taborder><taborder>text_hgr</taborder><taborder>text48</taborder><taborder>text49</taborder><taborder>text_ztc</taborder><taborder>text45</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder></root>" dj_sn="20090902152935812286" caption="发文页面" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="lcslid" isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090826084448609544" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<OBJECT id=MyScanner style="LEFT: 0px; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px" codeBase=../../../ccapp/app_4/other/MyScanner.cab#version=1,0,0,1 classid=clsid:3082F03D-B139-43E6-92BC-F8DBF9642E09 name=WebOffice>
   <PARAM NAME="_Version" VALUE="65536">
   <PARAM NAME="_ExtentX" VALUE="0">
   <PARAM NAME="_ExtentY" VALUE="0">
   <PARAM NAME="_StockProps" VALUE="0">
</OBJECT>

<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD><DIV style="VERTICAL-ALIGN: top; WIDTH: 100%; HEIGHT: 100%" align=center><DIV class=title style="COLOR: red" align=center>长沙市人民政府发文稿纸</DIV>
               <TABLE class=hidetable cellSpacing=0 cellPadding=0 width="95%" border=0>
                  <TBODY>
                     <TR>
                        <TD width="70%"><DIV align=left>文件状态<INPUT id=text_wjzt style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="WJZT" china="文件状态" dataset="dataset1"><INPUT id=text_ywlb style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="YWLB" china="业务类别" dataset="dataset1"><INPUT id=text_lccyr style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="LCCYR" china="流程参与人" dataset="dataset1"><INPUT id=text_ssdw style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="ssdw" china="所属单位" dataset="dataset1"><INPUT id=text_qcglid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="qcglid" china="签呈管理id" dataset="dataset1">&nbsp;&nbsp;</DIV></TD>
                        <TD width="30%"><DIV align=right>发文日期<INPUT id=text_fwrq style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></DIV></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <TABLE class=formtable_red style="WIDTH: 968px; HEIGHT: 725px" cellSpacing=0 cellPadding=0 width=968 border=1>
                  <TBODY>
                     <TR>
                        <TD style="COLOR: red" colSpan=2>长信中心&nbsp;(<SELECT id=text_wjn style="LEFT: 0px; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="WJN" china="文件年" dataset="dataset1" tempvalue="2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" temptext="2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" sql check="1"><OPTION value=2007 selected>2007</OPTION><OPTION value=2008>2008</OPTION><OPTION value=2009>2009</OPTION><OPTION value=2010>2010</OPTION></SELECT>)<INPUT id=text_wjh style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 76px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("changeWJH()")' size=8 controltype="text" field="WJH" china="文件号" dataset="dataset1">号</TD>
                        <TD style="COLOR: red" width="7%">缓急</TD>
                        <TD width="10%"><SELECT id=combobox_hj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="HJ" china="缓急" dataset="dataset1" tempvalue="非急件&#13;&#10;急件&#13;&#10;特急" temptext="非急件&#13;&#10;急件&#13;&#10;特急" sql check="1"><OPTION value=非急件 selected>非急件</OPTION><OPTION value=急件>急件</OPTION><OPTION value=特急>特急</OPTION></SELECT></TD>
                        <TD style="COLOR: red" width="7%">密级</TD>
                        <TD width="10%"><SELECT id=combobox_mj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="MJ" china="密级" dataset="dataset1" tempvalue="一般&#13;&#10;秘密&#13;&#10;机密&#13;&#10;绝密" temptext="一般&#13;&#10;秘密&#13;&#10;机密&#13;&#10;绝密" sql check="1"><OPTION value=一般 selected>一般</OPTION><OPTION value=秘密>秘密</OPTION><OPTION value=机密>机密</OPTION><OPTION value=绝密>绝密</OPTION></SELECT></TD>
                        <TD style="COLOR: red" width="6%">份数</TD>
                        <TD width="10%"><INPUT class=nolinetext id=text_fs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("changeFS()")' controltype="text" field="FS" china="份数" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" colSpan=2>签发&nbsp;<DIV id=div5 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><TEXTAREA class=nolinetext id=textarea_qfyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 150px" onmovestart=moveStart() controltype="textarea" field="QFYJ" china="签发意见" dataset="dataset1" value="textarea1" induce="否" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                        <TD style="COLOR: red" colSpan=6>主要领导人批示&nbsp;<DIV id=div6 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><TEXTAREA class=nolinetext id=textarea_hqyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 150px" onmovestart=moveStart() controltype="textarea" field="HQYJ" china="会签意见" dataset="dataset1" value="textarea1" induce="否" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" width="15%">拟稿单位</TD>
                        <TD width="35%"><INPUT class=nolinetext id=text_ngdw style="LEFT: 0px; WIDTH: 58.04%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=13 controltype="text" field="NGDW" china="拟稿单位" dataset="dataset1" onblur='bill_onexit("validateLength();")'><BUTTON class=button1 id=button20 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openExtTree(1)")'>选择</BUTTON></TD>
                        <TD style="COLOR: red" colSpan=6 rowSpan=4>办公室审核意见&nbsp;<DIV id=div7 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><TEXTAREA class=nolinetext id=textarea_hgyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() controltype="textarea" field="HGYJ" china="核稿意见" dataset="dataset1" value="textarea1" induce="否" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" width="15%">拟稿日期</TD>
                        <TD width="35%"><INPUT class=nolinetext id=text1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="NGRQ" china="拟稿日期" dataset="dataset1" onclick='bill_onclick("SelectDate()")'></TD>
                        <TR>
                           <TD style="COLOR: red" width="15%">拟稿人</TD>
                           <TD width="35%"><INPUT class=nolinetext id=text_ngr style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="ngr" china="拟稿人" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">核稿人</TD>
                           <TD width="35%"><INPUT class=nolinetext id=text_hgr style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="hgr" china="核稿人" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">主送</TD>
                           <TD colSpan=6><TEXTAREA class=nolinetext id=textarea_zs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="ZS" china="主送" dataset="dataset1" value="textarea1" induce="否" onblur='bill_onexit("validateLength();")'></TEXTAREA></TD>
                           <TD width="10%"><BUTTON class=button1 id=button14 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;cleanup(text48);openTree('org',text48,text48);textarea_zs.value = textarea_zs.value + text48.value;&quot;)">选择</BUTTON><INPUT id=text48 style="DISPLAY: none; LEFT: 0px; WIDTH: 20px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=200 controltype="text"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">抄送</TD>
                           <TD colSpan=6><TEXTAREA class=nolinetext id=textarea_cs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="CS" china="抄送" dataset="dataset1" value="textarea1" induce="否" onblur='bill_onexit("validateLength();")'></TEXTAREA></TD>
                           <TD width="10%"><BUTTON class=button1 id=button15 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;cleanup(text49);openTree('org',text49,text49);textarea_cs.value = textarea_cs.value + text49.value;&quot;)">选择</BUTTON><INPUT id=text49 style="DISPLAY: none; LEFT: 0px; WIDTH: 20px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=200 controltype="text"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">主题词</TD>
                           <TD colSpan=6><INPUT class=nolinetext id=text_ztc style="LEFT: 0px; WIDTH: 128.33%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=25 controltype="text" field="ZTC" china="主题词" dataset="dataset1" onblur='bill_onexit("validateLength();checkZTC();")'></TD>
                           <TD width="10%"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">标题</TD>
                           <TD colSpan=7><INPUT class=nolinetext id=text45 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FWBT" china="发文标题" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" colSpan=8>正文&nbsp;<BUTTON class=button1 id=button16 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openEdit()")'>编辑正文</BUTTON></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" colSpan=8>附件<BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("editFJ()")'>编辑附件</BUTTON></TD>
                        </TR>
                        <TR>
                           <TD colSpan=8><IFRAME id=fjframe width="100%" height=120 srcolling="no"></IFRAME></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
                  <TABLE width="95%" border=0>
                     <TBODY>
                        <TR>
                           <TD><DIV align=right><DIV id=workflowControl1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%" onmovestart=moveStart() controltype="workflowControl" NotBg="是"><DIV id=divPrintFWGZ style="FLOAT: left">&nbsp;</DIV><DIV id=divScanFWGZ style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 215px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">请选择活动：<SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor();")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></DIV>&nbsp;</DIV><DIV id=divLookFWGZ style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：<INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_xzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("selectActors();")'>选执行人</BUTTON></DIV>&nbsp;</DIV><DIV id=divSendGWCS style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：<INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("selectAndActors();")'>与分支选执行人</BUTTON></DIV>&nbsp;</DIV><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_qdlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'启动流程','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">启动流程</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_wchd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'完成活动','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">完成活动</BUTTON></DIV><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_ht style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'回退','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">回退</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_hs style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'收回','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">收回</BUTTON></DIV><DIV id=workflowControl_terminate style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_zzlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'终止流程','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">终止流程</BUTTON></DIV><DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'暂存','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">暂存</BUTTON></DIV><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV></DIV></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </DIV>
            </TD>
         </TR>
      </TBODY>
   </TABLE>
   <?xml:namespace prefix = fc />
   <fc:dataset id=dataset1 format="<fields><field><fieldname>CS</fieldname><datatype>字符</datatype><displaylabel>抄送</displaylabel><size>1024</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DZR</fieldname><datatype>字符</datatype><displaylabel>打字人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FJ</fieldname><datatype>字符</datatype><displaylabel>附件</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FS</fieldname><datatype>整数</datatype><displaylabel>份数</displaylabel><size>6</size><precision></precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWBT</fieldname><datatype>字符</datatype><displaylabel>发文标</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWRQ</fieldname><datatype>日期</datatype><displaylabel>发文日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yy-mm-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWZW</fieldname><datatype>图象</datatype><displaylabel>发文正文</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HGYJ</fieldname><datatype>字符</datatype><displaylabel>核稿意</displaylabel><size>2048</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HJ</fieldname><datatype>字符</datatype><displaylabel>缓急</displaylabel><size>6</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HQYJ</fieldname><datatype>字符</datatype><displaylabel>会签意</displaylabel><size>2048</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JDR</fieldname><datatype>字符</datatype><displaylabel>校对人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCCYR</fieldname><datatype>字符</datatype><displaylabel>流程参与人</displaylabel><size>2048</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCSLID</fieldname><datatype>字符</datatype><displaylabel>流程实例编号</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LXDH</fieldname><datatype>字符</datatype><displaylabel>联系电话</displaylabel><size>12</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LXR</fieldname><datatype>字符</datatype><displaylabel>联系人</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MJ</fieldname><datatype>字符</datatype><displaylabel>密级</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NGDW</fieldname><datatype>字符</datatype><displaylabel>拟稿单位</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NGRQ</fieldname><datatype>日期</datatype><displaylabel>拟稿日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yy-mm-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>QFYJ</fieldname><datatype>字符</datatype><displaylabel>签发意</displaylabel><size>2048</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJH</fieldname><datatype>整数</datatype><displaylabel>文件号</displaylabel><size></size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJN</fieldname><datatype>字符</datatype><displaylabel>文件年</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJZ</fieldname><datatype>字符</datatype><displaylabel>文件字</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJZT</fieldname><datatype>字符</datatype><displaylabel>文件状态</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>YWLB</fieldname><datatype>字符</datatype><displaylabel>业务类别</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZS</fieldname><datatype>字符</datatype><displaylabel>主送</displaylabel><size>1024</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZTC</fieldname><datatype>字符</datatype><displaylabel>主题词</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ssdw</fieldname><datatype>字符</datatype><displaylabel>所属单位</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>qcglid</fieldname><datatype>字符</datatype><displaylabel>签呈管理id</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ngr</fieldname><datatype>字符</datatype><displaylabel>拟稿人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>hgr</fieldname><datatype>字符</datatype><displaylabel>核稿人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' onValid='bill_ondatasetvalid("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' opensortno="1" temptable="TMP_DATASET2" saveastable="APP_4.TA_FWGL" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
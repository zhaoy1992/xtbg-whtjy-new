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
		
		//����Ӧ��ȷ����ʽ��Ŀ¼
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">���ڼ��ء���</DIV></TD>
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

<!-- ��ʾ������Ϊҳ���JS&CSS���� -->
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


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
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
//�ͻ���ȫ�ֱ���
var userName = getSysElement("userName"); //��ǰ�û����û���
var userId = "<%=userId%>";
var cc_form_instanceid = "<%=cc_form_instanceid%>"; //ҵ������ID
var orgName = "<%=orgName%>"; //��ǰ�û����ڲ��ŵ�����
var currentUser = userId; //��ǰ�Ĳ�����
var businessType = "���Ĺ���"; //ҵ�����
var currentDateTime = "<%=currentDateTime%>";
var actionInfo = workflow_operation('getActObject');
if (actionInfo == "false")
	actionInfo = "fwgls_wp1_act1||���||<%=currentDateTime%>";
var actionInfos = actionInfo.split("||");
var actionName = actionInfos[1]; //��ǰ�����
var actionId = actionInfos[0];
var actionStartFlag = "fwgls_wp1_act1";
var attachId = ""; //�����ϴ�ʹ�õ���ʱID
var editType = "1,0";
var showType = "1";
var taohong = "0";
var mark = "false";
var str_Hint = "0";
var mark_GWCS = "false";
var ztcIsError = false;
var wjh = new Array();
var hiddenFlag ; 
var contextInfo = new Array(new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_qfyj","","","","ǩ����","ǩ��ʱ��","ǩ�����",true,""),new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_hqyj","","","","��ǩ��","��ǩʱ��","��ǩ���",true,""),new Array("APP_4.TA_FWGLCLYJ","APP_4.audit_idea_id",false,"textarea_hgyj","","<%=currentDateTime%>",userName,"�˸���","�˸�ʱ��","�˸����",true,""));
var currentIndex = 0;
//��ѯҵ������
var sel_sql = "select LCSLID,YWLB,WJZ,WJN,WJH,NGDW,LXR,LXDH,to_char(NGRQ,'yyyy-mm-dd') NGRQ,MJ,HJ,FS,ZTC,ZS,CS,FWBT,FWZW,FJ,HGYJ,JDR,DZR,HQYJ,QFYJ,WJZT,to_char(FWRQ,'yyyy-mm-dd') FWRQ,CC_FORM_INSTANCEID,LCCYR,ssdw,qcglid from APP_4.TA_FWGL where cc_form_instanceid='<%=cc_form_instanceid%>'"; 
//����
var primaryKey = "lcslid";

//δ������,�����
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

//�绰�����ѯ
function QueryNum()
{	
	var num_query_sql = "select user_mobiletel1 from dzzwpt.td_sm_user where user_id ='" + userId + "'";
	var num_query_result = executeSelect(num_query_sql,1,1);
	return num_query_result;
}
//����ҵ������
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
	//�Ƿ�����ݿ��м�������
	if (loadDateFromDB(cc_form_instanceid))  //�����ݿ��м�������
	{	
		//����ҵ������
		dataset1.Open(sel_sql);
		handle();
		//����pubdjbhֵ
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
		$("text_ywlb").value = businessType;  //ҵ�����
		$("text_ngrq").value = GetDate();  //��ȡ������ʱ��
		$("combobox_mj").options[0].selected = true; //�ܼ��̶�
		$("combobox_hj").options[0].selected = true; //�����̶�	
		text_ngdw.value = "<%=orgName%>";
		textarea_zs.value = "�������أ��У�������������ֱ���ظ���λ��";
		textarea_cs.value = "��ί�����ţ���ɳ��������\r\n���˴�ί��칫��������Э�칫������������Ժ�����м�����Ժ��\r\n������������ί��";
		text_lxr.value = userName;
		text_wjn.value = GetDate().substring(0,4);
		text_ssdw.value = 0;
		pubdjbh = getTempAttachId();
		attachId = pubdjbh;
		if (wjh.length != 0) {
			text_wjh.value = wjh[0][2];
		}
	}
	//�޸��ļ�״̬��Ϣ
	$('text_wjzt').value = actionName;	
	if(actionId == "fwgls_wp1_act3")  //У��
	{
		$("text_jdr").value = userName + "  " + GetDate();
	}
	if(actionId == "fwgls_wp1_act6")  //ǩ��
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
		button16.innerText = "�鿴����";
	}
	//changeWorkflowControlStatus();
	DisplayButton(actionId,actionStartFlag,workflowControl_terminate);
}
//���������δ������Ա������õ�Ȩ�޲������ã�������Ҫ��Ȩ�޿���
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
//ȡǩ�ʵ�
function openQCD(){
	var tmp = creator_getSession("cc_form_instanceid");
	//��ȡǩ�ʵ�id
	jlid = showModalDialog(getOpenUrlByDjid("20090427170135343147"),window,"dialogWidth:850px;dialogHeight:680px;status:no;resizable:yes;;unadorne:yes");
	if(!IsSpace(jlid)){
		text_qcglid.value = jlid;
	}
	creator_setSession("cc_form_instanceid",tmp);
}
function getDetailPage() {
	if (IsSpace(text_qcglid.value)) {
		alert("û����֮������ǩ�ʵ���");
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
	if (!notEmpty(text45.value,true,"�ļ����ⲻ��Ϊ�գ�")) {
		return false;
	}
	if (!notEmpty(text_ngdw.value,true,"��嵥λ����Ϊ�գ�")) {
		return false;
	}
	if (!notEmpty(text_ngrq.value,true,"������ڲ���Ϊ�գ�")) {
		return false;
	}
	if(ztcIsError) {
		alert('����ʴ��ڴ���');
		return false;
	}
	var wordHint = "����û�б༭���ģ�";
	if (showType == "1" && editType == "0,0") {
		wordHint = "����û�в鿴���ģ�";
	}
	if (actionId == "fwgls_wp1_act1") {  //���
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act3") {  //У��	
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act13") {  //���Һ˶�
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act4") {  //���
		if (!contextInfo[2][2]) {
			alert("����д�˸������");
			return false;
		}
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act6") {  //ǩ��
		if (!contextInfo[0][2]) {
			alert("����дǩ�������");
			return false;
		}
		if(mark == "false")
		{
			alert("����û�ж����Ľ�����д��ע!");
			return false;
		}
	} else if (actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") {  //���
		var result = parseInt(text_fs.value);
		if (isNaN(result) || result == "" || result < 1) {
			alert("����д��������������Ϊ���ڵ���1��������");
			return false;
		} else {
			text_fs.value = result;
		}
		result = parseInt(text_wjh.value);
		if (isNaN(result) || result == "" || result < 1) {
			alert("����д�ļ��ţ��ļ��ű���Ϊ���ڵ���1��������");
			return false;
		} else {
			text_wjh.value = result;
		}		
	} else if (actionId == "fwgls_wp1_act15") {  //ת��
		if(mark == "false")
		{
			alert(wordHint);
			return false;
		}
	} else if (actionId == "fwgls_wp1_act2" || actionId == "fwgls_wp1_act11") {  //���Ż�ǩ �쵼��ǩ
		if (!contextInfo[1][2]) {
			alert("����д��ǩ�����");
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
//��Ż��ڻ�д�ļ���
function updateWJH() {
	if (actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") {
		if (wjh.length != 0) {
			var sql = "update APP_4.TA_WJZWH set wjh = " + (ToInt(text_wjh.value) + 1) + " where wjzid = '" + wjh[text_wjz.selectedIndex][0] + "'";
			if (!IsSpace(creator_update(sql))) {
				alert("�����ļ���ʧ�ܣ�");
			}
		}
	}	
}
//����ҵ������
function saveBusinessDate(dataset,type) {
	//���������ݼ� ��Ҫ�ñ��ϴ��ڶ�����ݼ������
	fcpubvar.DsMain = "" + dataset;
	//���̿�ʼҪ�����ʱʹ�õ�pubdjbh
	var b = isTempAttachId(pubdjbh);
	if (b) {
		pubdjbh = "";	
	}
	//�޸Ĳ�����
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
	} else if (type == 3) {  //�͹��Ĵ���
	}
	$("text_lccyr").value = lccyr;
	//��������
	var result = DjSave();
	if (result == "") {
		if (b)
			updateAttachId(pubdjbh,attachId);
		return true;
	} else {
		alert("��������ʧ�ܣ�");
		if (pubdjbh == "")
			pubdjbh = attachId;
		$("text_lccyr").value = rowlccyr;
		return false;
	}
}
//������ʱ���õĺ���
function init() {
	if(creator_iframeIsCompleted()=="false"){      
      setTimeout("init()",100);
      return;
    }
    /*
	document.getElementById("fjframe").src="20090828105536609657.jsp?cc_form_instanceid="+cc_form_instanceid+"&djbh=11";
	alert(document.getElementById("fjframe").src);*/
	hiddenFlag = creator_hasElementSwitch();
	//��ʼ��ҵ������
	//initBusinessData();
	//���̿�ʼ��Ҫ�ֶ�����Ȩ��
	
	$("text_wjzt").value=actionName;
	$("text_fwrq").value=actionInfos[2];
	if (actionId == actionStartFlag)
	{
		//����Ȩ��
		//setPurview();
	} else {
		button_xzqcd.style.display="none";
		if(IsSpace(text_qcglid.value))
		{
			button_ckqcd.style.display="none";
		}
	}
	if(hiddenFlag){
		creator_elementAuthority();  //����б�Ȩ�޿��ƻص�����
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
	if (actionId == "fwgls_wp1_act1") {  //���
		showType = "1";
		editType = "1,0";
	} else if (actionId == "fwgls_wp1_act13") {  //����ȷ��
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act3") {  //У��
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act4") {  //���
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act2") {  //���Ż�ǩ
		showType = "1";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act6") {  //ǩ��
		showType = "2";
		editType = "3,1";
	} else if (actionId == "fwgls_wp1_act8") {  //���
		showType = "0";
		editType = "1,0";
		taohong = "1";
	} else if (actionId == "fwgls_wp1_act15") {  //ת��
		showType = "0";
		editType = "2,0";
	} else if (actionId == "fwgls_wp1_act10") {  //�ַ�
		showType = "1";
		editType = "0,0";
	} else if (actionId == "fwgls_wp1_act11") {  //��ǩ
		showType = "2";
		editType = "3,1";
	} else if (actionId == "fwgls_wp1_act5") {  //ת�ͱ��
		showType = "0";
		editType = "1,0";
		taohong = "1";
	}
}
//�����ı༭
function openEdit() {
	//���Ϊ�׺�����Ҫ�ȱ�������
	if ((actionId == "fwgls_wp1_act8" || actionId == "fwgls_wp1_act5") && !hiddenFlag) {
		if (!confirm("�ڱ༭word֮ǰ����ȷ��������Ϣ��������д�����Ƿ�ȷ��������")) {
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
	return true; //��ʱ��������ʼ���
	if (ztc == "")
		return true;
	var ztcs = ztc.split(" ");
	var result = "";
	for (var i = 0; i < ztcs.length; i++) {
		var tmp = ztcs[i];
		if (tmp.indexOf("��") == (tmp.length - 1) || tmp.indexOf("��") == (tmp.length - 1))
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
		alert('����ʴ��ڴ���');
}
var send_result = "2";
function sendGWCS() {
	if (!validate() ||!validateLength()|| !saveBusinessDate(dataset1,3))
	{
		return false;
	}
	send_result = "2";
	if (!confirm("��ȷ�����˹����͹��Ĵ�����")) {
		return;
	}
	window.showModalDialog("/"+fcpubdata.mAppName+"/ccapp/app_4/jsp/SendGWCS.jsp?id=" + pubdjbh + "&djsn=530",window,"dialogHeight:600px;dialogWidth:800px;center:yes");
	if (send_result == "0") {
		alert("�͹��Ĵ���ʧ�ܣ�");
	} else if (send_result == "1") {
		mark_GWCS = "true";
		alert("���ͳɹ���");
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
	//������֤
	if (!validate()||!validateLength()) {
		return false;
	}
	if(!saveFromDate('��ɻ',dataset1)){
		return false;
	}
	return true;
}

function myNextAction(dataset,flag,_location) {
	if (flag == "��������" || flag == "��ɻ" || flag == "����" || flag == "�ݴ�")
	{
		//������֤
		if (!validate()||!validateLength())
		{
			return false;
		}
		if(!checkGWCS())
		{
			if(!confirm("����û���͹��Ĵ���,�Ƿ����?"))
			{
				return false;
			}

		}
		
}	

	//ѡ��ִ����
	if (!hasSelectUser(flag)) {
		alert("����ѡ��ִ���ˣ�");
		return false;
	}
	var result = true;
	//�������ӿ� ��ɻ
	if (flag == "��������") {
			if(IsSpace(text_qcglid.value)) {
				if(!confirm("��û��ѡ��ǩ�ʵ�,�Ƿ����?")) {
					return false;
				}
			}
			if (confirm("���Ƿ�ȷ���������̣�")) {
				if(!saveFromDate(flag,dataset)){
		  	     return false;
		             }
		             text_fs.value = "";
				result = creator_djsave('��������',false,false);
				if (result != "false") {
					alert("���Ѿ��ɹ����������̣�");
				} else {
					alert("����������ʧ�ܣ�");
					return false;
				}
			} else{
			    return false;
			}
	} else if (flag == "��ɻ") {
			if (confirm("���Ƿ�ȷ����ɻ��")) {
		             if(!saveFromDate(flag,dataset)){
		  	     return false;
		             }
					 updateWJH();
				result = creator_djsave('��ɻ',false,false);
				if (result != "false") {
					alert("���Ѿ��ɹ�����ɻ��");
				} else {
					alert("����ɻʧ�ܣ�");
					return false;
				}
			} else{
			    return false;
			}
	} else if (flag == "����") {
		if (confirm("���Ƿ�ȷ�����ˣ�")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('����',false,false);
			if (result != "false") {
				alert("���Ѿ��ɹ��Ľ��л��˲�����");
			} else {
				alert("�����еĻ��˲���ʧ�ܣ�");
				return false;
			}
		} else{
			    return false;
		}
	} else if (flag == "�ջ�") {
		if (confirm("���Ƿ�ȷ���ջأ�")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('�ջ�',false,false);
			if (result != "false") {
				alert("���Ѿ��ɹ��Ľ����ջز�����");
			} else {
				alert("�����е��ջز���ʧ�ܣ�");
				return false;
			}
		} else{
			    return false;
		}
	} else if (flag == "��ֹ����") {
		if (confirm("���Ƿ�ȷ����ֹ���̣�")) {
		          /* if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }*/
			result = creator_djsave('��ֹ����',false,false);
			if (result != "false") {
				var del_s = "delete from app_4.TA_FWGLCLYJ where lcslid = '" + pubdjbh + "'";
				var del_sel = "delete from app_4.TA_FWGL where lcslid = '" + pubdjbh + "'";
				if (IsSpace(InsertSql(del_s)) && IsSpace(InsertSql(del_sel))&&delWordByCcFormInstanceid(cc_form_instanceid,"app_4")&&delAttachByBh(pubdjbh,530,"app_4")) {
					alert("���Ѿ��ɹ�����ֹ���̣�");
				} else {
					alert("����ֹ����ʧ�ܣ�");
					return false;
				}
			} else {
				alert("����ֹ����ʧ�ܣ�");
				return false;
			}
		} else {
			return false;
		}
	} else if (flag == "�ݴ�") {
		if (confirm("���Ƿ�ȷ���ݴ棿")) {
		           if(!saveFromDate(flag,dataset)){
		  	     return false;
		           }
			result = creator_djsave('�ݴ�',false,false);
			if (result != "false") {
				alert("���ݴ����ݳɹ���");
			} else {
				alert("���ݴ�����ʧ�ܣ�");
				return false;
			}
		} else{
			    return false;
		}
	}
	//ҳ����Ҫ��ת
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
	button16.innerText="�鿴����";
	editType="0,0";
	showType="1";
	lookAttach("530",pubdjbh,"fj");
	button_sendGWCS.style.display="none";
}

function saveFromDate(flag,dataset){
	var result = true;
	//ҵ�����ݱ���
	if (flag == "��������" || flag == "��ɻ") {
		result = saveBusinessDate(dataset,1);
	} else if (flag == "��ֹ����") {
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
	if(!checkLength(text_fs.value,6,"�������Ȳ��ܴ���6!"))
	{
		return false;
	}
	if(checkSpecial(text_ngdw.value)){
		if(!checkLength(text_ngdw.value,100,"��嵥λ���Ȳ��ܴ���100!"))
		{
			return false;
		}
	} else	{
			text_ngdw.value = "";
			text_ngdw.focus();
			return false;
	}	
		
	if(!checkLength(text45.value,200,"�ļ����ⳤ�Ȳ��ܴ���200!"))
	{
		return false;
	}
	if(!checkLength(textarea_zs.value,1024,"���ͳ��Ȳ��ܴ���1024!"))
	{
		return false;
	}
	if(!checkLength(textarea_cs.value,1024,"���ͳ��Ȳ��ܴ���1024!"))
	{
		return false;
	}
	//��֤�绰����
	if(!validatePhoneCode(text_lxdh.value)){
		alert("��ϵ�绰����ȷ��");
		return false;
	}
	if(!checkLength(text_ztc.value,50,"����ʳ��Ȳ��ܴ���50!"))
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
	var wjMsg = arraySet[0] + "��" + arraySet[1] + "��" + arraySet[2] + "��";
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
			var result = scanner.ShowScan(tmpPath); //����ֵ <0 ���ִ���; 0=��������; 1=ȡ��. >1 ����������Ϣ
			if (result == 1) {
				scanResult.count = scanner.GetImageCount(); //��������
				scanResult.baseFilePath = scanner.GetSavePath(); //����·��, ·�����λ�ò���'\'; ���ؿ�, ����Ŀ¼���ɹ�;
				if (scanResult.count) {
					var paraFWGZScanned = {type : "common", id : pubdjbh + "s", flag : "edit", showType : "1", editType : "1,0", template : "1247455804062", loadType : "force", fillDataFun : "fillScanFWGZ", remoteFun : "remoteFunctionName"};
					openWord(paraFWGZScanned);
					if (isScanned()) {
						button_look.disabled = false;
					}
				}
			} else if (result < 0) {
				alert("���ִ���");
			}
			scanResult = {};
			scanner.DeleteImage(); //����1�ɹ�, ����ʧ��
			scanner = null;
			return;
		}
	} catch (e) {		
		alert("�밲װ�ƴ�Webɨ��ؼ���Ȼ�����ԡ�");
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
�޸ļ�¼:
2009-7-2
1.�쵼��ǩ��ǩ���ĳ�ֽ��
2.ת�͡��쵼��ǩ��ǩ���Լ���źϲ���ͬһ����ת��
3.ԭ�id��¼��
	ת��		fwgls_wp1_act15		User��songmin
	�쵼��ǩ	fwgls_wp1_act11		Role��22,21
	ǩ��		fwgls_wp1_act6		Role��22,21
	���		fwgls_wp1_act8		User��songmin
4.�ϲ����ת�ͣ�
	ת��		fwgls_wp1_act5		User��songmin
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

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><textarea><id>textarea_qfyj</id><id>textarea_hqyj</id><id>textarea_hgyj</id><id>textarea_zs</id><id>textarea_cs</id></textarea><combobox><id>text_wjn</id><id>combobox_hj</id><id>combobox_mj</id><id>workflowControl_selectAct</id></combobox><div><id>div5</id><id>div6</id><id>div7</id><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_terminate</id><id>workflowControl_tempSaveForm</id></div><button><id>button20</id><id>button14</id><id>button15</id><id>button16</id><id>button1</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_wchd</id><id>button_ht</id><id>button_hs</id><id>button_zzlc</id><id>button_zc</id></button><text><id>text_wjzt</id><id>text_ywlb</id><id>text_lccyr</id><id>text_ssdw</id><id>text_qcglid</id><id>text_fwrq</id><id>text_wjh</id><id>text_fs</id><id>text_ngdw</id><id>text1</id><id>text_ngr</id><id>text_hgr</id><id>text48</id><id>text49</id><id>text_ztc</id><id>text45</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>textarea_qfyj</taborder><taborder>textarea_hqyj</taborder><taborder>textarea_hgyj</taborder><taborder>textarea_zs</taborder><taborder>textarea_cs</taborder><taborder>text_wjn</taborder><taborder>combobox_hj</taborder><taborder>combobox_mj</taborder><taborder>workflowControl_selectAct</taborder><taborder>button20</taborder><taborder>button14</taborder><taborder>button15</taborder><taborder>button16</taborder><taborder>button1</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zzlc</taborder><taborder>button_zc</taborder><taborder>text_wjzt</taborder><taborder>text_ywlb</taborder><taborder>text_lccyr</taborder><taborder>text_ssdw</taborder><taborder>text_qcglid</taborder><taborder>text_fwrq</taborder><taborder>text_wjh</taborder><taborder>text_fs</taborder><taborder>text_ngdw</taborder><taborder>text1</taborder><taborder>text_ngr</taborder><taborder>text_hgr</taborder><taborder>text48</taborder><taborder>text49</taborder><taborder>text_ztc</taborder><taborder>text45</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder></root>" dj_sn="20090902152935812286" caption="����ҳ��" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield="lcslid" isfile="��" OtherSave="��" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090826084448609544" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<OBJECT id=MyScanner style="LEFT: 0px; WIDTH: 0px; POSITION: absolute; TOP: 0px; HEIGHT: 0px" codeBase=../../../ccapp/app_4/other/MyScanner.cab#version=1,0,0,1 classid=clsid:3082F03D-B139-43E6-92BC-F8DBF9642E09 name=WebOffice>
   <PARAM NAME="_Version" VALUE="65536">
   <PARAM NAME="_ExtentX" VALUE="0">
   <PARAM NAME="_ExtentY" VALUE="0">
   <PARAM NAME="_StockProps" VALUE="0">
</OBJECT>

<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD><DIV style="VERTICAL-ALIGN: top; WIDTH: 100%; HEIGHT: 100%" align=center><DIV class=title style="COLOR: red" align=center>��ɳ�������������ĸ�ֽ</DIV>
               <TABLE class=hidetable cellSpacing=0 cellPadding=0 width="95%" border=0>
                  <TBODY>
                     <TR>
                        <TD width="70%"><DIV align=left>�ļ�״̬<INPUT id=text_wjzt style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="WJZT" china="�ļ�״̬" dataset="dataset1"><INPUT id=text_ywlb style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="YWLB" china="ҵ�����" dataset="dataset1"><INPUT id=text_lccyr style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="LCCYR" china="���̲�����" dataset="dataset1"><INPUT id=text_ssdw style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="ssdw" china="������λ" dataset="dataset1"><INPUT id=text_qcglid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="qcglid" china="ǩ�ʹ���id" dataset="dataset1">&nbsp;&nbsp;</DIV></TD>
                        <TD width="30%"><DIV align=right>��������<INPUT id=text_fwrq style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></DIV></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <TABLE class=formtable_red style="WIDTH: 968px; HEIGHT: 725px" cellSpacing=0 cellPadding=0 width=968 border=1>
                  <TBODY>
                     <TR>
                        <TD style="COLOR: red" colSpan=2>��������&nbsp;(<SELECT id=text_wjn style="LEFT: 0px; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="WJN" china="�ļ���" dataset="dataset1" tempvalue="2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" temptext="2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" sql check="1"><OPTION value=2007 selected>2007</OPTION><OPTION value=2008>2008</OPTION><OPTION value=2009>2009</OPTION><OPTION value=2010>2010</OPTION></SELECT>)<INPUT id=text_wjh style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 76px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("changeWJH()")' size=8 controltype="text" field="WJH" china="�ļ���" dataset="dataset1">��</TD>
                        <TD style="COLOR: red" width="7%">����</TD>
                        <TD width="10%"><SELECT id=combobox_hj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="HJ" china="����" dataset="dataset1" tempvalue="�Ǽ���&#13;&#10;����&#13;&#10;�ؼ�" temptext="�Ǽ���&#13;&#10;����&#13;&#10;�ؼ�" sql check="1"><OPTION value=�Ǽ��� selected>�Ǽ���</OPTION><OPTION value=����>����</OPTION><OPTION value=�ؼ�>�ؼ�</OPTION></SELECT></TD>
                        <TD style="COLOR: red" width="7%">�ܼ�</TD>
                        <TD width="10%"><SELECT id=combobox_mj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="MJ" china="�ܼ�" dataset="dataset1" tempvalue="һ��&#13;&#10;����&#13;&#10;����&#13;&#10;����" temptext="һ��&#13;&#10;����&#13;&#10;����&#13;&#10;����" sql check="1"><OPTION value=һ�� selected>һ��</OPTION><OPTION value=����>����</OPTION><OPTION value=����>����</OPTION><OPTION value=����>����</OPTION></SELECT></TD>
                        <TD style="COLOR: red" width="6%">����</TD>
                        <TD width="10%"><INPUT class=nolinetext id=text_fs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("changeFS()")' controltype="text" field="FS" china="����" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" colSpan=2>ǩ��&nbsp;<DIV id=div5 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��"><TEXTAREA class=nolinetext id=textarea_qfyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 150px" onmovestart=moveStart() controltype="textarea" field="QFYJ" china="ǩ�����" dataset="dataset1" value="textarea1" induce="��" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                        <TD style="COLOR: red" colSpan=6>��Ҫ�쵼����ʾ&nbsp;<DIV id=div6 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��"><TEXTAREA class=nolinetext id=textarea_hqyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 150px" onmovestart=moveStart() controltype="textarea" field="HQYJ" china="��ǩ���" dataset="dataset1" value="textarea1" induce="��" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" width="15%">��嵥λ</TD>
                        <TD width="35%"><INPUT class=nolinetext id=text_ngdw style="LEFT: 0px; WIDTH: 58.04%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=13 controltype="text" field="NGDW" china="��嵥λ" dataset="dataset1" onblur='bill_onexit("validateLength();")'><BUTTON class=button1 id=button20 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openExtTree(1)")'>ѡ��</BUTTON></TD>
                        <TD style="COLOR: red" colSpan=6 rowSpan=4>�칫��������&nbsp;<DIV id=div7 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��"><TEXTAREA class=nolinetext id=textarea_hgyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() controltype="textarea" field="HGYJ" china="�˸����" dataset="dataset1" value="textarea1" induce="��" onblur='bill_onexit("validateLength();")'></TEXTAREA></DIV></TD>
                     </TR>
                     <TR>
                        <TD style="COLOR: red" width="15%">�������</TD>
                        <TD width="35%"><INPUT class=nolinetext id=text1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="NGRQ" china="�������" dataset="dataset1" onclick='bill_onclick("SelectDate()")'></TD>
                        <TR>
                           <TD style="COLOR: red" width="15%">�����</TD>
                           <TD width="35%"><INPUT class=nolinetext id=text_ngr style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="ngr" china="�����" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">�˸���</TD>
                           <TD width="35%"><INPUT class=nolinetext id=text_hgr style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="hgr" china="�˸���" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">����</TD>
                           <TD colSpan=6><TEXTAREA class=nolinetext id=textarea_zs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="ZS" china="����" dataset="dataset1" value="textarea1" induce="��" onblur='bill_onexit("validateLength();")'></TEXTAREA></TD>
                           <TD width="10%"><BUTTON class=button1 id=button14 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;cleanup(text48);openTree('org',text48,text48);textarea_zs.value = textarea_zs.value + text48.value;&quot;)">ѡ��</BUTTON><INPUT id=text48 style="DISPLAY: none; LEFT: 0px; WIDTH: 20px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=200 controltype="text"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">����</TD>
                           <TD colSpan=6><TEXTAREA class=nolinetext id=textarea_cs style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="CS" china="����" dataset="dataset1" value="textarea1" induce="��" onblur='bill_onexit("validateLength();")'></TEXTAREA></TD>
                           <TD width="10%"><BUTTON class=button1 id=button15 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;cleanup(text49);openTree('org',text49,text49);textarea_cs.value = textarea_cs.value + text49.value;&quot;)">ѡ��</BUTTON><INPUT id=text49 style="DISPLAY: none; LEFT: 0px; WIDTH: 20px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=200 controltype="text"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">�����</TD>
                           <TD colSpan=6><INPUT class=nolinetext id=text_ztc style="LEFT: 0px; WIDTH: 128.33%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=25 controltype="text" field="ZTC" china="�����" dataset="dataset1" onblur='bill_onexit("validateLength();checkZTC();")'></TD>
                           <TD width="10%"></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" width="15%">����</TD>
                           <TD colSpan=7><INPUT class=nolinetext id=text45 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FWBT" china="���ı���" dataset="dataset1" onblur='bill_onexit("validateLength();")'></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" colSpan=8>����&nbsp;<BUTTON class=button1 id=button16 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openEdit()")'>�༭����</BUTTON></TD>
                        </TR>
                        <TR>
                           <TD style="COLOR: red" colSpan=8>����<BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("editFJ()")'>�༭����</BUTTON></TD>
                        </TR>
                        <TR>
                           <TD colSpan=8><IFRAME id=fjframe width="100%" height=120 srcolling="no"></IFRAME></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
                  <TABLE width="95%" border=0>
                     <TBODY>
                        <TR>
                           <TD><DIV align=right><DIV id=workflowControl1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%" onmovestart=moveStart() controltype="workflowControl" NotBg="��"><DIV id=divPrintFWGZ style="FLOAT: left">&nbsp;</DIV><DIV id=divScanFWGZ style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 215px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="��">��ѡ����<SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor();")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></DIV>&nbsp;</DIV><DIV id=divLookFWGZ style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��">��ѡ��ִ���ˣ�<INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_xzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("selectActors();")'>ѡִ����</BUTTON></DIV>&nbsp;</DIV><DIV id=divSendGWCS style="FLOAT: left; WIDTH: 84px"><DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��">��ѡ��ִ���ˣ�<INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("selectAndActors();")'>���֧ѡִ����</BUTTON></DIV>&nbsp;</DIV><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_qdlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'��������','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">��������</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_wchd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'��ɻ','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">��ɻ</BUTTON></DIV><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_ht style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'����','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">����</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_hs style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'�ջ�','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">�ջ�</BUTTON></DIV><DIV id=workflowControl_terminate style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_zzlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'��ֹ����','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">��ֹ����</BUTTON></DIV><DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'�ݴ�','/creatorepp/eformsys/fceform/common/djframe.htm?djsn='20090826085027984445'&amp;djtype=ZW')&quot;)">�ݴ�</BUTTON></DIV><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV></DIV></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </DIV>
            </TD>
         </TR>
      </TBODY>
   </TABLE>
   <?xml:namespace prefix = fc />
   <fc:dataset id=dataset1 format="<fields><field><fieldname>CS</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>1024</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DZR</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FJ</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FS</fieldname><datatype>����</datatype><displaylabel>����</displaylabel><size>6</size><precision></precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWBT</fieldname><datatype>�ַ�</datatype><displaylabel>���ı�</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWRQ</fieldname><datatype>����</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat>yy-mm-dd</displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FWZW</fieldname><datatype>ͼ��</datatype><displaylabel>��������</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HGYJ</fieldname><datatype>�ַ�</datatype><displaylabel>�˸���</displaylabel><size>2048</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HJ</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>6</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HQYJ</fieldname><datatype>�ַ�</datatype><displaylabel>��ǩ��</displaylabel><size>2048</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JDR</fieldname><datatype>�ַ�</datatype><displaylabel>У����</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCCYR</fieldname><datatype>�ַ�</datatype><displaylabel>���̲�����</displaylabel><size>2048</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCSLID</fieldname><datatype>�ַ�</datatype><displaylabel>����ʵ�����</displaylabel><size>32</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LXDH</fieldname><datatype>�ַ�</datatype><displaylabel>��ϵ�绰</displaylabel><size>12</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LXR</fieldname><datatype>�ַ�</datatype><displaylabel>��ϵ��</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MJ</fieldname><datatype>�ַ�</datatype><displaylabel>�ܼ�</displaylabel><size>4</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NGDW</fieldname><datatype>�ַ�</datatype><displaylabel>��嵥λ</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NGRQ</fieldname><datatype>����</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat>yy-mm-dd</displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>QFYJ</fieldname><datatype>�ַ�</datatype><displaylabel>ǩ����</displaylabel><size>2048</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJH</fieldname><datatype>����</datatype><displaylabel>�ļ���</displaylabel><size></size><precision>2</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJN</fieldname><datatype>�ַ�</datatype><displaylabel>�ļ���</displaylabel><size>4</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJZ</fieldname><datatype>�ַ�</datatype><displaylabel>�ļ���</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJZT</fieldname><datatype>�ַ�</datatype><displaylabel>�ļ�״̬</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>YWLB</fieldname><datatype>�ַ�</datatype><displaylabel>ҵ�����</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZS</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>1024</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZTC</fieldname><datatype>�ַ�</datatype><displaylabel>�����</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ssdw</fieldname><datatype>�ַ�</datatype><displaylabel>������λ</displaylabel><size>2</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>qcglid</fieldname><datatype>�ַ�</datatype><displaylabel>ǩ�ʹ���id</displaylabel><size>32</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ngr</fieldname><datatype>�ַ�</datatype><displaylabel>�����</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>hgr</fieldname><datatype>�ַ�</datatype><displaylabel>�˸���</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' onValid='bill_ondatasetvalid("<dsid><CS></CS><DZR></DZR><FJ></FJ><FS></FS><FWBT></FWBT><FWRQ></FWRQ><FWZW></FWZW><HGYJ></HGYJ><HJ></HJ><HQYJ></HQYJ><JDR></JDR><LCCYR></LCCYR><LCSLID></LCSLID><LXDH></LXDH><LXR></LXR><MJ></MJ><NGDW></NGDW><NGRQ></NGRQ><QFYJ></QFYJ><WJH></WJH><WJN></WJN><WJZ></WJZ><WJZT></WJZT><YWLB></YWLB><ZS></ZS><ZTC></ZTC><ssdw></ssdw><qcglid></qcglid><ngr></ngr><hgr></hgr></dsid>")' opensortno="1" temptable="TMP_DATASET2" saveastable="APP_4.TA_FWGL" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
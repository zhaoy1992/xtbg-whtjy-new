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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordControl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/WordControl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/vo/WordControlVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/vo/WordControlVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Variable.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/VariableDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/VariableDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/business/Dataset.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var mb_id = creator_getQueryString("mb_id")=="null"?"":creator_getQueryString("mb_id");//ģ��ID
if(mb_id == "") {
    mb_id = window.dialogArguments.parent.frames["rightFrame"].$("mb_id").value;
}
var kj_id = creator_getQueryString("kj_id")==null?"":creator_getQueryString("kj_id");//�ؼ�ID
var kj_type = creator_getQueryString("kj_type")==null?"":creator_getQueryString("kj_type");//�ؼ�����

var window_source = creator_getQueryString("window_source"); //������Դ 1���� 2�б�
var webOffice = "";
if(window_source == "1") {
    webOffice = window.dialogArguments.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
} 
if(window_source == "2"){
    webOffice = window.dialogArguments.parent.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
}


//��ʼ��
function init() {
    autoBLDropDownNumber();
    autoSJJDropDownNumber();
    if(kj_id != "") {
        updateKJ();
    }
    isLookElements();
}

//��ʾ����
function isLookElements() {
    if(kj_type != "textInput" && kj_type != "dropDown") {
        $("help").style.display = "none";
        $("flag").style.display = "none";
    }
}

//ȡ�õ�ѡ��ť���ʵ��ֵ
function getRadioValue(objName) {
    this.objName = objName;
    var radioGroupValue = "";
    var ridList = document.getElementsByName(this.objName);
    for(var i=0; i<ridList.length; i++){
        if(ridList[i].checked){
            radioGroupValue = ridList[i].value;
            break;
        }
    }
    return radioGroupValue;
}

//���õ�ѡ��ť���ʵ��ֵ
function setRadioValue(objName, objVal) {
    this.objName = objName;
    var ridList = document.getElementsByName(this.objName);
    for(var i=0; i<ridList.length; i++) {
        if(ridList[i].value == objVal.trim()) {
            ridList[i].checked = true;
            break;
        }
    }
}

//����
function kjSave() {
    if(!validate()){
        return;
    }
    var kjObj = new WordControlVo.WordControl();
    var kjVo = DBUtil.getVoFromPage(kjObj);
    kjVo.KJ_LX = kj_type;
    kjVo.KJ_MC = $("kj_name").value;
    kjVo.KJ_ID = $("kj_id").value;
    var kj_lx = getRadioValue("kj_lx");
    kjVo.KJ_QZ_LX =kj_lx;
        if(kj_lx =="1") {
        kjVo.KJ_QZ = $("bl_name").value;
    } else {
        kjVo.KJ_QZ = $("sjj_name").value;
    }
    kjVo.MB_ID = mb_id;
    kjVo.KJ_ZT = $("kj_flag").value; //״̬
     kjVo.KJ_BZ = $("kj_help").value; //����
     kjVo.KJ_REMARK = $("kj_remark").value; //��ע
     kjVo.IWEBOFFICE= webOffice ;
    var returnValue = WordControl.addWordControl(kjVo);
    if(returnValue){
        alert("����������Ϣ�ɹ�");
        kjClose();
    }else{
        alert("����������Ϣʧ��");
    }
}

//�޸Ŀؼ�
function updateKJ() {
    var kj_result = [];
    if(kj_type == "autoText") {
       kj_result = WordControl.selectWordAutoTextControl(kj_id);
    }
    if(kj_type == "orderlyTable") {
       kj_result = WordControl.selectWordOrderlyTextControl(kj_id);
    }
    if(kj_type == "textInput") {
       kj_result = WordControl.selectWordTextInputControl(kj_id);
    }
    if(kj_type == "dropDown") {
       kj_result = WordControl.selectWordDropDownControl(kj_id);
    }
    $("kj_id").value = kj_result[0][1];
    $("kj_name").value = kj_result[0][2];
    $("kj_name").readOnly = true;
    $("kj_remark").value = kj_result[0][4];    
    setRadioValue("kj_lx", kj_result[0][5]);
    if(kj_result[0][5] == "1") {
        $("bl_name").value = kj_result[0][3];
        $("sjj_name").value = "";
    } else {
        $("sjj_name").value = kj_result[0][3];
        $("bl_name").value = "";
    }
    if(kj_type == "textInput" || kj_type == "dropDown") {
        $("kj_help").value = kj_result[0][7];
        $("kj_flag").value = kj_result[0][8];
    }
}

function validate() {
    var kj_mc = $("kj_name").value;
    var kj_id = $("kj_id").value;
    var kj_lx = getRadioValue("kj_lx");
    var bl_name = $("bl_name").value;
    var sjj_name = $("sjj_name").value;
    if(mb_id == "" || mb_id == "null") {
        alert("ģ�������Ϣδ���棬���ȱ���");
        return false;
    }
    if(kj_mc == "") {
        alert("�ؼ����Ʋ���Ϊ��");
        return false;
    }
    if(kj_id == "") {
        var countNum = WordControl.isUnique(mb_id,kj_mc);
        if(parseInt(countNum) != 0) {
            alert("ͬһģ���еĿؼ�������ͬ������������");
            return false;
        }
    }
    if(kj_lx == "") {
        alert("��ѡ��ؼ�ȡֵ");
        return false;
    }  
    if(kj_lx =="1" && bl_name =="") {
        alert("��ѡ�����");
        return false;
    }
    if(kj_lx =="2" && sjj_name =="") {
        alert("��ѡ�����ݼ�");
        return false;
    }
    if(kj_type == "orderlyTable") {
        var wordSelection = webOffice.WebObject.ActiveWindow.Selection;
        if (!wordSelection.Information(wdWithInTable)) {
            alert("������WORDģ���д������");
            return false;
        }
    }
    return true;
}

//����
function kjResert() {
    if(window_source == "2") {
        $("kj_name").value = "";
        $("kj_id").value = "";
    }
    $("bl_name").value = "";
    $("sjj_name").value = "";
    $("kj_lx").value = "";
    $("kj_remark").value = "";
    if(kj_type == "textInput" || kj_type == "dropDown") {
        $("kj_help").value = "";
        $("kj_flag").value = "";
    }
}

//����ؼ�������ȡֵ
function clearCombo(object){
    var optionIndex = object.options.length;
    for(;optionIndex>=0;optionIndex--){
        object.options.remove(optionIndex);
    }
}

//��̬���ر�������������
function autoBLDropDownNumber(){
    clearCombo($("bl_name"));
    var sql="select bl_id,bl_mc from ta_word_bl t where mb_id ='"+mb_id+"'";
    SqlCombo("bl_name",sql);
    return;
}

//��̬�������ݼ�����������
function autoSJJDropDownNumber(){
    clearCombo($("sjj_name"));
    var sql="select sjj_id,sjj_mc from ta_word_sjj where mb_id ='"+mb_id+"'";
    SqlCombo("sjj_name",sql);
    return;
}

//�ر��¼�
function kjClose() {
    window.returnValue =true;
    window.close();
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>kj_remark</id><id>kj_help</id><id>kj_flag</id></textarea><combobox><id>bl_name</id><id>sjj_name</id></combobox><button><id>btnSave</id><id>btnReset</id></button><text><id>kj_name</id><id>kj_id</id><id>temp_id</id></text></root>" billtaborder="<root><taborder>kj_remark</taborder><taborder>btnSave</taborder><taborder>btnReset</taborder><taborder>kj_name</taborder><taborder>bl_name</taborder><taborder>sjj_name</taborder><taborder>kj_help</taborder><taborder>kj_flag</taborder><taborder>kj_id</taborder><taborder>temp_id</taborder></root>" dj_sn="20101109103344984109" caption="���Կؼ�" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:1;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101027105323156235" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/WordControl.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/WordControlDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/vo/WordControlVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/report/WordReportUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Variable.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/VariableDao.js&#13;&#10;../../../ccapp/app_xzcf/js/word/business/Dataset.js&#13;&#10;../../../ccapp/app_xzcf/js/word/dao/DatasetDao.js&#13;&#10;">

<TABLE height="100%" width="100%" border=1>
   <TBODY>
      <TR>
         <TD width="20%">�ؼ�����<FONT color=red>*</FONT></TD>
         <TD width="80%" colSpan=3><INPUT id=kj_name style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
      </TR>
      <TR>
         <TD width="20%" rowSpan=2>�ؼ�ȡֵ<FONT color=red>*</FONT><INPUT id=kj_id style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=temp_id style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
         <TD width="20%"><INPUT type=radio value=1 name=kj_lx>����</TD>
         <TD width="60%"><SELECT id=bl_name style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue='""' temptext="--��ѡ��--" sql check="1"><OPTION value='""' selected>--��ѡ��--</OPTION></SELECT></TD>
      </TR>
      <TR>
         <TD width="20%"><INPUT type=radio value=2 name=kj_lx>���ݼ�</TD>
         <TD width="60%"><SELECT id=sjj_name style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue='""' temptext="--��ѡ��--" sql check="1"><OPTION value='""' selected>--��ѡ��--</OPTION></SELECT></TD>
      </TD>
   </TR>
   <TR>
      <TD>����</TD>
      <TD colSpan=3><TEXTAREA id=kj_remark style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
   </TR>
   <TR id=help>
      <TD>����</TD>
      <TD colSpan=3><TEXTAREA id=kj_help style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
   </TR>
   <TR id=flag>
      <TD>״̬</TD>
      <TD colSpan=3><TEXTAREA id=kj_flag style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
   </TR>
   <TR>
      <TD align=right colSpan=3><BUTTON id=btnSave style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("kjSave();")'>����</BUTTON><BUTTON id=btnReset style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("kjResert();")'>����</BUTTON></TD>
   </TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
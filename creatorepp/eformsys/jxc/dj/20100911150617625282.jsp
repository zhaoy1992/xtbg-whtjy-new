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


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>

/**
 * <p> ����ҵ�����
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
 *  ����:   init
 *  ˵��:   ��ʼ������
 *  ����:   
 *  ����ֵ: 
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
 *  ����:   saveSendPunishDataInfo
 *  ˵��:   �������������Ϣ
 *  ����:  (1)������ִ����������ʷ��
            (2)�����´�������ʵ������������λ�ֶ�
            (3)�����������������
            (4)�������������ϸ�������ѯ��
 *  ����:   
 *  ����ֵ: 
 */
function saveSendPunishDataInfo() {
    if (confirm("�Ƿ����Ͱ�����")) {
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
            ysVo.IS_ID = "4";//��Ϣ��Դ֮����
              var sqlTmp =SendPunishData.selectPunishInstanceOldUnit(wft_id);
            ysVo.SU_ID_OLD = SqlToField(sqlTmp);
            ysVo.MD_TITLE = "�����������";
            ysVo.MD_BODY = $("punishIdea").value;
            var returnValue = SendPunishData.saveSendPunishDataInfo(ysVo);
            if(returnValue){
                alert("�������ͳɹ���");
                parent.parent.window.location.href = "20100929153136375631.jsp";
            }else{
                alert("��������ʧ�ܣ�");
            }
        }
    }
}

function validate(){
    var flag = true;
    if (flag) {
        if (IsSpace($("receive_deptname").value)) {
            alert("��ѡ����յ�λ��");
            flag = false;
        }
    }
    $("punishIdea").value = $("punishIdea").value.trim();
    if (flag) {
        if (IsSpace($("punishIdea").value)) {
            alert("���������������Ϊ�գ�");
            flag = false;
        }
    }
    return flag;
}

/* ���ϴ�����ҳ�� */
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

//��ִ�������ѡ��
function openOrgTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseAllZfztSingle.jsp";
    $("orgNames").value = $("receive_deptname").value ;
    $("orgIds").value = $("org_id").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("receive_deptname").value = $("orgNames").value ;
    $("org_id").value  = $("orgIds").value ;
}

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>punishIdea</id></textarea><img><id>img0</id></img><button><id>btnUpload</id><id>btnYs</id></button><text><id>org_id</id><id>orgNames</id><id>orgIds</id><id>receive_deptname</id></text><dataset><id>dataset1</id><id>dataset2</id></dataset></root>" billtaborder="<root><taborder>punishIdea</taborder><taborder>receive_deptname</taborder><taborder>org_id</taborder><taborder>btnYs</taborder><taborder>btnUpload</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100911150617625282" caption="����" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:1;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/common/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SendPunishData.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SendPunishDataDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SendPunishDataVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE class=Ctable height="40%" width="100%" align=center border=1>
   <TBODY>
      <TR>
         <TD class=taobox align=middle colSpan=2>����</TD>
      </TR>
      <TR>
         <TD class=c2>���յ�λ<INPUT id=org_id style="DISPLAY: none; LEFT: 60px; WIDTH: 110px; POSITION: static; TOP: 26px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 52px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=9 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 42px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text"></TD>
         <TD><INPUT id=receive_deptname style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openOrgTree()")'><IMG id=img0 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/app_xzcf/images/search12.gif" controltype="img" onclick='bill_onclick("openOrgTree()")' cover="9" srcsk="../../../ccapp/app_xzcf/images/search12.gif"></TD>
      </TR>
      <TR>
         <TD class=c2 height=92>�����������</TD>
         <TD><TEXTAREA id=punishIdea style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() cols=135 controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD class=c2>��������</TD>
         <TD><BUTTON class=button id=btnUpload style="LEFT: 302px; POSITION: static; TOP: 143px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>�����ϴ�</BUTTON></TD>
      </TR>
      <TR>
         <TD align=middle colSpan=2><BUTTON class=button id=btnYs style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveSendPunishDataInfo();")'>����</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>wft_id</fieldname><datatype>�ַ�</datatype><displaylabel>Υ������ʵ��ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�½��ֶ�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><wft_id></wft_id><MD_ID></MD_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" saveastable="TA_DOCUMENT_MULTI" multiResult="��"></fc:dataset>

<fc:dataset id=dataset2 format="<fields><field><fieldname>bu_id</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_referral_unit</fieldname><datatype>�ַ�</datatype><displaylabel>�½��ֶ�</displaylabel><size>150</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><wft_referral_unit></wft_referral_unit></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js'></script>");
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
//��������ʵ����ŵĻ�ȡ
var wftId = creator_getQueryString("WFT_ID");
//����������ʵ����Ÿ�Ĭ��ֵ
if(IsSpace(wftId)){
    wftId = 1 ;
}
//֤����Ϣ��ŵĻ�ȡ
var elId = creator_getQueryString("EL_ID");
//��ʼ������
function init(){
    //����Υ����Ϊ�����б�
    var sql = "select t.or_id, trim(t1.rmd_name) rmd_name from TA_OFFENSE_RECORD t, " + 
             "TA_RULE_MATTER_DICTIONARY t1 where t.wft_id = " + wftId + 
             " and t.rmd_id = t1.rmd_id";
    if(!IsSpace(sql)){
        SqlCombo(WFXW_combox, sql);
    }
    if(IsSpace(elId)){//�������ʾ���ݵĳ�ʼ��
        $('MT_ID').value = -1 ;
        document.getElementById("AABB").innerText = "����֤����Ϣ" ;
    }else{
         document.getElementById("AABB").innerText = "�޸�֤����Ϣ" ;
         var sql = EvidenceList.findEvidenceListByElid(elId);
         dataset1.Open(sql);
         $("WFXW_combox").value = dataset1.Fields.Field['OR_ID'].Value;
    }
    $("EL_ID").value = elId;
}

//���水ť����
function saveProof(){
    if(IsSpace($("EL_ID").value)){//���֤����ˮΪ�գ����������֤����Ϣ
        if(validateProof()){
           var obj = new EvidenceListVo.Evidence() ;  //֤��Vo
           var evidenceVo= DBUtil.getVoFromPage(obj);
           //evidenceVo.OR_ID = findIllegalId() ;//Υ����ʵ��� 
             evidenceVo.OR_ID = $("WFXW_combox").value;//Υ����¼ID 
             evidenceVo.EL_FORMAT = "" ; //��ʽ
             evidenceVo.EL_DEL = 0 ; //ɾ��
            var vr = EvidenceList.addEvidenceList(evidenceVo); //����Biz����
             if(vr){
                alert("����ɹ�");
                var elids = DBUtil.getSeq("SEQ_EVIDENCE_LIST")-1 ;
                $("EL_ID").value = elids ; 
            }else{
                alert("����ʧ��");
            }
       }
    }else{//����֤����ˮ�Ž���֤����Ϣ���޸�
        if(validateProof()){
           var obj = new EvidenceListVo.Evidence() ;  //֤��Vo
           var evidenceVo= DBUtil.getVoFromPage(obj);
           evidenceVo.EL_ID = $("EL_ID").value ;
           var vr = EvidenceList.updEvidenceList(evidenceVo);
           if(vr){
               alert("����ɹ�");
           }else{
               alert("����ʧ��");
           }
       }
    }
}

//��ѯΥ����ʵ���
function findIllegalId(){
   var vr = EvidenceList.findIllegalId(wftId);
   return vr ;
}

//�����ϴ���ť����
/* ���ϴ�����ҳ�� */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('EL_EVIDENCE_BODY').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('EL_EVIDENCE_BODY').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

//֤����Ϣ��֤����
function validateProof(){
    var flag = true;
    
    if(flag){
        if($("WFXW_combox").value == -1){
            alert("��ѡ��Υ����Ϊ");
            flag = false;
        }
    }
    
    if (flag) {
        if(${'MT_ID'}.value==-1){
            alert("��ѡ���������");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_DESCRIPTION'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_DESCRIPTION'}.value]},
            MESSAGE : "�������Ʋ���Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_ACQUISITION_TIME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_ACQUISITION_TIME'}.value]},
            MESSAGE : "�ɼ�ʱ�䲻��Ϊ��"
        }, true);
    }
    
    if(flag){
        var newTime = ${'EL_ACQUISITION_TIME'}.value ;
        var sysTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,sysTime);
        if(!flag){
            alert("�ɼ�ʱ�䲻�ܴ���ϵͳ��ǰʱ��");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_NUM'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_NUM'}.value]},
            MESSAGE : "���Ϸ�������Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_NUM'}.value, {
            CHECK_TYPE : "integer",
            ARGUMENT : {placeholders : ["���Ϸ���"],length : 0}
        }, false);
    }  
    
    if (flag) {
        var reg = /^[1-9]\d*$/;
        if (!reg.test($("EL_NUM").value)) {
            alert("���Ϸ�����������������");
            flag = false;
        }
    }
   return flag;
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>EL_REMARK</id></textarea><combobox><id>WFXW_combox</id><id>MT_ID</id></combobox><button><id>button3</id><id>button1</id><id>button2</id></button><text><id>EL_DESCRIPTION</id><id>EL_ACQUISITION_TIME</id><id>EL_NUM</id><id>EL_EVIDENCE_BODY</id><id>EL_ID</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>WFXW_combox</taborder><taborder>MT_ID</taborder><taborder>EL_DESCRIPTION</taborder><taborder>EL_ACQUISITION_TIME</taborder><taborder>EL_REMARK</taborder><taborder>EL_NUM</taborder><taborder>button3</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>EL_EVIDENCE_BODY</taborder><taborder>EL_ID</taborder></root>" dj_sn="20100928171808109374" caption="���������޸�֤����Ϣ" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:1;textarea:1;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:2;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:1;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EvidenceList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=AABB colSpan=4></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">Υ����Ϊ<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=WFXW_combox style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="OR_ID" china="Υ����¼��ˮ" dataset="dataset1" tempvalue="-1" temptext="--��ѡ��--" sql check="1"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">֤�ݲ�������<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=MT_ID style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() name=select sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A8%B6%CC%A0%96Xr%94%A8%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%E8%D0%F6%D8%F2%E0%D0%E6%CC%F6%u0100%EE%D8Xrn%F6Xrn%AC%B2%96%98%B2Xrn%92%C0Xrn%A8%B6%CC%A0%96" controltype="combobox" field="MT_ID" china="֤�ݲ�������" dataset="dataset1" tempvalue="-1" temptext="--��ѡ��--" sql check="1"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��������<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=EL_DESCRIPTION style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text" field="EL_DESCRIPTION" china="��������" dataset="dataset1"></TD>
                     <TD class=c2 width="15%">�ɼ�ʱ��<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD><INPUT class=its_out id=EL_ACQUISITION_TIME style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly name=Input controltype="text" field="EL_ACQUISITION_TIME" china="�ɼ�ʱ��" dataset="dataset1" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��Ҫ����</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=EL_REMARK style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() name=textarea controltype="textarea" field="EL_REMARK" china="��ע" dataset="dataset1" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">���Ϸ���<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=EL_NUM style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text" field="EL_NUM" china="���Ϸ���" dataset="dataset1">&nbsp;��</TD>
                     <TD width="50%" colSpan=2><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>�����ϴ�</BUTTON><INPUT id=EL_EVIDENCE_BODY style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="EL_EVIDENCE_BODY" china="�ĵ���" dataset="dataset1"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle colSpan=2><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveProof()")'>����</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("CloseBill()")'>�ر�</BUTTON></TD>
      </TR>
      <TR>
         <TD colSpan=4>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD><INPUT id=EL_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=13 name=Input controltype="text" field="EL_ID" china="֤�ݱ��" dataset="dataset1"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>MT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>֤�ݲ�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ACQUISITION_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>�ɼ�ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DESCRIPTION</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_REMARK</fieldname><datatype>�ַ�</datatype><displaylabel>��ע</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_NUM</fieldname><datatype>�ַ�</datatype><displaylabel>���Ϸ���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_ID</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����¼��ˮ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ID</fieldname><datatype>�ַ�</datatype><displaylabel>֤�ݱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DSM</fieldname><datatype>�ַ�</datatype><displaylabel>�ĵ����淽ʽ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_EVIDENCE_BODY</fieldname><datatype>�ַ�</datatype><displaylabel>�ĵ���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' onValid='bill_ondatasetvalid("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
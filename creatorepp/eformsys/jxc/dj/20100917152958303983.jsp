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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/DsrVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/DsrVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var LTT_ID = creator_getQueryString("LTT_ID");//��������ˮ��
var OR_ID = creator_getQueryString("OR_ID");
var WFT_ID = creator_getQueryString("WFT_ID");
var rddType = creator_getQueryString("rddType");
var readOnlyFlag = creator_getQueryString("readOnlyFlag");//�Ƿ�Ϊֻ��

//ѡ������
function xzDsr(){
    var tempPara="dialogWidth:760px;dialogHeight:400px;";
    var tempURL="20101016144747234036.jsp?WFT_ID="+WFT_ID;
    var tmp = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(tmp)) {
        var name_tmp = tmp.names;
        var id_tmp = tmp.ids;
        $("LTT_NAME").value = name_tmp;
        LTT_ID = id_tmp;
        init();
    }
}

//����
function save(){
    if (validate()) {
        var obj = new DsrVo.Dsr();
        var vo = DBUtil.getVoFromPage(obj);
        var typeTmp = document.getElementsByName("userType");
        if (typeTmp[0].checked) {
            vo.LTT_ATTRI = typeTmp[0].value;
        } else {
            vo.LTT_ATTRI = typeTmp[1].value;
        }
        vo.LTT_ID = LTT_ID;
        vo.WFT_ID = WFT_ID ;
        vo.OR_ID = OR_ID;
        var rv = Ajsl.saveDsr(vo);
        if (rv) {
            alert("����������Ϣ�ɹ���");
            if (LTT_ID == 0) {
                LTT_ID= vo.LTT_ID ;
            }
            window.close();
        } else {
            alert("����������Ϣʧ�ܣ�");
        }
    }
}

//��ʼ��
function init(){
    var typeSels = document.getElementsByName("userType");
    if ((","+rddType+",").indexOf(",1,")==-1) {
        typeSels[0].checked=false;
        typeSels[0].disabled=true;
        typeSels[1].checked = true;
    }
    if ((","+rddType+",").indexOf(",2,")==-1) {
        typeSels[1].checked=false;
        typeSels[1].disabled=true;
    }
    if (LTT_ID==null||LTT_ID=="") { LTT_ID=0;}
    if (LTT_ID) {
        var sql = Ajsl.getDsrById(LTT_ID);
        dsrSavedataset.Open(sql);
        var typeTmp = document.getElementsByName("userType");
        if (dsrSavedataset.Fields.Field['LTT_ATTRI'].Value==1) {
            typeTmp[0].checked = true;
        } else {
            typeTmp[1].checked = true;
        }
        ${'CT_ID'}.value = dsrSavedataset.Fields.Field['CT_ID'].Value;
        document.getElementById("xzDsr").style.visibility = "hidden";
    }
    if (readOnlyFlag == "readOnly") {
        document.getElementById("xzDsr").style.visibility = "hidden";
        document.getElementById("saveBtn").style.visibility = "hidden";
        HTMLUtil.readOnly($("LTT_NAME"),"commonReadOnly");
        HTMLUtil.readOnly($("CT_ID"),"commonReadOnly");
        HTMLUtil.readOnly($("LTT_CODE"),"commonReadOnly");
        HTMLUtil.readOnly($("LTT_CORPORATE_COMMISSARY"),"commonReadOnly");
        HTMLUtil.readOnly($("LTT_TEL"),"commonReadOnly");
        HTMLUtil.readOnly($("LTT_ADDRESS"),"commonReadOnly");
        var tmpRadio = document.getElementsByName("userType");
        tmpRadio[0].disabled = true;
        tmpRadio[1].disabled = true;
    }
}

//��֤
function validate(){
    var flag = true;
    delSpace();
    if (flag) {
        flag = SValidator.validate(${'LTT_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'LTT_NAME'}.value]},
            MESSAGE : "������/��λ���Ʋ���Ϊ��!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'LTT_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [40],maxlength : 40},
            MESSAGE : "������/��λ���Ʋ��ܳ���{0}�ַ�!"
        }, true);
    }
    if (flag) {
        var typeSels = document.getElementsByName("userType");
        if (!typeSels[0].checked&&!typeSels[1].checked) {
            flag = false;
            alert("��ǰΥ����Ϊ��δ�������ɲ���Ȩ!");
        }
    }
    if (flag) {
        if(document.getElementById('CT_ID').value==-1){
            alert("��ѡ��֤������!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate(${'LTT_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'LTT_CODE'}.value]},
            MESSAGE : "֤�����벻��Ϊ��!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'LTT_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "֤�����벻�ܳ���{0}�ַ�!"
        }, true);
    }
    if (flag) {
        flag = checkonly(LTT_ID, ${'LTT_CODE'}.value);
        if (!flag) {
            alert("֤�������Ѵ��ڣ����������룡");
            return false;
        }
    }
    if (!IsSpace($("LTT_TEL").value)) {
        if (flag) {
            var reg=/(^\d{11}$)|(^\d{7}$)|(^\d{4}[-]\d{7}$)/;
            if (!reg.test($("LTT_TEL").value)) {
                alert("��������ȷ�ĵ绰���룡");
                return false;
            }
        }
    }
    return flag;
}

//ȥȫ�ǰ�ǿո�
function delSpace(){
    ${'LTT_NAME'}.value = ${'LTT_NAME'}.value.trim();
    ${'LTT_CODE'}.value = ${'LTT_CODE'}.value.trim();
    ${'LTT_CORPORATE_COMMISSARY'}.value = ${'LTT_CORPORATE_COMMISSARY'}.value.trim();
    ${'LTT_TEL'}.value = ${'LTT_TEL'}.value.trim();
    ${'LTT_ADDRESS'}.value = ${'LTT_ADDRESS'}.value.trim();
}

//��֤֤�������Ƿ�Ψһ
function checkonly(ltt_id, bm){
    var num = Ajsl.countZjBm(ltt_id, bm);
    if (num > 0) {
        return false;
    } else {
        return true;
    }
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><combobox><id>CT_ID</id></combobox><button><id>xzDsr</id><id>saveBtn</id><id>closeBtn</id></button><text><id>LTT_NAME</id><id>LTT_CODE</id><id>LTT_CORPORATE_COMMISSARY</id><id>LTT_TEL</id><id>LTT_ADDRESS</id></text><dataset><id>dsrSavedataset</id></dataset></root>" billtaborder="<root><taborder>saveBtn</taborder><taborder>closeBtn</taborder><taborder>LTT_NAME</taborder><taborder>CT_ID</taborder><taborder>LTT_CODE</taborder><taborder>LTT_CORPORATE_COMMISSARY</taborder><taborder>LTT_TEL</taborder><taborder>LTT_ADDRESS</taborder><taborder>xzDsr</taborder></root>" dj_sn="20100917152958303983" caption="�༭������" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:4;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100913200141634274" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/DsrVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Ajsl.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/AjslDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<TABLE class=Ctable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD class=taobox colSpan=4>�༭������</TD>
      </TR>
      <TR>
         <TD class=c2>������/��λ����<FONT color=#ff0000>*</FONT></TD>
         <TD colSpan=3><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 413px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=75 controltype="text" field="LTT_NAME" china="����������" dataset="dsrSavedataset"><BUTTON id=xzDsr style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("xzDsr()")'>ѡ��</BUTTON></TD>
      </TR>
      <TR>
         <TD class=c2>����������<FONT color=#ff0000>*</FONT></TD>
         <TD><INPUT type=radio CHECKED value=1 name=userType>����<INPUT type=radio value=2 name=userType>���˻�������֯</TD>
         <TD class=c2>֤������<FONT color=#ff0000>*</FONT></TD>
         <TD><SELECT id=CT_ID style="LEFT: 0px; WIDTH: 133px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%B6%CC%A0%96Xr%94%94%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%94%98%B2%B6%B6%C0%AE%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%94%B6%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--��ѡ��--" sql check="2"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
      </TR>
      <TR>
         <TD class=c2>֤������<FONT color=#ff0000>*</FONT></TD>
         <TD><INPUT class=input_out id=LTT_CODE style="LEFT: 0px; WIDTH: 157px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=28 controltype="text" field="LTT_CODE" china="֤������" dataset="dsrSavedataset"></TD>
         <TD class=c2>���˴���</TD>
         <TD><INPUT class=input_out id=LTT_CORPORATE_COMMISSARY style="LEFT: 0px; WIDTH: 132px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=24 controltype="text" field="LTT_CORPORATE_COMMISSARY" china="���˴���" dataset="dsrSavedataset"></TD>
      </TR>
      <TR>
         <TD class=c2>�����˵绰</TD>
         <TD colSpan=3><INPUT class=input_out id=LTT_TEL style="LEFT: 0px; WIDTH: 158px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=28 controltype="text" field="LTT_TEL" china="�����˵绰" dataset="dsrSavedataset"><FONT color=red size=2>(�绰��ʽ�磬'0735-1234567'��'15812345678'��'1234567')</FONT></TD>
      </TR>
      <TR>
         <TD class=c2>�����˵�ַ</TD>
         <TD colSpan=3><INPUT class=input_out id=LTT_ADDRESS style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=24 controltype="text" field="LTT_ADDRESS" china="�����˵�ַ" dataset="dsrSavedataset"></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR align=middle>
         <TD><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("save()")'>����</BUTTON><BUTTON class=button id=closeBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("CloseBill()")'>�ر�</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dsrSavedataset format="<fields><field><fieldname>LTT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������ˮ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>֤������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ATTRI</fieldname><datatype>�ַ�</datatype><displaylabel>����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>֤������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CORPORATE_COMMISSARY</fieldname><datatype>�ַ�</datatype><displaylabel>���˴���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_TEL</fieldname><datatype>�ַ�</datatype><displaylabel>�����˵绰</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ADDRESS</fieldname><datatype>�ַ�</datatype><displaylabel>�����˵�ַ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><LTT_ID></LTT_ID><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_ATTRI></LTT_ATTRI><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><LTT_ID></LTT_ID><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_ATTRI></LTT_ATTRI><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS></dsid>")' onValid='bill_ondatasetvalid("<dsid><LTT_ID></LTT_ID><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_ATTRI></LTT_ATTRI><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
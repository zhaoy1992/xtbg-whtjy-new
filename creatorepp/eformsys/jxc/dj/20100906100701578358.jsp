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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/LawVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/LawVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LawManager.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LawManager.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LawManagerDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LawManagerDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
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
var cl_id = creator_getQueryString("cl_id");//��ȡҪ�޸ĵķ��ɷ�����ID
var temp = false;

//��ʼ���޸�ҳ��
function initLaw(){
    if(IsSpace(cl_id)){//�������ɷ���
        ${'CL_NAME'}.value = "";
        ${'CL_BRIEF_NAME'}.value = "";
        ${'CL_AGENCY'}.value = "";
        $('VC_ID').value = "-1";
        ${'CLT_ID'}.value = "-1";
        ${'CL_DATE'}.value = "";
        ${'CL_EXPIRY_DATE'}.value = "";
        ${'CL_TEXTS'}.value = "";
        setStatType(1);        
         ${'saveUpdate'}.style.display = "none";
    } else {//�޸ķ��ɷ���
         var obj = new LawVo.Law();
        var vo = DBUtil.getVoFromPage(obj);
        ${'saveAndClose1'}.style.display = "none";
        ${'saveAndAdd1'}.style.display = "none";
        vo.CL_ID = cl_id;
        var sql = LawManager.initUpdateLawManager(vo.CL_ID);
        addlawdataset.Open(sql);
        if(IsSpace($('VC_ID').value)){
            $('VC_ID').value = -1;
        }
        vo.CL_ENABLE = addlawdataset.Fields.Field['CL_ENABLE'].Value;
        var tmp = document.getElementsByName('CL_ENABLE');
        if (vo.CL_ENABLE == 1) {
            tmp[0].checked = true;
        } else {
            tmp[1].checked = true;
        }
        document.getElementById("VC_ID").disabled = true;
        temp = true;
    }
}

function setStatType(type){
    var boxes = document.getElementsByName("CL_ENABLE");
    for(var i = 0; i < boxes.length; i++){
        if(type == boxes[i].value){
            boxes[i].checked = true;
            break;
        }
    }    
}

//�޸ķ��ɷ����
function updateLaw(){
    if(temp && insertLaw_validate()){
        var obj = new LawVo.Law();
        var vo = DBUtil.getVoFromPage(obj);
        vo.CL_ID = cl_id;
        if(!IsSpace($('CL_TEXTS').value)){
            vo.CL_DSM = 3;  //����ƽ̨
             vo.CL_TEXTS = $('CL_TEXTS').value;
        }
        var tmp = document.getElementsByName('CL_ENABLE');
        if (tmp[0].checked) {
            vo.CL_ENABLE = tmp[0].value ;
        } else {
            vo.CL_ENABLE = tmp[1].value ;
        }
        var rv = LawManager.saveLawManager(vo);
        if (IsSpace(rv)) {
            alert("����ɹ�");
        } else {
            alert("����ʧ��");
        }
        //window.close();
    }
}

//���淨�ɷ���
function saveLaw(){
    var flag = false;
    var obj = new LawVo.Law();
    var vo = DBUtil.getVoFromPage(obj);
    if(IsSpace($('CL_TEXTS').value)){
        vo.CL_DSM = 0; //�޸���
        vo.CL_TEXTS = "";
    } else {
        vo.CL_DSM = 3; //��������ƽ̨
         vo.CL_TEXTS = $('CL_TEXTS').value;
    }
    //ȡ�á�״̬��radio��ֵ
     var tmp = document.getElementsByName('CL_ENABLE');
    if (tmp[0].checked) {
        vo.CL_ENABLE = tmp[0].value ;
    } else {
        vo.CL_ENABLE = tmp[1].value ;
    }
    if(insertLaw_validate()){
        var rv = LawManager.saveLawManager(vo);
        if(IsSpace(rv)){
            return true;
        }else{
            return false;
        }
    }
}

//���沢�ر�
function saveAndClose(){
    var flag = saveLaw();
    if(flag == true){
        alert("����ɹ�");
        window.close();
    }
}

//���沢����
function saveAndAdd(){
    var flag = saveLaw();
    if(flag == true){
        alert("����ɹ�");
        initLaw();
    }
}

//�رմ���
function windowClose(){
  window.close();
}

//�к�ɫ*�ŵ��ֶ�Ϊ����д�����������Ƿ���д,����ֶγ��ȣ����ʱ���߼�����
function insertLaw_validate(){
    var flag = true;
 
    //��֤���ɷ��������Ƿ���д
    if(flag){
        flag = SValidator.validate(${'CL_NAME'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["���ɷ�������"]}
        }, true);
    }
    
    //��֤���ɷ������Ƶĳ���
    if(flag){
        flag = SValidator.validate(${'CL_NAME'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["���ɷ�������", 80], maxlength : 80}
        }, true);
    }
    
    //��֤���ɷ������Ƿ���д
    if(flag){
        flag = SValidator.validate(${'CL_BRIEF_NAME'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["���ɷ�����"]}
        }, true);
    }
    
    //��֤���ɷ����Ƶĳ���
    if(flag){
        flag = SValidator.validate(${'CL_BRIEF_NAME'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["���ɷ�����", 80], maxlength : 80}
        }, true); 
    }
    
    //��֤�������ŵĳ���
    if(flag){
        flag = SValidator.validate(${'CL_AGENCY'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["�������ŵĳ���", 80], maxlength : 80}
        }, true);
    }
    
    //��֤���������Ƿ���д
    if(flag){
        if($('CLT_ID').value == -1){
            alert("��ѡ�񷨹����ͣ�");
            flag = false;
        }
    }
    
    //��֤��Ч�����Ƿ���д
    if(flag){
        flag = SValidator.validate(${'CL_DATE'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["��Ч����"]}
        }, true);
    }
    
    //ʧЧ���ڱ��������Ч����
    if(flag){
        if(!IsSpace(${'CL_EXPIRY_DATE'}.value) && ${'CL_DATE'}.value >= ${'CL_EXPIRY_DATE'}.value){
        alert("ʧЧ���ڱ��������Ч���ڣ�");
        flag = false;
        }
    }
    return flag;
}

/* ���ϴ�����ҳ�� */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('CL_TEXTS').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('CL_TEXTS').value = id;
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

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();initLaw();" contxml="<root><combobox><id>VC_ID</id><id>CLT_ID</id></combobox><button><id>button3</id><id>saveUpdate</id><id>saveAndClose1</id><id>saveAndAdd1</id><id>closeWindow</id></button><text><id>CL_NAME</id><id>CL_BRIEF_NAME</id><id>CL_AGENCY</id><id>CL_DATE</id><id>CL_EXPIRY_DATE</id><id>CL_TEXTS</id><id>cl_id</id><id>CL_DSM</id></text><dataset><id>addlawdataset</id></dataset></root>" billtaborder="<root><taborder>VC_ID</taborder><taborder>CLT_ID</taborder><taborder>button3</taborder><taborder>saveUpdate</taborder><taborder>saveAndClose1</taborder><taborder>saveAndAdd1</taborder><taborder>closeWindow</taborder><taborder>CL_NAME</taborder><taborder>CL_BRIEF_NAME</taborder><taborder>CL_AGENCY</taborder><taborder>CL_DATE</taborder><taborder>CL_EXPIRY_DATE</taborder><taborder>cl_id</taborder><taborder>CL_TEXTS</taborder><taborder>CL_DSM</taborder></root>" dj_sn="20100906100701578358" caption="�������޸ķ��ɷ���" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181501546870" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/LawVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LawManager.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LawManagerDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js" center="����">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=c2 width="15%">���ɷ�������<FONT color=red>*</FONT></TD>
                     <TD width="85%" colSpan=3><INPUT class=input_out id=CL_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_NAME" china="���ɷ�������" dataset="addlawdataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">���ɷ�����<FONT color=red>*</FONT></TD>
                     <TD width="85%" colSpan=3><INPUT class=input_out id=CL_BRIEF_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_BRIEF_NAME" china="���ɷ�����" dataset="addlawdataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��ҵ����</TD>
                     <TD width="35%"><SELECT id=VC_ID style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2" controltype="combobox" field="VC_ID" china="��ҵ����" dataset="addlawdataset" tempvalue="-1" temptext="--��ѡ��--" sql check="2"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">��������</TD>
                     <TD width="35%"><INPUT class=input_out id=CL_AGENCY style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_AGENCY" china="��������" dataset="addlawdataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��������<FONT color=red>*</FONT></TD>
                     <TD width="35%"><SELECT id=CLT_ID style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%A6%B6%CC%A0%96Xr%94%94%A6%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%94%9E%A0%AA%90%CC%A6%90%BC%B4%CC%B6%C0%AE%98" controltype="combobox" field="CLT_ID" china="��������" dataset="addlawdataset" tempvalue="-1" temptext="--��ѡ��--" sql check="2"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">״̬</TD>
                     <TD width="35%"><INPUT type=radio CHECKED value=1 name=CL_ENABLE>��Ч</INPUT><INPUT type=radio value=0 name=CL_ENABLE>ʧЧ</INPUT></TD>
            </TR>
            <TR>
               <TD class=c2 width="15%">��Ч����<FONT color=red>*</FONT></TD>
               <TD width="35%"><INPUT class=its_out id=CL_DATE style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly controltype="text" field="CL_DATE" china="��Ч����" dataset="addlawdataset" onclick='bill_onclick("SelectDate()")'></TD>
               <TD class=c2 width="15%">ʧЧ����</TD>
               <TD width="35%"><INPUT class=its_out id=CL_EXPIRY_DATE style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly controltype="text" field="CL_EXPIRY_DATE" china="ʧЧ����" dataset="addlawdataset" onclick='bill_onclick("SelectDate()")'></TD>
            </TR>
            <TR>
               <TD class=c2 width="15%">�����ϴ�</TD>
               <TD width="85%" colSpan=3>&nbsp;<BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>�����ϴ�</BUTTON><INPUT id=CL_TEXTS style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_TEXTS" china="�����ı�" dataset="addlawdataset"><INPUT id=cl_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_ID" china="���ɷ����" dataset="addlawdataset"><INPUT id=CL_DSM style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CL_DSM" china="����洢��ʽ" dataset="addlawdataset"></TD>
            </TR>
         </TBODY>
      </TABLE>
      <TR>
         <TD align=middle><BUTTON class=button id=saveUpdate style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("updateLaw()")'>����</BUTTON><BUTTON class=button id=saveAndClose1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveAndClose()")'>���沢�ر�</BUTTON><BUTTON class=button id=saveAndAdd1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveAndAdd()")'>���沢����</BUTTON><BUTTON class=button id=closeWindow style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("windowClose()")'>�ر�</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 align=left border=0>
               <TBODY>
                  <TR>
                     <TD></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=addlawdataset showtypeXml="<root><showType><name>CL_ID</name><showRule>undefined</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>CL_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>���ɷ�������</displaylabel><size>80</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_BRIEF_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>���ɷ�����</displaylabel><size>80</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_AGENCY</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>80</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CLT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>��Ч����</displaylabel><size>7</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_EXPIRY_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>ʧЧ����</displaylabel><size>7</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_ENABLE</fieldname><datatype>�ַ�</datatype><displaylabel>״̬</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ����</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_ID</fieldname><datatype>�ַ�</datatype><displaylabel>���ɷ����</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_DSM</fieldname><datatype>�ַ�</datatype><displaylabel>����洢��ʽ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_TEXTS</fieldname><datatype>�ַ�</datatype><displaylabel>�����ı�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><CL_NAME></CL_NAME><CL_BRIEF_NAME></CL_BRIEF_NAME><CL_AGENCY></CL_AGENCY><CLT_ID></CLT_ID><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><CL_ID></CL_ID><CL_DSM></CL_DSM><CL_TEXTS></CL_TEXTS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CL_NAME></CL_NAME><CL_BRIEF_NAME></CL_BRIEF_NAME><CL_AGENCY></CL_AGENCY><CLT_ID></CLT_ID><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><CL_ID></CL_ID><CL_DSM></CL_DSM><CL_TEXTS></CL_TEXTS></dsid>")' onValid='bill_ondatasetvalid("<dsid><CL_NAME></CL_NAME><CL_BRIEF_NAME></CL_BRIEF_NAME><CL_AGENCY></CL_AGENCY><CLT_ID></CLT_ID><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><CL_ID></CL_ID><CL_DSM></CL_DSM><CL_TEXTS></CL_TEXTS></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
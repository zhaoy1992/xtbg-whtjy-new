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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js'></script>");
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
var buId=creator_getQueryString("bu_id");//ִ��������
var buName=creator_getQueryString("bu_name");//ִ����������
var userId = creator_getQueryString("userId");//ִ����Ա���
var orgId= creator_getQueryString("org_id");//ִ����Ա���

//��ʼ����Ϣ
function init(){
   $("BU_ID").value = buId;
   $("BU_NAME").value = buName;
   $("orgIds").value = buId;
   addOrUpdLawUserInfo();  
}

//�ж������������޸����ݵĳ�ʼ��
function addOrUpdLawUserInfo(){
    $("BU_ID").value = buId; 
    if(IsSpace(buId)){
        $("BWT_ID").value = -1 ;
        $("ELU_STATUS").value = -1 ;
    }else{        
        $("BU_ID").disabled = true;
    }
    //���ִ����Ա���Ϊ�գ�������������ݳ�ʼ��;��������޸����ݳ�ʼ��
    if(IsSpace(userId)){
        $("BWT_ID").value = -1 ;
        $("ELU_STATUS").value = -1 ;
        document.getElementById("CF_BB").innerText = "����ִ����Ա" ;      
    }else{
         $('BU_ID').disabled = true ;
         $("USER_NAME").disabled = true ;
         document.getElementById("CF_BB").innerText = "�޸�ִ����Ա" ;
         var sql = BusinessUnit.findLawUserById(userId);//��ʼ���޸�ʱ����        
          addLawUserDateset.Open(sql);
    }
}

//���溯��
function addOrUpdLawUser(){
    //���ִ����Ա���Ϊ�գ��������������;��������޸�����
    if(IsSpace(userId)){     
        addLawUser();//��������  
    }else{
        updLawUsre();//�޸�����       
    }
}

//����ִ����Ա
function addLawUser(){
    var flag = validate();
    if(!flag){
         return;
    }else{
        var obj = new xzcf.vo.LawUser();
        var lawUserVo= DBUtil.getVoFromPage(obj);
        var user_Id = $("USER_ID").value ;
        lawUserVo.USER_ID = user_Id ;
        var tmp = "";
        var temp = document.getElementsByName('RGELU_STATUS');
        for(var i = 0 ; i<temp.length ; i++){
            if(temp[i].checked == true){
                tmp = temp[i].value ;
            }
        }
        lawUserVo.ELU_STATUS = tmp ;
        lawUserVo.ELU_ACCESSORIES = $('ELU_ACCESSORIES').value ;
        var rv = BusinessUnit.addLawUser(lawUserVo);
        if(rv){
            alert("����������Ϣʧ�ܣ�");
            userId = "" ;
        }else{
            alert("����������Ϣ�ɹ���");
        }
    }
       
}

//�޸�ִ����Ա
function updLawUsre(){
        if(validate()){
            var obj = new xzcf.vo.LawUser();
            var LawUserVo= DBUtil.getVoFromPage(obj);
            userId =$("USER_ID").value ;
            LawUserVo.USER_ID = userId ;
            var rv = BusinessUnit.updateLawUsre(LawUserVo);
            if(rv){
                alert("����������Ϣ�ɹ�");
            }else{
                alert("����������Ϣʧ��");
            }  
        }
}

//�����ϴ���ť����
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('ELU_ACCESSORIES').value;
    if(IsSpace(id)){
        id = DBUtil.getSeq('SEQ_LITIGANT_RD');
        $('ELU_ACCESSORIES').value = id;
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


//��֤���� 
function validate() {
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'USER_ID'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'USER_ID'}.value]},
            MESSAGE : "��������Ϊ��"
        }, true);
    }
    if (flag) {
        if($("BU_ID").value==-1){
            alert("ִ�����岻��Ϊ��");
            flag = false ;
        }
    }
    
     if (flag) {
        if($("BWT_ID").value==-1){
            alert("ִ�������Ϊ��");
            flag = false ;
        }    
    }
 
    if (flag) {
        flag = SValidator.validate(${'ELU_DOCUMENT_NO'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_DOCUMENT_NO'}.value]},
            MESSAGE : "֤����Ų���Ϊ��"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("ELU_DOCUMENT_NO").value)){
            flag = false;
            alert("֤����Ų��ܰ������֣�");
        }            
    }

    if (flag) {
        flag = SValidator.validate(${'ELU_DOCUMENT_NO'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "֤���������ܳ���{0}�ַ�"
        }, true);
    }
    
    if(flag){
        flag = validateNum();
        if(!flag){
            alert("֤����Ų����ظ�����������д");
            flag = false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_LICENCE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_LICENCE'}.value]},
            MESSAGE : "��֤���ز���Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_LICENCE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [200],maxlength : 200},
            MESSAGE : "��֤��������ܳ���{0}�ַ�"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_CERTIFICATION_DATE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'ELU_CERTIFICATION_DATE'}.value]},
            MESSAGE : "��֤���ڲ���Ϊ��"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'ELU_CERTIFICATION_DATE'}.value, {
            CHECK_TYPE : "date",
            ARGUMENT : {placeholders : ["��֤����"]}
        }, true);
    }
    
    if(flag){
        if(!IsSpace($("ELU_END_DATE").value)){
            //ʧЧ���ڱ�����ڷ�֤����
            if(${'ELU_END_DATE'}.value >= ${'ELU_CERTIFICATION_DATE'}.value){
                flag = true;
            }else{
                alert("ʧЧ���ڱ�����ڷ�֤����");
                flag = false ;
            }
        }
    }
    
    return flag ;
}

//�����Ƿ����ù�
function validateName(){
    var uId = $("USER_ID").value ;
    var flag = true;
    var vr = BusinessUnit.findByUserId(uId);
    if(IsSpace(vr)){
        flag = true ;
    }else{
        flag = false ;
    }
    return flag ;
}

//֤�������Ψһ��
function validateNum(){
    var flag = true ;
    var num = $("ELU_DOCUMENT_NO").value ;
    var userId = $("USER_ID").value ;
    var vr = BusinessUnit.findByELU_DOCUMENT_NO(num,userId);
    if(vr>0){
        flag = false ;
    }else{
        flag = true ;
    }
    return flag ;
}

function closeWindows() {
    window.close();
}

//��ƽ̨��Ա��ѡ��
function openUserTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgUserPermissionTree.jsp?org_id="+orgId;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}


//��ִ�������ѡ��
function openOrgTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><radio><id>ELU_STATUS</id></radio><combobox><id>BWT_ID</id></combobox><button><id>button1</id><id>button2</id><id>button3</id></button><text><id>USER_NAME</id><id>USER_ID</id><id>BU_NAME</id><id>orgIds</id><id>orgNames</id><id>BU_ID</id><id>ELU_DOCUMENT_NO</id><id>ELU_LICENCE</id><id>ELU_CERTIFICATION_DATE</id><id>ELU_END_DATE</id><id>ELU_ACCESSORIES</id></text><dataset><id>addLawUserDateset</id></dataset></root>" billtaborder="<root><taborder>ELU_DOCUMENT_NO</taborder><taborder>ELU_LICENCE</taborder><taborder>ELU_CERTIFICATION_DATE</taborder><taborder>ELU_END_DATE</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>USER_NAME</taborder><taborder>USER_ID</taborder><taborder>BWT_ID</taborder><taborder>button1</taborder><taborder>ELU_ACCESSORIES</taborder><taborder>ELU_STATUS</taborder><taborder>BU_NAME</taborder><taborder>orgIds</taborder><taborder>orgNames</taborder><taborder>BU_ID</taborder></root>" dj_sn="20100902194102000659" caption="�������޸�ִ����Ա" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:0;combobox:6;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:13;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:8;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=CF_BB colSpan=4 VALUE=""></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=USER_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="user_realname" china="��ʵ����" dataset="addLawUserDateset" onclick='bill_onclick("openUserTree()")'><INPUT id=USER_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 39px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=3 controltype="text" field="USER_ID" china="ִ����Ա���" dataset="addLawUserDateset"></TD>
                     <TD class=c2 width="15%">ִ������<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%" height=25>ִ�����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=BWT_ID style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=select2 sqltrans="%F4%D8%E6%D8%D4%F6Xrn%92%BC%B6%CC%A0%96Xr%94%92%BC%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%92%B8%B4%A0%AA%98%B4%B4%CC%B6%C0%AE%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%92%BC%B6%CC%A0%96" controltype="combobox" field="BWT_ID" china="ִ�����" dataset="addLawUserDateset" tempvalue="-1" temptext="---��ѡ��---" sql check="1"><OPTION value=-1 selected>---��ѡ��---</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">֤�����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=ELU_DOCUMENT_NO style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=33 name=Input2 controltype="text" field="ELU_DOCUMENT_NO" china="ִ�����" dataset="addLawUserDateset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��֤����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=ELU_LICENCE style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=33 name=Input3 controltype="text" field="ELU_LICENCE" china="��֤����" dataset="addLawUserDateset"></TD>
                     <TD class=c2 width="15%">��֤����<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=its_out id=ELU_CERTIFICATION_DATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly size=33 name=Input4 controltype="text" field="ELU_CERTIFICATION_DATE" china="��֤����" dataset="addLawUserDateset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ʧЧ����</TD>
                     <TD width="35%"><INPUT class=its_out id=ELU_END_DATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly size=33 name=Input5 controltype="text" field="ELU_END_DATE" china="ʧЧ����" dataset="addLawUserDateset" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 width="15%">�Ƿ���Ч<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><FIELDSET id=ELU_STATUS contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 16px" onmovestart=moveStart() controltype="radio" field="ELU_STATUS" china="״̬" dataset="addLawUserDateset" tempvalue="1&#13;&#10;0" temptext="��Ч&#13;&#10;��Ч" aspect="����" legend NotBg="��" value="1"><INPUT type=radio CHECKED value=1 name=RGELU_STATUS text="��Ч"><SPAN onclick=RGELU_STATUS[0].checked=true;ELU_STATUS.value=RGELU_STATUS[0].value;RGELU_STATUS[0].focus();>��Ч</SPAN>&nbsp;<INPUT type=radio value=0 name=RGELU_STATUS text="��Ч"><SPAN onclick=RGELU_STATUS[1].checked=true;ELU_STATUS.value=RGELU_STATUS[1].value;RGELU_STATUS[1].focus();>��Ч</SPAN>&nbsp;</FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">֤������</TD>
                     <TD colSpan=3><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>�����ϴ�</BUTTON><INPUT id=ELU_ACCESSORIES style="DISPLAY: none; LEFT: 0px; WIDTH: 55px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" field="ELU_ACCESSORIES" china="֤������" dataset="addLawUserDateset"></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <TR>
               <TD align=middle><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("addOrUpdLawUser()")'>����</BUTTON><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("CloseBill()")'>�ر�</BUTTON></TD>
            </TR>
            <TR>
               <TD>
                  <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
                     <TBODY>
                        <TR>
                           <TD>&nbsp;</TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </TD>
            </TR>
         </TBODY>
      </TABLE>
      <?xml:namespace prefix = fc />
      <fc:dataset id=addLawUserDateset showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkBox</fieldname><datatype>�ַ�</datatype><displaylabel>ѡ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>�ַ�</datatype><displaylabel>֤�����</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>�ַ�</datatype><displaylabel>��֤����</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ�����</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>����</datatype><displaylabel>��֤����</displaylabel><size>7</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>����</datatype><displaylabel>ʧЧ����</displaylabel><size>7</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>�ַ�</datatype><displaylabel>״̬</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_ACCESSORIES</fieldname><datatype>ͼ��</datatype><displaylabel>֤������</displaylabel><size>4000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_ORDER</fieldname><datatype>�ַ�</datatype><displaylabel>���</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����Ա���</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>user_realname</fieldname><datatype>�ַ�</datatype><displaylabel>��ʵ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkBox></checkBox><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><ELU_ACCESSORIES></ELU_ACCESSORIES><ELU_ORDER></ELU_ORDER><BU_ID></BU_ID><USER_ID></USER_ID><USER_NAME></USER_NAME><user_realname></user_realname></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
   </DIV>
<div id='grid_tip'></div></body></html>
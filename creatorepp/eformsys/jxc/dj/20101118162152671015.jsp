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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js'></script>");
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
var rflId = creator_getQueryString("rflId");
var buId = creator_getQueryString("buId");
var buName = creator_getQueryString("buName");
var piId = creator_getQueryString("piId");
var piName = creator_getQueryString("piName");
var USER_ID = getSysElement("userid");
var word_id =0;
var wsNameBe = "";

function init(){
    document.getElementById("zfztName").innerHTML = buName;
    if (IsSpace(rflId)) {
        rflId = 0;
        $("DOA_ID").value = -1;
    } else {
        var sql = PunishInsConfig.queryById(rflId);
        wsSaveDataset.Open(sql);
        document.getElementById("formTitleId").innerHTML = "�޸�����";
        word_id = wsSaveDataset.Fields.Field['MB_ID'].Value;
        wsNameBe = wsSaveDataset.Fields.Field['RFL_NAME'].Value;
    }
    var tableObj = document.getElementById("stageTable");
    var sqlArray = PunishInsConfig.getIssueStage(rflId);
    for (var i = 0; i < sqlArray.length; i++) {
        var rowObj = tableObj.insertRow();//����һ��
         var cell0 = rowObj.insertCell();//����һ����Ԫ
         cell0.innerHTML = sqlArray[i][1];
        
        var cell1 = rowObj.insertCell();//����һ����Ԫ
         var readTmp ;
        if (rflId==0) {
            readTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISREAD' CHECKED VALUE='"+sqlArray[i][0]+"'>");
        } else {
            if (sqlArray[i][3]=="0") {
                readTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISREAD' CHECKED VALUE='"+sqlArray[i][0]+"'>");
            } else {
                readTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISREAD' VALUE='"+sqlArray[i][0]+"'>");
            }
        }
        cell1.appendChild(readTmp);
         
        var cell2 = rowObj.insertCell();//����һ����Ԫ
         var editTmp ;
        if (rflId==0) {
            editTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISEDIT' VALUE='"+sqlArray[i][0]+"'>");
        } else {
            if (sqlArray[i][3]=="1") {
                editTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISEDIT' CHECKED VALUE='"+sqlArray[i][0]+"'>");
            } else {
                editTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISEDIT' VALUE='"+sqlArray[i][0]+"'>");
            }
        }
        cell2.appendChild(editTmp);
         
        var cell3 = rowObj.insertCell();//����һ����Ԫ
         var isValid ;
        if (rflId==0) {
            isValid = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISVALID' CHECKED VALUE='"+sqlArray[i][0]+"'>");
        } else {
            if (sqlArray[i][2]!="0") {
                isValid = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISVALID' CHECKED VALUE='"+sqlArray[i][0]+"'>");
            } else {
                isValid = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISVALID' VALUE='"+sqlArray[i][0]+"'>");
            }
        }
        cell3.appendChild(isValid);
    }
    if (!IsSpace(piId)&&piId!=0) {
        $("PI_ID").value = piId;
        $("PI_NAME").value = piName;
        document.getElementById("isConfig").style.display = "none";
        var confType = document.getElementsByName("CONFIG_TYPE");
        confType[2].checked=true;
        $("PI_NAME").disabled = true;
    } else {
        document.getElementById("issueNeed").style.display = "none";
        document.getElementById("stageTable").style.display="none";
    }
}

//��������
function piLoad(){
    if (!IsSpace(buName)) {
        var tempPara="dialogWidth:760px;dialogHeight:400px;";
        var tempURL="20101013144720390036.jsp?USER_ID="+USER_ID+"&BU_ID="+buId;
        var rtn = showModalDialog(tempURL,window,tempPara);
        if (!IsSpace(rtn)) {
            document.getElementById("PI_NAME").value = rtn.names;
            document.getElementById("PI_ID").value = rtn.ids; 
        }
    } else {
        alert("��ǰ����ִ������!");
        return false;
    }
}


//���÷�ʽ
function showCom(){
    var conf = document.getElementsByName("CONFIG_TYPE");
    if (conf[0].checked) {
        document.getElementById("stageTable").style.display="none";
    } else {
        document.getElementById("stageTable").style.display="";
    }
    if (conf[2].checked) {    
        document.getElementById("issueNeed").style.display = "";
    } else {    
        document.getElementById("issueNeed").style.display = "none";
    }
}

//����
function rtnBack(){
    history.back(-1);
}

//ѡ������
function wordSel(){
    var tempPara="dialogWidth:760px;dialogHeight:400px;";
    var tempURL="20101209094954046862.jsp?mb_id="+word_id;
    var wordObj = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(wordObj)) {
        word_id = wordObj.mb_id;
        $("MB_NAME").value = wordObj.mb_name;        
    }    
}

//Ԥ��word�ĵ�
function preMb() {
    var url = "../../../eformsys/jxc/dj/20101124143257625133.jsp?mb_id="+word_id;
    url = url + "&wft_id=2806&ndp_id=8&ltt_id=1507,1508,1509&RFL_ID="+rflId;
    var height = window.screen.availHeight;
    var width = window.screen.availWidth;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
    //window.open(url,'newwindow','height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no')
}

function validate(){
    var conf = document.getElementsByName("CONFIG_TYPE");//���÷�ʽ
     var flag = true;
    if (flag) {
        flag = SValidator.validate($("RFL_NAME").value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$("RFL_NAME").value]},
            MESSAGE : "�������Ʋ���Ϊ��!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate($("RFL_NAME").value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [50],maxlength : 50},
            MESSAGE : "������������ܳ���{0}�ַ�!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate($("RFL_BRIEF_NAME").value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$("RFL_BRIEF_NAME").value]},
            MESSAGE : "�����Ʋ���Ϊ��!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate($("RFL_BRIEF_NAME").value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [50],maxlength : 50},
            MESSAGE : "����������ܳ���{0}�ַ�!"
        }, true);
    }
    if (flag) {
        if(word_id==0){
            alert("��ѡ��WORDģ��!");
            flag = false;
        }    
    }
    if (flag) {
        if($("DOA_ID").value==-1){
            alert("��ѡ���ĵ���������!");
            flag = false;
        }    
    }
    if (conf[2].checked) {
        if (flag) {
            flag = SValidator.validate($("PI_NAME").value, {
                CHECK_TYPE : "required",
                ARGUMENT : {placeholders : [$("PI_NAME").value]},
                MESSAGE : "���������Ϊ��!"
            }, true);
        }
        var validTmp = document.getElementsByName("ISVALID");
        var flag = false;
        for (var i=0;i<validTmp.length;i++) {
            if (validTmp[i].checked) {
                flag = true;
                break;
            }
        }
        if (!flag) {
            alert("�뽫Ҫ��Ч���������Ϊ��Ч");
        }
    }
    return flag;
}

//����
function save(){
    $("RFL_NAME").value = $("RFL_NAME").value.trim();
    $("RFL_BRIEF_NAME").value = $("RFL_BRIEF_NAME").value.trim();
    if (validate()) {
        var num = PunishInsConfig.queryQuoteRflAndName($("RFL_NAME").value, buId, rflId);
        if (num>0) {
            alert("�����������Ѵ��ڣ�����������!");
            return false;
        }
        var flag = 0;
        if (wsNameBe!="" && wsNameBe!=$("RFL_NAME").value) {
            var n = PunishInsConfig.queryQuoteRfl(rflId);
            if (n>1) {
                if (!confirm("�����鱻����������ã��Ƿ񽫸ò���Ӧ�õ��������õ����")) {
                    if (confirm("�Ƿ���������һ��������Ϣ��")) {
                        flag = 1;
                    } else {
                        return false;
                    }
                }
            }
        }
        var obj = new PunishInsConfigVo.PunishInsConfig();
        var vo = DBUtil.getVoFromPage(obj);
        vo.RFL_ID = rflId;
        vo.BU_ID = buId;
        var release = document.getElementsByName("IS_RELEASE");
        if (release[0].checked) {
            vo.RFL_ISRELEASE_DOCUMENT=1;
        } else {
            vo.RFL_ISRELEASE_DOCUMENT=0;
        }
        var status = document.getElementsByName("IS_STATUS");
        if (status[0].checked) {
            vo.RFL_STATUS=1;
        } else {
            vo.RFL_STATUS=0;
        }
        var confType = document.getElementsByName("CONFIG_TYPE");
        var arr = new Array();
        if (confType[0].checked) {
            vo.CONF_TYPE=0;
        } else if (confType[1].checked) {
            vo.CONF_TYPE=1;
            arr = stageConfig();
        } else {
            vo.CONF_TYPE=2;
            arr = stageConfig();
        }
        vo.MB_ID = word_id;
        var rv ;
        if (flag!=1) {
            rv = PunishInsConfig.savePunishConfig(vo, arr);
        } else {
            rv = PunishInsConfig.newPunishConfig(vo, arr);
        }
        if (rv) {
            alert("����������Ϣ�ɹ���");
            rflId = vo.RFL_ID;
            wsNameBe = $("RFL_NAME").value.trim();
        } else {
            alert("����������Ϣʧ�ܣ�");
        }
    }
}

//��ȡ�׶�����
function stageConfig(){
    var validTmp = document.getElementsByName("ISVALID");
    var editTmp = document.getElementsByName("ISEDIT");
    var list = new Array();
    var k = 0;
    var str = "";
    for (var i=0;i<validTmp.length;i++) {
        if (validTmp[i].checked) {
            k =0 ;
            if (editTmp[i].checked) {
                k = 1; 
            }
            str = validTmp[i].value + "_" + k;
            list.add(str);
        }
    }
    return list;
} 
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><combobox><id>DOA_ID</id></combobox><button><id>selWord</id><id>preView</id><id>saveBtn</id><id>clsBtn</id></button><text><id>RFL_NAME</id><id>RFL_BRIEF_NAME</id><id>MB_NAME</id><id>PI_NAME</id><id>PI_ID</id></text><dataset><id>wsSaveDataset</id></dataset></root>" billtaborder="<root><taborder>RFL_NAME</taborder><taborder>RFL_BRIEF_NAME</taborder><taborder>preView</taborder><taborder>saveBtn</taborder><taborder>clsBtn</taborder><taborder>PI_NAME</taborder><taborder>PI_ID</taborder><taborder>selWord</taborder><taborder>MB_NAME</taborder><taborder>DOA_ID</taborder></root>" dj_sn="20101118162152671015" caption="��������" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101117093013703020" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInsConfig.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js">

<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=formTitleId colSpan=4>��������</TD>
                  </TR>
                  <TR>
                     <TD class=c2>ִ������</TD>
                     <TD><SPAN id=zfztName></SPAN>&nbsp;</TD>
                  </TR>
                  <TR>
                     <TD class=c2>��������<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=RFL_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=54 controltype="text" field="RFL_NAME" china="��������" dataset="wsSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>������<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=RFL_BRIEF_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=54 controltype="text" field="RFL_BRIEF_NAME" china="������" dataset="wsSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>ѡ������ģ��<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=MB_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="MB_MC" china="ģ������" dataset="wsSaveDataset"><BUTTON id=selWord style="LEFT: 0px; WIDTH: 106px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("wordSel()")'>ѡ��Wordģ��</BUTTON><BUTTON id=preView style="LEFT: 0px; WIDTH: 84px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("preMb()")'>Ԥ��</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD class=c2>�ĵ���������<FONT color=red>*</FONT></TD>
                     <TD><SELECT id=DOA_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%96%AC%90%CC%A0%96Xr%94%96%AC%90%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%96%AC%94%CC%AC%AE%98%B2%90%B6%A0%AC%AA%CC%90%B6%B6%B2%A0" controltype="combobox" field="DOA_ID" china="�ĵ�����ID" dataset="wsSaveDataset" tempvalue="-1" temptext="--��ѡ��--" sql check="1"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                  </TR>
                  <TR id=isRealse>
                     <TD class=c2>�Ƿ񷢲�</TD>
                     <TD><INPUT type=radio CHECKED value=1 name=IS_RELEASE>��<INPUT type=radio value=0 name=IS_RELEASE>��</TD>
                  </TR>
                  <TR>
                     <TD class=c2>�Ƿ�����</TD>
                     <TD colSpan=3><INPUT type=radio CHECKED value=1 name=IS_STATUS>��<INPUT type=radio value=0 name=IS_STATUS>��</TD>
                  </TR>
                  <TR id=isConfig>
                     <TD class=c2>���÷�ʽ</TD>
                     <TD><SPAN id=com0><INPUT onclick=showCom() type=radio CHECKED value=0 name=CONFIG_TYPE>���鶨��</SPAN><SPAN id=com1><INPUT onclick=showCom() type=radio value=1 name=CONFIG_TYPE>�׶�����</SPAN><SPAN id=com2><INPUT onclick=showCom() type=radio value=2 name=CONFIG_TYPE>������׶�����</SPAN></TD>
                  </TR>
                  <TR id=issueNeed>
                     <TD class=c2>��������</TD>
                     <TD><INPUT class=input_out id=PI_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" onclick='bill_onclick("piLoad()")'><INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 38px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <?xml:namespace prefix = fc />
            <fc:dataset id=wsSaveDataset format="<fields><field><fieldname>MB_ID</fieldname><datatype>�ַ�</datatype><displaylabel>wordģ��ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_BRIEF_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_STATUS</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DOA_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�ĵ�����ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MB_MC</fieldname><datatype>�ַ�</datatype><displaylabel>ģ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_ISRELEASE_DOCUMENT</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ񷢲�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' onValid='bill_ondatasetvalid("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable id=stageTable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=c2>��������</TD>
                     <TD class=c2>ֻ��</TD>
                     <TD class=c2>�༭</TD>
                     <TD class=c2>�Ƿ���Ч</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle colSpan=4><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("save()")'>����</BUTTON><BUTTON class=button id=clsBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("rtnBack()")'>����</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
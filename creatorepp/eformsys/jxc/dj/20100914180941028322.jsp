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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js'></script>");
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
var tp_Statue;//״̬(�ݴ棬�ύ)
//var bu_id=creator_getQueryString("bu_id"); //ִ������ID
var bu_id = parent.bu_id;
var bu_name;//ִ����������
//��ȡ����ID
var wft_id = creator_getQueryString("wft_id");

//��ȡ��ʾ״̬
var readOnlyFlag = creator_getQueryString("readOnlyFlag");

//�Ӽ��׳���Tab�������ı���
//var thisOneCaseType = creator_getQueryString("thisOneCaseType");
var thisOneCaseType = parent.thisOneCaseType;
//��ȡ��ǰ�û�
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

//��ѯִ������ID��ִ����������
function findBuIdAndBuName(){
    var sql = EndCase.findBuIdAndBuName(user_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    return arr;
}

//��ȡ�ô�������ʵ������ע״̬
function findPostilStatus(){
    var ndp_id = "(5)";//�᰸�鵵�׶�
    var sql = EndCase.findOpinionInfo(wft_id, ndp_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        return "";
    } else {
        return arr[0][3];
    }
}

//��ʼ��
function init(){
    HTMLUtil.readOnly($("WFT_END_DATE"),"commonReadOnly");
    HTMLUtil.readOnly($("WFT_DATE_RETURN_RECEIVE"),"commonReadOnly");
    HTMLUtil.readOnly($("WFT_BRIEF"),"commonReadOnly");
    HTMLUtil.readOnly($("process_status"),"commonReadOnly");
    HTMLUtil.readOnly($("execute_status"),"commonReadOnly");
    if(IsSpace(findPostilStatus())){//����
       $('end_time').style.display = "none";//���ذ참����ʱ��
        $('end_time_value').style.display = "none";
       findCaseInfo();//��ѯ����������Ϣ
       if(Number(thisOneCaseType) == 2){//�Ӽ��׳������
           $('CL_id').style.display = "none";
         $('ZX_id').style.display = "none";
       } else {
          findOpinionInfo();//��ѯ���⴦��������͡��������顱       
       }
       
    } else if(findPostilStatus() == 0){
       $('end_time').style.display = "none";//���ذ참����ʱ��
        $('end_time_value').style.display = "none";
       findCaseInfo();//��ѯ����������Ϣ
        if(Number(thisOneCaseType) == 2){//�Ӽ��׳������
           $('CL_id').style.display = "none";
          $('ZX_id').style.display = "none";
       } else {
           findOpinionInfo();//��ѯ���⴦��������͡��������顱
       }
       findEndCaseInfo();//��ѯ"�᰸���"��"�᰸��Ա"
    } else {//ֻ��
       $('tempTD').style.display = "none";//���հ�TD����
        findAllEndCaseInfo();
       if(Number(thisOneCaseType) == 2){//�Ӽ��׳������
            $('CL_id').style.display = "none";
          $('ZX_id').style.display = "none";
       } else {
           findOpinionInfo();//��ѯ���⴦��������͡��������顱
       }
        findEndCaseInfo();//��ѯ"�᰸���"��"�᰸��Ա"
       $('saveNow').style.display = "none";
       $('saveAndGo').style.display = "none";
       HTMLUtil.readOnly($("endCaseOpinion"),"commonReadOnly");
       HTMLUtil.readOnly($("endCaseMen"),"commonReadOnly"); 
 //      document.getElementById("endCaseImg").style.display = "none";
    }
}

//��ѯ����������Ϣ,δ�ύ
function findCaseInfo(){
    var sql = EndCase.findCaseInfo(wft_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    ${'WFT_DATE_RETURN_RECEIVE'}.value = arr[0][0];
    ${'WFT_BRIEF'}.value = arr[0][1];
}

//��ѯ����������Ϣ,���ύ
function findAllEndCaseInfo(){
    var sql = EndCase.findAllEndCaseInfo(wft_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    ${'WFT_DATE_RETURN_RECEIVE'}.value = arr[0][0];
    ${'WFT_END_DATE'}.value = arr[0][1];
    ${'WFT_BRIEF'}.value = arr[0][2];
}

//��ѯ���⴦��������͡��������顱
function findOpinionInfo(){
    var ndp_id1 = "(7)";
     var sql1 = EndCase.findOpinionInfo(wft_id, ndp_id1);
     var arr1 = DBUtil.getQueryArray(sql1, 0, -1);
     if(!IsSpace(arr1)){
         ${'process_status'}.value = arr1[0][0];    
     } 
     var ndp_id2 = "(4)";
     var sql2 = EndCase.findOpinionInfo(wft_id, ndp_id2);
    var arr2 = DBUtil.getQueryArray(sql2, 0, -1);
     if(!IsSpace(arr2)){
         ${'execute_status'}.value = arr2[0][0];
     } 
}

//�����᰸�鵵��Ϣ
function saveEndCaseInfo(tp_Statue){
    var vo = new EndCaseVo.EndCase();
    vo.WFT_ID = wft_id;
    vo.NDP_ID = 5;//�᰸�鵵�׶�
    vo.TP_STATUS = tp_Statue;//״̬(�ݴ棬�ύ)
    vo.TP_EMY = user_id; //��ע���ǵ�ǰ�û�
    vo.ISPLATFORM = 0;//����ƽ̨���
    var arr = findBuIdAndBuName();
    vo.SU_ID_INNER = arr[0][0];  //ҵ��λ����
    vo.TP_SYSUNIT_NAME = arr[0][1];   //ִ������
    vo.WORKFLOW_NAME = "�᰸�鵵";
    vo.TP_INFO = 0;  //���ǲ�������
    vo.TP_POSTIL = ${'endCaseOpinion'}.value.trim();//�᰸���
    //��ע����(����ִ����Ա������ִ����ԱID�š�ִ����Ա��������)
    var endCaseMen = $('endCaseMen').value;
    var endMenId = $('endMenId').value;
    vo.TP_EMY_SET = endCaseMen;
    vo.TP_EMY_ID = endMenId;
    var currentDate = getNowTime();//��ǰϵͳʱ��   
    var rv = EndCase.insertOpinionInfo(vo, currentDate);
    if(rv){
        if (tp_Statue==0) {
            alert("����ɹ���");
            return true;
        } else {
            alert("�ύ������Ϣ�ɹ���");
            return true;
        }
    } else {
        if (tp_Statue==0) {
            alert("����ʧ�ܣ�");
            return false;
        } else {
            alert("�ύ������Ϣʧ�ܣ�");
            return false;
        }
    }
    if(tp_Statue == 1){
        $('WFT_END_DATE').value = currentDate;
    }
}

//�鿴�᰸�鵵��Ϣ
function findEndCaseInfo(){
     var ndp_id = "(5)";
     var sql = EndCase.findOpinionInfo(wft_id, ndp_id);
     var arr = DBUtil.getQueryArray(sql, 0, -1);
     $('endCaseOpinion').value = arr[0][0];
     $('endCaseMen').value = arr[0][2]; 
     $('endMenId').value = arr[0][1];
}

//�ݴ�
function savenow(){
    if(!validate()){
        return;
    } else {
        saveEndCaseInfo(0);  //����
    }
}

//�ύ
function savego(){
    if (confirm("ȷ�Ͻ���������?")) {
        if(!validate()){
            return;
        } else {
            var flag = saveEndCaseInfo(1);//����
             if (flag) {
                HTMLUtil.readOnly($("endCaseOpinion"),"commonReadOnly");
                HTMLUtil.readOnly($("endCaseMen"),"commonReadOnly");
                $('saveNow').style.display = "none";
                $('saveAndGo').style.display = "none";
                if(Number(thisOneCaseType) == 2){//���׳���
                    parent.window.location.href = "20100916091232930767.jsp";//���׳����ѯ�б�
                  } else {//һ�����
                    parent.window.location.href = "20100929153136375631.jsp";//һ���������б�
                }
            }
        }
    }
}

function closeZheWindow(){
    if(Number(thisOneCaseType) == 2){//���׳���
        parent.window.location.href = "20100916091232930767.jsp";//���׳����ѯ�б�
    } else {//һ�����
        parent.window.location.href = "20100929153136375631.jsp";//һ���������б�
    }
}

//������֤
function validate(){
    var flag = true;
    //��֤�᰸����Ƿ���д
    if(flag){
        flag = SValidator.validate(${'endCaseOpinion'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["�᰸���"]}
        }, true);
    }
    //��֤�᰸��Ա�Ƿ���д
    if(flag){
        flag = SValidator.validate(${'endCaseMen'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["�᰸��Ա"]}
        }, true);
    }
    return flag;
}

//�򿪽᰸��Ա��ѡ��
function openSignTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgUserTree.jsp?bu_id="+bu_id;
    $("userIds").value = $("endMenId").value;
    $("userNames").value = $("endCaseMen").value;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("endMenId").value = $("userIds").value;
    $("endCaseMen").value = $("userNames").value;

}

//��ȡ��ǰ������ʱ��
function getNowTime(){
    var nowYear = FormUtil.getServerYear();//��ȡ��ǰ��������
    var nowMonth = FormUtil.getServerMonth();//��ȡ��ǰ��������
    var nowDay = FormUtil.getServerDay();//��ȡ��ǰ��������
    if(parseInt(nowMonth) < 10){
        nowMonth = "0" + nowMonth;
    }
    if(parseInt(nowDay) < 10){
        nowDay = "0" + nowDay;
    }
    var nowDate = nowYear + "-" + nowMonth + "-" + nowDay;
    return nowDate;
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>WFT_BRIEF</id><id>process_status</id><id>execute_status</id><id>endCaseOpinion</id></textarea><button><id>saveNow</id><id>saveAndGo</id><id>goback</id></button><text><id>WFT_DATE_RETURN_RECEIVE</id><id>WFT_END_DATE</id><id>endCaseMen</id><id>userIds</id><id>userNames</id><id>endMenId</id></text><dataset><id>dataset</id></dataset></root>" billtaborder="<root><taborder>WFT_BRIEF</taborder><taborder>process_status</taborder><taborder>execute_status</taborder><taborder>endCaseOpinion</taborder><taborder>WFT_DATE_RETURN_RECEIVE</taborder><taborder>WFT_END_DATE</taborder><taborder>endCaseMen</taborder><taborder>endMenId</taborder><taborder>saveNow</taborder><taborder>saveAndGo</taborder><taborder>goback</taborder><taborder>userIds</taborder><taborder>userNames</taborder></root>" dj_sn="20100914180941028322" caption="�᰸�鵵" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:4;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:1;tab:0;div:0;DsMain_field:0;a:0;button:6;text:8;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/EndCaseVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EndCase.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EndCaseDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>�᰸�鵵</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">�참��ʼʱ��</TD>
                     <TD id=start_time width="35%"><INPUT class=input_out id=WFT_DATE_RETURN_RECEIVE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=c2 id=end_time width="15%">�참����ʱ��</TD>
                     <TD id=end_time_value width="35%"><INPUT class=input_out id=WFT_END_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD id=tempTD width="50%"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��Ҫ����</TD>
                     <TD colSpan=3><TEXTAREA id=WFT_BRIEF style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR id=CL_id>
                     <TD class=c2 width="15%">�������</TD>
                     <TD colSpan=3><TEXTAREA id=process_status style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea2" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR id=ZX_id>
                     <TD class=c2 width="15%">ִ�����</TD>
                     <TD colSpan=3><TEXTAREA id=execute_status style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea3" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">�᰸���<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=endCaseOpinion style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea4" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">�᰸��Ա<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><INPUT class=input_image id=endCaseMen style="LEFT: 0px; WIDTH: 39%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openSignTree()")'><INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 35px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"><INPUT id=userNames style="DISPLAY: none; LEFT: 0px; WIDTH: 39px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=saveNow style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("savenow()")'>�ݴ�</BUTTON><BUTTON class=button id=saveAndGo style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("savego()")'>�ύ</BUTTON><BUTTON class=button id=goback style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("closeZheWindow()")'>����</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD>&nbsp;<INPUT id=endMenId style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset format="<fields><field><fieldname>WFT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>�ַ�</datatype><displaylabel>�참��ʼʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_END_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>�참����ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BRIEF</fieldname><datatype>�ַ�</datatype><displaylabel>��Ҫ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_POSTIL</fieldname><datatype>�ַ�</datatype><displaylabel>���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_EMY_SET</fieldname><datatype>�ַ�</datatype><displaylabel>�᰸��Ա</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_END_DATE></WFT_END_DATE><WFT_BRIEF></WFT_BRIEF><TP_POSTIL></TP_POSTIL><TP_EMY_SET></TP_EMY_SET><BU_ID></BU_ID><BU_NAME></BU_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_END_DATE></WFT_END_DATE><WFT_BRIEF></WFT_BRIEF><TP_POSTIL></TP_POSTIL><TP_EMY_SET></TP_EMY_SET><BU_ID></BU_ID><BU_NAME></BU_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_END_DATE></WFT_END_DATE><WFT_BRIEF></WFT_BRIEF><TP_POSTIL></TP_POSTIL><TP_EMY_SET></TP_EMY_SET><BU_ID></BU_ID><BU_NAME></BU_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var readOnlyFlag = creator_getQueryString("readOnlyFlag");
//��ȡ��������ʵ�����
var wftId=creator_getQueryString("WFT_ID");
if(IsSpace(wftId)){
    wftId = 829 ;
}
//��ȡ������
var PiId=creator_getQueryString("PI_ID");
if(IsSpace(PiId)){
    PiId = 542 ;
}
//��ȡ�׶α��
var NdpId=creator_getQueryString("NDP_ID");
if(IsSpace(NdpId)){
    NdpId = 2 ;
}
//�ĵ�״̬0Ϊ�ݸ壬1Ϊ�浵
var wdzt = "";
var buId = "";
var buName = "";
/**
*˵������ʼ��
*������init
*ҵ���߼���
*1�����ݰ���ID�ͽ׶�ID���������Ϣ cf_AjClick(id,nodeId)
*ע����ҳ�ṩ�ĳ�ʼ��������Ϣ�ӿ�
*2������Υ����ΪID��һ�㴦������ID�����ύ�ĵ��嵥�Լ������ĵ�getFileList()
*/
function init(){
    var sql = LajdBiz.findLajdInfoBiz(wftId);
    lajdInfoDataset.Open(sql);
    var fnCode = lajdInfoDataset.Fields.Field["fnCode"].Value;//��������
    var tmp = document.getElementsByName('radiobutton');
    for(var i = 0 ; i<tmp.length ; i++){
        if(tmp[i].value==fnCode){
            tmp[i].checked=true ;
            break;
        }
    }
    if (tmp[2].checked) {
        showOrHiddenYS();
    }
    //����ִ�������ţ���ִ����������
    var sql1 = LajdBiz.findZfjtBhAndMcBiz(wftId);
    findZfjtDataset.Open(sql1);
    //��ȡִ�������ţ���ִ����������
     buId = findZfjtDataset.Fields.Field["bu_id"].Value;//ִ��������
     buName = findZfjtDataset.Fields.Field["bu_name"].Value;//ִ����������
     initHiddenLazd();
}

//�����ύǰ����ȥ�ո���
function validateValue(){
    $("BN_IBUSINESS_NUMBER").value = $("BN_IBUSINESS_NUMBER").value.trim();
    $("TP_POSTIL").value = $("TP_POSTIL").value.trim();
}
/**
*˵�����ύ
*������submitLA
*ҵ���߼�����ť��ʾ������ɹ����� 
*/
function submitLA(wdzt){
    if (wdzt==1) {
        if (!confirm("ȷ�Ͻ������׶�?")) {    
            return false;
        }
    }
    validateValue();
    if(validate()){
        var labh = $("BN_IBUSINESS_NUMBER").value.trim() ;//�������
         var lasj = $("WFT_PLACED_ON_FILE_TIME").value.trim() ;//����ʱ��
         var zfry = $("userNames").value.trim() ; //ִ����Ա
         var zfryId = $("userIds").value;//ִ����ԱID
         var spyj = $("TP_POSTIL").value.trim() ; //�������
         //��ȡ�������ֵ
         var tmp = document.getElementsByName('radiobutton');
        //�����������󣬷ֱ�Ϊ��������ʵ������ע����������������׶Σ�������װ����ֵ
         var cfsxslVo = new LajdVo.WorkFlowTicket() ; //��������ʵ����
         var pzVo = new LajdVo.Postil() ; //��ע��
         var lxsxjdVo = new LajdVo.FlowDirectionParaNdp() ; //��������������׶���
         //��������ʵ�����ݵķ�װ
         cfsxslVo.WFT_BUSINESS_NUMBER = labh ; //�������
         cfsxslVo.WFT_PLACED_ON_FILE_TIME = lasj ; //����ʱ��
         cfsxslVo.WFT_ID = wftId ; //��������ʵ�����
         cfsxslVo.WORKFLOW_NAME = "����ȡ֤" ; //��������ʵ�����
         
         //��ע���ݵķ�װ
         pzVo.WFT_ID = wftId ;
        pzVo.NDP_ID = 2 ;
        pzVo.TP_END_DATE = FormUtil.getServerDate() ; 
        pzVo.TP_POSTIL = spyj ;//�������
         pzVo.TP_IMAGE = "ͼƬ" ;
        pzVo.TP_SYS = "" ;
        pzVo.TP_STATUS = wdzt ;//�浵��0ʱ��Ϊ�ݴ�
         pzVo.TP_EMY = getSysElement("userid");
        pzVo.TP_FW_NAME = "" ;
        pzVo.TP_ES_NAME = "" ;
        pzVo.TP_EMY_SET = zfry ; //������Ա
         pzVo.TP_EMY_IDS = zfryId;//������ԱID
         pzVo.ISPLATFORM = 0 ;
        pzVo.SU_ID_INNER = buId ;
        pzVo.TP_SYSUNIT_NAME = buName ;
        pzVo.SEGMENT_ID = "" ;
        pzVo.WORKFLOW_NAME = "��������" ;
        pzVo.TP_INFO = 0 ;
        //��������ʵ�����ݵķ�װ
         lxsxjdVo.WFT_ID= wftId ; //��������ʵ�����
         lxsxjdVo.PI_ID = PiId ; //������ 
         lxsxjdVo.NDP_ID = pzVo.NDP_ID ; //�׶α��
         var rv = LajdBiz.addLajdBiz(cfsxslVo,pzVo,lxsxjdVo,tmp);
        if(rv){
            if(wdzt==1){
                alert("�ύ������Ϣ�ɹ���");
                backBtn();
            } else {
                alert("����ɹ���");
            }
        }else{
            alert("����ʧ�ܣ�");
        }   
    }
}

//����
function backBtn1(){
    var Labh = $('BN_IBUSINESS_NUMBER').value ;
    var Lary = $('userNames').value ;
    var Lasj = $('WFT_PLACED_ON_FILE_TIME').value ;
    var Spyj = $('TP_POSTIL').value ; 
    if(!Labh=="" && !Lary=="" && !Lasj=="" && !Spyj==""){
       var a = confirm('û���ύ�Ƿ񷵻�?') ;
       if(a==true){
           parent.window.location.href = "20100929153136375631.jsp";
       }        
    }
}

//����
function backBtn(){
    parent.window.location.href = "20100929153136375631.jsp";
}


//��ӡ����ģ��
function dySpMb(){
   var sql = LajdBiz.findLajdWsmbBiz(PiId,NdpId);
}

//�����ϴ���ť����
/* ���ϴ�����ҳ�� */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('MD_ASM').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('MD_ASM').value = id;
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


//��ʾ���������͵�����
function showOrHiddenYS(){
   var tmp = document.getElementsByName('radiobutton');
   for(var i = 0 ; i<tmp.length ; i++){
       if(tmp[i].value=="FNCode3" && tmp[i].checked==true){
           $("ysDiv").style.display="";
           $("btns").style.display="none";
        }else{
           $("ysDiv").style.display="none";
           $("btns").style.display="";
       }
   }
}

//��֤������ŵ�Ψһ��
function validateLabh(){
    var flag = true ;
    var labhId = $("BN_IBUSINESS_NUMBER").value ;
    var num = LajdBiz.findLabhIdBiz(labhId,wftId);
    if(num>0){
        flag = false ;
    }else{
        flag = true ;
    }
    return flag ;
}

//��֤������ŵ�Ψһ��
function validateWftId(){
      return LajdBiz.validateWftIdBiz(wftId,NdpId) ;
}


//��֤����
function validate(){
    var flag = true ;
    if (flag) {
        flag = SValidator.validate(${'BN_IBUSINESS_NUMBER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BN_IBUSINESS_NUMBER'}.value]},
            MESSAGE : "������Ų���Ϊ��!"
        }, true);
    }
    
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("BN_IBUSINESS_NUMBER").value)){
            flag = false;
            alert("������Ų��ܰ������֣�");
        }            
    }
    
    if(flag){
        flag = validateLabh() ;
        if(!flag){
            alert("��������Ѵ��ڣ����������룡")
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'BN_IBUSINESS_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "����ܳ���{0}�ַ�!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'userNames'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'userNames'}.value]},
            MESSAGE : "������Ա����Ϊ��!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'userNames'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [255],maxlength : 255},
            MESSAGE : "����ܳ���{0}�ַ�!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'WFT_PLACED_ON_FILE_TIME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_PLACED_ON_FILE_TIME'}.value]},
            MESSAGE : "����ʱ�䲻��Ϊ��!"
        }, true);
    }
    
    if (flag) {
        var newTime = $('WFT_PLACED_ON_FILE_TIME').value ;
        var sysTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,sysTime);
        if(!flag){
            alert("����ʱ�䲻�ܴ��ڵ�ǰʱ��");
            return false ;
        }           
    }
    
    if(flag){
        var time1 = findAcceptTime().split(" ")[0];//����ʱ��
        var time2 = $('WFT_PLACED_ON_FILE_TIME').value;//����ʱ��   
         
        var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("����ʱ�䲻��С������ʱ��");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'TP_POSTIL'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'TP_POSTIL'}.value]},
            MESSAGE : "����������Ϊ��"
        }, true);
    }


    
    return flag ;
}

function initHiddenLazd() {
    if(readOnlyFlag == "readOnly") {
        $("print_spTable").disabled = true;
        $("up_spTable").disabled = true;
        $("tempSave").disabled = true;
        $("submitBtn").disabled = true;
        HTMLUtil.readOnly($('BN_IBUSINESS_NUMBER'),"commonReadOnly");
        HTMLUtil.readOnly($('userNames'),"commonReadOnly");
        HTMLUtil.readOnly($('WFT_PLACED_ON_FILE_TIME'),"commonReadOnly");
        HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
        var tmp = document.getElementsByName('radiobutton');
        for(var i = 0 ; i<tmp.length ; i++){
            tmp[i].disabled = true;
        }
    }
}

//��ִ����Ա��ѡ��
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+buId;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    if(!IsSpace($("userIds").value)){
        var lttIds = $("userIds").value;
        var arr = WorkflowUtil.getUnableDateByUser(lttIds);//��ѯִ����Ա֤��ʧЧ����
        var tempNowDate = getNowDate();//��ǰ����
        var outArr = new Array();
        for(var i = 0; i < arr.length; i++){
            var myDate1 = "";
            if(Number(arr[i][0]) != 0){
                var arys1 = new Array();
                var tempD = arr[i][0].split(" ")[0];
                arys1 = tempD.split('-');
                myDate1 = new Date(arys1[0],arys1[1],arys1[2]);//ʧЧ����
                 if(tempNowDate > myDate1){//��ʧЧ
                     outArr[outArr.length] = arr[i][2];
                }
             }
             if(i == arr.length - 1 && outArr.length > 0){
                 alert("\"" + outArr + "\"��ִ��֤����ʧЧ�������ٽ���ִ����");
             }
        }
    }
}

//��ѯ����ʱ��
function findAcceptTime(){
    var acceptTime = WorkflowUtil.queryAcceptTime(wftId);
    return acceptTime;
}

//��ѯ��ǰ����
function getNowDate(){
    var yearValue = FormUtil.getServerYear();
    var monthValue = FormUtil.getServerMonth();
    var dayValue = FormUtil.getServerDay();
    var dateValue = yearValue + "-" + 
                    (Number(monthValue) >= 10 ? monthValue : ("0" + monthValue)) +
                    "-" + (Number(dayValue) >= 10 ? dayValue : ("0" + dayValue));
    var arys1 = new Array();
    arys1 = dateValue.split('-');
    var nowDateValue = new Date(arys1[0],arys1[1],arys1[2]);
    return nowDateValue;
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>TP_POSTIL</id></textarea><button><id>print_spTable</id><id>up_spTable</id><id>tempSave</id><id>submitBtn</id><id>button1</id></button><text><id>userIds</id><id>BN_IBUSINESS_NUMBER</id><id>userNames</id><id>WFT_PLACED_ON_FILE_TIME</id><id>MD_ASM</id></text><dataset><id>WORKFLOW_TICKET_DATASET</id><id>findZfjtDataset</id><id>lajdInfoDataset</id></dataset><creatorSubForm><id>iform1</id></creatorSubForm></root>" billtaborder="<root><taborder>TP_POSTIL</taborder><taborder>BN_IBUSINESS_NUMBER</taborder><taborder>userNames</taborder><taborder>WFT_PLACED_ON_FILE_TIME</taborder><taborder>userIds</taborder><taborder>print_spTable</taborder><taborder>up_spTable</taborder><taborder>tempSave</taborder><taborder>submitBtn</taborder><taborder>MD_ASM</taborder><taborder>button1</taborder></root>" dj_sn="20100910111620171187" caption="��������" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:2;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:7;hr:0;checkboxlist:0;radiolist:1;dropdownlist:0;grid:0;dataset:3;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/common/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/LajdVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LajdBiz.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LajdDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD height=33>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=7>������������</TD>
                  </TR>
                  <INPUT id=userIds style="DISPLAY: none; LEFT: 41px; WIDTH: 110px; POSITION: static; TOP: 26px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="EMY_ID" china="������ԱID" dataset="lajdInfoDataset">
                  <TR>
                     <TD class=c2 width="2%" rowSpan=3>��������</TD>
                     <TD class=c2 width="25%">�������<SPAN><FONT color=red>*</FONT></SPAN></TD>
                     <TD width="20%"><INPUT class=input_out id=BN_IBUSINESS_NUMBER style="LEFT: 0px; WIDTH: 98%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="WFT_BUSINESS_NUMBER" china="�������" dataset="lajdInfoDataset"></TD>
                     <TD class=c2 width="25%">������Ա<FONT color=red>*</FONT></TD>
                     <TD width="24%"><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="EMY_NAME" china="������Ա����" dataset="lajdInfoDataset" onclick='bill_onclick("openUserTree();")'></TD>
                     <TD class=c2 width=25>����ʱ��<FONT color=red>*</FONT></TD>
                     <TD width="15%"><INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME style="LEFT: 0px; WIDTH: 98%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="WFT_PLACED_ON_FILE_TIME" china="����ʱ��" dataset="lajdInfoDataset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="25%" height=69>�������<FONT color=red>*</FONT></SPAN></TD>
                  <TD colSpan=5><TEXTAREA id=TP_POSTIL style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() cols=135 controltype="textarea" field="TP_POSTIL" china="�������" dataset="lajdInfoDataset" value="textarea1" induce="��"></TEXTAREA></TD>
               </TR>
               <TR>
                  <TD class=c2 width="25%" height=17>�������<FONT color=red>*</FONT></SPAN></TD>
               <TD colSpan=5><INPUT onclick=showOrHiddenYS() type=radio CHECKED value=FNCode1 name=radiobutton>����<INPUT onclick=showOrHiddenYS() type=radio value=FNCode2 name=radiobutton>��������<INPUT onclick=showOrHiddenYS() type=radio value=FNCode3 name=radiobutton>����</TD>
            </TR>
            <TR id=btns>
               <TD align=middle colSpan=7><BUTTON class=button id=print_spTable style="DISPLAY: none; LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("dySpMb()")'>��ӡ������ģ��</BUTTON><BUTTON class=button id=up_spTable style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>�ϴ�������</BUTTON><BUTTON class=button id=tempSave style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("submitLA(0);")'>�ݴ�</BUTTON><BUTTON class=button id=submitBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("submitLA(1);")'>�ύ</BUTTON><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("backBtn1()")'>����</BUTTON><INPUT id=MD_ASM style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
            </TR>
         </TBODY>
      </TABLE>
   </TD>
</TR>
</TBODY>
</TABLE>

<TABLE id=ysDiv style="DISPLAY: none" height="40%" width="95%" align=center border=0>

<TBODY>
   <TR>
      <TD><IFRAME id=iform1 style="LEFT: 0px; WIDTH: 99.89%; POSITION: static; TOP: 0px; HEIGHT: 300px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load="1" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/20100911150617625282.jsp?1=1&amp;name=&amp;"></IFRAME></TD>
   </TD>
</TR>
</TBODY>
</TABLE>

<DIV></DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=WORKFLOW_TICKET_DATASET format="<fields><field><fieldname>WFT_ID</fieldname><datatype>����</datatype><displaylabel>��������ʵ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�׶�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_ID</fieldname><datatype>�ַ�</datatype><displaylabel>����ʵ��״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_REFERRAL</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_REFERRAL_UNIT</fieldname><datatype>�ַ�</datatype><displaylabel>��������λ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_IDOLD</fieldname><datatype>�ַ�</datatype><displaylabel>ԭִ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' opensortno="1" temptable="TMP_DATASET1" saveastable="TA_WORKFLOW_TICKET" multiResult="��"></fc:dataset>

<fc:dataset id=findZfjtDataset format="<fields><field><fieldname>bu_id</fieldname><datatype>�ַ�</datatype><displaylabel>ִ��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset>

<fc:dataset id=lajdInfoDataset format="<fields><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EMY_ID</fieldname><datatype>�ַ�</datatype><displaylabel>������ԱID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_POSTIL</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fnCode</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fdpn_para_value</fieldname><datatype>�ַ�</datatype><displaylabel>����ֵ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EMY_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������Ա����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
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
var wft_id = creator_getQueryString("wft_id"); //Υ��ʵ��ID
var pi_id = creator_getQueryString("pi_id"); //����ID
var ndp_id = creator_getQueryString("ndp_id"); //��ǰ�׶�ID
var bu_id = creator_getQueryString("bu_id"); //ִ������ID
var bu_name = creator_getQueryString("bu_name"); //ִ����������
var readOnlyFlag = creator_getQueryString("readOnlyFlag"); // �Ƿ�ֻ��


//��ȡ��ǰ�û�
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

var statusValue = "";//��ע״̬
//��ѯִ������ID��ִ����������
function findBuIdAndBuName(){
    var sql = EndCase.findBuIdAndBuName(user_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    return arr;
}

function init(){
    statusValue = findPostilState();
    if(statusValue == 0){
        findPostil();//��ѯ���������ִ����Ա
    } else if(statusValue == 1){
        findPostil();//��ѯ���������ִ����Ա
        $('saveButton').style.display = "none";
        $('goButton').style.display = "none";
        document.getElementById("ExecuteOpinion").readOnly = true;
        HTMLUtil.readOnly($("userNames"),"commonReadOnly");
     }
    $('tr_id').style.display = "none";
    loadCheckUserTable();
}

//����������
function chooseReceipt(element){
    if(IsSpace(element.innerHTML)){
        return;
    }
    $('tr_id').style.display = ""; 
    if(element.id != " " && element.id != null) {
        var ltt_id = element.id.replace("td_id_","");
        innerCss(element.id);
        window.frames['iframe_id'].location = "../../jxc/dj/20101017162104093657.jsp?wft_id=" + wft_id + "&ltt_id=" + ltt_id;
        reloadExtGrid();
    }
}

/**
 * ��������ϸ
 * 
 */
function loadCheckUserTable() {
    //��ѯ���е�����
    var insReceiptArr = ExecuteState.selectPunishUserByWFT_IdOther(wft_id);
    var tr = null;
    var tdCount = 4;
    document.getElementById("$template1$").style.display = "none";
    document.getElementById("$template2$").style.display = "none";
    if(insReceiptArr.length > 0) {
        $("dsr_user_id").value = insReceiptArr[0][1]; 
        for(var i = 0; i < insReceiptArr.length; i++) {
            if (i % tdCount == 0) {
                tr = HTMLUtil.cloneReplaceElement(document.getElementById("$template1$"), {
                    template1 : "tr_id_" + i
                });
            }
            var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
                $USERNAME$ : insReceiptArr[i][0],
                $template2$ : "td_id_"+insReceiptArr[i][1]
            });
            td.style.display = "block";           
            tr.appendChild(td);

            if (i % tdCount == 0) {
                tr.style.display = "block";
               
                document.getElementById("container").appendChild(tr);
            }
        }
        
        var count = 0;
        var tempCount = insReceiptArr.length % tdCount;
        if(tempCount == 0) {
            count = 0;
        } else {
            count = tdCount - tempCount;
        }

        for (var i = 0; i < count; i++) {
            var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
                $USERNAME$ : " ",
                $template2$ : " "
            });
            td.style.display = "block";
            td.className = "";
            td.style.border = 0;
            tr.appendChild(td);
            //td.style.visibility = "hidden";
        }
        
    }
}

//��ѯ���������ִ����Ա
function findPostil(){
    var flag = 0;
    var sql = EndCase.findOpinionInfo(wft_id, 4);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        flag = 0;
    } else {
        $('ExecuteOpinion').value = arr[0][0];
        $('userNames').value = arr[0][2];
        $('userIds').value = arr[0][1];
        flag = 1;
    } 
    return flag;
}

//��ѯ��ע״̬
function findPostilState(){
    var sql = EndCase.findOpinionInfo(wft_id, 4);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        return "";
    } else {
        return arr[0][3];
    }
}

//�������������ִ����Ա----------����
function savePostil(tp_status){
    var vo = new EndCaseVo.EndCase();         //��ע����
    vo.WFT_ID = wft_id;
    vo.NDP_ID = ndp_id;                       //�׶�ID
    vo.TP_POSTIL = $('ExecuteOpinion').value; //��������
    vo.TP_STATUS = tp_status;                 //��ע״̬
    vo.TP_EMY = user_id;                      //��ע��
    vo.ISPLATFORM = 0;//����ƽ̨��� 
    var arr = findBuIdAndBuName();//��ѯ�ð�����ִ������
    vo.SU_ID_INNER = arr[0][0];  //ҵ��λ����
    vo.TP_SYSUNIT_NAME = arr[0][1];   //ִ������
    var ExecuteMen = $('userNames').value;     //ִ����Ա����
    var ExecuteMenId = $('userIds').value; //ִ����ԱID
    vo.TP_EMY_SET = ExecuteMen;//ִ����Ա����
    vo.TP_EMY_ID = ExecuteMenId;//ִ����ԱID
    vo.WORKFLOW_NAME = 'ִ��';
    vo.TP_INFO = 0;  //���ǲ�������
    vo.PI_ID = pi_id;
    return vo;
}

//�ݴ�
function saveNow(){
    var flag = validate();
    if(!flag){
        return;
    }
    var vo2 = new PunishMeasureVo.Case();
    //��ȡ��һ�׶ε�ID
    vo2.NDP_ID = WorkflowUtil.getNextStageId(pi_id, ndp_id, wft_id, "");
    vo2.WORKFLOW_NAME = "�᰸�鵵";
    var vo = savePostil(0);
    var rv = ExecuteState.insertTaskPlstil(vo, vo2);
    if(rv){
        alert("�ݴ�ɹ�");
    } else {
        alert("�ݴ�ʧ��");
    }
}

//�ύ
function saveGo(){
    if(confirm("ȷ�Ͻ������׶�?")){
        var result1 = checkExecute();
        var result2 = QueryCLXZ();
        if(!IsSpace(result1) && (result2.length == 0)){
            var output = "����������²����ύ��\n\n";
            output += "\"" + result1[0][0] + "\"�д�����ʩδִ���꣡";
            alert(output);
            return;
        } else if(!IsSpace(result1) && (result2.length > 0)){
            var output = "����������²����ύ��\n\n";
            output += "\"" + result1[0][0] + "\"���д�����ʩδִ���꣡\n";
            output += "\"" + result2.toString() + "\"���з���δ���꣡";
            alert(output);
            return;
        } else if(IsSpace(result1) && (result2.length > 0)){
            var output = "����������²����ύ��\n\n";
            output += "\"" + result2.toString() + "\"���з���δ���꣡";
            alert(output);
            return;
        }
        if(!validate()){
            return;
        }
        var vo2 = new PunishMeasureVo.Case();
        //��ȡ��һ�׶ε�ID
        vo2.NDP_ID = WorkflowUtil.getNextStageId(pi_id, ndp_id, wft_id, "");
        vo2.WORKFLOW_NAME = "�᰸�鵵";
        var vo = savePostil(1);
        var rv = ExecuteState.insertTaskPlstil(vo, vo2);
        if(rv){
            alert("�ύ������Ϣ�ɹ�!");
            parent.window.location.href = "20100929153136375631.jsp";
        } else {
            alert("�ύ������Ϣʧ��!");
        }
    }
}

//����Ƿ����еĴ�����ʩ��ִ������
function checkExecute(){
    return ExecuteState.findExecuteStateId(wft_id);
}

//����Ƿ����з����ѽ���
function checkPay(){
    var alreadyPay = ExecuteState.findAlreadyCasePay(wft_id);//�ѽ�
    var shouldPay = ExecuteState.findCasePay(wft_id);//Ӧ��
    if(alreadyPay - shouldPay >= 0){
        return true;
    } else {
        return false;
    }
}

//����
function goBack(){
    parent.window.location.href = "20100929153136375631.jsp";
}

//������֤
function validate(){
    var flag = true;
    if(flag){
        flag = SValidator.validate(${'ExecuteOpinion'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["��������"]}
        }, true);
    }
    
    if(flag){
        flag = SValidator.validate(${'userNames'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["ִ����Ա"]}
        }, true);
    }
    return flag;
}
function innerCss(userId) {
   var insReceiptArr = ExecuteState.selectPunishUserByWFT_IdOther(wft_id);
   for(var i = 0; i < insReceiptArr.length; i++) {
       var tdId = "td_id_"+insReceiptArr[i][1];
       var tdsytle = document.getElementById(tdId);
       tdsytle.className="dsr_head2";
   }
   $(userId).className = "dsr_head";
}

//��ѯ�ô�������ʵ�������е�����
function QueryDSR() {
    return ExecuteState.selectPunishUserByWFT_IdOther(wft_id);
}

//��ѯÿ�����������еĲ���ϸ��ʵ��
function QueryCLXZ() {
    var arr = new Array();
    var temp = 0;
    var result1 = QueryDSR(); //ȡ�����е�����ID
    for(var i = 0; i < result1.length; i++){//���������еĲ���ϸ��ʵ��
       var result2 = ExecuteState.findClxzByDsr(wft_id, result1[i][1]);
        for(var j = 0; j < result2.length; j++){//������ÿ������ϸ��ʵ����Ӧ�ɽ����ѽɽ��
            //�õ����˵�ĳ����ϸ��ʵ����Ӧ�ɽ��
            var shouldPay = ExecuteState.findPayByCLXZ(result2[j][0]);
            if(shouldPay != 0){
                //�õ����˵�ĳ����ϸ��ʵ�����ѽɽ��
                var alreadyPay = ExecuteState.findAlreadyPay(wft_id, result1[i][1], result2[j][0]);
              //alert("shouldPay:" + shouldPay + "\n" + "alreadyPay:" + alreadyPay);
              if(shouldPay - alreadyPay > 0){
                  arr[temp] = result1[i][0];
                  temp++;
                  break;
              }
           }
       }
    }
    return arr;
}

//��ִ����Ա��ѡ��
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+bu_id;
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

function changeHand(element){
    var tepFlag = element.innerHTML.split("&nbsp;&nbsp;&nbsp;")[1];
    if(!IsSpace(tepFlag)){
        document.getElementById(element.id).style.cursor = "hand";
    } else {
        document.getElementById(element.id).style.cursor = "default";
    }
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>ExecuteOpinion</id></textarea><button><id>saveButton</id><id>goButton</id><id>button5</id></button><text><id>userNames</id><id>dsr_user_id</id><id>userIds</id></text></root>" billtaborder="<root><taborder>ExecuteOpinion</taborder><taborder>userNames</taborder><taborder>saveButton</taborder><taborder>goButton</taborder><taborder>button5</taborder><taborder>userIds</taborder><taborder>dsr_user_id</taborder></root>" dj_sn="20101020114118093410" caption="ִ������Ǽ�ҳ��" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:5;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/EndCaseVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EndCase.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EndCaseDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js">

<TABLE width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD align=right><BUTTON class=button id=saveButton style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveNow()")'>�ݴ�</BUTTON><BUTTON class=button id=goButton style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveGo()")'>�ύ</BUTTON><BUTTON class=button id=button5 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("goBack()")'>����</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=2>ִ������ܽ���Ϣ</TD>
                  </TR>
                  <TR>
                     <TD class=c2 id=td1 width="15%">��������<FONT color=red>*</FONT></TD>
                     <TD><TEXTAREA id=ExecuteOpinion style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ����Ա<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 300px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">������<INPUT id=dsr_user_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD>
                        <TABLE class=Ctable style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                           <TBODY id=container>
                              <TR id=$template1$ style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none">
                                 <TD class=dsr_head2 id=$template2$ onmouseover=changeHand(this) onclick=chooseReceipt(this) width="25%">&nbsp;&nbsp;&nbsp;$USERNAME$</TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR id=tr_id>
         <TD><IFRAME id=iframe_id src="" width="100%" height=1000></IFRAME></TD>
      </TR>
   </TBODY>
</TABLE>

<INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text">
</DIV>
<div id='grid_tip'></div></body></html>
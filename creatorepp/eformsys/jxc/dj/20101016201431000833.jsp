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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
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
var wft_id = creator_getQueryString("wft_id");//��ȡ����ʵ��ID
var tp_status = creator_getQueryString("tp_status");//��ȡ��ע״̬
var avermentState = creator_getQueryString("avermentState");
var flag = creator_getQueryString("flag");
var temp = creator_getQueryString("temp");

//��ȡ��ǰ�û�
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

//�����ֹʱ��
function calculateTime(){
    var happenTime = $('SPA_DATE').value;//����ʱ��
    if(IsSpace(happenTime)){//�������ʱ��Ϊ�գ��򲻽�����ֹʱ�����
       return; 
    }
    var applyTime = $('SPA_APPLICATION_TIME').value;//����ʱ��
    var timeUnits = 1;//ʵ�ֵ�λ
    //�Զ������ֹʱ��
    var planEndTime = WorkflowUtil.deadLineAlgorithm(happenTime, applyTime, timeUnits);
    
    $('SPA_END_DATE').value = planEndTime.split(" ")[0];
}

//�������ʱ��Ķ�̬����ʱ������ֹʱ��
function checkEndTime(){
    var tempValue = $('SPA_APPLICATION_TIME').value;//����ʱ��
    if(!IsSpace(tempValue)){//�������ʱ�޲�Ϊ�գ����Զ������ֹʱ��
        calculateTime();
    }
}

//��ѯǿ����ֹ״̬
function findEndStatus(){
    var result = SpecialApply.findPlanTime(wft_id, "��֤");
    return result;
}

//��ʼ��
function init(){
    if(temp == 0){   //�Ӳ�ѯ�б���
        if(flag == 0 && avermentState == "������" && IsSpace(tp_status)){//û��ʱ
            var segment = "��֤";
            var result = findEndStatus();
            if(result[0][1] == 0){
                var sql = SpecialApply.findSpecialApply(wft_id, segment);
                specialApplyDataset.Open(sql);
                $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
                $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
                $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
                $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
                $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
                $('SPA_DATE').disabled = true; //����ʱ���û�
                $('saveApply').style.display = "none";//�����ύ��ť
                  $('endReason').style.display = "none";//����ǿ����ֹ����
                  changeStyle();
            } else if(result[0][1] == 1 && result[0][2] == 1){
                var sql = SpecialApply.findSpecialApply(wft_id, segment);
                specialApplyDataset.Open(sql);
                $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
                $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
                $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
                $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
                $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
                $('ApplyEndReason').value = result[0][3];//ǿ����ֹ����
                  $('SPA_DATE').disabled = true; //����ʱ���û�
                  $('saveApply').style.display = "none";//�����ύ��ť
                  $('UnableApply').style.display = "none";//����ȡ�����밴ť
                  $('saveResult').style.display = "none";//���صǼǽ����ť
                  changeStyle();
                document.getElementById('ApplyEndReason').readOnly = true;
            }
        } else if(avermentState == "������" && IsSpace(tp_status) && flag == 1){//��ʱ
            var segment = "��֤";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;        
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;    
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var result = SpecialApply.findPlanTime(wft_id, segment);
            $('ApplyEndReason').value = result[0][3];//ǿ����ֹ����
             $('saveApply').style.display = "none";//�����ύ��ť
             $('SPA_DATE').disabled = true; //����ʱ���û�
             $('UnableApply').style.display = "none";//����ȡ�����밴ť
             $('saveResult').style.display = "none";//���صǼǽ����ť
             changeStyle();
            document.getElementById('ApplyEndReason').readOnly = true;
        }
    } else {   //�ӵǼǽ�����
        if(avermentState == "δ����"){
            var segment = "��֤";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            var result = DBUtil.getQueryArray(sql, 0, -1);
            if(result.length == 0){
                $('UnableApply').style.display = "none";//����ȡ�����밴ť
                  $('saveResult').style.display = "none";//���صǼǽ����ť
                  $('endReason').style.display = "none";//����ǿ����ֹ����
              } else {
                $('SPA_DATE').value = result[0][0];
                $('SPA_APPLICATION_TIME').value = result[0][1];
                $('SPA_END_DATE').value = result[0][3];
                $('SPA_APPLICANT').value = result[0][5];
                $('SPA_REASONS').value = result[0][6];
                $('saveApply').style.display = "none";//�����ύ��ť
                  $('saveResult').style.display = "none";//���صǼǽ����ť
                  $('endReason').style.display = "none";//����ǿ����ֹ����
             }
        } else if(avermentState == "������"){
           var segment = "��֤";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var spa_realend_date = specialApplyDataset.Fields.Field['SPA_REALEND_DATE'].Value;
            $('saveApply').style.display = "none";//�����ύ��ť
             $('UnableApply').style.display = "none";//����ȡ�����밴ť
             $('SPA_DATE').disabled = true; //����ʱ���û�
             $('saveResult').style.display = "none";//���صǼǽ����ť
             $('endReason').style.display = "none";//����ǿ����ֹ����
             changeStyle();
        } else if(avermentState == "����֤"){
            var segment = "��֤";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_REALEND_DATE'].Value;        
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;    
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var result = SpecialApply.findPlanTime(wft_id, segment);
            $('ApplyEndReason').value = result[0][3];//ǿ����ֹ����
             $('saveApply').style.display = "none";//�����ύ��ť
             $('SPA_DATE').disabled = true; //����ʱ���û�
             $('UnableApply').style.display = "none";//����ȡ�����밴ť
             $('saveResult').style.display = "none";//���صǼǽ����ť
             changeStyle();
           document.getElementById('ApplyEndReason').readOnly = true;
        } 
    }
}

//�鿴�����޸�
function changeStyle(){
    document.getElementById('SPA_DATE').readOnly = true;
    document.getElementById('SPA_APPLICATION_TIME').readOnly = true;
    document.getElementById('SPA_END_DATE').readOnly = true;
    document.getElementById('SPA_APPLICANT').readOnly = true;
    document.getElementById('SPA_REASONS').readOnly = true;
}

//�����ر��������
function saveSpecialApply(){
    if(!validate()){
        return;
    }
    var vo = new SpecialVo.SpecialApply();
    vo.SPA_DATE = $('SPA_DATE').value;//����ʱ��
    vo.SPA_APPLICATION_TIME = $('SPA_APPLICATION_TIME').value;//����ʱ��
    vo.HCU_ID = 1;//ʵ�ֵ�λ
    vo.SPA_PLANEND_DATE = $('SPA_END_DATE').value;//��ֹʱ��
    vo.SPA_APPLICANT = $('SPA_APPLICANT').value;//������
    vo.SPA_REASONS = $('SPA_REASONS').value;//��������
    vo.SPA_FORCED_TERMINATION = 0;
    vo.SPA_SEGMENT = "��֤";
    vo.SPA_HANDLER = user_id;//������
    vo.WFT_ID = wft_id;
    var rv = SpecialApply.saveSpecialApply(vo);
    if(IsSpace(rv)){
        alert("����ɹ���");
    } else {
        alert("����ʧ�ܣ�");
    }
    $('saveApply').style.display = "none";//�����ύ��ť
}

//ȡ������
function unableApply(){
    /*var vo = new SpecialVo.SpecialApply();
    vo.WFT_ID = wft_id;
    vo.SPAFTC_ID = 1;//ȡ������״̬
    vo.SPA_FORCED_TERMINATION = 1;//ǿ����ֹ״̬
    vo.SPA_FORCED_TERMINATER = user_id;//��ǰ�û�ID
    vo.SPA_TERMINATION_REASONS = "������ȡ�����룡";
    vo.SPA_SEGMENT = "��֤";
    var rv = SpecialApply.updateSpecialApply(vo);
    */
    
    var rv = SpecialApply.deleteApply(wft_id, "��֤");
    if(IsSpace(rv)){
        alert("ȡ���ɹ�!");
        $('UnableApply').style.display = "none";//����ȡ�����밴ť
         $('saveResult').style.display = "none";//���صǼǽ����ť
    } else {
        alert("ȡ��ʧ��!");
    }

}

//�Ǽǽ��,��ת����֤����
function toAvermentPage(){
   var tempPara = "dialogWidth:780px,dialogHeight:250px;";
   var tempURL = "20100913145409775622.jsp?djbh=222&wft_id=" + wft_id + "&eflag=0&tflag=1";
   var obj = window.showModalDialog(tempURL, window, tempPara);
   if(obj.pic == 1){//���ݴ�
       $('saveApply').style.display = "none";//�����ύ��ť
       $('UnableApply').style.display = "none";//����ȡ�����밴ť
       $('saveResult').style.display = "none";//���صǼǽ����ť
   } else if(obj.pic == 0){//δ�Ǽ���Ϣ
       $('saveApply').style.display = "none";//�����ύ��ť
   } else if(obj.pic == 2){//���ύ
        $('saveApply').style.display = "none";//�����ύ��ť
        $('UnableApply').style.display = "none";//����ȡ�����밴ť
        $('saveResult').style.display = "none";//���صǼǽ����ť
        //��ѯ������Ϣ
        var sql = SpecialApply.findSpecialApply(wft_id, "��֤");
        var arr = DBUtil.getQueryArray(sql, 0, -1);
        $('endReason').style.display = "block";//����ǿ����ֹ����
        $('SPA_DATE').value = arr[0][0];
        $('SPA_APPLICATION_TIME').value = arr[0][1];
        $('SPA_END_DATE').value = arr[0][4];
        $('SPA_APPLICANT').value = arr[0][5];
        $('SPA_REASONS').value = arr[0][6];
        $('ApplyEndReason').value = arr[0][7];
   }
   reloadExtGrid();
}

//�رմ���
function closeWindow(){
    window.close();
}

//�к�ɫ*�ŵ��ֶ�Ϊ����д�����������Ƿ���д,����ֶγ��ȣ����ʱ���߼�����
function validate(){
    var flag = true;
    $("SPA_APPLICATION_TIME").value = $("SPA_APPLICATION_TIME").value.trim();
    //��֤����ʱ���Ƿ���д
    if(flag){
        flag = SValidator.validate(${'SPA_DATE'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["����ʱ��"]}
        }, true);
    }
    
    //��֤����ʱ���Ƿ���д
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICATION_TIME'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["����ʱ��"]}
        }, true);
    }
    
    if (flag) {
        var testNum = /^[0-9]{1,3}$/;
        if (!testNum.test($("SPA_APPLICATION_TIME").value)) {
            alert("����ʱ��������3λ������������");
            flag = false;
        }
    }

    //��֤�������Ƿ���д
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICANT'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["������"]}
        }, true);
    }

    //��֤�����˵ĳ���
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICANT'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["������", 60], maxlength : 60}
        }, true);
    }
    
    if(flag){
        var tempTime = findDeclareApplyTime().split(" ")[0];//��������ʱ��
        if(!IsSpace(tempTime) && tempTime == $('SPA_DATE').value){
            alert("��ǰ�����ѽ����˳����������");
            flag = false;
        }
    }
    
    if(flag){
        var time1 = findSignInTime().split(" ")[0];//��֪��ִǩ��ʱ��
         var time2 = $('SPA_DATE').value;//��֤����ʱ��
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("����ʱ�䲻��С�ڸ�֪��ִǩ��ʱ��");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if(flag){
        var time1 = $('SPA_DATE').value;//��֤����ʱ��
         var time2 = getNowDate();//��ǰ������ʱ��
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("����ʱ�䲻�ܴ��ڵ�ǰʱ��");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    //��֤���������Ƿ���д
    if(flag){
        flag = SValidator.validate(${'SPA_REASONS'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["��������"]}
        }, true);
    }
    return flag;
}

//��ѯ��֪��ִǩ��ʱ��
function findSignInTime(){
    return WorkflowUtil.querySignInTime(wft_id);
}

//��ѯ��ǰ������ʱ��
function getNowDate(){
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

//��ѯ��������ʱ��
function findDeclareApplyTime(){
    return WorkflowUtil.queryDeclareApplyTime(wft_id);
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>SPA_REASONS</id><id>ApplyEndReason</id></textarea><button><id>saveApply</id><id>UnableApply</id><id>saveResult</id><id>closewindow</id></button><text><id>SPA_DATE</id><id>SPA_APPLICATION_TIME</id><id>SPA_END_DATE</id><id>SPA_APPLICANT</id></text><dataset><id>specialApplyDataset</id></dataset></root>" billtaborder="<root><taborder>SPA_REASONS</taborder><taborder>ApplyEndReason</taborder><taborder>saveApply</taborder><taborder>UnableApply</taborder><taborder>saveResult</taborder><taborder>closewindow</taborder><taborder>SPA_DATE</taborder><taborder>SPA_APPLICATION_TIME</taborder><taborder>SPA_END_DATE</taborder><taborder>SPA_APPLICANT</taborder></root>" dj_sn="20101016201431000833" caption="��֤����" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SpecialApply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>��֤����</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">����ʱ��<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=its_out id=SPA_DATE onblur=checkEndTime() style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 width="15%">����ʱ��<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_APPLICATION_TIME onblur=calculateTime() style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=30 controltype="text">&nbsp;������</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��ֹʱ��</TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_END_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=c2 width="15%">������<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_APPLICANT style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��������<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=SPA_REASONS style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR id=endReason>
                     <TD class=c2 width="15%">ǿ����ֹ����</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=ApplyEndReason style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea2" induce="��"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=saveApply style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveSpecialApply()")'>�ύ</BUTTON><BUTTON class=button id=UnableApply style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("unableApply()")'>ȡ������</BUTTON><BUTTON class=button id=saveResult style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("toAvermentPage()")'>�Ǽǽ��</BUTTON><BUTTON class=button id=closewindow style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("closeWindow()")'>�ر�</BUTTON></TD>
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

<fc:dataset id=specialApplyDataset format="<fields><field><fieldname>SPA_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size></size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_APPLICATION_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HCU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ʱ�޵�λ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_PLANEND_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>�ƻ���ֹʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_REALEND_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>ʵ����ֹʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_APPLICANT</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>60</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_REASONS</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������ʵ��ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_SEGMENT</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>120</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' onValid='bill_ondatasetvalid("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
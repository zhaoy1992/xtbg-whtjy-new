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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
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
var wft_id = creator_getQueryString("wft_id"); //Υ��ʵ��ID
var pi_id = creator_getQueryString("pi_id"); //����ID
var ndp_id = "6"; //��ǰ�׶�ID
var bu_id = creator_getQueryString("bu_id"); //ִ������ID
var bu_name = creator_getQueryString("bu_name"); //ִ����������
var readOnlyFlag = ""; // �Ƿ�ֻ��
//var readOnlyFlag = creator_getQueryString("readOnlyFlag"); 
var ldtId = "1";//��ȡ��ʿ�ĵ�������
var mdEditId = creator_getQueryString("MD_EDIT_DATE");//��ȡ��ʱ����Ϊ�����ı༭ʱ��
var user_id = getSysElement("userid");//�û����
//��ȡ�Ƿ��ǲ˵���ǰ���Ĳ���
var flags=creator_getQueryString("eflag");
var flag_value = "";

//����ѯ���⸳��ֵ
var wwssTitle = "Υ����ʵ" ;
var blsjTitle = "����ʱ��" ;

//��ʼ������
function init(){
    initInfo();
    loadCheckUserTable();
    $("wft_ID").value = wft_id;
    $("ndp_ID").value = ndp_id;
    commandBut2();   
    $("read_only").value = readOnlyFlag;
    var tempTime = DateUtil.getSysTime();  
    initZYCL();   
}

//��̬������ӦΥ����Ϊ��Ӧ�����ɲ�����׼�ο�
function initZYCL(){
    var url ="20101016105529421844.jsp?tmp_value=1";
    document.all.creatorSubForm2.src = url;
}

//���ƽ���Ԫ�ص���ʾ(�׶����Ե���ȡ֤)
function commandBut2(){
    if(flags==0){//�Ӳ�ѯ�б����
        var tmp = Diagnoses.findCountBYLABiz(wft_id);
       if(tmp>0){//�ж������������׶��û���ѡ���Ƿ��ǲ�������������ǡ����ֻ����һ�����ذ�ť���������ء�
              $("saveButton").style.display = "none" ;
            HTMLUtil.readOnly($('illegalDeed'),"commonReadOnly");
            HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
            HTMLUtil.readOnly($('userNames'),"commonReadOnly");
            HTMLUtil.readOnly($('state_time'),"commonReadOnly");
            $("read_only").value = "readOnly" ;
            readOnlyFlag = $("read_only").value ;
        }else{
          var num = Diagnoses.findCountNum1Biz(wft_id);//�жϸõ���ȡ֤�׶��Ƿ����ύ
            if(num>0){//����ȡ֤���ύ
                 var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//�ж����ɴ��������Ƿ��Ѿ��ύ
                 if(num3 > 0){//���ɴ��������Ѿ��ύ�������ذ�ť֮��ȫ��Ӱ��
                     //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                      $("saveButton").style.display = "none" ;
                    HTMLUtil.readOnly($('illegalDeed'),"commonReadOnly");
                    HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
                    HTMLUtil.readOnly($('userNames'),"commonReadOnly");
                    HTMLUtil.readOnly($('state_time'),"commonReadOnly");
                    $("read_only").value = "readOnly" ;
                    readOnlyFlag = $("read_only").value ;
                } else {
                     if(IsSpace(mdEditId)) {
                     } else {
                         $("saveButton").style.display = "none" ;
                         $("read_only").value = "readOnly" ;
                         readOnlyFlag = $("read_only").value ;
                     }
                }
          }
      }
   } else {//�Ӿ��ڽ���
        var num2 = Diagnoses.findPurviewByUserIdAndPiIdBiz(user_id,pi_id);//�жϵ�ǰ�û��Ƿ�߱����ʵ���ȡ֤��Ȩ��
        if(num2>0){//�����ǰ�û���Ȩ��
             var tmp = Diagnoses.findCountBYLABiz(wft_id);
           if(tmp>0){//�ж������������׶��û���ѡ���Ƿ��ǲ�������������ǡ����ֻ����һ�����ذ�ť���������ء�
                  $("saveButton").style.display = "none" ;
                HTMLUtil.readOnly($('illegalDeed'),"commonReadOnly");
                HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
                HTMLUtil.readOnly($('userNames'),"commonReadOnly");
                HTMLUtil.readOnly($('state_time'),"commonReadOnly");
                $("read_only").value = "readOnly" ;
                readOnlyFlag = $("read_only").value ;
            }else{
                  var num1 = Diagnoses.findCountNumBiz(wft_id);//�ж��Ƿ�������֮�����ȡ֤֮ǰ
                  if(num1>0){//����������֮�����ȡ֤֮ǰ,ֻӰ���ύ��ť
                  }else{
                  var num = Diagnoses.findCountNum1Biz(wft_id);//�жϸõ���ȡ֤�׶��Ƿ����ύ
                    if(num>0){//����ȡ֤���ύ
                            var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//�ж����ɴ��������Ƿ��Ѿ��ύ
                            if(num3 > 0){//���ɴ��������Ѿ��ύ�������ذ�ť֮��ȫ��Ӱ��
                                 $("saveButton").style.display = "none" ;
                             $("read_only").value = "readOnly" ;
                             readOnlyFlag = $("read_only").value;
                         } else {
                             if(IsSpace(mdEditId)) {
                             } else {
                                 $("saveButton").style.display = "none" ;
                                 $("read_only").value = "readOnly" ;
                                 readOnlyFlag = $("read_only").value ;
                             }
                         }   
                    }
                }
            }
        }else{
                //��ǰ����ֻ����ֻ���·��ذ�ť���Բ���
                  $("saveButton").style.display = "none" ;
                HTMLUtil.readOnly($('illegalDeed'),"commonReadOnly");
                HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
                HTMLUtil.readOnly($('userNames'),"commonReadOnly");
                HTMLUtil.readOnly($('state_time'),"commonReadOnly");
                $("read_only").value = "readOnly";
                readOnlyFlag = $("read_only").value ;
        }
  
    }
}

//ҳ������ǳ�ʼ��׼������
function initInfo(){
    $("userNames").readOnly = true ;
    if(IsSpace(mdEditId)){
        //document.getElementById("AABB").innerText = "��������ȡ֤" ;
    }else{
        //document.getElementById("AABB").innerText = "�޸ĵ���ȡ֤" ; 
        //�����޸ĳ�ʼ����ʾ�Ľ���Ԫ��
        updLoadInfo(wft_id,ldtId,mdEditId,wwssTitle,blsjTitle);   
    }
} 

//�޸�ʱ��Ҫ������Ϣ�ĺ���
function updLoadInfo(wft_id,ldtId,mdEditId,wwssTitle,blsjTitle){
    var sql = Diagnoses.findByTimeDcqzBiz(wft_id,ldtId,mdEditId,wwssTitle,blsjTitle);
    dcqzDateset1.Open(sql);
    /*var tmp = dcqzDateset1.Fields.Field['TP_EMY_SET'].Value;
    if (!IsSpace(tmp)) {
        $("userNames").value = tmp.split("#")[0];
        if (tmp.split("#").length>1) {
            $("userIds").value = tmp.split("#")[1];
        }
    }*/
    flag_value = $("wfss_mdID").value;
}

function validateValue(){
    $("illegalDeed").value = $("illegalDeed").value.trim();
    $("TP_POSTIL").value = $("TP_POSTIL").value.trim();
}

//�������ȡ֤��Ϣ
function saveStateRecord(){
    validateValue();
    if(validate()){
        //����ִ�������ţ���ִ����������
          var sql = LajdBiz.findZfjtBhAndMcBiz(wft_id);
        findZfjtDataset.Open(sql);
        //��ȡִ�������ţ���ִ����������
          var buId = findZfjtDataset.Fields.Field["bu_id"].Value;//ִ��������
          var buName = findZfjtDataset.Fields.Field["bu_name"].Value;//ִ����������
          var list = new Array(2); //����һ��List�����������ҳ���ϵ������ύ�ĵ��嵥����
          var documentVo = new DiagnosesVo.DocumentMulti() ; 
        //���ύ�ĵ��嵥����ʼ��ֵ
          documentVo.WFT_ID = wft_id ;
        documentVo.LDT_ID = ldtId ;
        documentVo.MT_ID = "" ; 
        documentVo.NDP_ID = ndp_id ;//��ʾ�ĵ�����==����ȡ֤
          documentVo.MD_NUM = 1;
        documentVo.MD_EDIT_DATE = FormUtil.getServerDate();//��ȡ�������ϵ�ʱ��
          documentVo.MD_DSM = 1 ;
        documentVo.MD_BODY_ATTRI = 0 ;
        documentVo.MD_ISTEMPLATE = 0 ;
        documentVo.MD_TSM = 0 ;
        documentVo.MD_TSI = "" ;
        documentVo.MD_FORMAT = "text" ;
        documentVo.MD_ISACCESSORIES = 0 ;
        documentVo.MD_ASM = 0 ;
        documentVo.MD_ACCESSORIES_BODY = "" ;
        documentVo.MD_AFORMAT = "" ;
        documentVo.ISPLATFORM = 0;
        documentVo.SEGMENT_ID = "" ;
        documentVo.WORKFLOW_NAME = "����ȡ֤" ;
                
        var postilVo= new DiagnosesVo.Postil() ; 
        //����ע����ʼ��ֵ
          postilVo.WFT_ID = wft_id  ;
        postilVo.NDP_ID = ndp_id  ;
        postilVo.TP_POSTIL = $("TP_POSTIL").value.trim() ;//ִ����Ա���
          postilVo.TP_IMAGE = "ͼƬ" ;
        postilVo.TP_SYS = "" ;
        postilVo.TP_STATUS = 0 ;
        postilVo.TP_EMY = getSysElement("userid");
        postilVo.TP_FW_NAME = "" ;
        postilVo.TP_ES_NAME = "" ;
        postilVo.TP_EMY_SET = $("userNames").value.trim(); //ִ����Ա
          postilVo.TP_EMY_ID = $("userIds").value; //ִ����Ա
          postilVo.ISPLATFORM = 0 ;
        postilVo.SU_ID_INNER = buId ;
        postilVo.TP_SYSUNIT_NAME = buName ;
        postilVo.SEGMENT_ID = "" ;
        postilVo.WORKFLOW_NAME = "����ȡ֤" ;
        postilVo.TP_INFO = 0 ;
        
        //���������ύ�ĵ��嵥����
         var vo1 = new DiagnosesVo.DocumentMulti();
        var vo2 = new DiagnosesVo.DocumentMulti();
        //��������������ݿ�
         vo1.MD_TITLE = "Υ����ʵ";
        vo1.MD_BODY = ${'illegalDeed'}.value;
        list[0] = vo1;
        vo2.MD_TITLE = "����ʱ��";
        vo2.MD_BODY = ${'state_time'}.value;
        list[1] = vo2;
        if(IsSpace(mdEditId)){//��������ȡ֤��Ϣ
              var rv = Diagnoses.insertDiagnoses(list,documentVo,postilVo); 
            if(rv){
                alert("����ɹ�!");
                loadDcqz();
            } else {
                alert("����ʧ��");
            }
         }else{//�޸ĵ���ȡ֤��Ϣ
           var vr = Diagnoses.updDcqzBiz(mdEditId, list, documentVo, postilVo, flag_value); 
         if(vr){
               alert("����ɹ�!");
               loadDcqz();
           } else {
               alert("����ʧ��");
           }   
         }   
         //��ѯ���µ�Υ����ʵ��Ӧ���ύ�����嵥��ˮ
         $("wfss_mdID").value = findNewestMdID(wft_id);
     }
}

//��ѯ���µ�Υ����ʵ��Ӧ���ύ�����嵥��ˮ
function findNewestMdID(wft_id){
    return Diagnoses.findNewestMdID(wft_id);
}

//�ݴ淽��
function zanCun (){
    validateValue();
    if(IsSpace(wft_id)){//��������ȡ֤��Ϣ
        if(validate()){
            var list = new Array(2); //����һ��List�����������ҳ���ϵ������ύ�ĵ��嵥����
              var documentVo = new DiagnosesVo.DocumentMulti() ; 
            //���ύ�ĵ��嵥����ʼ��ֵ
              documentVo.WFT_ID = wft_id ;
            documentVo.LDT_ID = ldtId ;
            documentVo.MT_ID = "" ; 
            documentVo.NDP_ID = ndp_id ;//��ʾ�ĵ�����==����ȡ֤
              documentVo.MD_NUM = 1;
            documentVo.MD_EDIT_DATE = FormUtil.getServerDate();//��ȡ�������ϵ�ʱ��
              documentVo.MD_DSM = 1 ;
            documentVo.MD_BODY_ATTRI = 0 ;
            documentVo.MD_ISTEMPLATE = 0 ;
            documentVo.MD_TSM = 0 ;
            documentVo.MD_TSI = "" ;
            documentVo.MD_FORMAT = "text" ;
            documentVo.MD_ISACCESSORIES = 0 ;
            documentVo.MD_ASM = 0 ;
            documentVo.MD_ACCESSORIES_BODY = "" ;
            documentVo.MD_AFORMAT = "" ;
            documentVo.ISPLATFORM = 0;
            documentVo.SEGMENT_ID = "" ;
            documentVo.WORKFLOW_NAME = "����ȡ֤" ;      
            var postilVo= new DiagnosesVo.Postil() ;
             
            //����ע����ʼ��ֵ
              postilVo.WFT_ID = wft_id  ;
            postilVo.NDP_ID = ndp_id  ;
            postilVo.TP_END_DATE = FormUtil.getServerDate();//��ȡ�������ϵ�ʱ�� 
              postilVo.TP_POSTIL = $("TP_POSTIL").value.trim() ;//ִ����Ա���
              postilVo.TP_IMAGE = "ͼƬ" ;
            postilVo.TP_SYS = "" ;
            postilVo.TP_STATUS = 0 ;
            postilVo.TP_EMY = getSysElement("userid");
            postilVo.TP_FW_NAME = "" ;
            postilVo.TP_ES_NAME = "" ;
            postilVo.TP_EMY_ID = $("userIds").value;
            postilVo.TP_EMY_SET = $("userNames").value.trim(); //ִ����Ա
              postilVo.ISPLATFORM = 0 ;
            postilVo.SU_ID_INNER = buId ;
            postilVo.TP_SYSUNIT_NAME = buName ;
            postilVo.SEGMENT_ID = "" ;
            postilVo.WORKFLOW_NAME = "����ȡ֤" ;
            postilVo.TP_INFO = 0 ;
            
            //���������ύ�ĵ��嵥����
              var vo1 = new DiagnosesVo.DocumentMulti();
            var vo2 = new DiagnosesVo.DocumentMulti();
            //��������������ݿ�
              vo1.MD_TITLE = "Υ����ʵ";
            vo1.MD_BODY = ${'illegalDeed'}.value;
            list[0] = vo1;
            vo2.MD_TITLE = "����ʱ��";
            vo2.MD_BODY = ${'state_time'}.value;
            list[1] = vo2;
            var rv = Diagnoses.insertDiagnoses(list,documentVo,postilVo); 
            if(rv){
                alert("����ɹ�!");
                loadDcqz();
            } else {
                alert("����ʧ��");
            }
        }
    }
}

//��֤����
function validate(){
    var flag = true ;
    if (flag) {
        flag = SValidator.validate(${'illegalDeed'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'illegalDeed'}.value]},
            MESSAGE : "Υ����ʵ����Ϊ��!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'TP_POSTIL'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'TP_POSTIL'}.value]},
            MESSAGE : "ִ����Ա�������Ϊ��!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'userNames'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'userNames'}.value]},
            MESSAGE : "ִ����Ա����Ϊ��!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'state_time'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'state_time'}.value]},
            MESSAGE : "����ʱ�䲻��Ϊ��!"
        }, true);
    }
    
    if (flag) {
        var newTime = ${'state_time'}.value ;
        var tempTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,tempTime);
        if(!flag){
            alert("����ʱ�䲻�ܴ��ڵ�ǰʱ��");
            return false ;
        }
    }
    
    if (flag) {
        var time1 = findRegisterTime().split(" ")[0];//����ʱ��
         var time2 = $('state_time').value;//����ʱ��
         
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
   
   return flag;
  
}

//��ת
function loadDcqz(){
    var tempURL="20100925191216234397.jsp?&eflag="+flags+"&wft_id="+wft_id+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag ;
    window.location.href(tempURL);
    reloadExtGrid();
}

/**
 * ��������ϸ
 * 
 */
function loadCheckUserTable() {
    var insReceiptArr = PunishDecide.selectPunishUserByWFT_IdOther(wft_id);
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
            tr.appendChild(td);
        }
    }
}

function saveUserInfo() {
    creatorSubForm2.savePunishDecideInfo();
} 
function allOpenInfo() {
    creatorSubForm2.openAllCFCSS();
}
function allCloseInfo() {
    creatorSubForm2.closeAllCFCSS();
}
function chooseReceipt(userIdsObj) {
    if(userIdsObj.id != " " && userIdsObj.id != null) {
        innerCss(userIdsObj.id);
        //creatorSubForm2.reloadPage(userIdsObj.id);
        creatorSubForm2.reloadPage(userIdsObj.id.replace("td_id_",""));

    }
}

function innerCss(userId) {
   var insReceiptArr = PunishDecide.selectPunishUserByWFT_IdOther(wft_id);
   for(var i = 0; i < insReceiptArr.length; i++) {
       var tdId = "td_id_"+insReceiptArr[i][1];
       var tdsytle = document.getElementById(tdId);
       tdsytle.className="";
   }
   $(userId).className = "c2";
}


//����
function backBtn(){
    parent.window.location.href = "20100929153136375631.jsp";
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

//��ѯ����ʱ��
function findRegisterTime(){
    return WorkflowUtil.queryRegisterTime(wft_id);
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
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>illegalDeed</id><id>TP_POSTIL</id></textarea><div><id>div2</id></div><button><id>saveButton</id><id>rebackID</id><id>allOpenBtn</id><id>allCloseBtn</id></button><text><id>userIds</id><id>wfss_mdID</id><id>userNames</id><id>state_time</id><id>dsr_user_id</id><id>wft_ID</id><id>ndp_ID</id><id>read_only</id></text><dataset><id>dcqzDateset1</id><id>findZfjtDataset</id></dataset></root>" billtaborder="<root><taborder>illegalDeed</taborder><taborder>TP_POSTIL</taborder><taborder>saveButton</taborder><taborder>rebackID</taborder><taborder>allOpenBtn</taborder><taborder>allCloseBtn</taborder><taborder>userIds</taborder><taborder>wfss_mdID</taborder><taborder>userNames</taborder><taborder>state_time</taborder><taborder>dsr_user_id</taborder><taborder>wft_ID</taborder><taborder>ndp_ID</taborder><taborder>read_only</taborder></root>" dj_sn="20100919163051506628" caption="����ȡ֤" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:2;textarea:2;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:3;DsMain_field:0;a:0;button:11;text:8;hr:0;checkboxlist:1;radiolist:1;dropdownlist:2;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:4;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Diagnoses.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LajdBiz.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LajdDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishDecide.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD><INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 82px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="emy_id" china="ִ����ԱID" dataset="dcqzDateset1"><?xml:namespace prefix = fc /><fc:dataset id=dcqzDateset1 format="<fields><field><fieldname>wfss</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����ʵ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_POSTIL</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����Ա���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>emy_id</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����ԱID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>blsj</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_REFER_ATTRI</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ���Ϊ������Ϣ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>emy_name</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����Ա����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wfssId</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����ʵ�嵥��ˮ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><wfss></wfss><TP_POSTIL></TP_POSTIL><emy_id></emy_id><blsj></blsj><MD_REFER_ATTRI></MD_REFER_ATTRI><emy_name></emy_name><wfssId></wfssId></dsid>")' onGetText='bill_ondatasetgettext("<dsid><wfss></wfss><TP_POSTIL></TP_POSTIL><emy_id></emy_id><blsj></blsj><MD_REFER_ATTRI></MD_REFER_ATTRI><emy_name></emy_name><wfssId></wfssId></dsid>")' onValid='bill_ondatasetvalid("<dsid><wfss></wfss><TP_POSTIL></TP_POSTIL><emy_id></emy_id><blsj></blsj><MD_REFER_ATTRI></MD_REFER_ATTRI><emy_name></emy_name><wfssId></wfssId></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset><fc:dataset id=findZfjtDataset format="<fields><field><fieldname>bu_id</fieldname><datatype>�ַ�</datatype><displaylabel>ִ��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset><INPUT id=wfss_mdID style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="wfssId" china="Υ����ʵ�嵥��ˮ" dataset="dcqzDateset1"></TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=AABB align=left width="15%" colSpan=4>����ȡ֤</TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">Υ����ʵ<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD align=left colSpan=3><TEXTAREA class=input_out id=illegalDeed style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="wfss" china="Υ����ʵ" dataset="dcqzDateset1" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">ִ����Ա���<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD align=left colSpan=3><TEXTAREA class=input_out id=TP_POSTIL style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="TP_POSTIL" china="ִ����Ա���" dataset="dcqzDateset1" value="textarea2" induce="��"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right height=22>ִ����Ա<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="34%"><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text" field="emy_name" china="ִ����Ա����" dataset="dcqzDateset1" onclick='bill_onclick("openUserTree();")'></TD>
                     <TD class=c2 align=right width="14%">����ʱ��<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD align=left width="19%"><INPUT class=its_out id=state_time style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly name=Input2 controltype="text" field="blsj" china="����ʱ��" dataset="dcqzDateset1" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD align=middle colSpan=4 height=22><BUTTON class=button id=saveButton style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("saveStateRecord();")'>����</BUTTON><BUTTON class=button id=rebackID style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("loadDcqz()")'>����</BUTTON></TD>
                  </TR>
                  <TR id=userInfo>
                     <TD class=c2 width="15%">������<INPUT class=input_out id=dsr_user_id style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=wft_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=ndp_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 6px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=read_only style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD colSpan=2>
                        <TABLE class=Ctable style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                           <TBODY id=container>
                              <TR id=$template1$>
                                 <TD id=$template2$ onclick=chooseReceipt(this) width="25%">$USERNAME$</TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                     <TD width="18%"><BUTTON class=button id=allOpenBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("allOpenInfo();")'>ȫ��չ��</BUTTON><BUTTON class=button id=allCloseBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("allCloseInfo();")'>ȫ������</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><DIV id=div2 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 350px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��"><IFRAME id=creatorSubForm2 style="WIDTH: 100%; HEIGHT: 106%" border=0 frameBorder=no></IFRAME></DIV></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
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
</DIV>
<div id='grid_tip'></div></body></html>
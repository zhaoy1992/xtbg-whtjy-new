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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/project_div_win.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/project_div_win.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/project_new_upload.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/project_new_upload.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/approval_ideal.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/approval_ideal.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/div_tree.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/div_tree.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/entrust_startwf.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/entrust_startwf.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/project_pub.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/project_pub.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcwebgrid.js');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
<%
    String userMobiletel1=accesscontroler.getUserAttribute("userMobiletel2");
    String userMobiletel2=accesscontroler.getUserAttribute("userMobiletel1");
%>
/* ϵͳ��Ϣ  */
var userId = getSysElement("userid"); //�û�ID
var userAccount = getSysElement("userAccount")//�û��˺�
var userName = getSysElement("userName"); //�û�����
var userMobiletel1="<%=userMobiletel1%>"; //�û��绰
if(IsSpace(userMobiletel1)){
    userMobiletel1="<%=userMobiletel2%>";
}
var orgId = getSysElement("userorgid"); //�û���������id
var orgName = getSysElement("userorgname"); //�û�������������
var strDate = executeSelect("select to_char(sysdate,'yyyy-mm-dd') as a,to_char(sysdate,'yyyymmdd') as b from dual",1,1); //��ǰ���ݿ����������
var currentDateTime =strDate[0][0];
var currentDateTimes=strDate[0][1];

/* ������Ϣ */
var entrustId=creator_getQueryString("entrust_id");
var taskId=creator_getQueryString("task_id");
var opType=creator_getQueryString("opType");//��ǰ��¼������״̬
var cc_form_instanceid = Trim(creator_getQueryString("cc_form_instanceid"));//����ҵ��ID
/* ��ǰ�ID */
var actId = creator_getQueryString("actDefId");
if(null==actId){
    actId = creator_getQueryString("oid");
}
var actIds = {
    actId1 : "taskEntrust_wp1_act1",
    actId2 : "taskEntrust_wp1_act2",
    actId3 : "taskEntrust_wp1_act3",
    actId4 : "taskEntrust_wp1_act4",
    actId5 : "taskEntrust_wp1_act5",
    actId6 : "taskEntrust_wp1_act6",
    actId7 : "taskEntrust_wp1_act7",
    actId8 : "taskEntrust_wp1_act8",
    actId9 : "taskEntrust_wp1_act9"
}
/* ��ǰ����� */
var actName = creator_getQueryString("actDefName"); 
var actNames = {
    actionname1 : "ί�еǼ�",
    actionname2 : "����/�ֹ�˾�쵼����",
    actionname3 : "�ܲ��г�������Ա���",
    actionname4 : "Э����Ŀ����",
    actionname5 : "�ܲ��г����쵼����",
    actionname6 : "֣���г����쵼����",
    actionname7 : "���첿���쵼����",
    actionname8 : "������ȷ��",
    actionname9 : "����",
    actionname10: "ί����ֹ"
}   
/* ��ɫ��Ϣ */
var roles = {
    rolename1 : "�ܲ��г������̹���Ա",//��Ӧ��ǰ��"�ܲ��г�������Ա"
    rolename2 : "�ܲ��г����쵼",
    rolename3 : "֣�ּ��в����ܹ����쵼",
    rolename4 : "�ֹ�˾�쵼",
    rolename5 : "�����쵼"  
}
/* ҵ����Ϣ */
var forwardUrl="../../../common_workflow/main.jsp";//�������̺���ɻ��ת��ҳ��

var hq_orgId="00700104100";//�ܲ��г�������ID
var userType="";//�û����ڻ�������������    0���ܲ��г�����Ա  1���ܲ����г�����Ա  2��֣����Ա  3�������ֹ�˾��Ա
var offerSql="";//�����б�sql
/* ҳ���ʼ�� */
function init(){
    $("actName").innerText=actName;
    //alert("cc_form_instanceid : "+cc_form_instanceid);
    if((opType=="view")||(opType=="read")){
        f_viewInit();
    }else{
        if(IsSpace(cc_form_instanceid)||cc_form_instanceid.indexOf("clear")!=-1) {
            f_newBaseInit();
        }else{
            f_existBaseInit();
            f_AttachInit(false);
        }
        $("transRead").style.display="none";
    }
    f_changeWay(false);
    f_OfferDetailInit();
    f_opinionInit();
    f_wfInit();
    $("anchor_up").click();
}
function f_viewInit(){
    f_existBaseInit();
    f_AttachInit(false);
    $("actName").innerText=$("status").value;
    $("monitor").style.display="block";
    if($("status").value=="�ݴ�"){
        hideOrShowTabByName('������Ϣ','hide');
    }else{
        $("txyj1").style.display="none";
        $("txyj2").style.display="none";
    }
    $("next").style.display="none";
    if($("status").value==actNames.actionname3||$("status").value==actNames.actionname4||$("status").value==actNames.actionname5){
        hideOrShowTabByName('���Ž��鵥','hide');
    }
    if($("status").value==actNames.actionname7||$("status").value==actNames.actionname8||$("status").value==actNames.actionname9){
        $("rwxd1").style.display="block";
        $("rwxd2").style.display="block";
    }else{
        $("rwxd1").style.display="none";
        $("rwxd2").style.display="none";        
    }
        
    $("save").style.display="none";
    $("workflowControl_start").style.display="none";
    $("workflowControl_complete").style.display="none";
    $("button6").disabled=true;
    $("planTypeBtn").disabled=true;
    $("planAddBtn").disabled=true;
    if(opType=="view"){
        $("transRead").style.display="none";
    }
}
/**
 * ����ҳ�����ҵ���ʼ��
 */
function f_newBaseInit(){
    if(IsSpace(entrustId)){
        f_newInit();
    }else{
        f_existInit();
    }
}
/**
 * ��������ҳ�����ҵ���ʼ��(����������)
 */
function f_existBaseInit(){
    f_displayUI();
    //������
    var planSql=" select oid as plan_id, task_oid, design_phasesid, design_phases, proj_level,"
        +" specialitys_id, specialitys,to_char(task_confirmdate,'yyyy-mm-dd') as task_confirmdate,"
        +" to_char(task_expectdate,'yyyy-mm-dd') as task_expectdate, m_deptid, m_dept, j_deptid, j_dept, receive_userid,"
        +" receive_user, task_sponsorid, task_sponsor, apply_deptid, apply_dept, apply_userid, apply_user, status,nc"
        +" from ta_project_task_plan"
        +" where cc_form_instanceid='"+cc_form_instanceid+"'";
    //alert("planSql:"+planSql);
    dataset3.Open(planSql);
    
    //ί������
    var taskSql=" select oid as task_id, entrust_oid, entrust_type, proj_id, proj_name, design_id, custom_proj_id,"
            +" custom_proj_name, ascription, province, belong_orgid, belong_org, profession_property, proj_type,"
            +" responsible_orgid, responsible_org, proj_level, add_entrust_phaseid, add_entrust_phase,undo_entrust_phaseid,"
            +"  undo_entrust_phase, dimensions, investment,to_char(expect_date,'yyyy-mm-dd') as expect_date, other_request,"
            +" used_phaseid, used_phase,to_char(approval_date,'yyyy-mm-dd') as approval_date,entrust_status,parent_id"
            +" from ta_project_task_record"
            +" where oid='"+dataset3.Fields.Field['task_oid'].Value+"'";
    //alert("taskSql:"+taskSql);
    dataset2.Open(taskSql);
    if(IsSpace($("used_phaseid").value)){
        var sqlstr=" select wmsys.wm_concat(t.design_phaseid) as design_phaseid,"
                  +" wmsys.wm_concat(t.design_phasename) as design_phasename"
                  +" from ta_project_approval_phase t,ta_project_approval d"
                  +" where t.approval_id=d.approval_id and d.is_pass='��' and t.design_status<>'2'"
                  +" and t.design_id='"+dataset2.Fields.Field['design_id'].Value+"'";
        var ret = executeSelect(sqlstr,1,1);        
        if(ret.length>0){
            $("used_phaseid").value=ret[0][0];
            $("used_phase").value=ret[0][1];
        }
    }
    f_displayInfoByType($("entrust_type").value);
    
    //ί����Ϣ
    var infoSql=" select entrust_id,entrust_no,inputer_id,inputer,to_char(inputer_date,'yyyy-mm-dd') as inputer_date,"
                +" dept_id,dept_name,client,entrust_subject,entrust_way,entrust_explain,entrust_way_no,opposite_linkman,"
                +" opposite_phone,opposite_org,our_linkman,our_phone,our_org,remark"
                +" from ta_project_entrust_record"
                +" where entrust_id='"+dataset2.Fields.Field['entrust_oid'].Value+"'";
    dataset1.Open(infoSql);
    //alert("infoSql:"+infoSql);
    $("entrust_type").disabled=true;    
    
    if((actId==actIds.actId3)||(actId==actIds.actId4)||(actId==actIds.actId5)){
        var sql1="select * from ta_project_task_plan_v where task_oid='"+$("task_id").value+"'";
        dataset6.Open(sql1);
        var sql2=" select oid, plan_oid, org_id, org_name, speciality_id, speciality_name, dept_id, dept_name,"
                +" case is_main when 0 then '��' else '��' end as is_main, memo"
                +" from ta_project_task_plan_detail_v where plan_oid='"+$("plan_id").value+"'";
        dataset7.Open(sql2);
        if(IsSpace(dataset6.Fields.Field['oid'].Value)){
            hideOrShowTabByName('���Ž��鵥','hide');
        }
    }
}
/**
 * ������ҵ������
 */
function f_newInit(){
    $("workflowControl_start").style.display="none";
    $("planTypeBtn").disabled=true;
    $("entrust_id").value=getNewCc_form_instanceid(false);
    //��ʼ��ҳ��Ԫ�ص�ֵ
    $("entrust_type").value="project_new";
    $("entrust_status").value="1";
    $("entrust_way").value="1"; 
    
    $("our_linkman").value=userName;
    $("our_phone").value=userMobiletel1;
    $("our_org").value=orgName;
    
    $("inputer_id").value=userId;
    $("inputer_id").value=userId;
    $("inputer").value=userName;
    $("inputer_date").value=currentDateTime;
    $("dept_id").value=orgId;
    $("dept_name").value=orgName;
    $("other_request").value="��";
}
function f_displayUI(){
    //��ʾ���˿�������Ϣ��
    $("xm1").style.display="block";
    $("xm2").style.display="block";
    $("xm3").style.display="block";
    $("xm4").style.display="block";
    $("xm5").style.display="block"; 
    $("cx").style.display="block";  
    $("rw1").style.display="block";
    $("rw2").style.display="block";
    $("rw3").style.display="block";
    $("rw4").style.display="block"; 
    $("qt1").style.display="block";
    $("qt2").style.display="block";
    $("qt3").style.display="block";
    $("qt4").style.display="block";
    //��ʾ����Ŀ���Ž��鵥��
    $("xmjy1").style.display="block";
    $("xmjy2").style.display="block";
    //��ʾ����Ŀ�´���Ϣ��
    $("rwxd1").style.display="block";
    $("rwxd2").style.display="block";
}
/**
 * ����ҵ�����ݣ���δ�������̣�
 */
function f_existInit(){
    f_displayUI();
    //ί����Ϣ
    var infoSql=" select entrust_id,entrust_no,inputer_id,inputer,to_char(inputer_date,'yyyy-mm-dd') as inputer_date,"
                +" dept_id,dept_name,client,entrust_subject,entrust_way,entrust_explain,entrust_way_no,opposite_linkman,"
                +" opposite_phone,opposite_org,our_linkman,our_phone,our_org,remark"
                +" from ta_project_entrust_record"
                +" where entrust_id='"+entrustId+"'";
    dataset1.Open(infoSql);
    //alert("infoSql:"+infoSql);
    f_AttachInit(true);
    $("entrust_type").disabled=true;
    //ί������
    var taskSql=" select oid as task_id, entrust_oid, entrust_type, proj_id, proj_name, design_id, custom_proj_id,"
            +" custom_proj_name, ascription, province, belong_orgid, belong_org, profession_property, proj_type,"
            +" responsible_orgid, responsible_org, proj_level, add_entrust_phaseid, add_entrust_phase,undo_entrust_phaseid,"
            +"  undo_entrust_phase, dimensions, investment,to_char(expect_date,'yyyy-mm-dd') as expect_date, other_request,"
            +" used_phaseid, used_phase,to_char(approval_date,'yyyy-mm-dd') as approval_date,entrust_status,parent_id"
            +" from ta_project_task_record"
            +" where oid='"+taskId+"'";
    //alert("taskSql:"+taskSql);
    dataset2.Open(taskSql);
    
    f_displayInfoByType($("entrust_type").value);

    //������
    var planSql=" select oid as plan_id, task_oid, design_phasesid, design_phases, proj_level,"
        +" specialitys_id, specialitys,to_char(task_confirmdate,'yyyy-mm-dd') as task_confirmdate,"
        +" to_char(task_expectdate,'yyyy-mm-dd') as task_expectdate, m_deptid, m_dept, j_deptid, j_dept, receive_userid,"
        +" receive_user, task_sponsorid, task_sponsor, apply_deptid, apply_dept, apply_userid, apply_user, status,nc"
        +" from ta_project_task_plan"
        +" where task_oid='"+taskId+"'";
    dataset3.Open(planSql);
    if(!(IsSpace(dataset3.Fields.Field['status'].Value)||(dataset3.Fields.Field['status'].Value=="�ݴ�"))){
        $("actName").innerText = dataset3.Fields.Field['status'].Value;
    }
    $("workflowControl_start").style.display="block";
    if(!(IsSpace($("design_phases").value))){
        fcpubdata.cc_form_instanceid=SqlToField("select cc_form_instanceid from ta_project_task_plan where task_oid='"+taskId+"'");
    }
    if(!IsSpace($("nc").value)){
        $("nc_describe").innerText=$("nc").value;
        $("planAddBtn").disabled=true;
        $("plan_phases1").setAttribute("colSpan","2");
        $("plan_phases2").style.display="none"; 
        $("proj_level3").disabled=true;
        hideOrShowTabByName('������Ϣ','hide');
    }
}
/**
 * ����ί��������ʾ������Ϣ
 * @param {Object} entrustType
 */
function f_displayInfoByType(entrustType){
    if(entrustType=="project_new"){
        $("xmxx").setAttribute("rowSpan","4");
        $("custom_proj_name").readOnly=false;
        $("custom_proj_id").readOnly=false;
        $("proj_type_label").setAttribute("colSpan","3");
        $("responsible_org1").style.display="none";
        $("responsible_org2").style.display="none";
        $("proj_name").readOnly=false;
        $("star").style.display="none";
        $("btn_relate").style.display="none";//��Ʊ�š��������ƶ����ܱ�ѡ��
        $("xm5").style.display="none";
        $("cx").style.display="none";
        $("planTypeBtn").style.display="none";
    }else if(entrustType=="phase_new"){
        $("cx").style.display="none";
        $("proj_name").readOnly=true;
        $("design_id").readOnly=true;
        $("ascription").disabled=true;
        $("province").disabled=true;
        $("belong_orgid").disabled=true;
        $("profession_property").disabled=true;
        $("proj_type").disabled=true;
        $("rw_phase_label").innerText="�����׶�";
        $("gljb").setAttribute("colSpan","3");
        $("fzjg1").style.display="none";
        $("fzjg2").style.display="none";
    }else if(entrustType=="phase_update"){
        $("rwxx_label").innerText="������ƽ׶�";
        $("rw_phase_label").innerText="�׶�ѡ��";
        $("proj_name").readOnly=true;
        $("design_id").readOnly=true;
        $("ascription").disabled=true;
        $("province").disabled=true;
        $("belong_orgid").disabled=true;
        $("profession_property").disabled=true;
        $("proj_type").disabled=true;
    }
}

/**
 * ��Ŀ���Ž��鵥��ϸ��ʼ��
 */
function f_OfferDetailInit(){
    var sql=" select oid as detail_id, plan_oid, org_id, org_name, speciality_id, speciality_name,"
           +" dept_id, dept_name, case is_main when 0 then '��' else '��' end as is_main, memo,";
           if(IsSpace($("nc").value)){
                if(opType=="view"){
                    sql+=" null as a,null as b,null as c";                  
                }else{
                    var remark4=SqlToField("select f_getSecondRemark4('"+orgId+"') from dual");
                    if(actId==actIds.actId2||actId==actIds.actId6){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" null as a,case when f_getSecondOrgId('"+orgId+"')=org_id then 'ָ������' else null end as b,null as c";                          
                        }else{
                            sql+=" null as a,null as b,null as c";
                        }
                    }else if(actId==actIds.actId1||actId==actIds.actId3||actId==actIds.actId5){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" '�޸�רҵ' as a,case when f_getSecondOrgId('"+orgId+"')=org_id then 'ָ������' else null end as b,'ɾ��' as c";                            
                        }else{
                            sql+=" '�޸�רҵ' as a,null as b,'ɾ��' as c";
                        }
                    }else if(actId==actIds.actId4){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" case when f_getSecondOrgId('"+orgId+"')=org_id then '�޸�רҵ' else null end as a,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then 'ָ������' else null end as b,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then 'ɾ��' else null end as c";                            
                        }else{
                            sql+=" case when f_getSecondOrgId('"+orgId+"')=org_id then '�޸�רҵ' else null end as a,"
                                +" null as b,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then 'ɾ��' else null end as c";
                        }
                    }else{
                        sql+=" null as a,null as b,null as c";
                    }
                }
           }else{
                sql+=" null as a,null as b,null as c";
           }
           
        sql+=" from ta_project_task_plan_detail where plan_oid='"+$("plan_id").value+"'";
        offerSql=sql;
    //alert("sql:"+sql);
    dataset4.Open(sql);
}

/**
 * ���������ʼ��
 */
function f_opinionInit(){
    var sql=" select ideal_id,ideal_peoplename,ideal_departname,ideal_result,ideal_conten,"
           +" to_char(ideal_date,'yyyy-mm-dd hh24:mi') as ideal_date,action_name,'�鿴' as a "
           +" from ta_project_approval_opinion"
           +" where businessid ='"+$("plan_id").value+"' order by ideal_id asc";
    //alert("�������sql = "+sql);
    dataset5.Open(sql);
}
/**
 * ��ͬ�����̻��ڽ����ҵ���ʼ��
 */
function f_wfInit(){
    if(actId==actIds.actId1){
        //hideOrShowTabByName('������Ϣ','hide');
        if(!f_HqMarketerInit()){
            return ;
        }
        if(userType=="0"){
            $("isHqMarketer").value="0";
            $("nextAction").innerText=actNames.actionname3;
        }else{
            $("isHqMarketer").value="1";
            $("nextAction").innerText=actNames.actionname2;
        }
        $("monitor").style.display="none";
        f_actUserInit1();
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("shjl").style.display="none";
        $("shyj").style.display="none";     
        if(SqlToField("select count(*) as num from ta_project_approval_opinion where businessid ='"+$("plan_id").value+"'")==0){
            $("yyyj1").style.display="none";
            $("yyyj2").style.display="none";
        }else{
            $("over").style.display="block";
        }
    }else{
        $("save").style.display="none";//����ɻ�������ر��水ť
        //�����������ж�ҳ��Ԫ�ؽ���ֻ������ȿ���
        $("client").readOnly=true;
        $("entrust_way").disabled=true;
        $("entrust_way_no").readOnly=true;
        $("entrust_explain").readOnly=true;
        $("upload_td").setAttribute("colSpan","5");
        $("upload_btn").style.display="none";
        $("proj_name").readOnly=true;
        $("design_id").readOnly=true;
        $("btn_relate").style.display="none";
        $("custom_proj_name").readOnly=true;
        $("custom_proj_id").readOnly=true;
        $("ascription").disabled=true;
        $("province").disabled=true;
        $("belong_orgid").disabled=true;
        $("profession_property").disabled=true;
        $("proj_type").disabled=true;
        
        $("cx1").setAttribute("colSpan","5");
        $("cx2").style.display="none";
        
        $("wtjd1").setAttribute("colSpan","2");
        $("wtjd2").style.display="none";
        $("expect_date").disabled=true;
        $("dimensions").readOnly=true;
        $("investment").readOnly=true;
        $("other_request").readOnly=true;
        $("opposite_linkman").readOnly=true;
        $("opposite_phone").readOnly=true;
        $("opposite_org").readOnly=true;
        $("dimensions").readOnly=true;
        $("our_linkman").readOnly=true;         
        $("our_phone").readOnly=true;
        $("our_org").readOnly=true;
        $("remark").readOnly=true;
        
        $("planTypeBtn").style.display="none";
        if(!(actId==actIds.actId3||actId==actIds.actId4)){
            $("planAddBtn").style.display="none";
        }       
        if(actId==actIds.actId6||actId==actIds.actId7||actId==actIds.actId8){           
            $("plan_phases1").setAttribute("colSpan","2");
            $("plan_phases2").style.display="none";
            
            $("proj_level3").disabled=true;
            $("charger_orgid").disabled=true;
        }
    }
    
    if((actId==actIds.actId1)||(actId==actIds.actId2)){
        //$("rwxd1").style.display="none";
        //$("rwxd2").style.display="none";
    }
    
    if(actId==actIds.actId2){
        //sql=" select wmsys.wm_concat(b.user_name) as id,wmsys.wm_concat(b.user_realname) as name"
        sql=" select b.user_name as id,b.user_realname as name"
           +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
           +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename1+"'"
           +" order by b.user_sn asc";         
        var ret=executeSelect(sql,1,1);
        if(ret.length>0){
            $("DYNAMICPERFORMER").value=ret[0][0];
            $("DYNAMICPERFORMER_NAME").value=ret[0][1];
        }
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname3;
    }
    
    if(actId==actIds.actId3){
        $("workflowControl_selectAct").value="taskEntrust_wp1_act5";
        sql=" select b.user_name as id,b.user_realname as name"
           +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
           +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename2+"'"
           +" order by b.user_sn asc";
        var ret=executeSelect(sql,1,1);
        if(ret.length>0){
            $("DYNAMICPERFORMER").value=ret[0][0];
            $("DYNAMICPERFORMER_NAME").value=ret[0][1];
        }
    }
    
    if((actId==actIds.actId3)||(actId==actIds.actId4)||(actId==actIds.actId5)||(actId==actIds.actId6)||(actId==actIds.actId7)){
        $("rwxd1").style.display="block";
        $("rwxd2").style.display="block";       
    }

    if((actId==actIds.actId3)||(actId==actIds.actId4)||(actId==actIds.actId6)||(actId==actIds.actId7)){
        $("shjl").style.display="none";
    }
    
    if((actId==actIds.actId3||actId==actIds.actId4||actId==actIds.actId5)&&($("status").value=="�ȴ�����")){
        $("workflowControl_complete").style.display="none";
        hideOrShowTabByName('���Ž��鵥','hide');
        alert("�������ǵȴ�����״̬�����ܷ������̣�");
    }
    
    if(!((actId==actIds.actId3)||((actId==actIds.actId4)||(actId==actIds.actId5)))){
         hideOrShowTabByName('���Ž��鵥','hide');
    }
        
    if(actId==actIds.actId3){
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname5;
    }
    if(actId==actIds.actId4){
        $("shxx").style.display="none";
        $("nextAction").innerText=actNames.actionname3;
    }
    
    if(actId==actIds.actId5){
        if(f_existZf()){
            $("existZf").value=0;
            var sql1=" select b.user_name,b.user_realname"
                    +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
                    +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename3+"'"
                    +" order by b.user_sn asc";
            var ret1=executeSelect(sql1,1,1);
            $("DYNAMICPERFORMER").value=ret1[0][0];
            $("DYNAMICPERFORMER_NAME").value=ret1[0][1];
            $("nextAction").innerText=actNames.actionname6;
        }else{
            $("existZf").value=1;
            var ret=f_getMdeptLeaderSql();
            var rets=executeSelect(ret,1,1);
            //���崦�쵼
            $("DYNAMICPERFORMER").value=rets[0][0];
            $("DYNAMICPERFORMER_NAME").value=rets[0][2];
            if(IsSpace(DYNAMICPERFORMER)){
                alert("û���ҵ����첿�ŵ��쵼��");
            }
            $("nextAction").innerText=actNames.actionname7;
        }
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
    }
    if(actId==actIds.actId6){
        var ret=f_getMdeptLeader();
        //���崦�쵼
        $("DYNAMICPERFORMER").value=ret[0][0];
        $("DYNAMICPERFORMER_NAME").value=ret[0][1];
        if(IsSpace(DYNAMICPERFORMER)){
            alert("û���ҵ����첿�ŵ��쵼��");
        }
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname7;
    }
    if(actId==actIds.actId7){
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname8;
        $("nextUserlabel").innerText="����������ѡ��";
    }
    if(actId==actIds.actId8){
        $("shxx").style.display="none";
        $("button_wchd").setAttribute("value","����");
        $("nextAction").innerText=actNames.actionname9;
    }
    if(!IsSpace($("parent_id").value)){
        $("btn_relate").style.display="none";
    }
}

/**
 * ��ȡ���崦�쵼SQL
 */
function f_getMdeptLeaderSql(){
    var strSql="select f_getsecondremark4('"+$("m_deptid").value+"') from dual";
    var sql="";
    var remark4=SqlToField(strSql);
    if(remark4=="shanghai"||remark4=="chengdu"||remark4=="guangdong"){
        sql=" select d.user_name as id,'1' as parent_id,d.user_realname as name"
           +" from td_sm_role a, td_sm_userrole b, td_sm_orguser c, td_sm_user d"
           +" where a.role_id = b.role_id and b.user_id = c.user_id and c.user_id = d.user_id"
           +" and a.role_name = '"+roles.rolename4+"' and f_getsecondorgid(c.org_id)='"+$("m_deptid").value+"'"
           +" order by d.user_sn asc";  
    }else{
        sql=" select d.user_name as id,'1' as parent_id,d.user_realname as name"
           +" from td_sm_role a, td_sm_userrole b, td_sm_orguser c, td_sm_user d"
           +" where a.role_id = b.role_id and b.user_id = c.user_id and c.user_id = d.user_id"
           +" and a.role_name = '"+roles.rolename5+"' and c.org_id='"+$("m_deptid").value+"'"
           +" order by d.user_sn asc";
    }
    return sql;
}

/**
 * ��ȡ���崦�쵼
 */
function f_getMdeptLeader(){
    var strSql="select f_getsecondremark4('"+$("m_deptid").value+"') from dual";
    var sql="";
    var remark4=SqlToField(strSql);
    if(remark4=="shanghai"||remark4=="chengdu"||remark4=="guangdong"){
        sql=" select wmsys.wm_concat(d.user_name) as user_name, wmsys.wm_concat(d.user_realname) as user_realname"
           +" from td_sm_role a, td_sm_userrole b, td_sm_orguser c, td_sm_user d"
           +" where a.role_id = b.role_id and b.user_id = c.user_id and c.user_id = d.user_id"
           +" and a.role_name = '"+roles.rolename4+"' and f_getsecondorgid(c.org_id)='"+$("m_deptid").value+"'"
           +" order by d.user_sn asc";  
    }else{
        sql=" select wmsys.wm_concat(d.user_name) as user_name, wmsys.wm_concat(d.user_realname) as user_realname"
           +" from td_sm_role a, td_sm_userrole b, td_sm_orguser c, td_sm_user d"
           +" where a.role_id = b.role_id and b.user_id = c.user_id and c.user_id = d.user_id"
           +" and a.role_name = '"+roles.rolename5+"' and c.org_id='"+$("m_deptid").value+"'"
           +" order by d.user_sn asc";
    }   
    var ret = executeSelect(sql,1,1);
    return ret;
}
/**
 * �ı���˽����¼�
 */
function f_changeAgree(){
    if(actId==actIds.actId2){
        if($("agree").value=="ͬ��"){
            $("shxx").style.display="block";
            $("button_wchd").setAttribute("value","�ύ");
            $("nextAction").innerText=actNames.actionname3;
        }else if($("agree").value=="��ͬ��"){
            $("shxx").style.display="none";
            $("button_wchd").setAttribute("value","����");
            $("nextAction").innerText=actNames.actionname1;
        }
    }else if(actId==actIds.actId5){
        if($("agree").value=="ͬ��"){
            $("shxx").style.display="block";
            $("button_wchd").setAttribute("value","�ύ");
            if(f_existZf()){
                $("nextAction").innerText=actNames.actionname6; 
            }else{
                $("nextAction").innerText=actNames.actionname7;
            }
        }else if($("agree").value=="��ͬ��"){
            $("shxx").style.display="none";
            $("button_wchd").setAttribute("value","����");
            $("nextAction").innerText=actNames.actionname3;
        }
    }else if(actId==actIds.actId8){
        if($("agree").value=="ͬ��"){
            $("button_wchd").setAttribute("value","����");
            $("nextAction").innerText=actNames.actionname9;
        }else if($("agree").value=="��ͬ��"){
            $("button_wchd").setAttribute("value","����");
            $("nextAction").innerText=actNames.actionname7;
        }
    }
}
/**
 * �Ƿ����֣��
 */
function f_existZf(){
    var sql="select count(*) as num from ta_project_task_plan_detail t where t.org_name like '֣��%' and t.plan_oid='"+$("plan_id").value+"'";
    if(SqlToField(sql)==0){
        //alert("�����ڼ�¼");
        return false;
    }else{
        //alert("���ڼ�¼");
        return true;
    }
}
/**
 * ��ʼ����һ������ʱ��Ҫָ������һ������ִ����
 */
function f_actUserInit1(){
    var sql="";
    if(userType=="0"){
        //sql=" select wmsys.wm_concat(b.user_name) as id,wmsys.wm_concat(b.user_realname) as name"
        sql=" select b.user_name as id,b.user_realname as name"
           +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
           +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename1+"'"
           +" order by b.user_sn asc";
    }else if((userType=="1")||(userType=="2")){
        //sql=" select wmsys.wm_concat(b.user_name) as id,wmsys.wm_concat(b.user_realname) as name"
        sql=" select b.user_name as id,b.user_realname as name"
           +" from td_sm_role a,td_sm_user b,td_sm_userrole c,td_sm_orguser d"
           +" where a.role_id=c.role_id and b.user_id=c.user_id and b.user_id=d.user_id and a.role_name='"+roles.rolename5+"' and d.org_id='"+orgId+"'"
           +" order by b.user_sn asc";      
    }else if(userType=="3"){
        //sql=" select wmsys.wm_concat(b.user_name) as id,wmsys.wm_concat(b.user_realname) as name"
        sql=" select b.user_name as id,b.user_realname as name"
           +" from td_sm_role a,td_sm_user b,td_sm_userrole c,td_sm_orguser d"
           +" where a.role_id=c.role_id and b.user_id=c.user_id and b.user_id=d.user_id and a.role_name='"+roles.rolename4+"' and f_getsecondorgid(d.org_id)=f_getsecondorgid('"+orgId+"')"
           +" order by b.user_sn asc";
    }
    //alert("sql:"+sql);
    var ret=executeSelect(sql,1,1);
    if(ret.length>0){
        $("DYNAMICPERFORMER").value=ret[0][0];
        $("DYNAMICPERFORMER_NAME").value=ret[0][1];
    }
}
/**
 * ���������ͳ�ʼ��
 * 0���ܲ��г�����Ա
 * 1���ܲ����г�����Ա
 * 2��֣����Ա
 * 3�������ֹ�˾��Ա
 */
function f_HqMarketerInit(){
    var sql=" ";
    var sql=" select b.org_id,f_getSecondRemark4(b.org_id) as remark4 from td_sm_user a,td_sm_organization b,td_sm_orguser c"
           +" where a.user_id=c.user_id and b.org_id=c.org_id"
           +" and a.user_id='"+userId+"'";
    //alert("sql:"+sql);
    var ret = executeSelect(sql,1,1);
    if(ret.length>0){
        var orgid=ret[0][0];
        var remark4=ret[0][1];
        if(remark4=="zongbu"){
            if(orgid==hq_orgId){
                userType="0";
            }else{
                userType="1";
            }
        }else if(remark4=="zhengzhou"){
            userType="2";
        }else if((remark4=="shanghai")||(remark4=="guangdong")||(remark4=="chengdu")){
            userType="3";
        }
        return true;
    }else{
        if(IsSpace($("entrust_id").value)){
            alert("ϵͳ����Ա���ܷ�������ί�У�");            
        }
        $("save").style.display="none";
        return false;
    }
}
function f_pickRoleUser(){
    var rootName="";
    var strSql="";
    if(actId==actIds.actId1){
        //userType �û����ڻ�������������   0���ܲ��г�����Ա  1���ܲ����г�����Ա  2��֣����Ա  3�������ֹ�˾��Ա
        if(userType=="0"){
            rootName=roles.rolename1;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename1+"'"
               +" order by b.user_sn asc";
        }else if((userType=="1")||(userType=="2")){
            rootName=roles.rolename5;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c,td_sm_orguser d"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and b.user_id=d.user_id and a.role_name='"+roles.rolename5+"' and d.org_id='"+orgId+"'"
               +" order by b.user_sn asc";
        }else if(userType=="3"){
            rootName=roles.rolename4;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c,td_sm_orguser d"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and b.user_id=d.user_id and a.role_name='"+roles.rolename4+"' and f_getsecondorgid(d.org_id)=f_getsecondorgid('"+orgId+"')"
               +" order by b.user_sn asc";
        }
    }else if(actId==actIds.actId2){
        rootName=roles.rolename1;
        strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
             +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
             +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename1+"'"
             +" order by b.user_sn asc";
    }else if(actId==actIds.actId3){
        if($("workflowControl_selectAct").value=="taskEntrust_wp1_act4"){
            openTree('user',DYNAMICPERFORMER,DYNAMICPERFORMER_NAME,true);
            return ;
        }else if($("workflowControl_selectAct").value=="taskEntrust_wp1_act5"){
            rootName=roles.rolename2;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename2+"'"
               +" order by b.user_sn asc";
        }
    }else if(actId==actIds.actId5){
        if($("existZf").value==0){
            //alert("֣�ּ����г����쵼");
            rootName=roles.rolename3;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename3+"'"
               +" order by b.user_sn asc";
        }else{
            rootName="���첿���쵼";
            strSql=f_getMdeptLeaderSql();
        }
    }else if(actId==actIds.actId6){
        rootName="���첿���쵼";
        strSql=f_getMdeptLeaderSql();
    }else if(actId==actIds.actId7){
        var org_id=$("m_deptid").value;
        var hidden_orgid=SqlToField("select wmsys.wm_concat(distinct (t.org_id)) from td_sm_organization t  connect by t.parent_id = prior t.org_id start with t.org_id in ('"+org_id+"')");
        var obj={
            flag:"1",
            sql:"",
            title:"ѡ����������������",
            isRadio:true,
            ObjId:DYNAMICPERFORMER,
            ObjName:DYNAMICPERFORMER_NAME,
            rootId:"0",
            rootName:"����",
            expandLevel:"2",
            isShowType:"hidden",
            params:hidden_orgid
        };
        obj.sql="select org_id as id ,'0' as parent_id,t.org_name as name from td_sm_organization t  where t.org_id='"+org_id+"'"
           +" union all select distinct (t.org_id) id, t.parent_id, t.org_name as name  from td_sm_organization t where t.org_id!='"+org_id+"'"
           +" connect by t.parent_id = prior t.org_id  start with t.org_id in ('"+org_id+"') union all "
           +" select to_char(u.user_name) as id,ou.org_id as parent_id,u.user_realname as name   from td_sm_user u, td_sm_orguser ou"
           +" where u.user_id = ou.user_id and ou.org_id in (select distinct (t.org_id) id  from td_sm_organization t "
           +"  connect by t.parent_id = prior t.org_id   start with t.org_id in ('"+org_id+"'))"
        //alert(obj.sql);
        OpenTreeFromSql(obj);
        
        return ;
    }
    var obj={ 
         flag:"1",
         sql:"",
         title:"ѡ����һ��ִ����",
         isRadio:true,
         ObjId:DYNAMICPERFORMER,
         ObjName:DYNAMICPERFORMER_NAME,
         rootId:"1",
         rootName:rootName
    };
    obj.sql=strSql;
    OpenTreeFromSql(obj);
}
/**
 * ������ʼ��
 */
function f_AttachInit(delflag){
    var businessid=$("entrust_id").value;
    var obj={
        cc_form_instanceid:"",
        businessid:businessid,
        divid:"upload_td",
        showtype:"table",//Ϊ��ʱΪ���ûص�������һ��(common),���(table)
        delflag:delflag,//true��ɾ��,false:����ɾ��,Ϊ��ʱΪ����ɾ����Ĭ��Ϊfalse
        callback:""//�ص��������ص���������showtypeΪ��ʱ�Ż�ִ�С�
    }
    InitAttach(obj);    
}
/* ������� */
/**
 * �ı�ί�з�ʽ
 */
function f_changeWay(isClear){
    if(isClear){
        $("entrust_way_no").value="";
        $("entrust_explain").value="";      
    }
    var entrust_way = $("entrust_way").value;
    switch (entrust_way) {
        case "1":
            $("way_no1").style.display = "none";
            $("way_no2").style.display = "none";
            $("way_explain1").innerText = "�绰˵��";
            $("way_explain2").setAttribute("colSpan", "5");
            break;
        case "2":
            $("way_no1").style.display = "none";
            $("way_no2").style.display = "none";
            $("way_explain1").innerText = "��Դ˵��";
            $("way_explain2").setAttribute("colSpan", "5");
            break;
        case "3":
            $("way_no1").style.display = "block";
            $("way_no2").style.display = "block";
            $("way_no1").innerText = "�����ĺ�";
            $("way_explain1").innerText = "���ı���";
            $("way_explain2").setAttribute("colSpan", "3");
            break;
        case "4":
            $("way_no1").style.display = "block";
            $("way_no2").style.display = "block";
            $("way_no1").innerText = "�б���";
            $("way_explain1").innerText = "�б���";
            $("way_explain2").setAttribute("colSpan", "3");
            break;
    }
}
/**
 * ��Ŀ��Ϣ-����������Ŀ
 */
function f_relate(){
    //id btn_relate
    var url = getOpenUrlByDjid('20100721104724062482');
    var obj = window.showModalDialog(url,obj,"dialogWidth=800px;dialogHeight=390px");
    if(null!=obj){
        $("proj_id").value=obj.proj_id;//������ĿID
        $("proj_name").value=obj.proj_name;//��������
        $("design_id").value=obj.design_id;//��Ʊ��
        $("custom_proj_name").value=obj.custom_proj_name;//�ͻ���Ŀ����
        $("custom_proj_id").value=obj.custom_proj_id;//�ͻ���Ŀ���
        $("ascription").value=obj.ascription;//��Ŀ����
        $("province").value=obj.province;//ʡ��
        $("belong_orgid").value=obj.belong_orgid;//��������ID
        $("belong_org").value=obj.belong_org;//������������
        $("profession_property").value=obj.profession_property;//רҵ����
        $("proj_type").value=obj.proj_type;//��������
        $("responsible_orgid").value=obj.responsible_orgid;//�������ID
        $("responsible_org").value=obj.responsible_org;//�����������
        $("proj_level").value=obj.proj_level;//������
        $("used_phaseid").value=obj.used_phaseid;//������׶�ID
        $("used_phase").value=obj.used_phase;//������׶�����
        $("approval_date").value=obj.approval_date;//��������
        $("add_entrust_phase").value="";
        $("undo_entrust_phase").value="";
    }
}
/**
 * ѡ��������ƽ׶�
 */
function f_pickUndoPhase(){
    var obj={ 
        flag:"1",
        sql:"",
        title:"���Ž׶�",
        isRadio:false,
        ObjId:undo_entrust_phaseid,
        ObjName:undo_entrust_phase,
        rootId:"0",
        rootName:"����ֹ�׶�"
    };
    obj.sql=" select c.oid as id,'0' as parent_id,c.design_phasename as name"
           +" from ta_project_basic_info a,ta_project_approval b,ta_project_approval_phase c"
           +" where a.proj_id = b.proj_id and b.approval_id = c.approval_id"
           +" and a.isvalid != '1' and b.is_pass = '��'"
           +" and c.proj_id='"+$("proj_id").value+"' and c.design_status='1'";
    OpenTreeFromSql(obj);
}
/**
 * ѡ�������׶� ��������Ŀ��������Ŀ��
 */
function f_pickNewPhase(){
    var phaseId=$("add_entrust_phaseid").value;
    var obj={
        flag:"1",
        sql:"",
        title:"����ί�н׶�",
        isRadio:false,
        ObjId:add_entrust_phaseid,
        ObjName:add_entrust_phase,
        rootId:"0",
        rootName:"ί�н׶�",
        callback:f_isAlterPhase()//�ô�û��������
    };
    if($("entrust_type").value=="project_new"){
        obj.sql=" select t.design_phaseid as id,'0' as parent_id,t.design_phasename as name"
               +" from ta_project_design_phase t order by t.order_number";
    }else{
        var phaseNames = $("used_phase").value;
        var phaseName = phaseNames.split(",");
        var phasename = "";
        for(var i=0;i<phaseName.length;i++){
            if(!IsSpace(phaseName[i])){
                if(IsSpace(phasename)){
                    phasename = "'"+phaseName[i]+"'";
                }else{
                    phasename += ",'"+phaseName[i]+"'";
                }
            }
        }
        var tmp="";
        if(phasename.indexOf("����")!=-1||phasename.indexOf("ʩ��")!=-1){
            tmp=",'һ�׶�'";
        }
        if(phasename.indexOf("һ�׶�")!=-1){
            tmp=",'����','ʩ��'";
        }
        obj.sql=" select t.design_phaseid as id,'0' as parent_id,t.design_phasename as name"
               +" from ta_project_design_phase t where t.design_phasename not in ("+phasename+tmp+") order by t.order_number";
    }
    //alert(obj.sql);
    OpenTreeFromSql(obj);
}
function f_isAlterPhase(phaseId){
    $("design_phasesid").value="";
    $("design_phases").value="";
}
/**
 * ѡ���Ž׶�
 */
function f_pickPlanPhase(){ 
    var obj={ 
        flag:"1",
        sql:"",
        title:"���Ž׶�",
        isRadio:false,
        ObjId:design_phasesid,
        ObjName:design_phases,
        rootId:"0",
        rootName:"�ɰ��Ž׶�"
    };
    var phaseNames = $("add_entrust_phase").value;
    var phaseName = phaseNames.split(",");
    var phasename = "";
    for(var i=0;i<phaseName.length;i++){
        if(!IsSpace(phaseName[i])){
            phasename += ",'"+phaseName[i]+"'";         
        }
    }
    phasename = phasename.substring(1);
    obj.sql=" select t.design_phaseid as id,'0' as parent_id,t.design_phasename as name"
           +" from ta_project_design_phase t where t.design_phasename in ("+phasename+") order by t.order_number";
    OpenTreeFromSql(obj);
}

/* ҵ����� */
/**
 * ί����Ϣ-�ϴ�����
 */
function f_upload(){    
    var sbusinessid = $("entrust_id").value;
    var attachObj = new Attachment({
        businessid:sbusinessid,//ҵ������ID
        djsn:$("SKbillsheet").dj_sn,//��ID
        cc_form_instanceid:"",//��businessid������һ������
        divid:"upload_td" ,  //div����ID
        fileMaxCount:"1",//�����ϴ����ļ�������Ĭ��Ϊ100
        showtype:"table"//Ϊ��ʱΪ���ûص�������ʽ��һ��(common),���(table)
    });
    attachObj.showUpload();//���������ϴ�����
}
/**
 * ������水ť����
 */
function f_save(){
    if(IsSpace($("entrust_no").value)){//û�С�ί����Ϣ���͡�ί���������ݵ����
        f_entrustNo();
        f_saveInfo();
    }else{
        if(f_updateData()){
            alert("����ɹ���");
        }
    }
}
function f_saveInfo(){
    if(f_validateInfo()){
        if(f_insertData()){
            alert("����ɹ���"); //\n����д������Ϣ��
            $("entrust_type").disabled=true;
            //��ʾ���˿�������Ϣ��
            $("xm1").style.display="block";
            $("xm2").style.display="block";
            $("xm3").style.display="block";
            $("xm4").style.display="block";
            $("xm5").style.display="block";
            $("cx").style.display="block";
            $("rw1").style.display="block";
            $("rw2").style.display="block";
            $("rw3").style.display="block";
            $("rw4").style.display="block";
            $("qt1").style.display="block";
            $("qt2").style.display="block";
            $("qt3").style.display="block";
            $("qt4").style.display="block";
            $("xmjy1").style.display="block";
            $("xmjy2").style.display="block";
            f_displayInfoByType($("entrust_type").value);
            $("workflowControl_start").style.display="block";
            $("planTypeBtn").disabled=false;
        }else{
            alert("����ʧ�ܣ�errorCode:"+msg+" | sql:"+sql);
            return false;
        }
    }
}
function f_validateInfo(){
    if(IsSpace($("entrust_type").value)){
        alert("ί�����Ͳ���Ϊ�գ�");
        return false;
    }else if(IsSpace($("client").value)){
        alert("ί�е�λ����Ϊ�գ�");
        return false;
    }else if(IsSpace($("entrust_way").value)){
        alert("ί�����Ͳ���Ϊ�գ�");
        return false;
    }
    return true;
}
function f_validateTask(){
    if(f_validateInfo()){
        if($("entrust_type").value=="project_new"){
            if(IsSpace($("proj_name").value)){
                alert("��Ŀ���Ʋ���Ϊ�գ�");
                return false;
            }else if(IsSpace($("ascription").value)){
                alert("��Ŀ��������Ϊ�գ�");
                return false;
            }else if(IsSpace($("province").value)){
                alert("ʡ�в���Ϊ�գ�");
                return false;
            }else if(IsSpace($("belong_orgid").value)){
                alert("������������Ϊ�գ�");
                return false;
            }else if(IsSpace($("profession_property").value)){
                alert("רҵ���Բ���Ϊ�գ�");
                return false;
            }else if(IsSpace($("proj_type").value)){
                alert("�������Ͳ���Ϊ�գ�");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("ί�н׶β���Ϊ�գ�");
                return false;
            }
        }else if($("entrust_type").value=="phase_new"){
            if(IsSpace($("proj_name").value)){
                alert("�����������Ŀ��");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("�����׶β���Ϊ�գ�");
                return false;
            }
        }else if($("entrust_type").value=="phase_update"){
            if(IsSpace($("proj_name").value)){
                alert("�����������Ŀ��");
                return false;
            }else if(IsSpace($("undo_entrust_phase").value)){
                alert("��ֹ�׶β���Ϊ�գ�");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("�����׶β���Ϊ�գ�");
                return false;
            }
        }
        if(IsSpace($("expect_date").value)){
            alert("Ҫ��������ڲ���Ϊ�գ�");
            return false;
        }else if(IsSpace($("dimensions").value)){
            alert("��ƹ�ģ����Ϊ�գ�");
            return false;
        }else if(IsSpace($("investment").value)){
            alert("������Ͷ�ʲ���Ϊ�գ�");
            return false;
        }else if(IsSpace($("other_request").value)){
            alert("����Ҫ����Ϊ�գ�");
            return false;
        }else if(IsSpace($("dimensions").value)){
            alert("��ƹ�ģ����Ϊ�գ�");
            return false;
        }
        else if(IsSpace($("opposite_linkman").value)){
            alert("�Է��ӿ��˲���Ϊ�գ�");
            return false;
        }else if(IsSpace($("opposite_phone").value)){
            alert("�Է��ӿ��˵绰����Ϊ�գ�");
            return false;
        }else if(IsSpace($("opposite_org").value)){
            alert("�Է��ӿڵ�λ����Ϊ�գ�");
            return false;
        }else if(IsSpace($("our_linkman").value)){
            alert("�ҷ��ӿ��˲���Ϊ�գ�");
            return false;
        }else if(IsSpace($("our_phone").value)){
            alert("�ҷ��ӿ��˵绰����Ϊ�գ�");
            return false;
        }else if(IsSpace($("our_org").value)){
            alert("�ҷ��ӿڵ�λ����Ϊ�գ�");
            return false;
        }
        return true;
    }else{
        return false;
    }
}
function f_validatePlan(){
    if(f_validateTask()){
        if(IsSpace($("design_phases").value)){
            alert("��Ŀ���Ž׶β���Ϊ�գ�");
            return false;
        }else if(IsSpace($("proj_level3").value)){
            alert("��������Ϊ�գ�");
            return false;
        }
        if(($("entrust_type").value=="project_new")&&(IsSpace($("charger_orgid").value))){
            alert("�����������Ϊ�գ�");
            return false;
        }
        return true;        
    }else{
        return false;       
    }
}
/**
 * ����ҵ������
 */
function f_insertData(){
    $("task_id").value=getNewCc_form_instanceid(false);
    $("plan_id").value=getNewCc_form_instanceid(false);
    $("status").value="�ݴ�";
    sql=" <no>"
       +" insert into ta_project_entrust_record"
       +" (entrust_id, entrust_no, our_linkman, our_phone, our_org, inputer_id, inputer, inputer_date, dept_id, dept_name,"
       +"  client,entrust_way, entrust_explain, entrust_way_no)"
       +" values"
       +" ('"+$("entrust_id").value+"','"
       +$("entrust_no").value+"','"
       +$("our_linkman").value+"','"
       +$("our_phone").value+"','"
       +$("our_org").value+"','"
       +$("inputer_id").value+"','"
       +$("inputer").value+"',sysdate,'"
       +$("dept_id").value+"','"
       +$("dept_name").value+"','"
       +$("client").value+"','"
       +$("entrust_way").value+"','"
       +$("entrust_explain").value+"','"
       +$("entrust_way_no").value+"')"
       +" </no>"
       +" <no>"
       +" insert into ta_project_task_record"
       +" (oid, entrust_oid, entrust_type,entrust_status,other_request)"
       +" values"
       +" ('"+$("task_id").value+"','"
       +$("entrust_id").value+"','"
       +$("entrust_type").value+"','"
       +$("entrust_status").value+"','��')"
       +" </no>"
       +" <no>"
       +" insert into ta_project_task_plan"
       +" (oid, task_oid,apply_deptid, apply_dept, apply_userid, apply_user, status)"
       +" values"
       +" ('"+$("plan_id").value+"','"
       +$("task_id").value+"','"
       +orgId+"','"
       +orgName+"','"
       +userId+"','"
       +userName+"','"+$("status").value+"')"
       +" </no>";
    var msg=InsertSqls(sql);
    if(IsSpace(msg)){
        //alert("����ҵ�����ݳɹ���");
        return true;
    }else{
        alert("����ҵ������ʧ�ܣ�errorCode:"+msg+" | sql:"+sql);
        return false;
    }
}
/**
 * �޸�ҵ������
 */
function f_updateData(){
    var sql=" <no>"
       +" update ta_project_entrust_record set"
       +" client = '"+$("client").value+"',"
       +" entrust_way = '"+$("entrust_way").value+"',"
       +" entrust_explain = '"+$("entrust_explain").value+"',"
       +" entrust_way_no = '"+$("entrust_way_no").value+"',"
       +" opposite_linkman = '"+$("opposite_linkman").value+"',"
       +" opposite_phone = '"+$("opposite_phone").value+"',"
       +" opposite_org = '"+$("opposite_org").value+"',"
       +" our_linkman = '"+$("our_linkman").value+"',"
       +" our_phone = '"+$("our_phone").value+"',"
       +" our_org = '"+$("our_org").value+"',"
       +" remark = '"+$("remark").value+"'"
       +" where entrust_id='"+$("entrust_id").value+"'"
       +" </no>";
           
       sql+=" <no>"
       +" update ta_project_task_record set"
       +" proj_id = '"+$("proj_id").value+"',"
       +" proj_name = '"+$("proj_name").value+"',"
       
       +" design_id = '"+$("design_id").value+"',"
       +" custom_proj_id = '"+$("custom_proj_id").value+"',"
       +" custom_proj_name = '"+$("custom_proj_name").value+"',"
       +" ascription = '"+$("ascription").value+"',"
       +" province = '"+$("province").value+"',"
       +" belong_orgid = '"+$("belong_orgid").value+"',";
       if(!IsSpace($("charger_orgid").value)){
            sql+=" belong_org = '"+$("belong_orgid").options[$("belong_orgid").selectedIndex].text+"' ,"        
       }
       sql+=" profession_property = '"+$("profession_property").value+"' ,"
       +" proj_type = '"+$("proj_type").value+"' ,";       
       if($("entrust_type").value=="project_new"){
            if(!IsSpace($("charger_orgid").value)){
                sql+=" responsible_orgid = '"+$("charger_orgid").value+"' ,"
                    +" responsible_org = '"+$("charger_orgid").options[$("charger_orgid").selectedIndex].text+"' ,";                
            }
       }else{
            if(!IsSpace($("responsible_orgid").value)){
                sql+=" responsible_orgid = '"+$("responsible_orgid").value+"' ,"
                    +" responsible_org = '"+$("responsible_orgid").options[$("responsible_orgid").selectedIndex].text+"' ,";
            }
       }
       sql+=" proj_level = '"+$("proj_level").value+"' ,"
       +" add_entrust_phaseid = '"+$("add_entrust_phaseid").value+"' ,"
       +" add_entrust_phase = '"+$("add_entrust_phase").value+"' ,"
       +" undo_entrust_phaseid = '"+$("undo_entrust_phaseid").value+"' ,"
       +" undo_entrust_phase = '"+$("undo_entrust_phase").value+"' ,"
       +" dimensions = '"+$("dimensions").value+"' ,"
       +" investment = '"+$("investment").value+"' ,"
       +" expect_date = to_date('"+$("expect_date").value+"','yyyy-mm-dd'),"
       +" other_request = '"+$("other_request").value+"' ,"
       +" used_phaseid = '"+$("used_phaseid").value+"' ,"
       +" used_phase = '"+$("used_phase").value+"' ,"
       +" approval_date = to_date('"+$("approval_date").value+"','yyyy-mm-dd'),"
       +" entrust_status = '"+$("entrust_status").value+"'"
       +" where oid='"+$("task_id").value+"'"
       +" </no>"
       +" <no>"
       +" update ta_project_task_plan set"
       +" design_phasesid = '"+$("design_phasesid").value+"' ,"
       +" design_phases = '"+$("design_phases").value+"' ,"
       +" proj_level = '"+$("proj_level3").value+"' ,"
       +" task_confirmdate = to_date('"+$("task_confirmdate").value+"','yyyy-mm-dd'),"
       +" task_expectdate = to_date('"+$("expect_date").value+"','yyyy-mm-dd'),"
       +" receive_userid = '"+$("receive_userid").value+"' ,"
       +" receive_user = '"+$("receive_user").value+"' ,"
       +" task_sponsorid = '"+$("task_sponsorid").value+"' ,"
       +" task_sponsor = '"+$("task_sponsor").value+"' ,"
       +" status = '"+$("status").value+"'"
       +" where oid='"+$("plan_id").value+"'"
       +" </no>";
    var msg=InsertSqls(sql);
    if(IsSpace(msg)){
        //alert("����ҵ�����ݳɹ���");
        return true;        
    }else{
        alert("�޸�ҵ������ʧ�ܣ�errorCode:"+msg+" | sql:"+sql);
        return false;
    }
}

/**
 * ��Ŀ���Ž��鵥-����רҵ����
 */
function f_newOfferSp(){
    var url = getOpenUrlByDjid("20100713175839328371");//����רҵ���ű�ID
    var obj = new Object();
    obj.plan_id = $("plan_id").value;//������ID
    var ret = window.showModalDialog(url,obj,"dialogWidth=600px;dialogHeight=300px");
    f_feedbackPlan();
    //�����޸ĺ�������
    f_OfferDetailInit();
    f_feedbackPlanDept();
}
/**
 * �ڰ��Ž�����ϸ���޸�רҵ
 */
function f_updateSpeciality(){
    var url=getOpenUrlByDjid("20100713175839328371");//�޸�רҵ���ű�ID
    var obj=new Object();
    obj.detail_id=dataset4.Fields.Field['detail_id'].Value;//רҵ����ID
    var ret=window.showModalDialog(url,obj,"dialogWidth=600px;dialogHeight=300px");
    f_OfferDetailInit();
    //�����޸ĺ�������
    f_feedbackPlan();
    f_feedbackPlanDept();
}
/**
 * ���������żƻ�
 */
function f_feedbackPlan(){    
    var specialitys="";
    var specialitys_id="";
    var m_dept="";
    var m_deptid="";
    var j_dept="";
    var j_deptid="";
    var sql1 =" select wmsys.wm_concat(distinct speciality_name) as speciality_name,"
            +" wmsys.wm_concat(distinct speciality_id) as speciality_id"
            +" from ta_project_task_plan_detail where plan_oid = '"+$("plan_id").value+"'"
            +" group by plan_oid";
    //alert("sql:"+sql);
    var ret1 = executeSelect(sql1,1,1);
    if(ret1.length>0){
        $("specialitys").value=ret1[0][0];
        $("specialitys_id").value=ret1[0][1];
        specialitys=ret1[0][0];
        specialitys_id=ret1[0][1];
    }
        
    var sql2=" select t.org_name,t.org_id from ta_project_task_plan_detail t"
            +" where t.plan_oid='"+$("plan_id").value+"' and t.is_main=0 and"
            +" f_getsecondremark4(t.org_id) in ('shanghai','guangdong','chengdu') ";
    var ret2 = executeSelect(sql2,1,1);
    if(ret2.length>0){
        $("m_dept").value=ret2[0][0];
        $("m_deptid").value=ret2[0][1];
        m_dept=ret2[0][0];
        m_deptid=ret2[0][1];
    }
        
    var sql3=" select wmsys.wm_concat(t.org_name) as org_name,wmsys.wm_concat(t.org_id) as org_id from ta_project_task_plan_detail t"
            +" where t.plan_oid='"+$("plan_id").value+"' and (t.is_main is null or is_main>0) and"
            +" f_getsecondremark4(t.org_id) in ('shanghai','guangdong','chengdu') ";
    var ret3 = executeSelect(sql3,1,1);
    if(ret3.length>0){
        $("j_dept").value=ret3[0][0];
        $("j_deptid").value=ret3[0][1];
        j_dept=ret3[0][0];
        j_deptid=ret3[0][1];
    }   
    
    var strSql =" update ta_project_task_plan set"
               +" specialitys='"+specialitys+"',"
               +" specialitys_id='"+specialitys_id+"',"
               +" m_dept='"+m_dept+"',"
               +" m_deptid='"+m_deptid+"',"
               +" j_dept='"+j_dept+"',"
               +" j_deptid='"+j_deptid+"'"
               +" where oid = '"+$("plan_id").value+"'";
    var msg=creator_update(strSql);
    if(msg==""){
        //alert("��������רҵ�ɹ���");
    }else{
        alert("��������רҵʧ�ܣ�errorCode:"+msg+"sql:"+strSql);
    }
}
/**
 * �ڰ��Ž�����ϸ��ָ������
 */
function f_updateDept(){
    var url=getOpenUrlByDjid("20100715104202078487");//�޸�רҵ�����еĲ�����Ϣ
    var obj=new Object();
    obj.detail_id =dataset4.Fields.Field['detail_id'].Value;//רҵ������ϸID
    obj.plan_id =dataset4.Fields.Field['plan_oid'].Value;//�ƻ�ID
    var msg=window.showModalDialog(url,obj,"dialogWidth=600px;dialogHeight=300px");
    
    f_OfferDetailInit();
    f_feedbackPlanDept();
}
function f_feedbackPlanDept(){
    var sql=" select dept_id,dept_name from("
           +" select t.dept_id,t.dept_name from ta_project_task_plan_detail t"
           +" where t.is_main='0' and t.plan_oid='"+$("plan_id").value+"'"
           +" union all"
           +" select t.org_id as dept_id,t.org_name as dept_name from ta_project_task_plan_detail t"
           +" where t.plan_oid='"+$("plan_id").value+"' and t.is_main=0 and"
           +" f_getsecondremark4(t.org_id) in ('shanghai','guangdong','chengdu')"
           +" ) where dept_id is not null";
    //alert("���岿��sql:"+sql);
    var ret = executeSelect(sql,1,1);
    if(ret.length>0){
        $("m_deptid").value = ret[0][0];
        $("m_dept").value = ret[0][1];
    }else{
        $("m_deptid").value = "";
        $("m_dept").value = "";     
    }
    

    if(((actId==actIds.actId5)&&($("existZf").value==1))||(actId==actIds.actId6)){
        var rets=f_getMdeptLeader();
        //���崦�쵼
        $("DYNAMICPERFORMER").value=rets[0][0];
        $("DYNAMICPERFORMER_NAME").value=rets[0][1];
        if(IsSpace(DYNAMICPERFORMER)){
            alert("û���ҵ����첿�ŵ��쵼��");
        }
    }
    
    var strSql=" select wmsys.wm_concat(distinct dept_id) as dept_id,wmsys.wm_concat(distinct dept_name) from ("
              +" select t.dept_id,t.dept_name from ta_project_task_plan_detail t "
              +" where t.is_main='1' and t.plan_oid ='"+$("plan_id").value+"'"
              +" union all"
              +" select t.org_id dept_id,t.org_name as dept_name"
              +" from ta_project_task_plan_detail t"
              +" where t.plan_oid='"+$("plan_id").value+"' and (t.is_main is null or is_main>0) and"
              +" f_getsecondremark4(t.org_id) in ('shanghai','guangdong','chengdu')"
              +" )"
              +" where dept_id !='"+$("m_deptid").value+"'";
              
    //alert("���벿��sql:"+strSql);
    var strRet = executeSelect(strSql,1,1);
    if(strRet.length>0){
        $("j_deptid").value  =strRet[0][0];
        $("j_dept").value=strRet[0][1];
    }
    
    var sqlstr=" select wmsys.wm_concat(distinct user_id) as user_id, wmsys.wm_concat(distinct user_realname) as user_realname from ("
           +" select b.user_id,d.user_realname from ta_project_task_plan_detail t,td_sm_role a,td_sm_userrole b,td_sm_orguser c,td_sm_user d"
           +" where f_getsecondorgid(t.org_id) = f_getsecondorgid(c.org_id) and a.role_id=b.role_id and b.user_id=c.user_id"
           +" and c.user_id=d.user_id and a.role_name='"+roles.rolename4+"' and t.plan_oid = '"+$("plan_id").value+"'"
           +" and f_getsecondremark4(t.org_id) in ('shanghai','guangdong','chengdu')"
           +" union all"
           +" select b.user_id,d.user_realname from ta_project_task_plan_detail t,td_sm_role a,td_sm_userrole b,td_sm_orguser c,td_sm_user d"
           +" where t.dept_id=c.org_id  and a.role_id=b.role_id and b.user_id=c.user_id"
           +" and c.user_id=d.user_id and a.role_name='"+roles.rolename5+"' and t.plan_oid = '"+$("plan_id").value+"'"
           +" and f_getsecondremark4(t.org_id) in ('zhengzhou','zongbu') )";
    //alert(sqlstr);
    var retstr=executeSelect(sqlstr,1,1);
    if(retstr.length>0){
        $("receive_userid").value=retstr[0][0];
        $("receive_user").value=retstr[0][1];
    }
    
    var sqlStr=" update ta_project_task_plan set"
              +" m_deptid  ='"+$("m_deptid").value+"',"
              +" m_dept='"+$("m_dept").value+"',"
              +" j_deptid  ='"+$("j_deptid").value+"',"
              +" j_dept='"+$("j_dept").value+"',"
              +" receive_userid  ='"+$("receive_userid").value+"',"
              +" receive_user='"+$("receive_user").value+"'"
              +" where oid ='"+$("plan_id").value+"'";
    var msg = creator_update(sqlStr);
    if(IsSpace(msg)){
        //alert("��������Ͳ��벿�ųɹ���");
    }else{
        alert("��������Ͳ��벿�ų���errorCode:"+msg+" | sql:"+sqlStr);
    }
}
/**
 * �ڰ��Ž�����ϸ��ɾ��רҵ
 */
function f_deleteSpeciality(){
    if(confirm("��ȷ��Ҫɾ����")){
        var id=dataset4.Fields.Field['detail_id'].Value;//רҵ����ID        
        var sql="delete from ta_project_task_plan_detail where oid = '"+id+"'";
        var ret=creator_update(sql);
        if(IsSpace(ret)){
            alert("ɾ���ɹ���");
        }else{
            alert("ɾ��ʧ�ܣ�errorCode:"+ret+" | sql:"+sql);
        }
        f_OfferDetailInit();
        //�����޸ĺ�������
        f_feedbackPlanDept();
    }
}
/**
 * ��Ŀ���ŷ�ʽѡ��
 */
function f_selPlanType(){
    var design_id = $("design_id").value;
    var obj = new Object();
    obj.plan_id = $("plan_id").value;//����ID
    
    var sql=" select phase_id,phase_name,design_id from"
           +" ("
           +" select b.design_phaseid as phase_id,b.design_phasename as phase_name,b.design_id,c.order_number"
           +" from ta_project_approval a,ta_project_approval_phase b,ta_project_design_phase c"
           +" where a.approval_id=b.approval_id and b.design_phaseid=c.design_phaseid"
           +" and a.is_pass='��' and a.design_id='"+design_id+"' order by c.order_number desc"
           +" )d where rownum=1";
           //alert("sql:"+sql);
    var ret = executeSelect(sql,1,1);
    if(ret.length>0){
        obj.phase_id = ret[0][0];
        obj.phase_name = ret[0][1];
        obj.design_id = ret[0][2];
        var url = getOpenUrlByDjid("20100726115115609882");
        var retObj = window.showModalDialog(url,obj,"dialogWidth=500px;dialogHeight=125px");
        if(null!=retObj){
            var type = retObj.type;//��������
            if(type=="0"){//����һ��
                $("nc").value=retObj.nc;
                $("nc_describe").innerText=retObj.nc;//����һ������
                $("btn_relate").disabled=true;
                $("planAddBtn").disabled=true;
                f_feedbackPlan();
                hideOrShowTabByName('������Ϣ','hide');
            }else if(type=="1"){//�޸�
                $("nc").value="";
                $("nc_describe").innerText="";
                $("btn_relate").disabled=false;
                $("planAddBtn").disabled=false;
                f_feedbackPlan();
                hideOrShowTabByName('������Ϣ','show');
            }else if(type=="2"){//���°���
                $("nc").value="";
                $("nc_describe").innerText="";
                $("btn_relate").disabled=false;
                $("specialitys").value="";
                $("specialitys_id").value="";
                
                $("planAddBtn").disabled=false;
                hideOrShowTabByName('������Ϣ','show');
            }
        }
        f_OfferDetailInit();
        f_feedbackPlanDept();
    }else{
        alert("��ǰ��Ŀ�Ҳ�����Ӧ��������׶Σ�");
    }
}
/* ���̲��� */
/**
 * ��������ǰִ�еĲ���
 */
function f_preStartAct(){
    //ҳ��Ԫ�ظ�ֵ    ҵ��Ԫ��    �������Ԫ��
    if(f_validatePlan()&&f_validateWf()){
        $("status").value="����/�ֹ�˾�쵼����";
        $("entrust_status").value="2";
        return true;
    }else{
        //alert("δͨ����֤��");
        return false;
    }
}
/**
 * ��������
 */
function f_startAct(){
    if(f_isNc()){
        if(confirm("��ȷ��Ҫ�ύ��")){
            var sql=" <no>"
                   +" update ta_project_task_record set"
                   +" entrust_status='5'"
                   +" where oid='"+$("task_id").value+"'"
                   +" </no>"
                   +" <no>"
                   +" update ta_project_task_plan set"
                   +" task_sponsorid='"+userAccount+"',"
                   +" task_sponsor='"+userName+"',"
                   +" status='����'"
                   +" where oid='"+$("plan_id").value+"'"
                   +" </no>";
            var msg=InsertSqls(sql);
            if(IsSpace(msg)){
                alert("�����ޱ仯����ƽ׶Σ��������������̣�\n�����Խ���������ֱ�Ӵ�������ҵ��");
                var url=location.protocol+"//"+location.host+getContextPath()+"/ccapp/zxyd/project/entrust/entrust_task_list.jsp";
                window.open(url,"_self","");
            }else{
                alert("���� �����ޱ仯����ƽ׶� ״̬ ���� errorCode:"+msg+" | sql:"+sql);
            }
        }
    }else{
        if(f_preStartAct()){
            if(confirm("��ȷ��Ҫ�ύ��")){
                if(f_updateData()&&f_insertIdeal()){
                    $("isOver").value="1";
                    fcpubdata.cc_form_instanceid=Trim((fcpubdata.cc_form_instanceid).replace("clear,",""));
                    creator_djsave('��������',false,true,forwardUrl);
                }                   
            }
        }
    }
}
/**
 * �ж��Ƿ񡰰����ޱ仯����ƽ׶��������޸ġ�
 */
function f_isNc(){
    if(IsSpace($("nc").value)){
        return false;
    }else{
        return true;
    }
}
/**
 * ��ɻǰִ�еĲ���
 */
function f_preCompleteAct(){
    var agree=$("agree").value;
    //���ݲ�ͬ�����̻��ڶ�ҳ��Ԫ�ظ�ֵ  ҵ��Ԫ��    �������Ԫ��

    if((actId==actIds.actId2)||(actId==actIds.actId8)){
        if(agree=="��ͬ��"){
            if(IsSpace($("ideal").value)){
                alert("����д��������");
                return false;
            }
        }
    }
    if((actId==actIds.actId3)&&($("workflowControl_selectAct").value=="taskEntrust_wp1_act4")){
        $("DYNAMICPERFORMER").value=SqlToField("select user_name from td_sm_user where user_id='"+$("DYNAMICPERFORMER").value+"'");
    }
    if(actId==actIds.actId5){//��"�ܲ��г����쵼����"ʱ����д������ȷ��ʱ�䡱
        if(agree=="��ͬ��"){
            if(IsSpace($("ideal").value)){
                alert("����д��������");
                return false;
            }
        }else{
            $("task_confirmdate").value=currentDateTime;
        }
    }
    if(actId==actIds.actId7){
        $("task_sponsorid").value=$("DYNAMICPERFORMER").value;
        $("task_sponsor").value=$("DYNAMICPERFORMER_NAME").value;
    }
    if(f_validatePlan()&&f_validateWf()){
        return true;
    }else{
        return false;
    }
}
/**
 * ��ɻ
 */
function f_completeAct(){
    if(f_preCompleteAct()){
        if(confirm("��ȷ��Ҫ�ύ��")){
            if($("agree").value=="ͬ��"){
                $("verdict").value=0;               
            }else{
                $("verdict").value=1;
            }
            
            if(($("verdict").value==1)&&((actId==actIds.actId2)||(actId==actIds.actId8))){
                if(confirm("������ͬ�⽫���ˣ���ȷ��Ҫ�ύ��")){
                    if(actId==actIds.actId2){
                        $("status").value=actNames.actionname1;
                    }else{
                        $("status").value=actNames.actionname7;
                    }
                    if(f_updateData()&&f_insertIdeal()){
                        creator_djsave('����',false,true,'');
                        retAction();
                    }
                }
            }else{
                //������״̬�ֶν��п���
                if(actId==actIds.actId1){
                    if($("isHqMarketer").value=="0"){
                        $("status").value=actNames.actionname3;//"�ܲ��г�������Ա���";
                    }else if($("isHqMarketer").value=="1"){         
                        $("status").value=actNames.actionname2;//"����/�ֹ�˾�쵼����";
                    }
                    $("entrust_status").value="1";
                }else if(actId==actIds.actId2){
                    if($("agree").value=="��ͬ��"){
                        $("status").value=actNames.actionname1;//"ί�еǼ�";
                    }else{
                        $("status").value=actNames.actionname3;//"�ܲ��г�������Ա���";
                    }
                }else if(actId==actIds.actId3){
                    if($("workflowControl_selectAct").value=="taskEntrust_wp1_act4"){
                        $("status").value=actNames.actionname4;
                    }else if($("workflowControl_selectAct").value=="taskEntrust_wp1_act5"){
                        $("status").value=actNames.actionname5;
                    }
                }else if(actId==actIds.actId4){
                    $("status").value=actNames.actionname3;
                }else if(actId==actIds.actId5){
                    if($("verdict").value==0){
                        if($("existZf").value==0){
                            $("status").value=actNames.actionname6;
                        }else{
                            $("status").value=actNames.actionname7;
                            f_dispense();
                        }
                        $("entrust_status").value="4";
                    }else if($("verdict").value==1){
                        $("status").value=actNames.actionname10;
                        $("entrust_status").value="3";
                        f_notice();
                    }
                }else if(actId==actIds.actId6){
                    $("status").value=actNames.actionname7;
                    f_dispense();
                }else if(actId==actIds.actId7){
                    $("status").value=actNames.actionname8;
                }else if(actId==actIds.actId8){
                    $("status").value=actNames.actionname9;             
                    $("entrust_status").value="5";
                }
                
                if(f_updateData()&&f_insertIdeal()){
                    if(actId==actIds.actId2){
                        if(!f_taskPlanBak()){
                            //alert("�����ű���ʧ��");
                            return ;
                        }
                    }
                    //�ж��Ƿ��û�б����ŵĽ׶Σ����������ֽ�����
                    if((actId==actIds.actId8)&&($("design_phases").value!=$("add_entrust_phase").value)){//&&($("entrust_type").value=="project_new")
                        if(!f_taskResolve()){
                            alert("�������ʧ�ܣ�");
                            return ;
                        }
                    }
                    creator_djsave('��ɻ',false,true,'');
                    retAction();
                }
                
            }
        }
    }
}
/**
 * ��ֹ����
 */
function over_workflow(){
    $("isOver").value="0";
    $("status").value=actNames.actionname10;
    if(f_updateData()&&f_insertIdeal()){
        creator_djsave('��ɻ',false,true,'');
        retAction();
    }
}

/**
 * ���ܲ��г����쵼������ͬʱ��ί����ֹ��֪ͨ�ַ�ǰ�����е�������ִ����
 */
function f_notice(){
    var sql=" select wmsys.wm_concat(distinct t.ideal_peopleid) as user_ids"
           +" from ta_project_approval_opinion t"
           +" where businessid ='"+$("plan_id").value+"'";
    var userids=SqlToField(sql);
    var businessName="����ί��";
    var otherpas="cc_form_instanceid="+cc_form_instanceid+"==opType=view";
    var readpath="eformsys/jxc/dj/20100917171201843030.jsp?";
    var businessid=$("plan_id").value;
    var proj_name=$("proj_name").value; 
    var displayPams="==opType=view";
    //���÷ַ��ӿ�
    sendMsg(businessName,otherpas,readpath,userids,businessid,proj_name);   
}
/**
 * �ַ�
 */
function f_dispense(){  
    var userids="";
    var sqlstr=" select wmsys.wm_concat(user_id) as user_id from ("
       +" select b.user_id from ta_project_task_plan_detail t,td_sm_role a,td_sm_userrole b,td_sm_orguser c"
       +" where t.is_main = 1 and f_getsecondremark4(t.org_id) = f_getsecondremark4(c.org_id) and a.role_id=b.role_id and b.user_id=c.user_id"
       +" and a.role_name='"+roles.rolename4+"' and t.plan_oid = '"+$("plan_id").value+"'"
       +" union all"
       +" select b.user_id from ta_project_task_plan_detail t,td_sm_role a,td_sm_userrole b,td_sm_orguser c"
       +" where t.is_main=1 and t.dept_id=c.org_id  and a.role_id=b.role_id and b.user_id=c.user_id"
       +" and a.role_name='"+roles.rolename5+"' and t.plan_oid = '"+$("plan_id").value+"')";
    var ret=SqlToField(sqlstr);
    if(!IsSpace(ret)){
        userids=ret;
    }
    var businessName="����ί��";
    var otherpas="cc_form_instanceid="+cc_form_instanceid+"==opType=view";
    var readpath="eformsys/jxc/dj/20100917171201843030.jsp?";
    var businessid=$("plan_id").value;
    var proj_name=$("proj_name").value; 
    var displayPams="==opType=view";
    //���÷ַ��ӿ�
    sendMsg(businessName,otherpas,readpath,userids,businessid,proj_name);
}

/**
 * �����ű���
 */
function f_taskPlanBak(){
    var sql=" <no>"
           +" insert into ta_project_task_plan_v"
           +" (oid, task_oid, design_phasesid, design_phases, proj_level, specialitys_id, specialitys)"
           +" values"
           +" ('"+$("plan_id").value+"', '"+$("task_id").value+"', '"+$("design_phasesid").value+"',"
           +" '"+$("design_phases").value+"', '"+$("proj_level3").value+"', '"+$("specialitys_id").value+"', '"+$("specialitys").value+"')"
           +" </no>"
           +" <no>"
           +" insert into ta_project_task_plan_detail_v"
           +" (oid, plan_oid, org_id, org_name, speciality_id, speciality_name, dept_id, dept_name, is_main, memo)"
           +" (select oid, plan_oid, org_id, org_name, speciality_id, speciality_name, dept_id, dept_name, is_main, memo"
           +" from ta_project_task_plan_detail where plan_oid='"+$("plan_id").value+"')"
           +" </no>";
    var tmp = fcpubdata.cc_form_instanceid;
    fcpubdata.cc_form_instanceid = "";
    var msg = InsertSqls(sql);
    fcpubdata.cc_form_instanceid = tmp;
    if(IsSpace(msg)){
        return true;
    }else{
        alert("�����ű���ʧ��sql:"+sql);
        return false;
    }
}
/**
 * ����ֽ�
 */
function f_taskResolve(){
    var entrustid=$("add_entrust_phaseid").value;
    var entrustids=entrustid.split(",");
    var entrusts=($("add_entrust_phase").value).split(",");;
    var planid=$("design_phasesid").value;
    var loseid="";
    var lose="";
    for(var i=0;i<entrustids.length;i++){
        if(planid.indexOf(entrustids[i])==-1){
            if(IsSpace(loseid)){
                loseid=entrustids[i];
                lose=entrusts[i];               
            }else{
                loseid+=","+entrustids[i];
                lose+=","+entrusts[i];
            }
        }
    }
    
    var sqlUser=" select ideal_peopleid,ideal_peoplename,ideal_departid,ideal_departname"
               +" from ta_project_approval_opinion t"
               +" where t.businessid ='"+$("plan_id").value+"'"
               +" and t.action_defid='taskEntrust_wp1_act3' order by t.ideal_date desc";
    var retUser = executeSelect(sqlUser,1,1);
    //alert("����ֽ������sql:"+sqlUser);
    var ideal_peopleid="";
    var ideal_peoplename="";
    var ideal_departid="";
    var ideal_departname="";
    if(retUser.length>0){
        ideal_peopleid = retUser[0][0];
        ideal_peoplename = retUser[0][1];
        ideal_departid = retUser[0][2];
        ideal_departname = retUser[0][3];
    }
    
    var taskId=getNewCc_form_instanceid(false);
    var sql=" <no>"
           +" insert into ta_project_task_record"
           +" (oid, entrust_oid, entrust_type, proj_id, proj_name, design_id, custom_proj_id,"
           +" custom_proj_name, ascription, province, belong_orgid, belong_org,"
           +" profession_property, proj_type, responsible_orgid, responsible_org, proj_level,"
           +" add_entrust_phaseid, add_entrust_phase, dimensions, investment, expect_date,"
           +" other_request, used_phaseid, used_phase, approval_date, entrust_status, parent_id)"
           +" values"
           +" ('"+taskId+"', '"+$("entrust_id").value+"', 'phase_new', '"+$("proj_id").value+"',"
           +" '"+$("proj_name").value+"', '"+$("design_id").value+"', '"+$("custom_proj_id").value+"',"
           +" '"+$("custom_proj_name").value+"', '"+$("ascription").value+"', '"+$("province").value+"',"
           +" '"+$("belong_orgid").value+"', '"+$("belong_orgid").options[$("belong_orgid").selectedIndex].text+"',"
           +" '"+$("profession_property").value+"', '"+$("proj_type").value+"', '"+$("responsible_orgid").value+"',"
           +" '"+$("responsible_orgid").options[$("responsible_orgid").selectedIndex].text+"', '"+$("proj_level3").value+"',"
           +" '"+loseid+"', '"+lose+"', '"+$("dimensions").value+"', '"+$("investment").value+"',"
           +" to_date('"+$("expect_date").value+"','yyyy-mm-dd'), '"+$("other_request").value+"',"
           +" '"+$("used_phaseid").value+"', '"+$("used_phase").value+"',"
           +" to_date('"+$("approval_date").value+"','yyyy-mm-dd'), 9, '"+$("task_id").value+"')"
           +" </no>"
           +" <no>"
           +" insert into ta_project_task_plan"
           +" (oid, task_oid, design_phasesid, design_phases, proj_level, task_expectdate,"
           +" apply_deptid, apply_dept, apply_userid, apply_user, status)"
           +" values"
           +" ('"+getNewCc_form_instanceid(false)+"', '"+taskId+"', '"+loseid+"', '"+lose+"',"
           +" '"+$("proj_level3").value+"', to_date('"+$("expect_date").value+"','yyyy-mm-dd'),"
           +" '"+ideal_departid+"', '"+ideal_departname+"', '"+ideal_peopleid+"', '"+ideal_peoplename+"', '�ȴ�����')"
           +" </no>";
    //alert("����ֽ�sql:"+sql);
    var tmp=fcpubdata.cc_form_instanceid;
    var ntmp=getNewCc_form_instanceid(false);
    fcpubdata.cc_form_instanceid=ntmp;
    var msg=InsertSqls(sql);
    fcpubdata.cc_form_instanceid=tmp;
    if(IsSpace(msg)){
        //alert("����ֽ�ɹ���sql:"+sql);
        return true;
    }else{
        alert("����ֽ�ʧ�ܣ�errorCode:"+msg+" sql:"+sql);
        return false;
    }
}
/**
 * Ч���Ƿ������������
 * ��Ҫ�������岿��
 */
function f_validateWf(){
    if(actId==actIds.actId5){//(actId==actIds.actId1)||actId==actIds.actId3||actId==actIds.actId4||
        var sql=" select count(*) as num from ta_project_task_plan_detail"
               +" where plan_oid='"+$("plan_id").value+"' and is_main=0";
        //alert("sql:"+sql);
        if(SqlToField(sql)==0){
            alert("û�а������岿�ţ�");
            return false;
        }
    }
    
    if((actId==actIds.actId1)||(actId==actIds.actId2)||(actId==actIds.actId3)||(actId==actIds.actId5)){
        if(IsSpace($("DYNAMICPERFORMER").value)){
            alert("��ѡ��������һ��ִ���ˣ�");
            return false;
        }
    }
    
    if(actId==actIds.actId5||actId==actIds.actId6){//actId==actIds.actId2||actId==actIds.actId3||actId==actIds.actId4||
        var sql="select count(*) as numm from ("+offerSql+") where dept_id is null and b='ָ������'";
        if(SqlToField(sql)==0){
            //alert("�����ڼ�¼");
        }else{
            alert("��ָ���������Ĳ��벿�ţ�");
            return false;
        }
    }
    if(actId==actIds.actId7){
        if(IsSpace($("task_sponsor").value)){
            alert("��ѡ���������������ˣ�");
            return false;
        }
    }
    if((actId==actIds.actId2)||(actId==actIds.actId5)){
        if(($("agree").value=="��ͬ��")&&(IsSpace($("ideal").value))){
            alert("����д���������");
            return false;
        }
    }
    return true;
}
/**
 * ����
 */
function f_backAct(){
    if(f_insertIdeal()){
        creator_djsave('����',false,true,'');
        retAction();
    }
}
/* ҵ������̹��õĺ��� */
/**
 * �����������������������
 */
function f_insertIdeal(){
    var ideal_id = getNewCc_form_instanceid(false);//������ϢID
    var result = $("agree").value;//��������
    var ideal = $("ideal").value;//�������
    var businessid=$("plan_id").value;//����ҵ��Id
    if(actId==actIds.actId1){
        result="";
        ideal="";
    }
    var sql = " insert into ta_project_approval_opinion(ideal_id,ideal_peopleid,ideal_peoplename,"
             +" ideal_departid,ideal_departname,ideal_result,ideal_conten,ideal_date,"
             +"order_no,"
             +" businessid,action_defid,action_name) values ('"
             +ideal_id+"','"
             +userId+"','"
             +userName+"','"
             +orgId+"','"
             +orgName +"','"
             +result+"','"
             +ideal+"',sysdate,'"   
             +ideal_id+"','"
             +businessid+"','"
             +actId+"','"
             +actName+"')";
    var ret = creator_insert(sql);
    if(IsSpace(ret)){
        //alert("������������ɹ���");
        return true;
    }else{
        alert("�����������ʧ�ܣ�errorCode:"+ret+" | sql:"+sql);
        return false;
    }
}
/** �鿴�����ϸ��Ϣ */
function f_viewOpinion(){
    var ideal_id = dataset5.Fields.Field['ideal_id'].Value;
    project_showDetailOption(ideal_id);
}
/**
 * ��ȡί�б��
 */
function  f_entrustNo(){
    var sql=" select to_char(sysdate,'yyyymm') ||decode(length(code),1,'00'||code,'2','0'||code,code)as entrust_no"
           +" from ("
           +" select to_number(decode(max(substr(a.entrust_no, 7)),'','0',max(substr(a.entrust_no,7))))+1 as code"
           +" from ta_project_entrust_record a"
          +" where substr(a.entrust_no,1,6)=to_char(sysdate,'yyyymm'))";
    var entrustNo=SqlToField(sql);
    $("entrust_no").value=entrustNo;
}
/**
 * LTrim(string):ȥ����ߵĿո�
 */ 
function LTrim(str){   
    var whitespace = new String(" \t\n\r");   
    var s = new String(str);      
  
    if (whitespace.indexOf(s.charAt(0)) != -1){   
        var j=0, i = s.length;   
        while (j < i && whitespace.indexOf(s.charAt(j)) != -1){   
            j++;   
        }   
        s = s.substring(j, i);   
    }   
    return s;   
}
/**
 * RTrim(string):ȥ���ұߵĿո�
 */
function RTrim(str){
    var whitespace = new String(" \t\n\r");
    var s = new String(str);
 
    if (whitespace.indexOf(s.charAt(s.length-1)) != -1){
        var i = s.length - 1;
        while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1){
            i--;
        }
        s = s.substring(0, i+1);
    }
    return s;
}
 
/**
 * Trim(string):ȥ���ַ������ߵĿո�
 * @param {Object} str
 */ 
function Trim(str){
    return RTrim(LTrim(str));   
}
/** 
* �ж��Ƿ�Ϊ���֣����򷵻�true,���򷵻�false 
*/ 
function f_check_number(){
    if(!(/^[-\+]?\d+(\.\d+)?$/.test($("investment").value))){
       alert("���������֣�");
       $("investment").value="";
    }
}
/**
 * �鿴���̼��
 */
function monitor_workflow(){
   show_workFlow_monitor(cc_form_instanceid);
}
/**
 * ���ز���
 */
function retAction(){
    history.go(-2);
}
/**
 * �ı���һ����ʱ�¼�
 */
function f_changeSelectActor(){
    changeSelectActor();
    if($("workflowControl_selectAct").value=="taskEntrust_wp1_act4"){
        $("nextAction").innerText=actNames.actionname4;
    }else if($("workflowControl_selectAct").value=="taskEntrust_wp1_act5"){
        $("nextAction").innerText=actNames.actionname5;
    }
}
/**
 * ���ذ�ť�¼�
 */
function f_back(){
    history.go(-2);
}
/**
 * ת��
 */
function f_transRead(){
    var proj_name=$("proj_name").value;//��Ŀ����
    var plan_id=$("plan_id").value;//�ƻ�ID
    var url=getOpenUrlByDjid("20101128163940484950")+"&proj_name="+proj_name+"&plan_id="+plan_id+"&cc_formInstanceId="+cc_form_instanceid;//ת��
    var msg=window.showModalDialog(url,window,"dialogWidth=600px;dialogHeight=130px");
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><label><id>label1</id><id>label2</id><id>label3</id><id>label38</id><id>label4</id><id>label5</id><id>label6</id><id>label7</id><id>label10</id><id>label11</id><id>label21</id><id>label12</id><id>label13</id><id>label14</id><id>label15</id><id>label16</id><id>label17</id><id>label37</id><id>label19</id><id>label20</id><id>label22</id><id>label23</id><id>label24</id><id>label25</id><id>label26</id><id>label27</id><id>label28</id><id>label36</id><id>label29</id><id>label30</id><id>label31</id><id>label32</id><id>label33</id><id>label34</id><id>label35</id></label><radio><id>agree</id></radio><textarea><id>dimensions</id><id>remark</id><id>ideal</id></textarea><combobox><id>entrust_type</id><id>entrust_status</id><id>entrust_way</id><id>ascription</id><id>province</id><id>belong_orgid</id><id>profession_property</id><id>proj_type</id><id>responsible_orgid</id><id>proj_level</id><id>proj_level3</id><id>charger_orgid</id><id>workflowControl_selectAct</id><id>combobox14</id><id>combobox15</id></combobox><tab><id>tab1</id></tab><div><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_recycle</id><id>workflowControl_back</id><id>div1</id><id>div12</id><id>workflowControl_selectAndUser</id><id>workflowControl_tempSaveForm</id><id>workflowControl_backToPrior</id><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>div7</id><id>div2</id><id>div3</id><id>div4</id><id>div5</id><id>div6</id><id>div8</id><id>div10</id><id>div11</id></div><a><id>anchor_up</id></a><button><id>back</id><id>button_qdlc</id><id>button_wchd</id><id>button_hs</id><id>button_ht</id><id>over</id><id>save</id><id>transRead</id><id>monitor</id><id>button6</id><id>btn_relate</id><id>button7</id><id>button4</id><id>planTypeBtn</id><id>planAddBtn</id><id>button5</id><id>button_yfzxzxr</id><id>button_zc</id><id>button_xzxr</id></button><text><id>entrust_no</id><id>client</id><id>entrust_way_no</id><id>entrust_explain</id><id>proj_name</id><id>design_id</id><id>custom_proj_name</id><id>custom_proj_id</id><id>used_phase</id><id>approval_date</id><id>undo_entrust_phase</id><id>add_entrust_phase</id><id>expect_date</id><id>investment</id><id>other_request</id><id>opposite_linkman</id><id>opposite_phone</id><id>opposite_org</id><id>our_linkman</id><id>our_phone</id><id>our_org</id><id>inputer</id><id>dept_name</id><id>inputer_date</id><id>design_phases</id><id>specialitys</id><id>m_dept</id><id>j_dept</id><id>task_confirmdate</id><id>receive_user</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>text77</id><id>text80</id><id>isHqMarketer</id><id>verdict</id><id>existZf</id><id>isOver</id><id>entrust_id</id><id>inputer_id</id><id>dept_id</id><id>task_id</id><id>entrust_oid</id><id>proj_id</id><id>belong_org</id><id>responsible_org</id><id>add_entrust_phaseid</id><id>undo_entrust_phaseid</id><id>used_phaseid</id><id>parent_id</id><id>plan_id</id><id>task_oid</id><id>design_phasesid</id><id>charger_org</id><id>specialitys_id</id><id>m_deptid</id><id>j_deptid</id><id>receive_userid</id><id>task_sponsor</id><id>task_sponsorid</id><id>apply_deptid</id><id>apply_dept</id><id>apply_userid</id><id>apply_user</id><id>status</id><id>nc</id></text><grid><id>grid1</id><id>grid2</id><id>grid3</id></grid><dataset><id>dataset1</id><id>dataset2</id><id>dataset3</id><id>dataset4</id><id>dataset5</id><id>dataset6</id><id>dataset7</id></dataset></root>" billtaborder="<root><taborder>planAddBtn</taborder><taborder>grid1</taborder><taborder>entrust_type</taborder><taborder>ascription</taborder><taborder>province</taborder><taborder>belong_orgid</taborder><taborder>profession_property</taborder><taborder>proj_type</taborder><taborder>entrust_no</taborder><taborder>client</taborder><taborder>entrust_explain</taborder><taborder>proj_name</taborder><taborder>design_id</taborder><taborder>custom_proj_name</taborder><taborder>custom_proj_id</taborder><taborder>expect_date</taborder><taborder>investment</taborder><taborder>other_request</taborder><taborder>opposite_linkman</taborder><taborder>opposite_phone</taborder><taborder>opposite_org</taborder><taborder>our_linkman</taborder><taborder>our_phone</taborder><taborder>our_org</taborder><taborder>inputer</taborder><taborder>dept_name</taborder><taborder>inputer_date</taborder><taborder>task_confirmdate</taborder><taborder>m_dept</taborder><taborder>j_dept</taborder><taborder>receive_user</taborder><taborder>specialitys</taborder><taborder>agree</taborder><taborder>ideal</taborder><taborder>grid2</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>add_entrust_phase</taborder><taborder>design_phases</taborder><taborder>proj_level3</taborder><taborder>charger_orgid</taborder><taborder>button6</taborder><taborder>remark</taborder><taborder>proj_level</taborder><taborder>used_phase</taborder><taborder>approval_date</taborder><taborder>button7</taborder><taborder>btn_relate</taborder><taborder>undo_entrust_phase</taborder><taborder>save</taborder><taborder>entrust_way_no</taborder><taborder>isHqMarketer</taborder><taborder>verdict</taborder><taborder>existZf</taborder><taborder>entrust_id</taborder><taborder>inputer_id</taborder><taborder>dept_id</taborder><taborder>responsible_orgid</taborder><taborder>task_id</taborder><taborder>entrust_oid</taborder><taborder>proj_id</taborder><taborder>belong_org</taborder><taborder>responsible_org</taborder><taborder>add_entrust_phaseid</taborder><taborder>undo_entrust_phaseid</taborder><taborder>used_phaseid</taborder><taborder>plan_id</taborder><taborder>task_sponsor</taborder><taborder>task_oid</taborder><taborder>design_phasesid</taborder><taborder>charger_org</taborder><taborder>specialitys_id</taborder><taborder>m_deptid</taborder><taborder>j_deptid</taborder><taborder>receive_userid</taborder><taborder>task_sponsorid</taborder><taborder>apply_deptid</taborder><taborder>apply_dept</taborder><taborder>apply_userid</taborder><taborder>apply_user</taborder><taborder>status</taborder><taborder>entrust_status</taborder><taborder>entrust_way</taborder><taborder>planTypeBtn</taborder><taborder>nc</taborder><taborder>workflowControl_selectAct</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zc</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder><taborder>combobox14</taborder><taborder>combobox15</taborder><taborder>text77</taborder><taborder>text80</taborder><taborder>grid3</taborder><taborder>monitor</taborder><taborder>dimensions</taborder><taborder>parent_id</taborder><taborder>isOver</taborder><taborder>over</taborder><taborder>back</taborder><taborder>transRead</taborder></root>" dj_sn="20100917171201843030" caption="ί�еǼ�" mkbh codeheader="BBB" entertype="չ��" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:38;radio:1;listbox:2;textarea:3;combobox:15;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:12;DsMain_field:0;a:0;button:14;text:82;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:3;dataset:8;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="4" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination="grid1,dataset4,5;grid2,dataset5,10;grid3,dataset7,10;" type="ZW" creatorType="20100518201032906877" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;/userjs/project/project_div_win.js&#13;&#10;/userjs/project/project_new_upload.js&#13;&#10;/userjs/project/approval_ideal.js&#13;&#10;/userjs/project/div_tree.js&#13;&#10;/userjs/project/entrust_startwf.js&#13;&#10;/userjs/project/project_pub.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid>grid1</gridid><iframeid></iframeid><index>1</index><gridid>grid2</gridid><iframeid></iframeid><index>2</index><gridid>grid3</gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE class=tit style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD width="35%"><A id=anchor_up style="POSITION: absolute" href="#haha" target=_self controltype="a" NotBg="��" href1="#haha"></A><A name=haha></A><H1>��ǰ���ڣ�<FONT id=actName>��������</FONT></H1></TD>
         <TD align=right><DIV id=workflowControl2 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 74.1%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="workflowControl" NotBg="��"><BUTTON class=button_top id=back style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_back()")'>����</BUTTON><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button_top id=button_qdlc style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_startAct()")'>�ύ</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button_top id=button_wchd style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_completeAct()")'>�ύ</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button_top id=button_hs style="LEFT: 0px; WIDTH: 64px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;creator_djsave('�ջ�',false,true,'../../../common_workflow/main.jsp')&quot;)">�ջ�</BUTTON></DIV><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button_top id=button_ht style="LEFT: 0px; WIDTH: 53px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;creator_djsave('����',false,true,'../../../common_workflow/main.jsp')&quot;)">����</BUTTON></DIV><BUTTON class=button_top id=over style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("over_workflow()")'>������ֹ</BUTTON><BUTTON class=button_top id=save style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_save()")'>����</BUTTON><BUTTON class=button_top id=transRead style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_transRead()")'>ת��</BUTTON><BUTTON class=button_top id=monitor style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("monitor_workflow()")'>���̼��</BUTTON></DIV></TD>
      </TR>
      <TR>
         <TD colSpan=3><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 1200px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��"><DIV class=tab-pane id=tab1 style="LEFT: 8px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 1100px" showtype="luna" IsHideTitle="��"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px"><H2 class=tab>������Ϣ</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR id=gkxq1>
                              <TD><LI>�˿�������Ϣ</LI></TD>
                           </TR>
                           <TR id=gkxq2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR id=wt1>
                                          <TH width="10%" rowSpan=4>ί����Ϣ</TH>
                                          <TH width="10%">ί�б��</TH>
                                          <TD width="20%"><INPUT id=entrust_no style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="entrust_no" china="�ͻ�ί�б��" dataset="dataset1"></TD>
                                          <TH width="10%">ί������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD width="20%"><SELECT id=entrust_type style="LEFT: 0px; WIDTH: 163px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpzXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="entrust_type" china="ί������" dataset="dataset2" tempvalue temptext sql check="2" backwidth="163" backheight="25"></SELECT></TD>
                                          <TH width="10%">ί��״̬</TH>
                                          <TD width="20%"><SELECT id=entrust_status style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7Crtp%80Xr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="entrust_status" china="ί��״̬" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=wt2>
                                          <TH>ί�е�λ
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD colSpan=5><INPUT id=client style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="client" china="ί�е�λ" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=wt3>
                                          <TH>ί�з�ʽ
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=entrust_way style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("f_changeWay(true)")' sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtrpXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="entrust_way" china="ί�з�ʽ" dataset="dataset1" tempvalue temptext sql check="2" backwidth="150" backheight="25"></SELECT></TD>
                                          <TH id=way_no1>���
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=way_no2><INPUT id=entrust_way_no style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_way_no" china="ί�з�ʽ���" dataset="dataset1"></TD>
                                          <TH id=way_explain1>˵��
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=way_explain2><INPUT id=entrust_explain style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_explain" china="ί�з�ʽ˵��" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=wt4>
                                          <TH>����</TH>
                                          <TD id=upload_td colSpan=4></TD>
                                          <TD id=upload_btn><BUTTON class=button_nor id=button6 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_upload()")'>�ϴ�</BUTTON></TD>
                                       </TR>
                                       <TR id=xm1 style="DISPLAY: none">
                                          <TH id=xmxx width="10%" rowSpan=5>��Ŀ��Ϣ</TH>
                                          <TH id=proj_label1>��������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_label2 colSpan=3><INPUT id=proj_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="proj_name" china="��Ŀ����" dataset="dataset2"></TD>
                                          <TH id=proj_label3>��Ʊ��
                                             <FONT id=star color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_label4><INPUT id=design_id style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 66.07%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="design_id" china="��Ʊ��" dataset="dataset2"><BUTTON class=button_nor id=btn_relate style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_relate()")'>����</BUTTON></TD>
                                       </TR>
                                       <TR id=xm2 style="DISPLAY: none">
                                          <TH>�ͻ���Ŀ����</TH>
                                          <TD colSpan=3><INPUT id=custom_proj_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_name" china="�ͻ���Ŀ����" dataset="dataset2"></TD>
                                          <TH>�ͻ���Ŀ���</TH>
                                          <TD><INPUT id=custom_proj_id style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_id" china="�ͻ���Ŀ���" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=xm3 style="DISPLAY: none">
                                          <TH>��Ŀ����
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=ascription style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtptXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="ascription" china="��Ŀ����" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>ʡ��
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=province style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpxXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="province" china="ʡ��" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>��������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=belong_orgid style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="belong_orgid" china="��������ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=xm4 style="DISPLAY: none">
                                          <TH>רҵ����
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=profession_property style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7Crtr%7CXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="profession_property" china="רҵ����" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>��������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_type_label><SELECT id=proj_type style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpvXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="proj_type" china="��������" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH id=responsible_org1>�������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=responsible_org2><SELECT id=responsible_orgid style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="responsible_orgid" china="�������ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=xm5 style="DISPLAY: none">
                                          <TH>������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=proj_level style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="������" dataset="dataset2" tempvalue="0&#13;&#10;1" temptext="Ժ��&#13;&#10;����" sql check="1" backwidth="100" backheight="25"><OPTION value=0 selected>Ժ��</OPTION><OPTION value=1>����</OPTION></SELECT></TD>
                                          <TH>������׶�
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=used_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="used_phase" china="������׶�����" dataset="dataset2"></TD>
                                          <TH>��������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=approval_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="approval_date" china="��������" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=cx style="DISPLAY: none">
                                          <TH colSpan=2>��ֹ��ƽ׶�
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=cx1 colSpan=4><INPUT id=undo_entrust_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="undo_entrust_phase" china="��ֹί�н׶�" dataset="dataset2"></TD>
                                          <TD id=cx2><BUTTON class=button_nor id=button7 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_pickUndoPhase()")'>ѡ��</BUTTON></TD>
                                       </TR>
                                       <TR id=rw1 style="DISPLAY: none">
                                          <TH id=rwxx_label width="10%" rowSpan=4>������Ϣ</TH>
                                          <TH id=rw_phase_label>ί�н׶�
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=wtjd1><INPUT id=add_entrust_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="add_entrust_phase" china="����ί�н׶�" dataset="dataset2"></TD>
                                          <TD id=wtjd2><BUTTON class=button_nor id=button4 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_pickNewPhase()")'>ѡ��</BUTTON></TD>
                                          <TH>Ҫ����
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=expect_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() controltype="text" field="expect_date" china="Ҫ���������" dataset="dataset2" onclick='bill_onclick("SelectDate()")'></TD>
                                          <TD>ǰ���</TD>
                                       </TR>
                                       <TR id=rw2 style="DISPLAY: none">
                                          <TH>��ƹ�ģ
                                             <FONT color=red>*</FONT>
                                             <BR>
                                             (����1000��)
                                          </TH>
                                          <TD colSpan=5><TEXTAREA id=dimensions style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 52px" onmovestart=moveStart() rows=1 controltype="textarea" field="dimensions" china="��ƹ�ģ" dataset="dataset2" value="textarea3" induce="��"></TEXTAREA></TD>
                                       </TR>
                                       <TR id=rw3 style="DISPLAY: none">
                                          <TH>������Ͷ��
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=investment style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() controltype="text" field="investment" china="������Ͷ��" dataset="dataset2" onblur='bill_onexit("f_check_number()")'></TD>
                                          <TD colSpan=4>��Ԫ�������������й����йع淶����׼��Ҫ��</TD>
                                       </TR>
                                       <TR id=rw4 style="DISPLAY: none">
                                          <TH>����Ҫ��
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD colSpan=5><INPUT id=other_request style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="other_request" china="����Ҫ��" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=qt1 style="DISPLAY: none">
                                          <TH width="10%" rowSpan=4>������Ϣ</TH>
                                          <TH>�Է��ӿ���
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_linkman style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_linkman" china="�Է��ӿ���" dataset="dataset1"></TD>
                                          <TH>�Է��ӿ��˵绰
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_phone style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_phone" china="�Է��ӿ��˵绰" dataset="dataset1"></TD>
                                          <TH>�Է��ӿڵ�λ
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_org style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_org" china="�Է��ӿڵ�λ" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=qt2 style="DISPLAY: none">
                                          <TH>�ҷ��ӿ���
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_linkman style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_linkman" china="�ҷ��ӿ���" dataset="dataset1"></TD>
                                          <TH>�ҷ��ӿ��˵绰
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_phone style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_phone" china="�ҷ��ӿ��˵绰" dataset="dataset1"></TD>
                                          <TH>�ҷ��ӿڵ�λ
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_org style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_org" china="�ҷ��ӿڵ�λ" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=qt3 style="DISPLAY: none">
                                          <TH>��ע</TH>
                                          <TD colSpan=5><TEXTAREA id=remark style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() rows=1 controltype="textarea" field="remark" china="��ע" dataset="dataset1" value="textarea2" induce="��"></TEXTAREA></TD>
                                       </TR>
                                       <TR id=qt4 style="DISPLAY: none">
                                          <TH>�����</TH>
                                          <TD><INPUT id=inputer style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="inputer" china="�����" dataset="dataset1"></TD>
                                          <TH>���ڲ���</TH>
                                          <TD><INPUT id=dept_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="dept_name" china="���ڲ���" dataset="dataset1"></TD>
                                          <TH>�������</TH>
                                          <TD><INPUT id=inputer_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="inputer_date" china="���ʱ��" dataset="dataset1"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=xmjy1 style="DISPLAY: none">
                              <TD><LI><SPAN><BUTTON class=button_nor id=planTypeBtn style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_selPlanType()")'>���ŷ�ʽѡ��</BUTTON><BUTTON class=button_nor id=planAddBtn style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_newOfferSp()")'>����רҵ����</BUTTON></SPAN>��Ŀ�������뵥<FONT color=red><B id=nc_describe></B></FONT></LI></TD>
                           </TR>
                           <TR id=xmjy2 style="DISPLAY: none">
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">��ƽ׶�
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=plan_phases1 width="35%"><INPUT id=design_phases style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="design_phases" china="��Ŀ�׶�����" dataset="dataset3"></TD>
                                          <TD id=plan_phases2 align=middle width="5%"><BUTTON class=button_nor id=button5 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("f_pickPlanPhase()")'>ѡ��</BUTTON></TD>
                                          <TH width="10%">������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=gljb width="15%"><SELECT id=proj_level3 style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="������" dataset="dataset3" tempvalue="0&#13;&#10;1" temptext="Ժ��&#13;&#10;����" sql check="1" backwidth="100" backheight="25"><OPTION value=0 selected>Ժ��</OPTION><OPTION value=1>����</OPTION></SELECT></TD>
                                          <TH id=fzjg1 width="10%">�������
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=fzjg2 width="15%"><SELECT id=charger_orgid style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="responsible_orgid" china="�������ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR>
                                          <TH>��Ŀ������רҵ</TH>
                                          <TD colSpan=6><INPUT id=specialitys style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="specialitys" china="רҵ����" dataset="dataset3"></TD>
                                       </TR>
                                       <TR>
                                          <TD colSpan=7><?xml:namespace prefix = fc /><fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' top="0" width="100%" height="129" format="<cols><col><fname>org_name</fname><cname>�μӻ���</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>speciality_name</fname><cname>רҵ����</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>���벿��</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>is_main</fname><cname>���崦</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>a</fname><cname>�޸�רҵ</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>b</fname><cname>ָ������</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>c</fname><cname>ɾ��</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col></cols>" dataset="dataset4" visible="��" canselect="��" autoheight="��" autowidth="��" autoappend="��" readonly="��" SetRowHeight="��" hideVscroll="��" hideHscroll="��" autosize="��" bodyrowheight="-1" bodyrows="-1" left="0">
                                                <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
                                                   <TBODY>
                                                      <TR class=fcGridFirstRow>
                                                         <TD></TD>
                                                      </TR>
                                                   </TBODY>
                                                </TABLE>
                                             </fc:webgrid>
                                          </TD>
                                       </TR>
                                       <TR>
                                          <TD colSpan=7><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid1"><SPAN id=pageInfogrid1></SPAN><A id=firstpagegrid1 onclick="buttonevent('grid1','firstpage')" href="javascript:void(0)">��ҳ</A><A id=prevpagegrid1 onclick="buttonevent('grid1','prevpage')" href="javascript:void(0)">��һҳ</A><A id=nextpagegrid1 onclick="buttonevent('grid1','nextpage')" href="javascript:void(0)">��һҳ</A><A id=lastpagegrid1 onclick="buttonevent('grid1','lastpage')" href="javascript:void(0)">βҳ</A></DIV></DIV></DIV></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=rwxd1 style="DISPLAY: none">
                              <TD><LI>�����´���Ϣ</LI></TD>
                           </TR>
                           <TR id=rwxd2 style="DISPLAY: none">
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">���첿��</TH>
                                          <TD width="20%"><INPUT id=m_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="m_dept" china="���첿������" dataset="dataset3"></TD>
                                          <TH width="10%">Э�첿��</TH>
                                          <TD width="50%"><INPUT id=j_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="j_dept" china="Э�첿������" dataset="dataset3"></TD>
                                       </TR>
                                       <TR>
                                          <TH>����ȷ��ʱ��</TH>
                                          <TD><INPUT id=task_confirmdate style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="task_confirmdate" china="����ȷ��ʱ��" dataset="dataset3"></TD>
                                          <TH>���������Ա</TH>
                                          <TD><INPUT id=receive_user style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="receive_user" china="���������" dataset="dataset3"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px">
                     <H2 class=tab>������Ϣ</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR id=next>
                              <TD><H1>��һ���ڣ�<FONT id=nextAction>��һ��������</FONT></H1></TD>
                           </TR>
                           <TR id=txyj1 style="DISPLAY: none">
                              <TD><LI>����д�������</LI><DIV id=div12 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 849px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 517px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 343px; HEIGHT: 74px" onmovestart=moveStart() controltype="div" NotBg="��"><DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 380px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��">��ѡ��ִ���ˣ�<INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button_nor id=button_yfzxzxr style="LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("addAndUser();")'>���֧ѡִ����</BUTTON></DIV><DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;creator_djsave('�ݴ�',true,true,'../../../common_workflow/main.jsp')&quot;)">�ݴ�</BUTTON></DIV><DIV id=workflowControl_backToPrior style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 84px; BORDER-BOTTOM: black 1px solid; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV></DIV></TD>
                           </TR>
                           <TR id=txyj2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR id=shxx>
                                          <TD colSpan=2><DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 253px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="��">��һ����ѡ��<SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 167px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("f_changeSelectActor()")' sqltrans controltype="combobox" tempvalue temptext sql check="1" backwidth="167" backheight="25"></SELECT></DIV><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 237px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="��"><FONT id=nextUserlabel>ִ����ѡ��</FONT><INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 74px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=11 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button_nor id=button_xzxr style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("adduser();")'>ѡ��</BUTTON></DIV></TD>
                                       </TR>
                                       <TR id=shjl>
                                          <TH width="10%">��������</TH>
                                          <TD><FIELDSET id=agree contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 18px" onmovestart=moveStart() controltype="radio" tempvalue="ͬ��&#13;&#10;��ͬ��" temptext="ͬ��&#13;&#10;��ͬ��" aspect="����" legend NotBg="��" value="ͬ��" onclick='bill_onclick("f_changeAgree()")'><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=ͬ�� name=RGagree text="ͬ��"><SPAN onclick=RGagree[0].checked=true;agree.value=RGagree[0].value;RGagree[0].focus();>ͬ��</SPAN>&nbsp;<INPUT type=radio value=��ͬ�� name=RGagree text="��ͬ��"><SPAN onclick=RGagree[1].checked=true;agree.value=RGagree[1].value;RGagree[1].focus();>��ͬ��</SPAN>&nbsp;</FIELDSET></TD>
                                       </TR>
                                       <TR id=shyj>
                                          <TH width="10%">�������</TH>
                                          <TD><TEXTAREA id=ideal style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=yyyj1>
                              <TD><LI>������������б�</LI></TD>
                           </TR>
                           <TR id=yyyj2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TD><fc:webgrid id=grid2 onkeydown='bill_ongridkeydown("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' ondblclick='bill_ongriddblclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' onclick='bill_ongridclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' top="0" width="100%" height="238" format="<cols><col><fname>ideal_peoplename</fname><cname>������</cname><width>40</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>ideal_departname</fname><cname>����</cname><width>40</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>action_name</fname><cname>��������</cname><width>40</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>ideal_result</fname><cname>�������</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>ideal_conten</fname><cname>��������</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>25%</columnwidth><align>left</align></col><col><fname>ideal_date</fname><cname>��������</cname><width>20</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>center</align></col><col><fname>a</fname><cname>�鿴</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>5%</columnwidth><align>center</align></col></cols>" dataset="dataset5" visible="��" canselect="��" autoheight="��" autowidth="��" autoappend="��" readonly="��" SetRowHeight="��" hideVscroll="��" hideHscroll="��" autosize="��" bodyrowheight="-1" bodyrows="-1" left="0">
                                                <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
                                                   <TBODY>
                                                      <TR class=fcGridFirstRow>
                                                         <TD></TD>
                                                      </TR>
                                                   </TBODY>
                                                </TABLE>
                                             </fc:webgrid>
                                          </TD>
                                       </TR>
                                       <TR>
                                          <TD><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid2"><SPAN id=pageInfogrid2></SPAN><A id=firstpagegrid2 onclick="buttonevent('grid2','firstpage')" href="javascript:void(0)">��ҳ</A><A id=prevpagegrid2 onclick="buttonevent('grid2','prevpage')" href="javascript:void(0)">��һҳ</A><A id=nextpagegrid2 onclick="buttonevent('grid2','nextpage')" href="javascript:void(0)">��һҳ</A><A id=lastpagegrid2 onclick="buttonevent('grid2','lastpage')" href="javascript:void(0)">βҳ</A></DIV></DIV></DIV></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px">
                     <H2 class=tab>���Ž��鵥</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR>
                              <TD><LI>��Ŀ���Ž��鵥</LI></TD>
                           </TR>
                           <TR>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">������ƽ׶�</TH>
                                          <TD width="30%"><INPUT id=text77 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="design_phases" china="��Ŀ�׶�����" dataset="dataset6"></TD>
                                          <TH width="10%">��Ŀ������</TH>
                                          <TD width="20%"><SELECT id=combobox14 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="������" dataset="dataset6" tempvalue="0&#13;&#10;1" temptext="Ժ��&#13;&#10;����" sql check="1" backwidth="120" backheight="25"><OPTION value=0 selected>Ժ��</OPTION><OPTION value=1>����</OPTION></SELECT></TD>
                                          <TH width="10%">�������</TH>
                                          <TD width="20%"><SELECT id=combobox15 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="responsible_orgid" china="�������ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                          <TR>
                                             <TH>��Ŀ������רҵ</TH>
                                             <TD colSpan=5><INPUT id=text80 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="specialitys" china="רҵ����" dataset="dataset6"></TD>
                                          </TR>
                                          <TR>
                                             <TD colSpan=6><fc:webgrid id=grid3 onkeydown='bill_ongridkeydown("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' ondblclick='bill_ongriddblclick("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' onclick='bill_ongridclick("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' top="0" width="100%" height="213" format="<cols><col><fname>org_name</fname><cname>�μӻ�������</cname><width>500</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>speciality_name</fname><cname>רҵ����</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>��������</cname><width>100</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>is_main</fname><cname>�Ƿ����岿��</cname><width>10</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>12%</columnwidth><align>center</align></col><col><fname>memo</fname><cname>����˵��</cname><width>200</width><dtype>�ַ�</dtype><readonly>��</readonly><visible>��</visible><u></u><v></v><s></s><r></r><columnwidth>28%</columnwidth><align>left</align></col></cols>" dataset="dataset7" visible="��" canselect="��" autoheight="��" autowidth="��" autoappend="��" readonly="��" SetRowHeight="��" hideVscroll="��" hideHscroll="��" autosize="��" bodyrowheight="-1" bodyrows="-1" left="0">
                                                   <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
                                                      <TBODY>
                                                         <TR class=fcGridFirstRow>
                                                            <TD></TD>
                                                         </TR>
                                                      </TBODY>
                                                   </TABLE>
                                                </fc:webgrid>
                                             </TD>
                                          </TR>
                                          <TR>
                                             <TD colSpan=6><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid3"><SPAN id=pageInfogrid3></SPAN><A id=firstpagegrid3 onclick="buttonevent('grid3','firstpage')" href="javascript:void(0)">��ҳ</A><A id=prevpagegrid3 onclick="buttonevent('grid3','prevpage')" href="javascript:void(0)">��һҳ</A><A id=nextpagegrid3 onclick="buttonevent('grid3','nextpage')" href="javascript:void(0)">��һҳ</A><A id=lastpagegrid3 onclick="buttonevent('grid3','lastpage')" href="javascript:void(0)">βҳ</A></DIV></DIV></DIV></TD>
                                          </TR>
                                       </TBODY>
                                    </TABLE>
                                 </TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </DIV>
                  </DIV>
                  <SCRIPT>var tab1 = new WebFXTabPane( document.getElementById( "tab1" ) );</SCRIPT>
               </DIV>
            </INPUT>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<DIV id=div7 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; DISPLAY: none; LEFT: 1287px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 80px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 77px; HEIGHT: 310px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
   <DIV id=div2 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 7px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 149px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 4px; HEIGHT: 192px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <DIV id=label1 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">�Ƿ��ܲ��г���Ա:0��,1��</DIV>
      <INPUT id=isHqMarketer style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label2 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label2">��������:0ͬ��,1��ͬ��</DIV>
      <INPUT id=verdict style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label3 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label3">�Ƿ�֣�ֲ���:0��,1��</DIV>
      <INPUT id=existZf style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label38 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label38">�Ƿ���ֹ����</DIV>
      <INPUT id=isOver style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() value=1 controltype="text">
   </DIV>
   <DIV id=div3 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 13px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 148px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 204px; HEIGHT: 151px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset1 format="<fields><field><fieldname>entrust_id</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ�ί��ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_no</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ�ί�б��</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer_id</fieldname><datatype>�ַ�</datatype><displaylabel>�����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer</fieldname><datatype>�ַ�</datatype><displaylabel>�����</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer_date</fieldname><datatype>�ַ�</datatype><displaylabel>���ʱ��</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>�ַ�</datatype><displaylabel>���ڲ���ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>�ַ�</datatype><displaylabel>���ڲ���</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>client</fieldname><datatype>�ַ�</datatype><displaylabel>ί�е�λ</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_subject</fieldname><datatype>�ַ�</datatype><displaylabel>ί������</displaylabel><size>500</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_way</fieldname><datatype>�ַ�</datatype><displaylabel>ί�з�ʽ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_explain</fieldname><datatype>�ַ�</datatype><displaylabel>ί�з�ʽ˵��</displaylabel><size>1000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_way_no</fieldname><datatype>�ַ�</datatype><displaylabel>ί�з�ʽ���</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_linkman</fieldname><datatype>�ַ�</datatype><displaylabel>�Է��ӿ���</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_phone</fieldname><datatype>�ַ�</datatype><displaylabel>�Է��ӿ��˵绰</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_org</fieldname><datatype>�ַ�</datatype><displaylabel>�Է��ӿڵ�λ</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_linkman</fieldname><datatype>�ַ�</datatype><displaylabel>�ҷ��ӿ���</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_phone</fieldname><datatype>�ַ�</datatype><displaylabel>�ҷ��ӿ��˵绰</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_org</fieldname><datatype>�ַ�</datatype><displaylabel>�ҷ��ӿڵ�λ</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>remark</fieldname><datatype>�ַ�</datatype><displaylabel>��ע</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' onGetText='bill_ondatasetgettext("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' onValid='bill_ondatasetvalid("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
      <DIV id=label4 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label4">���ͻ�ί����Ϣ</DIV>
      <DIV id=label5 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label5">�ͻ�ί��ID</DIV>
      <INPUT id=entrust_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_id" china="�ͻ�ί��ID" dataset="dataset1">
      <DIV id=label6 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label6">�����ID</DIV>
      <INPUT id=inputer_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="inputer_id" china="�����ID" dataset="dataset1">
      <DIV id=label7 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label7">���ڲ���ID</DIV>
      <INPUT id=dept_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="dept_id" china="���ڲ���ID" dataset="dataset1">
      &nbsp;
   </DIV>
   <DIV id=div4 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 13px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 148px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 358px; HEIGHT: 393px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset2 format="<fields><field><fieldname>task_id</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ�ί����������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_oid</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ�ί��ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_type</fieldname><datatype>�ַ�</datatype><displaylabel>ί������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_id</fieldname><datatype>�ַ�</datatype><displaylabel>����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_name</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ����</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_id</fieldname><datatype>�ַ�</datatype><displaylabel>��Ʊ��</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_id</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ���Ŀ���</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_name</fieldname><datatype>�ַ�</datatype><displaylabel>�ͻ���Ŀ����</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ascription</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ����</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>province</fieldname><datatype>�ַ�</datatype><displaylabel>ʡ��</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_orgid</fieldname><datatype>�ַ�</datatype><displaylabel>��������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_org</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>profession_property</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_type</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_orgid</fieldname><datatype>�ַ�</datatype><displaylabel>�������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_org</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phaseid</fieldname><datatype>�ַ�</datatype><displaylabel>����ί�н׶�ID</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phase</fieldname><datatype>�ַ�</datatype><displaylabel>����ί�н׶�</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phaseid</fieldname><datatype>�ַ�</datatype><displaylabel>��ֹί�н׶�ID</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phase</fieldname><datatype>�ַ�</datatype><displaylabel>��ֹί�н׶�</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dimensions</fieldname><datatype>�ַ�</datatype><displaylabel>��ƹ�ģ</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>investment</fieldname><datatype>�ַ�</datatype><displaylabel>������Ͷ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>expect_date</fieldname><datatype>�ַ�</datatype><displaylabel>Ҫ���������</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_request</fieldname><datatype>�ַ�</datatype><displaylabel>����Ҫ��</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>used_phaseid</fieldname><datatype>�ַ�</datatype><displaylabel>������׶�ID</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>used_phase</fieldname><datatype>�ַ�</datatype><displaylabel>������׶�����</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>approval_date</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_status</fieldname><datatype>�ַ�</datatype><displaylabel>ί��״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>parent_id</fieldname><datatype>�ַ�</datatype><displaylabel>��TaskId</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' onGetText='bill_ondatasetgettext("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' onValid='bill_ondatasetvalid("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset>
      <DIV id=label10 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label10">���ͻ�ί������</DIV>
      <DIV id=label11 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label11">�ͻ�ί����������ID</DIV>
      <INPUT id=task_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_id" china="�ͻ�ί����������ID" dataset="dataset2">
      <DIV id=label21 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label21">�ͻ�ί�й���ID</DIV>
      <INPUT id=entrust_oid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_oid" china="�ͻ�ί��ID" dataset="dataset2">
      <DIV id=label12 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label12">����ID</DIV>
      <INPUT id=proj_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="proj_id" china="����ID" dataset="dataset2">
      <DIV id=label13 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label13">��������</DIV>
      <INPUT id=belong_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="belong_org" china="��������" dataset="dataset2">
      <DIV id=label14 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label14">�������</DIV>
      <INPUT id=responsible_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="responsible_org" china="�������" dataset="dataset2">
      <DIV id=label15 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label15">����ί�н׶�ID</DIV>
      <INPUT id=add_entrust_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="add_entrust_phaseid" china="����ί�н׶�ID" dataset="dataset2">
      <DIV id=label16 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label16">��ֹί�н׶�ID</DIV>
      <INPUT id=undo_entrust_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="undo_entrust_phaseid" china="��ֹί�н׶�ID" dataset="dataset2">
      <DIV id=label17 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label17">������׶�ID</DIV>
      <INPUT id=used_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="used_phaseid" china="������׶�ID" dataset="dataset2">
      <DIV id=label37 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label37">��TaskId</DIV>
      <INPUT id=parent_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="parent_id" china="��TaskId" dataset="dataset2">
   </DIV>
   <DIV id=div5 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 164px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 149px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 11px; HEIGHT: 738px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset3 format="<fields><field><fieldname>plan_id</fieldname><datatype>�ַ�</datatype><displaylabel>�������´�����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_oid</fieldname><datatype>�ַ�</datatype><displaylabel>�������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasesid</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ�׶�ID</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phases</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ�׶�����</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>charger_orgid</fieldname><datatype>�ַ�</datatype><displaylabel>�������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>charger_org</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys_id</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����ID</displaylabel><size>500</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����</displaylabel><size>500</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_confirmdate</fieldname><datatype>�ַ�</datatype><displaylabel>����ȷ��ʱ��</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_expectdate</fieldname><datatype>�ַ�</datatype><displaylabel>����Ҫ�����ʱ��</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>m_deptid</fieldname><datatype>�ַ�</datatype><displaylabel>���첿��ID</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>m_dept</fieldname><datatype>�ַ�</datatype><displaylabel>���첿������</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>j_deptid</fieldname><datatype>�ַ�</datatype><displaylabel>Э�첿��ID</displaylabel><size>1000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>j_dept</fieldname><datatype>�ַ�</datatype><displaylabel>Э�첿������</displaylabel><size>1000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>receive_userid</fieldname><datatype>�ַ�</datatype><displaylabel>���������ID</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>receive_user</fieldname><datatype>�ַ�</datatype><displaylabel>���������</displaylabel><size>2400</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_sponsorid</fieldname><datatype>�ַ�</datatype><displaylabel>��������������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_sponsor</fieldname><datatype>�ַ�</datatype><displaylabel>��������������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_deptid</fieldname><datatype>�ַ�</datatype><displaylabel>���벿��ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_dept</fieldname><datatype>�ַ�</datatype><displaylabel>���벿������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_userid</fieldname><datatype>�ַ�</datatype><displaylabel>������ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_user</fieldname><datatype>�ַ�</datatype><displaylabel>����������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>status</fieldname><datatype>�ַ�</datatype><displaylabel>��ǰ����״̬</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>nc</fieldname><datatype>�ַ�</datatype><displaylabel>����һ������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' onGetText='bill_ondatasetgettext("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' onValid='bill_ondatasetvalid("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="��"></fc:dataset>
      <DIV id=label19 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label19">���������´�</DIV>
      <DIV id=label20 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label20">�������´�����ID</DIV>
      <INPUT id=plan_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="plan_id" china="�������´�����ID" dataset="dataset3">
      <DIV id=label22 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label22">�������ID</DIV>
      <INPUT id=task_oid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_oid" china="�������ID" dataset="dataset3">
      <DIV id=label23 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label23">��Ŀ�׶�ID</DIV>
      <INPUT id=design_phasesid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="design_phasesid" china="��Ŀ�׶�ID" dataset="dataset3">
      <DIV id=label24 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label24">�������</DIV>
      <INPUT id=charger_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="charger_org" china="�������" dataset="dataset3">
      <DIV id=label25 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label25">רҵ����ID</DIV>
      <INPUT id=specialitys_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="specialitys_id" china="רҵ����ID" dataset="dataset3">
      <DIV id=label26 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label26">���첿��ID</DIV>
      <INPUT id=m_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="m_deptid" china="���첿��ID" dataset="dataset3">
      <DIV id=label27 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label27">Э�첿��ID</DIV>
      <INPUT id=j_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="j_deptid" china="Э�첿��ID" dataset="dataset3">
      <DIV id=label28 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label28">���������ID</DIV>
      <INPUT id=receive_userid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="receive_userid" china="���������ID" dataset="dataset3">
      <DIV id=label36 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label36">��������������</DIV>
      <INPUT id=task_sponsor style="LEFT: 0px; WIDTH: 104px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=11 controltype="text" field="task_sponsor" china="��������������" dataset="dataset3">
      <DIV id=label29 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label29">��������������ID</DIV>
      <INPUT id=task_sponsorid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_sponsorid" china="��������������ID" dataset="dataset3">
      <DIV id=label30 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label30">���벿��ID</DIV>
      <INPUT id=apply_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_deptid" china="���벿��ID" dataset="dataset3">
      <DIV id=label31 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label31">���벿������</DIV>
      <INPUT id=apply_dept style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_dept" china="���벿������" dataset="dataset3">
      <DIV id=label32 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label32">������ID</DIV>
      <INPUT id=apply_userid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_userid" china="������ID" dataset="dataset3">
      <DIV id=label33 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label33">����������</DIV>
      <INPUT id=apply_user style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_user" china="����������" dataset="dataset3">
      <DIV id=label34 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label34">��ǰ����״̬</DIV>
      <INPUT id=status style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="status" china="��ǰ����״̬" dataset="dataset3">
      <DIV id=label35 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label35">����һ������</DIV>
      <INPUT id=nc style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="nc" china="����һ������" dataset="dataset3">
   </DIV>
   <DIV id=div6 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 14px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 70px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 760px; HEIGHT: 62px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset4 format="<fields><field><fieldname>detail_id</fieldname><datatype>�ַ�</datatype><displaylabel>��������ϸ����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>plan_oid</fieldname><datatype>�ַ�</datatype><displaylabel>�������´�ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_id</fieldname><datatype>�ַ�</datatype><displaylabel>�μӻ���ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>�ַ�</datatype><displaylabel>�μӻ���</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>speciality_id</fieldname><datatype>�ַ�</datatype><displaylabel>רҵID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>speciality_name</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>�ַ�</datatype><displaylabel>����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>�ַ�</datatype><displaylabel>���벿��</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>is_main</fieldname><datatype>�ַ�</datatype><displaylabel>���崦</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>memo</fieldname><datatype>�ַ�</datatype><displaylabel>����˵��</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a</fieldname><datatype>�ַ�</datatype><displaylabel>�޸�רҵ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target>_self</target><href>javascript:f_updateSpeciality()</href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>b</fieldname><datatype>�ַ�</datatype><displaylabel>ָ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target>_self</target><href>javascript:f_updateDept()</href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>c</fieldname><datatype>�ַ�</datatype><displaylabel>ɾ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target>_self</target><href>javascript:f_deleteSpeciality()</href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' onGetText='bill_ondatasetgettext("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' onValid='bill_ondatasetvalid("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="��"></fc:dataset>
   </DIV>
   <DIV id=div8 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 92px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 64px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 761px; HEIGHT: 58px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset5 format="<fields><field><fieldname>ideal_id</fieldname><datatype>�ַ�</datatype><displaylabel>����Id</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ideal_peoplename</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_departname</fieldname><datatype>�ַ�</datatype><displaylabel>����</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>action_name</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_result</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_conten</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>25%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_date</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>a</fieldname><datatype>�ַ�</datatype><displaylabel>�鿴</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target>_self</target><href>javascript:f_viewOpinion()</href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>5%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' onValid='bill_ondatasetvalid("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' opensortno="1" temptable="TMP_DATASET6" multiResult="��"></fc:dataset>
   </DIV>
   <DIV id=div10 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 169px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 64px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 759px; HEIGHT: 62px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset6 format="<fields><field><fieldname>oid</fieldname><datatype>�ַ�</datatype><displaylabel>�������´�ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_oid</fieldname><datatype>�ַ�</datatype><displaylabel>����ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasesid</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ�׶�ID</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phases</fieldname><datatype>�ַ�</datatype><displaylabel>��Ŀ�׶�����</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys_id</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' opensortno="1" temptable="TMP_DATASET7" multiResult="��"></fc:dataset>
   </DIV>
   <DIV id=div11 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 238px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 59px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 759px; HEIGHT: 61px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="��">
      <fc:dataset id=dataset7 format="<fields><field><fieldname>oid</fieldname><datatype>�ַ�</datatype><displaylabel>��������ϸ����ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>plan_oid</fieldname><datatype>�ַ�</datatype><displaylabel>�������´�ID</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_id</fieldname><datatype>�ַ�</datatype><displaylabel>�μӻ���ID</displaylabel><size>500</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>�ַ�</datatype><displaylabel>�μӻ�������</displaylabel><size>500</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>speciality_id</fieldname><datatype>�ַ�</datatype><displaylabel>רҵID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>speciality_name</fieldname><datatype>�ַ�</datatype><displaylabel>רҵ����</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>�ַ�</datatype><displaylabel>����ID</displaylabel><size>40</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>is_main</fieldname><datatype>�ַ�</datatype><displaylabel>�Ƿ����岿��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>12%25</columnWidth2></columnWidth1></field><field><fieldname>memo</fieldname><datatype>�ַ�</datatype><displaylabel>����˵��</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>28%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' opensortno="1" temptable="TMP_DATASET8" multiResult="��"></fc:dataset>
   </DIV>
</DIV>
</DIV>
<div id='grid_tip'></div></body></html>
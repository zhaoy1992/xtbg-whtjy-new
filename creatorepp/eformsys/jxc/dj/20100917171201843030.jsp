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
		
		//根据应用确定样式的目录
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
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

<!-- 提示：以下为页面的JS&CSS内容 -->
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


<!-- 提示：以下为页面自定义JS内容 -->
<script>
<%
    String userMobiletel1=accesscontroler.getUserAttribute("userMobiletel2");
    String userMobiletel2=accesscontroler.getUserAttribute("userMobiletel1");
%>
/* 系统信息  */
var userId = getSysElement("userid"); //用户ID
var userAccount = getSysElement("userAccount")//用户账号
var userName = getSysElement("userName"); //用户名称
var userMobiletel1="<%=userMobiletel1%>"; //用户电话
if(IsSpace(userMobiletel1)){
    userMobiletel1="<%=userMobiletel2%>";
}
var orgId = getSysElement("userorgid"); //用户所属机构id
var orgName = getSysElement("userorgname"); //用户所属机构名称
var strDate = executeSelect("select to_char(sysdate,'yyyy-mm-dd') as a,to_char(sysdate,'yyyymmdd') as b from dual",1,1); //当前数据库服务器日期
var currentDateTime =strDate[0][0];
var currentDateTimes=strDate[0][1];

/* 流程信息 */
var entrustId=creator_getQueryString("entrust_id");
var taskId=creator_getQueryString("task_id");
var opType=creator_getQueryString("opType");//当前记录的流程状态
var cc_form_instanceid = Trim(creator_getQueryString("cc_form_instanceid"));//流程业务ID
/* 当前活动ID */
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
/* 当前活动名称 */
var actName = creator_getQueryString("actDefName"); 
var actNames = {
    actionname1 : "委托登记",
    actionname2 : "部门/分公司领导审批",
    actionname3 : "总部市场部管理员审核",
    actionname4 : "协助项目安排",
    actionname5 : "总部市场部领导审批",
    actionname6 : "郑分市场部领导安排",
    actionname7 : "主办部门领导审批",
    actionname8 : "主办人确认",
    actionname9 : "结束",
    actionname10: "委托中止"
}   
/* 角色信息 */
var roles = {
    rolename1 : "总部市场部工程管理员",//对应以前的"总部市场部管理员"
    rolename2 : "总部市场部领导",
    rolename3 : "郑分技市部主管工程领导",
    rolename4 : "分公司领导",
    rolename5 : "部门领导"  
}
/* 业务信息 */
var forwardUrl="../../../common_workflow/main.jsp";//启动流程和完成活动后转发页面

var hq_orgId="00700104100";//总部市场部机构ID
var userType="";//用户所在机构、部门类型    0：总部市场部人员  1：总部非市场部人员  2：郑分人员  3：其他分公司人员
var offerSql="";//安排列表sql
/* 页面初始化 */
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
    if($("status").value=="暂存"){
        hideOrShowTabByName('审批信息','hide');
    }else{
        $("txyj1").style.display="none";
        $("txyj2").style.display="none";
    }
    $("next").style.display="none";
    if($("status").value==actNames.actionname3||$("status").value==actNames.actionname4||$("status").value==actNames.actionname5){
        hideOrShowTabByName('安排建议单','hide');
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
 * 新增页面基础业务初始化
 */
function f_newBaseInit(){
    if(IsSpace(entrustId)){
        f_newInit();
    }else{
        f_existInit();
    }
}
/**
 * 已有数据页面基础业务初始化(已启动流程)
 */
function f_existBaseInit(){
    f_displayUI();
    //任务安排
    var planSql=" select oid as plan_id, task_oid, design_phasesid, design_phases, proj_level,"
        +" specialitys_id, specialitys,to_char(task_confirmdate,'yyyy-mm-dd') as task_confirmdate,"
        +" to_char(task_expectdate,'yyyy-mm-dd') as task_expectdate, m_deptid, m_dept, j_deptid, j_dept, receive_userid,"
        +" receive_user, task_sponsorid, task_sponsor, apply_deptid, apply_dept, apply_userid, apply_user, status,nc"
        +" from ta_project_task_plan"
        +" where cc_form_instanceid='"+cc_form_instanceid+"'";
    //alert("planSql:"+planSql);
    dataset3.Open(planSql);
    
    //委托任务
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
                  +" where t.approval_id=d.approval_id and d.is_pass='是' and t.design_status<>'2'"
                  +" and t.design_id='"+dataset2.Fields.Field['design_id'].Value+"'";
        var ret = executeSelect(sqlstr,1,1);        
        if(ret.length>0){
            $("used_phaseid").value=ret[0][0];
            $("used_phase").value=ret[0][1];
        }
    }
    f_displayInfoByType($("entrust_type").value);
    
    //委托信息
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
                +" case is_main when 0 then '是' else '否' end as is_main, memo"
                +" from ta_project_task_plan_detail_v where plan_oid='"+$("plan_id").value+"'";
        dataset7.Open(sql2);
        if(IsSpace(dataset6.Fields.Field['oid'].Value)){
            hideOrShowTabByName('安排建议单','hide');
        }
    }
}
/**
 * 不存在业务数据
 */
function f_newInit(){
    $("workflowControl_start").style.display="none";
    $("planTypeBtn").disabled=true;
    $("entrust_id").value=getNewCc_form_instanceid(false);
    //初始化页面元素的值
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
    $("other_request").value="无";
}
function f_displayUI(){
    //显示“顾客需求信息”
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
    //显示“项目安排建议单”
    $("xmjy1").style.display="block";
    $("xmjy2").style.display="block";
    //显示“项目下达信息”
    $("rwxd1").style.display="block";
    $("rwxd2").style.display="block";
}
/**
 * 存在业务数据（还未启动流程）
 */
function f_existInit(){
    f_displayUI();
    //委托信息
    var infoSql=" select entrust_id,entrust_no,inputer_id,inputer,to_char(inputer_date,'yyyy-mm-dd') as inputer_date,"
                +" dept_id,dept_name,client,entrust_subject,entrust_way,entrust_explain,entrust_way_no,opposite_linkman,"
                +" opposite_phone,opposite_org,our_linkman,our_phone,our_org,remark"
                +" from ta_project_entrust_record"
                +" where entrust_id='"+entrustId+"'";
    dataset1.Open(infoSql);
    //alert("infoSql:"+infoSql);
    f_AttachInit(true);
    $("entrust_type").disabled=true;
    //委托任务
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

    //任务安排
    var planSql=" select oid as plan_id, task_oid, design_phasesid, design_phases, proj_level,"
        +" specialitys_id, specialitys,to_char(task_confirmdate,'yyyy-mm-dd') as task_confirmdate,"
        +" to_char(task_expectdate,'yyyy-mm-dd') as task_expectdate, m_deptid, m_dept, j_deptid, j_dept, receive_userid,"
        +" receive_user, task_sponsorid, task_sponsor, apply_deptid, apply_dept, apply_userid, apply_user, status,nc"
        +" from ta_project_task_plan"
        +" where task_oid='"+taskId+"'";
    dataset3.Open(planSql);
    if(!(IsSpace(dataset3.Fields.Field['status'].Value)||(dataset3.Fields.Field['status'].Value=="暂存"))){
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
        hideOrShowTabByName('审批信息','hide');
    }
}
/**
 * 根据委托类型显示任务信息
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
        $("btn_relate").style.display="none";//设计编号、工程名称都不能被选择
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
        $("rw_phase_label").innerText="新增阶段";
        $("gljb").setAttribute("colSpan","3");
        $("fzjg1").style.display="none";
        $("fzjg2").style.display="none";
    }else if(entrustType=="phase_update"){
        $("rwxx_label").innerText="新增设计阶段";
        $("rw_phase_label").innerText="阶段选择";
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
 * 项目安排建议单明细初始化
 */
function f_OfferDetailInit(){
    var sql=" select oid as detail_id, plan_oid, org_id, org_name, speciality_id, speciality_name,"
           +" dept_id, dept_name, case is_main when 0 then '是' else '否' end as is_main, memo,";
           if(IsSpace($("nc").value)){
                if(opType=="view"){
                    sql+=" null as a,null as b,null as c";                  
                }else{
                    var remark4=SqlToField("select f_getSecondRemark4('"+orgId+"') from dual");
                    if(actId==actIds.actId2||actId==actIds.actId6){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" null as a,case when f_getSecondOrgId('"+orgId+"')=org_id then '指定部门' else null end as b,null as c";                          
                        }else{
                            sql+=" null as a,null as b,null as c";
                        }
                    }else if(actId==actIds.actId1||actId==actIds.actId3||actId==actIds.actId5){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" '修改专业' as a,case when f_getSecondOrgId('"+orgId+"')=org_id then '指定部门' else null end as b,'删除' as c";                            
                        }else{
                            sql+=" '修改专业' as a,null as b,'删除' as c";
                        }
                    }else if(actId==actIds.actId4){
                        if(remark4=="zongbu"||remark4=="zhengzhou"){
                            sql+=" case when f_getSecondOrgId('"+orgId+"')=org_id then '修改专业' else null end as a,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then '指定部门' else null end as b,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then '删除' else null end as c";                            
                        }else{
                            sql+=" case when f_getSecondOrgId('"+orgId+"')=org_id then '修改专业' else null end as a,"
                                +" null as b,"
                                +" case when f_getSecondOrgId('"+orgId+"')=org_id then '删除' else null end as c";
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
 * 审批意见初始化
 */
function f_opinionInit(){
    var sql=" select ideal_id,ideal_peoplename,ideal_departname,ideal_result,ideal_conten,"
           +" to_char(ideal_date,'yyyy-mm-dd hh24:mi') as ideal_date,action_name,'查看' as a "
           +" from ta_project_approval_opinion"
           +" where businessid ='"+$("plan_id").value+"' order by ideal_id asc";
    //alert("审批意见sql = "+sql);
    dataset5.Open(sql);
}
/**
 * 不同的流程环节界面和业务初始化
 */
function f_wfInit(){
    if(actId==actIds.actId1){
        //hideOrShowTabByName('审批信息','hide');
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
        $("save").style.display="none";//在完成活动环节隐藏保存按钮
        //在审批环节中对页面元素进行只读、活动等控制
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
    
    if((actId==actIds.actId3||actId==actIds.actId4||actId==actIds.actId5)&&($("status").value=="等待处理")){
        $("workflowControl_complete").style.display="none";
        hideOrShowTabByName('安排建议单','hide');
        alert("该任务还是等待处理状态，不能发起流程！");
    }
    
    if(!((actId==actIds.actId3)||((actId==actIds.actId4)||(actId==actIds.actId5)))){
         hideOrShowTabByName('安排建议单','hide');
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
            //主体处领导
            $("DYNAMICPERFORMER").value=rets[0][0];
            $("DYNAMICPERFORMER_NAME").value=rets[0][2];
            if(IsSpace(DYNAMICPERFORMER)){
                alert("没有找到主办部门的领导！");
            }
            $("nextAction").innerText=actNames.actionname7;
        }
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
    }
    if(actId==actIds.actId6){
        var ret=f_getMdeptLeader();
        //主体处领导
        $("DYNAMICPERFORMER").value=ret[0][0];
        $("DYNAMICPERFORMER_NAME").value=ret[0][1];
        if(IsSpace(DYNAMICPERFORMER)){
            alert("没有找到主办部门的领导！");
        }
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname7;
    }
    if(actId==actIds.actId7){
        $("button_xzxr").onclick=function(){ f_pickRoleUser(); }
        $("nextAction").innerText=actNames.actionname8;
        $("nextUserlabel").innerText="立项申请人选择：";
    }
    if(actId==actIds.actId8){
        $("shxx").style.display="none";
        $("button_wchd").setAttribute("value","结束");
        $("nextAction").innerText=actNames.actionname9;
    }
    if(!IsSpace($("parent_id").value)){
        $("btn_relate").style.display="none";
    }
}

/**
 * 获取主体处领导SQL
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
 * 获取主体处领导
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
 * 改变审核结论事件
 */
function f_changeAgree(){
    if(actId==actIds.actId2){
        if($("agree").value=="同意"){
            $("shxx").style.display="block";
            $("button_wchd").setAttribute("value","提交");
            $("nextAction").innerText=actNames.actionname3;
        }else if($("agree").value=="不同意"){
            $("shxx").style.display="none";
            $("button_wchd").setAttribute("value","回退");
            $("nextAction").innerText=actNames.actionname1;
        }
    }else if(actId==actIds.actId5){
        if($("agree").value=="同意"){
            $("shxx").style.display="block";
            $("button_wchd").setAttribute("value","提交");
            if(f_existZf()){
                $("nextAction").innerText=actNames.actionname6; 
            }else{
                $("nextAction").innerText=actNames.actionname7;
            }
        }else if($("agree").value=="不同意"){
            $("shxx").style.display="none";
            $("button_wchd").setAttribute("value","结束");
            $("nextAction").innerText=actNames.actionname3;
        }
    }else if(actId==actIds.actId8){
        if($("agree").value=="同意"){
            $("button_wchd").setAttribute("value","结束");
            $("nextAction").innerText=actNames.actionname9;
        }else if($("agree").value=="不同意"){
            $("button_wchd").setAttribute("value","回退");
            $("nextAction").innerText=actNames.actionname7;
        }
    }
}
/**
 * 是否存在郑分
 */
function f_existZf(){
    var sql="select count(*) as num from ta_project_task_plan_detail t where t.org_name like '郑州%' and t.plan_oid='"+$("plan_id").value+"'";
    if(SqlToField(sql)==0){
        //alert("不存在记录");
        return false;
    }else{
        //alert("存在记录");
        return true;
    }
}
/**
 * 初始化第一个环节时需要指定的下一个环节执行人
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
 * 发起人类型初始化
 * 0：总部市场部人员
 * 1：总部非市场部人员
 * 2：郑分人员
 * 3：其他分公司人员
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
            alert("系统管理员不能发起任务委托！");            
        }
        $("save").style.display="none";
        return false;
    }
}
function f_pickRoleUser(){
    var rootName="";
    var strSql="";
    if(actId==actIds.actId1){
        //userType 用户所在机构、部门类型   0：总部市场部人员  1：总部非市场部人员  2：郑分人员  3：其他分公司人员
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
            //alert("郑分技术市场部领导");
            rootName=roles.rolename3;
            strSql=" select b.user_name as id,'1' as parent_id,b.user_realname as name"
               +" from td_sm_role a,td_sm_user b,td_sm_userrole c"
               +" where a.role_id=c.role_id and b.user_id=c.user_id and a.role_name='"+roles.rolename3+"'"
               +" order by b.user_sn asc";
        }else{
            rootName="主办部门领导";
            strSql=f_getMdeptLeaderSql();
        }
    }else if(actId==actIds.actId6){
        rootName="主办部门领导";
        strSql=f_getMdeptLeaderSql();
    }else if(actId==actIds.actId7){
        var org_id=$("m_deptid").value;
        var hidden_orgid=SqlToField("select wmsys.wm_concat(distinct (t.org_id)) from td_sm_organization t  connect by t.parent_id = prior t.org_id start with t.org_id in ('"+org_id+"')");
        var obj={
            flag:"1",
            sql:"",
            title:"选择生产任务主办人",
            isRadio:true,
            ObjId:DYNAMICPERFORMER,
            ObjName:DYNAMICPERFORMER_NAME,
            rootId:"0",
            rootName:"机构",
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
         title:"选择下一步执行人",
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
 * 附件初始化
 */
function f_AttachInit(delflag){
    var businessid=$("entrust_id").value;
    var obj={
        cc_form_instanceid:"",
        businessid:businessid,
        divid:"upload_td",
        showtype:"table",//为空时为调用回调函数，一般(common),表格(table)
        delflag:delflag,//true可删除,false:不可删除,为空时为不可删除，默认为false
        callback:""//回调函数，回调函数，当showtype为空时才会执行。
    }
    InitAttach(obj);    
}
/* 界面操作 */
/**
 * 改变委托方式
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
            $("way_explain1").innerText = "电话说明";
            $("way_explain2").setAttribute("colSpan", "5");
            break;
        case "2":
            $("way_no1").style.display = "none";
            $("way_no2").style.display = "none";
            $("way_explain1").innerText = "来源说明";
            $("way_explain2").setAttribute("colSpan", "5");
            break;
        case "3":
            $("way_no1").style.display = "block";
            $("way_no2").style.display = "block";
            $("way_no1").innerText = "公文文号";
            $("way_explain1").innerText = "公文标题";
            $("way_explain2").setAttribute("colSpan", "3");
            break;
        case "4":
            $("way_no1").style.display = "block";
            $("way_no2").style.display = "block";
            $("way_no1").innerText = "中标编号";
            $("way_explain1").innerText = "中标结果";
            $("way_explain2").setAttribute("colSpan", "3");
            break;
    }
}
/**
 * 项目信息-关联已有项目
 */
function f_relate(){
    //id btn_relate
    var url = getOpenUrlByDjid('20100721104724062482');
    var obj = window.showModalDialog(url,obj,"dialogWidth=800px;dialogHeight=390px");
    if(null!=obj){
        $("proj_id").value=obj.proj_id;//工程项目ID
        $("proj_name").value=obj.proj_name;//工程名称
        $("design_id").value=obj.design_id;//设计编号
        $("custom_proj_name").value=obj.custom_proj_name;//客户项目名称
        $("custom_proj_id").value=obj.custom_proj_id;//客户项目编号
        $("ascription").value=obj.ascription;//项目归属
        $("province").value=obj.province;//省市
        $("belong_orgid").value=obj.belong_orgid;//归属机构ID
        $("belong_org").value=obj.belong_org;//归属机构名称
        $("profession_property").value=obj.profession_property;//专业属性
        $("proj_type").value=obj.proj_type;//工程类型
        $("responsible_orgid").value=obj.responsible_orgid;//负责机构ID
        $("responsible_org").value=obj.responsible_org;//负责机构名称
        $("proj_level").value=obj.proj_level;//管理级别
        $("used_phaseid").value=obj.used_phaseid;//已立项阶段ID
        $("used_phase").value=obj.used_phase;//已立项阶段名称
        $("approval_date").value=obj.approval_date;//立项日期
        $("add_entrust_phase").value="";
        $("undo_entrust_phase").value="";
    }
}
/**
 * 选择撤销的设计阶段
 */
function f_pickUndoPhase(){
    var obj={ 
        flag:"1",
        sql:"",
        title:"安排阶段",
        isRadio:false,
        ObjId:undo_entrust_phaseid,
        ObjName:undo_entrust_phase,
        rootId:"0",
        rootName:"可中止阶段"
    };
    obj.sql=" select c.oid as id,'0' as parent_id,c.design_phasename as name"
           +" from ta_project_basic_info a,ta_project_approval b,ta_project_approval_phase c"
           +" where a.proj_id = b.proj_id and b.approval_id = c.approval_id"
           +" and a.isvalid != '1' and b.is_pass = '是'"
           +" and c.proj_id='"+$("proj_id").value+"' and c.design_status='1'";
    OpenTreeFromSql(obj);
}
/**
 * 选择新增阶段 包含新项目和已有项目的
 */
function f_pickNewPhase(){
    var phaseId=$("add_entrust_phaseid").value;
    var obj={
        flag:"1",
        sql:"",
        title:"新增委托阶段",
        isRadio:false,
        ObjId:add_entrust_phaseid,
        ObjName:add_entrust_phase,
        rootId:"0",
        rootName:"委托阶段",
        callback:f_isAlterPhase()//该处没有起作用
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
        if(phasename.indexOf("初设")!=-1||phasename.indexOf("施设")!=-1){
            tmp=",'一阶段'";
        }
        if(phasename.indexOf("一阶段")!=-1){
            tmp=",'初设','施设'";
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
 * 选择安排阶段
 */
function f_pickPlanPhase(){ 
    var obj={ 
        flag:"1",
        sql:"",
        title:"安排阶段",
        isRadio:false,
        ObjId:design_phasesid,
        ObjName:design_phases,
        rootId:"0",
        rootName:"可安排阶段"
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

/* 业务操作 */
/**
 * 委托信息-上传附件
 */
function f_upload(){    
    var sbusinessid = $("entrust_id").value;
    var attachObj = new Attachment({
        businessid:sbusinessid,//业务主键ID
        djsn:$("SKbillsheet").dj_sn,//表单ID
        cc_form_instanceid:"",//与businessid两者有一个即可
        divid:"upload_td" ,  //div对象ID
        fileMaxCount:"1",//允许上传的文件个数，默认为100
        showtype:"table"//为空时为调用回调函数方式，一般(common),表格(table)
    });
    attachObj.showUpload();//弹出附件上传窗口
}
/**
 * 点击保存按钮操作
 */
function f_save(){
    if(IsSpace($("entrust_no").value)){//没有“委托信息”和“委托任务”数据的情况
        f_entrustNo();
        f_saveInfo();
    }else{
        if(f_updateData()){
            alert("保存成功！");
        }
    }
}
function f_saveInfo(){
    if(f_validateInfo()){
        if(f_insertData()){
            alert("保存成功！"); //\n请填写以下信息！
            $("entrust_type").disabled=true;
            //显示“顾客需求信息”
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
            alert("保存失败！errorCode:"+msg+" | sql:"+sql);
            return false;
        }
    }
}
function f_validateInfo(){
    if(IsSpace($("entrust_type").value)){
        alert("委托类型不能为空！");
        return false;
    }else if(IsSpace($("client").value)){
        alert("委托单位不能为空！");
        return false;
    }else if(IsSpace($("entrust_way").value)){
        alert("委托类型不能为空！");
        return false;
    }
    return true;
}
function f_validateTask(){
    if(f_validateInfo()){
        if($("entrust_type").value=="project_new"){
            if(IsSpace($("proj_name").value)){
                alert("项目名称不能为空！");
                return false;
            }else if(IsSpace($("ascription").value)){
                alert("项目归属不能为空！");
                return false;
            }else if(IsSpace($("province").value)){
                alert("省市不能为空！");
                return false;
            }else if(IsSpace($("belong_orgid").value)){
                alert("归属机构不能为空！");
                return false;
            }else if(IsSpace($("profession_property").value)){
                alert("专业属性不能为空！");
                return false;
            }else if(IsSpace($("proj_type").value)){
                alert("工程类型不能为空！");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("委托阶段不能为空！");
                return false;
            }
        }else if($("entrust_type").value=="phase_new"){
            if(IsSpace($("proj_name").value)){
                alert("请关联已有项目！");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("新增阶段不能为空！");
                return false;
            }
        }else if($("entrust_type").value=="phase_update"){
            if(IsSpace($("proj_name").value)){
                alert("请关联已有项目！");
                return false;
            }else if(IsSpace($("undo_entrust_phase").value)){
                alert("中止阶段不能为空！");
                return false;
            }else if(IsSpace($("add_entrust_phase").value)){
                alert("新增阶段不能为空！");
                return false;
            }
        }
        if(IsSpace($("expect_date").value)){
            alert("要求完成日期不能为空！");
            return false;
        }else if(IsSpace($("dimensions").value)){
            alert("设计规模不能为空！");
            return false;
        }else if(IsSpace($("investment").value)){
            alert("工程总投资不能为空！");
            return false;
        }else if(IsSpace($("other_request").value)){
            alert("其他要求不能为空！");
            return false;
        }else if(IsSpace($("dimensions").value)){
            alert("设计规模不能为空！");
            return false;
        }
        else if(IsSpace($("opposite_linkman").value)){
            alert("对方接口人不能为空！");
            return false;
        }else if(IsSpace($("opposite_phone").value)){
            alert("对方接口人电话不能为空！");
            return false;
        }else if(IsSpace($("opposite_org").value)){
            alert("对方接口单位不能为空！");
            return false;
        }else if(IsSpace($("our_linkman").value)){
            alert("我方接口人不能为空！");
            return false;
        }else if(IsSpace($("our_phone").value)){
            alert("我方接口人电话不能为空！");
            return false;
        }else if(IsSpace($("our_org").value)){
            alert("我方接口单位不能为空！");
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
            alert("项目安排阶段不能为空！");
            return false;
        }else if(IsSpace($("proj_level3").value)){
            alert("管理级别不能为空！");
            return false;
        }
        if(($("entrust_type").value=="project_new")&&(IsSpace($("charger_orgid").value))){
            alert("负责机构不能为空！");
            return false;
        }
        return true;        
    }else{
        return false;       
    }
}
/**
 * 新增业务数据
 */
function f_insertData(){
    $("task_id").value=getNewCc_form_instanceid(false);
    $("plan_id").value=getNewCc_form_instanceid(false);
    $("status").value="暂存";
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
       +$("entrust_status").value+"','无')"
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
        //alert("新增业务数据成功！");
        return true;
    }else{
        alert("新增业务数据失败！errorCode:"+msg+" | sql:"+sql);
        return false;
    }
}
/**
 * 修改业务数据
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
        //alert("保存业务数据成功！");
        return true;        
    }else{
        alert("修改业务数据失败！errorCode:"+msg+" | sql:"+sql);
        return false;
    }
}

/**
 * 项目安排建议单-增加专业安排
 */
function f_newOfferSp(){
    var url = getOpenUrlByDjid("20100713175839328371");//增加专业安排表单ID
    var obj = new Object();
    obj.plan_id = $("plan_id").value;//任务安排ID
    var ret = window.showModalDialog(url,obj,"dialogWidth=600px;dialogHeight=300px");
    f_feedbackPlan();
    //处理修改后反馈问题
    f_OfferDetailInit();
    f_feedbackPlanDept();
}
/**
 * 在安排建议明细中修改专业
 */
function f_updateSpeciality(){
    var url=getOpenUrlByDjid("20100713175839328371");//修改专业安排表单ID
    var obj=new Object();
    obj.detail_id=dataset4.Fields.Field['detail_id'].Value;//专业安排ID
    var ret=window.showModalDialog(url,obj,"dialogWidth=600px;dialogHeight=300px");
    f_OfferDetailInit();
    //处理修改后反馈问题
    f_feedbackPlan();
    f_feedbackPlanDept();
}
/**
 * 反馈任务安排计划
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
        //alert("反馈更新专业成功！");
    }else{
        alert("反馈更新专业失败！errorCode:"+msg+"sql:"+strSql);
    }
}
/**
 * 在安排建议明细中指定部门
 */
function f_updateDept(){
    var url=getOpenUrlByDjid("20100715104202078487");//修改专业安排中的部门信息
    var obj=new Object();
    obj.detail_id =dataset4.Fields.Field['detail_id'].Value;//专业安排明细ID
    obj.plan_id =dataset4.Fields.Field['plan_oid'].Value;//计划ID
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
    //alert("主体部门sql:"+sql);
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
        //主体处领导
        $("DYNAMICPERFORMER").value=rets[0][0];
        $("DYNAMICPERFORMER_NAME").value=rets[0][1];
        if(IsSpace(DYNAMICPERFORMER)){
            alert("没有找到主办部门的领导！");
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
              
    //alert("参与部门sql:"+strSql);
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
        //alert("回填主办和参与部门成功！");
    }else{
        alert("回填主办和参与部门出错！errorCode:"+msg+" | sql:"+sqlStr);
    }
}
/**
 * 在安排建议明细中删除专业
 */
function f_deleteSpeciality(){
    if(confirm("您确定要删除？")){
        var id=dataset4.Fields.Field['detail_id'].Value;//专业安排ID        
        var sql="delete from ta_project_task_plan_detail where oid = '"+id+"'";
        var ret=creator_update(sql);
        if(IsSpace(ret)){
            alert("删除成功！");
        }else{
            alert("删除失败！errorCode:"+ret+" | sql:"+sql);
        }
        f_OfferDetailInit();
        //处理修改后反馈问题
        f_feedbackPlanDept();
    }
}
/**
 * 项目安排方式选择
 */
function f_selPlanType(){
    var design_id = $("design_id").value;
    var obj = new Object();
    obj.plan_id = $("plan_id").value;//安排ID
    
    var sql=" select phase_id,phase_name,design_id from"
           +" ("
           +" select b.design_phaseid as phase_id,b.design_phasename as phase_name,b.design_id,c.order_number"
           +" from ta_project_approval a,ta_project_approval_phase b,ta_project_design_phase c"
           +" where a.approval_id=b.approval_id and b.design_phaseid=c.design_phaseid"
           +" and a.is_pass='是' and a.design_id='"+design_id+"' order by c.order_number desc"
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
            var type = retObj.type;//安排类型
            if(type=="0"){//安排一致
                $("nc").value=retObj.nc;
                $("nc_describe").innerText=retObj.nc;//安排一致描述
                $("btn_relate").disabled=true;
                $("planAddBtn").disabled=true;
                f_feedbackPlan();
                hideOrShowTabByName('审批信息','hide');
            }else if(type=="1"){//修改
                $("nc").value="";
                $("nc_describe").innerText="";
                $("btn_relate").disabled=false;
                $("planAddBtn").disabled=false;
                f_feedbackPlan();
                hideOrShowTabByName('审批信息','show');
            }else if(type=="2"){//重新安排
                $("nc").value="";
                $("nc_describe").innerText="";
                $("btn_relate").disabled=false;
                $("specialitys").value="";
                $("specialitys_id").value="";
                
                $("planAddBtn").disabled=false;
                hideOrShowTabByName('审批信息','show');
            }
        }
        f_OfferDetailInit();
        f_feedbackPlanDept();
    }else{
        alert("当前项目找不到相应的已立项阶段！");
    }
}
/* 流程操作 */
/**
 * 流程启动前执行的操作
 */
function f_preStartAct(){
    //页面元素赋值    业务元素    流程相关元素
    if(f_validatePlan()&&f_validateWf()){
        $("status").value="部门/分公司领导审批";
        $("entrust_status").value="2";
        return true;
    }else{
        //alert("未通过验证！");
        return false;
    }
}
/**
 * 启动流程
 */
function f_startAct(){
    if(f_isNc()){
        if(confirm("您确定要提交吗？")){
            var sql=" <no>"
                   +" update ta_project_task_record set"
                   +" entrust_status='5'"
                   +" where oid='"+$("task_id").value+"'"
                   +" </no>"
                   +" <no>"
                   +" update ta_project_task_plan set"
                   +" task_sponsorid='"+userAccount+"',"
                   +" task_sponsor='"+userName+"',"
                   +" status='结束'"
                   +" where oid='"+$("plan_id").value+"'"
                   +" </no>";
            var msg=InsertSqls(sql);
            if(IsSpace(msg)){
                alert("安排无变化的设计阶段，不经过审批过程！\n您可以接下来可以直接处理后面的业务！");
                var url=location.protocol+"//"+location.host+getContextPath()+"/ccapp/zxyd/project/entrust/entrust_task_list.jsp";
                window.open(url,"_self","");
            }else{
                alert("更新 安排无变化的设计阶段 状态 出错 errorCode:"+msg+" | sql:"+sql);
            }
        }
    }else{
        if(f_preStartAct()){
            if(confirm("您确定要提交吗？")){
                if(f_updateData()&&f_insertIdeal()){
                    $("isOver").value="1";
                    fcpubdata.cc_form_instanceid=Trim((fcpubdata.cc_form_instanceid).replace("clear,",""));
                    creator_djsave('启动流程',false,true,forwardUrl);
                }                   
            }
        }
    }
}
/**
 * 判断是否“安排无变化的设计阶段新增和修改”
 */
function f_isNc(){
    if(IsSpace($("nc").value)){
        return false;
    }else{
        return true;
    }
}
/**
 * 完成活动前执行的操作
 */
function f_preCompleteAct(){
    var agree=$("agree").value;
    //根据不同的流程环节对页面元素赋值  业务元素    流程相关元素

    if((actId==actIds.actId2)||(actId==actIds.actId8)){
        if(agree=="不同意"){
            if(IsSpace($("ideal").value)){
                alert("请填写审核意见！");
                return false;
            }
        }
    }
    if((actId==actIds.actId3)&&($("workflowControl_selectAct").value=="taskEntrust_wp1_act4")){
        $("DYNAMICPERFORMER").value=SqlToField("select user_name from td_sm_user where user_id='"+$("DYNAMICPERFORMER").value+"'");
    }
    if(actId==actIds.actId5){//在"总部市场部领导审批"时，填写“任务确定时间”
        if(agree=="不同意"){
            if(IsSpace($("ideal").value)){
                alert("请填写审核意见！");
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
 * 完成活动
 */
function f_completeAct(){
    if(f_preCompleteAct()){
        if(confirm("您确定要提交吗？")){
            if($("agree").value=="同意"){
                $("verdict").value=0;               
            }else{
                $("verdict").value=1;
            }
            
            if(($("verdict").value==1)&&((actId==actIds.actId2)||(actId==actIds.actId8))){
                if(confirm("审批不同意将回退，您确定要提交吗？")){
                    if(actId==actIds.actId2){
                        $("status").value=actNames.actionname1;
                    }else{
                        $("status").value=actNames.actionname7;
                    }
                    if(f_updateData()&&f_insertIdeal()){
                        creator_djsave('回退',false,true,'');
                        retAction();
                    }
                }
            }else{
                //对流程状态字段进行控制
                if(actId==actIds.actId1){
                    if($("isHqMarketer").value=="0"){
                        $("status").value=actNames.actionname3;//"总部市场部管理员审核";
                    }else if($("isHqMarketer").value=="1"){         
                        $("status").value=actNames.actionname2;//"部门/分公司领导审批";
                    }
                    $("entrust_status").value="1";
                }else if(actId==actIds.actId2){
                    if($("agree").value=="不同意"){
                        $("status").value=actNames.actionname1;//"委托登记";
                    }else{
                        $("status").value=actNames.actionname3;//"总部市场部管理员审核";
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
                            //alert("任务安排备份失败");
                            return ;
                        }
                    }
                    //判断是否存没有被安排的阶段，如果存在则分解任务
                    if((actId==actIds.actId8)&&($("design_phases").value!=$("add_entrust_phase").value)){//&&($("entrust_type").value=="project_new")
                        if(!f_taskResolve()){
                            alert("拆分任务失败！");
                            return ;
                        }
                    }
                    creator_djsave('完成活动',false,true,'');
                    retAction();
                }
                
            }
        }
    }
}
/**
 * 终止流程
 */
function over_workflow(){
    $("isOver").value="0";
    $("status").value=actNames.actionname10;
    if(f_updateData()&&f_insertIdeal()){
        creator_djsave('完成活动',false,true,'');
        retAction();
    }
}

/**
 * 在总部市场部领导审批不同时，委托中止，通知分发前面所有的流程人执行人
 */
function f_notice(){
    var sql=" select wmsys.wm_concat(distinct t.ideal_peopleid) as user_ids"
           +" from ta_project_approval_opinion t"
           +" where businessid ='"+$("plan_id").value+"'";
    var userids=SqlToField(sql);
    var businessName="任务委托";
    var otherpas="cc_form_instanceid="+cc_form_instanceid+"==opType=view";
    var readpath="eformsys/jxc/dj/20100917171201843030.jsp?";
    var businessid=$("plan_id").value;
    var proj_name=$("proj_name").value; 
    var displayPams="==opType=view";
    //调用分发接口
    sendMsg(businessName,otherpas,readpath,userids,businessid,proj_name);   
}
/**
 * 分发
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
    var businessName="任务委托";
    var otherpas="cc_form_instanceid="+cc_form_instanceid+"==opType=view";
    var readpath="eformsys/jxc/dj/20100917171201843030.jsp?";
    var businessid=$("plan_id").value;
    var proj_name=$("proj_name").value; 
    var displayPams="==opType=view";
    //调用分发接口
    sendMsg(businessName,otherpas,readpath,userids,businessid,proj_name);
}

/**
 * 任务安排备份
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
        alert("任务安排备份失败sql:"+sql);
        return false;
    }
}
/**
 * 任务分解
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
    //alert("任务分解后发起人sql:"+sqlUser);
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
           +" '"+ideal_departid+"', '"+ideal_departname+"', '"+ideal_peopleid+"', '"+ideal_peoplename+"', '等待处理')"
           +" </no>";
    //alert("任务分解sql:"+sql);
    var tmp=fcpubdata.cc_form_instanceid;
    var ntmp=getNewCc_form_instanceid(false);
    fcpubdata.cc_form_instanceid=ntmp;
    var msg=InsertSqls(sql);
    fcpubdata.cc_form_instanceid=tmp;
    if(IsSpace(msg)){
        //alert("任务分解成功！sql:"+sql);
        return true;
    }else{
        alert("任务分解失败！errorCode:"+msg+" sql:"+sql);
        return false;
    }
}
/**
 * 效验是否可以启动流程
 * 需要安排主体部门
 */
function f_validateWf(){
    if(actId==actIds.actId5){//(actId==actIds.actId1)||actId==actIds.actId3||actId==actIds.actId4||
        var sql=" select count(*) as num from ta_project_task_plan_detail"
               +" where plan_oid='"+$("plan_id").value+"' and is_main=0";
        //alert("sql:"+sql);
        if(SqlToField(sql)==0){
            alert("没有安排主体部门！");
            return false;
        }
    }
    
    if((actId==actIds.actId1)||(actId==actIds.actId2)||(actId==actIds.actId3)||(actId==actIds.actId5)){
        if(IsSpace($("DYNAMICPERFORMER").value)){
            alert("请选择流程下一步执行人！");
            return false;
        }
    }
    
    if(actId==actIds.actId5||actId==actIds.actId6){//actId==actIds.actId2||actId==actIds.actId3||actId==actIds.actId4||
        var sql="select count(*) as numm from ("+offerSql+") where dept_id is null and b='指定部门'";
        if(SqlToField(sql)==0){
            //alert("不存在记录");
        }else{
            alert("请指定本机构的参与部门！");
            return false;
        }
    }
    if(actId==actIds.actId7){
        if(IsSpace($("task_sponsor").value)){
            alert("请选择生产任务主办人！");
            return false;
        }
    }
    if((actId==actIds.actId2)||(actId==actIds.actId5)){
        if(($("agree").value=="不同意")&&(IsSpace($("ideal").value))){
            alert("请填写审批意见！");
            return false;
        }
    }
    return true;
}
/**
 * 回退
 */
function f_backAct(){
    if(f_insertIdeal()){
        creator_djsave('回退',false,true,'');
        retAction();
    }
}
/* 业务和流程公用的函数 */
/**
 * 在审批环节中增加审批意见
 */
function f_insertIdeal(){
    var ideal_id = getNewCc_form_instanceid(false);//审批信息ID
    var result = $("agree").value;//审批结论
    var ideal = $("ideal").value;//审批意见
    var businessid=$("plan_id").value;//基础业务Id
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
        //alert("增加审批意见成功！");
        return true;
    }else{
        alert("增加审批意见失败！errorCode:"+ret+" | sql:"+sql);
        return false;
    }
}
/** 查看审核详细信息 */
function f_viewOpinion(){
    var ideal_id = dataset5.Fields.Field['ideal_id'].Value;
    project_showDetailOption(ideal_id);
}
/**
 * 获取委托编号
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
 * LTrim(string):去除左边的空格
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
 * RTrim(string):去除右边的空格
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
 * Trim(string):去除字符串两边的空格
 * @param {Object} str
 */ 
function Trim(str){
    return RTrim(LTrim(str));   
}
/** 
* 判断是否为数字，是则返回true,否则返回false 
*/ 
function f_check_number(){
    if(!(/^[-\+]?\d+(\.\d+)?$/.test($("investment").value))){
       alert("请输入数字！");
       $("investment").value="";
    }
}
/**
 * 查看流程监控
 */
function monitor_workflow(){
   show_workFlow_monitor(cc_form_instanceid);
}
/**
 * 返回操作
 */
function retAction(){
    history.go(-2);
}
/**
 * 改变下一环节时事件
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
 * 返回按钮事件
 */
function f_back(){
    history.go(-2);
}
/**
 * 转阅
 */
function f_transRead(){
    var proj_name=$("proj_name").value;//项目名称
    var plan_id=$("plan_id").value;//计划ID
    var url=getOpenUrlByDjid("20101128163940484950")+"&proj_name="+proj_name+"&plan_id="+plan_id+"&cc_formInstanceId="+cc_form_instanceid;//转阅
    var msg=window.showModalDialog(url,window,"dialogWidth=600px;dialogHeight=130px");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><label><id>label1</id><id>label2</id><id>label3</id><id>label38</id><id>label4</id><id>label5</id><id>label6</id><id>label7</id><id>label10</id><id>label11</id><id>label21</id><id>label12</id><id>label13</id><id>label14</id><id>label15</id><id>label16</id><id>label17</id><id>label37</id><id>label19</id><id>label20</id><id>label22</id><id>label23</id><id>label24</id><id>label25</id><id>label26</id><id>label27</id><id>label28</id><id>label36</id><id>label29</id><id>label30</id><id>label31</id><id>label32</id><id>label33</id><id>label34</id><id>label35</id></label><radio><id>agree</id></radio><textarea><id>dimensions</id><id>remark</id><id>ideal</id></textarea><combobox><id>entrust_type</id><id>entrust_status</id><id>entrust_way</id><id>ascription</id><id>province</id><id>belong_orgid</id><id>profession_property</id><id>proj_type</id><id>responsible_orgid</id><id>proj_level</id><id>proj_level3</id><id>charger_orgid</id><id>workflowControl_selectAct</id><id>combobox14</id><id>combobox15</id></combobox><tab><id>tab1</id></tab><div><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_recycle</id><id>workflowControl_back</id><id>div1</id><id>div12</id><id>workflowControl_selectAndUser</id><id>workflowControl_tempSaveForm</id><id>workflowControl_backToPrior</id><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>div7</id><id>div2</id><id>div3</id><id>div4</id><id>div5</id><id>div6</id><id>div8</id><id>div10</id><id>div11</id></div><a><id>anchor_up</id></a><button><id>back</id><id>button_qdlc</id><id>button_wchd</id><id>button_hs</id><id>button_ht</id><id>over</id><id>save</id><id>transRead</id><id>monitor</id><id>button6</id><id>btn_relate</id><id>button7</id><id>button4</id><id>planTypeBtn</id><id>planAddBtn</id><id>button5</id><id>button_yfzxzxr</id><id>button_zc</id><id>button_xzxr</id></button><text><id>entrust_no</id><id>client</id><id>entrust_way_no</id><id>entrust_explain</id><id>proj_name</id><id>design_id</id><id>custom_proj_name</id><id>custom_proj_id</id><id>used_phase</id><id>approval_date</id><id>undo_entrust_phase</id><id>add_entrust_phase</id><id>expect_date</id><id>investment</id><id>other_request</id><id>opposite_linkman</id><id>opposite_phone</id><id>opposite_org</id><id>our_linkman</id><id>our_phone</id><id>our_org</id><id>inputer</id><id>dept_name</id><id>inputer_date</id><id>design_phases</id><id>specialitys</id><id>m_dept</id><id>j_dept</id><id>task_confirmdate</id><id>receive_user</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>text77</id><id>text80</id><id>isHqMarketer</id><id>verdict</id><id>existZf</id><id>isOver</id><id>entrust_id</id><id>inputer_id</id><id>dept_id</id><id>task_id</id><id>entrust_oid</id><id>proj_id</id><id>belong_org</id><id>responsible_org</id><id>add_entrust_phaseid</id><id>undo_entrust_phaseid</id><id>used_phaseid</id><id>parent_id</id><id>plan_id</id><id>task_oid</id><id>design_phasesid</id><id>charger_org</id><id>specialitys_id</id><id>m_deptid</id><id>j_deptid</id><id>receive_userid</id><id>task_sponsor</id><id>task_sponsorid</id><id>apply_deptid</id><id>apply_dept</id><id>apply_userid</id><id>apply_user</id><id>status</id><id>nc</id></text><grid><id>grid1</id><id>grid2</id><id>grid3</id></grid><dataset><id>dataset1</id><id>dataset2</id><id>dataset3</id><id>dataset4</id><id>dataset5</id><id>dataset6</id><id>dataset7</id></dataset></root>" billtaborder="<root><taborder>planAddBtn</taborder><taborder>grid1</taborder><taborder>entrust_type</taborder><taborder>ascription</taborder><taborder>province</taborder><taborder>belong_orgid</taborder><taborder>profession_property</taborder><taborder>proj_type</taborder><taborder>entrust_no</taborder><taborder>client</taborder><taborder>entrust_explain</taborder><taborder>proj_name</taborder><taborder>design_id</taborder><taborder>custom_proj_name</taborder><taborder>custom_proj_id</taborder><taborder>expect_date</taborder><taborder>investment</taborder><taborder>other_request</taborder><taborder>opposite_linkman</taborder><taborder>opposite_phone</taborder><taborder>opposite_org</taborder><taborder>our_linkman</taborder><taborder>our_phone</taborder><taborder>our_org</taborder><taborder>inputer</taborder><taborder>dept_name</taborder><taborder>inputer_date</taborder><taborder>task_confirmdate</taborder><taborder>m_dept</taborder><taborder>j_dept</taborder><taborder>receive_user</taborder><taborder>specialitys</taborder><taborder>agree</taborder><taborder>ideal</taborder><taborder>grid2</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>add_entrust_phase</taborder><taborder>design_phases</taborder><taborder>proj_level3</taborder><taborder>charger_orgid</taborder><taborder>button6</taborder><taborder>remark</taborder><taborder>proj_level</taborder><taborder>used_phase</taborder><taborder>approval_date</taborder><taborder>button7</taborder><taborder>btn_relate</taborder><taborder>undo_entrust_phase</taborder><taborder>save</taborder><taborder>entrust_way_no</taborder><taborder>isHqMarketer</taborder><taborder>verdict</taborder><taborder>existZf</taborder><taborder>entrust_id</taborder><taborder>inputer_id</taborder><taborder>dept_id</taborder><taborder>responsible_orgid</taborder><taborder>task_id</taborder><taborder>entrust_oid</taborder><taborder>proj_id</taborder><taborder>belong_org</taborder><taborder>responsible_org</taborder><taborder>add_entrust_phaseid</taborder><taborder>undo_entrust_phaseid</taborder><taborder>used_phaseid</taborder><taborder>plan_id</taborder><taborder>task_sponsor</taborder><taborder>task_oid</taborder><taborder>design_phasesid</taborder><taborder>charger_org</taborder><taborder>specialitys_id</taborder><taborder>m_deptid</taborder><taborder>j_deptid</taborder><taborder>receive_userid</taborder><taborder>task_sponsorid</taborder><taborder>apply_deptid</taborder><taborder>apply_dept</taborder><taborder>apply_userid</taborder><taborder>apply_user</taborder><taborder>status</taborder><taborder>entrust_status</taborder><taborder>entrust_way</taborder><taborder>planTypeBtn</taborder><taborder>nc</taborder><taborder>workflowControl_selectAct</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zc</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder><taborder>combobox14</taborder><taborder>combobox15</taborder><taborder>text77</taborder><taborder>text80</taborder><taborder>grid3</taborder><taborder>monitor</taborder><taborder>dimensions</taborder><taborder>parent_id</taborder><taborder>isOver</taborder><taborder>over</taborder><taborder>back</taborder><taborder>transRead</taborder></root>" dj_sn="20100917171201843030" caption="委托登记" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:38;radio:1;listbox:2;textarea:3;combobox:15;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:12;DsMain_field:0;a:0;button:14;text:82;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:3;dataset:8;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="4" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination="grid1,dataset4,5;grid2,dataset5,10;grid3,dataset7,10;" type="ZW" creatorType="20100518201032906877" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;/userjs/project/project_div_win.js&#13;&#10;/userjs/project/project_new_upload.js&#13;&#10;/userjs/project/approval_ideal.js&#13;&#10;/userjs/project/div_tree.js&#13;&#10;/userjs/project/entrust_startwf.js&#13;&#10;/userjs/project/project_pub.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid>grid1</gridid><iframeid></iframeid><index>1</index><gridid>grid2</gridid><iframeid></iframeid><index>2</index><gridid>grid3</gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE class=tit style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD width="35%"><A id=anchor_up style="POSITION: absolute" href="#haha" target=_self controltype="a" NotBg="否" href1="#haha"></A><A name=haha></A><H1>当前环节：<FONT id=actName>环节名称</FONT></H1></TD>
         <TD align=right><DIV id=workflowControl2 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 74.1%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="workflowControl" NotBg="是"><BUTTON class=button_top id=back style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_back()")'>返回</BUTTON><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_qdlc style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_startAct()")'>提交</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_wchd style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_completeAct()")'>提交</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_hs style="LEFT: 0px; WIDTH: 64px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)">收回</BUTTON></DIV><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 54px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_ht style="LEFT: 0px; WIDTH: 53px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('回退',false,true,'../../../common_workflow/main.jsp')&quot;)">回退</BUTTON></DIV><BUTTON class=button_top id=over style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("over_workflow()")'>流程终止</BUTTON><BUTTON class=button_top id=save style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_save()")'>保存</BUTTON><BUTTON class=button_top id=transRead style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_transRead()")'>转阅</BUTTON><BUTTON class=button_top id=monitor style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("monitor_workflow()")'>流程监控</BUTTON></DIV></TD>
      </TR>
      <TR>
         <TD colSpan=3><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 1200px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab1 style="LEFT: 8px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 1100px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px"><H2 class=tab>基本信息</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR id=gkxq1>
                              <TD><LI>顾客需求信息</LI></TD>
                           </TR>
                           <TR id=gkxq2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR id=wt1>
                                          <TH width="10%" rowSpan=4>委托信息</TH>
                                          <TH width="10%">委托编号</TH>
                                          <TD width="20%"><INPUT id=entrust_no style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="entrust_no" china="客户委托编号" dataset="dataset1"></TD>
                                          <TH width="10%">委托类型
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD width="20%"><SELECT id=entrust_type style="LEFT: 0px; WIDTH: 163px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpzXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="entrust_type" china="委托类型" dataset="dataset2" tempvalue temptext sql check="2" backwidth="163" backheight="25"></SELECT></TD>
                                          <TH width="10%">委托状态</TH>
                                          <TD width="20%"><SELECT id=entrust_status style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7Crtp%80Xr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="entrust_status" china="委托状态" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=wt2>
                                          <TH>委托单位
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD colSpan=5><INPUT id=client style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="client" china="委托单位" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=wt3>
                                          <TH>委托方式
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=entrust_way style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("f_changeWay(true)")' sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtrpXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="entrust_way" china="委托方式" dataset="dataset1" tempvalue temptext sql check="2" backwidth="150" backheight="25"></SELECT></TD>
                                          <TH id=way_no1>编号
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=way_no2><INPUT id=entrust_way_no style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_way_no" china="委托方式编号" dataset="dataset1"></TD>
                                          <TH id=way_explain1>说明
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=way_explain2><INPUT id=entrust_explain style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_explain" china="委托方式说明" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=wt4>
                                          <TH>附件</TH>
                                          <TD id=upload_td colSpan=4></TD>
                                          <TD id=upload_btn><BUTTON class=button_nor id=button6 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_upload()")'>上传</BUTTON></TD>
                                       </TR>
                                       <TR id=xm1 style="DISPLAY: none">
                                          <TH id=xmxx width="10%" rowSpan=5>项目信息</TH>
                                          <TH id=proj_label1>工程名称
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_label2 colSpan=3><INPUT id=proj_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="proj_name" china="项目名称" dataset="dataset2"></TD>
                                          <TH id=proj_label3>设计编号
                                             <FONT id=star color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_label4><INPUT id=design_id style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 66.07%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="design_id" china="设计编号" dataset="dataset2"><BUTTON class=button_nor id=btn_relate style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_relate()")'>关联</BUTTON></TD>
                                       </TR>
                                       <TR id=xm2 style="DISPLAY: none">
                                          <TH>客户项目名称</TH>
                                          <TD colSpan=3><INPUT id=custom_proj_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_name" china="客户项目名称" dataset="dataset2"></TD>
                                          <TH>客户项目编号</TH>
                                          <TD><INPUT id=custom_proj_id style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_id" china="客户项目编号" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=xm3 style="DISPLAY: none">
                                          <TH>项目归属
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=ascription style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtptXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="ascription" china="项目归属" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>省市
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=province style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpxXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="province" china="省市" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>归属机构
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=belong_orgid style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="belong_orgid" china="归属机构ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=xm4 style="DISPLAY: none">
                                          <TH>专业属性
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=profession_property style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7Crtr%7CXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="profession_property" china="专业属性" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH>工程类型
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=proj_type_label><SELECT id=proj_type style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%D6%E0%D4%F6%D6%D0%F6%D0Xrn%F6Xrn%FC%DE%D8%F2%D8Xrn%F6j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96Xr%7CrtpvXr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%F6j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2Xrn%D0%F4%D4" controltype="combobox" field="proj_type" china="工程类型" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                          <TH id=responsible_org1>负责机构
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=responsible_org2><SELECT id=responsible_orgid style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="responsible_orgid" china="负责机构ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR id=xm5 style="DISPLAY: none">
                                          <TH>管理级别
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><SELECT id=proj_level style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="管理级别" dataset="dataset2" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" sql check="1" backwidth="100" backheight="25"><OPTION value=0 selected>院管</OPTION><OPTION value=1>处管</OPTION></SELECT></TD>
                                          <TH>已立项阶段
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=used_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="used_phase" china="已立项阶段名称" dataset="dataset2"></TD>
                                          <TH>立项日期
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=approval_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="approval_date" china="立项日期" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=cx style="DISPLAY: none">
                                          <TH colSpan=2>中止设计阶段
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=cx1 colSpan=4><INPUT id=undo_entrust_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="undo_entrust_phase" china="中止委托阶段" dataset="dataset2"></TD>
                                          <TD id=cx2><BUTTON class=button_nor id=button7 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_pickUndoPhase()")'>选择</BUTTON></TD>
                                       </TR>
                                       <TR id=rw1 style="DISPLAY: none">
                                          <TH id=rwxx_label width="10%" rowSpan=4>任务信息</TH>
                                          <TH id=rw_phase_label>委托阶段
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=wtjd1><INPUT id=add_entrust_phase style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="add_entrust_phase" china="新增委托阶段" dataset="dataset2"></TD>
                                          <TD id=wtjd2><BUTTON class=button_nor id=button4 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_pickNewPhase()")'>选择</BUTTON></TD>
                                          <TH>要求在
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=expect_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() controltype="text" field="expect_date" china="要求完成日期" dataset="dataset2" onclick='bill_onclick("SelectDate()")'></TD>
                                          <TD>前完成</TD>
                                       </TR>
                                       <TR id=rw2 style="DISPLAY: none">
                                          <TH>设计规模
                                             <FONT color=red>*</FONT>
                                             <BR>
                                             (少于1000字)
                                          </TH>
                                          <TD colSpan=5><TEXTAREA id=dimensions style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 52px" onmovestart=moveStart() rows=1 controltype="textarea" field="dimensions" china="设计规模" dataset="dataset2" value="textarea3" induce="否"></TEXTAREA></TD>
                                       </TR>
                                       <TR id=rw3 style="DISPLAY: none">
                                          <TH>工程总投资
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=investment style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() controltype="text" field="investment" china="工程总投资" dataset="dataset2" onblur='bill_onexit("f_check_number()")'></TD>
                                          <TD colSpan=4>万元。质量满足现行国家有关规范，标准的要求。</TD>
                                       </TR>
                                       <TR id=rw4 style="DISPLAY: none">
                                          <TH>其他要求
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD colSpan=5><INPUT id=other_request style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="other_request" china="其他要求" dataset="dataset2"></TD>
                                       </TR>
                                       <TR id=qt1 style="DISPLAY: none">
                                          <TH width="10%" rowSpan=4>其他信息</TH>
                                          <TH>对方接口人
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_linkman style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_linkman" china="对方接口人" dataset="dataset1"></TD>
                                          <TH>对方接口人电话
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_phone style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_phone" china="对方接口人电话" dataset="dataset1"></TD>
                                          <TH>对方接口单位
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=opposite_org style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="opposite_org" china="对方接口单位" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=qt2 style="DISPLAY: none">
                                          <TH>我方接口人
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_linkman style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_linkman" china="我方接口人" dataset="dataset1"></TD>
                                          <TH>我方接口人电话
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_phone style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_phone" china="我方接口人电话" dataset="dataset1"></TD>
                                          <TH>我方接口单位
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD><INPUT id=our_org style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="our_org" china="我方接口单位" dataset="dataset1"></TD>
                                       </TR>
                                       <TR id=qt3 style="DISPLAY: none">
                                          <TH>备注</TH>
                                          <TD colSpan=5><TEXTAREA id=remark style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() rows=1 controltype="textarea" field="remark" china="备注" dataset="dataset1" value="textarea2" induce="否"></TEXTAREA></TD>
                                       </TR>
                                       <TR id=qt4 style="DISPLAY: none">
                                          <TH>填表人</TH>
                                          <TD><INPUT id=inputer style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="inputer" china="填表人" dataset="dataset1"></TD>
                                          <TH>所在部门</TH>
                                          <TD><INPUT id=dept_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="dept_name" china="所在部门" dataset="dataset1"></TD>
                                          <TH>填表日期</TH>
                                          <TD><INPUT id=inputer_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="inputer_date" china="填表时间" dataset="dataset1"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=xmjy1 style="DISPLAY: none">
                              <TD><LI><SPAN><BUTTON class=button_nor id=planTypeBtn style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_selPlanType()")'>安排方式选择</BUTTON><BUTTON class=button_nor id=planAddBtn style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_newOfferSp()")'>增加专业安排</BUTTON></SPAN>项目安排申请单<FONT color=red><B id=nc_describe></B></FONT></LI></TD>
                           </TR>
                           <TR id=xmjy2 style="DISPLAY: none">
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">设计阶段
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=plan_phases1 width="35%"><INPUT id=design_phases style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="design_phases" china="项目阶段名称" dataset="dataset3"></TD>
                                          <TD id=plan_phases2 align=middle width="5%"><BUTTON class=button_nor id=button5 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("f_pickPlanPhase()")'>选择</BUTTON></TD>
                                          <TH width="10%">管理级别
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=gljb width="15%"><SELECT id=proj_level3 style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="管理级别" dataset="dataset3" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" sql check="1" backwidth="100" backheight="25"><OPTION value=0 selected>院管</OPTION><OPTION value=1>处管</OPTION></SELECT></TD>
                                          <TH id=fzjg1 width="10%">负责机构
                                             <FONT color=red>*</FONT>
                                          </TH>
                                          <TD id=fzjg2 width="15%"><SELECT id=charger_orgid style="LEFT: 0px; WIDTH: 100px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%ECj%EC%F2%DC%CC%F4%EAXrn%D0%F4%D4" controltype="combobox" field="responsible_orgid" china="负责机构ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="100" backheight="25"></SELECT></TD>
                                       </TR>
                                       <TR>
                                          <TH>项目包含的专业</TH>
                                          <TD colSpan=6><INPUT id=specialitys style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="specialitys" china="专业名称" dataset="dataset3"></TD>
                                       </TR>
                                       <TR>
                                          <TD colSpan=7><?xml:namespace prefix = fc /><fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' top="0" width="100%" height="129" format="<cols><col><fname>org_name</fname><cname>参加机构</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>speciality_name</fname><cname>专业名称</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>参与部门</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>is_main</fname><cname>主体处</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>a</fname><cname>修改专业</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>b</fname><cname>指定部门</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>c</fname><cname>删除</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col></cols>" dataset="dataset4" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
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
                                          <TD colSpan=7><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid1"><SPAN id=pageInfogrid1></SPAN><A id=firstpagegrid1 onclick="buttonevent('grid1','firstpage')" href="javascript:void(0)">首页</A><A id=prevpagegrid1 onclick="buttonevent('grid1','prevpage')" href="javascript:void(0)">上一页</A><A id=nextpagegrid1 onclick="buttonevent('grid1','nextpage')" href="javascript:void(0)">下一页</A><A id=lastpagegrid1 onclick="buttonevent('grid1','lastpage')" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=rwxd1 style="DISPLAY: none">
                              <TD><LI>任务下达信息</LI></TD>
                           </TR>
                           <TR id=rwxd2 style="DISPLAY: none">
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">主办部门</TH>
                                          <TD width="20%"><INPUT id=m_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="m_dept" china="主办部门名称" dataset="dataset3"></TD>
                                          <TH width="10%">协办部门</TH>
                                          <TD width="50%"><INPUT id=j_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="j_dept" china="协办部门名称" dataset="dataset3"></TD>
                                       </TR>
                                       <TR>
                                          <TH>任务确定时间</TH>
                                          <TD><INPUT id=task_confirmdate style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="task_confirmdate" china="任务确定时间" dataset="dataset3"></TD>
                                          <TH>任务接收人员</TH>
                                          <TD><INPUT id=receive_user style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="receive_user" china="任务接收人" dataset="dataset3"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px">
                     <H2 class=tab>审批信息</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR id=next>
                              <TD><H1>下一环节：<FONT id=nextAction>下一环节名称</FONT></H1></TD>
                           </TR>
                           <TR id=txyj1 style="DISPLAY: none">
                              <TD><LI>请填写审批意见</LI><DIV id=div12 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 849px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 517px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 343px; HEIGHT: 74px" onmovestart=moveStart() controltype="div" NotBg="是"><DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 380px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：<INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button_nor id=button_yfzxzxr style="LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addAndUser();")'>与分支选执行人</BUTTON></DIV><DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)">暂存</BUTTON></DIV><DIV id=workflowControl_backToPrior style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; DISPLAY: none; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 84px; BORDER-BOTTOM: black 1px solid; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV></DIV></TD>
                           </TR>
                           <TR id=txyj2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR id=shxx>
                                          <TD colSpan=2><DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 253px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">下一环节选择：<SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 167px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("f_changeSelectActor()")' sqltrans controltype="combobox" tempvalue temptext sql check="1" backwidth="167" backheight="25"></SELECT></DIV><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 237px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><FONT id=nextUserlabel>执行人选择：</FONT><INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 74px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=11 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button_nor id=button_xzxr style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("adduser();")'>选择</BUTTON></DIV></TD>
                                       </TR>
                                       <TR id=shjl>
                                          <TH width="10%">审批结论</TH>
                                          <TD><FIELDSET id=agree contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 152px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 18px" onmovestart=moveStart() controltype="radio" tempvalue="同意&#13;&#10;不同意" temptext="同意&#13;&#10;不同意" aspect="横向" legend NotBg="否" value="同意" onclick='bill_onclick("f_changeAgree()")'><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=同意 name=RGagree text="同意"><SPAN onclick=RGagree[0].checked=true;agree.value=RGagree[0].value;RGagree[0].focus();>同意</SPAN>&nbsp;<INPUT type=radio value=不同意 name=RGagree text="不同意"><SPAN onclick=RGagree[1].checked=true;agree.value=RGagree[1].value;RGagree[1].focus();>不同意</SPAN>&nbsp;</FIELDSET></TD>
                                       </TR>
                                       <TR id=shyj>
                                          <TH width="10%">审批意见</TH>
                                          <TD><TEXTAREA id=ideal style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=yyyj1>
                              <TD><LI>已有审批意见列表</LI></TD>
                           </TR>
                           <TR id=yyyj2>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TD><fc:webgrid id=grid2 onkeydown='bill_ongridkeydown("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' ondblclick='bill_ongriddblclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' onclick='bill_ongridclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' top="0" width="100%" height="238" format="<cols><col><fname>ideal_peoplename</fname><cname>审批人</cname><width>40</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>ideal_departname</fname><cname>部门</cname><width>40</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>action_name</fname><cname>审批环节</cname><width>40</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>ideal_result</fname><cname>审批结果</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>ideal_conten</fname><cname>审批内容</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>25%</columnwidth><align>left</align></col><col><fname>ideal_date</fname><cname>审批日期</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>center</align></col><col><fname>a</fname><cname>查看</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>5%</columnwidth><align>center</align></col></cols>" dataset="dataset5" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
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
                                          <TD><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid2"><SPAN id=pageInfogrid2></SPAN><A id=firstpagegrid2 onclick="buttonevent('grid2','firstpage')" href="javascript:void(0)">首页</A><A id=prevpagegrid2 onclick="buttonevent('grid2','prevpage')" href="javascript:void(0)">上一页</A><A id=nextpagegrid2 onclick="buttonevent('grid2','nextpage')" href="javascript:void(0)">下一页</A><A id=lastpagegrid2 onclick="buttonevent('grid2','lastpage')" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 1082px">
                     <H2 class=tab>安排建议单</H2>
                     <TABLE class=shade style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR>
                              <TD><LI>项目安排建议单</LI></TD>
                           </TR>
                           <TR>
                              <TD class=padding>
                                 <TABLE class=shadeTab cellSpacing=0 cellPadding=0 width="100%" border=0>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">建议设计阶段</TH>
                                          <TD width="30%"><INPUT id=text77 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="design_phases" china="项目阶段名称" dataset="dataset6"></TD>
                                          <TH width="10%">项目管理级别</TH>
                                          <TD width="20%"><SELECT id=combobox14 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="管理级别" dataset="dataset6" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" sql check="1" backwidth="120" backheight="25"><OPTION value=0 selected>院管</OPTION><OPTION value=1>处管</OPTION></SELECT></TD>
                                          <TH width="10%">负责机构</TH>
                                          <TD width="20%"><SELECT id=combobox15 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%ECj%EC%F2%DC%CC%E0%D6Xr%94Xrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXrn%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="responsible_orgid" china="负责机构ID" dataset="dataset2" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                          <TR>
                                             <TH>项目包含的专业</TH>
                                             <TD colSpan=5><INPUT id=text80 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="specialitys" china="专业名称" dataset="dataset6"></TD>
                                          </TR>
                                          <TR>
                                             <TD colSpan=6><fc:webgrid id=grid3 onkeydown='bill_ongridkeydown("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' ondblclick='bill_ongriddblclick("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' onclick='bill_ongridclick("<grid3><col></col><col></col><col></col><col></col><col></col></grid3>")' top="0" width="100%" height="213" format="<cols><col><fname>org_name</fname><cname>参加机构名称</cname><width>500</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>speciality_name</fname><cname>专业名称</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>部门名称</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>is_main</fname><cname>是否主体部门</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>12%</columnwidth><align>center</align></col><col><fname>memo</fname><cname>安排说明</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>28%</columnwidth><align>left</align></col></cols>" dataset="dataset7" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
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
                                             <TD colSpan=6><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid3"><SPAN id=pageInfogrid3></SPAN><A id=firstpagegrid3 onclick="buttonevent('grid3','firstpage')" href="javascript:void(0)">首页</A><A id=prevpagegrid3 onclick="buttonevent('grid3','prevpage')" href="javascript:void(0)">上一页</A><A id=nextpagegrid3 onclick="buttonevent('grid3','nextpage')" href="javascript:void(0)">下一页</A><A id=lastpagegrid3 onclick="buttonevent('grid3','lastpage')" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
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

<DIV id=div7 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; DISPLAY: none; LEFT: 1287px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 80px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 77px; HEIGHT: 310px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
   <DIV id=div2 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 7px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 149px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 4px; HEIGHT: 192px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <DIV id=label1 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label1">是否总部市场人员:0是,1否</DIV>
      <INPUT id=isHqMarketer style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label2 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label2">审批结论:0同意,1不同意</DIV>
      <INPUT id=verdict style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label3 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label3">是否郑分参与:0是,1否</DIV>
      <INPUT id=existZf style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
      <DIV id=label38 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label38">是否终止流程</DIV>
      <INPUT id=isOver style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() value=1 controltype="text">
   </DIV>
   <DIV id=div3 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 13px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 148px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 204px; HEIGHT: 151px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset1 format="<fields><field><fieldname>entrust_id</fieldname><datatype>字符</datatype><displaylabel>客户委托ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_no</fieldname><datatype>字符</datatype><displaylabel>客户委托编号</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer_id</fieldname><datatype>字符</datatype><displaylabel>填表人ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer</fieldname><datatype>字符</datatype><displaylabel>填表人</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer_date</fieldname><datatype>字符</datatype><displaylabel>填表时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>字符</datatype><displaylabel>所在部门ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>所在部门</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>client</fieldname><datatype>字符</datatype><displaylabel>委托单位</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_subject</fieldname><datatype>字符</datatype><displaylabel>委托主题</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_way</fieldname><datatype>字符</datatype><displaylabel>委托方式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_explain</fieldname><datatype>字符</datatype><displaylabel>委托方式说明</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_way_no</fieldname><datatype>字符</datatype><displaylabel>委托方式编号</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_linkman</fieldname><datatype>字符</datatype><displaylabel>对方接口人</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_phone</fieldname><datatype>字符</datatype><displaylabel>对方接口人电话</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>opposite_org</fieldname><datatype>字符</datatype><displaylabel>对方接口单位</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_linkman</fieldname><datatype>字符</datatype><displaylabel>我方接口人</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_phone</fieldname><datatype>字符</datatype><displaylabel>我方接口人电话</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>our_org</fieldname><datatype>字符</datatype><displaylabel>我方接口单位</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>remark</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' onGetText='bill_ondatasetgettext("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' onValid='bill_ondatasetvalid("<dsid><entrust_id></entrust_id><entrust_no></entrust_no><inputer_id></inputer_id><inputer></inputer><inputer_date></inputer_date><dept_id></dept_id><dept_name></dept_name><client></client><entrust_subject></entrust_subject><entrust_way></entrust_way><entrust_explain></entrust_explain><entrust_way_no></entrust_way_no><opposite_linkman></opposite_linkman><opposite_phone></opposite_phone><opposite_org></opposite_org><our_linkman></our_linkman><our_phone></our_phone><our_org></our_org><remark></remark></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
      <DIV id=label4 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label4">表：客户委托信息</DIV>
      <DIV id=label5 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label5">客户委托ID</DIV>
      <INPUT id=entrust_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_id" china="客户委托ID" dataset="dataset1">
      <DIV id=label6 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label6">填表人ID</DIV>
      <INPUT id=inputer_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="inputer_id" china="填表人ID" dataset="dataset1">
      <DIV id=label7 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label7">所在部门ID</DIV>
      <INPUT id=dept_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="dept_id" china="所在部门ID" dataset="dataset1">
      &nbsp;
   </DIV>
   <DIV id=div4 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 13px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 148px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 358px; HEIGHT: 393px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset2 format="<fields><field><fieldname>task_id</fieldname><datatype>字符</datatype><displaylabel>客户委托任务主键ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_oid</fieldname><datatype>字符</datatype><displaylabel>客户委托ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_type</fieldname><datatype>字符</datatype><displaylabel>委托类型</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_id</fieldname><datatype>字符</datatype><displaylabel>工程ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_name</fieldname><datatype>字符</datatype><displaylabel>项目名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_id</fieldname><datatype>字符</datatype><displaylabel>设计编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_id</fieldname><datatype>字符</datatype><displaylabel>客户项目编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_name</fieldname><datatype>字符</datatype><displaylabel>客户项目名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ascription</fieldname><datatype>字符</datatype><displaylabel>项目归属</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>province</fieldname><datatype>字符</datatype><displaylabel>省市</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_orgid</fieldname><datatype>字符</datatype><displaylabel>归属机构ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_org</fieldname><datatype>字符</datatype><displaylabel>归属机构</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>profession_property</fieldname><datatype>字符</datatype><displaylabel>专业属性</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_type</fieldname><datatype>字符</datatype><displaylabel>工程类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_orgid</fieldname><datatype>字符</datatype><displaylabel>负责机构ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_org</fieldname><datatype>字符</datatype><displaylabel>负责机构</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phaseid</fieldname><datatype>字符</datatype><displaylabel>新增委托阶段ID</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phase</fieldname><datatype>字符</datatype><displaylabel>新增委托阶段</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phaseid</fieldname><datatype>字符</datatype><displaylabel>中止委托阶段ID</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phase</fieldname><datatype>字符</datatype><displaylabel>中止委托阶段</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dimensions</fieldname><datatype>字符</datatype><displaylabel>设计规模</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>investment</fieldname><datatype>字符</datatype><displaylabel>工程总投资</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>expect_date</fieldname><datatype>字符</datatype><displaylabel>要求完成日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_request</fieldname><datatype>字符</datatype><displaylabel>其他要求</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>used_phaseid</fieldname><datatype>字符</datatype><displaylabel>已立项阶段ID</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>used_phase</fieldname><datatype>字符</datatype><displaylabel>已立项阶段名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>approval_date</fieldname><datatype>字符</datatype><displaylabel>立项日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_status</fieldname><datatype>字符</datatype><displaylabel>委托状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>parent_id</fieldname><datatype>字符</datatype><displaylabel>父TaskId</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' onGetText='bill_ondatasetgettext("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' onValid='bill_ondatasetvalid("<dsid><task_id></task_id><entrust_oid></entrust_oid><entrust_type></entrust_type><proj_id></proj_id><proj_name></proj_name><design_id></design_id><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><ascription></ascription><province></province><belong_orgid></belong_orgid><belong_org></belong_org><profession_property></profession_property><proj_type></proj_type><responsible_orgid></responsible_orgid><responsible_org></responsible_org><proj_level></proj_level><add_entrust_phaseid></add_entrust_phaseid><add_entrust_phase></add_entrust_phase><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><dimensions></dimensions><investment></investment><expect_date></expect_date><other_request></other_request><used_phaseid></used_phaseid><used_phase></used_phase><approval_date></approval_date><entrust_status></entrust_status><parent_id></parent_id></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
      <DIV id=label10 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label10">表：客户委托任务</DIV>
      <DIV id=label11 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label11">客户委托任务主键ID</DIV>
      <INPUT id=task_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_id" china="客户委托任务主键ID" dataset="dataset2">
      <DIV id=label21 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label21">客户委托关联ID</DIV>
      <INPUT id=entrust_oid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="entrust_oid" china="客户委托ID" dataset="dataset2">
      <DIV id=label12 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label12">工程ID</DIV>
      <INPUT id=proj_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="proj_id" china="工程ID" dataset="dataset2">
      <DIV id=label13 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label13">归属机构</DIV>
      <INPUT id=belong_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="belong_org" china="归属机构" dataset="dataset2">
      <DIV id=label14 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label14">负责机构</DIV>
      <INPUT id=responsible_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="responsible_org" china="负责机构" dataset="dataset2">
      <DIV id=label15 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label15">新增委托阶段ID</DIV>
      <INPUT id=add_entrust_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="add_entrust_phaseid" china="新增委托阶段ID" dataset="dataset2">
      <DIV id=label16 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label16">中止委托阶段ID</DIV>
      <INPUT id=undo_entrust_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="undo_entrust_phaseid" china="中止委托阶段ID" dataset="dataset2">
      <DIV id=label17 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label17">已立项阶段ID</DIV>
      <INPUT id=used_phaseid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="used_phaseid" china="已立项阶段ID" dataset="dataset2">
      <DIV id=label37 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label37">父TaskId</DIV>
      <INPUT id=parent_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="parent_id" china="父TaskId" dataset="dataset2">
   </DIV>
   <DIV id=div5 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 164px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 149px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 11px; HEIGHT: 738px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset3 format="<fields><field><fieldname>plan_id</fieldname><datatype>字符</datatype><displaylabel>任务安排下达主键ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_oid</fieldname><datatype>字符</datatype><displaylabel>任务关联ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasesid</fieldname><datatype>字符</datatype><displaylabel>项目阶段ID</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phases</fieldname><datatype>字符</datatype><displaylabel>项目阶段名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>charger_orgid</fieldname><datatype>字符</datatype><displaylabel>负责机构ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>charger_org</fieldname><datatype>字符</datatype><displaylabel>负责机构</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys_id</fieldname><datatype>字符</datatype><displaylabel>专业名称ID</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys</fieldname><datatype>字符</datatype><displaylabel>专业名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_confirmdate</fieldname><datatype>字符</datatype><displaylabel>任务确定时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_expectdate</fieldname><datatype>字符</datatype><displaylabel>任务要求完成时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>m_deptid</fieldname><datatype>字符</datatype><displaylabel>主办部门ID</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>m_dept</fieldname><datatype>字符</datatype><displaylabel>主办部门名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>j_deptid</fieldname><datatype>字符</datatype><displaylabel>协办部门ID</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>j_dept</fieldname><datatype>字符</datatype><displaylabel>协办部门名称</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>receive_userid</fieldname><datatype>字符</datatype><displaylabel>任务接收人ID</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>receive_user</fieldname><datatype>字符</datatype><displaylabel>任务接收人</displaylabel><size>2400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_sponsorid</fieldname><datatype>字符</datatype><displaylabel>生产任务主办人ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_sponsor</fieldname><datatype>字符</datatype><displaylabel>生产任务主办人</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_deptid</fieldname><datatype>字符</datatype><displaylabel>申请部门ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_dept</fieldname><datatype>字符</datatype><displaylabel>申请部门名称</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_userid</fieldname><datatype>字符</datatype><displaylabel>申请人ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>apply_user</fieldname><datatype>字符</datatype><displaylabel>申请人姓名</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>status</fieldname><datatype>字符</datatype><displaylabel>当前审批状态</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>nc</fieldname><datatype>字符</datatype><displaylabel>安排一致描述</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' onGetText='bill_ondatasetgettext("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' onValid='bill_ondatasetvalid("<dsid><plan_id></plan_id><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><charger_orgid></charger_orgid><charger_org></charger_org><specialitys_id></specialitys_id><specialitys></specialitys><task_confirmdate></task_confirmdate><task_expectdate></task_expectdate><m_deptid></m_deptid><m_dept></m_dept><j_deptid></j_deptid><j_dept></j_dept><receive_userid></receive_userid><receive_user></receive_user><task_sponsorid></task_sponsorid><task_sponsor></task_sponsor><apply_deptid></apply_deptid><apply_dept></apply_dept><apply_userid></apply_userid><apply_user></apply_user><status></status><nc></nc></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="是"></fc:dataset>
      <DIV id=label19 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label19">表：任务安排下达</DIV>
      <DIV id=label20 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label20">任务安排下达主键ID</DIV>
      <INPUT id=plan_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="plan_id" china="任务安排下达主键ID" dataset="dataset3">
      <DIV id=label22 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label22">任务关联ID</DIV>
      <INPUT id=task_oid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_oid" china="任务关联ID" dataset="dataset3">
      <DIV id=label23 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label23">项目阶段ID</DIV>
      <INPUT id=design_phasesid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="design_phasesid" china="项目阶段ID" dataset="dataset3">
      <DIV id=label24 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label24">负责机构</DIV>
      <INPUT id=charger_org style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="charger_org" china="负责机构" dataset="dataset3">
      <DIV id=label25 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label25">专业名称ID</DIV>
      <INPUT id=specialitys_id style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="specialitys_id" china="专业名称ID" dataset="dataset3">
      <DIV id=label26 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label26">主办部门ID</DIV>
      <INPUT id=m_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="m_deptid" china="主办部门ID" dataset="dataset3">
      <DIV id=label27 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label27">协办部门ID</DIV>
      <INPUT id=j_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="j_deptid" china="协办部门ID" dataset="dataset3">
      <DIV id=label28 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label28">任务接收人ID</DIV>
      <INPUT id=receive_userid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="receive_userid" china="任务接收人ID" dataset="dataset3">
      <DIV id=label36 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label36">生产任务主办人</DIV>
      <INPUT id=task_sponsor style="LEFT: 0px; WIDTH: 104px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=11 controltype="text" field="task_sponsor" china="生产任务主办人" dataset="dataset3">
      <DIV id=label29 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label29">生产任务主办人ID</DIV>
      <INPUT id=task_sponsorid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="task_sponsorid" china="生产任务主办人ID" dataset="dataset3">
      <DIV id=label30 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label30">申请部门ID</DIV>
      <INPUT id=apply_deptid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_deptid" china="申请部门ID" dataset="dataset3">
      <DIV id=label31 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label31">申请部门名称</DIV>
      <INPUT id=apply_dept style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_dept" china="申请部门名称" dataset="dataset3">
      <DIV id=label32 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label32">申请人ID</DIV>
      <INPUT id=apply_userid style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_userid" china="申请人ID" dataset="dataset3">
      <DIV id=label33 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label33">申请人姓名</DIV>
      <INPUT id=apply_user style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="apply_user" china="申请人姓名" dataset="dataset3">
      <DIV id=label34 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label34">当前审批状态</DIV>
      <INPUT id=status style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="status" china="当前审批状态" dataset="dataset3">
      <DIV id=label35 style="LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label35">安排一致描述</DIV>
      <INPUT id=nc style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="nc" china="安排一致描述" dataset="dataset3">
   </DIV>
   <DIV id=div6 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 14px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 70px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 760px; HEIGHT: 62px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset4 format="<fields><field><fieldname>detail_id</fieldname><datatype>字符</datatype><displaylabel>任务安排明细主键ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>plan_oid</fieldname><datatype>字符</datatype><displaylabel>任务安排下达ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_id</fieldname><datatype>字符</datatype><displaylabel>参加机构ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>字符</datatype><displaylabel>参加机构</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>speciality_id</fieldname><datatype>字符</datatype><displaylabel>专业ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>speciality_name</fieldname><datatype>字符</datatype><displaylabel>专业名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>字符</datatype><displaylabel>部门ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>参与部门</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>is_main</fieldname><datatype>字符</datatype><displaylabel>主体处</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>memo</fieldname><datatype>字符</datatype><displaylabel>安排说明</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>修改专业</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:f_updateSpeciality()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>b</fieldname><datatype>字符</datatype><displaylabel>指定部门</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:f_updateDept()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>c</fieldname><datatype>字符</datatype><displaylabel>删除</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:f_deleteSpeciality()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' onGetText='bill_ondatasetgettext("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' onValid='bill_ondatasetvalid("<dsid><detail_id></detail_id><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo><a></a><b></b><c></c></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset>
   </DIV>
   <DIV id=div8 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 92px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 64px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 761px; HEIGHT: 58px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset5 format="<fields><field><fieldname>ideal_id</fieldname><datatype>字符</datatype><displaylabel>主键Id</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ideal_peoplename</fieldname><datatype>字符</datatype><displaylabel>审批人</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_departname</fieldname><datatype>字符</datatype><displaylabel>部门</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>action_name</fieldname><datatype>字符</datatype><displaylabel>审批环节</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_result</fieldname><datatype>字符</datatype><displaylabel>审批结果</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_conten</fieldname><datatype>字符</datatype><displaylabel>审批内容</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>25%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_date</fieldname><datatype>字符</datatype><displaylabel>审批日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>查看</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:f_viewOpinion()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>5%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' onValid='bill_ondatasetvalid("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><a></a></dsid>")' opensortno="1" temptable="TMP_DATASET6" multiResult="是"></fc:dataset>
   </DIV>
   <DIV id=div10 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 169px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 64px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 759px; HEIGHT: 62px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset6 format="<fields><field><fieldname>oid</fieldname><datatype>字符</datatype><displaylabel>任务安排下达ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_oid</fieldname><datatype>字符</datatype><displaylabel>任务ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasesid</fieldname><datatype>字符</datatype><displaylabel>项目阶段ID</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phases</fieldname><datatype>字符</datatype><displaylabel>项目阶段名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys_id</fieldname><datatype>字符</datatype><displaylabel>专业名称ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>specialitys</fieldname><datatype>字符</datatype><displaylabel>专业名称</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><task_oid></task_oid><design_phasesid></design_phasesid><design_phases></design_phases><proj_level></proj_level><specialitys_id></specialitys_id><specialitys></specialitys></dsid>")' opensortno="1" temptable="TMP_DATASET7" multiResult="是"></fc:dataset>
   </DIV>
   <DIV id=div11 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 238px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 59px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 759px; HEIGHT: 61px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset7 format="<fields><field><fieldname>oid</fieldname><datatype>字符</datatype><displaylabel>任务安排明细主键ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>plan_oid</fieldname><datatype>字符</datatype><displaylabel>任务安排下达ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_id</fieldname><datatype>字符</datatype><displaylabel>参加机构ID</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>字符</datatype><displaylabel>参加机构名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>speciality_id</fieldname><datatype>字符</datatype><displaylabel>专业ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>speciality_name</fieldname><datatype>字符</datatype><displaylabel>专业名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>字符</datatype><displaylabel>部门ID</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>部门名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>is_main</fieldname><datatype>字符</datatype><displaylabel>是否主体部门</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>12%25</columnWidth2></columnWidth1></field><field><fieldname>memo</fieldname><datatype>字符</datatype><displaylabel>安排说明</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>28%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><plan_oid></plan_oid><org_id></org_id><org_name></org_name><speciality_id></speciality_id><speciality_name></speciality_name><dept_id></dept_id><dept_name></dept_name><is_main></is_main><memo></memo></dsid>")' opensortno="1" temptable="TMP_DATASET8" multiResult="是"></fc:dataset>
   </DIV>
</DIV>
</DIV>
<div id='grid_tip'></div></body></html>
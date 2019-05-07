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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/project_pub.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/project_pub.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/div_tree.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/div_tree.js'></script>");
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
var orgId=getSysElement("userorgid");                 //机构ID
var orgName=getSysElement("userOrgName");         //机构名字
var userId=getSysElement("userId");         
var userName=getSysElement("userName"); 
var flag="new";//判断数据新增还是修改
var cc_form_instanceid=creator_getQueryString("cc_form_instanceid");
var actName=creator_getQueryString("actDefName");
var m_oid=creator_getQueryString("plan_id");
var approval_id=""; //立项修改，查看审批意见用
var buess_id = creator_getQueryString("businessid")==null ? "":creator_getQueryString("businessid");
var oid = creator_getQueryString("oid"); //环节定义ID
var entrust_type="";//根据此字段来判断是新项目立项，还是阶段新增和修改

/*
*表单初始化
*/
function init(){
 $("actName").innerHTML=actName;
 if(!IsSpace(cc_form_instanceid)&&cc_form_instanceid=="clear"&&buess_id==""){
      hideOrShowTabByName("审批信息","hide");
      $("workflowControl_start").style.display="none";
      initDate();
 }else{ //立项修改环节
       if(buess_id!=""){//从我的参与立项列表过来
         cc_form_instanceid=buess_id;
       }
      if(oid!="undefined"){$("button_jslc").style.display="";}//当从列表进来不显示结束流程按钮
         approval_modify();
 }
}

/*
*数据展示
*/
function initDate(){
// 委托信息展示
var entrust_sql="select e.client, entrust_way, e.entrust_explain,t.add_entrust_phaseid,t.proj_id,t.design_id, t.undo_entrust_phaseid,t.undo_entrust_phase,to_char(sysdate,'yyyy-mm-dd') as input_date,"
            +" t.proj_name,t.custom_proj_name,t.custom_proj_id,t.ascription,t.belong_orgid,t.proj_type,t.province,t.belong_org,t.dimensions,t.investment, t.add_entrust_phase,"
            +"to_char(t.expect_date,'yyyy-mm-dd') as expect_date,t.entrust_type,t.other_request,t.profession_property,t.responsible_org,t.responsible_orgid from  ta_project_task_record t, ta_project_entrust_record e,ta_project_task_plan  m"
            +" where m.task_oid=t.oid and t.entrust_oid= e.entrust_id and m.oid='"+m_oid+"'";
  dataset_entrust.Open(entrust_sql);
  entrust_type=dataset_entrust.Fields.Field['entrust_type'].Value;
if(buess_id=="" && oid=="undefined"){
    $("input_date").value=dataset_entrust.Fields.Field['input_date'].Value;//新增数据时显示时间
    $("project_name").value=dataset_entrust.Fields.Field['proj_name'].Value;
    $("inputer").value=userName;
    $("orgName").value=orgName;   
    $("radio1").value="是";
    $("radio2").value="是";
    $("radio3").value="是";
    $("radio4").value="是";
   // $("ablity_explain").value="是";
    $("other").value="无";
    $("appraisal_measure").value="无"; //$("other_explain").value="无";
    $("appraisal_result").value="顾客要求能够满足,同意承接。";
}
 //设计阶段新增相关设置
 if(entrust_type=="phase_new"||entrust_type=="phase_update"){ 
  $("project_name").readOnly=true;
  $("design_id").value = dataset_entrust.Fields.Field['design_id'].Value;
  $("proj_id").value = dataset_entrust.Fields.Field['proj_id'].Value;
  $("phase_td1").style.display="";
  $("phase_td2").style.display="";
  initPhaseInfo(dataset_entrust.Fields.Field['proj_id'].Value);
  $("show_info").innerText="新增阶段";
 }
 //设计阶段修改时，显示终止的设计阶段
 if(entrust_type=="phase_update"){
   $("undo_phase").style.display="";
   $("undo_phase_name").innerText=dataset_entrust.Fields.Field['undo_entrust_phase'].Value;
 }
 //项目安排信息
 var taskt_sql=" select c.proj_level,c.design_phasesid,c.design_phases,"
                +" c.j_deptid  as joindept_id,c.j_dept as joindept_name,c.m_deptid as dept_id,c.m_dept as dept_name from ta_project_task_plan c"
                +"  where  c.oid='"+ m_oid +"'"; 
      dataset_taskt.Open(taskt_sql);  
      $("phasename").innerText=dataset_taskt.Fields.Field['design_phases'].Value;        
}

//立项修改和暂存列表进去函数
function approval_modify(){
$("workflowControl_back").style.display="none";
 approval_id = SqlToField("select t.approval_id from ta_project_approval t where t.cc_form_instanceid='" +cc_form_instanceid + "'");
 flag="edit";
var modify_sql=" select a.mc_oid,b.proj_id,b.proj_name,b.ascription,b.proj_type,b.province,b.belong_orgid,a.inputer,a.org_name,to_char(b.created_date,'yyyy-mm-dd') as input_date,"
              +"c.client_request, c.request_explain, c.agress,c.agress_explain,c.ablity,c.ablity_explain,c.other, c.other_request,c.other_explain,c.appraisal_measure,c.appraisal_result"
              +" from ta_project_approval a, ta_project_basic_info b, ta_project_appraisal c"
              +" where a.proj_id=b.proj_id and a.approval_id=c.link_id and a.approval_id = '"+ approval_id +"'";    
        modify_dataset.Open(modify_sql); 
        $("approval_id").value=approval_id;
        $("input_date").value = modify_dataset.Fields.Field['input_date'].Value;  
        $("proj_id").value=modify_dataset.Fields.Field['proj_id'].Value; 
        m_oid = modify_dataset.Fields.Field['mc_oid'].Value;     
        $("tr1").style.display="";       
        $("save").innerText="修改";
        //hideOrShowTabByName("审批信息","");
        //$("workflowControl_selectUser").style.display="";
        //$("div_select_user").style.display="";
        initDate(); 
        initItemList();
        initDutyPerson();
        if(buess_id=="" && oid !="undefined"){ $("viewlog").style.display=""; }
        $("combobox1").value= modify_dataset.Fields.Field['ascription'].Value;
        $("combobox2").value= modify_dataset.Fields.Field['proj_type'].Value;
        $("combobox3").value= modify_dataset.Fields.Field['province'].Value;
        $("combobox4").value= modify_dataset.Fields.Field['belong_orgid'].Value;
        initNextActAndUser(); 
}

//添加项目负责人
function addProUser(){
  var temp=fcpubdata.cc_form_instanceid;
   fcpubdata.cc_form_instanceid=""; 
  var url = "20100520091505125743.jsp?approval_id="+$("approval_id").value+"&m_oid="+m_oid;
  var swidth = 650;
  var sheight = 400;
  showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
 initDutyPerson();
 fcpubdata.cc_form_instanceid=temp;
}
//添加单项信息
function addSingleInfo(){
  var url = getOpenUrlByDjid("20100520112333156582")+"&approval_id="+$("approval_id").value+"&proj_id="+$("proj_id").value+"&m_taskId="+m_oid;
  var swidth = 850;
  var sheight = 600;
  showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
  initItemList();
}

var all_sql="";
/*
**保存信息，1、保存工程基本信息。2保存工程立项信息。3、保存顾客要求评审表。4、保存立项阶段信息
*/
function savaInfo(){
var project_name=trim($("project_name").value);
if(project_name==""||project_name.length==0){
  alert("工程名不能为空！");return false;
}
 if(IsSameProname()&&entrust_type=="project_new"){
    alert("工程名已经存在");return ; 
 }
 if($("appraisal_result").value.byteLength()>200){
  alert("评审结论超过100字");return ;
 }
var ascription= $("combobox1").value;//项目归属
var proj_type = $("combobox2").value;//工程类型
var province = $("combobox3").value;//所属区域
var belong_org = dataset_entrust.Fields.Field['belong_org'].Value;    //归属机构
var belong_orgid = dataset_entrust.Fields.Field['belong_orgid'].Value; //归属机构ID
var charge_orgid = dataset_entrust.Fields.Field['responsible_orgid'].Value;   //负责机构id
var charge_org = dataset_entrust.Fields.Field['responsible_org'].Value;   //负责机构
var custom_proj_name = dataset_entrust.Fields.Field['custom_proj_name'].Value; //客户项目名称
var custom_proj_id = dataset_entrust.Fields.Field['custom_proj_id'].Value;     //客户项目编号
var profession_property = dataset_entrust.Fields.Field['profession_property'].Value; //项目属性
var dimensions="";
var investment="";
var expect_date="";
var explain="";
if(flag=="new"){ //保存处理
 var proj_id=""; //工程ID
 var design_id="";//设计编号
if(entrust_type=="project_new"){
     proj_id=getNewCc_form_instanceid(false);
    $("proj_id").value=proj_id;
    var project_sql="insert into ta_project_basic_info(proj_id,proj_name,created_date,isvalid,ascription,proj_type,province,belong_org,belong_orgid,"
                  +" responsible_org,responsible_orgid,custom_proj_name,custom_proj_id,professional_property)" 
                  +" values('"+proj_id+"','"+project_name+"',sysdate,'0','"+ascription+"','"+proj_type+"','"+province+"','"+belong_org
                  +"','"+belong_orgid+"','"+charge_org+"','"+charge_orgid+"','"+custom_proj_name+"','"+custom_proj_id+"','"+ profession_property +"')";
    //alert(project_sql); 
    all_sql="<no> "+project_sql+" </no> ";
 }else{
   proj_id = $("proj_id").value;
   design_id = $("design_id").value;
 } 
var approval_id=getNewCc_form_instanceid(false);
$("approval_id").value=approval_id;
var consult_id=SqlToField("select p.task_oid from ta_project_task_plan p where p.oid='"+m_oid+"'");//任务安排
var proj_level=$("proj_level").value;//管理级别
var client = $("client").value;//委托单位
var entrust_way= $("entrust_way").value;//委托方式
var entrust_explain = $("entrust_explain").value;//委托说明
  dimensions = $("dimensions").value;//设计规模
  investment = $("investment").value;//总投资
  explain=$("other_request").value;
  expect_date=$("expect_date").value;
var entrust_phase= dataset_entrust.Fields.Field['add_entrust_phase'].Value;//委托阶段
var entrust_phaseid=dataset_entrust.Fields.Field['add_entrust_phaseid'].Value;//委托阶段ID
var approval_sql = " insert into  ta_project_approval t(t.approval_id,t.proj_id,t.mc_oid,"
               +" t.inputer_id,t.inputer,t.org_id, t.org_name,t.proj_level,t.task_id,"
               +" t.client,t.ascription,t.proj_type,t.province,t.entrust_way,t.entrust_type,"
               +" t.entrust_explain,t.dimensions,t.investment,t.status,"
               +" t.expect_date,t.other_request,t.entrust_phaseid,t.entrust_phase,t.design_id )"
               +" values('"+ approval_id + "','" + proj_id + "','"+m_oid+"','" + userId + "','" + userName 
               + "','" + orgId + "','" + orgName + "','"+proj_level+"','" + consult_id + "','"+client
               +"','"+ascription+"','"+proj_type +"','"+province +"','"+entrust_way+"','"+entrust_type
               +"','"+ entrust_explain +"','"+dimensions +"','"+investment+"','草稿', to_date('"+expect_date+"','yyyy-mm-dd'),'"+explain 
               +"','"+entrust_phaseid+"','"+entrust_phase+"','"+design_id+"')" ;         
   all_sql+=" <no> " + approval_sql+ " </no> "; 
 }else{ //修改处理
       var project_sql=" update ta_project_basic_info a set a.proj_name='"+project_name
                      +"',a.created_date=sysdate,a.ascription='"+ascription+"',a.proj_type='"+proj_type
                      +"',a.province='"+province+"',a.belong_org='"+belong_org+"' where a.proj_id='" + trim($("proj_id").value) +"'";
        all_sql=" <no>"+project_sql + "</no> " ;             
 }    
 var approval_id=trim($("approval_id").value);
 var request_explain=trim($("request_explain").value);
 var agress_explain=trim($("agress_explain").value);
 var ablity_explain=trim($("ablity_explain").value);
 var other=trim($("other").value);
 var other_explain=trim($("other_explain").value);
 var appraisal_measure=trim($("appraisal_measure").value);
 var appraisal_result=trim($("appraisal_result").value);
if(flag=="new"){ //保存处理
 var client_sql=" insert into TA_PROJECT_APPRAISAL t(t.link_id,t.request_explain,t.agress_explain, t.client_request,t.agress,t.ablity,t.other_request,"
              +" t.ablity_explain,t.other,t.other_explain,t.appraisal_measure,t.appraisal_result) values("             
              +"'"+ approval_id + "','" + request_explain + "','" + agress_explain + "','"+$("radio1").value+"','"+$("radio2").value
              +"','"+$("radio3").value+"','"+$("radio4").value+"','"+ ablity_explain             
              + "','" + other + "','" + other_explain + "','" + appraisal_measure + "','" + appraisal_result + "')";
 all_sql+=" <no> " + client_sql + "</no> ";       
 var proiect_id =$("proj_id").value;//工程ID
 var design_id = $("design_id").value;//设计编号
 var proj_level = dataset_taskt.Fields.Field['proj_level'].Value;  //管理级别 
 
 var main_deptid = dataset_taskt.Fields.Field['dept_id'].Value; //主体部门ID
 var main_dept =  dataset_taskt.Fields.Field['dept_name'].Value; //主体部门
 
 var join_deptid = dataset_taskt.Fields.Field['joindept_id'].Value; //参加部门Id
 var join_deptid_array = join_deptid.split(",");//将参加部门ID拆分为数组。
 var join_deptname = dataset_taskt.Fields.Field['joindept_name'].Value; //参加部门  
 var join_deptname_array = join_deptname.split(","); //将参加部门拆分为数组。 
 var design_phaseid = dataset_taskt.Fields.Field['design_phasesid'].Value;//设计阶段ID
 var design_phasename = dataset_taskt.Fields.Field['design_phases'].Value;//设计阶段名称
 var phaseid_array = design_phaseid.split(","); //将设计阶段ID转换为数组存贮
 var phasename_array = design_phasename .split(",");
 var sql="";
 for(var i=0;i<phaseid_array.length;i++){
     if(IsSpace(trim(phaseid_array[i]))){continue;}//处理为空的情况
     var oid=getNewCc_form_instanceid(false);
    sql+=" <no>"+" insert into ta_project_approval_phase t(t.oid,t.design_phaseid,t.design_phasename,t.approval_id, t.proj_id,t.proj_level, "
        +"t.join_deptid, t.join_deptname, t.m_deptid, t.m_deptname,t.dimensions,t.investment,t.expect_date,t.other_request,t.design_id) values("
        +"'" + oid + "','" + phaseid_array[i] + "','" + phasename_array[i] 
        + "','" + approval_id + "','" + proiect_id + "','" + proj_level  + "','" + join_deptid
        + "','" + join_deptname + "','" + main_deptid + "','" + main_dept + "','"+dimensions +"','"+investment 
        +"',to_date('"+expect_date+"','yyyy-mm-dd'),'"+explain+"','"+design_id+"')"+" </no> ";
        
      var org_oid=getNewCc_form_instanceid(false); //加入主体部门  
       sql+=" <no>"+" insert into ta_project_joindept t(t.oid,t.phase_oid,t.joindept_type,t.join_deptid,t.join_deptname) " 
          +" values('" +org_oid+ "','"+ oid +"','2','" +main_deptid+ "','"+ main_dept +"')"+"</no> ";          
        for(var j=0;j<join_deptid_array.length;j++){
         if(IsSpace(trim(join_deptid_array[j]))){continue;}//处理为空的情况
         org_oid=getNewCc_form_instanceid(false); 
         sql+=" <no>"+" insert into ta_project_joindept t(t.oid,t.phase_oid,t.joindept_type,t.join_deptid,t.join_deptname) " 
             + " values('"+org_oid+"','"+ oid +"','1','"+ join_deptid_array[j] + "','" + join_deptname_array[j] + "')"+"</no> ";  
        } 
      }         
   all_sql += sql; 
 //更新任务安排的状态和任务开始时间   
   var mc_sql=" <no> update  ta_project_task_record  p set p.entrust_status='6',p.exec_date=sysdate  where p.oid='"+consult_id+"'</no>" ;
   all_sql += mc_sql;
 if(entrust_type=="phase_update"){//保存在阶段更新时中止的阶段
    var undo_phase_name=dataset_entrust.Fields.Field['undo_entrust_phase'].Value.split(","); 
    var undo_phase_id=dataset_entrust.Fields.Field['undo_entrust_phaseid'].Value.split(",");
    for(var i=0;i<undo_phase_id.length;i++){
        if(trim(undo_phase_id[i]=="")){continue;}
        var undo_id=getNewCc_form_instanceid(false);
        var undo_sql="insert into ta_project_phase_change p(p.phase_changeid,p.proj_id,p.change_type,p.repeal_phaseid,p.repeal_phasename,p.created_date,"
                   +" p.optype, p.is_pass,p.repeal_id) values ('"+undo_id+"', '"+proiect_id+"', 'phase_undo', '"+undo_phase_id[i]
                   +"', '"+undo_phase_name[i]+"', sysdate, '2', '否', '"+approval_id +"')";                 
    }
  }    
 }else{
       var client_sql=" update TA_PROJECT_APPRAISAL t set t.request_explain='"             
              + request_explain + "', t.agress_explain='" + agress_explain + "',t.ablity_explain='" + ablity_explain             
              + "', t.other='" + other + "',t.other_explain='" + other_explain 
              + "',t.appraisal_measure='" + appraisal_measure + "',t.appraisal_result='" + appraisal_result + "',t.client_request='"+$("radio1").value
              +"',t.agress='"+$("radio2").value+"',t.ablity='"+$("radio3").value+"',t.other_request='"+$("radio4").value+"' "
              +" where t.link_id='" + approval_id + "'";  
       all_sql+=" <no>"+client_sql+ "</no> " 
 }
 if(flag=="new"){
  var msg=InsertSqls(all_sql);
  if(IsSpace(msg)){
        alert("保存成功!请安排总负责人和单项.");
        flag="edit";
        $("tr1").style.display="";       
        var btnObj=window.event.srcElement;//将保存按钮改为修改
         btnObj.innerText="修改";
        $("workflowControl_start").style.display=""; //显示流程启动
          hideOrShowTabByName("审批信息","none");
        // $("workflowControl_selectUser").style.display="";
       // $("div_select_user").style.display="";
         initNextActAndUser();
    }else{
       alert("保存失败！"+msg);
       flag="new";
       $("approval_id").value="";
       $("proj_id").value="";
  }  
}else{
  var msg=InsertSqls(all_sql);
  if(IsSpace(msg)){
       alert("修改成功");
     }else{
       alert("修改失败！"+msg);
    }
 }
}

//录入返回后，初始化项目负责人列表
function initDutyPerson(){
var phase_oid=SqlToField("select wmsys.wm_concat(oid) from ta_project_approval_phase t where t.approval_id='" 
            + $("approval_id").value + "' order by design_phaseid");          
var phase_id = phase_oid.split(",");
var sql="select rownum as orderno,a.* from(select duty_id, phase_oid,duty_type,"
       +" decode(duty_type,'00','项目负责人','01','第一总负责人','02','第二总负责人','03','第三总负责人','其他')duty_type_name,"
       +" org_name, user_realname from ta_project_duty_person where phase_oid='"+phase_id[0] +"' order by duty_type)a";
  duty_dataset.Open(sql);     
}

//录入返回后，初始化项目负责人列表
function initItemList(){
var tem=fcpubdata.cc_form_instanceid;
fcpubdata.cc_form_instanceid="";
var phase_oid=SqlToField("select wmsys.wm_concat(oid) from ta_project_approval_phase t where t.approval_id='" 
            + $("approval_id").value + "' order by design_phaseid"); //阶段ID         
var phase_id = phase_oid.split(",");//将阶段信息放入到数组中。
  var item_List_Sql="select rownum as num,a.item_id,a.item_name,a.dept_name,c.admin_name,c.reviewers_name,c.user_name"
                  +" from TA_PROJECT_ITEM a,TA_PROJECT_ITEM_PHASE b,TA_PROJECT_ITEM_JOIN_PEOPLE c "
                  +" where a.item_id=b.item_id and b.oid=c.phase_oid  and b.phase_oid='"+phase_id[0]+"'";
item_dataset.Open(item_List_Sql);
fcpubdata.cc_form_instanceid=tem;
}

//判断名称是否相同 
function IsSameProname(){
    var project_name=trim($("project_name").value);
    var msg="";
    if(flag=="new"){
      msg=SqlToField("select t.proj_name from ta_project_basic_info t where t.proj_name='"+project_name+"'");
      }else{
       var id=$("proj_id").value; 
        msg=SqlToField("select t.proj_name from ta_project_basic_info t where t.proj_name='"+project_name+"' and t.proj_id !='"+id+"'");
     }
   if(!IsSpace(msg)){return true;}else{return false};
}

//查看意见
function viewOption(){
 var url=getOpenUrlByDjid("20100520152703328042")+"&approval_id="+approval_id;
 window.open(url,"","height=400,width=850,status=yes,toolbar=no,menubar=no,location=no");
}

//初始化顾客要求评审表中领导意见
function initCustomOption(){
var sql="select t.ideal_result, t.ideal_peoplename,to_char(t.ideal_date,'yyyy-mm-dd hh24:mi')ideal_date from ta_project_approval_opinion t"
        +" where t.businessid='"+approval_id+"' order by t.ideal_date";
var count = SqlToField("select count(*) from ta_project_approval_opinion t where t.businessid='"+approval_id+"'");
var option_array=executeSelect(sql,1,count); 
var options="";
for(var i=0;i<option_array.length;i++){
 options+=option_array[i][0]+"  "+option_array[i][1]+ "  " + option_array[i][2]+ "\n";
}
$("leader_option").value=options;
}

//查看任务安排
function viewItemPlan(){
var url = "20100520151753078849.jsp?plan_id="+m_oid;
  var swidth = 700;
  var sheight = 300;
  showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
}

//返回函数
function back(){
window.history.back();
}

//启动流程
function doStart(){
 if(!isApprovalDuty()){return;} //判断是否安排负责人
 if(!isApprovalItem()){return;}//判断是否安排单项
//获取参与部门和主体处
 approval_id=$("approval_id").value;
if($("approval_id").value==""){approval_id="'";}

//判断主体处是否为空，容错的判断
var main_dept_sql=" select * from(select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='2' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')) left join "
                +" (select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='1' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')) on 1=1  ";   
var main_dept_count = executeSelect(main_dept_sql,1,1);  //主体处的个数。
if(main_dept_count[0][0]=="0"){alert("主体处为空");return false;} 
  if($("DYNAMICPERFORMER").value==""&&main_dept_count[0][1]!="0"){alert("请选择参加处领导！");return false;}
  if($("main_dept_id").value==""){alert("请选择主体处领导!");return false;}
  if(main_dept_count[0][1]=="0"){//当无配合处时，设置动态选择下一步执行人为主体处领导
   $("DYNAMICPERFORMER").value=$("main_dept_id").value;
  }
  if(buess_id!=""){fcpubdata.cc_form_instanceid=buess_id;}
  var update_sql="<no>"+" update ta_project_approval p set p.status='在办',p.main_dept_leader='"+$("main_dept_id").value+"' where p.approval_id='"+ approval_id +"'"+"</no>";
  //立项申请插入审批信息
   var ideal_id = getNewCc_form_instanceid(false);
    update_sql += "<no>"+"insert into ta_project_approval_opinion t (t.ideal_id,t.ideal_peopleid,t.ideal_peoplename,"
                   +" t.ideal_departid,t.ideal_departname,t.ideal_result,t.ideal_conten,t.ideal_date,"
                   +"t.businessid,t.action_defid,t.action_name)   values('"+ideal_id+"','"+userId+"','"+userName
                   +"','"+orgId+"','"+orgName+"','','',sysdate,'"+approval_id+"','setitem_wp1_act1','"+actName+"')"+"</no>";               
   if(!confirm("确认提交吗？")){return;}
  var msg=creator_inserts(update_sql);
  if(IsSpace(msg)){
       creator_djsave('启动流程',false,true,''); 
        history.go(-1);   
     }else{
       alert("启动流程失败！"+msg);
    }
}

//获取参与部门和主体处
function initNextActAndUser(){
approval_id=$("approval_id").value;
if($("approval_id").value==""){approval_id="'";}

//判断主体处是否为空，容错的判断
var main_dept_sql="  select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='2' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')";  
var main_dept_count = SqlToField(main_dept_sql);  //主体处的个数。
if(main_dept_count=="0"){alert("主体处为空");//return false;
} 
 
//判断配合处是否为空                    
var join_dept_sql=" select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='1' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')";
var join_dept_count = SqlToField(join_dept_sql);  //配合处的个数。
var joindept_type="";
if(join_dept_count=="0"){//无配合处
    $("nextActName").innerHTML="主体处领导审批";//显示下一环节名称
    $("workflow_ctrl").value="无";
    $("workflowControl_selectAct").value="setitem_wp1_act3";
    $("workflowControl_selectUser").style.display="none"; 
    $("join_dept_content").style.display="none";
    $("join_dept_text").style.display="none";
}else{//有配合处
   $("nextActName").innerHTML="参加处领导审批";
   joindept_type="1";
   $("workflow_ctrl").value="有";
   $("workflowControl_selectAct").value="setitem_wp1_act2";  
 //处理配合处中的分公司的情况
  var fen_sql="select distinct (d.join_deptid),f_getSecondRemark4(join_deptid) from ta_project_joindept d where d.joindept_type = '1'" 
             +" and d.phase_oid in(select t.oid from ta_project_approval_phase t where t.approval_id = '"+ approval_id+"') ";
  var fen_array=executeSelect(fen_sql,1,100); 
  var m=0,n=0; 
  var fen_dept_id="",zzbj_dept_id="";
   for(var i=0;i<fen_array.length;i++){
    if(fen_array[i][1]=="zongbu"||fen_array[i][1]=="zhengzhou"){
       if(m>=1){
        zzbj_dept_id+=","+fen_array[i][0];
       }else{
        zzbj_dept_id=fen_array[i][0];
       }  
       m++; 
    }else{
      if(n>=1){
       fen_dept_id+=","+"'"+fen_array[i][1]+"'";
      }else{
        fen_dept_id="'"+fen_array[i][1]+"'";
      }
      n++;
    }
  }  
if(zzbj_dept_id==""){zzbj_dept_id="''"; }  
if(fen_dept_id==""){fen_dept_id="''"; }
join_dept_sql = "select wmsys.wm_concat(user_name), wmsys.wm_concat(user_realname) from( select wmsys.wm_concat(u.user_name) as user_name, wmsys.wm_concat(u.user_realname) as user_realname "
               +"  from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou  where u.user_id = ur.user_id "
               +" and r.role_id = ur.role_id and u.user_id = ou.user_id and r.role_name = '部门主管生产领导' and ou.org_id in ("
               +zzbj_dept_id+") union all select wmsys.wm_concat(u.user_name) as user_name,wmsys.wm_concat(u.user_realname) as user_realname from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou " 
               +" where  f_getSecondRemark4(ou.org_id)  in("+fen_dept_id+")  and u.user_id = ur.user_id and r.role_id = ur.role_id  and u.user_id = ou.user_id  and r.role_name = '分公司主管生产领导')";
var user_array=executeSelect(join_dept_sql,1,1);
$("DYNAMICPERFORMER").value = user_array[0][0]      
$("DYNAMICPERFORMER_NAME").value = user_array[0][1];
$("workflowControl_selectUser").style.display=""; 
} 
 
joindept_type="2";
//处理主体处是否为分公司情况
var fen_sql="  select distinct (d.join_deptid),f_getSecondRemark4(join_deptid) as remark from ta_project_joindept d where d.joindept_type = '2'"
                +"  and d.phase_oid in (select t.oid  from ta_project_approval_phase t  where t.approval_id = '"+approval_id+"')";
var fen_array=executeSelect(fen_sql,1,1);   
if(fen_array[0][1]=="zongbu"||fen_array[0][1]=="zhengzhou") {             
join_dept_sql = " select wmsys.wm_concat(u.user_name) as user_name, wmsys.wm_concat(u.user_realname) as user_realname "
               +"  from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou  where u.user_id = ur.user_id "
               +" and r.role_id = ur.role_id and u.user_id = ou.user_id and r.role_name = '部门主管生产领导' and ou.org_id in ('"
               +fen_array[0][0] +"')";   
  }else{
 join_dept_sql = " select wmsys.wm_concat(u.user_name) as user_name, wmsys.wm_concat(u.user_realname) as user_realname from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou"  
               +" where  f_getSecondRemark4(ou.org_id)  in('" + fen_array[0][1] + "') and u.user_id = ur.user_id  and r.role_id = ur.role_id "
               +" and u.user_id = ou.user_id and r.role_name = '分公司主管生产领导'" 
  }
var user_array=executeSelect(join_dept_sql,1,1);
$("main_dept_id").value = user_array[0][0]      
$("main_dept_name").value = user_array[0][1];     
}

//初始化已立项阶段的信息
function initPhaseInfo(proj_id){
 if(trim(proj_id)==""){proj_id="'";}
 var initPhase_sql="  select t.oid,t.cc_form_instanceid,t.design_phasename,decode(t.proj_level, '0', '院管', '处管') proj_level,"
                +" t.m_deptname,t.institute_director, t.investment,p.duty_person from ta_project_approval_phase t "
                +" left join (select wmsys.wm_concat(t.user_realname) as duty_person, t.phase_oid from (select c.user_realname, c.phase_oid"
                +" from ta_project_duty_person c order by c.duty_type)t group by t.phase_oid) p on t.oid = p.phase_oid left join ta_project_design_phase d on t.design_phaseid = d.design_phaseid,ta_project_approval b"
                +" where t.design_status not in( '2','3') and t.approval_id=b.approval_id and b.is_pass='是' and t.proj_id = '"+ trim(proj_id) + "' order by d.order_number";
               // alert(initPhase_sql);
approval_phase_dataset.Open(initPhase_sql);
}

//查看已有阶段详情
function viewPhaseInfo(){
 var cc_form_instanceid = approval_phase_dataset.Fields.Field['cc_form_instanceid'].Value;
 var url="20100704171803734764.jsp?cc_form_instanceid="+cc_form_instanceid+"&opType=view";
   document.location.href=url;
}

//判断是否安排负责人
function isApprovalDuty(){
var id=trim($("approval_id").value);
if(id==""){id="'";}
var sql="select count(*) from ta_project_duty_person b where b.phase_oid in"
       + "(select a.oid from ta_project_approval_phase a where a.approval_id='"+id+"')";
 var msg=SqlToField(sql);
 if(IsSpace(msg)||"0"==msg){
  alert("请安排负责人");return false;
 }else{return true;}
}
//判断是否安排单项
function isApprovalItem(){
var id=trim($("approval_id").value);
if(id==""){id="'";}
var sql="select count(*) from ta_project_item i where i.item_id in("
       + " select b.item_id from ta_project_item_phase b where b.approval_id='"+id+"')";
     //  alert(sql);
 var msg=SqlToField(sql);
 if(IsSpace(msg)||"0"==msg){
  alert("请安排单项");return false;
 }else{
      var sql=" select (case when t.dept_id is null then org_id else dept_id end) as dept_id,"
             +" (case when t.dept_name is null then org_name else dept_name end) as dept_name from  ta_project_task_plan_detail t where t.plan_oid = '"+m_oid+"'";
      var  join_org = executeSelect(sql,1,200); 
      var item_join_sql ="select distinct(w.dept_id) from TA_PROJECT_ITEM  w where w.item_id in "
                 +" (select distinct(t.item_id) from ta_project_item_phase t where t.approval_id='" + $("approval_id").value +"')";
      var item_org = executeSelect(item_join_sql,1,200); 
      var org_name=""; 
      for(var i=0;i<join_org.length;i++){
         var flag=true;
         for(var j=0;j<item_org.length;j++){
          if(join_org[i][0]==item_org[j][0])
          {flag=false;break;}
         }
         if(flag){org_name+=join_org[i][1]+" ";}
      }         
       if(org_name==""){
        return true;
       }else{
          alert(org_name+" 还没安排单项！");
          return false;
       }        
 }
 
}

//结束流程
function doEnd(){
  if(!confirm("确认结束吗？")){return;}
  $("workflow_ctrl").value="结束";
  var end_sql= "<no>"+" update ta_project_approval a set a.status='作废' where a.approval_id='"+$("approval_id").value+"'"+"</no>";
      end_sql += "<no>"+"update ta_project_approval_phase p set p.design_status=3 where p.approval_id='"+$("approval_id").value+"'"+"</no>";    
  if(entrust_type ="project_new"){
    var consult_id=SqlToField("select p.task_oid from ta_project_task_plan p where p.oid='"+m_oid+"'");//任务安排
     end_sql += "<no>"+"update ta_project_basic_info c set c.isvalid=3 where c.proj_id='"+$("proj_id").value+"'"+"</no>";
    end_sql += " <no> update  ta_project_task_record  p set p.entrust_status='8',p.finish_date=sysdate  where p.oid='"+consult_id+"'</no>" ;
    end_sql +="<no> update ta_project_task_record t set t.entrust_status='8',t.finish_date=sysdate "
                 +" where t.parent_id='"+ consult_id +"' </no>" ;  
  } 
  var msg=InsertSqls(end_sql);
  if(IsSpace(msg)){
    creator_djsave('完成活动',false,true,''); 
    history.go(-1);   
  }
}

//选着参加处的领导
function select_joindept(){
approval_id=$("approval_id").value;
if($("approval_id").value==""){approval_id="'";}
var join_dept_allsql = " select wmsys.wm_concat(distinct(p.join_deptid)) from ta_project_joindept p where p.joindept_type='1' and p.phase_oid in "
                  +"  (select a.oid from ta_project_approval_phase a where a.approval_id='"+ approval_id +"')";           
 var join_dept_id=SqlToField(join_dept_allsql);
 //处理配合处中的分公司的情况
  var join_dept_sql="select distinct (d.join_deptid),f_getSecondRemark4(join_deptid) from ta_project_joindept d where d.joindept_type = '1'" 
             +" and d.phase_oid in(select t.oid from ta_project_approval_phase t where t.approval_id = '"+ approval_id+"') ";
  var join_dept_array=executeSelect(join_dept_sql,1,100); 
  var m=0,n=0; 
  var fen_dept_id="",zzbj_dept_id="";
   for(var i=0;i<join_dept_array.length;i++){
    if(join_dept_array[i][1]=="zongbu"||join_dept_array[i][1]=="zhengzhou"){
       if(m>=1){
        zzbj_dept_id+=","+join_dept_array[i][0];
       }else{
        zzbj_dept_id=join_dept_array[i][0];
       }  
       m++; 
    }else{
      if(n>=1){
       fen_dept_id+=","+"'"+join_dept_array[i][1]+"'";
      }else{
        fen_dept_id="'"+join_dept_array[i][1]+"'";
      }
      n++;
    }
  }  
if(zzbj_dept_id==""){zzbj_dept_id="''"; }  
if(fen_dept_id==""){fen_dept_id="''"; }
var obj={ 
     flag:"1",
     sql:"",
     title:"选择参加处领导",
     isRadio:false,
     ObjId:DYNAMICPERFORMER,
     ObjName:DYNAMICPERFORMER_NAME,
     rootId:"0",
     rootName:"机构树",
     callback:"",
     expandLevel:"3"
    };
 obj.sql="  select distinct(o.org_id) as id, o.parent_id, o.org_name as name"
        +" from td_sm_organization o connect by prior o.parent_id=o.org_id  start with o.org_id in ("+join_dept_id+")"
        +" union all select to_char(u.user_name) as id,ou.org_id as parent_id,u.user_realname as name from td_sm_user u,"
        +" td_sm_userrole ur,td_sm_orguser ou, td_sm_role  r where u.user_id = ur.user_id  and ur.role_id = r.role_id"
        +" and u.user_id = ou.user_id and ou.org_id in ("+zzbj_dept_id+") and r.role_name = '部门领导' union all "
        +" select to_char(u.user_name) as id,f_getSecondOrgId(ou.org_id) as parent_id,u.user_realname as name from td_sm_user u,"
        +" td_sm_userrole ur, td_sm_orguser ou, td_sm_role r where "
        +" f_getSecondRemark4(ou.org_id) in ("+fen_dept_id+") and u.user_id = ur.user_id  and ur.role_id = r.role_id and u.user_id = ou.user_id and r.role_name = '分公司领导'";  
    OpenTreeFromSql(obj); 
}

//选着主体处的领导
function select_maindept(){
approval_id=$("approval_id").value;
if($("approval_id").value==""){approval_id="'";}
 var join_dept_sql = " select distinct(p.join_deptid),f_getSecondRemark4(join_deptid) as remark from ta_project_joindept p where p.joindept_type='2' and p.phase_oid in "
                  +"  (select a.oid from ta_project_approval_phase a where a.approval_id='"+ approval_id +"')";            
 var join_dept_id=executeSelect(join_dept_sql,1,1);
 var obj={ 
     flag:"1",
     sql:"",
     title:"选择主体处领导",
     isRadio:true,
     ObjId:main_dept_id,
     ObjName:main_dept_name,
     rootId:"0",
     rootName:"机构树",
     callback:"",
     expandLevel:"2",
     isShowType:"hidden",
     params:join_dept_id[0][0]
    };
    if(join_dept_id[0][1]=="zongbu"||join_dept_id[0][1]=="zhengzhou"){//处理选择主体处为分公司的情况
    obj.sql="  select distinct (id), t.parent_id, t.name from (select distinct(o.org_id) as id, '0' as parent_id, o.org_name as name"
        +" from td_sm_organization o where o.org_id in ("+join_dept_id[0][0]+")"
        +" union all select to_char(u.user_name) as id,ou.org_id as parent_id,u.user_realname as name from td_sm_user u,"
        +" td_sm_userrole ur,td_sm_orguser ou, td_sm_role  r where u.user_id = ur.user_id  and ur.role_id = r.role_id"
        +" and u.user_id = ou.user_id and ou.org_id in ("+join_dept_id[0][0]+") and r.role_name = '部门领导') t";  
      }else{
       obj.sql="  select '"+join_dept_id[0][0]+"' as id, '0' as parent_id, o.org_name as name from td_sm_organization o where o.org_id in ('"+join_dept_id[0][0]+"')"
       +" union all  select u.user_name as id, '"+join_dept_id[0][0]+"' as parent_id, u.user_realname as name from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou"
       +"  where f_getSecondRemark4(ou.org_id) in ('"+join_dept_id[0][1]+"')  and u.user_id = ur.user_id and r.role_id = ur.role_id and u.user_id = ou.user_id and r.role_name = '分公司领导'";
      }  
    OpenTreeFromSql(obj); 
}

//完成活动，即立项修改环节提交 
function completeAct(){
approval_id=$("approval_id").value;
if($("approval_id").value==""){approval_id="'";}

//判断主体处是否为空，容错的判断
var main_dept_sql=" select * from(select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='2' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')) left join "
                +" (select count(distinct(d.join_deptid)) from ta_project_joindept d  where d.joindept_type='1' and d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')) on 1=1  ";   
var main_dept_count = executeSelect(main_dept_sql,1,1);  //主体处的个数。
if(main_dept_count[0][0]=="0"){alert("主体处为空");return false;} 
  if($("DYNAMICPERFORMER").value==""&&main_dept_count[0][1]!="0"){alert("请选择参加处领导！");return false;}
  if($("main_dept_id").value==""){alert("请选择主体处领导!");return false;}
  if(main_dept_count[0][1]=="0"){//当无配合处时，设置动态选择下一步执行人为主体处领导
   $("DYNAMICPERFORMER").value=$("main_dept_id").value;
   $("DYNAMICPERFORMER_NAME").value=$("main_dept_name").value;
  }
 if(!confirm("确认提交吗？")){return;}
 creator_djsave('完成活动',false,true,'');
  history.go(-1);

}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>radio1</id><id>radio2</id><id>radio3</id><id>radio4</id></radio><textarea><id>other_request</id><id>request_explain</id><id>agress_explain</id><id>ablity_explain</id><id>other_explain</id><id>appraisal_measure</id><id>appraisal_result</id></textarea><combobox><id>combobox1</id><id>combobox3</id><id>combobox8</id><id>combobox9</id><id>combobox2</id><id>combobox4</id><id>combobox5</id><id>entrust_way</id><id>proj_level</id><id>workflowControl_selectAct</id></combobox><img><id>img1</id></img><tab><id>tab1</id></tab><div><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_recycle</id><id>div_select_user</id><id>workflowControl_selectUser</id><id>div1</id><id>workflowControl_selectAndUser</id><id>workflowControl_tempSaveForm</id><id>workflowControl_back</id><id>workflowControl_backToPrior</id><id>workflowControl_selectAct_div</id></div><button><id>button_jslc</id><id>button_qdlc</id><id>button_wchd</id><id>button_hs</id><id>save</id><id>viewlog</id><id>button7</id><id>button6</id><id>button3</id><id>button2</id><id>select_main_user</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_zc</id><id>button_ht</id></button><text><id>project_name</id><id>design_id</id><id>dept_name</id><id>joindept_name</id><id>inputer</id><id>orgName</id><id>input_date</id><id>client</id><id>entrust_explain</id><id>text30</id><id>text27</id><id>text13</id><id>expect_date</id><id>dimensions</id><id>investment</id><id>other</id><id>main_dept_name</id><id>main_dept_id</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>workflow_ctrl</id><id>proj_id</id><id>approval_id</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><grid><id>grid3</id><id>grid1</id><id>grid2</id></grid><dataset><id>dataset_entrust</id><id>item_dataset</id><id>dataset_taskt</id><id>modify_dataset</id><id>approval_phase_dataset</id><id>duty_dataset</id></dataset></root>" billtaborder="<root><taborder>combobox1</taborder><taborder>combobox2</taborder><taborder>combobox3</taborder><taborder>combobox4</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zc</taborder><taborder>save</taborder><taborder>viewlog</taborder><taborder>button7</taborder><taborder>button6</taborder><taborder>workflowControl_result</taborder><taborder>workflow_ctrl</taborder><taborder>proj_id</taborder><taborder>approval_id</taborder><taborder>project_name</taborder><taborder>design_id</taborder><taborder>dept_name</taborder><taborder>joindept_name</taborder><taborder>inputer</taborder><taborder>orgName</taborder><taborder>other_request</taborder><taborder>client</taborder><taborder>entrust_explain</taborder><taborder>text27</taborder><taborder>dimensions</taborder><taborder>investment</taborder><taborder>text13</taborder><taborder>expect_date</taborder><taborder>request_explain</taborder><taborder>agress_explain</taborder><taborder>ablity_explain</taborder><taborder>other_explain</taborder><taborder>appraisal_measure</taborder><taborder>appraisal_result</taborder><taborder>button2</taborder><taborder>grid1</taborder><taborder>grid2</taborder><taborder>proj_level</taborder><taborder>entrust_way</taborder><taborder>grid3</taborder><taborder>radio1</taborder><taborder>radio2</taborder><taborder>radio3</taborder><taborder>radio4</taborder><taborder>other</taborder><taborder>button3</taborder><taborder>button_jslc</taborder><taborder>combobox8</taborder><taborder>combobox9</taborder><taborder>combobox5</taborder><taborder>text30</taborder><taborder>button_yfzxzxr</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>input_date</taborder><taborder>select_main_user</taborder><taborder>main_dept_name</taborder><taborder>main_dept_id</taborder><taborder>button_xzxr</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>workflowControl_selectAct</taborder></root>" dj_sn="20100519145625218443" caption="工程立项申请表" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:2;radio:4;listbox:0;textarea:9;combobox:9;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:1;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:7;text:31;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:3;dataset:6;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="bspf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination="grid3,approval_phase_dataset,;grid1,duty_dataset,;grid2,item_dataset,5;" type="ZW" creatorType="20100518201118906945" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;/userjs/project/project_pub.js&#13;&#10;/userjs/project/div_tree.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid>grid3,grid1,grid2</gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=tit style="POSITION: static" width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD><H1>当前环节：<FONT id=actName>环节名称</FONT></H1></TD>
                     <TD><DIV id=workflowControl1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="workflowControl" NotBg="是"><BUTTON class=button_top id=button_jslc style="DISPLAY: none; LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doEnd()")'>结束</BUTTON><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 64px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_qdlc style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doStart()")'>提交</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 53px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_wchd style="LEFT: 0px; WIDTH: 47px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("completeAct()")'>提交</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 57px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_nor id=button_hs style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)">收回</BUTTON></DIV></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><DIV class=tab-pane id=tab1 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 35px; HEIGHT: 520px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 502px"><H2 class=tab>基本信息</H2>
                  <TABLE class=shade style="POSITION: static" width="100%" align=left>
                     <TBODY>
                        <TR>
                           <TD colSpan=2><LI><SPAN><BUTTON class=button_nor id=save style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("savaInfo()")'>保存</BUTTON><BUTTON class=button_nor id=viewlog style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("viewOption()")'>查看日志</BUTTON><BUTTON class=button_nor id=button7 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("viewItemPlan()")'>查看项目安排</BUTTON><BUTTON class=button_nor id=button6 style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("back()")'>返回</BUTTON></SPAN>工程立项基本信息</LI></TD>
                        </TR>
                        <TR>
                           <TD colSpan=2>
                              <TABLE class=shadeTab style="POSITION: static" width="100%" align=left>
                                 <TBODY>
                                    <TR>
                                       <TH width="5%">工程名称&nbsp;
                                          <FONT color=red>*</FONT>
                                       </TH>
                                       <TD width="70%" colSpan=3><INPUT id=project_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="proj_name" china="工程名称" dataset="modify_dataset"></TD>
                                       <TH class=color width="5%">设计编号</TH>
                                       <TD width="20%"><INPUT id=design_id style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                                    </TR>
                                    <TR>
                                       <TH width="5%">主体处</TH>
                                       <TD width="20%"><INPUT id=dept_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="dept_name" china="主体部门" dataset="dataset_taskt"></TD>
                                       <TH width="5%">配合处</TH>
                                       <TD width="70%" colSpan=3><INPUT id=joindept_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="joindept_name" china="参与部门" dataset="dataset_taskt"></TD>
                                    </TR>
                                    <TR>
                                       <TH>项目归属</TH>
                                       <TD><SELECT id=combobox1 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xrn%D0%EA%D6XrnXrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xt%96Xr%7C%EE%F2%EC%E2%CC%D0%F6%F6%F2%E0%D2%F8%F6%E0%FA%D8Xr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="ASCRIPTION" china="项目归属" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH>省市</TH>
                                       <TD><SELECT id=combobox3 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%EE%F2%EC%FA%E0%EA%D4%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="PROVINCE" china="省市" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH>归属机构</TH>
                                       <TD><SELECT id=combobox8 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%EC%F2%DC%CC%E0%D6Xr%94%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXn%96Xn%90%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="belong_orgid" china="归属机构ID" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                    </TR>
                                    <TR>
                                       <TH>专业属性</TH>
                                       <TD><SELECT id=combobox9 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90Xrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90Xrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xt%96XrnXr%7C%EE%F2%EC%DA%D8%F4%F4%E0%EC%EA%D0%E6%CC%EE%F2%EC%EE%D8%F2%F6%u0100Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="profession_property" china="专业属性" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH noWrap>工程类型</TH>
                                       <TD><SELECT id=combobox2 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%EE%F2%EC%E2%CC%F6%u0100%EE%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="PROJ_TYPE" china="工程类型" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH noWrap>负责机构</TH>
                                       <TD><SELECT id=combobox4 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%EC%F2%DC%CC%E0%D6Xr%94%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXn%96Xn%90%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="responsible_orgid" china="负责机构ID" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                    </TR>
                                    <TR>
                                       <TH class=color width="10%">填表人</TH>
                                       <TD width="15%"><INPUT id=inputer style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=16 controltype="text" field="inputer" china="申请者" dataset="modify_dataset"></TD>
                                       <TH class=color width="10%">部门名称</TH>
                                       <TD width="25%"><INPUT id=orgName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="org_name" china="机构" dataset="modify_dataset"></TD>
                                       <TH>填表日期</TH>
                                       <TD><INPUT id=input_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR id=phase_td1 style="DISPLAY: none">
                           <TD colSpan=2><LI>已立项的阶段信息</LI></TD>
                        </TR>
                        <TR id=phase_td2 style="DISPLAY: none">
                           <TD colSpan=2><?xml:namespace prefix = fc /><fc:webgrid id=grid3 onkeydown='bill_ongridkeydown("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' ondblclick='bill_ongriddblclick("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' onclick='bill_ongridclick("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' top="0" width="100%" height="123" format="<cols><col><fname>design_phasename</fname><cname>阶段名称</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>13%</columnwidth><align>left</align></col><col><fname>proj_level</fname><cname>管理级别</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>7%</columnwidth><align>left</align></col><col><fname>m_deptname</fname><cname>主体处</cname><width>30</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>duty_person</fname><cname>总负责人</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>40%</columnwidth><align>left</align></col><col><fname>institute_director</fname><cname>院主管</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>investment</fname><cname>投资规模</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col></cols>" dataset="approval_phase_dataset" visible="是" canselect="是" autoheight="是" autowidth="否" autoappend="否" readonly="否" SetRowHeight="否" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="25" bodyrows="-1" left="0">
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
                           <TD colSpan=2><LI><SPAN><IMG id=img1 style="LEFT: 0px; CURSOR: hand; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/zxyd/project/images/menu_off.gif" controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('table_entrust')&quot;)" cover="9" srcsk="../../../ccapp/zxyd/project/images/menu_off.gif"></SPAN>委托情况</LI></TD>
                        </TR>
                        <TR>
                           <TD colSpan=2>
                              <TABLE class=shadeTab id=table_entrust style="DISPLAY: none; POSITION: static" width="100%" align=left <TBODY>
                                 <TBODY>
                                    <TR>
                                       <TH width="10%">委托类型</TH>
                                       <TD width="15%"><SELECT id=combobox5 style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%D8%EA%F6%F2%F8%F4%F6%CC%F6%u0100%EE%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="entrust_type" china="委托类型" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="150" backheight="25"></SELECT></TD>
                                       <TH width="10%">委托单位</TH>
                                       <TD width="65%"><INPUT id=client style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 80%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CLIENT" china="委托单位" dataset="dataset_entrust"></TD>
                                    </TR>
                                    <TR>
                                       <TH>委托方式</TH>
                                       <TD><SELECT id=entrust_way style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%D8%EA%F6%F2%F8%F4%F6%CC%FC%D0%u0100Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="ENTRUST_WAY" china="委托方式" dataset="dataset_entrust" tempvalue temptext sql check="2" backwidth="147" backheight="25"></SELECT></TD>
                                       <TH>委托说明</TH>
                                       <TD><INPUT id=entrust_explain style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ENTRUST_EXPLAIN" china="委托说明" dataset="dataset_entrust"></TD>
                                    </TR>
                                    <TR>
                                       <TH>客户编号</TH>
                                       <TD><INPUT id=text30 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_id" china="客户项目编号" dataset="dataset_entrust"></TD>
                                       <TH>客户项目名称</TH>
                                       <TD><INPUT id=text27 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_name" china="客户项目名称" dataset="dataset_entrust"></TD>
                                    </TR>
                                    <TR>
                                       <TH rowSpan=5>任务信息</TH>
                                       <TH>
                                          <FONT id=show_info>委托阶段</FONT>
                                       </TH>
                                       <TD colSpan=2><INPUT id=text13 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 30%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() readOnly controltype="text" field="add_entrust_phase" china="委托阶段" dataset="dataset_entrust">要求在<INPUT id=expect_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly controltype="text" field="EXPECT_DATE" china="完成日期" dataset="dataset_entrust">前完成。</TD>
                                    </TR>
                                    <TR id=undo_phase style="DISPLAY: none">
                                       <TH>中止阶段</TH>
                                       <TD id=undo_phase_name colSpan=2>中止阶段</TD>
                                    </TR>
                                    <TR>
                                       <TH>设计规模</TH>
                                       <TD colSpan=2><INPUT id=dimensions style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() readOnly controltype="text" field="DIMENSIONS" china="设计规模" dataset="dataset_entrust"></THD TR <><TR><TH>工程总投资</TH><TD colSpan=2><INPUT id=investment style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 118px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: left" onmovestart=moveStart() readOnly size=11 controltype="text" field="INVESTMENT" china="总投资" dataset="dataset_entrust">万元,质量满足现行国家有关规范、标准的要求。</TD>
                                       </TR>
                                       <TR>
                                          <TH>其他要求</TH>
                                          <TD colSpan=2><TEXTAREA id=other_request style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() readOnly controltype="textarea" field="OTHER_REQUEST" china="其他要求" dataset="dataset_entrust" value="textarea1" induce="否"></TEXTAREA></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD colSpan=2><LI>顾客要求评审表</LI></TD>
                           </TR>
                           <TR>
                              <TD colSpan=2>
                                 <TABLE class=shadeTab style="POSITION: static" width="100%" align=left>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">1、顾客要求是否已经明确？</TH>
                                          <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio1 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 75px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() controltype="radio" field="client_request" china="客户要求" dataset="modify_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=是 name=RGradio1 text="是"><SPAN onclick=RGradio1[0].checked=true;radio1.value=RGradio1[0].value;RGradio1[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio1 text="否"><SPAN onclick=RGradio1[1].checked=true;radio1.value=RGradio1[1].value;RGradio1[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                          <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=request_explain style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 34px" onmovestart=moveStart() rows=1 controltype="textarea" field="request_explain" china="要求是否明确" dataset="modify_dataset" value="textarea3" induce="否"></TEXTAREA></TD>
                                          <TH style="TEXT-ALIGN: left" width="10%">2、与顾客的理解是否达成共识？</TH>
                                          <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio2 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 75px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() controltype="radio" field="agress" china="同意" dataset="modify_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=是 name=RGradio2 text="是"><SPAN onclick=RGradio2[0].checked=true;radio2.value=RGradio2[0].value;RGradio2[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio2 text="否"><SPAN onclick=RGradio2[1].checked=true;radio2.value=RGradio2[1].value;RGradio2[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                          <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=agress_explain style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 34px" onmovestart=moveStart() cols=15 controltype="textarea" field="agress_explain" china="理解达成共识" dataset="modify_dataset" value="textarea4" induce="否"></TEXTAREA></TD>
                                       </TR>
                                       <TR>
                                          <TH style="TEXT-ALIGN: left" width="10%">3、是否有能力满足顾客要求？</TH>
                                          <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio3 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 75px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 14px" onmovestart=moveStart() controltype="radio" field="ablity" china="能力" dataset="modify_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=是 name=RGradio3 text="是"><SPAN onclick=RGradio3[0].checked=true;radio3.value=RGradio3[0].value;RGradio3[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio3 text="否"><SPAN onclick=RGradio3[1].checked=true;radio3.value=RGradio3[1].value;RGradio3[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                          <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=ablity_explain style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 34px" onmovestart=moveStart() controltype="textarea" field="ablity_explain" china="是否有能力满足" dataset="modify_dataset" value="textarea5" induce="否"></TEXTAREA></TD>
                                          <TH noWrap width="10%">4、其它：
                                             <INPUT id=other style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 22px" onmovestart=moveStart() value=无 controltype="text" field="other" china="其他" dataset="modify_dataset">
                                          </TH>
                                          <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio4 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 75px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px; valign: middle" onmovestart=moveStart() controltype="radio" field="other_request" china="其他要求" dataset="modify_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=是 name=RGradio4 text="是"><SPAN onclick=RGradio4[0].checked=true;radio4.value=RGradio4[0].value;RGradio4[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio4 text="否"><SPAN onclick=RGradio4[1].checked=true;radio4.value=RGradio4[1].value;RGradio4[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                          <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=other_explain style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 34px" onmovestart=moveStart() controltype="textarea" field="other_explain" china="其他要求解释" dataset="modify_dataset" value="textarea6" induce="否"></TEXTAREA></TD>
                                       </TR>
                                       <TR>
                                          <TH>评审引发的措施:(其他要求)</TD>
                                          <TD colSpan=5><TEXTAREA id=appraisal_measure style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() controltype="textarea" field="appraisal_measure" china="措施" dataset="modify_dataset" value="textarea7" induce="否">无</TEXTAREA></TH></TD>
                                       <TR>
                                          <TH>评审结论(少于100字)</TH>
                                          <TD colSpan=5><TEXTAREA id=appraisal_result style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() cols=18 controltype="textarea" field="appraisal_result" china="评审结论" dataset="modify_dataset" value="textarea8" induce="否">顾客要求能够满足,同意承接。</TEXTAREA></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD colSpan=2><LI>【<FONT id=phasename color=red></FONT>】阶段总负责人和单项安排</LI></TD>
                           </TR>
                           <TR>
                              <TD colSpan=2>
                                 <TABLE class=shadeTab style="POSITION: static" width="100%" align=left>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">管理级别</TH>
                                          <TD width="40%"><SELECT id=proj_level style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="管理级别" dataset="dataset_taskt" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" sql check="1" backwidth="120" backheight="25"><OPTION value=0>院管</OPTION><OPTION value=1 selected>处管</OPTION></SELECT></TD>
                                          <TH width="10%">院主管</TH>
                                          <TD width="40%"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR id=tr1 style="DISPLAY: none">
                              <TD colSpan=2>
                                 <TABLE style="POSITION: static" width="100%" align=left border=0>
                                    <TBODY>
                                       <TR>
                                          <TD colSpan=2><LI><BUTTON class=button_top id=button3 style="LEFT: 0px; WIDTH: 162px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addProUser()")'>添加/编辑项目负责人</BUTTON>1.总负责人(项目负责人)审批表</LI></TD>
                                       </TR>
                                       <TR>
                                          <TD colSpan=2><fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col></grid1>")' top="0" width="100%" height="103" format="<cols><col><fname>orderno</fname><cname>序号</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>duty_type_name</fname><cname>负责人类型</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>30%</columnwidth><align>center</align></col><col><fname>org_name</fname><cname>单位</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>30%</columnwidth><align>center</align></col><col><fname>user_realname</fname><cname>总负责人</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>30%</columnwidth><align>center</align></col></cols>" dataset="duty_dataset" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="25" bodyrows="-1" left="0">
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
                                          <TD><LI><BUTTON class=button_top id=button2 style="LEFT: 0px; WIDTH: 159px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addSingleInfo()")'>添加/编辑单项负责人</BUTTON>2.单项负责人审批表</LI></TD>
                                       </TR>
                                       <TR>
                                          <TD colSpan=2><fc:webgrid id=grid2 onkeydown='bill_ongridkeydown("<grid2><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' ondblclick='bill_ongriddblclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' onclick='bill_ongridclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' top="0" width="100%" height="143" format="<cols><col><fname>num</fname><cname>序号</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>5%</columnwidth><align>left</align></col><col><fname>item_name</fname><cname>单项名称</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>负责处</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>admin_name</fname><cname>负责人</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>reviewers_name</fname><cname>审核人</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>user_name</fname><cname>参加人</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>45%</columnwidth><align>left</align></col></cols>" dataset="item_dataset" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
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
                                          <TD colSpan=2><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid2"><SPAN id=pageInfogrid2></SPAN><A id=firstpagegrid2 onclick="buttonevent('grid2','firstpage')" href="javascript:void(0)">首页</A><A id=prevpagegrid2 onclick="buttonevent('grid2','prevpage')" href="javascript:void(0)">上一页</A><A id=nextpagegrid2 onclick="buttonevent('grid2','nextpage')" href="javascript:void(0)">下一页</A><A id=lastpagegrid2 onclick="buttonevent('grid2','lastpage')" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 502px">
                     <H2 class=tab>审批信息</H2>
                     <TABLE class=tit style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 2px" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
                        <TBODY>
                           <TR>
                              <TD colSpan=2><H1>下一环节：<FONT id=nextActName>环节名称</FONT></H1></TD>
                           </TR>
                           <TR>
                              <TD>
                                 <TABLE class=shadeTab id=design_table style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left>
                                    <TBODY>
                                       <TR>
                                          <TH width="10%">选择主体处领导</TH>
                                          <TD width="20%"><DIV id=div_select_user style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 137px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 32px" onmovestart=moveStart() controltype="div" NotBg="是"><INPUT id=main_dept_name style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 20px; TEXT-ALIGN: center" onmovestart=moveStart() readOnly size=15 controltype="text"><INPUT id=main_dept_id style="DISPLAY: none; LEFT: 0px; WIDTH: 7px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=1 controltype="text"><BUTTON class=button_nor id=select_main_user style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 23px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("select_maindept()")'>选择</BUTTON></DIV></TD>
                                          <TH id=join_dept_text width="10%">选择参加处领导</TH>
                                          <TD id=join_dept_content width="60%"><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 211px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=18 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button_nor id=button_xzxr style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 23px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("select_joindept()")'>选择</BUTTON></DIV></TD>
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
            </TD>
         </TR>
      </TBODY>
   </TABLE>
   <DIV id=div1 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; DISPLAY: none; Z-INDEX: 5; LEFT: 548px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 240px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 310px; HEIGHT: 464px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
      <fc:dataset id=dataset_entrust format="<fields><field><fieldname>CLIENT</fieldname><datatype>字符</datatype><displaylabel>委托单位</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ENTRUST_WAY</fieldname><datatype>字符</datatype><displaylabel>委托方式</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ENTRUST_EXPLAIN</fieldname><datatype>字符</datatype><displaylabel>委托说明</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ASCRIPTION</fieldname><datatype>字符</datatype><displaylabel>项目归属</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PROJ_TYPE</fieldname><datatype>字符</datatype><displaylabel>工程类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PROVINCE</fieldname><datatype>字符</datatype><displaylabel>省市</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_org</fieldname><datatype>字符</datatype><displaylabel>归属机构</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_orgid</fieldname><datatype>字符</datatype><displaylabel>归属机构ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DIMENSIONS</fieldname><datatype>字符</datatype><displaylabel>设计规模</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>INVESTMENT</fieldname><datatype>字符</datatype><displaylabel>总投资</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phase</fieldname><datatype>字符</datatype><displaylabel>委托阶段</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXPECT_DATE</fieldname><datatype>字符</datatype><displaylabel>完成日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OTHER_REQUEST</fieldname><datatype>字符</datatype><displaylabel>其他要求</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_type</fieldname><datatype>字符</datatype><displaylabel>委托类型</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_name</fieldname><datatype>字符</datatype><displaylabel>项目名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>add_entrust_phaseid</fieldname><datatype>字符</datatype><displaylabel>委托阶段ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_id</fieldname><datatype>字符</datatype><displaylabel>工程ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phaseid</fieldname><datatype>字符</datatype><displaylabel>撤销阶段ID</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>undo_entrust_phase</fieldname><datatype>字符</datatype><displaylabel>撤销阶段</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_id</fieldname><datatype>字符</datatype><displaylabel>设计编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_name</fieldname><datatype>字符</datatype><displaylabel>客户项目名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_id</fieldname><datatype>字符</datatype><displaylabel>客户项目编号</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>profession_property</fieldname><datatype>字符</datatype><displaylabel>专业属性</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_org</fieldname><datatype>字符</datatype><displaylabel>负责机构</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_orgid</fieldname><datatype>字符</datatype><displaylabel>负责机构ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>input_date</fieldname><datatype>字符</datatype><displaylabel>临时填表日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><CLIENT></CLIENT><ENTRUST_WAY></ENTRUST_WAY><ENTRUST_EXPLAIN></ENTRUST_EXPLAIN><ASCRIPTION></ASCRIPTION><PROJ_TYPE></PROJ_TYPE><PROVINCE></PROVINCE><belong_org></belong_org><belong_orgid></belong_orgid><DIMENSIONS></DIMENSIONS><INVESTMENT></INVESTMENT><add_entrust_phase></add_entrust_phase><EXPECT_DATE></EXPECT_DATE><OTHER_REQUEST></OTHER_REQUEST><entrust_type></entrust_type><proj_name></proj_name><add_entrust_phaseid></add_entrust_phaseid><proj_id></proj_id><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><design_id></design_id><custom_proj_name></custom_proj_name><custom_proj_id></custom_proj_id><profession_property></profession_property><responsible_org></responsible_org><responsible_orgid></responsible_orgid><input_date></input_date></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CLIENT></CLIENT><ENTRUST_WAY></ENTRUST_WAY><ENTRUST_EXPLAIN></ENTRUST_EXPLAIN><ASCRIPTION></ASCRIPTION><PROJ_TYPE></PROJ_TYPE><PROVINCE></PROVINCE><belong_org></belong_org><belong_orgid></belong_orgid><DIMENSIONS></DIMENSIONS><INVESTMENT></INVESTMENT><add_entrust_phase></add_entrust_phase><EXPECT_DATE></EXPECT_DATE><OTHER_REQUEST></OTHER_REQUEST><entrust_type></entrust_type><proj_name></proj_name><add_entrust_phaseid></add_entrust_phaseid><proj_id></proj_id><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><design_id></design_id><custom_proj_name></custom_proj_name><custom_proj_id></custom_proj_id><profession_property></profession_property><responsible_org></responsible_org><responsible_orgid></responsible_orgid><input_date></input_date></dsid>")' onValid='bill_ondatasetvalid("<dsid><CLIENT></CLIENT><ENTRUST_WAY></ENTRUST_WAY><ENTRUST_EXPLAIN></ENTRUST_EXPLAIN><ASCRIPTION></ASCRIPTION><PROJ_TYPE></PROJ_TYPE><PROVINCE></PROVINCE><belong_org></belong_org><belong_orgid></belong_orgid><DIMENSIONS></DIMENSIONS><INVESTMENT></INVESTMENT><add_entrust_phase></add_entrust_phase><EXPECT_DATE></EXPECT_DATE><OTHER_REQUEST></OTHER_REQUEST><entrust_type></entrust_type><proj_name></proj_name><add_entrust_phaseid></add_entrust_phaseid><proj_id></proj_id><undo_entrust_phaseid></undo_entrust_phaseid><undo_entrust_phase></undo_entrust_phase><design_id></design_id><custom_proj_name></custom_proj_name><custom_proj_id></custom_proj_id><profession_property></profession_property><responsible_org></responsible_org><responsible_orgid></responsible_orgid><input_date></input_date></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset>
      <fc:dataset id=item_dataset format="<fields><field><fieldname>item_id</fieldname><datatype>整数</datatype><displaylabel>单项主键</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>num</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>5%25</columnWidth2></columnWidth1></field><field><fieldname>item_name</fieldname><datatype>字符</datatype><displaylabel>单项名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>负责处</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>admin_name</fieldname><datatype>字符</datatype><displaylabel>负责人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>reviewers_name</fieldname><datatype>字符</datatype><displaylabel>审核人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>user_name</fieldname><datatype>字符</datatype><displaylabel>参加人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>45%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name></dsid>")' opensortno="4" temptable="TMP_DATASET3" multiResult="是"></fc:dataset>
      <fc:dataset id=dataset_taskt format="<fields><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>主体部门</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>字符</datatype><displaylabel>主体部门ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>joindept_name</fieldname><datatype>字符</datatype><displaylabel>参与部门</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>joindept_id</fieldname><datatype>字符</datatype><displaylabel>参与部门ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasesid</fieldname><datatype>字符</datatype><displaylabel>设计阶段ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phases</fieldname><datatype>字符</datatype><displaylabel>设计阶段名称</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><proj_level></proj_level><dept_name></dept_name><dept_id></dept_id><joindept_name></joindept_name><joindept_id></joindept_id><design_phasesid></design_phasesid><design_phases></design_phases></dsid>")' onGetText='bill_ondatasetgettext("<dsid><proj_level></proj_level><dept_name></dept_name><dept_id></dept_id><joindept_name></joindept_name><joindept_id></joindept_id><design_phasesid></design_phasesid><design_phases></design_phases></dsid>")' onValid='bill_ondatasetvalid("<dsid><proj_level></proj_level><dept_name></dept_name><dept_id></dept_id><joindept_name></joindept_name><joindept_id></joindept_id><design_phasesid></design_phasesid><design_phases></design_phases></dsid>")' opensortno="2" temptable="TMP_DA" multiResult="是"></fc:dataset>
      <fc:dataset id=modify_dataset format="<fields><field><fieldname>proj_name</fieldname><datatype>字符</datatype><displaylabel>工程名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>request_explain</fieldname><datatype>字符</datatype><displaylabel>要求是否明确</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ablity_explain</fieldname><datatype>字符</datatype><displaylabel>是否有能力满足</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue>是</defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>agress_explain</fieldname><datatype>字符</datatype><displaylabel>理解达成共识</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other</fieldname><datatype>字符</datatype><displaylabel>其他</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_explain</fieldname><datatype>字符</datatype><displaylabel>其他要求解释</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>appraisal_measure</fieldname><datatype>字符</datatype><displaylabel>措施</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>appraisal_result</fieldname><datatype>字符</datatype><displaylabel>评审结论</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_id</fieldname><datatype>字符</datatype><displaylabel>工程ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mc_oid</fieldname><datatype>字符</datatype><displaylabel>任务下达</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ascription</fieldname><datatype>字符</datatype><displaylabel>归属</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_type</fieldname><datatype>字符</datatype><displaylabel>工程类型</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>province</fieldname><datatype>字符</datatype><displaylabel>省市</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_orgid</fieldname><datatype>字符</datatype><displaylabel>归属机构id</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer</fieldname><datatype>字符</datatype><displaylabel>申请者</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>字符</datatype><displaylabel>机构</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>client_request</fieldname><datatype>字符</datatype><displaylabel>客户要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>agress</fieldname><datatype>字符</datatype><displaylabel>同意</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ablity</fieldname><datatype>字符</datatype><displaylabel>能力</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_request</fieldname><datatype>字符</datatype><displaylabel>其他要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>input_date</fieldname><datatype>字符</datatype><displaylabel>填表日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><proj_name></proj_name><request_explain></request_explain><ablity_explain></ablity_explain><agress_explain></agress_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><appraisal_result></appraisal_result><proj_id></proj_id><mc_oid></mc_oid><ascription></ascription><proj_type></proj_type><province></province><belong_orgid></belong_orgid><inputer></inputer><org_name></org_name><client_request></client_request><agress></agress><ablity></ablity><other_request></other_request><input_date></input_date></dsid>")' onGetText='bill_ondatasetgettext("<dsid><proj_name></proj_name><request_explain></request_explain><ablity_explain></ablity_explain><agress_explain></agress_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><appraisal_result></appraisal_result><proj_id></proj_id><mc_oid></mc_oid><ascription></ascription><proj_type></proj_type><province></province><belong_orgid></belong_orgid><inputer></inputer><org_name></org_name><client_request></client_request><agress></agress><ablity></ablity><other_request></other_request><input_date></input_date></dsid>")' onValid='bill_ondatasetvalid("<dsid><proj_name></proj_name><request_explain></request_explain><ablity_explain></ablity_explain><agress_explain></agress_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><appraisal_result></appraisal_result><proj_id></proj_id><mc_oid></mc_oid><ascription></ascription><proj_type></proj_type><province></province><belong_orgid></belong_orgid><inputer></inputer><org_name></org_name><client_request></client_request><agress></agress><ablity></ablity><other_request></other_request><input_date></input_date></dsid>")' opensortno="5" temptable="TMP_DATASET5" multiResult="是"></fc:dataset>
      <fc:dataset id=approval_phase_dataset format="<fields><field><fieldname>oid</fieldname><datatype>字符</datatype><displaylabel>阶段ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasename</fieldname><datatype>字符</datatype><displaylabel>阶段名称</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target></target><href>javascript:viewPhaseInfo()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>13%25</columnWidth2></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>7%25</columnWidth2></columnWidth1></field><field><fieldname>m_deptname</fieldname><datatype>字符</datatype><displaylabel>主体处</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>duty_person</fieldname><datatype>字符</datatype><displaylabel>总负责人</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40%25</columnWidth2></columnWidth1></field><field><fieldname>institute_director</fieldname><datatype>字符</datatype><displaylabel>院主管</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>investment</fieldname><datatype>字符</datatype><displaylabel>投资规模</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>cc_form_instanceid</fieldname><datatype>字符</datatype><displaylabel>流程业务ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' opensortno="6" temptable="TMP_DATASET6" multiResult="是"></fc:dataset>
      <fc:dataset id=duty_dataset format="<fields><field><fieldname>orderno</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>duty_type_name</fieldname><datatype>字符</datatype><displaylabel>负责人类型</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>30%25</columnWidth2></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>字符</datatype><displaylabel>单位</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>30%25</columnWidth2></columnWidth1></field><field><fieldname>user_realname</fieldname><datatype>字符</datatype><displaylabel>总负责人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>30%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><orderno></orderno><duty_type_name></duty_type_name><org_name></org_name><user_realname></user_realname></dsid>")' onGetText='bill_ondatasetgettext("<dsid><orderno></orderno><duty_type_name></duty_type_name><org_name></org_name><user_realname></user_realname></dsid>")' onValid='bill_ondatasetvalid("<dsid><orderno></orderno><duty_type_name></duty_type_name><org_name></org_name><user_realname></user_realname></dsid>")' opensortno="3" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
      <INPUT id=workflow_ctrl style="LEFT: 298px; WIDTH: 110px; POSITION: static; TOP: 61px; HEIGHT: 20px" onmovestart=moveStart() value=无 controltype="text">
      <INPUT id=proj_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text">
      <INPUT id=approval_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text">
      <DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 10px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 143px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 259px; HEIGHT: 85px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：
         <INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 129px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=21 controltype="text">
         <INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text">
         <BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addAndUser();")'>与分支选执行人</BUTTON>
      </DIV>
      <DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 10px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 351px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
         <BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)">暂存</BUTTON>
      </DIV>
      <DIV id=workflowControl_back style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; LEFT: 142px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 81px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 85px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
         <BUTTON class=button1 id=button_ht style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('回退',false,true,'../../../common_workflow/main.jsp')&quot;)">回退</BUTTON>
      </DIV>
      <DIV id=workflowControl_backToPrior style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 84px; BORDER-BOTTOM: black 1px solid; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
         <INPUT id=workflowControl_result style="DISPLAY: block; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text">
      </DIV>
      <DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; DISPLAY: none; FONT-SIZE: 12px; LEFT: 13px; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 197px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 404px; HEIGHT: 24px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">请选择活动：
         <SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 114px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor()")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT>
      </DIV>
   </DIV>
</DIV>
<div id='grid_tip'></div></body></html>
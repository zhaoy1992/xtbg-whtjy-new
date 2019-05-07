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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/approval_ideal.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/approval_ideal.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/project_pub.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/project_pub.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js//userjs/project/entrust_startwf.js');");
if(bDgMode) out.println("<script src='../../fceform/js//userjs/project/entrust_startwf.js'></script>");
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
<%@ page import="org.frameworkset.spi.BaseSPIManager,com.chinacreator.commonworkflow.dao.CommonWorkflowDao"%>
<%
    String opType=request.getParameter("opType");//操作类型,主要用于查看.
    String act_oid=request.getParameter("oid");
    String wflag = "";
    if(!"view".equals(opType)){
    if(act_oid.equals("setitem_wp1_act2")){
        CommonWorkflowDao dao = (CommonWorkflowDao)BaseSPIManager.getProvider("commonWorkflowDao");
        String actInsId = request.getParameter("actInsId");
        String curActExcutor = dao.getResourceIdByActInsId(actInsId);//是当前活动实例还没有执行的用户逗号隔开
         String userAccount = accesscontroler.getUserAccount();
        if(curActExcutor.equals(userAccount)){
            wflag = "final";
        }
      }
    }
%>
//当前登录用户的信息
var org_Id=getSysElement("userorgid");  
var orgId="";
var bz=SqlToField("select f_getSecondRemark4('"+org_Id+"') from dual");
  if((bz!="zongbu"&&bz!="zhengzhou")&&bz!=""){//处理分公司的情况
     orgId=SqlToField("select t.org_id from td_sm_organization t where t.remark4='"+bz+"'");
  }else{
   orgId=org_Id;
  }     
var orgName=getSysElement("userOrgName");   
var userId=getSysElement("userId");         
var userName=getSysElement("userName"); 
var cc_form_instanceid = creator_getQueryString("cc_form_instanceid");
//alert(cc_form_instanceid);
var approval_id = SqlToField("select t.approval_id from ta_project_approval t where t.cc_form_instanceid='" +cc_form_instanceid + "'");
var phase_oid=SqlToField("select wmsys.wm_concat(oid) from ta_project_approval_phase t where t.approval_id='" 
            + approval_id + "' order by design_phaseid"); //阶段ID         
var phase_id = phase_oid.split(",");//将阶段信息放入到数组中。
var actName = ""; //本环节的名称
var oid = creator_getQueryString("oid"); //环节定义ID
var code="";//根据环节定义ID，返回不同的代码，更具代码控制界面的显示。
var entrust_type="";//根据此字段来判断是新项目立项，还是阶段新增和修改
var proj_level="1";

//初始化函数
function init(){
if("<%=opType%>"!="view"){ //查看时不执行此段代码，减少请求，提高效率
 actName = creator_getActName();
 $("curact").innerText="当前环节："+actName;
}
initByActId();
initDate();
init_item_list();
initOptionList();
}

//数据展示
function initDate(){
 var sql=" select b.proj_name,b.ascription,b.proj_type,b.province,b.belong_org,b.belong_orgid,b.proj_id,b.design_id,b.responsible_org,a.mc_oid,a.task_id,"
       +" a.inputer,a.org_name,a.client,a.entrust_type, a.entrust_way,a.entrust_explain,b.professional_property,b.custom_proj_id,b.custom_proj_name,to_char(b.created_date,'yyyy-mm-dd') as input_date,"     
       +" a.dimensions,a.investment,a.expect_date,a.entrust_phase,a.proj_level,a.other_request,c.client_request,c.agress,c.ablity,c.other_request as c_other_request,"
       +" c.request_explain,c.agress_explain,c.ablity_explain,c.other, c.other_explain,c.appraisal_measure,c.appraisal_result"
       +" from ta_project_approval a,ta_project_basic_info b, ta_project_appraisal c"
       +" where a.proj_id=b.proj_id and a.approval_id=c.link_id"
       +" and a.approval_id='" + approval_id + "'";
     //alert(sql);
 approv_dataset.Open(sql);
 entrust_type = approv_dataset.Fields.Field['entrust_type'].Value;
 proj_level = approv_dataset.Fields.Field['proj_level'].Value;
 //设计阶段新增相关设置
 if(entrust_type=="phase_new"||entrust_type=="phase_update"){ 
  $("text4").value = approv_dataset.Fields.Field['design_id'].Value;
  $("button1").style.display="none";//只有在新项目立项时才编号，新增和修改已经有编号了，不再立项
  $("phase_td1").style.display="";
  $("phase_td2").style.display="";
   initPhaseInfo(approv_dataset.Fields.Field['proj_id'].Value);
   $("show_info").innerText="新增阶段";
 }
 if(proj_level=="1"&&(code==3||code==5)){
  $("dept_text").style.display="none";
  $("dept_td").style.display="none";
 }
var tep_sql=" select wmsys.wm_concat(distinct(u.design_phasename)),wmsys.wm_concat(distinct(u.m_deptname))"
            +" from ta_project_approval_phase u where u.approval_id='"+ approval_id +"'";          
      var teparray=executeSelect(tep_sql,1,1);
      $("phasename").innerText=teparray[0][0];
      $("main_dept").value = teparray[0][1];
      var join_dept_sql=" select wmsys.wm_concat(tt.dept_name) from ((select distinct(w.dept_name) as dept_name  from TA_PROJECT_ITEM  w where w.item_id in("
                        +" select distinct(t.item_id) from ta_project_item_phase t where t.approval_id='"+ approval_id+"'))"
                        +" minus (select distinct(a.join_deptname) as dept_name  from TA_PROJECT_JOINDEPT a where a.phase_oid in"
                        +" (select b.oid from ta_project_approval_phase b where b.approval_id='"+approval_id+"') and a.joindept_type='2'))tt";
      var join_dept_value = SqlToField(join_dept_sql);         
      $("join_dept_name").value = join_dept_value=='null' ? "":join_dept_value;
      $("join_dept").innerText = join_dept_value=='null' ? "":join_dept_value;
      getDutyPerson(); //获取此次立项的负责人，在相应区域展示     
     //获取处主管        
     var joindept_sql="select '处主管为：'||wmsys.wm_concat(t.dept_director|| '(' || t.join_deptname || ')') from ta_project_joindept t where t.dept_director is not null and t.phase_oid='"+phase_id[0]+"'"; 
     //alert(joindept_sql);
     $("joindept").innerText=SqlToField(joindept_sql);  
    //获取院主管
     var main_leader = SqlToField("select t.institute_director from  ta_project_approval_phase t where t.oid='"+ phase_id[0] +"'");
     $("text5").value = main_leader=='null' ? "":main_leader;
}
//初始化项目的相关负责人
function getDutyPerson(){
var duty_person_sql=" select decode(t.duty_type,'01', '第一总负责人为：','02','第二总负责人为：',"
                 +" '03','第三总负责人为：','00','项目负责人为：') || t.user_realname||'('||t.org_name||')'  as duty_person,t.duty_type "
                 +" from TA_PROJECT_DUTY_PERSON t where t.phase_oid = '"+phase_id[0] 
                 +"' order by duty_type";
      var duty_array = executeSelect(duty_person_sql,1,3);
   if(duty_array.length!="0"){
      if(duty_array[0][1]=="00"){
          $("duty_person").innerText="项目负责人";
      }else{
          $("duty_person").innerText="总负责人";
      }
      for(var i=0;i<3;i++){
        $("td"+i).style.display="none";
        $("td"+i).innerText="";
      }
      for(var i=0;i<duty_array.length;i++){
        $("td"+i).style.display="";
        $("td"+i).innerText=" "+duty_array[i][0];
      }
    }  
}
//修改项目负责人
function modifyUser(){
  var temp=fcpubdata.cc_form_instanceid;
   fcpubdata.cc_form_instanceid=""; 
   var m_oid= SqlToField("select a.mc_oid from ta_project_approval a where a.approval_id='"+approval_id+"'");
  var url = "20100520091505125743.jsp?approval_id="+approval_id+"&m_oid="+m_oid;
  var swidth = 650;
  var sheight = 400;
  showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
 fcpubdata.cc_form_instanceid=temp;
 getDutyPerson();
 
}

//初始化单项
function init_item_list(){
   var item_List_Sql="select rownum as num,a.item_id,a.item_name,a.dept_id,a.dept_name,c.admin_name,c.reviewers_name,c.user_name"
                  +" from TA_PROJECT_ITEM a,TA_PROJECT_ITEM_PHASE b,TA_PROJECT_ITEM_JOIN_PEOPLE c "
                  +" where a.item_id=b.item_id and b.oid=c.phase_oid  and b.phase_oid='"+phase_id[0]+"'";                
item_dataset.Open(item_List_Sql);
crtlItemList();
}

//初始化意见列表
function initOptionList(){
 var option_sql=" select t.ideal_id,t.ideal_peoplename,t.ideal_departname,t.ideal_result,t.ideal_conten,'查看' as detail,"
              +" t.action_name,to_char(t.ideal_date,'yyyy-mm-dd hh24:mi')ideal_date from ta_project_approval_opinion t  where t.businessid='"+approval_id
              +"' order by t.ideal_date";
             // alert(option_sql);
    option_dataset.Open(option_sql);          
}

//控制单项列表，本部门的可以编辑，其他部门不可
function crtlItemList(){
if(code!=0 && code!=1){return false;}
if(item_dataset.PageNo==1){item_dataset.FirstPage();}
if(item_dataset.PageNo==item_dataset.PageCount){item_dataset.LastPage();}
var grid = document.getElementById("grid2");
var trObjArray=grid.getElementsByTagName("table")[0].getElementsByTagName("tr");
  var item_dept_id="";//负责处ID
  var item_id=""; 
   for(var i=1;i<trObjArray.length;i++){
    item_dept_id = item_dataset.Fields.Field["dept_id"].Value;
    item_id = item_dataset.Fields.Field["item_id"].Value;
    var tdObjArrays=trObjArray[i].getElementsByTagName("td");
     if(item_dept_id==orgId){
          tdObjArrays[7].vAlign="top";
         // tdObjArrays[7].innerHTML="<INPUT TYPE=\"button\" VALUE=\" 编辑 \" class=\"button_nor\" ONCLICK=\"doEdit(\'"+item_id+"\')\">";
         tdObjArrays[7].innerHTML=" <a href=\"javascript:doEdit('"+ item_id +"');\">&nbsp;编&nbsp;辑</a>"
       }else{
           tdObjArrays[7].innerHTML="";
      }
        item_dataset.MoveNext();
    }
}

//编辑本单位单项
function doEdit(item_id){
  var url=getOpenUrlByDjid("20100520142627890849")+"&item_id="+item_id+"&flag=sp&proj_id="+approv_dataset.Fields.Field['proj_id'].Value;
  var swidth = 780;
  var sheight = 300;
  showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
  init_item_list();
}

/*
** 完成活动操作,在此方法中加入业务处理，然后调用平台的完成活动的方法
** creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp')
*/
function doComplete(){
if(code!=6){
    var agree_result=$("is_agree").value;//审批结论
    var duty_personId = $("dept_manager").value;
    var duty_person = $("dept_manager").options[$("dept_manager").selectedIndex].text;
    var option_content = trim($("option").value);
    var dept_sql="";
    if(code==0){
        if(duty_personId=="00"){
          alert("请选择处主管");return ;
        }else if(duty_personId==userId){
          alert("不能指定自己为处主管！");return false;
        } 
           
       dept_sql="<no>"+" update ta_project_joindept c set c.dept_directorid='"+ duty_personId +"',c.dept_director='"+duty_person+"'"
                +" where c.join_deptid='"+orgId+"' and c.phase_oid in ("+ phase_id +")"+"</no> ";
       if("final"=="<%=wflag%>"){
         var main_person=SqlToField("select t.main_dept_leader from ta_project_approval t where t.approval_id='"+approval_id+"'");
         if(IsSpace(main_person)){alert("主体处领导为空！");return;}
         $("DYNAMICPERFORMER").value = main_person;
       }
    }
    if(code==1){
      if(agree_result=="同意"){
         if(duty_personId=="00"){alert("请选择处主管");return ; }
         if(duty_personId==userId){alert("不能指定自己为处主管！");return false;}       
         if($("DYNAMICPERFORMER_NAME").value==""){alert("请选择审批领导！");return;}    
         dept_sql="<no>"+" update ta_project_joindept c set c.dept_directorid='"+ duty_personId +"',c.dept_director='"+duty_person+"'"
                +" where c.join_deptid='"+orgId+"' and c.joindept_type='2' and c.phase_oid in ("+ phase_id +")"+"</no> ";
      }
    }
    if(code==2 || code==4){
         if($("DYNAMICPERFORMER_NAME").value==""){alert("请选择审批领导！");return;}
    }
   if(code==5||code==3){ //公司领导处理逻辑
       if((agree_result=="同意" && code==5) || code==3){
         if(code==3&&IsSpace($("DYNAMICPERFORMER").value)){alert("请选择总部市场部领导！");return false;}
         var manage_type=$("radio5").value;
         if(proj_level!=manage_type){//当管理级别有变化时更新
            dept_sql="<no>"+" update ta_project_approval a set a.proj_level='"+manage_type+"' where a.approval_id='" + approval_id + "'" +"</no>" ; 
          dept_sql += "<no>"+" update ta_project_approval_phase p set p.proj_level='"+manage_type+"' where p.approval_id='" + approval_id + "'" +"</no>" ; 
         }
        if(manage_type=="0"){ //级别为院管时
          if(duty_personId=="00"){alert("请选择院主管");return false;}
           if(duty_personId==userId) {alert("不能选择自己为院主管");return false;}
           dept_sql +="<no>"+" update ta_project_approval_phase t set t.institute_directorid='"+duty_personId+"',t.institute_director='"+duty_person.split("(")[0]
                  +"' where t.approval_id='"+approval_id+"'"+"</no>";
        }else{ //级别为处管
           dept_sql +="<no>"+" update ta_project_approval_phase t set t.institute_directorid='',t.institute_director='' where t.approval_id='"+approval_id+"'"+"</no>"; 
        } 
        $("spworkflow_ctrl").value="同意";
     }else{      
        $("spworkflow_ctrl").value="不同意";
     }
   }
    
    if(option_content==""||option_content.length==0){
     //if(!confirm("确定不输入审批意见吗？")){return;}
    }else{
      if(option_content.byteLength()>=400){alert("超过限制大小！");return false;}
    }
    var ideal_id = getNewCc_form_instanceid(false);
    var option_sql="<no>"+"insert into ta_project_approval_opinion t (t.ideal_id,t.ideal_peopleid,t.ideal_peoplename,"
                   +" t.ideal_departid,t.ideal_departname,t.ideal_result,t.ideal_conten,t.ideal_date,"
                   +"t.businessid,t.action_defid,t.action_name)   values('"+ideal_id+"','"+userId+"','"+userName
                   +"','"+orgId+"','"+orgName+"','"+agree_result+"','"+option_content
                   +"',sysdate,'"+approval_id+"','"+oid+"','"+actName+"')"+"</no>";
    sql=dept_sql+option_sql; 
    if(!confirm("确定要提交吗？")){return false;}
    var msg=creator_inserts(sql); 
    if(IsSpace(msg)){
      //alert("插入成功！");
      creator_djsave('完成活动',false,true,'');
      history.go(-1);
    }else{
     alert("插入失败！"+msg);
    }
}else{ 
   var design_id = trim($("text4").value);
   var design_sql="";
   if(entrust_type=="project_new"){ 
   if(design_id==""||design_id.length==0){
    alert("请设计编号"); return ;
   }
   var is_exist_sql=" select count(*) from ta_project_basic_info t where t.design_id="+design_id;
    if(SqlToField(is_exist_sql)!=0){alert("此编号已存在,请重新设计编号");return false;} 
   design_sql+= " <no>"+"update ta_project_basic_info a set a.design_id='" + design_id 
           + "',a.approval_date=sysdate where a.proj_id in(select b.proj_id from ta_project_approval b  where b.approval_id='" + approval_id +"')"+"</no>";
  }
       design_sql += "<no>"+" update ta_project_approval_phase t set t.design_id='" + design_id + "' where t.approval_id='"+approval_id+"'"+"</no>";
       design_sql += " <no>"+"update ta_project_approval b set b.is_pass='是',b.status='办结',b.design_id='" + design_id
                    +"' where b.approval_id='"+ approval_id +"'"+"</no>";
       //处理立项通过回填任务管理相关信息
    if(entrust_type=="project_new"){
        var proj_id=approv_dataset.Fields.Field['proj_id'].Value;
        var proj_name=approv_dataset.Fields.Field['proj_name'].Value;
       design_sql +="<no> update ta_project_task_record t set t.proj_id='"+proj_id+"',t.proj_name='"+proj_name+"',t.design_id='"+design_id +"',t.entrust_status='7',"
                 +" t.approval_date=sysdate,t.finish_date=sysdate where t.oid=(select a.task_id from ta_project_approval a where a.approval_id='"+ approval_id +"') </no>" ;
       design_sql +="<no> update ta_project_task_record t set t.proj_id='"+proj_id+"',t.proj_name='"+proj_name+"',t.design_id='"+design_id +"',t.entrust_status='2',"
                 +" t.approval_date=sysdate where t.parent_id=(select a.task_id from ta_project_approval a where a.approval_id='"+ approval_id +"') </no>" ;          
    } else{
     design_sql +="<no> update ta_project_task_record t set t.entrust_status='7',t.approval_date=sysdate,t.finish_date=sysdate "
                 +" where t.oid=(select a.task_id from ta_project_approval a where a.approval_id='"+ approval_id +"') </no>" ;
     design_sql +="<no> update ta_project_task_record t set t.entrust_status='2',t.approval_date=sysdate"
                 +" where t.parent_id=(select a.task_id from ta_project_approval a where a.approval_id='"+ approval_id +"') </no>" ;   
    }                           
   if(!confirm("确定要提交吗？")){return false;}
   var msg=InsertSqls(design_sql);
   if(IsSpace(msg)){
      var task_id=approv_dataset.Fields.Field['task_id'].Value;
        f_startWf(task_id);
       creator_djsave('完成活动',false,true,''); 
        history.go(-1); 
   }else{
    alert("失败"+msg);
   }
 }
}

/*
** 回退活动操作,在此方法中加入业务处理，然后调用平台的回退的方法
** creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp')
*/
function doBack(){
var option_content = trim($("option").value);
 var ideal_id = getNewCc_form_instanceid(false);
  if(option_content==""||option_content.length==0){
    if(!confirm("确定不输入审批意见吗？")){return;}
    }
 var sql="<no>"+"insert into ta_project_approval_opinion t (t.ideal_id,t.ideal_peopleid,t.ideal_peoplename,"
                   +" t.ideal_departid,t.ideal_departname,t.ideal_result,t.ideal_conten,t.ideal_date,"
                   +"t.businessid,t.action_defid,t.action_name)   values('"+ideal_id+"','"+userId+"','"+userName
                   +"','"+orgId+"','"+orgName+"','不同意','"+option_content
                   +"',sysdate,'"+approval_id+"','"+oid+"','"+actName+"')"+"</no>";
  if(!confirm("确定要提交吗？")){return false;}
  var msg=InsertSqls(sql);
    if(IsSpace(msg)){
      //alert("插入成功！");
      creator_djsave('回退',false,true,''); 
       history.go(-1);   
      }else{
     alert("插入失败！"+msg);
    }
}

/*
**根据流程中不同的环节控制界面的展现
**
*/
function initByActId(){
 code=getCodeByOid(); 
 if(code==0 || code==1){
    var userList_sql=" select u.user_id,u.user_realname from td_sm_user u,td_sm_orguser w,td_sm_role r,td_sm_userrole ur "
                 +" where  u.user_id=w.user_id and u.user_id=ur.user_id and ur.role_id=r.role_id and r.role_name='部门处主管' and ";
        if((bz!="zongbu"&&bz!="zhengzhou")&&bz!=""){
             userList_sql+=" f_getSecondOrgId(w.org_id)";
         }else{
             userList_sql+="w.org_id";
         }
      userList_sql+= "='"+orgId+"' order by u.user_sn,u.user_name";
    SqlCombo($("dept_manager"),userList_sql);//初始化选择的处主管 
    //选中已经存在的处主管，回退过来用的
      var exist_dept_sql=" select distinct(b.dept_directorid) from ta_project_joindept b where b.join_deptid='"+orgId+"' and b.phase_oid in "
                   +" (select p.oid from ta_project_approval_phase p where p.approval_id = '"+approval_id+"')";
      var exist_dept = SqlToField(exist_dept_sql); 
      if(IsSpace(exist_dept)){exist_dept="00";}    
      $("dept_manager").value = exist_dept; //选中已设置的处主管
      userList_sql=" select u.user_name,u.user_realname from td_sm_user u,td_sm_orguser w,td_sm_role r,td_sm_userrole ur "
                 +" where  u.user_id=w.user_id and u.user_id=ur.user_id and ur.role_id=r.role_id and ";
        if((bz!="zongbu"&&bz!="zhengzhou")&&bz!=""){
             userList_sql+=" r.role_name='分公司领导' and  f_getSecondOrgId(w.org_id)";
         }else{
             userList_sql+=" r.role_name='部门领导' and w.org_id";
         }
      userList_sql+= "='"+orgId+"' order by u.user_sn,u.user_name";
      SqlCombo($("turnleader"),userList_sql); //初始化转发的领导
 }
if(code==0){
 $("sp_result").style.display="none";
 $("oper_type").style.display="";     
 $("turn_oper").setAttribute("colSpan", "3");
 $("next_user").style.display="none";
 $("next_user_per").style.display="none";
 $("dept_td").setAttribute("colSpan", "3");
 }
if(code==1){
      $("workflowControl_back").style.display="none";
      $("workflowControl_selectAct_div").style.display="none";
      $("oper_type").style.display="";     
      $("turn_oper").setAttribute("colSpan", "3");
      $("sp_result2").setAttribute("colSpan", "3");     
      isZFDept();
     setNextUser();    
  }
if(code==2 || code==4){
     $("sp_result").style.display="none";
     $("workflowControl_back").style.display="none";
     $("dept_text").style.display="none";
     $("dept_td").style.display="none";
     if(code==2){
       $("next_user").innerText="选择郑分领导审批";
     }else{
       $("next_user").innerText="选择公司领导审批";
     }
    $("next_user_per").setAttribute("colSpan", "3");   
} 
if(code==3){
   $("button2").style.display=""; //显示修改负责人按钮
   $("sp_result").style.display="";
   $("sp_result1").style.display="none";
   $("sp_result2").style.display="none";
   $("mange_type1").style.display="";
   $("mange_type2").style.display="";
   $("mange_type2").setAttribute("colSpan", "3");
   $("workflowControl_back").style.display="none";
   $("dept_manager").style.display="";
   $("dept_text").innerText="选择院主管";
   $("next_user").innerText="选择总部市场部领导审批";
   var leader=SqlToField("select t.institute_directorid from  ta_project_approval_phase t where t.oid='"+ phase_id[0] +"'");
   if(IsSpace(leader)){leader="00";}
   var userList_sql=" select u.user_id, u.user_realname from td_sm_user u, td_sm_userrole ur, td_sm_role r,td_sm_orguser ou "
                 +"  where f_getSecondRemark4(ou.org_id) ='zhengzhou' and u.user_id = ur.user_id and u.user_id=ou.user_id and r.role_id = ur.role_id and r.role_name = '分公司领导'";
    SqlCombo($("dept_manager"),userList_sql); 
    $("dept_manager").value = leader;
} 
if(code==5){
 $("button2").style.display=""; //显示修改负责人按钮
 $("workflowControl_back").style.display="none";
 $("sp_result").style.display=""; 
 $("mange_type1").style.display="";
 $("mange_type2").style.display="";
 $("next_user").style.display="none";
 $("next_user_per").style.display="none";
 $("dept_text").innerText="选择院主管";
 $("dept_td").setAttribute("colSpan","3");
 var leader=SqlToField("select t.institute_directorid from  ta_project_approval_phase t where t.oid='"+ phase_id[0] +"'");
 if(IsSpace(leader)){leader="00";}
  var userList_sql=" select aa.user_id,aa.user_realname from ( select u.user_id,u.user_realname||'(总部)' as user_realname, '1' as org_id,u.user_sn from td_sm_user u, td_sm_userrole ur, td_sm_role r "
                 +"  where u.user_id = ur.user_id and r.role_id = ur.role_id and r.role_name = '公司领导'"
                 +" union all select u.user_id,u.user_realname||'(郑分)' as user_realname,'2' as org_id,u.user_sn from td_sm_user u, td_sm_userrole ur, td_sm_role r,td_sm_orguser ou"
                 +" where f_getSecondRemark4(ou.org_id) ='zhengzhou'  and u.user_id=ou.user_id and u.user_id = ur.user_id and r.role_id = ur.role_id and r.role_name = '分公司领导')aa order by aa.org_id,aa.user_sn";              
    SqlCombo($("dept_manager"),userList_sql); 
    $("dept_manager").value = leader; 
} 
if(code==6){
   $("workflowControl_back").style.display="none";
   $("button1").style.display="";
   $("design_table").style.display="none";
 }
 //用户查看立项信息
 if("view"=="<%=opType%>"){
    $("workflowControl_selectAct_div").style.display="none";
    $("design_table").style.display="none";
    $("back_id").style.display="";
    $("curact").style.display="none";
    code=6;
  }else{
   setNextActName(code);//初始化下一环节
  }
}

/*
***当同意时，设定下一个环节的执行人
*/
function setNextUser(){
  if(isflag=="有"){
    $("spworkflow_ctrl").value="有";
    $("workflowControl_selectAct").value="setitem_wp1_act5";
    $("next_user").innerText="选择郑分技市领导";
    changeSelectActor();
  }else{
     $("spworkflow_ctrl").value="无";
     $("workflowControl_selectAct").value="setitem_wp1_act7";
     $("next_user").innerText="选择总部市场部领导";
     changeSelectActor();
  }  
}

var isflag="无"; 
/**
***判断是否有郑分部门参加
**/
function isZFDept(){
if(trim(approval_id)==""){approval_id="'";}
var join_dept_sql="  select distinct(d.join_deptid) from ta_project_joindept d  where d.phase_oid in("
                + " select t.oid from ta_project_approval_phase t where t.approval_id='"+approval_id+"')";
var join_dept=executeSelect(join_dept_sql,1,1000);
var remark="";
for(var i=0;i<join_dept.length;i++){//判断参与处和主体处中是否有郑分部门
    remark=SqlToField(" select remark4 from td_sm_organization t where t.org_id=F_getsecondorgid('"+join_dept[i][0]+"')");
   if(remark=="zhengzhou"){
       isflag="有";
       $("spworkflow_ctrl").value="有";
       break;
    }
   }
}

/*
**根据当前环节ID 返回一个控制一个界面控制代码0-5或空值
*/
function getCodeByOid(){
    var act_type= new Array();
    act_type.push("setitem_wp1_act2");//参与处领导审批0
    act_type.push("setitem_wp1_act3");//主体处领导审批 1
    act_type.push( "setitem_wp1_act5"); //郑分市场部领导审批2
    act_type.push( "setitem_wp1_act6") ;// 郑分领导审批3
    act_type.push( "setitem_wp1_act7");//总部市场部领导审批4
    act_type.push( "setitem_wp1_act8");//公司主管领导审批5
    act_type.push( "setitem_wp1_act9");//设计编号6
    for(var i=0;i<act_type.length;i++){
      if(act_type[i].indexOf(oid)!=-1){
       return i;
      }
    }
    return "";
}
/*
**设置下一环节的名称
*/
function setNextActName(code){
  var nextActName="";
 switch(code)
   {
   case 0:
     nextActName="主体处领导审批";
     break;
   case 1:
     if(isflag=="无"){nextActName="总部市场部领导审批";}else{nextActName="郑分市场部领导审批";}
     break;
 case 2:
     nextActName="郑分领导审批";
     break;
case 3:
     nextActName="总部市场部领导审批";
     break;
case 4:
     nextActName="公司主管领导审批";
     break;
case 5:
     nextActName="设计编号";
     break;
case 6:
     nextActName="办结";
     break;
   default:
    nextActName="";
   }
$("nextActName").innerText="下一环节:"+nextActName;
}

//获取设计编号函数
function  getDesign_id(){
 var sql=" select to_char(sysdate, 'yyyymm') ||decode(length(code), 1, '00' || code, '2', '0' || code,code) as design_id"
         +"   from (select to_number(decode(max(substr(a.design_id, 7)), '', '0',max(substr(a.design_id, 7)))) + 1 as code from ta_project_basic_info a"
         +"  where substr(a.design_id, 1, 6) = to_char(sysdate, 'yyyymm'))";
       //  alert(sql);
 var design_id=SqlToField(sql);
 $("text4").value=design_id;
}

//初始化顾客要求评审表中领导意见
function initCustomOption(){
var sql="select t.ideal_result, t.ideal_peoplename,to_char(t.ideal_date,'yyyy-mm-dd hh24:mi')ideal_date from ta_project_approval_opinion t"
        +" where t.businessid='"+approval_id+"' order by t.ideal_date";
var count = SqlToField("select count(*) from ta_project_approval_opinion t where t.businessid='"+approval_id+"'");
var option_array=executeSelect(sql,1,count); 
var options="";
for(var i=0;i<option_array.length;i++){
 options+=option_array[i][0]+"  "+option_array[i][1]+"  "+option_array[i][2]+"\n";
}
$("leader_option").innerText=options;
}

//改变
function is_change(){
if(code==1){
   if($("is_agree").value=="不同意"){
      $("tr1").style.display="none";
      $("spworkflow_ctrl").value="不同意";
      $("workflowControl_selectAct").value="setitem_wp1_act10";
      changeSelectActor();
   }else{
     $("tr1").style.display="";
     setNextUser();
   }
}
if(code==5){
   if($("is_agree").value=="不同意"){
     $("tr1").style.display="none";
     $("mange_type1").style.display="none";
     $("mange_type2").style.display="none";
   }else{
     $("tr1").style.display="";
     $("mange_type1").style.display="";
     $("mange_type2").style.display="";
    }
}
}
//查看审核详细信息
function viewOption(){
 var iedal_id = option_dataset.Fields.Field['ideal_id'].Value;
 //alert(iedal_id);
  project_showDetailOption(iedal_id);
}

/*判断输入的字符数*/
document.onkeydown=function(){
    countChars();
}

function countChars(){
    var maxChar="400"
    var mind=document.getElementById("option").value;
    var count=(trim(mind)+"").byteLength();
    document.getElementById("charCount").innerHTML="已输入："+count+"/"+maxChar+" 字符 注：1汉字=2字符";
}
document.onkeyup= countChars;

//初始化已立项阶段的信息
function initPhaseInfo(proj_id){
 if(trim(proj_id)==""){proj_id="'";} 
 var initPhase_sql="  select t.oid,t.cc_form_instanceid,t.design_phasename,decode(t.proj_level, '0', '院管', '处管') proj_level,"
                +" t.m_deptname,t.institute_director, t.investment,p.duty_person from ta_project_approval_phase t "
                +" left join (select wmsys.wm_concat(t.user_realname) as duty_person, t.phase_oid from (select c.user_realname, c.phase_oid"
                +" from ta_project_duty_person c order by c.duty_type)t group by t.phase_oid) p on t.oid = p.phase_oid left join ta_project_design_phase d on t.design_phaseid = d.design_phaseid,ta_project_approval b"
                +" where t.design_status not in( '2','3') and t.approval_id=b.approval_id and b.is_pass='是' and t.proj_id = '"+ trim(proj_id) + "' order by d.order_number";
               //alert(initPhase_sql);
approval_phase_dataset.Open(initPhase_sql);
}
//查看已有阶段详情
function viewPhaseInfo(){
 var cc_form_instanceid = approval_phase_dataset.Fields.Field['cc_form_instanceid'].Value;
 var url="20100704171803734764.jsp?cc_form_instanceid="+cc_form_instanceid+"&opType=view";
   document.location.href=url;
}

//是否转其他领导处理
function isTurnLeader(){
 var ischeck = $("checkbox1").value;
 if(ischeck=="是"){
  $("turn_to").style.display="";
  $("workflowControl_complete").style.display="none";
  $("turn_oper").setAttribute("colSpan", "1");
  $("turn_leader1").style.display="";
  $("turn_leader2").style.display="";  
  $("sp_result").style.display="none";
  $("tr1").style.display="none";
  $("tr2").style.display="none";
  $("tr3").style.display="none";
  $("tr4").style.display="none";
 }else{
  $("turn_to").style.display="none";
  $("workflowControl_complete").style.display="";
  $("turn_oper").setAttribute("colSpan", "3");
  $("turn_leader1").style.display="none";
  $("turn_leader2").style.display="none";
  if(code!=0){  
   $("sp_result").style.display="";
  }
  $("tr1").style.display="";
  $("tr2").style.display="";
  $("tr3").style.display="";
  $("tr4").style.display="";
 }
}

//转发其他领导处理
function turn_other(){
   var other_personname = $("turnleader").value;
   var other_personrealname = $("turnleader").options[$("turnleader").selectedIndex].text;
   if(other_personname =="00"){
          alert("请选择要转发的领导");return ;
    }else if(other_personrealname==userName){
          alert("不能转发给自己！");return false;
   }      
   if(!confirm("确定要转发吗？")){return false;}
    var ideal_id = getNewCc_form_instanceid(false);
    var option_sql="<no>"+"insert into ta_project_approval_opinion t (t.ideal_id,t.ideal_peopleid,t.ideal_peoplename,"
                   +" t.ideal_departid,t.ideal_departname,t.ideal_result,t.ideal_conten,t.ideal_date,"
                   +"t.businessid,t.action_defid,t.action_name)   values('"+ideal_id+"','"+userId+"','"+userName
                   +"','"+orgId+"','"+orgName+"','','转发【"+other_personrealname
                   +"】处理',sysdate,'"+approval_id+"','"+oid+"','"+actName+"')"+"</no>";    
  var msg=creator_inserts(option_sql); 
    if(IsSpace(msg)){
      //alert("插入成功！");
      $("DYNAMICPERFORMER").value = other_personname;
      $("spworkflow_ctrl").value="转发";
      alert($("DYNAMICPERFORMER").value);
      creator_djsave('完成活动',false,true,'');
       history.go(-1);   
    }else{
     alert("插入失败！"+msg);
    }
}

//改变管理级别
function ischangetype(){
 var mange_type = $("radio5").value;
 if(code==3){
    if(mange_type==1){
       $("dept_text").style.display="none";
       $("dept_td").style.display="none";
     }else{
       $("dept_text").style.display="";
       $("dept_td").style.display="";
     }
 }else{
     if(mange_type==1){
       $("dept_text").style.display="none";
       $("dept_td").style.display="none";
     }else{
      $("dept_text").style.display="";
       $("dept_td").style.display="";
     }
 }
}

//返回函数
function goback(){
window.history.back();
}
//流程监控方法
function monitor_workflow(){
   show_workFlow_monitor(cc_form_instanceid);
}

//选择下一步执行人
function select_nextUser(){
 var rootname="";
 var rolename="'";
 if(code=="1"&&isflag=="有"){
   rootname="选择郑分技市部领导";
   rolename="郑分技市部主管工程领导";
 }else if(code=="1"&&isflag=="无"){
   rootname="选择总部市场部领导";
   rolename="总部市场部领导";
 }else if(code=="2"){
   rootname="选择郑分领导";
 }else if(code=="3"){
   rootname="选择总部市场部领导";
   rolename="总部市场部领导";
 }if(code=="4"){
  rootname="选择公司领导";
  rolename="公司领导";
 }
 
     var obj={ 
     flag:"1",
     sql:"",
     title:"选择下一步执行人",
     isRadio:true,
     ObjId:DYNAMICPERFORMER,
     ObjName:DYNAMICPERFORMER_NAME,
     rootId:'0',
     rootName:rootname,
     expandLevel:"2"
    };
    if(code=="2"){
       obj.sql="select u.user_name as id,'0' as parent_id, u.user_realname as name from td_sm_user u, td_sm_userrole ur, td_sm_role r, td_sm_orguser ou"
               +" where f_getSecondRemark4(ou.org_id) ='zhengzhou' and u.user_id = ur.user_id and r.role_id = ur.role_id and u.user_id = ou.user_id and r.role_name = '分公司领导'";
    }else{
    obj.sql="  select u.user_name as id, u.user_realname as name,'0' as parent_id from td_sm_user u, td_sm_userrole ur, td_sm_role r"
        +" where u.user_id = ur.user_id and r.role_id = ur.role_id and r.role_name = '"+rolename+"' order by user_sn";  
     //alert(obj.sql);
   }
    OpenTreeFromSql(obj);
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><checkbox><id>checkbox1</id></checkbox><radio><id>radio1</id><id>radio2</id><id>radio3</id><id>radio4</id><id>is_agree</id><id>radio5</id></radio><textarea><id>textarea1</id><id>request_explain</id><id>agress_explain</id><id>ablity_explain</id><id>other_explain</id><id>appraisal_measure</id><id>appraisal_result</id><id>option</id></textarea><combobox><id>combobox1</id><id>combobox5</id><id>combobox15</id><id>combobox14</id><id>combobox3</id><id>combobox8</id><id>combobox9</id><id>ENTRUST_WAY</id><id>combobox11</id><id>turnleader</id><id>dept_manager</id><id>workflowControl_selectAct</id></combobox><img><id>img1</id><id>img2</id></img><tab><id>tab7</id></tab><div><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_complete</id><id>workflowControl_selectUser</id><id>div1</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_tempSaveForm</id><id>workflowControl_selectAct_div</id><id>workflowControl_backToPrior</id></div><button><id>back_id</id><id>turn_to</id><id>button_ht</id><id>button_hs</id><id>button_wchd</id><id>monitor</id><id>button1</id><id>button2</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_zc</id></button><text><id>project_name</id><id>text4</id><id>main_dept</id><id>join_dept_name</id><id>inputer</id><id>orgName</id><id>input_date</id><id>CLIENT</id><id>text11</id><id>text3</id><id>text7</id><id>text13</id><id>text14</id><id>text24</id><id>text12</id><id>other</id><id>text5</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>spworkflow_ctrl</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><grid><id>grid3</id><id>grid2</id><id>grid1</id></grid><dataset><id>item_dataset</id><id>approv_dataset</id><id>option_dataset</id><id>approval_phase_dataset</id></dataset></root>" billtaborder="<root><taborder>is_agree</taborder><taborder>textarea1</taborder><taborder>request_explain</taborder><taborder>agress_explain</taborder><taborder>ablity_explain</taborder><taborder>other_explain</taborder><taborder>appraisal_measure</taborder><taborder>appraisal_result</taborder><taborder>option</taborder><taborder>combobox1</taborder><taborder>combobox3</taborder><taborder>dept_manager</taborder><taborder>button_yfzxzxr</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button1</taborder><taborder>button_xzxr</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder><taborder>project_name</taborder><taborder>inputer</taborder><taborder>orgName</taborder><taborder>input_date</taborder><taborder>CLIENT</taborder><taborder>text11</taborder><taborder>text24</taborder><taborder>text12</taborder><taborder>text13</taborder><taborder>text14</taborder><taborder>other</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>grid2</taborder><taborder>grid1</taborder><taborder>combobox5</taborder><taborder>combobox8</taborder><taborder>main_dept</taborder><taborder>join_dept_name</taborder><taborder>combobox9</taborder><taborder>combobox11</taborder><taborder>ENTRUST_WAY</taborder><taborder>grid3</taborder><taborder>spworkflow_ctrl</taborder><taborder>radio1</taborder><taborder>radio2</taborder><taborder>radio3</taborder><taborder>radio4</taborder><taborder>turnleader</taborder><taborder>checkbox1</taborder><taborder>turn_to</taborder><taborder>radio5</taborder><taborder>button2</taborder><taborder>combobox14</taborder><taborder>combobox15</taborder><taborder>text3</taborder><taborder>text7</taborder><taborder>text4</taborder><taborder>back_id</taborder><taborder>monitor</taborder><taborder>button_qdlc</taborder><taborder>button_zc</taborder><taborder>workflowControl_selectAct</taborder><taborder>text5</taborder></root>" dj_sn="20100704171803734764" caption="立项审批" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:0;radio:5;listbox:1;textarea:0;combobox:15;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:2;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:3;text:8;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:4;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination="grid3,approval_phase_dataset,;grid2,item_dataset,5;grid1,option_dataset,10;" type="ZW" creatorType="20100518201118906945" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;/userjs/project/approval_ideal.js&#13;&#10;/userjs/project/project_pub.js&#13;&#10;/userjs/project/entrust_startwf.js&#13;&#10;/userjs/project/div_tree.js" creator_allTab="<tabs><tab><id>tab7</id><content><index>0</index><gridid>grid3,grid2</gridid><iframeid></iframeid><index>1</index><gridid>grid1</gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=tit style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD noWrap width="20%"><H1><SPAN id=curact></SPAN></H1></TD>
                     <TD width="80%"><DIV id=workflowControl3 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 99.42%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 85.69%; TEXT-ALIGN: right; valign: buttom" onmovestart=moveStart() controltype="workflowControl" NotBg="是"><BUTTON class=button_top id=back_id style="LEFT: 0px; WIDTH: 46px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("goback()")'>返回</BUTTON><BUTTON class=button_top id=turn_to style="DISPLAY: none; LEFT: 0px; WIDTH: 46px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("turn_other();")'>转发</BUTTON><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 64px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_top id=button_ht style="LEFT: 0px; WIDTH: 57px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doBack()")'>回退</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 56px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_nor id=button_hs style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)">收回</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: right; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 55px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button_nor id=button_wchd style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doComplete()")'>提交</BUTTON></DIV><BUTTON class=button_top id=monitor style="LEFT: 0px; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("monitor_workflow()")'>流程监控</BUTTON></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><DIV class=tab-pane id=tab7 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 30px; HEIGHT: 952px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 934px"><H2 class=tab>基本信息</H2>
                  <TABLE class=shade style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                     <TBODY>
                        <TR>
                           <TD colSpan=2>
                              <TABLE class=shade style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TD><LI>工程立项基本信息</LI></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR>
                           <TD colSpan=2>
                              <TABLE class=shadeTab style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TH width="5%">工程名称</TH>
                                       <TD width="50%" colSpan=3><INPUT id=project_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="proj_name" china="工程名称" dataset="approv_dataset"></TD>
                                       <TH width="5%">设计编号</TH>
                                       <TD width="40%"><INPUT id=text4 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 50%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="design_id" china="设计编号" dataset="approv_dataset"><BUTTON class=button_nor id=button1 style="DISPLAY: none; LEFT: 0px; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("getDesign_id()")'>自动编号</BUTTON></TD>
                                    </TR>
                                    <TR>
                                       <TH>主体处</TH>
                                       <TD><INPUT id=main_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 168px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 90px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                                       <TH>配合处</TH>
                                       <TD colSpan=3><INPUT id=join_dept_name style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 520px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 88px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=11 controltype="text"></TD>
                                    </TR>
                                    <TR>
                                       <TH width="5%">项目归属</TH>
                                       <TD width="25%"><SELECT id=combobox1 style="LEFT: 133px; WIDTH: 120px; POSITION: static; TOP: 66px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xt%96%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xrn%D0%EA%D6XrnXrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xt%96Xr%7C%EE%F2%EC%E2%CC%D0%F6%F6%F2%E0%D2%F8%F6%E0%FA%D8Xr%7CXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="ascription" china="项目归属" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH width="5%">省市</TH>
                                       <TD width="20%"><SELECT id=combobox5 style="LEFT: 0px; WIDTH: 99px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%EE%F2%EC%FA%E0%EA%D4%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="province" china="省市" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="99" backheight="25"></SELECT></TD>
                                       <TH noWrap width="5%">归属机构</TH>
                                       <TD width="40%"><SELECT id=combobox15 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%ECj%EC%F2%DC%CC%E0%D6Xr%94%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXn%96Xn%90%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="belong_orgid" china="归属机构ID" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                    </TR>
                                    <TR>
                                       <TH>专业属性</TH>
                                       <TD><SELECT id=combobox14 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90Xrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90Xrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8Xt%96XrnXr%7C%EE%F2%EC%DA%D8%F4%F4%E0%EC%EA%D0%E6%CC%EE%F2%EC%EE%D8%F2%F6%u0100Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH>工程类型</TH>
                                       <TD><SELECT id=combobox3 style="LEFT: 439px; WIDTH: 99px; POSITION: static; TOP: 64px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%EE%F2%EC%E2%CC%F6%u0100%EE%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="proj_type" china="工程类型" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="99" backheight="25"></SELECT></TD>
                                       <TH noWrap>负责机构</TH>
                                       <TD><SELECT id=combobox8 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 1px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%ECj%EC%F2%DC%CC%EA%D0%E8%D8XrnXrn%DA%F2%EC%E8Xrn%F6%D6%CC%F4%E8%CC%EC%F2%DC%D0%EA%E0%u0102%D0%F6%E0%EC%EAXrn%ECXrn%FC%DE%D8%F2%D8Xrn%E6%D8%FA%D8%E6Xt%96Xr%7CrXr%7CXrn%F4%F6%D0%F2%F6Xrn%FC%E0%F6%DEXrn%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6Xt%96Xr%7CnXr%7CXn%96Xn%90%D4%EC%EA%EA%D8%D4%F6Xrn%D2%u0100Xrn%EE%F2%E0%EC%F2Xrn%ECj%EC%F2%DC%CC%E0%D6Xt%96%ECj%EE%D0%F2%D8%EA%F6%CC%E0%D6" controltype="combobox" field="responsible_org" china="负责机构" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                    </TR>
                                    <TR>
                                       <TH>填表人</TH>
                                       <TD><INPUT id=inputer style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=16 controltype="text" field="inputer" china="填表人" dataset="approv_dataset"></TD>
                                       <TH>部门名称</TH>
                                       <TD><INPUT id=orgName style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="org_name" china="填表人所在单位" dataset="approv_dataset"></TD>
                                       <TH>填表时间</TH>
                                       <TD><INPUT id=input_date style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="input_date" china="填表日期" dataset="approv_dataset"></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR id=phase_td1 style="DISPLAY: none">
                           <TD colSpan=2><LI>已立项阶段</LI></TD>
                        </TR>
                        <TR id=phase_td2 style="DISPLAY: none">
                           <TD colSpan=2><?xml:namespace prefix = fc /><fc:webgrid id=grid3 onkeydown='bill_ongridkeydown("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' ondblclick='bill_ongriddblclick("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' onclick='bill_ongridclick("<grid3><col></col><col></col><col></col><col></col><col></col><col></col></grid3>")' top="0" width="100%" height="93" format="<cols><col><fname>design_phasename</fname><cname>阶段名称</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>13%</columnwidth><align>left</align></col><col><fname>proj_level</fname><cname>管理级别</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>7%</columnwidth><align>left</align></col><col><fname>m_deptname</fname><cname>主体处</cname><width>30</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>duty_person</fname><cname>总负责人</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>40%</columnwidth><align>left</align></col><col><fname>institute_director</fname><cname>院主管</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>investment</fname><cname>投资规模</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col></cols>" dataset="approval_phase_dataset" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="是" bodyrowheight="-1" bodyrows="-1" left="0">
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
                              <TABLE class=shadeTab id=table_entrust style="DISPLAY: none; POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TH width="10%">委托类型</TH>
                                       <TD width="10%"><SELECT id=combobox9 style="LEFT: 804px; WIDTH: 120px; POSITION: static; TOP: 173px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%D8%EA%F6%F2%F8%F4%F6%CC%F6%u0100%EE%D8Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="entrust_type" china="委托类型" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH width="10%">委托单位</TH>
                                       <TD width="70%"><INPUT id=CLIENT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="client" china="委托单位" dataset="approv_dataset"></TD>
                                    </TR>
                                    <TR>
                                       <TH>委托方式</TH>
                                       <TD><SELECT id=ENTRUST_WAY style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6XrnXrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%FA%D0%E6%F8%D8Xr%94%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EA%D0%E8%D8Xn%96Xn%90XrnXrnXrn%DA%F2%EC%E8Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%96%90%B6%90Xrn%D2Xr%94Xrn%B6%96%CC%B4%A8%CC%96%A0%94%B6%B6%C0%AE%98Xrn%D0Xn%96Xn%90XrnXrn%FC%DE%D8%F2%D8Xrn%D2j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6XrnXt%96Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%E0%D6Xn%96Xn%90XrnXrnXrnXrn%D0%EA%D6Xrn%D0j%D6%E0%D4%F6%F6%u0100%EE%D8%CC%EA%D0%E8%D8XrnXt%96XrnXr%7C%D8%EA%F6%F2%F8%F4%F6%CC%FC%D0%u0100Xr%7CXn%96Xn%90XrnXrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%D2j%D6%E0%D4%F6%D6%D0%F6%D0%CC%EC%F2%D6%D8%F2" controltype="combobox" field="entrust_way" china="委托方式" dataset="approv_dataset" tempvalue temptext sql check="2" backwidth="120" backheight="25"></SELECT></TD>
                                       <TH>委托说明</TH>
                                       <TD><INPUT id=text11 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="entrust_explain" china="委托说明" dataset="approv_dataset"></TD>
                                    </TR>
                                    <TR>
                                       <TH>客户编号</TH>
                                       <TD><INPUT id=text3 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="custom_proj_id" china="客户项目编号" dataset="approv_dataset"></TD>
                                       <TH>客户项目名称</TH>
                                       <TD><INPUT id=text7 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="custom_proj_name" china="客户项目名称" dataset="approv_dataset"></TD>
                                    </TR>
                                    <TR>
                                       <TH rowSpan=4>任务信息</TH>
                                       <TH>
                                          <FONT id=show_info>委托阶段</FONT>
                                       </TH>
                                       <TD colSpan=2><INPUT id=text13 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 40%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="entrust_phase" china="委托阶段" dataset="approv_dataset">要求在<INPUT id=text14 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 95px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=17 controltype="text" field="expect_date" china="要求完成日期" dataset="approv_dataset">前完成。</TD>
                                    </TR>
                                    <TR>
                                       <TH>设计规模为</TH>
                                       <TD colSpan=2><INPUT id=text24 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="dimensions" china="设计规模" dataset="approv_dataset"></TD>
                                    </TR>
                                    <TR>
                                       <TH>工程总投资约为</TH>
                                       <TD colSpan=2><INPUT id=text12 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 170px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=17 controltype="text" field="investment" china="总投资" dataset="approv_dataset">万元,质量满足现行国家有关规范、标准的要求。</TD>
                                    </TR>
                                    <TR>
                                       <TH>其他要求</TH>
                                       <TD colSpan=2><TEXTAREA id=textarea1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() readOnly controltype="textarea" field="other_request" china="其他要求" dataset="approv_dataset" value="textarea1" induce="否"></TEXTAREA></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR>
                           <TD colSpan=2><LI><SPAN><IMG id=img2 style="LEFT: 0px; CURSOR: hand; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/zxyd/project/images/menu_off.gif" controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('table_client')&quot;)" cover="9" srcsk="../../../ccapp/zxyd/project/images/menu_off.gif"></SPAN>顾客要求评审表</LI></TD>
                        </TR>
                        <TR>
                           <TD colSpan=2>
                              <TABLE class=shadeTab id=table_client style="DISPLAY: none; POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TH style="TEXT-ALIGN: left" noWrap width="10%">1、顾客要求是否已经明确？</TH>
                                       <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio1 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 78px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 18px" disabled onmovestart=moveStart() controltype="radio" field="client_request" china="客户要求" dataset="approv_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><INPUT type=radio CHECKED value=是 name=RGradio1 text="是"><SPAN onclick=RGradio1[0].checked=true;radio1.value=RGradio1[0].value;RGradio1[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio1 text="否"><SPAN onclick=RGradio1[1].checked=true;radio1.value=RGradio1[1].value;RGradio1[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                       <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=request_explain style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly controltype="textarea" field="request_explain" china="顾客要求" dataset="approv_dataset" value="textarea3" induce="否"></TEXTAREA></TD>
                                       <TH style="TEXT-ALIGN: left" noWrap width="10%">2、与顾客的理解是否达成共识？</TH>
                                       <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio2 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 78px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 16px" disabled onmovestart=moveStart() controltype="radio" field="agress" china="客户理解" dataset="approv_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是" readOnly="true"><INPUT type=radio CHECKED value=是 name=RGradio2 text="是"><SPAN onclick=RGradio2[0].checked=true;radio2.value=RGradio2[0].value;RGradio2[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio2 text="否"><SPAN onclick=RGradio2[1].checked=true;radio2.value=RGradio2[1].value;RGradio2[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                       <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=agress_explain style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly controltype="textarea" field="agress_explain" china="顾客达成共识" dataset="approv_dataset" value="textarea4" induce="否"></TEXTAREA></TD>
                                    </TR>
                                    <TR>
                                       <TH noWrap width="10%">3、是否有能力满足顾客要求？</TH>
                                       <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio3 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 78px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 19px" disabled onmovestart=moveStart() controltype="radio" field="ablity" china="是否有能力" dataset="approv_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><INPUT type=radio CHECKED value=是 name=RGradio3 text="是"><SPAN onclick=RGradio3[0].checked=true;radio3.value=RGradio3[0].value;RGradio3[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio3 text="否"><SPAN onclick=RGradio3[1].checked=true;radio3.value=RGradio3[1].value;RGradio3[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                       <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=ablity_explain style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly controltype="textarea" field="ablity_explain" china="满足顾客要求" dataset="approv_dataset" value="textarea5" induce="否">是</TEXTAREA></TD>
                                       <TH style="TEXT-ALIGN: left" noWrap width="10%">4、其他：
                                          <INPUT id=other style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 108px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=7 controltype="text" field="other" china="其他" dataset="approv_dataset">
                                       </TD>
                                       <TD style="BORDER-RIGHT: 0px" noWrap width="10%"><FIELDSET id=radio4 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 78px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 5px" disabled onmovestart=moveStart() controltype="radio" field="c_other_request" china="客户其他要求" dataset="approv_dataset" tempvalue="是&#13;&#10;否" temptext="是&#13;&#10;否" aspect="横向" legend NotBg="否" value="是"><INPUT type=radio CHECKED value=是 name=RGradio4 text="是"><SPAN onclick=RGradio4[0].checked=true;radio4.value=RGradio4[0].value;RGradio4[0].focus();>是</SPAN>&nbsp;<INPUT type=radio value=否 name=RGradio4 text="否"><SPAN onclick=RGradio4[1].checked=true;radio4.value=RGradio4[1].value;RGradio4[1].focus();>否</SPAN>&nbsp;</FIELDSET>原因如下：</TD>
                                       <TD style="BORDER-LEFT: 0px" width="30%"><TEXTAREA id=other_explain style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly controltype="textarea" field="other_explain" china="其他能否满足" dataset="approv_dataset" value="textarea6" induce="否"></TEXTAREA></TH></TD>
                                    <TR>
                                       <TH style="TEXT-ALIGN: left">评审引发的措施:(其他要求)</TH>
                                       <TD colSpan=5><TEXTAREA id=appraisal_measure style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly controltype="textarea" field="appraisal_measure" china="引发的措施" dataset="approv_dataset" value="textarea7" induce="否">无</TEXTAREA></TD>
                                    </TR>
                                    <TR>
                                       <TH noWrap width="10%">评审结论</TH>
                                       <TD width="90%" colSpan=5><TEXTAREA id=appraisal_result style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 35px" onmovestart=moveStart() readOnly cols=18 controltype="textarea" value="textarea8" induce="否">顾客要求能够满足,同意承接。</TEXTAREA></TD>
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
                              <TABLE class=shadeTab style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TH width="15%">管理级别</TH>
                                       <TD width="35%"><SELECT id=combobox11 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="proj_level" china="项目管理级别" dataset="approv_dataset" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" sql check="1" backwidth="120" backheight="25"><OPTION value=0>院管</OPTION><OPTION value=1 selected>处管</OPTION></SELECT></TD>
                                       <TH width="15%">院主管</TH>
                                       <TD width="35%"><INPUT id=text5 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR>
                           <TD colSpan=2>
                              <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                 <TBODY>
                                    <TR>
                                       <TD><LI><SPAN><BUTTON class=button_nor id=button2 style="DISPLAY: none; LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("modifyUser()")'>修改项目(总)负责人</BUTTON></SPAN>项目总负责人(项目负责人)审批表</LI></TD>
                                    </TR>
                                    <TR>
                                       <TD>
                                          <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                                             <TBODY>
                                                <TR>
                                                   <TD>&nbsp;根据相关任职条件，经与&nbsp;<FONT id=join_dept></FONT>&nbsp;协商，我单位拟推荐该工程设计项目的<FONT id=duty_person></FONT></TD>
                                                </TR>
                                                <TR>
                                                   <TD id=td0 style="DISPLAY: none"></TD>
                                                </TR>
                                                <TR>
                                                   <TD id=td1 style="DISPLAY: none"></TD>
                                                </TR>
                                                <TR>
                                                   <TD id=td2 style="DISPLAY: none"></TD>
                                                </TR>
                                                <TR>
                                                   <TD id=joindept>&nbsp;处主管：</TD>
                                                </TR>
                                             </TBODY>
                                          </TABLE>
                                       </TD>
                                    </TR>
                                    <TR>
                                       <TD><LI>单项负责人审批表</LI></TD>
                                    </TR>
                                    <TR>
                                       <TD><fc:webgrid id=grid2 onkeydown='bill_ongridkeydown("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' ondblclick='bill_ongriddblclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' onclick='bill_ongridclick("<grid2><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid2>")' top="0" width="100%" height="143" format="<cols><col><fname>num</fname><cname>序号</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>5%</columnwidth><align>left</align></col><col><fname>item_name</fname><cname>单项名称</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>20%</columnwidth><align>left</align></col><col><fname>dept_name</fname><cname>负责处</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>left</align></col><col><fname>admin_name</fname><cname>负责人</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>reviewers_name</fname><cname>审核人</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>left</align></col><col><fname>user_name</fname><cname>参加人</cname><width>200</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>38%</columnwidth><align>left</align></col><col><fname>do</fname><cname>操作</cname><width>25</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" dataset="item_dataset" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="25" bodyrows="-1" left="0">
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
                                       <TD><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 299px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid2"><SPAN id=pageInfogrid2></SPAN><A id=firstpagegrid2 onclick="buttonevent('grid2','firstpage');crtlItemList();" href="javascript:void(0)">首页</A><A id=prevpagegrid2 onclick="buttonevent('grid2','prevpage');crtlItemList()" href="javascript:void(0)">上一页</A><A id=nextpagegrid2 onclick="buttonevent('grid2','nextpage');crtlItemList()" href="javascript:void(0)">下一页</A><A id=lastpagegrid2 onclick="buttonevent('grid2','lastpage');crtlItemList()" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </DIV>
               <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 934px">
                  <H2 class=tab>审批信息</H2>
                  <TABLE class=tit style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px" cellSpacing=2 cellPadding=0 width="100%" align=left border=0>
                     <TBODY>
                        <TR>
                           <TD><H1><FONT id=nextActName></FONT></H1></TD>
                        </TR>
                        <TR>
                           <TD>
                              <TABLE class=shadeTab id=design_table style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left>
                                 <TBODY>
                                    <TR id=oper_type style="DISPLAY: none">
                                       <TH>转其他领导</TH>
                                       <TD id=turn_oper><DIV id=checkbox1 style="LEFT: 0px; WIDTH: 36px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() noWrap controltype="checkbox" NotBg="否" value="否" onclick='bill_onclick("isTurnLeader()")' truevalue="是" falsevalue="否" divtype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>是</SPAN></DIV></TD>
                                       <TH id=turn_leader1 style="DISPLAY: none">选择其他领导</TH>
                                       <TD id=turn_leader2 style="DISPLAY: none"><SELECT id=turnleader style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="00" temptext="--请选择--" sql check="1" backwidth="120" backheight="25"><OPTION value=00 selected>--请选择--</OPTION></SELECT></TD>
                                    </TR>
                                    <TR id=sp_result>
                                       <TH id=sp_result1>审批结论</TH>
                                       <TD id=sp_result2><FIELDSET id=is_agree contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 117px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 22px" onmovestart=moveStart() controltype="radio" tempvalue="同意&#13;&#10;不同意" temptext="同意&#13;&#10;不同意" aspect="横向" legend NotBg="是" value="同意" onclick='bill_onclick("is_change()")'><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio CHECKED value=同意 name=RGis_agree text="同意"><SPAN onclick=RGis_agree[0].checked=true;is_agree.value=RGis_agree[0].value;RGis_agree[0].focus();>同意</SPAN>&nbsp;<INPUT type=radio value=不同意 name=RGis_agree text="不同意"><SPAN onclick=RGis_agree[1].checked=true;is_agree.value=RGis_agree[1].value;RGis_agree[1].focus();>不同意</SPAN>&nbsp;</FIELDSET></TD>
                                       <TH id=mange_type1 style="DISPLAY: none">确定管理级别</TH>
                                       <TD id=mange_type2 style="DISPLAY: none"><FIELDSET id=radio5 contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 105px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 23px" onmovestart=moveStart() controltype="radio" field="proj_level" china="项目管理级别" dataset="approv_dataset" tempvalue="0&#13;&#10;1" temptext="院管&#13;&#10;处管" aspect="横向" legend NotBg="否" value="1" onclick='bill_onclick("ischangetype()")'><LEGEND style="DISPLAY: none"></LEGEND><INPUT type=radio value=0 name=RGradio5 text="院管"><SPAN onclick=RGradio5[0].checked=true;radio5.value=RGradio5[0].value;RGradio5[0].focus();>院管</SPAN>&nbsp;<INPUT type=radio CHECKED value=1 name=RGradio5 text="处管"><SPAN onclick=RGradio5[1].checked=true;radio5.value=RGradio5[1].value;RGradio5[1].focus();>处管</SPAN>&nbsp;</FIELDSET></TD>
                                    </TR>
                                    <TR id=tr1>
                                       <TH id=dept_text>指定处主管</TH>
                                       <TD id=dept_td><SELECT id=dept_manager style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="00" temptext="--请选择--" sql check="1" backwidth="120" backheight="25"><OPTION value=00 selected>--请选择--</OPTION></SELECT></TD>
                                       <TH id=next_user>选择下一环节执行人</TH>
                                       <TD id=next_user_per><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=menu_s id=button_xzxr style="LEFT: 0px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("select_nextUser()")'>选择</BUTTON></DIV></TD>
                                    </TR>
                                    <TR id=tr2>
                                       <TH colSpan=4>填写审批意见(少于200字)</TH>
                                    </TR>
                                    <TR id=tr3>
                                       <TD colSpan=4><TEXTAREA id=option style="LEFT: 0px; WIDTH: 100%; WORD-BREAK: break-all; POSITION: static; TOP: 0px; HEIGHT: 50px" onmovestart=moveStart() onchange='bill_onclick("countChars()")' controltype="textarea" value="textarea3" onclick='bill_onclick("countChars()")' induce="否" onblur='bill_onexit("countChars()")' onkeydown='bill_onkeydown("countChars()")' onfocus='bill_onenter("countChars()")'></TEXTAREA></TD>
                                    </TR>
                                    <TR id=tr4>
                                       <TD colSpan=4><FONT id=charCount></FONT></TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                        <TR>
                           <TD class=shade><LI>已有审批意见列表</LI></TD>
                        </TR>
                        <TR>
                           <TD><fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col><col></col><col></col><col></col></grid1>")' top="0" width="100%" height="233" format="<cols><col><fname>ideal_peoplename</fname><cname>审核人</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>10%</columnwidth><align>center</align></col><col><fname>ideal_departname</fname><cname>部门</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>12%</columnwidth><align>center</align></col><col><fname>action_name</fname><cname>审核环节</cname><width>100</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>13%</columnwidth><align>center</align></col><col><fname>ideal_result</fname><cname>审核结果</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>7%</columnwidth><align>center</align></col><col><fname>ideal_conten</fname><cname>审核意见</cname><width>500</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>35%</columnwidth><align>center</align></col><col><fname>ideal_date</fname><cname>审核日期</cname><width>20</width><dtype>日期</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>15%</columnwidth><align>center</align></col><col><fname>detail</fname><cname>查看</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>8%</columnwidth><align>center</align></col></cols>" dataset="option_dataset" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="否" bodyrowheight="-1" bodyrows="-1" left="0">
                                 <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #ffffff" cellSpacing=0 cellPadding=1 width="100%" frame=box>
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
                           <TD><DIV align=left><DIV style="DISPLAY: inline"><DIV style="LEFT: 0px; WIDTH: 689px; POSITION: static; TOP: 199px; HEIGHT: 26px" name="Ctrlgrid1"><SPAN id=pageInfogrid1></SPAN><A id=firstpagegrid1 onclick="buttonevent('grid1','firstpage')" href="javascript:void(0)">首页</A><A id=prevpagegrid1 onclick="buttonevent('grid1','prevpage')" href="javascript:void(0)">上一页</A><A id=nextpagegrid1 onclick="buttonevent('grid1','nextpage')" href="javascript:void(0)">下一页</A><A id=lastpagegrid1 onclick="buttonevent('grid1','lastpage')" href="javascript:void(0)">尾页</A></DIV></DIV></DIV></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
               </DIV>
            </DIV>
            <SCRIPT>var tab7 = new WebFXTabPane( document.getElementById( "tab7" ) );</SCRIPT>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<DIV id=div1 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: auto; DISPLAY: none; Z-INDEX: 10; LEFT: 432px; OVERFLOW-X: auto; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 174px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 80px; HEIGHT: 499px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否">
   <INPUT id=spworkflow_ctrl style="LEFT: 1044px; WIDTH: 135px; POSITION: static; TOP: 47px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=24 value=同意 controltype="text">
   <fc:dataset id=item_dataset format="<fields><field><fieldname>item_id</fieldname><datatype>字符</datatype><displaylabel>单项主键</displaylabel><size>25</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>num</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>5%25</columnWidth2></columnWidth1></field><field><fieldname>item_name</fieldname><datatype>字符</datatype><displaylabel>单项名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>20%25</columnWidth2></columnWidth1></field><field><fieldname>dept_name</fieldname><datatype>字符</datatype><displaylabel>负责处</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>admin_name</fieldname><datatype>字符</datatype><displaylabel>负责人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>reviewers_name</fieldname><datatype>字符</datatype><displaylabel>审核人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>user_name</fieldname><datatype>字符</datatype><displaylabel>参加人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>38%25</columnWidth2></columnWidth1></field><field><fieldname>dept_id</fieldname><datatype>字符</datatype><displaylabel>所属处ID</displaylabel><size>25</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>do</fieldname><datatype>字符</datatype><displaylabel>操作</displaylabel><size>25</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1><columnHeight2>2%25</columnHeight2></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name><dept_id></dept_id><do></do></dsid>")' onGetText='bill_ondatasetgettext("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name><dept_id></dept_id><do></do></dsid>")' onValid='bill_ondatasetvalid("<dsid><item_id></item_id><num></num><item_name></item_name><dept_name></dept_name><admin_name></admin_name><reviewers_name></reviewers_name><user_name></user_name><dept_id></dept_id><do></do></dsid>")' opensortno="4" temptable="TMP_DATASET3" multiResult="是"></fc:dataset>
   <fc:dataset id=approv_dataset format="<fields><field><fieldname>proj_name</fieldname><datatype>字符</datatype><displaylabel>工程名称</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ascription</fieldname><datatype>字符</datatype><displaylabel>项目归属</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_type</fieldname><datatype>字符</datatype><displaylabel>工程类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>province</fieldname><datatype>字符</datatype><displaylabel>省市</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_org</fieldname><datatype>字符</datatype><displaylabel>归属机构</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>inputer</fieldname><datatype>字符</datatype><displaylabel>填表人</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_name</fieldname><datatype>字符</datatype><displaylabel>填表人所在单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>client</fieldname><datatype>字符</datatype><displaylabel>委托单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_way</fieldname><datatype>字符</datatype><displaylabel>委托方式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_type</fieldname><datatype>字符</datatype><displaylabel>委托类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_explain</fieldname><datatype>字符</datatype><displaylabel>委托说明</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>dimensions</fieldname><datatype>字符</datatype><displaylabel>设计规模</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>investment</fieldname><datatype>字符</datatype><displaylabel>总投资</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>expect_date</fieldname><datatype>日期</datatype><displaylabel>要求完成日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yy-mm-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>entrust_phase</fieldname><datatype>字符</datatype><displaylabel>委托阶段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_request</fieldname><datatype>字符</datatype><displaylabel>其他要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>request_explain</fieldname><datatype>字符</datatype><displaylabel>顾客要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>agress_explain</fieldname><datatype>字符</datatype><displaylabel>顾客达成共识</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ablity_explain</fieldname><datatype>字符</datatype><displaylabel>满足顾客要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other</fieldname><datatype>字符</datatype><displaylabel>其他</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>other_explain</fieldname><datatype>字符</datatype><displaylabel>其他能否满足</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>appraisal_measure</fieldname><datatype>字符</datatype><displaylabel>引发的措施</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>项目管理级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>proj_id</fieldname><datatype>字符</datatype><displaylabel>工程ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_id</fieldname><datatype>字符</datatype><displaylabel>设计编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>responsible_org</fieldname><datatype>字符</datatype><displaylabel>负责机构</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>client_request</fieldname><datatype>字符</datatype><displaylabel>客户要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>agress</fieldname><datatype>字符</datatype><displaylabel>客户理解</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ablity</fieldname><datatype>字符</datatype><displaylabel>是否有能力</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>c_other_request</fieldname><datatype>字符</datatype><displaylabel>客户其他要求</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>professional_property</fieldname><datatype>字符</datatype><displaylabel>专业属性</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_id</fieldname><datatype>字符</datatype><displaylabel>客户项目编号</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>custom_proj_name</fieldname><datatype>字符</datatype><displaylabel>客户项目名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>belong_orgid</fieldname><datatype>字符</datatype><displaylabel>归属机构ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mc_oid</fieldname><datatype>字符</datatype><displaylabel>任务安排ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>task_id</fieldname><datatype>字符</datatype><displaylabel>任务ID</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>input_date</fieldname><datatype>字符</datatype><displaylabel>填表日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><proj_name></proj_name><ascription></ascription><proj_type></proj_type><province></province><belong_org></belong_org><inputer></inputer><org_name></org_name><client></client><entrust_way></entrust_way><entrust_type></entrust_type><entrust_explain></entrust_explain><dimensions></dimensions><investment></investment><expect_date></expect_date><entrust_phase></entrust_phase><other_request></other_request><request_explain></request_explain><agress_explain></agress_explain><ablity_explain></ablity_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><proj_level></proj_level><proj_id></proj_id><design_id></design_id><responsible_org></responsible_org><client_request></client_request><agress></agress><ablity></ablity><c_other_request></c_other_request><professional_property></professional_property><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><belong_orgid></belong_orgid><mc_oid></mc_oid><task_id></task_id><input_date></input_date></dsid>")' onGetText='bill_ondatasetgettext("<dsid><proj_name></proj_name><ascription></ascription><proj_type></proj_type><province></province><belong_org></belong_org><inputer></inputer><org_name></org_name><client></client><entrust_way></entrust_way><entrust_type></entrust_type><entrust_explain></entrust_explain><dimensions></dimensions><investment></investment><expect_date></expect_date><entrust_phase></entrust_phase><other_request></other_request><request_explain></request_explain><agress_explain></agress_explain><ablity_explain></ablity_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><proj_level></proj_level><proj_id></proj_id><design_id></design_id><responsible_org></responsible_org><client_request></client_request><agress></agress><ablity></ablity><c_other_request></c_other_request><professional_property></professional_property><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><belong_orgid></belong_orgid><mc_oid></mc_oid><task_id></task_id><input_date></input_date></dsid>")' onValid='bill_ondatasetvalid("<dsid><proj_name></proj_name><ascription></ascription><proj_type></proj_type><province></province><belong_org></belong_org><inputer></inputer><org_name></org_name><client></client><entrust_way></entrust_way><entrust_type></entrust_type><entrust_explain></entrust_explain><dimensions></dimensions><investment></investment><expect_date></expect_date><entrust_phase></entrust_phase><other_request></other_request><request_explain></request_explain><agress_explain></agress_explain><ablity_explain></ablity_explain><other></other><other_explain></other_explain><appraisal_measure></appraisal_measure><proj_level></proj_level><proj_id></proj_id><design_id></design_id><responsible_org></responsible_org><client_request></client_request><agress></agress><ablity></ablity><c_other_request></c_other_request><professional_property></professional_property><custom_proj_id></custom_proj_id><custom_proj_name></custom_proj_name><belong_orgid></belong_orgid><mc_oid></mc_oid><task_id></task_id><input_date></input_date></dsid>")' opensortno="1" temptable="TMP_DA" multiResult="是"></fc:dataset>
   <fc:dataset id=option_dataset format="<fields><field><fieldname>ideal_id</fieldname><datatype>字符</datatype><displaylabel>意见ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ideal_peoplename</fieldname><datatype>字符</datatype><displaylabel>审核人</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_departname</fieldname><datatype>字符</datatype><displaylabel>部门</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>12%25</columnWidth2></columnWidth1></field><field><fieldname>action_name</fieldname><datatype>字符</datatype><displaylabel>审核环节</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>13%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_result</fieldname><datatype>字符</datatype><displaylabel>审核结果</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>7%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_conten</fieldname><datatype>字符</datatype><displaylabel>审核意见</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>35%25</columnWidth2></columnWidth1></field><field><fieldname>ideal_date</fieldname><datatype>日期</datatype><displaylabel>审核日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>detail</fieldname><datatype>字符</datatype><displaylabel>查看</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:viewOption();</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>8%25</columnWidth2></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><detail></detail></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><detail></detail></dsid>")' onValid='bill_ondatasetvalid("<dsid><ideal_id></ideal_id><ideal_peoplename></ideal_peoplename><ideal_departname></ideal_departname><action_name></action_name><ideal_result></ideal_result><ideal_conten></ideal_conten><ideal_date></ideal_date><detail></detail></dsid>")' opensortno="3" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
   <fc:dataset id=approval_phase_dataset format="<fields><field><fieldname>oid</fieldname><datatype>字符</datatype><displaylabel>阶段ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>design_phasename</fieldname><datatype>字符</datatype><displaylabel>阶段名称</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target></target><href>javascript:viewPhaseInfo()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>13%25</columnWidth2></columnWidth1></field><field><fieldname>proj_level</fieldname><datatype>字符</datatype><displaylabel>管理级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>7%25</columnWidth2></columnWidth1></field><field><fieldname>m_deptname</fieldname><datatype>字符</datatype><displaylabel>主体处</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>duty_person</fieldname><datatype>字符</datatype><displaylabel>总负责人</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40%25</columnWidth2></columnWidth1></field><field><fieldname>institute_director</fieldname><datatype>字符</datatype><displaylabel>院主管</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>investment</fieldname><datatype>字符</datatype><displaylabel>投资规模</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>cc_form_instanceid</fieldname><datatype>字符</datatype><displaylabel>流程业务ID</displaylabel><size>25</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' onValid='bill_ondatasetvalid("<dsid><oid></oid><design_phasename></design_phasename><proj_level></proj_level><m_deptname></m_deptname><duty_person></duty_person><institute_director></institute_director><investment></investment><cc_form_instanceid></cc_form_instanceid></dsid>")' opensortno="6" temptable="TMP_DATASET6" multiResult="是"></fc:dataset>
   <DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 13px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 138px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 187px; HEIGHT: 74px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：
      <INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 128px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=21 controltype="text">
      <INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text">
      <BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addAndUser();")'>与分支选执行人</BUTTON>
   </DIV>
   <DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 13px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 275px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_qdlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('启动流程',true,true,'../../../common_workflow/main.jsp')&quot;)">启动流程</BUTTON>
   </DIV>
   <DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 12px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 331px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)">暂存</BUTTON>
   </DIV>
   <DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 18px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 126px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 378px; HEIGHT: 51px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">请选择活动：
      <SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor()")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT>
   </DIV>
   <DIV id=workflowControl_backToPrior style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; OVERFLOW-Y: hidden; LEFT: 22px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 84px; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 445px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <INPUT id=workflowControl_result style="DISPLAY: block; LEFT: 20px; WIDTH: 50px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
   </DIV>
</DIV>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/xtbg/js/Validate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/xtbg/js/Validate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/xtbg/js/PubFun.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/xtbg/js/PubFun.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/xtbg/js/QianYueYiJian.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/xtbg/js/QianYueYiJian.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script language='javascript'>
<%if(bDgMode){%>var mylink0 = document.createElement("link");
mylink0.setAttribute("type","text/css");
mylink0.setAttribute("rel","stylesheet");
mylink0.setAttribute("href",stylePath+"css/creatorBlue1/allStyle.css");
var myhead0 = document.getElementsByTagName("head")[0];
myhead0.appendChild(mylink0);
<%}else{%>adv_loadjsfile(stylePath+'css/creatorBlue1/allStyle.css');
<%}%></script>
   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
<%
    String cc_form_instanceid = request.getParameter("cc_form_instanceid");
    java.util.Date date = new java.util.Date(); 
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentDateTime = sdf.format(date);
    String app_id = "app_" + accesscontroler.getCurrentSystemID();
    String lcslid = request.getParameter("lcslid");
    lcslid = (lcslid == null) ? "" : lcslid;
%>
//客户端全局变量
var app_id = "<%=app_id%>"; //应用id
var userName = getSysElement("userName"); //当前用户的用户名
var userId = getSysElement("userid");  //当前用户ID
var orgName = getSysElement("userorgname");  //当前用户所在部门的名称
var orgId = getSysElement("userorgid");  //当前用户所在部门ID
var cc_form_instanceid = "<%=cc_form_instanceid%>"; //业务流程ID
var currentUser = userId; //当前的参与者
var businessType = "项目管理"; //业务类别
var currentDateTime = "<%=currentDateTime%>";
var actionId = getActionDefineId(); //当前活动ID
var actionName = getActionDefineName(); //当前活动名称
var contextInfo = new Array(new Array("ta_xmgl_xmsbclyj", "audit_idea_id",false,"textarea_psyj","","","","评审人","评审时间","评审意见",true,""),new Array("ta_xmgl_xmsbclyj", "audit_idea_id",false,"textarea_psyj","","","","评审人","评审时间","评审意见",true,""),new Array("ta_xmgl_xmsbclyj","audit_idea_id",false,"textarea_psyj","","","","评审人","评审时间","评审意见",true,""),new Array("ta_xmgl_xmsbclyj", "audit_idea_id",false,"textarea_psyj","","","","评审人","评审时间","评审意见",true,""),new Array( "ta_xmgl_xmsbclyj","audit_idea_id",false,"textarea_ldyj","","","","意见人","意见时间","意见",true,""));
var currentIndex = 0;  //当前处理意见索引
var lcslid = "<%=lcslid%>";
var djbh = "";
//设置请示报告的状态
var showTypeQSBG = "1";
var editTypeQSBG = "1,0";
var paraZJPS = null;
var paraZJZMD = null;
var paraQSBG = null;
//定义变量用来存贮word是否已经保存
var wordResults = [{isEmpty : true, saved : false}, {isEmpty : true, saved : false}];
//查询业务数据的sql
var base_sql = "select LCSLID,bhn,bhh,xm_name,zr_dept,zr_man,zr_phone,js_aim,js_content,gh_name,xm_type,xm_all_money,xm_all_finance,xm_all_other,xm_startdate,xm_enddate,tb_dept,tb_man,tb_phone,jhtz_all_money,jhtz_all_finance,jhtz_all_other,tb_date,tz_year,jhtz_money,sjtz_money,xxzxsbje,cc_form_instanceid,ywlb,wjzt,lccyr,xghyjksh,xzykfksh,xdzzwksh,xjsyyksh,fjid from ta_xmgl_xmsb"; 
var sel_sql = base_sql + " where cc_form_instanceid='<%=cc_form_instanceid%>'"; 
//主键
var primaryKey = "LCSLID";
//加载业务数据
function initBusinessData() {   
    //是否加载业务数据
    if (loadDateFromDB(cc_form_instanceid)) {  //从数据库中加载数据
        //加载业务数据
        dataset1.Open(sel_sql);
        //设置djbh值
        djbh = dataset1.Fields.Field[primaryKey].Value;
        //读取签阅意见
        if(actionId == "zxsb_wp1_act3") {//规划研究科审核
            currentIndex = 0;
            checkAudited();
            getAllAuditIdeaFromDB();
        } else if(actionId == "zxsb_wp1_act4") {//资源开发科审核
            currentIndex = 1;
            checkAudited();
            getAllAuditIdeaFromDB();
        } else if(actionId == "zxsb_wp1_act5") {//电子政务科审核
            currentIndex = 2;
            checkAudited();
            getAllAuditIdeaFromDB();
        } else if(actionId == "zxsb_wp1_act6") {//办公室审核
            currentIndex = 3;
            checkAudited();
            getAllAuditIdeaFromDB();
        } else {
            getPSYJ();
        }
        currentIndex = 4;
        checkAudited();
        getAllAuditIdeaFromDB();
    } else { //系统给出初始化数据
        /**当前日期**/
        TB_DATE.value = "<%=currentDateTime%>";
        $("text_ywlb").value = businessType;  //业务类别
    }
}
//如果是流程未启动则对表单上设置的权限不起作用，所以需要做权限控制
function setPurview() {
    //隐藏签阅意见的按钮
    button_ghyjk.style.display = "none";
    button_dzzwk.style.display = "none";
    button_zykfk.style.display = "none";
    button_bgs.style.display = "none";
}
//验证业务数据 错误信息必须提示返回值为false
function validate() {
    var isTrue = false;
    //验证编号
    isTrue = notEmpty($("TB_Number").value,true,"编号不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("TB_Number").value,20,0,"编号必须为小于20位的整数!");
    if( !isTrue){
        return false;
    }
    //验证填表单位
    isTrue = notEmpty($("TB_DEPT").value,true,"填表单位不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(TB_dept,"填表单位",200);
    if( !isTrue){
        return false;
    }
    //验证项目名称
    isTrue = notEmpty($("XM_NAME").value,true,"项目名称不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(XM_NAME,"项目名称",400);
    if( !isTrue){
        return false;
    }
    //验证责任单位
    isTrue = notEmpty($("ZR_DEPT").value,true,"责任单位不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(ZR_DEPT,"责任单位",400);
    if( !isTrue){
        return false;
    }
    //验证责任人
    isTrue = notEmpty($("ZR_MAN").value,true,"责任人不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(ZR_MAN,"责任人",100);
    if( !isTrue){
        return false;
    }
    //验证责任人联系电话 
    isTrue = notEmpty($("ZR_PHONE").value,true,"责任人联系电话不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkPhone1($("ZR_PHONE").value,"责任人电话号码有误！");
    if(!isTrue){
        return false;
    }
    //验证目标
    isTrue = notEmpty($("JS_AIM").value,true,"目标不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(JS_AIM,"目标",2000);
    if( !isTrue){
        return false;
    }
    //验证建设内容
    isTrue = notEmpty($("JS_CONTENT").value,true,"建设内容不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(JS_CONTENT,"建设内容",4000);
    if( !isTrue){
        return false;
    }
    //是否有总体规划及规划名称
    isTrue = validata_length(GH_NAME,"总体规划及规划名称",200);
    if( !isTrue){
        return false;
    }
    //验证是否选择项目类别
    isTrue = notEmpty($("XM_TYPE").value,true,"请选择项目类别！");
    if(!isTrue){
        return false;
    } else {
         dataset1.Fields.Field["XM_TYPE"].Value = $("XM_TYPE").value;
    }
    //验证项目总投资
    isTrue = notEmpty($("XM_ALL_MONEY").value,true,"总额不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("XM_ALL_MONEY").value,20,2,"总额必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    isTrue = notEmpty($("XM_ALL_FINANCE").value,true,"其中财政不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("XM_ALL_FINANCE").value,20,2,"其中财政必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    if(parseFloat($("XM_ALL_FINANCE").value) > parseFloat($("XM_ALL_MONEY").value)){
        alert("项目总投资的其中财政不能大于总额！");
        return false;
    }

    //验证已完成投资
    isTrue = notEmpty($("JHTZ_MONEY").value,true,"计划额不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("JHTZ_MONEY").value,20,2,"计划额必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    isTrue = notEmpty($("SJTZ_MONEY").value,true,"实际完成投资额不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("SJTZ_MONEY").value,20,2,"实际完成投资额必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    //验证计划投资及来源
    isTrue = notEmpty($("JHTZ_ALL_MONEY").value,true,"计划投资总额不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("JHTZ_ALL_MONEY").value,20,2,"计划投资总额必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    isTrue = notEmpty($("JHTZ_ALL_FINANCE").value,true,"其中财政不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = checkNum1($("JHTZ_ALL_FINANCE").value,20,2,"其中财政必须为小于18位的实数!");
    if( !isTrue){
        return false;
    }
    if(parseFloat($("JHTZ_ALL_FINANCE").value) > parseFloat($("JHTZ_ALL_MONEY").value)) {
        alert("计划投资的其中财政不能大于总额！");
        return false;
    }
    //验证项目建设起止时间
    isTrue = notEmpty($("XM_STARTDATE").value,true,"项目建设开始时间不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = notEmpty($("XM_ENDDATE").value,true,"项目建设结束时间不能为空！");
    if( !isTrue){
        return false;
    }
    if($("XM_ENDDATE").value<$("XM_STARTDATE").value){
        alert("项目建设开始时间不能大于结束时间！");
        return false;
    }

    //验证项目联系人
    isTrue = notEmpty($("TB_MAN").value,true,"项目联系人不能为空！");
    if( !isTrue){
        return false;
    }
    isTrue = validata_length(TB_MAN,"项目联系人",200);
    if( !isTrue){
        return false;
    }
    //验证联系人电话
    isTrue = notEmpty($("TB_PHONE").value,true,"联系电话不能为空！");
    if( !isTrue) {
        return false;
    }
    isTrue = checkPhone1($("TB_PHONE").value,"联系人电话有误！");
    if(!isTrue) {
        return false;
    }
    //判断是否上传附件
    //if(attachCount(getDJID(),djbh) == 0){
    //  alert("请上传请示公文！");
    //  return false;
    //}
    //验证是否选择了评审科室
    if(actionId == "zxsb_wp1_act2") {
        if( $("zxsb_wp1_act4").value != "Y" && $("zxsb_wp1_act3").value != "Y" && $("zxsb_wp1_act6").value != "Y" && $("zxsb_wp1_act5").value != "Y" ){
            alert("请至少选择一个评审科室！");return false;
        }
    }
    //验证需要签阅意见的环节有没有签阅意见
    if(actionId == "zxsb_wp1_act3") {//规划研究科审核
        if (!contextInfo[0][2]) {
            alert("请填写评审意见！");
            return false;
        }
    }
    if(actionId == "zxsb_wp1_act4") {//资源开发科审核
        if (!contextInfo[1][2]) {
            alert("请填写评审意见！");
            return false;
        }
    }
    if(actionId == "zxsb_wp1_act5") {//电子政务科审核
        if (!contextInfo[2][2]) {
            alert("请填写评审意见！");
            return false;
        }
    }
    if(actionId == "zxsb_wp1_act6") {//办公室审核
        if (!contextInfo[3][2]) {
            alert("请填写评审意见！");
            return false;
        }
    }
    
    //if(actionId == "zxsb_wp1_act12"){
    //  if($("checkbox1").value == 1){
    //      if($("TB_Money").value.trim() == "0.00" || $("TB_Money").value.trim() == "" || $("TB_Money").value.trim() == null){
    //          alert("请编辑信息中心审批金额！");
    //          return false;
    //      }
    //      isTrue = checkNum1($("TB_Money").value,20,2,"信息中心审批金额必须为小于18位的实数!");
    //      if( !isTrue){
    //          return false;
    //      }
    //      if(parseFloat($("TB_Money").value) > parseFloat($("XM_ALL_MONEY").value)) {
    //          alert("信息中心审批金额不能大于项目总投资总额！");
    //          return false;
    //      }
    //      if(wordResults[1].saved == false){
    //          alert("请填写并保存专家意见！");
    //          return false;
    //      }
    //  }
    //}
    return true;
}
//保存业务数据
function saveBusinessDate(dataset,type) {
    //设置主数据集 主要用表单上存在多个数据集的情况
    fcpubvar.DsMain = "" + dataset;
    //流程开始要清空临时使用的djbh
    //var b = isTempAttachId(djbh);
    //if (b) {
    //  djbh = "";  
    //}
    //修改参与人
    var lccyr = $("text_lccyr").value;
    var rowlccyr = lccyr;
    if (type == 1) {        
        if (lccyr.length == 0)
            lccyr = "@" + currentUser + "@";
        else
            lccyr = lccyr + ",@" + currentUser + "@";
        
    } else if (type == 2) {
        if (lccyr.length == 0)
            lccyr = "$" + currentUser + "$";
        else
            lccyr = lccyr + ",$" + currentUser + "$";
    }
    $("text_lccyr").value = lccyr;
    //保存数据
    var result = DjSave();
    if (result == "") {  //数据保存成功
        alert("数据保存成功！");
        return true;
    } else {
        alert("保存数据失败！");
        $("text_lccyr").value = rowlccyr;  //还原参与人
        return false;
    }
}
//获取已经签阅的所有意见
function getPSYJ() {
    var temp = "";
    currentIndex = 0;
    getAllAuditIdeaFromDB();
    temp = $("textarea_psyj").value;
    $("textarea_psyj").value = "";
    currentIndex = 1;
    getAllAuditIdeaFromDB();
    temp += $("textarea_psyj").value;
    $("textarea_psyj").value = "";
    currentIndex = 2;
    getAllAuditIdeaFromDB();
    temp += $("textarea_psyj").value;
    $("textarea_psyj").value = "";
    currentIndex = 3;
    getAllAuditIdeaFromDB();
    temp += $("textarea_psyj").value;
    $("textarea_psyj").value = temp;
    temp = "";
}
//表单加载时调用的函数
function init() {
    //原始数据初始化
    var os = new Array(ToInt(GetDate().substring(0,4)) - 1 + "", GetDate().substring(0,4), ToInt(GetDate().substring(0,4)) + 1 + "");
    addOptions(text_wjn, os, os);   
    addOptions(TZ_YEAR, os, os);    
    text_wjn.value = GetDate().substring(0,4);
    TZ_YEAR.value = GetDate().substring(0,4);
    TZ_YEAR.onchange();
    var status = "";
    if (creator_hasElementSwitch()) {
        status = "worked";
    } else if (lcslid != "") {
        status = "look";
    } else {
        status = "todo";
    }
    if (status == "worked" || status == "look") {
        if (status == "worked") {
            dataset1.Open(sel_sql);
        } else {
            var sel_sql_look = base_sql + " where LCSLID = '" + lcslid + "'"; 
            dataset1.Open(sel_sql_look);
        }       
        djbh = dataset1.Fields.Field["LCSLID"].Value;
        getPSYJ();
        currentIndex = 4;
        getAllAuditIdeaFromDB();                        
        creator_elementAuthority();
        //paraQSBG = {type : "common", id : djbh + "_1", flag : "show"};
        //paraZJPS = {type : "common", id : djbh + "_3", flag : "show"};
        if (status == "look") {
            //隐藏流程控件
            workflowControl1.style.display = "none";
            //关闭按钮（按钮用于查看页面）
            button_close.style.display="block";
        }
    } else if (status == "todo") {
        //初始化业务数据
        initBusinessData();
        //只读状态控制
        var result = creator_getElementAuthority(actionId,getDJID());
        var ids = result.readonlyId.split(",");
        var styles = result.readonlyStyle.split(",");
        for (var i = 0, count = ids.length; i < count; i++) {
            if (ids[i] != "") {
                var style = (styles[i] == "") ? "nolinetext_xtbg" : styles[i];
                elementReadOnlyPro($(ids[i]),style);
            }
        }
        //disabled状态控制
        var disabledIds = result.disabledId.split(",");
        for (var i = 0, count = disabledIds.length; i < count; i++) {
            if (disabledIds[i] != "") {
                $(disabledIds[i]).disabled = true;
            }
        }
        //隐藏状态控制
        var hiddenIds = result.hiddenId.split(",");
        for (var i = 0, count = hiddenIds.length; i < count; i++) {
            if (hiddenIds[i] != "") {
                $(hiddenIds[i]).style.display = "none";
            }
        }
        if (actionId == "zxsb_wp1_act2") { //经办受理
            $("psks1").style.display = "";
            $("psks2").style.display = "";
            $("psks3").style.display = "";
            $("psks4").style.display = "";
            workflowControl_selectAndUser.style.display = "none";
        }
        if (actionId == "zxsb_wp1_act8") { //经办
            $("sfxyzjps").style.display = "block";
            if($("TB_Money").value == "0.00") {
                $("TB_Money").value = "";
            }
        }
        if (actionId == "zxsb_wp1_act8") {
            workflowControl_selectAct_div.style.display = "none";
        }

        //修改文件状态信息
        $('text_wjzt').value = actionName;
        if (actionId != "zxsb_wp1_act1") {
            //修改附件为只读状态
            //lookAttach(getDJID(),djbh,"fj");
        }
        //paraQSBG = {type : "common", id : djbh + "_1", flag : ((actionId == "zxsb_wp1_act12") ? "show" : "edit"), showType : showTypeQSBG, editType : editTypeQSBG, template : "1245394180937", loadType : "auto", fillDataFun : "fillWordDataQSBG", remoteFun : "", buttonStatus : ""};
        //paraZJZMD = {type : "common", id : djbh + "_2", flag : "print", template : "1245378822062", loadType : "force", fillDataFun : "fillWordDataZJZMD"};
        //paraZJPS = {type : "common", id : djbh + "_3", flag : "edit", showType : "1", editType : "1,0", template : "1245400606703", fillDataFun : "fillWordDataZJPS"};
    }
}
//下一步活动
function myNextAction(dataset,flag,_location) {
    if (flag == "启动流程" || flag == "完成活动" || flag == "暂存") {
        //数据验证
        if (!validate()) {
            return false;
        }
    }
    if ((flag == "启动流程" || flag == "完成活动") && actionId == "zxsb_wp1_act2"){
        //与分支选择执行人
        if (!getANDSPLITUSERS()) {
            return false;
        }
        
    }
    //选择执行人
    if (!hasSelectUser(flag)) {
        alert("请您选择执行人！");
        return false;
    }

    var result = true;
    //工作流接口 完成活动
    if (flag == "启动流程") {
        if (confirm("您是否确定启动流程？")) {
            if(!saveFromDate(flag,dataset)){
                alert("保存数据成失败");
                return false;
            }
            result = creator_djsave('启动流程',false,false);
            if (result != "false") {
                alert("您已经成功的启动流程！");
            } else {
                alert("您启动流程失败！");
                return false;       
            }
        } else {
            return false;
        }
    } else if (flag == "完成活动") {
        var tempstr = "您是否确定完成活动？";
        if (confirm(tempstr)) {
            if(!saveFromDate(flag,dataset)){
                return false;
            }
            result = creator_djsave('完成活动',false,false);
            if (result != "false") {
                alert("您已经成功的完成活动！");
            } else {
                alert("您完成活动失败！");
                return false;
            }
        } else{
            return false;
        }
    } else if (flag == "回退") {
        if (confirm("您是否确定回退？")) {
            if(!saveFromDate(flag,dataset)){
                return false;
            }
            result = creator_djsave('回退',false,false);
            if (result != "false") {
                alert("您已经成功的进行回退操作！");
            } else {
                alert("您进行的回退操作失败！");
                return false;
            }
        } else{
            return false;
        }
    } else if (flag == "收回") {
        if (confirm("您是否确定收回？")) {
            if(!saveFromDate(flag,dataset)){
            return false;
            }
            result = creator_djsave('收回',false,false);
            if (result != "false") {
                alert("您已经成功的进行收回操作！");
            } else {
                alert("您进行的收回操作失败！");
                return false;
            }
        } else{
                return false;
        }
    } else if (flag == "终止流程") {
        if (confirm("您是否确定终止流程？")) {
            if(!saveFromDate(flag,dataset)){
                return false;
            }
            result = creator_djsave('终止流程',false,false);
            if (result != "false") {
                var del_clyj = "delete from ta_xmgl_xmsbclyj where lcslid = '" + djbh + "'";
                var del_xmsb = "delete from ta_xmgl_xmsb where lcslid = '" + djbh + "'";
                if (delAttachByBh(djbh,getDJID(),"dzzwpt")&& IsSpace(InsertSql(del_clyj)) && IsSpace(InsertSql(del_xmsb))) {
                    alert("您已经成功的终止流程！");
                } else {
                    alert("您终止流程失败！");
                    return false;
                }
            } else {
                alert("您终止流程失败！");
                return false;
            }
        } else {
            return false;
        }
    } else if (flag == "暂存") {
        if (confirm("您是否确定暂存？")) {
            if(!saveFromDate(flag,dataset)){
                return false;
            }
            result = creator_djsave('暂存',false,false);
            if (result != "false") {
                alert("您暂存数据成功！");
            } else {
                alert("您暂存数据失败！");
                return false;
            }
        } else{
                return false;
        }
    }
    //页面需要跳转
    /*portlet*/
    window.open("<%=request.getContextPath() %>/common_workflow/main.jsp","perspective_content");
    /*portlet*/
}
//选择执行人
function selectActors() {
    adduser();
}
//选择与分支执行人
function selectAndActors() {
    addAndUser();
}
//办结列表表单元素权限控制
function creator_elementAuthority(){
            
    XM_TYPE.disabled = true;
    button4.style.display = "none";
    button9.style.display = "none";
    button13.style.display = "none";
    button14.style.display = "none";
    $("JS_AIM").readOnly = true;
    $("JS_CONTENT").readOnly = true;
    button_ghyjk.style.display = "none";
    button_dzzwk.style.display = "none";
    button_zykfk.style.display = "none";
    button_bgs.style.display = "none";
    elementReadOnly(GH_NAME,'nolinetext_xtbg');
    elementReadOnly(TB_Money,'nolinetext_xtbg');
    elementReadOnly(TZ_YEAR,'nolinetext_xtbg');
    elementReadOnly(TB_dept,'nolinetext_xtbg');
    elementReadOnly(text_wjzt,'nolinetext_xtbg');
    elementReadOnly(TB_Number,'nolinetext_xtbg');
    elementReadOnly(text_wjn,'nolinetext_xtbg');
    elementReadOnly(TB_MAN,'nolinetext_xtbg');
    elementReadOnly(TB_PHONE,'nolinetext_xtbg');
    elementReadOnly(TB_DATE,'nolinetext_xtbg');
    elementReadOnly(XM_NAME,'nolinetext_xtbg');
    elementReadOnly(ZR_DEPT,'nolinetext_xtbg');
    elementReadOnly(ZR_MAN,'nolinetext_xtbg');
    elementReadOnly(ZR_PHONE,'nolinetext_xtbg');
    elementReadOnly(XM_ALL_MONEY,'nolinetext_xtbg');
    elementReadOnly(XM_ALL_FINANCE,'nolinetext_xtbg');
    elementReadOnly(XM_ALL_OTHER,'nolinetext_xtbg');
    elementReadOnly(JHTZ_MONEY,'nolinetext_xtbg');
    elementReadOnly(SJTZ_MONEY,'nolinetext_xtbg');
    elementReadOnly(JHTZ_ALL_MONEY,'nolinetext_xtbg');
    elementReadOnly(JHTZ_ALL_FINANCE,'nolinetext_xtbg');
    elementReadOnly(JHTZ_ALL_OTHER,'nolinetext_xtbg');
    elementReadOnly(XM_STARTDATE,'nolinetext_xtbg');
    elementReadOnly(XM_ENDDATE,'nolinetext_xtbg');
    lookAttach(getDJID(),djbh,"fj");
}
//保存业务数据
function saveFromDate(flag,dataset){
    var result = true;
    //业务数据保存
    if (flag == "启动流程" || flag == "完成活动") {
        result = saveBusinessDate(dataset,1);
    } else if (flag == "终止流程") {
        //result = saveBusinessDate(dataset,2);
    } else {
        result = saveBusinessDate(dataset,1);
    }
    return result;
}
//验证电话号码
function checkPhone1(value,alertValue){
    var regExp = /(^\d{7,8}$)|(^0\d{3}-?\d{7,8}$)|(^0?1[35]\d{9}$)/;
    value = value.trim();
    if(!IsSpace(value)){
        if(!regExp.test(value)){
            alert(alertValue);
            return false;
        }
    }
    return true;
}

/**验证长度**/
function validata_length(obj,titles,length){
    if(obj.value.length > length){
        alert("【"+titles + "】长度不能超过" + length + "个字符！");
        obj.focus();
        return false;  
    } else {
        return true;
    }
}

//保证浮点型保留两位小数
function formatNum(value) {
    value = value.toString();
    var index = value.indexOf(".");
    if(index != "-1"){
        value = value.split(".")[0] +"."+ (value.split(".")[1]).substr(0,2);
    }else {
        value = value + ".00";
    }
    return value;
}

//验证数字
function checkNum1(value,intLength,floatLength,alertValue){
    value = value.trim();
    var regExp = /^(-|\+)?\d+(\.)?(\d+)*$/;
    var index = value.indexOf(".");
    if(!IsSpace(value)){
        var values = new Array();
        if(index != "-1"){
            values[0] = value.substring(0,index);
            values[1] = value.substring(index+1,value.length);
        }
        else{
            values[0] = value;
            values[1] = "0";
        }
        if(floatLength==0&&index!="-1"){
            alert(alertValue);
            return false;
        }
        if(values[0].length>intLength){
            alert(alertValue);
            return false;
        }
        else if(floatLength!=0){
            if(values[1].length>floatLength){
                alert(alertValue);
                return false;
            }
        }
        if(!regExp.test(value)){
            alert(alertValue);
            return false;
        }
    }
    return true;
}

var zjxxlb = "";
function randomSimpale() {
    zjxxlb = $("text_zjlbxx").value;
    window.showModalDialog(getOpenUrlByDjid('20090617124344640053') + "&cc_form_instanceid=" + cc_form_instanceid, window);
    $("text_zjlbxx").value = zjxxlb;
    getZJLB();
}
function deleteZJLB(force) {
    force = (force == undefined) ? false : force;
    if (force == true || $("text_zjlbxx").value == "") {
        var delSql = "delete from ta_xmgl_xmsbzjlb t where t.xm_id = '" + djbh + "'";
        if (!IsSpace(InsertSql(delSql))) {
            return;
        }
    }
}
function getZJLB() {
    deleteZJLB();   
    var zjlbSql = "select t1.id,t1.xm,t1.xb,t1.gzdw,t1.zw,t4.lb,t1.zc,t1.zyyjfx from ta_xmgl_zjk t1,ta_xmgl_xmsb t2,ta_xmgl_xmsbzjlb t3,ta_xmgl_zjlb t4 where t1.id=t3.zjid and t1.zjlbid = t4.id and t3.xm_id=t2.lcslid and t2.lcslid='" + djbh + "'";
    dataset2.Open(zjlbSql);
}
//是否需要专家评审复选框改变时事件
function checkboxChanged() {
    if($("checkbox1").value == "1") {
        $("psxx").style.display = "block";
        $("TB_Money").value = "";
        $("TB_Money").style.display = "none";
        workflowControl_selectAct.options[1].selected = true;
    } else {
        $("psxx").style.display = "none";
        workflowControl_selectAct.options[0].selected = true;
        $("TB_Money").style.display = "block";
    }   
}
//从专家列表进入查看专家的详细信息
function showinfo(){
    var tmp = creator_getSession("cc_form_instanceid");
    var id = dataset2.Fields.Field['id'].Value;
    window.showModalDialog(getOpenUrlByDjid('20090622111607234815') + "&id=" + id, window);
    creator_setSession("cc_form_instanceid",tmp);
}
//请示报告
function fillWordDataQSBG(wordApplication) {
    var tb_dept = $("TB_dept").value; //填表单位
    var xm_name = $("XM_NAME").value; //项目名称
    var tb_date = $("TB_DATE").value; //填表日期
    var xm_all_money = $("XM_ALL_MONEY").value; //项目总投资总额
    var word = new SimpleWord(wordApplication); 
    word.insertTextRange("xtbg_sqdw1",tb_dept);
    word.insertTextRange("xtbg_sqdw2",tb_dept);
    word.insertTextRange("xtbg_sqdw3",tb_dept);
    word.insertTextRange("xtbg_sqdw4",tb_dept);
    word.insertTextRange("xtbg_xmmc1",xm_name);
    word.insertTextRange("xtbg_xmmc2",xm_name);
    word.insertTextRange("xtbg_tbrq",tb_date);
    word.insertTextRange("xtbg_tje",xm_all_money);
}
//打印
function fillWordDataZJZMD(wordApplication) {
    var sql = "select k.xm, k.xb, k.gzdw, k.zw, k.zc, k.zyyjfx, k.bghm, k.email from ta_xmgl_zjk k where k.id in (select l.zjid from ta_xmgl_xmsbzjlb l where l.xm_id = '" + djbh + "')";
    var result = executeSelect(sql, 1, -1);
    var values = [];
    for (var i = 0, count = result.length; i < count; i++) {
        values.push(i + 1);
        values.push(result[i][0]);
        values.push(result[i][1]);
        values.push(result[i][2]);
        values.push(result[i][3]);
        values.push(result[i][4]);
        values.push(result[i][5]);
        values.push(result[i][6] + "\r\n" +result[i][7]);
    }
    var word = new SimpleWord(wordApplication); 
    word.insertTextRange("xtbg_xmmc",$("XM_NAME").value);
    word.setTableValueAutoInsertRow("xtbg_zjzmd",2,1,8,values);
}
//专家评审意见
function fillWordDataZJPS(wordApplication) {
    var xm_mc = $("XM_NAME").value;
    var word = new SimpleWord(wordApplication); 
    word.insertTextRange("xtbg_xmmc1",xm_mc);
    word.insertTextRange("xtbg_xmmc2",xm_mc);
}
function dataXMZTZ() {
    var _XM_ALL_MONEY = XM_ALL_MONEY.value;
    var _XM_ALL_FINANCE = XM_ALL_FINANCE.value;
    if (_XM_ALL_MONEY != "" && _XM_ALL_FINANCE != "") {
        var other = parseFloat(_XM_ALL_MONEY) - parseFloat(_XM_ALL_FINANCE);
        if (other < 0) {
            alert("项目总投资总额必须大于项目总投资其中财政！");
            XM_ALL_OTHER.value = "";
            return false;
        } else {
            XM_ALL_OTHER.value = formatNum(other);
            return true;
        }
    }
}
function dataYWCTZ() {
    var _JHTZ_MONEY = JHTZ_MONEY.value;
    var _SJTZ_MONEY = SJTZ_MONEY.value;
    if (_JHTZ_MONEY != "" && _SJTZ_MONEY != "") {
        var other = parseFloat(_JHTZ_MONEY) - parseFloat(_SJTZ_MONEY);
        if (other < 0) {
            alert("已完成投资计划额必须大于实际完成投资额！");
            return false;
        }
    }
    return true;
}
function dataJHTZJLY() {
    var _JHTZ_ALL_MONEY = JHTZ_ALL_MONEY.value;
    var _JHTZ_ALL_FINANCE = JHTZ_ALL_FINANCE.value;
    if (_JHTZ_ALL_MONEY != "" && _JHTZ_ALL_FINANCE != "") {
        var other = parseFloat(_JHTZ_ALL_MONEY) - parseFloat(_JHTZ_ALL_FINANCE);
        if (other < 0) {
            alert("计划投资及来源总额必须大于其其中财政！");
            JHTZ_ALL_OTHER.value = "";
            return false;
        } else {
            JHTZ_ALL_OTHER.value = formatNum(other);
            return true;
        }
    }
}
//清空日期
function clearDate() {
    $("XM_STARTDATE").value = "";
    $("XM_ENDDATE").value = "";
}
function selectPSKSActor(actDefId, text_id, text_name) {
    var users = $(text_id).value;
    var actDefId = actDefId;"zxsb_wp1_act4";
    var tmp = '<%=request.getParameter("mgrName")%>';
    tmp = tmp.split("#");
    var pkgId = tmp[0];
    var version = tmp[1];
    var procDefId = tmp[2];
    var ret = showModalDialog('<%=request.getContextPath()%>/common_workflow/select_user.jsp?actDefId='+actDefId+'&inputText='+actDefId
    +'&pkgId=' + pkgId + '&version=' + version + '&procDefId=' + procDefId + '&type=act'+'&users='+users
    ,'newWin'
    ,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
    if (ret != null) {
        $(text_id).value = ret.split("|")[0];
        $(text_name).value = ret.split("|")[1];
    }
}
function selectActorControl(checkbox, button, text) {
    $(button).disabled = ($(checkbox).value == 'Y') ? false : true;
    $(text).disabled = ($(checkbox).value == 'Y') ? false : true;
}
function getANDSPLITUSERS() {
    var result = "";
    if ($("zxsb_wp1_act3").value == "Y" && $("text_ghyjk_").value == "") {
        alert("请选择规划研究科执行人！");
        return false;
    } else if ($("zxsb_wp1_act3").value == "Y") {
        result = result + "zxsb_wp1_act3:" + $("text_ghyjk_").value + ";";
    }
    if ($("zxsb_wp1_act4").value == "Y" && $("text_zykfk_").value == "") {
        alert("请选择资源开发科执行人！");
        return false;
    } else if ($("zxsb_wp1_act4").value == "Y") {
        result = result + "zxsb_wp1_act4:" + $("text_zykfk_").value + ";";
    }
    if ($("zxsb_wp1_act5").value == "Y" && $("text_dzzwk_").value == "") {
        alert("请选择电子政务科执行人！");
        return false;
    } else if ($("zxsb_wp1_act5").value == "Y") {
        result = result + "zxsb_wp1_act5:" + $("text_dzzwk_").value + ";";
    }
    if ($("zxsb_wp1_act6").value == "Y" && $("text_bgs_").value == "") {
        alert("请选择办公室执行人！");
        return false;
    } else if ($("zxsb_wp1_act6").value == "Y") {
        result = result + "zxsb_wp1_act6:" + $("text_bgs_").value + ";";
    }
    if (result == "") {
        alert("请选择执行人！");
        ANDSPLITUSERS.value = "";
        return false;
    } else {
        ANDSPLITUSERS.value = result;
        return true;
    }
}
function openWordQSBG() {
    var result = openWord(paraQSBG);
    if (result != null && result != undefined) {
        wordResults[0] = result;
    }   
}
function openWordZJPS() {
    var result = openWord(paraZJPS);
    if (result != null && result != undefined)  {
        wordResults[1] = result;
    }   
}

function editAffix(){
var fjid = $("text_fjid").value;
if(IsSpace(fjid)){
fjid = getFjId();
}
var operType='readonly';
if(actionId=='zxsb_wp1_act1'){
operType="";
}
showModalDialog(getOpenUrlByDjid('20090903152316781786') + "&djbh=" +fjid+"&operType="+operType,window,"status:yes;resizable:yes;unadorne:yes;center:yes");
$("text_fjid").value = fjid;
}

function getFjId(){
return SqlToField("select dzzwpt.SEQ_FW_FJID.nextval from dual");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><checkbox><id>zxsb_wp1_act3</id><id>zxsb_wp1_act4</id><id>zxsb_wp1_act5</id><id>zxsb_wp1_act6</id></checkbox><radio><id>XM_TYPE</id></radio><textarea><id>JS_AIM</id><id>JS_CONTENT</id><id>textarea_psyj</id></textarea><combobox><id>text_wjn</id><id>TZ_YEAR</id><id>workflowControl_selectAct</id></combobox><div><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_terminate</id><id>workflowControl_tempSaveForm</id><id>div_width</id></div><button><id>button4</id><id>button_ghyjk_</id><id>button_zykfk_</id><id>button_dzzwk_</id><id>button_bgs_</id><id>affix_upload</id><id>button_ghyjk</id><id>button_dzzwk</id><id>button_zykfk</id><id>button_bgs</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_wchd</id><id>button_ht</id><id>button_hs</id><id>button_zzlc</id><id>button_zc</id><id>button_close</id></button><text><id>text_ywlb</id><id>text_lccyr</id><id>text_wjzt</id><id>TB_Number</id><id>TB_dept</id><id>XM_NAME</id><id>ZR_DEPT</id><id>ZR_MAN</id><id>ZR_PHONE</id><id>GH_NAME</id><id>XM_ALL_MONEY</id><id>XM_ALL_FINANCE</id><id>XM_ALL_OTHER</id><id>JHTZ_MONEY</id><id>text_TZ_YEAR</id><id>SJTZ_MONEY</id><id>JHTZ_ALL_MONEY</id><id>JHTZ_ALL_FINANCE</id><id>JHTZ_ALL_OTHER</id><id>XM_STARTDATE</id><id>XM_ENDDATE</id><id>TB_MAN</id><id>TB_PHONE</id><id>TB_DATE</id><id>text_ghyjk</id><id>text_ghyjk_</id><id>text_zykfk</id><id>text_zykfk_</id><id>text_dzzwk</id><id>text_dzzwk_</id><id>text_bgs</id><id>text_bgs_</id><id>text_fjid</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>zxsb_wp1_act3</taborder><taborder>zxsb_wp1_act4</taborder><taborder>zxsb_wp1_act5</taborder><taborder>zxsb_wp1_act6</taborder><taborder>XM_TYPE</taborder><taborder>JS_AIM</taborder><taborder>JS_CONTENT</taborder><taborder>textarea_psyj</taborder><taborder>text_wjn</taborder><taborder>TZ_YEAR</taborder><taborder>workflowControl_selectAct</taborder><taborder>button4</taborder><taborder>button_ghyjk_</taborder><taborder>button_zykfk_</taborder><taborder>button_dzzwk_</taborder><taborder>button_bgs_</taborder><taborder>button_ghyjk</taborder><taborder>button_dzzwk</taborder><taborder>button_zykfk</taborder><taborder>button_bgs</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zzlc</taborder><taborder>button_zc</taborder><taborder>button_close</taborder><taborder>text_ywlb</taborder><taborder>text_lccyr</taborder><taborder>text_wjzt</taborder><taborder>TB_Number</taborder><taborder>TB_dept</taborder><taborder>XM_NAME</taborder><taborder>ZR_DEPT</taborder><taborder>ZR_MAN</taborder><taborder>ZR_PHONE</taborder><taborder>GH_NAME</taborder><taborder>XM_ALL_MONEY</taborder><taborder>XM_ALL_FINANCE</taborder><taborder>XM_ALL_OTHER</taborder><taborder>JHTZ_MONEY</taborder><taborder>text_TZ_YEAR</taborder><taborder>SJTZ_MONEY</taborder><taborder>JHTZ_ALL_MONEY</taborder><taborder>JHTZ_ALL_FINANCE</taborder><taborder>JHTZ_ALL_OTHER</taborder><taborder>XM_STARTDATE</taborder><taborder>XM_ENDDATE</taborder><taborder>TB_MAN</taborder><taborder>TB_PHONE</taborder><taborder>TB_DATE</taborder><taborder>text_ghyjk</taborder><taborder>text_ghyjk_</taborder><taborder>text_zykfk</taborder><taborder>text_zykfk_</taborder><taborder>text_dzzwk</taborder><taborder>text_dzzwk_</taborder><taborder>text_bgs</taborder><taborder>text_bgs_</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder><taborder>affix_upload</taborder><taborder>text_fjid</taborder></root>" dj_sn="20090903095615828224" caption="项目申报" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="lcslid" isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue1" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib="allStyle.css" version="1.0" creator_pagination type="ZW" creatorType="20090901175633734792" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/xtbg/js/Validate.js&#13;&#10;../../../ccapp/xtbg/js/PubFun.js&#13;&#10;../../../ccapp/xtbg/js/QianYueYiJian.js">

<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD vAlign=top><DIV align=center><DIV class=title align=center>长沙市信息化建设项目申报表<INPUT id=text_ywlb style="DISPLAY: none; LEFT: 0px; WIDTH: 17px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=2 controltype="text" field="YWLB" china="业务类别" dataset="dataset1"><INPUT id=text_lccyr style="DISPLAY: none; LEFT: 0px; WIDTH: 18px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=3 controltype="text" field="LCCYR" china="流程参与人" dataset="dataset1"></DIV>
               <TABLE class=hidetable cellSpacing=0 cellPadding=0 width="90%" border=0>
                  <TBODY>
                     <TR>
                        <TD width="15%">文件状态</TD>
                        <TD width="15%"><INPUT class=nolinetext id=text_wjzt style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 110%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=9 controltype="text" field="WJZT" china="文件状态" dataset="dataset1"></TD>
                        <TD></TD>
                        <TD width="10%"><DIV align=right>编号<FONT color=#ff0000>*</FONT></DIV></TD>
                        <TD width="15%">&nbsp;<INPUT class=canWrite id=TB_Number style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 165px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 controltype="text" field="BHH" china="编号号" dataset="dataset1"></TD>
                        <TD width="10%"><DIV align=right>年号<FONT color=#ff0000>*</FONT></DIV></TD>
                        <TD width="15%">&nbsp;<SELECT id=text_wjn style="LEFT: 0px; WIDTH: 162px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() sqltrans controltype="combobox" field="BHN" china="编号年" dataset="dataset1" tempvalue temptext sql check="1"></SELECT></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <TABLE class=formtable width="90%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>填表单位<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><DIV align=left><INPUT class=canWrite id=TB_dept style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=91 name=Input controltype="text" field="TB_DEPT" china="填表单位" dataset="dataset1"></DIV></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>项目名称<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><INPUT class=canWrite id=XM_NAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=78 controltype="text" field="XM_NAME" china="项目名称" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>责任单位<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><INPUT class=canWrite id=ZR_DEPT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=80 controltype="text" field="ZR_DEPT" china="责任单位" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>项目责任人及联系电话<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4>责任人<INPUT class=canWrite id=ZR_MAN style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=29 controltype="text" field="ZR_MAN" china="责任人" dataset="dataset1">&nbsp;电话<INPUT class=canWrite id=ZR_PHONE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=28 controltype="text" field="ZR_PHONE" china="责任人电话" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>目标（包括总体目标及阶段目标）<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><TEXTAREA id=JS_AIM style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() cols=92 controltype="textarea" field="JS_AIM" china="目标（包括总体目标与阶段目标）" dataset="dataset1" value="textarea1" induce="否"></TEXTAREA></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>建设内容(包括总体建设内容及阶段建设内容)<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><TEXTAREA id=JS_CONTENT style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() cols=91 controltype="textarea" field="JS_CONTENT" china="建设内容（包括总体建设内容与阶段建设内容）" dataset="dataset1" value="textarea2" induce="否"></TEXTAREA></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>是否有总体规划及规划名称</TD>
                        <TD width="60%" colSpan=4><INPUT class=canWrite id=GH_NAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=83 controltype="text" field="GH_NAME" china="是否有总体规划及规划名称" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>项目类别<FONT color=#ff0000>*</FONT></TD>
                        <TD width="60%" colSpan=4><FIELDSET id=XM_TYPE contentEditable=false style="LEFT: 0px; WIDTH: 369px; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 40px" onmovestart=moveStart() controltype="radio" field="XM_TYPE" china="项目类别" dataset="dataset1" tempvalue="续建&#13;&#10;新开工&#13;&#10;预开工" temptext="续建&#13;&#10;新开工&#13;&#10;预开工" aspect="横向" legend NotBg="是" value><LEGEND></LEGEND><INPUT type=radio value=续建 name=RGXM_TYPE text="续建"><SPAN onclick=RGXM_TYPE[0].checked=true;XM_TYPE.value=RGXM_TYPE[0].value;RGXM_TYPE[0].focus();>续建</SPAN>&nbsp;<INPUT type=radio value=新开工 name=RGXM_TYPE text="新开工"><SPAN onclick=RGXM_TYPE[1].checked=true;XM_TYPE.value=RGXM_TYPE[1].value;RGXM_TYPE[1].focus();>新开工</SPAN>&nbsp;<INPUT type=radio value=预开工 name=RGXM_TYPE text="预开工"><SPAN onclick=RGXM_TYPE[2].checked=true;XM_TYPE.value=RGXM_TYPE[2].value;RGXM_TYPE[2].focus();>预开工</SPAN>&nbsp;</FIELDSET></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="10%" rowSpan=3>项目总投资<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="30%">总额（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=XM_ALL_MONEY style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=82 controltype="text" field="XM_ALL_MONEY" china="项目总投资" dataset="dataset1" onblur='bill_onexit("dataXMZTZ()")'></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="30%">其中财政（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=XM_ALL_FINANCE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=81 controltype="text" field="XM_ALL_FINANCE" china="项目总财政" dataset="dataset1" onblur='bill_onexit("dataXMZTZ()")'></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="30%">其它（万元）</TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=nolinetext id=XM_ALL_OTHER style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=80 controltype="text" field="XM_ALL_OTHER" china="项目总其它" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="10%" rowSpan=2>已完成投资<FONT color=#ff0000>*</FONT></TD>
                        <TD width="30%"><SELECT id=TZ_YEAR style="LEFT: 0px; WIDTH: 64px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("text_TZ_YEAR.value = TZ_YEAR.value;")' sqltrans controltype="combobox" field="TZ_YEAR" china="投资年份" dataset="dataset1" tempvalue temptext sql check="1"></SELECT>年计划额（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=JHTZ_MONEY style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=79 controltype="text" field="JHTZ_MONEY" china="年度计划投资金额" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="30%"><INPUT class=nolinetext id=text_TZ_YEAR style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 64px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=9 controltype="text" field="TZ_YEAR" china="投资年份" dataset="dataset1">年实际完成投资额（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=SJTZ_MONEY style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=79 controltype="text" field="SJTZ_MONEY" china="年度实际投资金额" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="10%" rowSpan=3>计划投资及来源<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="30%">总额（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=JHTZ_ALL_MONEY style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=80 controltype="text" field="JHTZ_ALL_MONEY" china="计划投资总金额" dataset="dataset1" onblur='bill_onexit("dataJHTZJLY()")'></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="30%">其中财政（万元）<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=canWrite id=JHTZ_ALL_FINANCE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("dataJHTZJLY()")' size=82 controltype="text" field="JHTZ_ALL_FINANCE" china="计划投资总财政" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="30%">其它（万元）</TD>
                        <TD class=tdLabel width="60%" colSpan=4><INPUT class=nolinetext id=JHTZ_ALL_OTHER style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=81 controltype="text" field="JHTZ_ALL_OTHER" china="计划投资总其它" dataset="dataset1"></TD>
                     </TR>
                     <TR>
                        <TD class=tdLabel width="40%" colSpan=2>项目建设起止时间<FONT color=#ff0000>*</FONT></TD>
                        <TD class=tdLabel width="60%" colSpan=4>从<INPUT class=canWrite id=XM_STARTDATE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 115px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=18 controltype="text" field="XM_STARTDATE" china="项目建设开始日期" dataset="dataset1" onclick='bill_onclick("SelectDate()")'>&nbsp;到<INPUT class=canWrite id=XM_ENDDATE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 116px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=19 controltype="text" field="XM_ENDDATE" china="项目建设结束日期" dataset="dataset1" onclick='bill_onclick("SelectDate()")'>&nbsp;<BUTTON class=botton id=button4 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("clearDate()")'>清空日期</BUTTON></TD>
                     </TR>
                     <TR>
                        <TD width="10%">项目联系人<FONT color=#ff0000>*</FONT></TD>
                        <TD width="30%">&nbsp;<INPUT class=canWrite id=TB_MAN style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 165px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 controltype="text" field="TB_MAN" china="项目联系人" dataset="dataset1"></TD>
                        <TD width="10%">联系电话<FONT color=#ff0000>*</FONT></TD>
                        <TD width="20%"><INPUT class=canWrite id=TB_PHONE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=22 controltype="text" field="TB_PHONE" china="联系电话" dataset="dataset1"></TD>
                        <TD width="10%">填表日期<FONT color=#ff0000>*</FONT></TD>
                        <TD width="20%"><INPUT class=canWrite id=TB_DATE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=30 controltype="text" field="TB_DATE" china="填表日期" dataset="dataset1"></TD>
                     </TR>
                     <TR id=psks1 style="DISPLAY: none">
                        <TD width="10%" rowSpan=4>评审科室</TD>
                        <TD width="30%"><DIV id=zxsb_wp1_act3 style="LEFT: 0px; FLOAT: left; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() noWrap controltype="checkbox" NotBg="否" value="N" onclick="bill_onclick(&quot;selectActorControl('zxsb_wp1_act3', 'button_ghyjk_','text_ghyjk')&quot;)" truevalue="Y" falsevalue="N" divtype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>规划研究科</SPAN></DIV></TD>
                        <TD width="60%" colSpan=4><INPUT class=nolinetext id=text_ghyjk style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 378px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=68 controltype="text"><BUTTON id=button_ghyjk_ style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;selectPSKSActor('zxsb_wp1_act3', 'text_ghyjk_', 'text_ghyjk');&quot;)">选择执行人</BUTTON><INPUT class=nolinetext id=text_ghyjk_ style="DISPLAY: none; LEFT: 0px; WIDTH: 32px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     </TR>
                     <TR id=psks2 style="DISPLAY: none">
                        <TD width="30%"><DIV id=zxsb_wp1_act4 style="LEFT: 0px; FLOAT: left; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() noWrap controltype="checkbox" NotBg="否" value="N" onclick="bill_onclick(&quot;selectActorControl('zxsb_wp1_act4', 'button_zykfk_','text_zykfk')&quot;)" truevalue="Y" falsevalue="N" divtype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>资源开发科</SPAN></DIV></TD>
                        <TD width="60%" colSpan=4><INPUT class=nolinetext id=text_zykfk style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 378px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=68 controltype="text"><BUTTON id=button_zykfk_ style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;selectPSKSActor('zxsb_wp1_act4', 'text_zykfk_', 'text_zykfk');&quot;)">选择执行人</BUTTON><INPUT class=nolinetext id=text_zykfk_ style="DISPLAY: none; LEFT: 0px; WIDTH: 32px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     </TR>
                     <TR id=psks3 style="DISPLAY: none">
                        <TD width="30%"><DIV id=zxsb_wp1_act5 style="LEFT: 0px; FLOAT: left; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() noWrap controltype="checkbox" NotBg="否" value="N" onclick="bill_onclick(&quot;selectActorControl('zxsb_wp1_act5','button_dzzwk_','text_dzzwk')&quot;)" truevalue="Y" falsevalue="N" divtype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>电子政务科</SPAN></DIV></TD>
                        <TD width="60%" colSpan=4><INPUT class=nolinetext id=text_dzzwk style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 378px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=68 controltype="text"><BUTTON id=button_dzzwk_ style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;selectPSKSActor('zxsb_wp1_act5', 'text_dzzwk_', 'text_dzzwk');&quot;)">选择执行人</BUTTON><INPUT class=nolinetext id=text_dzzwk_ style="DISPLAY: none; LEFT: 0px; WIDTH: 32px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     </TR>
                     <TR id=psks4 style="DISPLAY: none">
                        <TD width="30%"><DIV id=zxsb_wp1_act6 style="LEFT: 0px; FLOAT: left; WIDTH: 80px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() noWrap controltype="checkbox" NotBg="否" value="N" onclick="bill_onclick(&quot;selectActorControl('zxsb_wp1_act6', 'button_bgs_','text_bgs')&quot;)" truevalue="Y" falsevalue="N" divtype="checkbox"><INPUT oncontrolselect=controlselectcancel() type=checkbox><SPAN>办公室</SPAN></DIV></TD>
                        <TD width="60%" colSpan=4><INPUT class=nolinetext id=text_bgs style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 378px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=68 controltype="text"><BUTTON id=button_bgs_ style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;selectPSKSActor('zxsb_wp1_act6', 'text_bgs_', 'text_bgs');&quot;)">选择执行人</BUTTON><INPUT class=nolinetext id=text_bgs_ style="DISPLAY: none; LEFT: 0px; WIDTH: 32px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD colSpan=6><DIV id=fj><FONT color=#ff0000>附件</FONT>&nbsp;<BUTTON id=affix_upload style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("editAffix()")'>附件</BUTTON><INPUT class=nolinetext id=text_fjid style="DISPLAY: none; LEFT: 0px; WIDTH: 187px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=29 controltype="text" field="FJID" china="附件id" dataset="dataset1"></DIV></TD>
                     </TR>
                     <TR>
                        <TD colSpan=6>评审意见<BUTTON id=button_ghyjk style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("currentIndex = 0;getIdea();")'>添加意见</BUTTON><BUTTON id=button_dzzwk style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("currentIndex = 1;getIdea();")'>添加意见</BUTTON><BUTTON id=button_zykfk style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("currentIndex = 2;getIdea();")'>添加意见</BUTTON><BUTTON id=button_bgs style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("currentIndex = 3;getIdea();")'>添加意见</BUTTON><TEXTAREA id=textarea_psyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 150px" onmovestart=moveStart() rows=1 readOnly cols=166 controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
                  <TBODY>
                     <TR>
                        <TD><DIV id=div_ align=right><DIV id=workflowControl1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%" onmovestart=moveStart() controltype="workflowControl" NotBg="是">&nbsp;<DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 215px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">请选择活动：<SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor();")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></DIV><DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：<INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_xzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("selectActors();")'>选执行人</BUTTON></DIV><DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：<INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text"><INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text"><BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("selectAndActors();")'>与分支选执行人</BUTTON></DIV><DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_qdlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'启动流程','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">启动流程</BUTTON></DIV><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_wchd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'完成活动','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">完成活动</BUTTON></DIV><DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_ht style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'回退','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">回退</BUTTON></DIV><DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_hs style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'收回','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">收回</BUTTON></DIV><DIV id=workflowControl_terminate style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_zzlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'终止流程','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">终止流程</BUTTON></DIV><DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;myNextAction(dataset1,'暂存','/creatorepp/eformsys/fceform/common/djframe.htm?djsn=20090903095615828224&amp;djtype=ZW')&quot;)">暂存</BUTTON></DIV><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV>&nbsp;</DIV></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               <TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
                  <TBODY>
                     <TR>
                        <TD><DIV align=right><BUTTON class=button1 id=button_close style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("CloseBill()")'>关闭</BUTTON></DIV></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </DIV>
            <DIV id=div_width style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 850px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 1px" onmovestart=moveStart() controltype="div" NotBg="是"></DIV>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>BHH</fieldname><datatype>整数</datatype><displaylabel>编号号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BHN</fieldname><datatype>字符</datatype><displaylabel>编号年</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>GH_NAME</fieldname><datatype>字符</datatype><displaylabel>是否有总体规划及划名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JHTZ_ALL_FINANCE</fieldname><datatype>实数</datatype><displaylabel>计划投总财政</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JHTZ_ALL_MONEY</fieldname><datatype>实数</datatype><displaylabel>计划投总金额</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JHTZ_ALL_OTHER</fieldname><datatype>实数</datatype><displaylabel>计划投总其它</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JHTZ_MONEY</fieldname><datatype>实数</datatype><displaylabel>年度计划投资金额</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JS_AIM</fieldname><datatype>字符</datatype><displaylabel>目标（包括总体目标与阶段目标）</displaylabel><size>2000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JS_CONTENT</fieldname><datatype>字符</datatype><displaylabel>建设内容</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCCYR</fieldname><datatype>字符</datatype><displaylabel>流程参与人</displaylabel><size>2048</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LCSLID</fieldname><datatype>字符</datatype><displaylabel>项目ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SJTZ_MONEY</fieldname><datatype>实数</datatype><displaylabel>年度实投资金额</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TB_DATE</fieldname><datatype>字符</datatype><displaylabel>填表日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TB_DEPT</fieldname><datatype>字符</datatype><displaylabel>填表单位</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TB_MAN</fieldname><datatype>字符</datatype><displaylabel>项目联系人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TB_PHONE</fieldname><datatype>字符</datatype><displaylabel>联系电</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TZ_YEAR</fieldname><datatype>字符</datatype><displaylabel>投资年份</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WJZT</fieldname><datatype>字符</datatype><displaylabel>文件状态</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XDZZWKSH</fieldname><datatype>字符</datatype><displaylabel>需电子政务科审核</displaylabel><size>1</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XGHYJKSH</fieldname><datatype>字符</datatype><displaylabel>需规划研究科审核</displaylabel><size>1</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XJSYYKSH</fieldname><datatype>字符</datatype><displaylabel>需技术应用科审核</displaylabel><size>1</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_ALL_FINANCE</fieldname><datatype>实数</datatype><displaylabel>项目总政</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_ALL_MONEY</fieldname><datatype>实数</datatype><displaylabel>项目总投资</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_ALL_OTHER</fieldname><datatype>实数</datatype><displaylabel>项目总其它</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_ENDDATE</fieldname><datatype>字符</datatype><displaylabel>项目建结束日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_NAME</fieldname><datatype>字符</datatype><displaylabel>项目名称</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_STARTDATE</fieldname><datatype>字符</datatype><displaylabel>项目建开始日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM_TYPE</fieldname><datatype>字符</datatype><displaylabel>项目类别</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XXZXSBJE</fieldname><datatype>实数</datatype><displaylabel>信息中心审批金额</displaylabel><size>126</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XZYKFKSH</fieldname><datatype>字符</datatype><displaylabel>需资源开发科审核</displaylabel><size>1</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>YWLB</fieldname><datatype>字符</datatype><displaylabel>业务类别</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZR_DEPT</fieldname><datatype>字符</datatype><displaylabel>责任单位</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZR_MAN</fieldname><datatype>字符</datatype><displaylabel>责任人</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ZR_PHONE</fieldname><datatype>字符</datatype><displaylabel>责任人电话</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FJID</fieldname><datatype>字符</datatype><displaylabel>附件id</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><BHH></BHH><BHN></BHN><GH_NAME></GH_NAME><JHTZ_ALL_FINANCE></JHTZ_ALL_FINANCE><JHTZ_ALL_MONEY></JHTZ_ALL_MONEY><JHTZ_ALL_OTHER></JHTZ_ALL_OTHER><JHTZ_MONEY></JHTZ_MONEY><JS_AIM></JS_AIM><JS_CONTENT></JS_CONTENT><LCCYR></LCCYR><LCSLID></LCSLID><SJTZ_MONEY></SJTZ_MONEY><TB_DATE></TB_DATE><TB_DEPT></TB_DEPT><TB_MAN></TB_MAN><TB_PHONE></TB_PHONE><TZ_YEAR></TZ_YEAR><WJZT></WJZT><XDZZWKSH></XDZZWKSH><XGHYJKSH></XGHYJKSH><XJSYYKSH></XJSYYKSH><XM_ALL_FINANCE></XM_ALL_FINANCE><XM_ALL_MONEY></XM_ALL_MONEY><XM_ALL_OTHER></XM_ALL_OTHER><XM_ENDDATE></XM_ENDDATE><XM_NAME></XM_NAME><XM_STARTDATE></XM_STARTDATE><XM_TYPE></XM_TYPE><XXZXSBJE></XXZXSBJE><XZYKFKSH></XZYKFKSH><YWLB></YWLB><ZR_DEPT></ZR_DEPT><ZR_MAN></ZR_MAN><ZR_PHONE></ZR_PHONE><FJID></FJID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><BHH></BHH><BHN></BHN><GH_NAME></GH_NAME><JHTZ_ALL_FINANCE></JHTZ_ALL_FINANCE><JHTZ_ALL_MONEY></JHTZ_ALL_MONEY><JHTZ_ALL_OTHER></JHTZ_ALL_OTHER><JHTZ_MONEY></JHTZ_MONEY><JS_AIM></JS_AIM><JS_CONTENT></JS_CONTENT><LCCYR></LCCYR><LCSLID></LCSLID><SJTZ_MONEY></SJTZ_MONEY><TB_DATE></TB_DATE><TB_DEPT></TB_DEPT><TB_MAN></TB_MAN><TB_PHONE></TB_PHONE><TZ_YEAR></TZ_YEAR><WJZT></WJZT><XDZZWKSH></XDZZWKSH><XGHYJKSH></XGHYJKSH><XJSYYKSH></XJSYYKSH><XM_ALL_FINANCE></XM_ALL_FINANCE><XM_ALL_MONEY></XM_ALL_MONEY><XM_ALL_OTHER></XM_ALL_OTHER><XM_ENDDATE></XM_ENDDATE><XM_NAME></XM_NAME><XM_STARTDATE></XM_STARTDATE><XM_TYPE></XM_TYPE><XXZXSBJE></XXZXSBJE><XZYKFKSH></XZYKFKSH><YWLB></YWLB><ZR_DEPT></ZR_DEPT><ZR_MAN></ZR_MAN><ZR_PHONE></ZR_PHONE><FJID></FJID></dsid>")' onValid='bill_ondatasetvalid("<dsid><BHH></BHH><BHN></BHN><GH_NAME></GH_NAME><JHTZ_ALL_FINANCE></JHTZ_ALL_FINANCE><JHTZ_ALL_MONEY></JHTZ_ALL_MONEY><JHTZ_ALL_OTHER></JHTZ_ALL_OTHER><JHTZ_MONEY></JHTZ_MONEY><JS_AIM></JS_AIM><JS_CONTENT></JS_CONTENT><LCCYR></LCCYR><LCSLID></LCSLID><SJTZ_MONEY></SJTZ_MONEY><TB_DATE></TB_DATE><TB_DEPT></TB_DEPT><TB_MAN></TB_MAN><TB_PHONE></TB_PHONE><TZ_YEAR></TZ_YEAR><WJZT></WJZT><XDZZWKSH></XDZZWKSH><XGHYJKSH></XGHYJKSH><XJSYYKSH></XJSYYKSH><XM_ALL_FINANCE></XM_ALL_FINANCE><XM_ALL_MONEY></XM_ALL_MONEY><XM_ALL_OTHER></XM_ALL_OTHER><XM_ENDDATE></XM_ENDDATE><XM_NAME></XM_NAME><XM_STARTDATE></XM_STARTDATE><XM_TYPE></XM_TYPE><XXZXSBJE></XXZXSBJE><XZYKFKSH></XZYKFKSH><YWLB></YWLB><ZR_DEPT></ZR_DEPT><ZR_MAN></ZR_MAN><ZR_PHONE></ZR_PHONE><FJID></FJID></dsid>")' opensortno="1" temptable="TMP_DATASET1" saveastable="TA_XMGL_XMSB" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
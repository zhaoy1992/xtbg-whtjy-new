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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js'></script>");
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


<!-- 提示：以下为页面自定义JS内容 -->
<script>
//要获取处罚事项实例的ID
var wft_id = creator_getQueryString("wft_id");
var tp_status = creator_getQueryString("tp_status");
var avermentState = creator_getQueryString("avermentState");
var eflag = creator_getQueryString("eflag");
var tflag = creator_getQueryString("tflag");
var workflow_name = "陈述申辩";

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

var statusValue = "";

//获取当前处罚事项实例的特别程序申请强制终止状态
function checkApplyTime(wft_id){
    var result = SpecialApply.findPlanTime(wft_id, "陈述申辩");  
    if(IsSpace(result)){
        return "";
    } else {
        var end_status = result[0][1];
        return end_status;
    }
}

//初始化
function init(){
    statusValue = getStatusByWft();
    if(eflag == 0){//从查询页面或登记页面来
         if(avermentState == "未申请"){
            
        } else if(tflag == 1){
            document.getElementById('tr_id').style.display = "none";
        } else if(avermentState == "已申请" && tp_status == 0){
            findStateInfo();//进入初始化陈述申辩信息的界面
            if(IsSpace(checkApplyTime(wft_id))){
                $('apply').disabled = true;
            }
        } else if(avermentState == "已申辩"){
            findStateInfo();     
            document.getElementById('state_time').disabled = true;
            document.getElementById('state_men').disabled = true;
            document.getElementById('state_record').readOnly = true;
            document.getElementById('state_conclusion').readOnly = true;
            if(IsSpace(checkApplyTime(wft_id))){
                $('apply').disabled = true;
            }
            $('saveNow').style.display = "none";
            $('saveAndGo').style.display = "none";
        }  
    } else { //从tab页来
         findStateInfo();
        document.getElementById('state_time').disabled = true;
        document.getElementById('state_men').disabled = true;
        document.getElementById('state_record').readOnly = true;
        document.getElementById('state_conclusion').readOnly = true;
        $('apply').disabled = true;
        $('saveNow').style.display = "none";
        $('saveAndGo').style.display = "none";
    }
}

//跳转到特别程序申请的界面
function toSpecialApply(){
    var tempPara = "dialogWidth:780px,dialogHeight:250px;";
    var tempURL = "20100909163528703907.jsp?wft_id=" + wft_id + "&avermentState=" + avermentState + "&tp_status=" + tp_status + "&temp=1";
    showModalDialog(tempURL, window, tempPara);
    reloadExtGrid();
}

//保存陈述申辩记录
function saveStateRecord(){
    var list = new Array(4);
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 4;//列示文档归类
    vo.WORKFLOW_NAME = "陈述申辩";
    vo.MD_TITLE = "附件上传";
    vo.MD_ACCESSORIES_BODY = $('MD_ACCESSORIES_BODY').value;//附件体
    if(!IsSpace(vo.MD_ACCESSORIES_BODY)){//有附件
        vo.MD_ISACCESSORIES = 1;//有附件
        vo.MD_ASM = 1;//附件存储方式--数据库    
    } else {//没有附件
       vo.MD_ISACCESSORIES = 0;//没有附件
        vo.MD_ASM = 0;//附件存储方式--数据库
    }
    var vo1 = new SpecialVo.Document2();
    var vo2 = new SpecialVo.Document2();
    var vo3 = new SpecialVo.Document2();
    var vo4 = new SpecialVo.Document2();
    //当做4个对象存入数据库
    vo1.MD_TITLE = "陈述申辩时间";
    vo1.MD_BODY = ${'state_time'}.value;
    list[0] = vo1;
    vo2.MD_TITLE = "申请人";
    vo2.MD_BODY = $('state_men').value;
    list[1] = vo2;
    vo3.MD_TITLE = "陈述申辩记录";
    vo3.MD_BODY = ${'state_record'}.value;
    list[2] = vo3;
    vo4.MD_TITLE = "陈述申辩结论";
    vo4.MD_BODY = ${'state_conclusion'}.value;
    list[3] = vo4;
    var arr = new Array();
    arr[0] = list;
    arr[1] = vo;
    return arr;
}

//修改陈述申辩信息
function updateStateRecord(){
    var list = new Array(4);
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 4;//列示文档归类
    vo.WORKFLOW_NAME = "陈述申辩";
    vo.MD_TITLE = "附件上传";
    vo.MD_ACCESSORIES_BODY = $('MD_ACCESSORIES_BODY').value;//附件体
    if(!IsSpace(vo.MD_ACCESSORIES_BODY)){//有附件
        vo.MD_ISACCESSORIES = 1;//有附件
        vo.MD_ASM = 1;//附件存储方式--数据库    
    } else {//没有附件
       vo.MD_ISACCESSORIES = 0;//没有附件
        vo.MD_ASM = 0;//附件存储方式--数据库
    }
    var vo1 = new SpecialVo.Document2();
    var vo2 = new SpecialVo.Document2();
    var vo3 = new SpecialVo.Document2();
    var vo4 = new SpecialVo.Document2();
    //当做三个对象存入数据库
    vo1.MD_TITLE = "陈述申辩时间";
    vo1.MD_BODY = ${'state_time'}.value;
    list[0] = vo1;
    vo2.MD_TITLE = "申请人";
    vo2.MD_BODY = $('state_men').value;
    list[1] = vo2;
    vo3.MD_TITLE = "陈述申辩记录";
    vo3.MD_BODY = ${'state_record'}.value;
    list[2] = vo3;
    vo4.MD_TITLE = "陈述申辩结论";
    vo4.MD_BODY = ${'state_conclusion'}.value;
    list[3] = vo4;
    var arr = new Array();
    arr[0] = list;
    arr[1] = vo;
    return arr;
}

//向批注表写入数据的公共方法
function saveTaskPlstil(tp_STATUS){
    var vo = new publicVO.TaskPlstil();
    vo.WFT_ID = wft_id;
    vo.TP_STATUS = tp_STATUS;
    vo.TP_EMY = user_id;
    vo.ISPLATFORM = 0;
    var sql = DocumentList.findBuId(vo.WFT_ID);
    dataset.Open(sql);//查询该案件的执法主体
    var bu_id = dataset.Fields.Field['BU_ID'].Value;
    var bu_name = dataset.Fields.Field['BU_NAME'].Value;
    vo.SU_ID_INNER = bu_id;//执法主体ID
    vo.TP_SYSUNIT_NAME = bu_name;//执法主体名称
    vo.WORKFLOW_NAME = '陈述申辩';
    vo.TP_INFO = 0;
    return vo;
}

//暂存
function saveNOW(){
    if(!validate()){
        return;
    }
    if(IsSpace(tp_status)){//没有陈述申辩信息
        var arr = saveStateRecord();
        var list = arr[0];
        var vo1 = arr[1];
        var vo2 = saveTaskPlstil(0);
        var vo3 = "";
        var rv = DocumentList.insertDocumentAndPlstil(list, vo1, vo2, vo3);
        if(IsSpace(checkApplyTime(wft_id))){
            $('apply').disabled = true;  
        }
        if(rv){
            alert("保存成功！");
        } else {
            alert("保存失败！");
        }
    } else {
        var arr = updateStateRecord();
        var list = arr[0];
        var vo1 = arr[1];
        var vo2 = saveTaskPlstil(0);
        var vo3 = "";
        var rv = DocumentList.updateDocumentInfo(list, vo1, vo2, vo3);
        if(rv){
            alert("保存成功！");
        } else {
            alert("保存失败！");
        }
    }
}

//当提交时，写入强制终止理由
function saveEndInfo(wft_id){
    var vo = new SpecialVo.SpecialApply();
    vo.WFT_ID = wft_id;
    vo.SPAFTC_ID = 0;//登记结果
    vo.SPA_FORCED_TERMINATION = 1;//强制终止状态(提交终止)
    vo.SPA_FORCED_TERMINATER = user_id;//当前用户ID(即强制终止人)
    vo.SPA_TERMINATION_REASONS = "陈述申辩已结束！";//强制终止理由
    return vo;
}

//提交
function saveGO(){
    var flag;
    if(!validate()){
        return;
    }
    if(IsSpace(tp_status)){//没有陈述申辩信息
        var arr = saveStateRecord();
        var list = arr[0];
        var vo1 = arr[1];
        var vo2 = saveTaskPlstil(1);
        var vo3 = "";
        if(checkApplyTime(wft_id) == 0){
            vo3 = saveEndInfo(wft_id);
        }
        var rv = DocumentList.insertDocumentAndPlstil(list, vo1, vo2, vo3);
        if(IsSpace(checkApplyTime(wft_id))){
            $('apply').disabled = true;  
        }
        if(rv){
            $('saveNow').disabled = true;
            $('saveAndGo').disabled = true;
            alert("提交成功！");
        } else {
            alert("提交失败！");
        }
    } else {
        var arr = updateStateRecord();
        var list = arr[0];
        var vo1 = arr[1];
        var vo2 = saveTaskPlstil(1);
        var vo3 = "";
        if(!IsSpace(checkApplyTime(wft_id)) && checkApplyTime(wft_id) == 0){
            vo3 = saveEndInfo(wft_id);
        }
        var rv = DocumentList.updateDocumentInfo(list, vo1, vo2, vo3);
        if(rv){
            $('saveNow').disabled = true;
            $('saveAndGo').disabled = true;
            alert("提交成功!");
        } else {
            alert("提交失败!");
        }
    }
}

//返回
function closeZheWindow(){
    if(eflag == 0 && (tflag != 1)){
         window.close();
    } else if(eflag == 0 && (tflag == 1)) {
        //返回到申请页面
        var obj = new Object();
       var sql = DocumentList.findPostilInfo(wft_id, "陈述申辩");
       var arr = DBUtil.getQueryArray(sql, 0, -1);
       if(IsSpace(arr)){
           obj.pic = 0;//没有暂存和提交
        } else if(arr[0][1] == 0) {
           obj.pic = 1;//已暂存
        } else if(arr[0][1] == 1){
           obj.pic = 2;//已提交
        }
       window.returnValue = obj;
       window.close();
    } else {
        WorkflowUtil.backToWorklist();
    }
}

//查询陈述申辩信息
function findStateInfo(){
    var ldt_id = 4;//列示文档归类==陈述申辩
     var md_Title = new Array(5);
    md_Title[0] = "陈述申辩时间";
    md_Title[1] = "申请人";
    md_Title[2] = "陈述申辩记录";
    md_Title[3] = "陈述申辩结论";
    md_Title[4] = "附件上传";
    var md_title = "('" + md_Title[0] + "','" + md_Title[1] + "','" + md_Title[2] + "','" + md_Title[3] + "','" + md_Title[4] + "')";
    var sql = DocumentList.findDocumentInfo(wft_id, ldt_id, md_title);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        //return;
    } else {
        $('state_time').value = arr[0][0];
        $('state_men').value = arr[1][0];
        $('state_record').value = arr[2][0];
        $('state_conclusion').value = arr[3][0];
        $('MD_ACCESSORIES_BODY').value = arr[4][1];
    }
}

//有红色*号的字段为必填写，检测必填项是否填写,检测字段长度，检测时间逻辑限制
function validate(){
    var flag = true;
 
    //验证陈述申辩时间是否填写
    if(flag){
        flag = SValidator.validate(${'state_time'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["陈述申辩时间"]}
        }, true);
    }
    
    //验证申请人是否填写
    if(flag){
        flag = SValidator.validate(${'state_men'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["申请人"]}
        }, true);
    }
    
    //验证陈述申辩记录是否填写
    if(flag){
        flag = SValidator.validate(${'state_record'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["陈述申辩记录"]}
        }, true);
    }
    
    //验证陈述申辩结论是否填写
    if(flag){
        flag = SValidator.validate(${'state_conclusion'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["陈述申辩结论"]}
        }, true);
    }
    
    //验证陈述申辩时间的逻辑范围
    if(flag){
       time1 = findDeclareApplyTime().split(" ")[0];////陈述申请时间
        time2 = $('state_time').value;//陈述申辩时间
        
        var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("陈述申辩时间不能小于申请时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if(flag){
        var time1 = $('state_time').value;//陈述申辩时间
         var time2 = getNowDate();//当前服务器时间
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("陈述申辩时间不能大于当前时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    
    return flag;
} 

//附件上传按钮函数
/* 打开上传下载页面 */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('MD_ACCESSORIES_BODY').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('MD_ACCESSORIES_BODY').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    if(statusValue == 1){
        isAllowDelete = false;
        allowAdd = false;
    }
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

//查询陈述申请时间
function findDeclareApplyTime(){
    return WorkflowUtil.queryDeclareApplyTime(wft_id);
}

//查询当前服务器时间
function getNowDate(){
    var nowYear = FormUtil.getServerYear();//获取当前服务器年
    var nowMonth = FormUtil.getServerMonth();//获取当前服务器月
    var nowDay = FormUtil.getServerDay();//获取当前服务器日
    if(parseInt(nowMonth) < 10){
        nowMonth = "0" + nowMonth;
    }
    if(parseInt(nowDay) < 10){
        nowDay = "0" + nowDay;
    }
    var nowDate = nowYear + "-" + nowMonth + "-" + nowDay;
    return nowDate;
}

//查询当前批注状态
function getStatusByWft(){
    var sql = DocumentList.findPostilInfo(wft_id, "陈述申辩");
    var arr = DBUtil.getQueryArray(sql,0,-1);
    if(arr.length == 0){//没有批注信息
        return "";
    } else {
        return arr[0][1];//批注状态
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>state_record</id><id>state_conclusion</id></textarea><button><id>apply</id><id>uploadB</id><id>saveNow</id><id>saveAndGo</id><id>goback</id></button><text><id>state_time</id><id>state_men</id><id>MD_ACCESSORIES_BODY</id></text><dataset><id>dataset</id><id>applyDataset</id></dataset></root>" billtaborder="<root><taborder>saveNow</taborder><taborder>saveAndGo</taborder><taborder>goback</taborder><taborder>apply</taborder><taborder>state_time</taborder><taborder>state_record</taborder><taborder>state_conclusion</taborder><taborder>uploadB</taborder><taborder>state_men</taborder><taborder>MD_ACCESSORIES_BODY</taborder></root>" dj_sn="20100909161026046925" caption="陈述申辩" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:1;textarea:4;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:7;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:1;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:3;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/publicVO.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SpecialApply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>陈述申辩登记</TD>
                  </TR>
                  <TR id=tr_id>
                     <TD class=c2 width="15%">特别程序申请</TD>
                     <TD colSpan=3><BUTTON class=button id=apply style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("toSpecialApply()")'>陈述申辩申请</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">陈述申辩时间<FONT color=red>*</FONT></TD>
                     <TD width="35%"><INPUT class=input_out id=state_time style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() readOnly size=50 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 width="15%">申请人<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=state_men style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">陈述申辩记录<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=state_record style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea3" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">陈述申辩结论<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=state_conclusion style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea4" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">附件上传</TD>
                     <TD colSpan=3><BUTTON class=button id=uploadB style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>附件上传</BUTTON><INPUT id=MD_ACCESSORIES_BODY style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=saveNow style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveNOW()")'>暂存</BUTTON><BUTTON class=button id=saveAndGo style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveGO()")'>提交</BUTTON><BUTTON class=button id=goback style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeZheWindow()")'>返回</BUTTON></TD>
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

<fc:dataset id=dataset format="<fields><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ID</fieldname><datatype>字符</datatype><displaylabel>提交文档清单ID</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LDT_ID</fieldname><datatype>字符</datatype><displaylabel>列示文档归类</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_TITLE</fieldname><datatype>字符</datatype><displaylabel>标题</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_BODY</fieldname><datatype>字符</datatype><displaylabel>材料体</displaylabel><size>4000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WORKFLOW_NAME</fieldname><datatype>字符</datatype><displaylabel>流程名称</displaylabel><size>255</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_ID</fieldname><datatype>字符</datatype><displaylabel>事项状态ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_DATE</fieldname><datatype>字符</datatype><displaylabel>批注时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_STATUS</fieldname><datatype>字符</datatype><displaylabel>批注状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><MD_ID></MD_ID><LDT_ID></LDT_ID><MD_TITLE></MD_TITLE><MD_BODY></MD_BODY><WORKFLOW_NAME></WORKFLOW_NAME><MIS_ID></MIS_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><TP_DATE></TP_DATE><TP_STATUS></TP_STATUS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><MD_ID></MD_ID><LDT_ID></LDT_ID><MD_TITLE></MD_TITLE><MD_BODY></MD_BODY><WORKFLOW_NAME></WORKFLOW_NAME><MIS_ID></MIS_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><TP_DATE></TP_DATE><TP_STATUS></TP_STATUS></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><MD_ID></MD_ID><LDT_ID></LDT_ID><MD_TITLE></MD_TITLE><MD_BODY></MD_BODY><WORKFLOW_NAME></WORKFLOW_NAME><MIS_ID></MIS_ID><BU_ID></BU_ID><BU_NAME></BU_NAME><TP_DATE></TP_DATE><TP_STATUS></TP_STATUS></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<fc:dataset id=applyDataset format="<fields><field><fieldname>SPA_APPLICATION_TIME</fieldname><datatype>字符</datatype><displaylabel>申请时限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME></dsid>")' onValid='bill_ondatasetvalid("<dsid><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
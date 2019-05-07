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


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wft_id = creator_getQueryString("wft_id");//获取处罚实例ID
var tp_status = creator_getQueryString("tp_status");//获取批注状态
var avermentState = creator_getQueryString("avermentState");
var flag = creator_getQueryString("flag");
var temp = creator_getQueryString("temp");

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

//算出终止时间
function calculateTime(){
    var happenTime = $('SPA_DATE').value;//发生时间
    if(IsSpace(happenTime)){//如果申请时间为空，则不进行终止时间计算
       return; 
    }
    var applyTime = $('SPA_APPLICATION_TIME').value;//申请时限
    var timeUnits = 1;//实现单位
    //自动算出终止时间
    var planEndTime = WorkflowUtil.deadLineAlgorithm(happenTime, applyTime, timeUnits);
    
    $('SPA_END_DATE').value = planEndTime.split(" ")[0];
}

//检测申请时间的动态，随时更新终止时间
function checkEndTime(){
    var tempValue = $('SPA_APPLICATION_TIME').value;//申请时限
    if(!IsSpace(tempValue)){//如果申请时限不为空，则自动算出终止时间
        calculateTime();
    }
}

//查询强制终止状态
function findEndStatus(){
    var result = SpecialApply.findPlanTime(wft_id, "听证");
    return result;
}

//初始化
function init(){
    if(temp == 0){   //从查询列表来
        if(flag == 0 && avermentState == "已申请" && IsSpace(tp_status)){//没超时
            var segment = "听证";
            var result = findEndStatus();
            if(result[0][1] == 0){
                var sql = SpecialApply.findSpecialApply(wft_id, segment);
                specialApplyDataset.Open(sql);
                $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
                $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
                $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
                $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
                $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
                $('SPA_DATE').disabled = true; //发生时间置灰
                $('saveApply').style.display = "none";//隐藏提交按钮
                  $('endReason').style.display = "none";//隐藏强制终止理由
                  changeStyle();
            } else if(result[0][1] == 1 && result[0][2] == 1){
                var sql = SpecialApply.findSpecialApply(wft_id, segment);
                specialApplyDataset.Open(sql);
                $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
                $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
                $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
                $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
                $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
                $('ApplyEndReason').value = result[0][3];//强制终止理由
                  $('SPA_DATE').disabled = true; //发生时间置灰
                  $('saveApply').style.display = "none";//隐藏提交按钮
                  $('UnableApply').style.display = "none";//隐藏取消申请按钮
                  $('saveResult').style.display = "none";//隐藏登记结果按钮
                  changeStyle();
                document.getElementById('ApplyEndReason').readOnly = true;
            }
        } else if(avermentState == "已申请" && IsSpace(tp_status) && flag == 1){//超时
            var segment = "听证";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;        
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;    
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var result = SpecialApply.findPlanTime(wft_id, segment);
            $('ApplyEndReason').value = result[0][3];//强制终止理由
             $('saveApply').style.display = "none";//隐藏提交按钮
             $('SPA_DATE').disabled = true; //发生时间置灰
             $('UnableApply').style.display = "none";//隐藏取消申请按钮
             $('saveResult').style.display = "none";//隐藏登记结果按钮
             changeStyle();
            document.getElementById('ApplyEndReason').readOnly = true;
        }
    } else {   //从登记界面来
        if(avermentState == "未申请"){
            var segment = "听证";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            var result = DBUtil.getQueryArray(sql, 0, -1);
            if(result.length == 0){
                $('UnableApply').style.display = "none";//隐藏取消申请按钮
                  $('saveResult').style.display = "none";//隐藏登记结果按钮
                  $('endReason').style.display = "none";//隐藏强制终止理由
              } else {
                $('SPA_DATE').value = result[0][0];
                $('SPA_APPLICATION_TIME').value = result[0][1];
                $('SPA_END_DATE').value = result[0][3];
                $('SPA_APPLICANT').value = result[0][5];
                $('SPA_REASONS').value = result[0][6];
                $('saveApply').style.display = "none";//隐藏提交按钮
                  $('saveResult').style.display = "none";//隐藏登记结果按钮
                  $('endReason').style.display = "none";//隐藏强制终止理由
             }
        } else if(avermentState == "已申请"){
           var segment = "听证";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_PLANEND_DATE'].Value;
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var spa_realend_date = specialApplyDataset.Fields.Field['SPA_REALEND_DATE'].Value;
            $('saveApply').style.display = "none";//隐藏提交按钮
             $('UnableApply').style.display = "none";//隐藏取消申请按钮
             $('SPA_DATE').disabled = true; //发生时间置灰
             $('saveResult').style.display = "none";//隐藏登记结果按钮
             $('endReason').style.display = "none";//隐藏强制终止理由
             changeStyle();
        } else if(avermentState == "已听证"){
            var segment = "听证";
            var sql = SpecialApply.findSpecialApply(wft_id, segment);
            specialApplyDataset.Open(sql);
            $('SPA_DATE').value = specialApplyDataset.Fields.Field['SPA_DATE'].Value;
            $('SPA_APPLICATION_TIME').value = specialApplyDataset.Fields.Field['SPA_APPLICATION_TIME'].Value;
            $('SPA_END_DATE').value = specialApplyDataset.Fields.Field['SPA_REALEND_DATE'].Value;        
            $('SPA_APPLICANT').value = specialApplyDataset.Fields.Field['SPA_APPLICANT'].Value;    
            $('SPA_REASONS').value = specialApplyDataset.Fields.Field['SPA_REASONS'].Value;
            var result = SpecialApply.findPlanTime(wft_id, segment);
            $('ApplyEndReason').value = result[0][3];//强制终止理由
             $('saveApply').style.display = "none";//隐藏提交按钮
             $('SPA_DATE').disabled = true; //发生时间置灰
             $('UnableApply').style.display = "none";//隐藏取消申请按钮
             $('saveResult').style.display = "none";//隐藏登记结果按钮
             changeStyle();
           document.getElementById('ApplyEndReason').readOnly = true;
        } 
    }
}

//查看不能修改
function changeStyle(){
    document.getElementById('SPA_DATE').readOnly = true;
    document.getElementById('SPA_APPLICATION_TIME').readOnly = true;
    document.getElementById('SPA_END_DATE').readOnly = true;
    document.getElementById('SPA_APPLICANT').readOnly = true;
    document.getElementById('SPA_REASONS').readOnly = true;
}

//保存特别程序申请
function saveSpecialApply(){
    if(!validate()){
        return;
    }
    var vo = new SpecialVo.SpecialApply();
    vo.SPA_DATE = $('SPA_DATE').value;//发生时间
    vo.SPA_APPLICATION_TIME = $('SPA_APPLICATION_TIME').value;//申请时限
    vo.HCU_ID = 1;//实现单位
    vo.SPA_PLANEND_DATE = $('SPA_END_DATE').value;//终止时间
    vo.SPA_APPLICANT = $('SPA_APPLICANT').value;//申请人
    vo.SPA_REASONS = $('SPA_REASONS').value;//申请理由
    vo.SPA_FORCED_TERMINATION = 0;
    vo.SPA_SEGMENT = "听证";
    vo.SPA_HANDLER = user_id;//经办人
    vo.WFT_ID = wft_id;
    var rv = SpecialApply.saveSpecialApply(vo);
    if(IsSpace(rv)){
        alert("申请成功！");
    } else {
        alert("申请失败！");
    }
    $('saveApply').style.display = "none";//隐藏提交按钮
}

//取消申请
function unableApply(){
    /*var vo = new SpecialVo.SpecialApply();
    vo.WFT_ID = wft_id;
    vo.SPAFTC_ID = 1;//取消申请状态
    vo.SPA_FORCED_TERMINATION = 1;//强制终止状态
    vo.SPA_FORCED_TERMINATER = user_id;//当前用户ID
    vo.SPA_TERMINATION_REASONS = "当事人取消申请！";
    vo.SPA_SEGMENT = "听证";
    var rv = SpecialApply.updateSpecialApply(vo);
    */
    
    var rv = SpecialApply.deleteApply(wft_id, "听证");
    if(IsSpace(rv)){
        alert("取消成功!");
        $('UnableApply').style.display = "none";//隐藏取消申请按钮
         $('saveResult').style.display = "none";//隐藏登记结果按钮
    } else {
        alert("取消失败!");
    }

}

//登记结果,跳转到听证界面
function toAvermentPage(){
   var tempPara = "dialogWidth:780px,dialogHeight:250px;";
   var tempURL = "20100913145409775622.jsp?djbh=222&wft_id=" + wft_id + "&eflag=0&tflag=1";
   var obj = window.showModalDialog(tempURL, window, tempPara);
   if(obj.pic == 1){//已暂存
       $('saveApply').style.display = "none";//隐藏提交按钮
       $('UnableApply').style.display = "none";//隐藏取消申请按钮
       $('saveResult').style.display = "none";//隐藏登记结果按钮
   } else if(obj.pic == 0){//未登记信息
       $('saveApply').style.display = "none";//隐藏提交按钮
   } else if(obj.pic == 2){//已提交
        $('saveApply').style.display = "none";//隐藏提交按钮
        $('UnableApply').style.display = "none";//隐藏取消申请按钮
        $('saveResult').style.display = "none";//隐藏登记结果按钮
        //查询申请信息
        var sql = SpecialApply.findSpecialApply(wft_id, "听证");
        var arr = DBUtil.getQueryArray(sql, 0, -1);
        $('endReason').style.display = "block";//隐藏强制终止理由
        $('SPA_DATE').value = arr[0][0];
        $('SPA_APPLICATION_TIME').value = arr[0][1];
        $('SPA_END_DATE').value = arr[0][4];
        $('SPA_APPLICANT').value = arr[0][5];
        $('SPA_REASONS').value = arr[0][6];
        $('ApplyEndReason').value = arr[0][7];
   }
   reloadExtGrid();
}

//关闭窗口
function closeWindow(){
    window.close();
}

//有红色*号的字段为必填写，检测必填项是否填写,检测字段长度，检测时间逻辑限制
function validate(){
    var flag = true;
    $("SPA_APPLICATION_TIME").value = $("SPA_APPLICATION_TIME").value.trim();
    //验证申请时间是否填写
    if(flag){
        flag = SValidator.validate(${'SPA_DATE'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["申请时间"]}
        }, true);
    }
    
    //验证申请时限是否填写
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICATION_TIME'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["申请时限"]}
        }, true);
    }
    
    if (flag) {
        var testNum = /^[0-9]{1,3}$/;
        if (!testNum.test($("SPA_APPLICATION_TIME").value)) {
            alert("申请时限请输入3位以内正整数！");
            flag = false;
        }
    }

    //验证申请人是否填写
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICANT'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["申请人"]}
        }, true);
    }

    //验证申请人的长度
    if(flag){
        flag = SValidator.validate(${'SPA_APPLICANT'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["申请人", 60], maxlength : 60}
        }, true);
    }
    
    if(flag){
        var tempTime = findDeclareApplyTime().split(" ")[0];//陈述申请时间
        if(!IsSpace(tempTime) && tempTime == $('SPA_DATE').value){
            alert("当前案件已进行了陈述申辩申请");
            flag = false;
        }
    }
    
    if(flag){
        var time1 = findSignInTime().split(" ")[0];//告知回执签收时间
         var time2 = $('SPA_DATE').value;//听证申请时间
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("申请时间不能小于告知回执签收时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if(flag){
        var time1 = $('SPA_DATE').value;//听证申请时间
         var time2 = getNowDate();//当前服务器时间
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("申请时间不能大于当前时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    //验证申请理由是否填写
    if(flag){
        flag = SValidator.validate(${'SPA_REASONS'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["申请理由"]}
        }, true);
    }
    return flag;
}

//查询告知回执签收时间
function findSignInTime(){
    return WorkflowUtil.querySignInTime(wft_id);
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

//查询陈述申请时间
function findDeclareApplyTime(){
    return WorkflowUtil.queryDeclareApplyTime(wft_id);
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>SPA_REASONS</id><id>ApplyEndReason</id></textarea><button><id>saveApply</id><id>UnableApply</id><id>saveResult</id><id>closewindow</id></button><text><id>SPA_DATE</id><id>SPA_APPLICATION_TIME</id><id>SPA_END_DATE</id><id>SPA_APPLICANT</id></text><dataset><id>specialApplyDataset</id></dataset></root>" billtaborder="<root><taborder>SPA_REASONS</taborder><taborder>ApplyEndReason</taborder><taborder>saveApply</taborder><taborder>UnableApply</taborder><taborder>saveResult</taborder><taborder>closewindow</taborder><taborder>SPA_DATE</taborder><taborder>SPA_APPLICATION_TIME</taborder><taborder>SPA_END_DATE</taborder><taborder>SPA_APPLICANT</taborder></root>" dj_sn="20101016201431000833" caption="听证申请" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SpecialApply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>听证申请</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">申请时间<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=its_out id=SPA_DATE onblur=checkEndTime() style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 width="15%">申请时限<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_APPLICATION_TIME onblur=calculateTime() style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=30 controltype="text">&nbsp;工作日</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">终止时间</TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_END_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=c2 width="15%">申请人<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=input_out id=SPA_APPLICANT style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">申请理由<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=SPA_REASONS style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR id=endReason>
                     <TD class=c2 width="15%">强制终止理由</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=ApplyEndReason style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea2" induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=saveApply style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveSpecialApply()")'>提交</BUTTON><BUTTON class=button id=UnableApply style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("unableApply()")'>取消申请</BUTTON><BUTTON class=button id=saveResult style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("toAvermentPage()")'>登记结果</BUTTON><BUTTON class=button id=closewindow style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeWindow()")'>关闭</BUTTON></TD>
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

<fc:dataset id=specialApplyDataset format="<fields><field><fieldname>SPA_DATE</fieldname><datatype>字符</datatype><displaylabel>发生时间</displaylabel><size></size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_APPLICATION_TIME</fieldname><datatype>字符</datatype><displaylabel>申请时限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HCU_ID</fieldname><datatype>字符</datatype><displaylabel>时限单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_PLANEND_DATE</fieldname><datatype>字符</datatype><displaylabel>计划终止时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_REALEND_DATE</fieldname><datatype>字符</datatype><displaylabel>实际终止时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_APPLICANT</fieldname><datatype>字符</datatype><displaylabel>申请人</displaylabel><size>60</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_REASONS</fieldname><datatype>字符</datatype><displaylabel>申请理由</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SPA_SEGMENT</fieldname><datatype>字符</datatype><displaylabel>发生环节</displaylabel><size>120</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' onValid='bill_ondatasetvalid("<dsid><SPA_DATE></SPA_DATE><SPA_APPLICATION_TIME></SPA_APPLICATION_TIME><HCU_ID></HCU_ID><SPA_PLANEND_DATE></SPA_PLANEND_DATE><SPA_REALEND_DATE></SPA_REALEND_DATE><SPA_APPLICANT></SPA_APPLICANT><SPA_REASONS></SPA_REASONS><WFT_ID></WFT_ID><SPA_SEGMENT></SPA_SEGMENT></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
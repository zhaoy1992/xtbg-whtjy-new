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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var readOnlyFlag = creator_getQueryString("readOnlyFlag");
//获取处罚事项实例编号
var wftId=creator_getQueryString("WFT_ID");
if(IsSpace(wftId)){
    wftId = 829 ;
}
//获取事项编号
var PiId=creator_getQueryString("PI_ID");
if(IsSpace(PiId)){
    PiId = 542 ;
}
//获取阶段编号
var NdpId=creator_getQueryString("NDP_ID");
if(IsSpace(NdpId)){
    NdpId = 2 ;
}
//文档状态0为草稿，1为存档
var wdzt = "";
var buId = "";
var buName = "";
/**
*说明：初始化
*函数：init
*业务逻辑：
*1、根据案件ID和阶段ID输出案件信息 cf_AjClick(id,nodeId)
*注：首页提供的初始化案件信息接口
*2、根据违法行为ID、一般处罚程序ID搜素提交文档清单以及发布文档getFileList()
*/
function init(){
    var sql = LajdBiz.findLajdInfoBiz(wftId);
    lajdInfoDataset.Open(sql);
    var fnCode = lajdInfoDataset.Fields.Field["fnCode"].Value;//程序功能码
    var tmp = document.getElementsByName('radiobutton');
    for(var i = 0 ; i<tmp.length ; i++){
        if(tmp[i].value==fnCode){
            tmp[i].checked=true ;
            break;
        }
    }
    if (tmp[2].checked) {
        showOrHiddenYS();
    }
    //加载执法主体编号，及执法主体名称
    var sql1 = LajdBiz.findZfjtBhAndMcBiz(wftId);
    findZfjtDataset.Open(sql1);
    //获取执法主体编号，及执法主体名称
     buId = findZfjtDataset.Fields.Field["bu_id"].Value;//执法主体编号
     buName = findZfjtDataset.Fields.Field["bu_name"].Value;//执法主体名称
     initHiddenLazd();
}

//数据提交前进行去空格处理
function validateValue(){
    $("BN_IBUSINESS_NUMBER").value = $("BN_IBUSINESS_NUMBER").value.trim();
    $("TP_POSTIL").value = $("TP_POSTIL").value.trim();
}
/**
*说明：提交
*函数：submitLA
*业务逻辑：按钮提示“保存成功”。 
*/
function submitLA(wdzt){
    if (wdzt==1) {
        if (!confirm("确认结束本阶段?")) {    
            return false;
        }
    }
    validateValue();
    if(validate()){
        var labh = $("BN_IBUSINESS_NUMBER").value.trim() ;//立案编号
         var lasj = $("WFT_PLACED_ON_FILE_TIME").value.trim() ;//立案时间
         var zfry = $("userNames").value.trim() ; //执法人员
         var zfryId = $("userIds").value;//执法人员ID
         var spyj = $("TP_POSTIL").value.trim() ; //审批意见
         //获取审批结果值
         var tmp = document.getElementsByName('radiobutton');
        //创建三个对象，分别为处罚事项实例，批注，流程流向与事项阶段，用来封装界面值
         var cfsxslVo = new LajdVo.WorkFlowTicket() ; //处罚事项实例类
         var pzVo = new LajdVo.Postil() ; //批注类
         var lxsxjdVo = new LajdVo.FlowDirectionParaNdp() ; //流程流向与事项阶段类
         //处罚事项实例数据的封装
         cfsxslVo.WFT_BUSINESS_NUMBER = labh ; //立案编号
         cfsxslVo.WFT_PLACED_ON_FILE_TIME = lasj ; //立案时间
         cfsxslVo.WFT_ID = wftId ; //处罚事项实例编号
         cfsxslVo.WORKFLOW_NAME = "调查取证" ; //处罚事项实例编号
         
         //批注数据的封装
         pzVo.WFT_ID = wftId ;
        pzVo.NDP_ID = 2 ;
        pzVo.TP_END_DATE = FormUtil.getServerDate() ; 
        pzVo.TP_POSTIL = spyj ;//审批意见
         pzVo.TP_IMAGE = "图片" ;
        pzVo.TP_SYS = "" ;
        pzVo.TP_STATUS = wdzt ;//存档，0时，为暂存
         pzVo.TP_EMY = getSysElement("userid");
        pzVo.TP_FW_NAME = "" ;
        pzVo.TP_ES_NAME = "" ;
        pzVo.TP_EMY_SET = zfry ; //立案人员
         pzVo.TP_EMY_IDS = zfryId;//立案人员ID
         pzVo.ISPLATFORM = 0 ;
        pzVo.SU_ID_INNER = buId ;
        pzVo.TP_SYSUNIT_NAME = buName ;
        pzVo.SEGMENT_ID = "" ;
        pzVo.WORKFLOW_NAME = "立案决定" ;
        pzVo.TP_INFO = 0 ;
        //处罚事项实例数据的封装
         lxsxjdVo.WFT_ID= wftId ; //处罚事项实例编号
         lxsxjdVo.PI_ID = PiId ; //事项编号 
         lxsxjdVo.NDP_ID = pzVo.NDP_ID ; //阶段编号
         var rv = LajdBiz.addLajdBiz(cfsxslVo,pzVo,lxsxjdVo,tmp);
        if(rv){
            if(wdzt==1){
                alert("提交数据信息成功！");
                backBtn();
            } else {
                alert("保存成功！");
            }
        }else{
            alert("保存失败！");
        }   
    }
}

//返回
function backBtn1(){
    var Labh = $('BN_IBUSINESS_NUMBER').value ;
    var Lary = $('userNames').value ;
    var Lasj = $('WFT_PLACED_ON_FILE_TIME').value ;
    var Spyj = $('TP_POSTIL').value ; 
    if(!Labh=="" && !Lary=="" && !Lasj=="" && !Spyj==""){
       var a = confirm('没有提交是否返回?') ;
       if(a==true){
           parent.window.location.href = "20100929153136375631.jsp";
       }        
    }
}

//返回
function backBtn(){
    parent.window.location.href = "20100929153136375631.jsp";
}


//打印审批模板
function dySpMb(){
   var sql = LajdBiz.findLajdWsmbBiz(PiId,NdpId);
}

//附件上传按钮函数
/* 打开上传下载页面 */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('MD_ASM').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('MD_ASM').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}


//显示或隐藏移送弹出框
function showOrHiddenYS(){
   var tmp = document.getElementsByName('radiobutton');
   for(var i = 0 ; i<tmp.length ; i++){
       if(tmp[i].value=="FNCode3" && tmp[i].checked==true){
           $("ysDiv").style.display="";
           $("btns").style.display="none";
        }else{
           $("ysDiv").style.display="none";
           $("btns").style.display="";
       }
   }
}

//验证立案编号的唯一性
function validateLabh(){
    var flag = true ;
    var labhId = $("BN_IBUSINESS_NUMBER").value ;
    var num = LajdBiz.findLabhIdBiz(labhId,wftId);
    if(num>0){
        flag = false ;
    }else{
        flag = true ;
    }
    return flag ;
}

//验证立案编号的唯一性
function validateWftId(){
      return LajdBiz.validateWftIdBiz(wftId,NdpId) ;
}


//验证函数
function validate(){
    var flag = true ;
    if (flag) {
        flag = SValidator.validate(${'BN_IBUSINESS_NUMBER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'BN_IBUSINESS_NUMBER'}.value]},
            MESSAGE : "立案编号不能为空!"
        }, true);
    }
    
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("BN_IBUSINESS_NUMBER").value)){
            flag = false;
            alert("立案编号不能包含汉字！");
        }            
    }
    
    if(flag){
        flag = validateLabh() ;
        if(!flag){
            alert("立案编号已存在，请重新填入！")
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'BN_IBUSINESS_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'userNames'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'userNames'}.value]},
            MESSAGE : "立案人员不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'userNames'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [255],maxlength : 255},
            MESSAGE : "最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'WFT_PLACED_ON_FILE_TIME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_PLACED_ON_FILE_TIME'}.value]},
            MESSAGE : "立案时间不能为空!"
        }, true);
    }
    
    if (flag) {
        var newTime = $('WFT_PLACED_ON_FILE_TIME').value ;
        var sysTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,sysTime);
        if(!flag){
            alert("立案时间不能大于当前时间");
            return false ;
        }           
    }
    
    if(flag){
        var time1 = findAcceptTime().split(" ")[0];//受理时间
        var time2 = $('WFT_PLACED_ON_FILE_TIME').value;//立案时间   
         
        var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("立案时间不能小于受理时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'TP_POSTIL'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'TP_POSTIL'}.value]},
            MESSAGE : "审核意见不能为空"
        }, true);
    }


    
    return flag ;
}

function initHiddenLazd() {
    if(readOnlyFlag == "readOnly") {
        $("print_spTable").disabled = true;
        $("up_spTable").disabled = true;
        $("tempSave").disabled = true;
        $("submitBtn").disabled = true;
        HTMLUtil.readOnly($('BN_IBUSINESS_NUMBER'),"commonReadOnly");
        HTMLUtil.readOnly($('userNames'),"commonReadOnly");
        HTMLUtil.readOnly($('WFT_PLACED_ON_FILE_TIME'),"commonReadOnly");
        HTMLUtil.readOnly($('TP_POSTIL'),"commonReadOnly");
        var tmp = document.getElementsByName('radiobutton');
        for(var i = 0 ; i<tmp.length ; i++){
            tmp[i].disabled = true;
        }
    }
}

//打开执法人员的选择
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+buId;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    if(!IsSpace($("userIds").value)){
        var lttIds = $("userIds").value;
        var arr = WorkflowUtil.getUnableDateByUser(lttIds);//查询执法人员证件失效日期
        var tempNowDate = getNowDate();//当前日期
        var outArr = new Array();
        for(var i = 0; i < arr.length; i++){
            var myDate1 = "";
            if(Number(arr[i][0]) != 0){
                var arys1 = new Array();
                var tempD = arr[i][0].split(" ")[0];
                arys1 = tempD.split('-');
                myDate1 = new Date(arys1[0],arys1[1],arys1[2]);//失效日期
                 if(tempNowDate > myDate1){//已失效
                     outArr[outArr.length] = arr[i][2];
                }
             }
             if(i == arr.length - 1 && outArr.length > 0){
                 alert("\"" + outArr + "\"的执法证件已失效，不能再进行执法！");
             }
        }
    }
}

//查询受理时间
function findAcceptTime(){
    var acceptTime = WorkflowUtil.queryAcceptTime(wftId);
    return acceptTime;
}

//查询当前日期
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

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>TP_POSTIL</id></textarea><button><id>print_spTable</id><id>up_spTable</id><id>tempSave</id><id>submitBtn</id><id>button1</id></button><text><id>userIds</id><id>BN_IBUSINESS_NUMBER</id><id>userNames</id><id>WFT_PLACED_ON_FILE_TIME</id><id>MD_ASM</id></text><dataset><id>WORKFLOW_TICKET_DATASET</id><id>findZfjtDataset</id><id>lajdInfoDataset</id></dataset><creatorSubForm><id>iform1</id></creatorSubForm></root>" billtaborder="<root><taborder>TP_POSTIL</taborder><taborder>BN_IBUSINESS_NUMBER</taborder><taborder>userNames</taborder><taborder>WFT_PLACED_ON_FILE_TIME</taborder><taborder>userIds</taborder><taborder>print_spTable</taborder><taborder>up_spTable</taborder><taborder>tempSave</taborder><taborder>submitBtn</taborder><taborder>MD_ASM</taborder><taborder>button1</taborder></root>" dj_sn="20100910111620171187" caption="立案决定" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:2;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:7;hr:0;checkboxlist:0;radiolist:1;dropdownlist:0;grid:0;dataset:3;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/common/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/LajdVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LajdBiz.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LajdDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD height=33>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=7>【立案决定】</TD>
                  </TR>
                  <INPUT id=userIds style="DISPLAY: none; LEFT: 41px; WIDTH: 110px; POSITION: static; TOP: 26px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="EMY_ID" china="立案人员ID" dataset="lajdInfoDataset">
                  <TR>
                     <TD class=c2 width="2%" rowSpan=3>立案审批</TD>
                     <TD class=c2 width="25%">立案编号<SPAN><FONT color=red>*</FONT></SPAN></TD>
                     <TD width="20%"><INPUT class=input_out id=BN_IBUSINESS_NUMBER style="LEFT: 0px; WIDTH: 98%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="WFT_BUSINESS_NUMBER" china="立案编号" dataset="lajdInfoDataset"></TD>
                     <TD class=c2 width="25%">立案人员<FONT color=red>*</FONT></TD>
                     <TD width="24%"><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="EMY_NAME" china="立案人员名称" dataset="lajdInfoDataset" onclick='bill_onclick("openUserTree();")'></TD>
                     <TD class=c2 width=25>立案时间<FONT color=red>*</FONT></TD>
                     <TD width="15%"><INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME style="LEFT: 0px; WIDTH: 98%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="WFT_PLACED_ON_FILE_TIME" china="立案时间" dataset="lajdInfoDataset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="25%" height=69>审批意见<FONT color=red>*</FONT></SPAN></TD>
                  <TD colSpan=5><TEXTAREA id=TP_POSTIL style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100%" onmovestart=moveStart() cols=135 controltype="textarea" field="TP_POSTIL" china="审批意见" dataset="lajdInfoDataset" value="textarea1" induce="否"></TEXTAREA></TD>
               </TR>
               <TR>
                  <TD class=c2 width="25%" height=17>审批结果<FONT color=red>*</FONT></SPAN></TD>
               <TD colSpan=5><INPUT onclick=showOrHiddenYS() type=radio CHECKED value=FNCode1 name=radiobutton>立案<INPUT onclick=showOrHiddenYS() type=radio value=FNCode2 name=radiobutton>不予立案<INPUT onclick=showOrHiddenYS() type=radio value=FNCode3 name=radiobutton>移送</TD>
            </TR>
            <TR id=btns>
               <TD align=middle colSpan=7><BUTTON class=button id=print_spTable style="DISPLAY: none; LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("dySpMb()")'>打印审批表模板</BUTTON><BUTTON class=button id=up_spTable style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>上传审批表</BUTTON><BUTTON class=button id=tempSave style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("submitLA(0);")'>暂存</BUTTON><BUTTON class=button id=submitBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("submitLA(1);")'>提交</BUTTON><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("backBtn1()")'>返回</BUTTON><INPUT id=MD_ASM style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
            </TR>
         </TBODY>
      </TABLE>
   </TD>
</TR>
</TBODY>
</TABLE>

<TABLE id=ysDiv style="DISPLAY: none" height="40%" width="95%" align=center border=0>

<TBODY>
   <TR>
      <TD><IFRAME id=iform1 style="LEFT: 0px; WIDTH: 99.89%; POSITION: static; TOP: 0px; HEIGHT: 300px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load="1" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/20100911150617625282.jsp?1=1&amp;name=&amp;"></IFRAME></TD>
   </TD>
</TR>
</TBODY>
</TABLE>

<DIV></DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=WORKFLOW_TICKET_DATASET format="<fields><field><fieldname>WFT_ID</fieldname><datatype>整数</datatype><displaylabel>处罚事项实例</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_ID</fieldname><datatype>字符</datatype><displaylabel>阶段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_ID</fieldname><datatype>字符</datatype><displaylabel>事项实例状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE</fieldname><datatype>字符</datatype><displaylabel>日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>受理日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>字符</datatype><displaylabel>立案时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_REFERRAL</fieldname><datatype>字符</datatype><displaylabel>移送</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_REFERRAL_UNIT</fieldname><datatype>字符</datatype><displaylabel>移送至单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_IDOLD</fieldname><datatype>字符</datatype><displaylabel>原执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>字符</datatype><displaylabel>立案编号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><PI_ID></PI_ID><NDP_ID></NDP_ID><MIS_ID></MIS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><WFT_REFERRAL></WFT_REFERRAL><WFT_REFERRAL_UNIT></WFT_REFERRAL_UNIT><BU_IDOLD></BU_IDOLD><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER></dsid>")' opensortno="1" temptable="TMP_DATASET1" saveastable="TA_WORKFLOW_TICKET" multiResult="是"></fc:dataset>

<fc:dataset id=findZfjtDataset format="<fields><field><fieldname>bu_id</fieldname><datatype>字符</datatype><displaylabel>执法主体编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>

<fc:dataset id=lajdInfoDataset format="<fields><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>字符</datatype><displaylabel>立案编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>字符</datatype><displaylabel>立案时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EMY_ID</fieldname><datatype>字符</datatype><displaylabel>立案人员ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_POSTIL</fieldname><datatype>字符</datatype><displaylabel>审批意见</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fnCode</fieldname><datatype>字符</datatype><displaylabel>程序功能码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fdpn_para_value</fieldname><datatype>字符</datatype><displaylabel>参数值</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EMY_NAME</fieldname><datatype>字符</datatype><displaylabel>立案人员名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><EMY_ID></EMY_ID><TP_POSTIL></TP_POSTIL><fnCode></fnCode><fdpn_para_value></fdpn_para_value><EMY_NAME></EMY_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
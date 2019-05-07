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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/InformedVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/InformedVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
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
var wftId = creator_getQueryString("wft_id");//事项实例ID;
var ndpId = parent.parent.ndpId; //阶段ID;
var bu_id = creator_getQueryString("bu_id"); //执法主体ID
var piId = creator_getQueryString("pi_id");//事项ID
var read_only = creator_getQueryString("readOnlyFlag");
var user_Ids = "";
var rfl_id = 0; //附件ID


function init() {
    rfl_id = WorkflowUtil.getRilIdByWftIdAndNdpId(wftId, ndpId);
    if(ndpId == "8") {
        $('sdShowID').style.display = "none";
    } else {
        $('sdShowID').style.display = "";
        $('wsTitle').innerHTML = "送达文件";
    }
    user_Ids = parent.$("IDS").value;
    if(!IsSpace(user_Ids)) {
        initUserReceipt(user_Ids);
    } else {
        $('saveBtn').disabled = true;
    }
    $("userIds").value = $("receiptUserId").value;
    $("userNames").value = $("receiptUserNames").value;
    initHiddenPage();
}

function initUserReceipt(ids) {
    var sql = PunishInformed.queryUserReceipt(user_Ids, wftId, ndpId);
    Receiptdataset.Open(sql);
    if (!IsSpace(Receiptdataset.Fields.Field['DDM_ID'].Value)) {
        $("DDM_ID").value = Receiptdataset.Fields.Field['DDM_ID'].Value;
        $("HCU_ID").value = Receiptdataset.Fields.Field['HCU_ID'].Value;
    } else {
        $("DDM_ID").value = -1;
        $("HCU_ID").value = 1;
    }
}

function saveUserReceipt() {
    var templeteArr = PunishInformed.getInstrumentsTemp(piId, ndpId);
    if(templeteArr.length <= 0) {
        alert("处罚事项当前阶段没有配置文书,请配置后再登记回执");
        return;
    }

    if(!validate()){
        return;
    }
    $("userIds").value = $("receiptUserId").value;
    var inforObj = new InformedVo.InstrumentsReceipt();
    var infoVo = DBUtil.getVoFromPage(inforObj);
    var upId = $('IDS').value;//上传附件
    var rv = PunishInformed.saveUserReceipt(infoVo,user_Ids,wftId, ndpId, piId, upId);
    if(rv){
        alert("保存数据信息成功！");
    }else{
        alert("保存数据信息失败！");
    }
}

//打开人员的选择
function openUserTree(){
    if (ndpId==8) {//告知
        url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgUserTree.jsp?bu_id="+bu_id;
    } else {//送达
        url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+bu_id;
    }
      $("userIds").value = $("receiptUserId").value;
    $("userNames").value = $("receiptUserNames").value;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("receiptUserId").value = $("userIds").value;
    $("receiptUserNames").value = $("userNames").value;
    
    if(ndpId==10 && !IsSpace($("userIds").value)){//送达
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

//打开签发人员的选择
function openSignTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseSingleOrgUserTree.jsp?bu_id="+bu_id;
    $("userIds").value = $("LRD_SIGNER").value;
    $("userNames").value = $("SIGNERUSERNAME").value;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("LRD_SIGNER").value = $("userIds").value;
    $("SIGNERUSERNAME").value = $("userNames").value;

}


function validate() {
    var flag = true;    
    $('RLD_PERFORM_TIMELIMIT').value = $('RLD_PERFORM_TIMELIMIT').value.trim();
    if(flag){
        flag = SValidator.validate($("receiptUserId").value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["承办人"]}
        }, true);
    }

    
   /*if (flag) {
        flag = SValidator.validate($("receiptUserId").value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$("receiptUserId").value]},
            MESSAGE : "承办人不能为空!"
        }, true);
    }*/
    
    if (flag) {
        flag = SValidator.validate($('LRD_UNDERTAK_DATE').value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$('LRD_UNDERTAK_DATE').value]},
            MESSAGE : "承办时间不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_SIGNER').value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$('LRD_SIGNER').value]},
            MESSAGE : "签发人不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_SIGN_DATE').value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$('LRD_SIGN_DATE').value]},
            MESSAGE : "签发时间不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_CONTRACTOR').value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$('LRD_CONTRACTOR').value]},
            MESSAGE : "签收人不能为空!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_CONTRACTOR').value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [255],maxlength : 255},
            MESSAGE : "签收人最大不能超过{0}字符!"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_CONTRACT_DATE').value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$('LRD_CONTRACT_DATE').value]},
            MESSAGE : "签收时间不能为空!"
        }, true);
    }
    
    if(ndpId == "10") {
        if (flag) {
            if ($('DDM_ID').value==-1) {
                alert("请选择送达方式!");
                flag = false;
            }
        }
        
        if (flag) {
            flag = SValidator.validate($('RLD_PERFORM_TIMELIMIT').value, {
                CHECK_TYPE : "integer",
                ARGUMENT : {placeholders : ["承诺履行时限"],length : 0}
            }, false);
        }
        if (!IsSpace($('RLD_PERFORM_TIMELIMIT').value)) {
            if (flag) {
                var testNum = /^[0-9]{1,3}$/;
                if (!testNum.test($('RLD_PERFORM_TIMELIMIT').value)) {
                    flag = false;
                    alert("承诺履行时限请输入3位以内正整数！");
                }
            }
        } else {
            $('RLD_PERFORM_TIMELIMIT').value =0;
        }
    }
    
    if (flag) {
        flag = SValidator.validate($('LRD_REMARK').value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [255],maxlength : 255},
            MESSAGE : "备注最大不能超过{0}字符!"
        }, true);
    }
    
    if(flag){
        //告知阶段
        if(ndpId == "8"){
            var time1 = findTransactTime().split(" ")[0];//调查取证办理时间
              var time2 = $('LRD_UNDERTAK_DATE').value;//承办时间
             
              var arys1 = new Array();
            arys1 = time1.split('-');
            var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
            
            var arys2 = new Array();
            arys2 = time2.split('-');
            var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
            if(myDate1 > myDate2){
                alert("承办时间不能小于办理时间");
                flag = false;
            } else {
                flag = true;
            }
        } else {//送达阶段
              var time1 = findPunishmentTime().split(" ")[0];//处罚决定时间
              var time2 = $('LRD_UNDERTAK_DATE').value;//承办时间
              
              var arys1 = new Array();
            arys1 = time1.split('-');
            var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
            
            var arys2 = new Array();
            arys2 = time2.split('-');
            var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
            if(myDate1 > myDate2){
                alert("承办时间不能小于处罚决定时间");
                flag = false;
            } else {
                flag = true;
            }
        }
    }
    
    if (flag) {
        var newTime = $('LRD_UNDERTAK_DATE').value ;
        var tempTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,tempTime);
        if(!flag){
            alert("承办时间不能大于当前时间");
            return false ;
        }           
    }
    
    if(flag){
        var time1 = $('LRD_UNDERTAK_DATE').value;//承办时间
         var time2 = $('LRD_SIGN_DATE').value;//签发时间
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("签发时间不能小于承办时间");
            flag = false;
        } else {
            flag = true;
        }
    }
    
    if (flag) {
        var newTime = $('LRD_SIGN_DATE').value ;
        var tempTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,tempTime);
        if(!flag){
            alert("签发时间不能大于当前时间");
            return false ;
        }           
    }
    
    if(flag){
        var time1 = $('LRD_SIGN_DATE').value;//签发时间
         var time2 = $('LRD_CONTRACT_DATE').value;//签收时间
         
         var arys1 = new Array();
        arys1 = time1.split('-');
        var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = time2.split('-');
        var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
        if(myDate1 > myDate2){
            alert("签收时间不能小于签发时间");
            flag = false;
        } else {
            flag = true;
        }
    }

    if (flag) {
        var newTime = $('LRD_CONTRACT_DATE').value ;
        var tempTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,tempTime);
        if(!flag){
            alert("签收时间不能大于当前时间");
            return false ;
        }           
    }

    return flag;
}

function initHiddenPage() {
    if(read_only == "readOnly") {
        $("saveBtn").style.display = "none";
        document.getElementById("receiptUserNames").style.width = "100%";
        document.getElementById("SIGNERUSERNAME").style.width = "100%";
        HTMLUtil.readOnly($("receiptUserNames"),"commonReadOnly");
        HTMLUtil.readOnly($('LRD_UNDERTAK_DATE'),"commonReadOnly");
        HTMLUtil.readOnly($('SIGNERUSERNAME'),"commonReadOnly");
        HTMLUtil.readOnly($('LRD_SIGN_DATE'),"commonReadOnly");
        HTMLUtil.readOnly($('LRD_CONTRACTOR'),"commonReadOnly");
        HTMLUtil.readOnly($('LRD_CONTRACT_DATE'),"commonReadOnly");
        HTMLUtil.readOnly($('LRD_REMARK'),"commonReadOnly");
        
        if(ndpId == "10") {
            //$('DDM_ID').disabled = true;
            //$('HCU_ID').disabled = true;
            HTMLUtil.readOnly($('DDM_ID'),"commonReadOnly");
            HTMLUtil.readOnly($('HCU_ID'),"commonReadOnly");
            HTMLUtil.readOnly($('RLD_PERFORM_TIMELIMIT'),"commonReadOnly");
        }
    }
}

/* 打开上传下载页面 */
function openUploadAndDownView(){
    if(IsSpace(rfl_id)) {
        rfl_id= DBUtil.getSeq('SEQ_LITIGANT_RD');
        $('IDS').value = rfl_id;
    }
    var isAllowDelete = true ;
    var allowAdd = true;
    if(read_only == "readOnly"){
        allowAdd = false;
        isAllowDelete = false;
    }
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+rfl_id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+rfl_id+"&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    
    return rtn ;
}

//查询调查取证办理时间
function findTransactTime(){
    return WorkflowUtil.queryTransactTime(wftId);
}

//查询处罚决定的时间
function findPunishmentTime(){
    return WorkflowUtil.queryPunishmentTime(wftId);
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
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>LRD_REMARK</id></textarea><combobox><id>DDM_ID</id><id>HCU_ID</id></combobox><button><id>downBtn</id><id>saveBtn</id></button><text><id>receiptUserId</id><id>userIds</id><id>userNames</id><id>receiptUserNames</id><id>LRD_UNDERTAK_DATE</id><id>LRD_SIGNER</id><id>SIGNERUSERNAME</id><id>LRD_SIGN_DATE</id><id>LRD_CONTRACTOR</id><id>LRD_CONTRACT_DATE</id><id>RLD_PERFORM_TIMELIMIT</id><id>IDS</id></text><dataset><id>Receiptdataset</id></dataset></root>" billtaborder="<root><taborder>LRD_REMARK</taborder><taborder>DDM_ID</taborder><taborder>HCU_ID</taborder><taborder>downBtn</taborder><taborder>saveBtn</taborder><taborder>receiptUserId</taborder><taborder>userIds</taborder><taborder>userNames</taborder><taborder>receiptUserNames</taborder><taborder>LRD_UNDERTAK_DATE</taborder><taborder>LRD_SIGNER</taborder><taborder>SIGNERUSERNAME</taborder><taborder>LRD_SIGN_DATE</taborder><taborder>LRD_CONTRACTOR</taborder><taborder>LRD_CONTRACT_DATE</taborder><taborder>RLD_PERFORM_TIMELIMIT</taborder><taborder>IDS</taborder></root>" dj_sn="20100928151643671116" caption="登记回执详细" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:1;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:4;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInformed.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/InformedVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=c2 width="20%">承办人<FONT color=red>*</FONT><INPUT class=input_out id=receiptUserId style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="userIds" china="承办人" dataset="Receiptdataset"><INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 17px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=3 controltype="text"><INPUT id=userNames style="DISPLAY: none; LEFT: 0px; WIDTH: 23px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text"></TD>
                     <TD width="30%"><INPUT class=input_image id=receiptUserNames style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="userNames" china="承办人" dataset="Receiptdataset" onclick='bill_onclick("openUserTree();")'></TD>
                     <TD class=c2 width="20%">承办时间<FONT color=red>*</FONT></TD>
                     <TD width="30%"><INPUT class=its_out id=LRD_UNDERTAK_DATE style="LEFT: 44px; WIDTH: 100%; POSITION: static; TOP: 80px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="LRD_UNDERTAK_DATE" china="承办日期" dataset="Receiptdataset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2>签发人<FONT color=red>*</FONT><INPUT class=input_out id=LRD_SIGNER style="DISPLAY: none; LEFT: 0px; WIDTH: 10px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="LRD_SIGNER" china="签发人" dataset="Receiptdataset"></TD>
                     <TD><INPUT class=input_image id=SIGNERUSERNAME style="LEFT: 44px; WIDTH: 100%; POSITION: static; TOP: 80px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="SIGNERUSERNAME" china="签发人" dataset="Receiptdataset" onclick='bill_onclick("openSignTree()")'></TD>
                     <TD class=c2>签发时间<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=its_out id=LRD_SIGN_DATE style="LEFT: 44px; WIDTH: 100%; POSITION: static; TOP: 80px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="LRD_SIGN_DATE" china="签发日期" dataset="Receiptdataset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2>签收人<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=LRD_CONTRACTOR style="LEFT: 44px; WIDTH: 100%; POSITION: static; TOP: 80px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="LRD_CONTRACTOR" china="签收人" dataset="Receiptdataset"></TD>
                     <TD class=c2>签收时间<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=its_out id=LRD_CONTRACT_DATE style="LEFT: 44px; WIDTH: 100%; POSITION: static; TOP: 80px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="LRD_CONTRACT_DATE" china="签收日期" dataset="Receiptdataset" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR id=sdShowID>
                     <TD class=c2>送达方式<FONT color=red>*</FONT></TD>
                     <TD><SELECT id=DDM_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D6%D6%E8%CC%E0%D6Xr%94%F6j%D6%D6%E8%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%96%AC%94%B8%A8%98%AA%B6%CC%96%98%A6%A0%BA%98%B2%C0%CC%A8%AC%96%98Xrn%F6" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2>承诺履行时限</TD>
                     <TD><INPUT class=input_out id=RLD_PERFORM_TIMELIMIT style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RLD_PERFORM_TIMELIMIT" china="承诺履行时限" dataset="Receiptdataset"><SELECT id=HCU_ID style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="1&#13;&#10;2" temptext="工作日&#13;&#10;工作时" sql check="2"><OPTION value=1 selected>工作日</OPTION><OPTION value=2>工作时</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2 id=wsTitle>告知文件</TD>
                     <TD colSpan=3><BUTTON class=button id=downBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>上传与下载</BUTTON><INPUT id=IDS style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>备注</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=LRD_REMARK style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="LRD_REMARK" china="备注" dataset="Receiptdataset" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveUserReceipt();")'>保存</BUTTON><?xml:namespace prefix = fc /><fc:dataset id=Receiptdataset format="<fields><field><fieldname>LRD_SIGNER</fieldname><datatype>字符</datatype><displaylabel>签发人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_SIGN_DATE</fieldname><datatype>字符</datatype><displaylabel>签发日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>userIds</fieldname><datatype>字符</datatype><displaylabel>承办人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_UNDERTAK_DATE</fieldname><datatype>字符</datatype><displaylabel>承办日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_CONTRACTOR</fieldname><datatype>字符</datatype><displaylabel>签收人</displaylabel><size>255</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_CONTRACT_DATE</fieldname><datatype>字符</datatype><displaylabel>签收日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_ISACCESSORIES</fieldname><datatype>字符</datatype><displaylabel>有附件</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_ASM</fieldname><datatype>字符</datatype><displaylabel>附件存储方式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_REMARK</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>255</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LRD_BODY</fieldname><datatype>字符</datatype><displaylabel>附件体</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>userNames</fieldname><datatype>字符</datatype><displaylabel>承办人</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SIGNERUSERNAME</fieldname><datatype>字符</datatype><displaylabel>签发人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DDM_ID</fieldname><datatype>字符</datatype><displaylabel>送达方式</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RLD_PERFORM_TIMELIMIT</fieldname><datatype>字符</datatype><displaylabel>承诺履行时限</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>HCU_ID</fieldname><datatype>字符</datatype><displaylabel>时限单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><LRD_SIGNER></LRD_SIGNER><LRD_SIGN_DATE></LRD_SIGN_DATE><userIds></userIds><LRD_UNDERTAK_DATE></LRD_UNDERTAK_DATE><LRD_CONTRACTOR></LRD_CONTRACTOR><LRD_CONTRACT_DATE></LRD_CONTRACT_DATE><LRD_ISACCESSORIES></LRD_ISACCESSORIES><LRD_ASM></LRD_ASM><LRD_REMARK></LRD_REMARK><LRD_BODY></LRD_BODY><userNames></userNames><SIGNERUSERNAME></SIGNERUSERNAME><DDM_ID></DDM_ID><RLD_PERFORM_TIMELIMIT></RLD_PERFORM_TIMELIMIT><HCU_ID></HCU_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><LRD_SIGNER></LRD_SIGNER><LRD_SIGN_DATE></LRD_SIGN_DATE><userIds></userIds><LRD_UNDERTAK_DATE></LRD_UNDERTAK_DATE><LRD_CONTRACTOR></LRD_CONTRACTOR><LRD_CONTRACT_DATE></LRD_CONTRACT_DATE><LRD_ISACCESSORIES></LRD_ISACCESSORIES><LRD_ASM></LRD_ASM><LRD_REMARK></LRD_REMARK><LRD_BODY></LRD_BODY><userNames></userNames><SIGNERUSERNAME></SIGNERUSERNAME><DDM_ID></DDM_ID><RLD_PERFORM_TIMELIMIT></RLD_PERFORM_TIMELIMIT><HCU_ID></HCU_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><LRD_SIGNER></LRD_SIGNER><LRD_SIGN_DATE></LRD_SIGN_DATE><userIds></userIds><LRD_UNDERTAK_DATE></LRD_UNDERTAK_DATE><LRD_CONTRACTOR></LRD_CONTRACTOR><LRD_CONTRACT_DATE></LRD_CONTRACT_DATE><LRD_ISACCESSORIES></LRD_ISACCESSORIES><LRD_ASM></LRD_ASM><LRD_REMARK></LRD_REMARK><LRD_BODY></LRD_BODY><userNames></userNames><SIGNERUSERNAME></SIGNERUSERNAME><DDM_ID></DDM_ID><RLD_PERFORM_TIMELIMIT></RLD_PERFORM_TIMELIMIT><HCU_ID></HCU_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
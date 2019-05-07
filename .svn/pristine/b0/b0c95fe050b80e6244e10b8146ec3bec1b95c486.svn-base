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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/EndCaseVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wft_id = creator_getQueryString("wft_id");//获取处罚实例ID
var ltt_id = creator_getQueryString("ltt_id");//获取当事人ID

var maxTime = "";//当事人中最大的签收日期

//初始化
function init() {
    initModuleInfo();
    //查询当事人文书签收时间的最大值
    maxTime = WorkflowUtil.querySendSignInMaxTime(wft_id);
}

//关闭窗口
function closeZheWindow(){
    WorkflowUtil.backToWorklist();
}

//获取当前服务器时间
function getNowTime(){
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

//查询批注状态
function findPostilState(){
    var sql = EndCase.findOpinionInfo(wft_id, 4);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        return "";
    } else {
        return arr[0][2];
    }
}

/*
     函数:   initModuleInfo
     说明:   通过模板生成动态页面入口
             拼接违法行为和自由裁量详细模板
*/
function initModuleInfo() {
    //隐藏模板
    $("$clxz_mb$").style.display = "none";
    $("$clxz_mx_mb$").style.display = "none";
    var result = ExecuteState.findClxzByDsr(wft_id, ltt_id);
    //克隆违法行为模板
    for (var i = 0, count = result.length; i < count; i++) {
        var clxz= HTMLUtil.cloneReplaceElement($("$clxz_mb$"), {
            $clxz_mb$ : "clxz_" + result[i][0],
            $clxzid$ : result[i][0],         //裁量细则ID
            $pic_clxzid$ : "pic_" + result[i][0],//扩张符号ID
            $wfxw_mc$ : result[i][2],        //违法行为名称
            $clxz_mc$ : result[i][1]         //裁量细则名称
        });
        clxz.style.display = "block";
        $("container").insertBefore(clxz, $("executeEndInfo")); 
    }
}

function insertAfter(newEl, targetEl) {
    var parentEl = targetEl.parentNode;
    if (parentEl.lastChild == targetEl) {
        parentEl.appendChild(newEl);
    } else {
        parentEl.insertBefore(newEl, targetEl.nextSibling);
    }            
}

function changeDisplay(element) {
    var ele_first = element.split("_")[0];
    if(ele_first == "clxz"){
        var clxzid = element.split("_")[2];
        var pic = "pic_" + clxzid;
        if($(element).style.display == "none") {
            $(pic).src = "../../../ccapp/app_xzcf/images/minus.gif";
            $(element).style.display = "block";
        } else {
            $(pic).src = "../../../ccapp/app_xzcf/images/plus.gif";
            $(element).style.display = "none";
        }
    } else {
        var clxzid = element.split("_")[1];
        var cfcsid = element.split("_")[2];
        var pic = "pic#" + clxzid + "#" + cfcsid;  
        if($(element).style.display == "none") {
            $(pic).src = "../../../ccapp/app_xzcf/images/minus.gif";
            $(element).style.display = "block";
        } else {
            $(pic).src = "../../../ccapp/app_xzcf/images/plus.gif";
            $(element).style.display = "none";
        } 
    }
}

function changeWFXWState(element) {
    var clxzid = element.flag;
    var result = ExecuteState.findPayByCLXZ(clxzid);//查询该裁量细则的罚金
    var arr1 = ExecuteState.findAlreadyPay(wft_id, ltt_id, clxzid);//查询已缴罚金
    var arr2 = ExecuteState.findLatePay(wft_id, ltt_id, clxzid);//查询滞纳金
    if(arr1 == 0){
        arr1 = "0";
    }
    if(arr2 == 0){
        arr2 = "0";
    }
    if (changeWFXWState["$" + clxzid]) {
        changeDisplay("clxz_mx_" + clxzid);
    } else {
        var clxzmx = HTMLUtil.cloneReplaceElement($("$clxz_mx_mb$"), {
            $clxzid$ : clxzid,
            $pay_clxz$ : "pay_cfje_" + clxzid,   
            $clxz_mx_mb$ : "clxz_mx_" + clxzid,
            $yjje$ : result[0][0],            //应缴金额
              $sjje$ : arr1,                    //实缴金额
              $realPay$ : "realPay_" + clxzid,  //实缴金额ID
            $znj$ : arr2,                    //滞纳金
              $znj_id$ : "znj_id_" + clxzid,    //滞纳金ID
            $iframe_clxzid$ : "iframe_" + clxzid,
            $iframeSrc$ : "../../jxc/dj/20101018200857453925.jsp?wft_id=" + wft_id + "&ltt_id=" + ltt_id + "&clxzId=" + clxzid,
            $button_clxzid$ : "button_" + clxzid,
            $cfcs_clxzid_cfcsid$ : "$cfcs_" + clxzid + "$",
            //$pic_clxzid_cfcsid$ : "$pic_" + clxzid + "$", 
            $cfcsmx_clxzid_cfcsid$ : "$cfcsmx_" + clxzid + "$"
        });
        insertAfter(clxzmx, $("clxz_" + clxzid));
        var pic = "pic_" + clxzid;
        $(pic).src = "../../../ccapp/app_xzcf/images/minus.gif";
        clxzmx.style.display = "block";
        changeWFXWState["$" + clxzid] = true;
        if(result[0][0] == 0){     
            $("pay_cfje_" + clxzid).style.display = "none";//不显示罚金信息
        }
        if(parent.statusValue == 1){
            var buttonID = "button_" + clxzid;
            $(buttonID).style.display = "none";
        }
    }
}

//点击处罚措施
function changeCFCSState(element) {
    var conId = element.flag.replace("#", "_");
    var clxzId = element.flag.split("#")[0];
    var cfcsId = element.flag.split("#")[1];
    if (changeCFCSState["$" + conId]) {
        changeDisplay("cfcsmx_" + conId);
    } else {
       var result = ExecuteState.findPunishMeasureByDsrAndClxz(wft_id, ltt_id, clxzId,cfcsId)//查询该处罚措施的执行情况
        if(result[0][3] == 0){//未执行
           var option = {
            $callback$ : "setZXZT",
            $lxqx$ : result[0][0],              //履行期限
              $zxzt_clxzid_cfcsid$ : "zxzt_" + conId,
            $zxfs_clxzid_cfcsid$ : "zxfs_" + conId,    //执行方式
              $zxsj_clxzid_cfcsid$ : "zxsj_" + conId,    //执行时间
              $zxsj$ : result[0][2],              //执行时间
              $zxzt$ : result[0][1],              //执行状态
              $clxzid_cfcsid$ : element.flag,
            $pic_clxzid_cfcsid$ : "pic#" + element.flag
          };
       } else {
           var option = {    //已执行
                $callback$ : "setZXZT",
              $lxqx$ : result[0][0],              //履行期限
                $zxzt_clxzid_cfcsid$ : "zxzt_" + conId,//执行状态id
              $zxfs_clxzid_cfcsid$ : "zxfs_" + conId,//执行方式id
              $zxsj_clxzid_cfcsid$ : "zxsj_" + conId,//执行时间id
              $zxsj$ : result[0][2],              //执行时间
                $zxzt$ : result[0][1],              //执行状态
                $zxfs$ : result[0][3],              //执行方式
                $save_clxzid_cfcsid$ : "save_" + clxzId + "_" + cfcsId,
              //$clxzid_cfcsid$ : element.flag,
              $pic_clxzid_cfcsid$ : "pic#" + element.flag
           }; 
       }
        option["$cfcsmx_" + clxzId + "$"] = "cfcsmx_" + conId;
        insertAfter(HTMLUtil.cloneReplaceElement($("$cfcsmx_" + clxzId + "$"), option), $("cfcs_" + conId));
        changeDisplay("cfcsmx_" + conId);
        changeCFCSState["$" + conId] = true;
         if(parent.statusValue == 1){
            var saveID = "save_" + clxzId + "_" + cfcsId;
            $(saveID).style.display = "none";
            var zxztId = "zxzt_" + clxzId + "_" + cfcsId; //执行状态ID
            var zxfsId = "zxfs_" + clxzId + "_" + cfcsId; //执行方式ID
            var zxsjId = "zxsj_" + clxzId + "_" + cfcsId; //执行时间ID
            HTMLUtil.readOnly($(zxztId),"commonReadOnly");
            HTMLUtil.readOnly($(zxfsId),"commonReadOnly");
            HTMLUtil.readOnly($(zxsjId),"commonReadOnly");
        }
    }
}

function saveZXZT(element) {    //点击保存按钮
    var clxzId = element.flag.split("#")[0];    //裁量细则ID
    var cfcsId = element.flag.split("#")[1];    //处罚措施ID
    var zxztId = "zxzt_" + clxzId + "_" + cfcsId; //执行状态ID
    var zxfsId = "zxfs_" + clxzId + "_" + cfcsId; //执行方式ID
    var zxsjId = "zxsj_" + clxzId + "_" + cfcsId; //执行时间ID
    var vo = new PunishMeasureVo.PunishMeasure();//执行情况VO
    vo.WFT_ID = wft_id;
    vo.LTT_ID = ltt_id;
    vo.JD_ID = clxzId;
    vo.PM_ID = cfcsId;
    vo.EXECUTING_STATE = $(zxztId).value;       //执行状态值
    vo.EM_ID = $(zxfsId).value;                 //执行方式
    var chooseTime = $(zxsjId).value;              //执行时间
    vo.EXECUTING_DATE = chooseTime;
    var nowTime = getNowTime(); //当前服务器时间
    var arys1 = new Array();
    arys1 = chooseTime.split('-');
    var myDate1 = new Date(arys1[0],arys1[1],arys1[2]);//控件上的时间
    
    var arys2 = new Array();
    arys2 = nowTime.split('-');
    var myDate2 = new Date(arys2[0],arys2[1],arys2[2]);//当前服务器时间
    
    var arys3 = new Array();
    arys3 = maxTime.substring(0,10).split('-');
    var myDate3 = new Date(arys3[0],arys3[1],arys3[2]);//签收时间最大值
    if(myDate1 > myDate2){
        alert("执行时间不能大于当前时间");    
        return;   
    }
    
    if(myDate1 < myDate3){
        alert("执行时间不能小于送达回执签收时间");
        return;
    }
    
    var rv = ExecuteState.updateExecuteState(vo);
    if(IsSpace(rv)){
        alert("保存成功");
    } else {
        alert("保存失败");
    }
}

function loopCFCS(element) {
    var result = ExecuteState.findCfcsByDsrAndClxz(wft_id, ltt_id, element.flag);
    for (var i = 0, count = result.length; i < count; i++) {
        var option = {
            $clxzid_cfcsid$ :  element.flag + "#" + result[i][0],
            $pic_clxzid_cfcsid$ : "pic#" + element.flag + "#" + result[i][0],
            $cfcs_mc$ : result[i][1]
        };
        option["$cfcs_" + element.flag + "$"] = "cfcs_" + element.flag + "_" + result[i][0];
        element.appendChild(HTMLUtil.cloneReplaceElement(element.firstChild, option));
    }
    element.firstChild.style.display = "none";
    element.firstChild.nextSibling.style.display = "none";
}

function setZXZT(element) {
    element.value = element.flag;
}

//点击“新增收据”按钮
function addPayReceipt(element){
    var clxzId = element.flag;  //裁量细则ID
    var tempPara = "dialogWidth:780px,dialogHeight:250px;";
    var tempURL = "20101017150611671822.jsp?djbh=222&wft_id=" + wft_id + "&ltt_id=" + ltt_id + "&clxzId=" + clxzId;
    var returnValue = window.showModalDialog(tempURL, "window", tempPara);
    if(returnValue == true) {
        var iframe = "iframe_" + clxzId;
        var arr1 = ExecuteState.findAlreadyPay(wft_id, ltt_id, clxzId);//查询已缴罚金
        var arr2 = ExecuteState.findLatePay(wft_id, ltt_id, clxzId);//查询滞纳金
        var realPay = "realPay_" + clxzId;
        var znj = "znj_id_" + clxzId;
        $(realPay).innerHTML = arr1;
        $(znj).innerHTML = arr2;
        eval(iframe).location.reload();
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>$zxzt_clxzid_cfcsid$</id><id>$zxfs_clxzid_cfcsid$</id></combobox><img><id>$pic_clxzid$</id><id>$pic_clxzid_cfcsid$</id></img><text><id>$zxsj_clxzid_cfcsid$</id></text></root>" billtaborder="<root><taborder>$zxzt_clxzid_cfcsid$</taborder><taborder>$zxfs_clxzid_cfcsid$</taborder><taborder>$zxsj_clxzid_cfcsid$</taborder></root>" dj_sn="20101017162104093657" caption="裁量细则列表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:3;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/EndCaseVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EndCase.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EndCaseDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<TABLE class=Ctable width="100%" border=0>
   <TBODY id=container>
      <TR id=$clxz_mb$>
         <TD colSpan=2>
            <TABLE class=Ctable width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD onclick=changeWFXWState(this) width=10 flag="$clxzid$"><IMG id=$pic_clxzid$ style="POSITION: static" src="../../../ccapp/app_xzcf/images/plus.gif" controltype="img" plus.gif? images app_xzcf ccapp .. cover="9" srcsk="../../../ccapp/app_xzcf/images/plus.gif"></IMG></TD>
                  <TD>
                     <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                        <TBODY>
                           <TR>
                              <TD class=c2 width="15%">违法行为</TD>
                              <TD width="35%">$wfxw_mc$</TD>
                              <TD class=c2 width="15%">裁量细则</TD>
                              <TD>$clxz_mc$</TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
   <TR id=$clxz_mx_mb$>
      <TD colSpan=2>
         <TABLE class=Ctable width="100%" border=0>
            <TBODY>
               <TR>
                  <TD flag="$clxzid$" callback="loopCFCS">
                     <TABLE class=Ctable id=$cfcs_clxzid_cfcsid$ width="100%" border=0>
                        <TBODY>
                           <TR>
                              <TD onclick=changeCFCSState(this) width=10 flag="$clxzid_cfcsid$"><IMG id=$pic_clxzid_cfcsid$ style="POSITION: static" src="../../../ccapp/app_xzcf/images/plus.gif" controltype="img" plus.gif? images app_xzcf ccapp .. cover="9" srcsk="../../../ccapp/app_xzcf/images/plus.gif"></IMG></TD>
                           <TD>
                              <TABLE class=Ctable width="100%" border=0>
                                 <TBODY>
                                    <TR>
                                       <TD class=c2 width="15%">处罚措施</TD>
                                       <TD>$cfcs_mc$</TD>
                                    </TR>
                                 </TBODY>
                              </TABLE>
                           </TD>
                        </TR>
                     </TBODY>
                  </TABLE>
                  <TABLE class=Ctable id=$cfcsmx_clxzid_cfcsid$ width="100%" border=0>
                     <TBODY>
                        <TR>
                           <TD class=c2 width="15%">履行期限</TD>
                           <TD width="35%">$lxqx$</TD>
                           <TD class=c2 width="15%">执行状态</TD>
                           <TD><SELECT id=$zxzt_clxzid_cfcsid$ style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() flag="$zxzt$" sqltrans controltype="combobox" tempvalue="0&#13;&#10;1&#13;&#10;2" temptext="未执行&#13;&#10;执行中&#13;&#10;已执行" sql check="1" callback="$callback$"><OPTION value=0 selected>未执行</OPTION><OPTION value=1>执行中</OPTION><OPTION value=2>已执行</OPTION></SELECT></TD>
                        </TR>
                        <TR>
                           <TD class=c2 width="15%">执行方式</TD>
                           <TD width="35%"><SELECT id=$zxfs_clxzid_cfcsid$ style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() flag="$zxfs$" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%98%A8%CC%A0%96Xr%94%98%A8%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%98%BE%98%94%B8%B6%A0%BA%98%CC%A8%AC%96%98" controltype="combobox" tempvalue temptext sql check="2" callback="$callback$"></SELECT></TD>
                           <TD class=c2 width="15%">执行时间</TD>
                           <TD><INPUT class=its_out id=$zxsj_clxzid_cfcsid$ style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly flag="$zxsj$" controltype="text" onclick='bill_onclick("SelectDate()")' callback="$callback$"></TD>
                        </TR>
                        <TR>
                           <TD align=middle colSpan=4><INPUT class=button id=$save_clxzid_cfcsid$ onclick=saveZXZT(this) type=button value=保存 flag="$clxzid_cfcsid$"></INPUT></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR id=$pay_clxz$>
            <TD>
               <TABLE class=Ctable width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=4>罚款执行情况</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">应交金额</TD>
                        <TD width="35%">$yjje$&nbsp;元</TD>
                        <TD class=c2 width="15%">实交金额</TD>
                        <TD id=$realPay$ width="35%">$sjje$&nbsp;元</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">滞纳金</TD>
                        <TD id=$znj_id$ width="35%">$znj$&nbsp;元</TD>
                        <TD width="50%" colSpan=2>&nbsp;</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%" rowSpan=2>收据明细</TD>
                        <TD colSpan=3><IFRAME id=$iframe_clxzid$ src="$iframeSrc$" width="100%" height="100%"></IFRAME></TD>
                     </TR>
                     <TR>
                        <TD colSpan=3><INPUT class=button id=$button_clxzid$ onclick=addPayReceipt(this) type=button value=新增 flag="$clxzid$"></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
      </TBODY>
   </TABLE>
</TD>
</TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
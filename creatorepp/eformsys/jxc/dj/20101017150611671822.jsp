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
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wft_id = creator_getQueryString("wft_id");
var ltt_id = creator_getQueryString("ltt_id");
var jd_id = creator_getQueryString("clxzId"); //裁量细则ID

//获取当前服务器时间
function getNowTime(){
    var nowTime = FormUtil.getServerDate(); //当前服务器时间
     var nowTIME = nowTime.substring(0,10);
    return nowTIME;
}


function saveReceipt(){
    if(!validate()){
        return;
    }
    var flag = true;
    var LATER_PAY = 0;
    var vo = new PunishMeasureVo.Receipt();
    vo.WFT_ID = wft_id;
    vo.LTT_ID = ltt_id;
    vo.JD_ID = jd_id;
    vo.EL_VOUCHER_NUMBER = $('EL_VOUCHER_NUMBER').value;//收据编号
    vo.EL_SUM = $('EL_SUM').value;//缴纳金额
    vo.EL_DATE = $('EL_DATE').value;//缴纳日期
    vo.EL_SUM_EXPOSURE = 0;        //金额方向
    var tmp = document.getElementsByName('later_pay');
    if (tmp[0].checked) {
        LATER_PAY = tmp[0].value;
    } else {
        LATER_PAY = tmp[1].value;
    }
    vo.EL_LATE_FEE_ITEM = LATER_PAY;//是否为滞纳金
    var rv = ExecuteState.saveReceipt(vo);
    if(rv){
        alert("保存成功");
        flag = true;
    } else{
        alert("保存失败");
        flag = false;
    }
    return flag;
}

//清空页面
function saveAndInit(){
    $('EL_VOUCHER_NUMBER').value = "";
    $('EL_SUM').value = "";
    $('EL_DATE').value = "";
}

//保存并新增
function save_and_add(){
    if(saveReceipt()){
        saveAndInit();
    }
}

//保存并关闭
function save_and_close(){
    if(saveReceipt()){
        closeZheWindow();
    }
}

function closeZheWindow(){
    window.returnValue = true;
    window.close();
}

//有红色*号的字段为必填写，检测必填项是否填写,检测字段长度，检测时间逻辑限制
function validate(){
    var flag = true;
    ${'EL_VOUCHER_NUMBER'}.value = ${'EL_VOUCHER_NUMBER'}.value.trim();
    ${'EL_SUM'}.value = ${'EL_SUM'}.value.trim();
    //验证收据编号是否填写
    if(flag){
        flag = SValidator.validate(${'EL_VOUCHER_NUMBER'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["收据编号"]}
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("EL_VOUCHER_NUMBER").value)){
            flag = false;
            alert("收据编号不能包含汉字！");
        }            
    }

    //验证收据编号的长度
    if(flag){
        flag = SValidator.validate(${'EL_VOUCHER_NUMBER'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["收据编号", 20], maxlength : 20}
        }, true);
    }
    
    //验证缴纳金额是否填写
    if(flag){
        flag = SValidator.validate(${'EL_SUM'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["缴纳金额"]}
        }, true);
    }
    
    //验证缴纳金额是否为整型
    if(flag){
        flag = SValidator.validate(${'EL_SUM'}.value, {
        CHECK_TYPE : "integer",
        ARGUMENT : {placeholders : ["缴纳金额"], length : 0}
        }, true);
    }
    
    //验证缴纳金额是否为正数
    if(flag){
        var testNum = /^[0-9]{1,13}$/;
        if (!testNum.test($('EL_SUM').value)) {
            alert("缴纳金额请输入13位以内的正整数！");
            flag = false;
        }
    }

    
    //验证缴纳金额的长度
    if(flag){
        flag = SValidator.validate(${'EL_SUM'}.value, {
        CHECK_TYPE : "maxlength",
        ARGUMENT : {placeholders : ["缴纳金额", 18], maxlength : 18}
        }, true);
    } 
    
    //验证缴纳日期是否填写
    if(flag){
        flag = SValidator.validate(${'EL_DATE'}.value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["缴纳日期"]}
        }, true);
    }
    
    //检验缴纳日期不大于当前日期
    if(flag){
        var now_time = getNowTime();
        var choose_time = $('EL_DATE').value;
        var arys1 = new Array();
        arys1 = now_time.split('-'); //当前时间
         var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
        
        var arys2 = new Array();
        arys2 = choose_time.split('-'); //控件上的时间
         var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
    
        if(myDate2 > myDate1){
            alert("缴纳日期不能大于当前日期");
            flag = false;
        }
    }
    return flag;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><button><id>button1</id><id>button6</id><id>button2</id></button><text><id>EL_VOUCHER_NUMBER</id><id>EL_SUM</id><id>EL_DATE</id></text></root>" billtaborder="<root><taborder>EL_VOUCHER_NUMBER</taborder><taborder>EL_SUM</taborder><taborder>EL_DATE</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>button6</taborder></root>" dj_sn="20101017150611671822" caption="新增收据" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:6;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=2>收据信息</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">收据编号<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=EL_VOUCHER_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">缴纳金额<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=EL_SUM style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">缴纳日期<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=its_out id=EL_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">是否滞纳金</TD>
                     <TD>&nbsp;<INPUT type=radio CHECKED value=0 name=later_pay>否&nbsp;<INPUT type=radio value=1 name=later_pay>是&nbsp;</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save_and_add()")'>保存并新增</BUTTON><BUTTON class=button id=button6 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save_and_close()")'>保存并关闭</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("closeZheWindow()")'>取消</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
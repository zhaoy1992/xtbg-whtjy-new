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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wftId = creator_getQueryString("wft_id"); //事项实例ID
var NdpId = creator_getQueryString("ndp_id"); //阶段ID
var pi_id = creator_getQueryString("pi_id");//事项ID
var user_id = getSysElement('userId'); //用户ID
var read_only = creator_getQueryString("readOnlyFlag");
var org_id = creator_getQueryString("bu_id");
var org_name = creator_getQueryString("bu_name");

function init() {
    if(read_only =="readOnly") {
        read_Only();
    }
    $('wft_id').value = wftId;
    $('ndp_id').value = NdpId;
    $('read_only').value = read_only;
    loadCheckUserTable();
    var dsr_user_id = $("dsr_user_id").value;
    $("td_id_"+dsr_user_id).className = "c5";
    //$("iform2").style.height = screen.availHeight-370
}

/**
 * 函数:   readOnly 
 * 说明:   设置只读
 * 参数:   
 * 返回值: 无
*/

function read_Only () {
    $('submitBtn').style.display = "none";
    //$('saveBtn').style.display = "none";
}

/**
 * 当事人详细
 * 
 */
function loadCheckUserTable() {
    var insReceiptArr = PunishDecide.selectPunishUserByWFT_IdOther(wftId);
    var tr = null;
    var tdCount = 4;
    document.getElementById("$template1$").style.display = "none";
    document.getElementById("$template2$").style.display = "none";
    if(insReceiptArr.length > 0) {
        $("dsr_user_id").value = insReceiptArr[0][1];
        for(var i = 0; i < insReceiptArr.length; i++) {
            if (i % tdCount == 0) {
                tr = HTMLUtil.cloneReplaceElement(document.getElementById("$template1$"), {
                    template1 : "tr_id_" + i
                });
            }
            var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
                $USERNAME$ : insReceiptArr[i][0],
                $template2$ : "td_id_"+insReceiptArr[i][1]
            });
            td.style.display = "block";
            tr.appendChild(td);
            if (i % tdCount == 0) {
                tr.style.display = "block";
                document.getElementById("container").appendChild(tr);
            }
        }
        
        var count = 0;
        var tempCount = insReceiptArr.length % tdCount;
        if(tempCount == 0) {
            count = 0;
        } else {
            count = tdCount - tempCount;
        }

        for (var i = 0; i < count; i++) {
            var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
                $USERNAME$ : " ",
                $template2$ : " "
            });
            td.style.display = "block";
            tr.appendChild(td);
        }
    }
}

/**
 * 函数:   savePunishDecide
 * 说明:   保存处罚决定
 * 参数:   
 * 返回值: 无
*/ 
function savePunishDecide(){
    if (confirm("确认结束本阶段?")) {
        if(!validate()){
            return;
        }   
           
        var pdvObj = new PunishDecideVo.PunishDecide();
        var pdVo = DBUtil.getVoFromPage(pdvObj);
        pdvObj.WFT_ID = wftId;
        pdvObj.NDP_ID = NdpId;
        pdvObj.PI_ID = pi_id;
        pdvObj.TP_EMY = user_id;
        pdvObj.SU_ID_INNER = org_id;
        pdvObj.TP_SYSUNIT_NAME = org_name;
        pdvObj.WORKFLOW_NAME = "处罚决定";
        pdvObj.TP_DATE = FormUtil.getServerDate(); 

        var returnValue = PunishDecide.savePunishDecideAEnter(pdVo);
        if(returnValue){
            alert("提交数据信息成功!");
            parent.window.location.href = "20100929153136375631.jsp";
        }else{
            alert("提交数据信息失败!");
        }
    }
}

/**
 * 验证方法
 */
function validate() {
    var flag = true;
    var ltt_names = "";
    var insReceiptArr = PunishDecide.selectPunishUserByWFT_IdOther(wftId);
    if(insReceiptArr.length > 0) {
        for(var i = 0; i < insReceiptArr.length; i++) {
            var countNum= SqlToField(PunishDecide.getIsCountSetupPunish(wft_id,insReceiptArr[i][1]));
            if(parseInt(countNum) == 0) {
                var sql = "select trim(ltt_name) from ta_litigant t where ltt_id = '"+insReceiptArr[i][1]+"'";
                if(ltt_names == "") {
                    ltt_names = SqlToField(sql);
                } else {
                    ltt_names += "," + SqlToField(sql);
                }          
            }
        }
        if(ltt_names != "") {
            flag = false;
            alert("当事人("+ltt_names+")有处罚措施未处理");
        }
    }
    return flag;
}

function saveUserInfo() {
    iform2.savePunishDecideInfo();
} 
function allOpenInfo() {
    iform2.openAllCFCSS();
}
function allCloseInfo() {
    iform2.closeAllCFCSS();
}
function chooseReceipt(userIdsObj) {
        if(userIdsObj.id != " " && userIdsObj.id != null) {
        innerCss(userIdsObj.id);
        iform2.reloadPage(userIdsObj.id.replace("td_id_",""));
    }
}   
function backBtn(){
    parent.window.location.href = "20100929153136375631.jsp";
}

function innerCss(userId) {
   var insReceiptArr = PunishDecide.selectPunishUserByWFT_IdOther(wftId);
   for(var i = 0; i < insReceiptArr.length; i++) {
       var tdId = "td_id_"+insReceiptArr[i][1];
       var tdsytle = document.getElementById(tdId);
       tdsytle.className="";
   }
   $(userId).className = "c5";
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><div><id>div2</id></div><button><id>submitBtn</id><id>returnBtn</id><id>allOpenBtn</id><id>allCloseBtn</id></button><text><id>wft_id</id><id>ndp_id</id><id>read_only</id><id>dsr_user_id</id></text><creatorSubForm><id>iform2</id></creatorSubForm></root>" billtaborder="<root><taborder>submitBtn</taborder><taborder>allOpenBtn</taborder><taborder>allCloseBtn</taborder><taborder>dsr_user_id</taborder><taborder>returnBtn</taborder><taborder>wft_id</taborder><taborder>ndp_id</taborder><taborder>read_only</taborder></root>" dj_sn="20101008101716328044" caption="生成处罚决定" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishDecide.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js">

<TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=center>
   <TBODY>
      <TR id=sccfjdtr>
         <TD><INPUT id=wft_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=ndp_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><INPUT id=read_only style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
         <TD align=right><BUTTON class=button id=submitBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("savePunishDecide();")'>提交</BUTTON><BUTTON class=button id=returnBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("backBtn();")'>返回</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
   <TBODY>
      <TR>
         <TD class=taobox colSpan=3>生成处罚决定</TD>
      </TR>
      <TR>
         <TD class=c2 width="15%">当事人<INPUT id=dsr_user_id style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY id=container>
                  <TR id=$template1$>
                     <TD id=$template2$ onclick=chooseReceipt(this); width="25%">$USERNAME$</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
         <TD width="20%"><BUTTON class=button id=allOpenBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("allOpenInfo();")'>全部展开</BUTTON><BUTTON class=button id=allCloseBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("allCloseInfo();")'>全部收缩</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>
</TR>

<TR id=punishment>

<TD colSpan="3"><DIV id=div2 style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 0px solid; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: auto; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; POSITION: static; TOP: 0px; HEIGHT: 380px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><IFRAME id=iform2 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 98%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load="1" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/20101008091744171948.jsp?1=1&amp;name=&amp;"></IFRAME></DIV></TD>
</TR>

<TR>

<TD>&nbsp;</TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
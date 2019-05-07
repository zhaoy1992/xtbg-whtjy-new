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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js'></script>");
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
//获取该处罚事项实例ID
var wft_id = creator_getQueryString("wft_id");

//获取该裁量细则下的该处罚措施
var jd_id = creator_getQueryString("jd_id");//裁量细则流水
var pm_id = creator_getQueryString("pm_id");//处罚措施ID

//根据“执行信息”是否提交判断初始化

//初始化该处罚措施
function init(){
    var sql = ExecuteState.findPunishMeasure(jd_id,pm_id);
    punishMeasureDataset.Open(sql);
    selectExecuteState();
}

//查询"执行情况"字段内容
function selectExecuteState(){
    var ldt_id = 6;//列示文档归类
    var md_title = "执行情况";
    var sql = DocumentList.findDocumentInfo(wft_id, ldt_id, md_title);
    punishMeasureDataset.Open(sql);
    var executeInfo = punishMeasureDataset..Fields.Field['MD_BODY'].Value;
    if(!IsSpace(executeInfo)){
        $('executeInfo').value = executeInfo;
    }
}

//修改"执行状态"
function updateExecuteState(){
    var vo = new PunishMeasureVo.PunishMeasure();
    vo.WFT_ID = wft_id;
    vo.JD_ID = jd_id;
    vo.PM_ID = pm_id;
    vo.EXECUTING_STATE = $('EXECUTING_STATE').value;
    return vo;
}

//插入"执行情况"字段数据
function insertExecuteInfo(){
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 6;//列示文档归类
    vo.MD_TITLE = "执行情况";
    vo.MD_BODY = $('executeInfo').value;
    vo.WORKFLOW_NAME = "执行";
    return vo;
}

//修改"执行情况"字段数据
function updateExecuteInfo(){
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 6;//列示文档归类
     vo.MD_TITLE = "执行情况";
    vo.MD_BODY = $('executeInfo').value;
    return vo;
}

//点击"保存"按钮
function clickSave(){
    var flag = false;
    var vo1 = updateExecuteState();//修改"执行状态"
    if(IsSpace(selectExecuteState())){//如果"执行情况"内容为空
    //插入"执行情况"字段数据
        var vo2 = insertExecuteInfo();
    //保存  
        flag = true;
        var rv = ExecuteState.savePunishMeasure(vo1, vo2, flag);
        alert(rv);
        if(rv){
            alert("保存成功！");
        } else {
            alert("保存失败！");
        }
    } else {
    //修改"执行情况"字段数据
        var vo3 = updateExecuteInfo();
    //修改
         flag = false;
        var rv = ExecuteState.savePunishMeasure(vo1, vo3, flag);
        alert(rv);
        if(rv){
            alert("保存成功！");
        } else {
            alert("保存失败！");
        }
    }
}

//点击"返回"按钮
function clickBack(){
    window.history.back();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>executeInfo</id></textarea><combobox><id>EXECUTING_STATE</id></combobox><button><id>button1</id><id>button2</id></button><text><id>PM_NAME</id><id>TIME_OF_PERFORMANCE</id><id>EXECUTING_DATE</id></text><dataset><id>punishMeasureDataset</id></dataset></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>EXECUTING_STATE</taborder><taborder>PM_NAME</taborder><taborder>TIME_OF_PERFORMANCE</taborder><taborder>EXECUTING_DATE</taborder><taborder>executeInfo</taborder></root>" dj_sn="20100926200552578075" caption="处罚措施执行情况" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>处罚措施执行情况</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚措施</TD>
                     <TD width="30%"><INPUT id=PM_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="PM_NAME" china="执法措施" dataset="punishMeasureDataset"></TD>
                     <TD class=c2 width="15%">履行期限</TD>
                     <TD width="30%"><INPUT id=TIME_OF_PERFORMANCE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="TIME_OF_PERFORMANCE" china="履行期限" dataset="punishMeasureDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执行状态</TD>
                     <TD width="30%"><SELECT id=EXECUTING_STATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="EXECUTING_STATE" china="执行状态" dataset="punishMeasureDataset" tempvalue="0&#13;&#10;1&#13;&#10;2" temptext="未执行&#13;&#10;执行中&#13;&#10;已执行" sql check="1"><OPTION value=0 selected>未执行</OPTION><OPTION value=1>执行中</OPTION><OPTION value=2>已执行</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">执行时间</TD>
                     <TD width="30%"><INPUT id=EXECUTING_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="EXECUTING_DATE" china="执行时间" dataset="punishMeasureDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执行情况</TD>
                     <TD colSpan=3><TEXTAREA class=input_out onmousemove="this.className='input_move'" id=executeInfo onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onfocus="this.className='input_on';this.onmouseout='" onmovestart=moveStart() onmouseout="this.className='input_out'" controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><BUTTON id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button">保存</BUTTON><BUTTON id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button">返回</BUTTON></TD>
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

<fc:dataset id=punishMeasureDataset format="<fields><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>执法措施</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>执法措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TIME_OF_PERFORMANCE</fieldname><datatype>字符</datatype><displaylabel>履行期限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_STATE</fieldname><datatype>字符</datatype><displaylabel>执行状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_DATE</fieldname><datatype>字符</datatype><displaylabel>执行时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_BODY</fieldname><datatype>字符</datatype><displaylabel>文档体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
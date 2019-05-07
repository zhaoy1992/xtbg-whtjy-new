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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/commonOperation.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/commonOperation.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/workflow.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/workflow.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/public.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/public.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script language='javascript'>
<%if(bDgMode){%>var mylink0 = document.createElement("link");
mylink0.setAttribute("type","text/css");
mylink0.setAttribute("rel","stylesheet");
mylink0.setAttribute("href",stylePath+"css/creatorBlue/style_right.css");
var myhead0 = document.getElementsByTagName("head")[0];
myhead0.appendChild(mylink0);
<%}else{%>adv_loadjsfile(stylePath+'css/creatorBlue/style_right.css');
<%}%></script>
   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>

var ds=new DataStore();
var PageParms = {
    ccFormId : IsSpace(creator_getQueryString("cc_form_instanceid"))? "":creator_getQueryString("cc_form_instanceid"),
    ecId : IsSpace(creator_getQueryString("ec_id"))? "":creator_getQueryString("ec_id"),//事项ID
    itemInsId : IsSpace(creator_getQueryString("item_insid"))? "":creator_getQueryString("item_insid"),//项目实例ID
    itemName : IsSpace(creator_getQueryString("item_name"))? "":creator_getQueryString("item_name"),//事项名称
    crntAction : IsSpace(creator_getQueryString("crnt_action"))? "":creator_getQueryString("crnt_action"),//当前环节
    flowId : "",
    isChargeShow : false,
    isCertFinish : false,
    procInsId:  creator_getQueryString("procInsId")
}


/**
 * 初始化：
 * 本界面有个入口：来自待办列表、来自过期列表、来自挂起、来自回退
 */
function initByInitManager(){


  var sql1="select * from ta_sp_instance where cc_form_instanceid='"+PageParms.ccFormId+"'";
  var sql2="select * from ta_sp_applicant  where cc_form_instanceid='"+PageParms.ccFormId+"'";
  var sql3="select * from ta_sp_applycorp  where cc_form_instanceid='"+PageParms.ccFormId+"'";
  instanceDataset.Open(sql1);
  applycorpDataset.Open(sql3);
  applicantDataset.Open(sql2);

  ds.SendAllRequest();

}

function creator_pt_onbodyload(){
  ds.regRequest(instanceDataset);
  ds.regRequest(applycorpDataset);
  ds.regRequest(applicantDataset);
}





//==============================================功能按钮控制区=========================================

/* 判断是否输入了处理意见 */
function isMemoEntered(){
    if(IsSpace($('HANDLE_AREA').value)){
        alert("请输入处理意见");
        $('HANDLE_AREA').focus();
        return false;
    }
    return true;
}





/* 获取界面参数值，包括处理意见、材料信息等 */
function getTaskData(){

    var tasklistVO = new xzsp.vo.Tasklist();
    tasklistVO.item_insid = PageParms.itemInsId; //设置项目实例ID
    tasklistVO.action_defid = creator_getQueryString("oid"); //活动定义ID
    tasklistVO.action_name = creator_getQueryString("defactname"); 
    tasklistVO.chulimanid = getSysElement("userId");
    tasklistVO.chuliman = getSysElement("userName");
    tasklistVO.org_name = getSysElement("userorgname");
    tasklistVO.handle_result = "是";
    tasklistVO.handle_idea = $('HANDLE_AREA').value;
    tasklistVO.cc_form_instanceid = creator_getQueryString("cc_form_instanceid");
    //alert( tasklistVO.action_name );
    return tasklistVO;
}

/*通过审批项目实例编号查看流程审批历史*/
function showFlowHistoryByInsId(procInsId){
    var url = "../../../common_workflow/workflow_record_list.jsp";
    url = url + "?procInsId="+procInsId;
    var freatrues = "height=630,width=850,status=yes,toolbar=no,menubar=no,location=no";

    window.open(url,"",freatrues );
}

function sendWork(){
 creator_djsave('完成活动',false,true,'../../../common_workflow/main.jsp');
}

function editWord(){
 showModalDialog(getOpenUrlByDjid("20090826091801750969")+".jsp?status=readonly&cc_form_instanceid="+PageParms.ccFormId,"","dialogWidth:600px,dialogHeight:600px");
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();initByInitManager();" contxml="<root><textarea><id>REMARK1</id></textarea><combobox><id>CORP_CERTTYPE</id><id>CORP_TYPE</id><id>CERT_TYPE</id></combobox><img><id>imgOne</id><id>imgTwo</id><id>imgThree</id></img><tab><id>tab2</id></tab><div><id>mainDiv</id><id>workflowControl_complete</id><id>workflowControl_backToPrior</id></div><button><id>btnHistory</id><id>btnViewBaseInfo</id><id>btnBack2List</id><id>button1</id><id>button_wchd</id><id>button_fh</id></button><text><id>ITEM_INSNAME</id><id>INSTANCE_CODE</id><id>ACCEPT_TIME</id><id>CORP_NAME</id><id>CORP_ACCOUNTS</id><id>RELATOR</id><id>RELATOR_MOBILE</id><id>CORP_ADDR</id><id>CORPORATOR</id><id>CORPORATOR_PHONE</id><id>APPLICANT_NAME</id><id>ACCOUNTS</id><id>MOBILE</id><id>PHONE</id><id>ADDRESS</id><id>SEX</id><id>POST</id><id>EMAIL</id><id>workflowControl_result</id></text><dataset><id>applycorpDataset</id><id>instanceDataset</id><id>applicantDataset</id></dataset><creatorSubForm><id>attachSubForm</id><id>taskListSubForm</id></creatorSubForm></root>" billtaborder="<root><taborder>REMARK1</taborder><taborder>CORP_CERTTYPE</taborder><taborder>CORP_TYPE</taborder><taborder>CERT_TYPE</taborder><taborder>btnHistory</taborder><taborder>btnViewBaseInfo</taborder><taborder>btnBack2List</taborder><taborder>ITEM_INSNAME</taborder><taborder>INSTANCE_CODE</taborder><taborder>ACCEPT_TIME</taborder><taborder>CORP_NAME</taborder><taborder>CORP_ACCOUNTS</taborder><taborder>RELATOR</taborder><taborder>RELATOR_MOBILE</taborder><taborder>CORP_ADDR</taborder><taborder>CORPORATOR</taborder><taborder>CORPORATOR_PHONE</taborder><taborder>APPLICANT_NAME</taborder><taborder>ACCOUNTS</taborder><taborder>MOBILE</taborder><taborder>PHONE</taborder><taborder>ADDRESS</taborder><taborder>SEX</taborder><taborder>POST</taborder><taborder>EMAIL</taborder><taborder>button_wchd</taborder><taborder>button_fh</taborder><taborder>workflowControl_result</taborder><taborder>button1</taborder></root>" dj_sn="20090826082754562450" caption="办结表单" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="bspf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib="style_right.css" version="1.0" creator_pagination type="ZW" creatorType="20090825142858531214" jslib="fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js&#13;&#10;../../../ccapp/app_5/js/workflow.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js" creator_allTab="<tabs><tab><id>tab2</id><content><index>0</index><gridid></gridid><iframeid>attachSubForm</iframeid><index>1</index><gridid></gridid><iframeid>taskListSubForm</iframeid></content></tab></tabs>" center="居中">

<TABLE width="100%">
   <TBODY>
      <TR>
         <TD>
            <TABLE class=table_sidle width="100%">
               <TBODY>
                  <TR>
                     <TD class=all_title align=left width="50%"><DIV id=divItemName></DIV></TD>
                     <TD class=all_title align=right><DIV id=divCurrentTache></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=btn id=btnHistory onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("showFlowHistoryByInsId(PageParms.procInsId);")'>办理历史</BUTTON><BUTTON class=btn id=btnViewBaseInfo onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openBaseInfoView()")'>查看审批规范</BUTTON><BUTTON class=btn id=btnBack2List onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("history.back(-1);")'>返回</BUTTON><BUTTON class=btn id=button1 onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("editWord()")'>WORD文档</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD>
                        <TABLE class=table_function width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color width="15%">项目名称</TD>
                                 <TD colSpan=3><INPUT id=ITEM_INSNAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ITEM_INSNAME" china="ITEM_INSNAME" dataset="instanceDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">受理流水号</TD>
                                 <TD width="35%"><INPUT id=INSTANCE_CODE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="INSTANCE_CODE" china="INSTANCE_CODE" dataset="instanceDataset"></TD>
                                 <TD class=color width="15%">受理日期</TD>
                                 <TD><INPUT id=ACCEPT_TIME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ACCEPT_TIME" china="ACCEPT_TIME" dataset="instanceDataset"><IMG id=imgOne style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() height=16 src="../../../ccapp/app_5/images/menu_off.gif" width=16 controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('instanceDefaultHideArea')&quot;)" cover="9" srcsk="../../../ccapp/app_5/images/menu_off.gif"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>
                        <TABLE class=table_function_other id=instanceDefaultHideArea style="DISPLAY: none" width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color width="15%">备注</TD>
                                 <TD><TEXTAREA id=REMARK1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 42px" onmovestart=moveStart() readOnly controltype="textarea" field="REMARK1" china="REMARK1" dataset="baseinfoDataset" value="textarea1" induce="否"></TEXTAREA></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD>
                        <TABLE class=table_function id=applyCorpArea width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color>单位名称</TD>
                                 <TD colSpan=3><INPUT id=CORP_NAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CORP_NAME" china="CORP_NAME" dataset="applycorpDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">证件名称</TD>
                                 <TD width="35%"><SELECT id=CORP_CERTTYPE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans controltype="combobox" field="CORP_CERTTYPE" china="证件类型" dataset="applycorpDataset" tempvalue="0&#13;&#10;1" temptext="工商注册号&#13;&#10;组织机构代码" sql check="1"><OPTION value=0 selected>工商注册号</OPTION><OPTION value=1>组织机构代码</OPTION></SELECT></TD>
                                 <TD class=color width="15%">证件号码</TD>
                                 <TD><INPUT id=CORP_ACCOUNTS style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CORP_ACCOUNTS" china="CORP_ACCOUNTS" dataset="applycorpDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color>联系人</TD>
                                 <TD><INPUT id=RELATOR style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="RELATOR" china="RELATOR" dataset="applycorpDataset"></TD>
                                 <TD class=color>联系电话</TD>
                                 <TD><INPUT id=RELATOR_MOBILE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=16 controltype="text" field="RELATOR_MOBILE" china="RELATOR_MOBILE" dataset="applycorpDataset"><IMG id=imgTwo style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() height=16 src="../../../ccapp/app_5/images/menu_off.gif" width=16 controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('applyCorpDefaultHideArea')&quot;)" cover="9" srcsk="../../../ccapp/app_5/images/menu_off.gif"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>
                        <TABLE class=table_function_other id=applyCorpDefaultHideArea style="DISPLAY: none" width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color>单位地址</TD>
                                 <TD colSpan=3><INPUT id=CORP_ADDR style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CORP_ADDR" china="CORP_ADDR" dataset="applycorpDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">单位性质</TD>
                                 <TD width="35%"><SELECT id=CORP_TYPE style="WIDTH: 100%; POSITION: static; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%96%98%AE%B6%B6%C0%AE%98%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%90%AE%AE%CCxj%B6%90%CC%AE%90%B2%90%A8%CC%96%98%AE%B6%B6%C0%AE%98" controltype="combobox" field="CORP_TYPE" china="CORP_TYPE" dataset="applycorpDataset" tempvalue="国有企业&#13;&#10;非国有企业" temptext="国有企业&#13;&#10;非国有企业" sql check="1" backwidth="229" backheight="25"><OPTION value=国有企业 selected>国有企业</OPTION><OPTION value=非国有企业>非国有企业</OPTION></SELECT></TD>
                                 <TD width="15%"></TD>
                                 <TD></TD>
                              </TR>
                              <TR>
                                 <TD class=color>法人代表</TD>
                                 <TD><INPUT id=CORPORATOR style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CORPORATOR" china="CORPORATOR" dataset="applycorpDataset"></TD>
                                 <TD class=color>法人代表电话</TD>
                                 <TD><INPUT id=CORPORATOR_PHONE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="CORPORATOR_PHONE" china="CORPORATOR_PHONE" dataset="applycorpDataset"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>
                        <TABLE class=table_function id=applicantArea style="DISPLAY: none" width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color>申请人姓名</TD>
                                 <TD colSpan=3><INPUT id=APPLICANT_NAME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="APPLICANT_NAME" china="APPLICANT_NAME" dataset="applicantDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">证件类型</TD>
                                 <TD width="35%"><SELECT id=CERT_TYPE style="WIDTH: 100%; POSITION: static; HEIGHT: 25px" disabled onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%98%B2%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%90%AE%AE%CCxj%B6%90%CC%AE%90%B2%90%A8%CC%94%98%B2%B6" controltype="combobox" field="CERT_TYPE" china="CERT_TYPE" dataset="applicantDataset" tempvalue temptext sql check="2" backwidth="227" backheight="25"></SELECT></TD>
                                 <TD class=color width="15%">证件号码</TD>
                                 <TD><INPUT id=ACCOUNTS style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ACCOUNTS" china="ACCOUNTS" dataset="applicantDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color>手机号码</TD>
                                 <TD><INPUT id=MOBILE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="MOBILE" china="MOBILE" dataset="applicantDataset"></TD>
                                 <TD class=color>座机号码</TD>
                                 <TD><INPUT id=PHONE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=17 controltype="text" field="PHONE" china="PHONE" dataset="applicantDataset"><IMG id=imgThree style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() height=16 src="../../../ccapp/app_5/images/menu_off.gif" width=16 controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('applicantDefaultHideArea')&quot;)" cover="9" srcsk="../../../ccapp/app_5/images/menu_off.gif"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>
                        <TABLE class=table_function_other id=applicantDefaultHideArea style="DISPLAY: none" width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color>住址</TD>
                                 <TD colSpan=3><INPUT id=ADDRESS style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ADDRESS" china="ADDRESS" dataset="applicantDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">性别</TD>
                                 <TD width="35%"><INPUT id=SEX style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="SEX" china="SEX" dataset="applicantDataset"></TD>
                                 <TD class=color width="15%"></TD>
                                 <TD></TD>
                              </TR>
                              <TR>
                                 <TD class=color>邮编</TD>
                                 <TD><INPUT id=POST style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="POST" china="POST" dataset="applicantDataset"></TD>
                                 <TD class=color>邮箱</TD>
                                 <TD><INPUT id=EMAIL style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="EMAIL" china="EMAIL" dataset="applicantDataset"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><DIV id=mainDiv style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 253px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab2 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 92.53%" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 74px"><H2 class=tab>材料信息</H2><IFRAME id=attachSubForm style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 209px" onmovestart=moveStart() src="" frameBorder=no scrolling=no controltype="creatorSubForm" id_load="1" objType="eform" autoload="yes" autoSetSize="no" url="../../jxc/dj/20090825161955609398.jsp?ecId=1341"></IFRAME></DIV><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 74px"><H2 class=tab>意见列表</H2><IFRAME id=taskListSubForm style="LEFT: 50px; WIDTH: 100%; POSITION: static; TOP: 50px; HEIGHT: 209px" onmovestart=moveStart() src="" frameBorder=no scrolling=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url="../../jxc/dj/20090826083758343990.jsp"></IFRAME></DIV></DIV><SCRIPT>var tab2 = new WebFXTabPane( document.getElementById( "tab2" ) );</SCRIPT></DIV></TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=table_sidle width="100%">
               <TBODY>
                  <THEAD>
                     <TR>
                        <TD width="30%"></TD>
                        <TD></TD>
                     </TR>
                  </THEAD>
                  <TBODY>
                     <TR>
                        <TD></TD>
                        <TD></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD vAlign=top align=right><DIV id=workflowControl1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%" onmovestart=moveStart() controltype="workflowControl" NotBg="是"><DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_wchd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("sendWork();")'>完成活动</BUTTON></DIV><DIV id=workflowControl_backToPrior style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是"><BUTTON class=button1 id=button_fh style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("history.back();")'>返回</BUTTON></DIV><INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text"></DIV></TD>
         </TR>
      </TBODY>
   </TABLE>
   <?xml:namespace prefix = fc />
   <fc:dataset id=applycorpDataset format="<fields><field><fieldname>APPLYCORP_ID</fieldname><datatype>字符</datatype><displaylabel>APPLYCORP_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORPORATOR</fieldname><datatype>字符</datatype><displaylabel>CORPORATOR</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORPORATOR_PHONE</fieldname><datatype>字符</datatype><displaylabel>CORPORATOR_PHONE</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_ACCOUNTS</fieldname><datatype>字符</datatype><displaylabel>CORP_ACCOUNTS</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_ADDR</fieldname><datatype>字符</datatype><displaylabel>CORP_ADDR</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_NAME</fieldname><datatype>字符</datatype><displaylabel>CORP_NAME</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_TYPE</fieldname><datatype>字符</datatype><displaylabel>CORP_TYPE</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_CERTTYPE</fieldname><datatype>字符</datatype><displaylabel>证件类型</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RELATOR</fieldname><datatype>字符</datatype><displaylabel>RELATOR</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RELATOR_MOBILE</fieldname><datatype>字符</datatype><displaylabel>RELATOR_MOBILE</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE><CORP_ACCOUNTS></CORP_ACCOUNTS><CORP_ADDR></CORP_ADDR><CORP_NAME></CORP_NAME><CORP_TYPE></CORP_TYPE><CORP_CERTTYPE></CORP_CERTTYPE><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE><CORP_ACCOUNTS></CORP_ACCOUNTS><CORP_ADDR></CORP_ADDR><CORP_NAME></CORP_NAME><CORP_TYPE></CORP_TYPE><CORP_CERTTYPE></CORP_CERTTYPE><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE></dsid>")' onValid='bill_ondatasetvalid("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE><CORP_ACCOUNTS></CORP_ACCOUNTS><CORP_ADDR></CORP_ADDR><CORP_NAME></CORP_NAME><CORP_TYPE></CORP_TYPE><CORP_CERTTYPE></CORP_CERTTYPE><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE></dsid>")' opensortno="1" temptable="TMP_DATASET2" saveastable="APP_5.TA_SP_APPLYCORP" multiResult="否"></fc:dataset>
   <fc:dataset id=instanceDataset format="<fields><field><fieldname>ITEM_INSID</fieldname><datatype>字符</datatype><displaylabel>ITEM_INSID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>INSTANCE_CODE</fieldname><datatype>字符</datatype><displaylabel>INSTANCE_CODE</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_INSNAME</fieldname><datatype>字符</datatype><displaylabel>ITEM_INSNAME</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STATUS</fieldname><datatype>字符</datatype><displaylabel>STATUS</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACCEPT_TIME</fieldname><datatype>日期</datatype><displaylabel>ACCEPT_TIME</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLY_ID</fieldname><datatype>字符</datatype><displaylabel>APPLY_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLY_TYPE</fieldname><datatype>字符</datatype><displaylabel>APPLY_TYPE</displaylabel><size>1</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLY_ID></APPLY_ID><APPLY_TYPE></APPLY_TYPE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLY_ID></APPLY_ID><APPLY_TYPE></APPLY_TYPE></dsid>")' onValid='bill_ondatasetvalid("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLY_ID></APPLY_ID><APPLY_TYPE></APPLY_TYPE></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="否"></fc:dataset>
   <fc:dataset id=applicantDataset format="<fields><field><fieldname>ACCOUNTS</fieldname><datatype>字符</datatype><displaylabel>ACCOUNTS</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ADDRESS</fieldname><datatype>字符</datatype><displaylabel>ADDRESS</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLICANT_ID</fieldname><datatype>字符</datatype><displaylabel>APPLICANT_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLICANT_NAME</fieldname><datatype>字符</datatype><displaylabel>APPLICANT_NAME</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CERT_ID</fieldname><datatype>实数</datatype><displaylabel>CERT_ID</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CERT_TYPE</fieldname><datatype>字符</datatype><displaylabel>CERT_TYPE</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MOBILE</fieldname><datatype>字符</datatype><displaylabel>MOBILE</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PHONE</fieldname><datatype>字符</datatype><displaylabel>PHONE</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EMAIL</fieldname><datatype>字符</datatype><displaylabel>EMAIL</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>POST</fieldname><datatype>字符</datatype><displaylabel>POST</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SEX</fieldname><datatype>字符</datatype><displaylabel>SEX</displaylabel><size>5</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ACCOUNTS></ACCOUNTS><ADDRESS></ADDRESS><APPLICANT_ID></APPLICANT_ID><APPLICANT_NAME></APPLICANT_NAME><CERT_ID></CERT_ID><CERT_TYPE></CERT_TYPE><MOBILE></MOBILE><PHONE></PHONE><EMAIL></EMAIL><POST></POST><SEX></SEX></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ACCOUNTS></ACCOUNTS><ADDRESS></ADDRESS><APPLICANT_ID></APPLICANT_ID><APPLICANT_NAME></APPLICANT_NAME><CERT_ID></CERT_ID><CERT_TYPE></CERT_TYPE><MOBILE></MOBILE><PHONE></PHONE><EMAIL></EMAIL><POST></POST><SEX></SEX></dsid>")' onValid='bill_ondatasetvalid("<dsid><ACCOUNTS></ACCOUNTS><ADDRESS></ADDRESS><APPLICANT_ID></APPLICANT_ID><APPLICANT_NAME></APPLICANT_NAME><CERT_ID></CERT_ID><CERT_TYPE></CERT_TYPE><MOBILE></MOBILE><PHONE></PHONE><EMAIL></EMAIL><POST></POST><SEX></SEX></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
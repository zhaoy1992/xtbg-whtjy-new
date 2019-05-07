<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,
java.util.List,java.util.ArrayList,
com.frameworkset.util.StringUtil,
com.chinacreator.workflow.shark.SharkEngine,
com.chinacreator.eform.formmanage.dbmanager.FormManager,
com.chinacreator.eform.formmanage.vo.FormCtrl,
org.enhydra.shark.SharkUtilities,
org.enhydra.shark.xpdl.elements.Activity,
org.enhydra.shark.api.client.wfmodel.WfActivity,
com.chinacreator.workflow.shark.SharkUtil,
com.chinacreator.spi.impl.local.EformManagerImpl,
org.enhydra.shark.api.SharkTransaction,
com.lutris.appserver.server.sql.DBConnection,
org.apache.log4j.Logger
,com.chinacreator.spi.api.EformManager
,com.chinacreator.commonworkflow.ComponentFactory 
,com.chinacreator.commonworkflow.util.FormUtils
,com.chinacreator.workflow.shark.procconfig.ProcessConfigManager
,com.chinacreator.epp.util.EgpManager"%>
 
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%@page import="org.enhydra.shark.api.common.SharkConstants"%>
<%!private static final Logger logger = Logger.getLogger("handle_tobe_work");%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String actInsId = request.getParameter("actInsId");
	String busiId = request.getParameter("busiId");
	String tobeWorkDBId = request.getParameter("tobeWorkDBId");
	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	String DYNAMICPERFORMER = request.getParameter("DYNAMICPERFORMER");
	String next_acts = request.getParameter("next_acts");
	String andsplitusers = request.getParameter("andsplitusers");
	String moduleId = (String) request.getParameter("moduleId");//add by luming。tang
	//获取模块数据源，如果是非平台配置的模块数据源，需要替换此处
//	String moduleDBName = EgpManager.getMenuDBNameByMenuID(accesscontroler.getCurrentSystemID(),moduleId);
	//动态跳转
	String url = "";
	String listFolder = StringUtil.replaceNull(request
			.getParameter("url"));
	if (listFolder.length() > 0) {
		url = "/" + listFolder + "/";
	} else {
		url = "/common_workflow/";
	}
	url += "tobe_work_list.jsp";
	String backUrl = "../" + url;

	if (isError == null) {
		isError = "";
	}
	SharkTransaction t = null;
	DBConnection dbConn = null;
	SharkEngine shark = SharkEngine.getInstance();
	String userName = accesscontroler.getUserAccount();
	//活动表单的定义id
	String formDefId = "";
	boolean isShowBackButton = false;
	boolean isShowUserText = false;
	boolean isShowActSelectText = false;
	boolean isShowAndActSelectText = false;
	boolean hasFlowButt = false;
	boolean isEformPage = true;//是否为eform页面 add by luming.tang at 2009-6-23
	
	List actList = null;
	String procDefId = "";
	String procInsId = "";
	String mgrName = "";
	String mgrNameEncode = "";
	String procDefName = "";
	String actDefId = "";
	String actDefName = "";
	String actId = "";
	String actName = "";
	String andsplitname = "";
	FormManager fm = new FormManager();
	List extList = null;
	try {
		t = SharkUtil.createTransaction();
		shark.loginWorkflowServer(t, userName, "");
		dbConn = SharkUtil.getDBConnection(t);
		WfActivity act = SharkUtil.currentLoginInfo()
		.getExecutionAdministration().getActivity(t, actInsId);
		procDefId = act.container(t).manager(t).process_definition_id(t);
		procInsId = act.container(t).key(t);
		mgrName = act.container(t).manager(t).name(t);
		mgrNameEncode = StringUtil.encode(mgrName);
		procDefName = act.container(t).manager(t)
		.process_definition_name(t);
		Activity actDefObj = SharkUtilities.getActivityDefinition(t,
		actInsId);
		actDefId = actDefObj.getId();
		actDefName = actDefObj.getName();
		if (actDefObj.isAndTypeJoin())// 如果是与节点则不允许回退
		{
			isShowBackButton = false;
		}
		isShowUserText = shark.isChooseUserFromActIns(t, actInsId);
		isShowActSelectText = shark.isShowXorActivityInput(t, actInsId);
		if (isShowActSelectText) {
			actList = shark.getNextActivities(t, actInsId);
		} else {
			isShowAndActSelectText = shark.isShowAndUserInput(t,
			actInsId);
		}
		//formDefId = shark.getFormDefIdFromActIns(t, actInsId);
		//EformManagerImpl eformImpl = new EformManagerImpl();
		//hasFlowButt = eformImpl.hasWorkFlowButton(dbConn, formDefId);
		//formDefId = shark.getFormDefIdFromActIns(t,actInsId);
    		//这里从外围配置中获取活动配置的表单,如果没有则从定义中取 add by luming.tang at 2009-6-23
			ProcessConfigManager procConfigManager = new ProcessConfigManager();
			formDefId = procConfigManager.getActivityFormByInsId(procInsId, actInsId);
			if(formDefId==null || "".equals(formDefId)){
				formDefId = shark.getFormDefIdFromActIns(t, actInsId);
			}
			// 判断表单是否包含工作流控件
			//EformManager eformImpl = ComponentFactory.getEformManagerInstance();
			//hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			//add by luming.tang at 2009-6-23
			isEformPage=(!FormUtils.isURL(formDefId));
			if(isEformPage){
				EformManager eformImpl = ComponentFactory.getEformManagerInstance();
				hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			}else{//如果表单是jsp页面
				hasFlowButt =  false;
			} 		  		

		if (formDefId == null || formDefId.length() == 0 ||!isEformPage) {
			extList = new ArrayList();
		} else {
			extList = fm.queryFormCtrls(formDefId, procDefId);
		}
				
		String andact[] = new String[0];
		
		if (!"".equals(andsplitusers)) {
			andact = andsplitusers.split(";");
		}
		
		for(int i=0;i<andact.length;i++){
			String selectAct=andact[i].split(":")[0];
			String pkgId = mgrName.split("#")[0];
			String version = mgrName.split("#")[1];
			String prDefId = mgrName.split("#")[2];
			Activity actUser =SharkUtilities.getActivityDefinition(pkgId, version, prDefId, null, selectAct);
			String selectname = actUser.getName();
			andsplitname += selectname+"@";
		}		
		if (hasFlowButt) {
			isShowUserText = isShowActSelectText = isShowAndActSelectText = false;
		}

		// 提交事务
		SharkUtil.commitTransaction(t);
	} catch (Exception e) {
		logger.error("暂存页面获取流程信息异常",e);
		try {
			// 回滚事务
			SharkUtil.rollbackTransaction(t);
		} catch (Exception ex) {
			logger.error("exception in rollbackTransaction:", ex);
		}
	} finally {
		//add by minghua.guo 2010-7-30 关闭连接
		if(dbConn != null){
			dbConn.release();
		}
		shark.logoutWorkflowServer(t);// 退出工作流
		try {
			// 释放事务
			SharkUtil.releaseTransaction(t);
		} catch (Exception e) {
			logger.error("exception in releaseTransaction:", e);
		}
	}

	//add by minghua.guo[2011-04-14] 获取用户名，设置登录用户机构id到工作流引擎
	String user_name = (String) request.getParameter("userName");
	//当前待办任务用户处理机构id
	String login_orgid = "";
	if(SharkEngineManager.getInstance().isSys_user_enablemutiorg()){//判断是否启动兼职借调
		//shark.setLogin_orgid(user_name);
		if(user_name!= null && user_name.indexOf(SharkConstants.USER_ORG_TOKEN) > 0){
			login_orgid = user_name.substring(user_name.indexOf(SharkConstants.USER_ORG_TOKEN) + SharkConstants.USER_ORG_TOKEN.length());
		}else{
			login_orgid = "";
		}
	}
%>
<html>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script language="JavaScript" 
		src="<%=request.getContextPath()%>/eformsys/fceform/js/openDjUrl.js"
		type="text/javascript">
</script>
<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
<script language="JavaScript">
<%if(isError.equals("true")){%>
	alert("<%=message%>");
<%}%>
function setFormCtrlField()
{
	<%for(int i = 0;i < extList.size();i++) {
		FormCtrl formCtrl = (FormCtrl) extList.get(i);
		String fieldName = formCtrl.getCtrlId();
		String initValue = formCtrl.getInitValue();
	%>
	var o = document.workflowform.<%=fieldName%>;
	var b = r_down.document.frames[1].document.all.<%=fieldName%>;
	if(o&&b){ o.value = b.value;} 
	<%}%>
}
function displayBut()
{
	if(document.workflowform.cmplt_form)document.workflowform.cmplt_form.style.display = "none";
	if(document.workflowform.back_form)document.workflowform.back_form.style.display = "none";
}
function completeAct()
{
	outMsg = "请确认您是否已经保存表单，是否继续";
	var isSave = document.getElementById("cc_form_issave").value;
	if(isSave == "false"){
		if(confirm("你还没有保存业务数据，确定提交？")){
			isSave = "true";
		}
	}
	if (isSave == "true"){
		document.getElementById("cc_form_issave").value = "true";
		setFormCtrlField();
		displayBut();	
		document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=resumeAct";
		document.workflowform.submit();
	}		
}
function backAct()
{
	outMsg = "请确认您是否已经保存表单，是否继续";
	if (confirm(outMsg)){
		displayBut();
		document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=backAct";
		document.workflowform.submit();
	}	
}
function adduser(){
	var actDefId = "";
	var type = "common";
	if(document.workflowform.NEXT_ACT){
		actDefId = document.workflowform.NEXT_ACT.value;
		type = "act";
	}
   	window.open('select_user_modal.jsp?moduleId=<%=moduleId %>&actInsId=<%=actInsId%>&actDefId='+actDefId+'&type='+type
   	,'newWin'
   	,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
}
function addAndUser(){
   	var ret = showModalDialog("select_andsplit_user.jsp?moduleId=<%=moduleId %>&actInsId=<%=actInsId%>"
   	,window
   	,"status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no");
   	if(ret !=null ){
	   	var str1 = ret.split("#")[0];
	   	var str2 = ret.split("#")[1];
	   	document.workflowform.ANDSPLITUSERS.value=str1;
	   	document.workflowform.ANDSPLITUSERS_ACTNAME.value=str2;
   	}
}
function clearText(){
	if(document.workflowform.ANDSPLITUSERS)document.workflowform.ANDSPLITUSERS.value="";
	if(document.workflowform.DYNAMICPERFORMER)document.workflowform.DYNAMICPERFORMER.value="";
	if(document.workflowform.ANDSPLITUSERS_ACTNAME)document.workflowform.ANDSPLITUSERS_ACTNAME.value="";
}

//暂存
function saveTemp()
{
	outMsg = "请确认您是否已经保存数据。";
	var isSave = document.getElementById("cc_form_issave").value;
	if(isSave == "false"){
		if(confirm("你还没有保存业务数据，确定提交？")){
			isSave = "true";
		}
	}
	if (isSave == "true"){
		document.getElementById("cc_form_issave").value = "true";
		displayBut();
		document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=savaTempWhenHandle";
		document.workflowform.submit();
	}		
}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" >
<%if(hasFlowButt) {%>
<DIV style="display:none">
<%} %>
<DIV valign=top style="width:100%;height:0;overflow:auto">
<form name="workflowform" action="handle_tobe_work.jsp" method="post">
<input type="hidden" name="busiId" value="<%=busiId %>">
<input type="hidden" name="mgrName" value="<%=mgrName%>">
<input type="hidden" name="moduleId" value="<%=moduleId%>">
<input type="hidden" name="cc_form_issave" value="false">
<input type="hidden" name="mgrNameEncode" value="<%=mgrNameEncode%>">
<input type="hidden" name="tobeWorkDBId" value="<%=tobeWorkDBId%>">
<input type="hidden" name="actInsId" value="<%=actInsId%>">
<input type="hidden" name="curUserName" value="<%=userName%>">
<input type="hidden" name="formDefId" value="<%=formDefId%>">
<input type="hidden" name="next_acts" value="<%=next_acts%>">
<input type="hidden" name="DYNAMICPERFORMER" value="<%=DYNAMICPERFORMER%>">
<input type="hidden" name="andsplitusers" value="<%=andsplitusers%>">
<input type="hidden" name="url" value="<%=url%>">
<input type="hidden" name="isTobeHandle" value="true">
<%
		for (int i = 0; i < extList.size(); i++) {
		FormCtrl formCtrl = (FormCtrl) extList.get(i);
		String fieldName = formCtrl.getCtrlId();
		String initValue = formCtrl.getInitValue();
%>
<input type="hidden" name="<%=fieldName%>" value="<%=initValue%>">
<%
}
%>
  <table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
	<tr>
	  <td align="right">
	  
	  	<%
	  	  	if (isShowActSelectText) {//是否选择后续活动
	  	  	%>
			选择活动：
			<select name="NEXT_ACT">
				<%
							for (int i = 0; i < actList.size(); i++) {
							Activity nextAct = (Activity) actList.get(i);
							String actId2 = nextAct.getId();
							String actName2 = StringUtil.replaceNull(nextAct.getName());
							if (actName2.length() < 1)
						actName2 = actId2;
							if (next_acts.equals(actId2)) {
				%>
							<option value="<%=actId2%>" selected="selected"><%=actName2%></option>
						<%
						} else {
						%>
							<option value="<%=actId2%>"><%=actName2%></option>
						<%
								}
								}
						%>
			</select>
	  	<%
	  	}
	  	%>
	 	<%
	 	if (isShowUserText) {//是否显示选择下一步执行人
	 	%>
	    <INPUT type="button" class="input" value="选执行人" onclick="adduser()">
	    <INPUT type="button" class="input" value="清空" onclick="clearText()">
	    <input type="text" name="DYNAMICPERFORMER" size="50" value="<%=DYNAMICPERFORMER%>" readonly="true">
	    <%
	    } else if (isShowAndActSelectText) {//与分支
	    %>
	    <INPUT type="button" class="input" value="选执行人" onclick="addAndUser()">
	    <INPUT type="button" class="input" value="清空" onclick="clearText()">
	    <input type="hidden" name="ANDSPLITUSERS" >
	    <input type="text" name="ANDSPLITUSERS_ACTNAME" size="80" value="" readonly="true">
	    <%
	    }
	    %>
		<input class="input" type="button" name="cmplt_form" value="完成活动" onClick="completeAct()">
		<!--
		 	启动多次暂存，add by minghua.guo 2010-10-11	
		-->
		<input class="input" type="button" name="temp_sava" value="暂存数据" onClick="saveTemp()">
		<%
		if (isShowBackButton) {
		%>
	    <input class="input" type="button" name="back_form" value="退回" onClick="backAct()">
	    <%
	    }
	    %> 
	    
	  </td>
	</tr>	
  </table>
</form>
</DIV>
<%if(hasFlowButt) {%>
</DIV>
<%} %>
<div style="width:100%;height:100%;overflow:hidden">
<form name="eform" action="" method="post">
 <table width="99%" cellpadding="0" cellspacing="0" border="1" style="padding:2 " bordercolorlight="#3B4D61" bordercolordark="#ffffff">
 <tr>
   <td  valign="top">
   	 <iframe name="r_down" height=570px width="100%" src=""  frameborder="0" ></iframe>
   </td>
 </tr>
</table>
</form>
</div>
</body>
<script language="JavaScript">
//设置处理机构
//fcpubdata.login_orgid="<%=login_orgid %>";
<%
//设置处理机构
request.getSession().setAttribute(busiId, login_orgid);
//改变系统默认数据源
//if(moduleDBName!=null && !"".equals(moduleDBName)){
//	session.setAttribute("menuDatasource",moduleDBName);
//}else{
//	session.setAttribute("menuDatasource",EgpManager.getAppDBName());
//}
//add by minghua.guo 20-04-11 加actDefId和自定义参数
String queryString = request.getQueryString();
// 非正常菜单页面打开会重复
if(queryString.indexOf("&cc_form_instanceid=undefined")>-1)
{
	queryString = queryString.replace("&cc_form_instanceid=undefined"," ");
}
if(isEformPage){%> 
 r_down.document.location=kcpubdata.openDjUrl+"<%=formDefId%>&cc_form_instanceid=<%=busiId%>"
 + "&workflowId=<%=procDefId%>&oid=<%=actDefId%>&procInsId=<%=procInsId%>&actInsId=<%=actInsId%>&next_acts=<%=next_acts%>"
 + "&DYNAMICPERFORMER=<%=DYNAMICPERFORMER%>&andsplitusers=<%=andsplitusers%>&andsplitname=<%=andsplitname%>"
 + "&mgrName=<%=mgrNameEncode%>&procDefName=<%=procDefName%>&actDefName=<%=actDefName%>&moduleId=<%=moduleId%>&operType=nosend&actDefId=<%=actDefId%>&<%=queryString %>";
  <%}else{//如果不是eform表单
 	String formUrl = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")
 				+"cc_form_instanceid="+busiId+"&workflowId="+procDefId
 				+"&oid="+actDefId+"&procInsId="+procInsId+"&operType=nosend"
 				+"&procDefName="+procDefName+"&actDefId="+actDefId
 				+"&actInsId="+actInsId+"&mgrName="+mgrNameEncode
 				+"&actDefName="+actDefName+"&next_acts="+next_acts+"&DYNAMICPERFORMER="+DYNAMICPERFORMER
 				+"&andsplitusers="+andsplitusers+"&andsplitname="+andsplitname+"&moduleId="+moduleId+"&operType=nosend&actDefId="+actDefId+"&"+queryString;
		formUrl = java.net.URLEncoder.encode(formUrl);
		%>
		r_down.document.location="formFrame.jsp?url=<%=formUrl%>";
 <%}%> 
 <%if(hasFlowButt){%>
 	displayBut();
 <%}%>
 function displayBut()
{
	if(document.workflowform.cmplt_form)document.workflowform.cmplt_form.style.display = "none";
	if(document.workflowform.back_form)document.workflowform.back_form.style.display = "none";
	<%
	if(!isShowUserText && !isShowAndActSelectText && !isShowBackButton){%>
	//eForm.height="570";
	//r_down.height="570";
	<%}%>
}
</script>
</html>


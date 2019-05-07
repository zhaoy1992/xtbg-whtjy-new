<%@ page import="com.chinacreator.security.AccessControl
				,com.frameworkset.util.StringUtil
				,com.chinacreator.workflow.shark.SharkEngine
				,com.chinacreator.eform.formmanage.dbmanager.FormManager
				,com.chinacreator.eform.formmanage.vo.FormCtrl
				,org.enhydra.shark.SharkUtilities
				,org.enhydra.shark.xpdl.elements.Activity
				,com.chinacreator.commonworkflow.WorkflowOpertionWrapper
				,org.enhydra.shark.api.client.wfmodel.WfActivity
				,com.chinacreator.workflow.shark.SharkUtil
				,com.chinacreator.spi.api.EformManager
				,com.chinacreator.commonworkflow.ComponentFactory 
				,com.chinacreator.spi.impl.local.WorkflowManagerImpl
				,com.chinacreator.sysmgrcore.manager.UserManager
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.sysmgrcore.entity.User
				,java.util.List
				,java.util.Map
				,org.enhydra.shark.xpdl.elements.DataFields
				,org.enhydra.shark.xpdl.elements.WorkflowProcess
				,org.enhydra.shark.xpdl.elements.DataField
				,java.util.ArrayList
				,com.lutris.appserver.server.sql.DBConnection
				,org.enhydra.shark.api.SharkTransaction
				,org.apache.log4j.Logger,
				com.chinacreator.commonworkflow.util.FormUtils,
				com.chinacreator.workflow.shark.procconfig.ProcessConfigManager,
				com.chinacreator.epp.util.EgpManager"%>
 
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%@page import="org.enhydra.shark.api.common.SharkConstants"%>
<%!
	private static final Logger logger = Logger
			.getLogger("handle_form");
%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String procInsId = request.getParameter("procInsId");
	String actInsId = request.getParameter("actInsId");
	String busiId = request.getParameter("busiId");
	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	String moduleId = (String) request.getParameter("moduleId");//add by luming。tang

	//获取模块数据源，如果是非平台配置的模块数据源，需要替换此处
	//String moduleDBName = EgpManager.getMenuDBNameByMenuID(accesscontroler.getCurrentSystemID(),moduleId);
	String mgrName = "";
	String mgrNameEncode = "";
	//动态跳转
	String url = "";
	String listFolder = StringUtil.replaceNull(request.getParameter("url"));
	if (listFolder.length() > 0) {
		url = "/" + listFolder + "/";
	} else {
		url = "/common_workflow/";
	}
	url += "work_list.jsp";
	String backUrl = "../" + url;

	String actDefId = "";
	String actDefName = "";
	if (isError == null) {
		isError = "";
	}
	
	SharkTransaction t = null;
	DBConnection dbConn = null;
	SharkEngine shark = SharkEngine.getInstance();	
	String userName = accesscontroler.getUserAccount();
	//活动表单的定义id
	String formDefId = "";
	boolean isShowBackButton = true;
	boolean isShowUserText = false;
	boolean isShowActSelectText = false;
	boolean isShowAndActSelectText = false;
	boolean hasFlowButt = false;
	boolean isEformPage = true;//是否为eform页面 add by luming.tang at 2009-6-23
	
	FormManager fm = new FormManager();
	WorkflowManagerImpl impl = new WorkflowManagerImpl();
	boolean isFirstAct = shark.isSubFlowFirstActivity(actInsId);
	String procDefId = "";
	String procDefName = "";
	
	List extList = new ArrayList();;
	List actList = null;
	String operType = "";
	try {
		// 创建事务
		t = SharkUtil.createTransaction();
		shark.loginWorkflowServer(t, userName, "");
		dbConn = SharkUtil.getDBConnection(t);		
		// 如果为锁定状态
		String lockInfo = impl.isActivityOnUse(dbConn, actInsId);
		if (!"".equals(lockInfo)) {
			String[] lockInfoArr = lockInfo.split(SharkEngine.AT_TOKEN);
			String lockUser = lockInfoArr[0];
			long unLockTime = Long.parseLong(lockInfoArr[1]);
			// 如果达到解锁时间或者登录用户是上次上锁的用户则可以解锁
			if (impl.isAllowUnLock(dbConn, actInsId, userName, unLockTime, lockUser)) {
				operType = "daiban";
				// 更新解锁时间与锁定用户
				impl.changeActivityUnLockInfo(dbConn, actInsId, userName);
			} else {
				operType = "onuse";
				UserManager userManager = null;
				User user = null;
				try {
					userManager = SecurityDatabase.getUserManager();
				} catch (Exception e) {			
					e.printStackTrace();					
				}
				if (userManager != null) {
					user = userManager.getUserByName(lockUser.trim());					
				}
				
				%>
				<script language="javascript">
		        alert("任务正在被【<%=user.getUserRealname()%>】处理，您现在只能查看！");
		        </script>
				<%
			}			
		} else {	
			operType = "daiban";
			// 锁定活动实例
			impl.lockActivity(t,dbConn, actInsId, userName);			
		}		
		
	
		// ----------------------正式开始执行流程相关操作---------------------
		WfActivity act = SharkUtil.currentLoginInfo()
		.getExecutionAdministration().getActivity(t, actInsId);
		procDefId = act.container(t).manager(t).process_definition_id(t);
		mgrName = act.container(t).manager(t).name(t);
		mgrNameEncode = StringUtil.encode(mgrName);
		procDefName = act.container(t).manager(t).process_definition_name(t);		
		//如果是第一个子流程活动，则需要从父流程表单读取数据填充子流程的表单数据
		if (isFirstAct) {
			WorkflowOpertionWrapper wrapper = new WorkflowOpertionWrapper();
			busiId = wrapper.saveSubflowData(t,dbConn,actInsId, busiId);
			//第一个活动不允许回退
			isShowBackButton = false;
		} else {
			Activity actDefObj = SharkUtilities.getActivityDefinition(t, actInsId);
			actDefId = actDefObj.getId();
			actDefName = actDefObj.getName();
		}
		//这里从外围配置中获取活动配置的表单,如果没有则从定义中取 add by luming.tang at 2009-6-23
		ProcessConfigManager procConfigManager = new ProcessConfigManager();
		formDefId = procConfigManager.getActivityFormByInsId(procInsId, actInsId);
		//从外围配置获取别名 add by minghua.guo[2011-03-08]
		String tmp = actDefName;
		actDefName = procConfigManager.getActivityAlias(moduleId,mgrName,actDefId);
		if(actDefName==null || "".equals(actDefName)){
			actDefName = tmp;
		}
		if(formDefId==null || "".equals(formDefId)){
			formDefId = shark.getFormDefIdFromActIns(t, actInsId);
		}
		// 判断表单是否包含工作流控件
		//EformManager eformImpl = ComponentFactory.getEformManagerInstance();
		//hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
		//add by luming.tang at 2009-6-23
		if(isEformPage=(!FormUtils.isURL(formDefId))){
			EformManager eformImpl = ComponentFactory.getEformManagerInstance();
			hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
		}else{//如果表单是jsp页面
			hasFlowButt =  false;
		}
		// 如果用的是表单中的工作流控件，则很多操作都不需要做
		if (!hasFlowButt) {
			
			//add by minghua.guo 2010-07-12====================begin====================
			//读取外围扩展配置 中的动态选择执行人
			ProcessConfigManager processConfigManager = new ProcessConfigManager();
			String isShowUserText1 = processConfigManager.isChooseUserFromActIns(moduleId, mgrName,actInsId);
			if("".equals(isShowUserText1)){
			//add by minghua.guo 2010-07-12====================end =====================
				
				isShowUserText = shark.isChooseUserFromActIns(t,actInsId);
			}else{
				isShowUserText = Boolean.parseBoolean(isShowUserText1);
			}
			//add by minghua.guo 2010-07-12====================begin====================
			//读取外围扩展配置 中的 动态选择下一步活动
			String isShowActSelectText1 = processConfigManager.isShowXorActivityInput(moduleId, mgrName, actInsId);
			if("".equals(isShowActSelectText1)){
			//add by minghua.guo 2010-07-12====================end====================
				
				isShowActSelectText = shark.isShowXorActivityInput(t,actInsId);
			}else{
				isShowActSelectText = Boolean.parseBoolean(isShowActSelectText1);
			}
			if (isShowActSelectText) {
				actList = shark.getNextActivities(t,actInsId);
			} else {

				//add by minghua.guo 2010-07-12====================begin====================
				//读取外围扩展配置 中的 指定后续与活动参与者
				String isShowAndActSelectText1 = processConfigManager.isShowAndUserInput(moduleId, mgrName, actInsId);
				if("".equals(isShowAndActSelectText1)){
				//add by minghua.guo 2010-07-12====================end====================
					
					isShowAndActSelectText = shark.isShowAndUserInput(t,actInsId);
				}else{
					isShowAndActSelectText = Boolean.parseBoolean(isShowAndActSelectText1);
				}
			}
			isShowBackButton = impl.isAllowBack(mgrName, procInsId,	actInsId);
			//if (formDefId != null && !"".equals(formDefId)) {
			// modified by luming.tang at 2009-6-23
			if (formDefId != null && !"".equals(formDefId) && isEformPage) {
				extList = fm.queryFormCtrls(formDefId, procDefId);
			}else{
				extList = new ArrayList();
				WorkflowProcess wf = shark.getProcessDefinition(mgrName);
				DataFields dataFields = wf.getDataFields();
				if(dataFields != null){
					List list = dataFields.toElements();
					int i = 0, size = list.size();
					for(i=0;i<size;i++){
						DataField df = (DataField)list.get(i);
						FormCtrl fc = new FormCtrl();
						fc.setCtrlId(df.getId());
						fc.setCtrName(df.getName());
						fc.setInitValue(df.getInitialValue());
						extList.add(fc);
					}
				}
			}
		}
		// 提交事务
		dbConn.commit();
		SharkUtil.commitTransaction(t);	
	} catch (Exception e) {
		logger.error("exception in handle_form.jsp:", e);
		try {
			// 回滚事务
			SharkUtil.rollbackTransaction(t,dbConn);
		} catch (Exception e1) {
			logger.error("exception in handle_form.jsp rollbackTransaction:", e1);
		}
	} finally {
		//add by minghua.guo 2010-7-30 关闭连接
		//if(dbConn != null){
		//	dbConn.release();
		//}
		// 退出工作流
		shark.logoutWorkflowServer(t);
		try {
			// 释放事务
			SharkUtil.releaseTransaction(t);
		} catch (Exception e) {
			logger.error("exception in handle_form.jsp releaseTransaction:", e);
		}
	}

	//div  iframe高度
	String div1Height = "100%";
	String div2Height = "0";
	String iframeHeight = "800";
	String tableStyle = "thin";
	//如果表单包括工作流控件
	if (hasFlowButt || operType.equals("onuse")) {
		div1Height = "545";
		div2Height = "0";
		iframeHeight = "518";
		tableStyle = "";
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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/eformsys/fceform/js/openDjUrl.js"
	type="text/javascript">
</script>
<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
<script language="JavaScript">
var oid = "<%=actDefId%>";
var djid = "<%=formDefId%>";
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
	var o = document.getElementById('<%=fieldName%>');
	var b = r_down.document.r_down1.document.getElementById('<%=fieldName%>');
	if(o&&b){ document.getElementById('<%=fieldName%>').value = b.value;} 
	
	<%}%>
}
	
	function completeAct()
	{
		if(document.workflowform.DYNAMICPERFORMER && document.workflowform.DYNAMICPERFORMER.value==""){
			alert("请选择执行人。");
			return ;
		}
		if(document.workflowform.ANDSPLITUSERS && document.workflowform.ANDSPLITUSERS.value==""){
			alert("请选择执行人。");
			return ;
		}
		outMsg = "请确认您是否已经保存数据。";
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
			document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=completeAct";
			document.workflowform.submit();
		}	
	}
	function backAct()
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
			document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=backAct";
			document.workflowform.submit();	
		}
	}
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
	function reassign()
	{	
		var ret = showModalDialog("select_org_user.jsp"
	   	,window
	   	,"status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no");
	   	if(ret !=null && ret != "" ){
	   		displayBut();
	   		document.workflowform.reassignToUser.value=ret;
		    document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=reassign";
		 	document.workflowform.submit();
	   	}
		
		
	}
	function backToList()
	{
		history.go(-1);
	}
	function adduser(){
		var actDefId = "";
		var type = "common";
		if(document.workflowform.NEXT_ACT){
			actDefId = document.workflowform.NEXT_ACT.value;
			type = "act";
		}
		if(document.workflowform.DYNAMICPERFORMER){
			users = document.workflowform.DYNAMICPERFORMER.value;
		}
	   	var ret = showModalDialog('select_user_modal.jsp?moduleId=<%=moduleId %>&actInsId=<%=actInsId%>&actDefId='+actDefId+'&type='+type+'&users='+users
	   	,'newWin'
	   	,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
	   	
	   	if(ret != null){
	   		document.all.item("DYNAMICPERFORMER").value = ret.split("|")[0];
	    	document.all.item("DYNAMICPERFORMER_NAME").value = ret.split("|")[1]; 
	   	}
	}
	function addAndUser(){
		var andusers = "";
		var andusers_name = "";
		if (document.workflowform.ANDSPLITUSERS) {
			andusers = document.workflowform.ANDSPLITUSERS.value;
		}
		if (document.workflowform.ANDSPLITUSERS_ACTNAME) {
			andusers_name = document.workflowform.ANDSPLITUSERS_ACTNAME.value;
		}
	   	var ret = showModalDialog("select_andsplit_user.jsp?moduleId=<%=moduleId %>&actInsId=<%=actInsId%>"+"&andusers="+andusers+"&andusers_name="+andusers_name
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

	// add by yaohui.luo	2008-10-16
	// 如果退出页面时活动还是为锁定状态则改变该状态为open.not_running.not_started
	function isActivityOnUseChangeIt(actInsId) {
		if ('<%=operType%>' == 'daiban') {
			sendWorkflowOperationRequest("isactivityonusechangeit",actInsId);
		}		
	}
	
	function sendWorkflowOperationRequest(opType,actInsId) {
		var retX = "";
		var sXml = "";
		retX = SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath 
			+ "/WorkflowOperationServlet"+fcpubdata.dotnetVersion+"?opType="+opType+"&actInsId="
			+actInsId,sXml);
		//return retX;	
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<body class="contentbodymargin" onload="init()">
		<%
		if (hasFlowButt || operType.equals("onuse")) {
		%>
		<div style="display:none;">
			<%
			}
			%>
			<DIV valign=top id="eForm"
				style="width:100%;height:<%=div2Height%>;overflow:auto">
				<form name="workflowform" action="handle_form.jsp" method="post">
					<input type="hidden" name="busiId" value="<%=busiId %>">
					<input type="hidden" name="mgrName" value="<%=mgrName%>">
					<input type="hidden" name="moduleId" value="<%=moduleId%>">
					<input type="hidden" name="cc_form_issave" value="false">
					<input type="hidden" name="mgrNameEncode"
						value="<%=mgrNameEncode%>">
					<input type="hidden" name="actInsId" value="<%=actInsId%>">
					<input type="hidden" name="curUserName" value="<%=userName%>">
					<input type="hidden" name="formDefId" value="<%=formDefId%>">
					<input type="hidden" name="isFirstAct" value="<%=isFirstAct%>">
					<input type="hidden" name="reassignToUser" value="">
					<input type="hidden" name="url" value="<%=url%>">
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
					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=100% class="<%=tableStyle%>">
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
											String actId = nextAct.getId();
											String actName = StringUtil.replaceNull(nextAct.getName());
											if (actName.length() < 1)
											actName = actId;
									%>
									<option value="<%=actId%>">
										<%=actName%>
									</option>
									<%
									}
									%>
								</select>
								<%
								}
								%>
								<%
								if (isShowUserText) {//是否显示选择下一步执行人
								%>
								<input type="hidden" name="DYNAMICPERFORMER" value="">
	    						<input type="text" name="DYNAMICPERFORMER_NAME" size="50" value="" readonly="true">
								<INPUT type="button" class="input" value="选执行人"
									onclick="adduser()">
								<INPUT type="button" class="input" value="清空"
									onclick="clearText()">
								<%
								} else if (isShowAndActSelectText) {//与分支
								%>
								<input type="hidden" name="ANDSPLITUSERS">
								<input type="text" name="ANDSPLITUSERS_ACTNAME" size="80"
									value="" readonly="true">
								<INPUT type="button" class="input" value="选执行人"
									onclick="addAndUser()">
								<INPUT type="button" class="input" value="清空"
									onclick="clearText()">
								<%
								}
								%>
								<input class="input" type="button" name="cmplt_form"
									value="完成活动" onClick="completeAct()">
								<!--<input class="input" type="button" name="temp_sava" value="暂存数据"
									onClick="saveTemp()">
								--><input class="input" type="button" name="reassign_assignment"
									value="任务转交" onClick="reassign()">
								<%
								if (isShowBackButton) {
								%>
								<input class="input" type="button" name="back_form" value="退回"
									onClick="backAct()">
								<%
								}
								%>
								<input class="input" type="button" name="back_to_list"
									value="返回" onClick="backToList()">


							</td>
						</tr>
					</table>
				</form>
			</DIV>
			<%
			if (hasFlowButt) {
			%>
		</div>
		<%
		}
		%>
	<%
	if (hasFlowButt) {
	%>
	<div style="width:100%;height:100%;overflow:hidden">
		<%
		} else {
		%>
		<div style="width:100%;height:100%;overflow:hidden">
			<%
			}
			%>
			<form name="eform" action="" method="post">
				<table width="100%" <%if(hasFlowButt) {%> height="100%" <%}%>
					cellpadding="0" cellspacing="0" 
					border="<%if(hasFlowButt) {%>0<%} else {%>1<%}%>" style="padding:2 "
					bordercolorlight="#3B4D61" bordercolordark="#ffffff">
					<tr>
						<td valign="top">
							<%
							if (hasFlowButt) {
							%>
							<iframe name="r_down" height="100%" width="100%" src=""
								frameborder="0"></iframe>
							<%
							} else {
							%>
							<iframe name="r_down" height=<%=iframeHeight%> px width="100%"
								src="" frameborder="0"></iframe>
							<%
							}
							%>
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
String queryString = request.getQueryString();
//add by minghua.guo 2010-07-13 非正常菜单页面打开会重复
if(queryString.indexOf("&cc_form_instanceid=undefined")>-1)
{
	queryString = queryString.replace("&cc_form_instanceid=undefined"," ");
}
//modify by minghua.guo[2011-04-11] url加actDefId
if(isEformPage){%>
 r_down.document.location=kcpubdata.openDjUrl+"<%=formDefId%>&cc_form_instanceid=<%=busiId%>" 
 	+ "&workflowId=<%=procDefId%>&oid=<%=actDefId%>&procInsId=<%=procInsId%>&operType=<%=operType%>"
 	+ "&actInsId=<%=actInsId%>&mgrName=<%=mgrNameEncode%>&procDefName=<%=procDefName%>&actDefName=<%=actDefName%>&moduleId=<%=moduleId%>&actDefId=<%=actDefId%>&<%=queryString%>";
 <%}else{//如果不是eform表单
 	String formUrl = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")
 				+"cc_form_instanceid="+busiId+"&workflowId="+procDefId
 				+"&oid="+actDefId+"&procInsId="+procInsId+"&operType="+operType
 				+"&procDefName="+procDefName+"&actDefId="+actDefId
 				+"&actInsId="+actInsId+"&mgrName="+mgrNameEncode
 				+"&actDefName="+actDefName+"&moduleId="+moduleId+"&"+queryString;
		formUrl = java.net.URLEncoder.encode(formUrl);
%>
		r_down.document.location="formFrame.jsp?url=<%=formUrl%>";
 <%}%> 
 //如果表单上面存在启动流程按钮，则将通用流程的按钮屏蔽
 //if(r_down.document.frames[1].document.all.)
 <%if(hasFlowButt){%>
 	displayBut();
 <%}%>
 function displayBut()
{
	if(document.workflowform.cmplt_form)document.workflowform.cmplt_form.style.display = "none";
	if(document.workflowform.temp_sava)document.workflowform.temp_sava.style.display = "none";
	if(document.workflowform.back_form)document.workflowform.back_form.style.display = "none";
	if(document.workflowform.back_to_list)document.workflowform.back_to_list.style.display = "none";
	if(document.workflowform.reassign_assignment)document.workflowform.reassign_assignment.style.display = "none";
	<%
	if(!isShowUserText && !isShowAndActSelectText && !isShowBackButton){%>
	//eForm.style.height="100%";
	//r_down.height="570";
	<%}%>
}
function init(){
	document.getElementById("r_down").height = document.body.clientHeight;
}
</script>
</html>

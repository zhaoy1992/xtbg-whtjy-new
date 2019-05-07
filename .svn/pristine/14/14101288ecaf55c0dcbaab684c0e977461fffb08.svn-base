
<%@page import="com.chinacreator.epp.delegate.DelegateDao"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl
				,java.util.List
				,java.util.Map
				,org.enhydra.shark.xpdl.elements.DataFields
				,org.enhydra.shark.xpdl.elements.DataField
				,java.util.ArrayList 
				,com.frameworkset.util.StringUtil
				,com.chinacreator.workflow.shark.SharkEngine
				,org.enhydra.shark.xpdl.elements.Activity
				,org.enhydra.shark.xpdl.elements.WorkflowProcess
				,com.chinacreator.eform.formmanage.dbmanager.FormManager
				,com.chinacreator.eform.formmanage.vo.FormCtrl
				,com.chinacreator.spi.api.EformManager
				,com.chinacreator.commonworkflow.ComponentFactory 
				,com.chinacreator.workflow.shark.SharkUtil
				,com.lutris.appserver.server.sql.DBConnection
				,org.enhydra.shark.api.SharkTransaction
				,org.apache.log4j.Logger,
				com.chinacreator.commonworkflow.util.FormUtils,
				com.chinacreator.workflow.shark.procconfig.ProcessConfigManager"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%!
	private static final Logger logger = Logger
			.getLogger("handle_form");
%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String mgrName = request.getParameter("mgrName");
	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	String menuPath = request.getParameter("menu_path");
	String moduleId = request.getParameter("moduleId");
	if (isError == null) {
		isError = "";
	}
	String pkgId = "";
	String version = "";
	String procDefId = "";
	String procDefName = "";
	String actDefId = "";
	String actDefName = "";
	Activity act = null;
	SharkEngine shark = SharkEngine.getInstance();
	boolean isShowUserText = false;
	boolean isShowActSelectText = false;
	boolean isShowAndActSelectText = false;
	boolean isStartFlowUser = false;
	boolean hasFlowButt = false;
	boolean isEformPage = true;//是否为eform页面 add by luming.tang at 2009-6-23
	List actList = null;
	String mgrNameEncode ="";
	String userName = accesscontroler.getUserAccount();
	//add by minghua.guo 2010-9-3
	String busiId = com.chinacreator.eform.business.InstanceIdManager.getFormInstanceId();
	
	//活动表单的定义id
	String formDefId = "";
	
	FormManager fm = new FormManager();
	List extList = null;
	SharkTransaction t=null;
	DBConnection dbcon=null;
	try {
		moduleId = (moduleId==null)?FormUtils.getModuleIdFromMenuPath(menuPath):moduleId;
		t=SharkUtil.createTransaction();		  
		shark.loginWorkflowServer(t,userName,"");
		dbcon=SharkUtil.getDBConnection(t);
		mgrName = shark.getCurVerMgrNameByMgrName(mgrName);
		
		//add by minghua.guo 2010-07-12====================begin====================
		//读取外围扩展配置 中的动态选择执行人
		ProcessConfigManager processConfigManager = new ProcessConfigManager();
		String isShowUserText1 = processConfigManager.isChooseUserFromFirstAct(moduleId, mgrName);
		if("".equals(isShowUserText1)){
		//add by minghua.guo 2010-07-12====================end =====================
			isShowUserText = shark.isChooseUserFromFirstAct(mgrName);
		}else{
			isShowUserText = Boolean.parseBoolean(isShowUserText1);
		}

		//add by minghua.guo 2010-07-12====================begin====================
		//读取外围扩展配置 中的动态选择执行人
		String isShowActSelectText1 = processConfigManager.isShowXorActivityFromFirstAct(moduleId, mgrName);
		if("".equals(isShowActSelectText1)){
		//add by minghua.guo 2010-07-12====================end =====================
			isShowActSelectText = shark
				.isShowXorActivityFromFirstAct(mgrName);
		}else{
			isShowActSelectText = Boolean.parseBoolean(isShowActSelectText1);
		}
		if (isShowActSelectText) {
			//后续活动列表
			actList = shark.getNextActivitiesFromFirstAct(mgrName);
		} else {
			//add by minghua.guo 2010-07-12====================begin====================
			//读取外围扩展配置 中的动态选择执行人
			String isShowAndActSelectText1 = processConfigManager.isShowAndUserInputFromFirstAct(moduleId, mgrName);
			if("".equals(isShowAndActSelectText1)){
			//add by minghua.guo 2010-07-12====================end =====================
				
				//是否显示与分支执行人选择按钮
				isShowAndActSelectText = shark
					.isShowAndUserInputFromFirstAct(mgrName);
			}else{
				isShowAndActSelectText = Boolean.parseBoolean(isShowAndActSelectText1);
			}
		}
		isStartFlowUser = shark.isStartFlowUser(mgrName, userName, moduleId);
	
		//add by minghua.guo 2010-04-22 任务委派部分权限控制
		DelegateDao dd = DelegateDao.getInstance();
		//获取当前用户的被委托人
		String designee = dd.getAssignDesignee(userName,moduleId);
		//获取当前用户的委托人
		String designator = dd.getAssignDesignator(userName,moduleId);
		
		if(isStartFlowUser){//当前登录用户有启动流程的权限
			if(!"".equals(designee)){//被委托人不为空，当前用户的任务已被委托出去，不再有权限操作
				isStartFlowUser = false;
			}
		}else{//当前登录用户没有启动流程的权限
			if(!"".equals(designator)){//该用户的委托人不为空。判断委托人是否有启动流程的权限
				isStartFlowUser = shark.isStartFlowUser(mgrName, designator, moduleId);
			}
		}
		//end minghua.guo 2010-04-22
		
		pkgId = mgrName.split("#")[0];
		version = mgrName.split("#")[1];
		procDefId = mgrName.split("#")[2];
		act = shark.getFirstActivityByMgrName(mgrName);
		actDefId = act.getId();
		actDefName = act.getName();		
		WorkflowProcess wf = shark.getProcessDefinition(mgrName);
		procDefName = wf.getName();

		//从外围配置获取别名 add by minghua.guo[2011-03-08]
		String tmp = actDefName;
		actDefName = processConfigManager.getActivityAlias(moduleId,mgrName,actDefId);
		if(actDefName==null || "".equals(actDefName)){
			actDefName = tmp;
		}
		
		//这里从外围配置中获取第一个活动配置的表单,如果没有则从定义中取 add by luming.tang at 2009-6-23
		//外围配置读取已封装到SharkEngine.getFormDefIdFromFirstAct方法中 at 2009-11-2
		//ProcessConfigManager procConfigManager = new ProcessConfigManager();
		//formDefId = procConfigManager.getActivityForm(moduleId, mgrName, actDefId);
		//if(formDefId==null || "".equals(formDefId)){
			
			formDefId = shark.getFormDefIdFromFirstAct(mgrName, moduleId);
		//}
		
		
		//EformManager eformImpl = ComponentFactory.getEformManagerInstance();
		//hasFlowButt = eformImpl.hasWorkFlowButton(dbcon,formDefId);
		//add by luming.tang at 2009-6-23
		if(isEformPage=(!FormUtils.isURL(formDefId))){
			EformManager eformImpl = ComponentFactory.getEformManagerInstance();
			hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
		}else{//如果表单是jsp页面
			hasFlowButt =  false;
		}
		//add end
		
		//if (formDefId == null || formDefId.length() == 0){
		//modified by luming.tang at 2009-6-23
		if (formDefId == null || formDefId.length() == 0|| !isEformPage) {
			extList = new ArrayList();
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
		} else {
			extList = fm.queryFormCtrls(formDefId, procDefId);
		}
		mgrNameEncode = StringUtil.encode(mgrName);
		if (hasFlowButt) {
			isShowUserText = isShowActSelectText = isShowAndActSelectText = false;
		}		
		SharkUtil.commitTransaction(t);
	} catch (Exception e) {
		e.printStackTrace();
		logger.error("exception in start_form.jsp:", e);
		try{
			SharkUtil.rollbackTransaction(t,dbcon);
		}catch(Exception ex){
			logger.error("start workflow exception:",e);
		}		
	} finally {
		//add by minghua.guo 2010-7-30 关闭连接
		//if(dbcon != null){
		//	dbcon.release();
		//}
		shark.logoutWorkflowServer(t);// 退出工作流
		try{
			SharkUtil.releaseTransaction(t);
		}catch(Exception e){
			logger.error("releaseTransaction exception:",e);
		}
	}
	

	//div  iframe高度
	String div1Height = "100%";
	String div2Height = "0";
	String iframeHeight = "800";
	String tableStyle = "thin";
	//如果表单包括工作流控件
	if (hasFlowButt) {
		div1Height = "545";
		div2Height = "0";
		iframeHeight = "518";
		tableStyle = "";
	}
%>
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
<script language="JavaScript">
<%if(isError.equals("true") || isError.equals("false")){%>
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

function startForm()
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
		setFormCtrlField();
		displayBut();
		document.getElementById("cc_form_issave").value = "true";
		document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=startWorkflow";
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
		document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=savaTempWhenStart";
		document.workflowform.submit();
	}		
}
function displayBut()
{
	if(document.workflowform.start_form)document.workflowform.start_form.style.display = "none";
	if(document.workflowform.temp_sava)document.workflowform.temp_sava.style.display = "none";
}
function adduser(){
	var actDefId = "";
	var users = "";
	var type = "first";
	if(document.workflowform.NEXT_ACT){
		actDefId = document.workflowform.NEXT_ACT.value;
		type = "act";
	}
	if(document.workflowform.DYNAMICPERFORMER){
		users = document.workflowform.DYNAMICPERFORMER.value;
	}
   	var ret = showModalDialog('select_user_modal.jsp?moduleId=<%=moduleId %>&pkgId=<%=pkgId%>&version=<%=version%>&procDefId=<%=procDefId%>&actDefId='
   	+actDefId+'&type='+type+'&users='+users
   	,'newWin'
   	,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');

   	if(ret != null){
   		document.all.item("DYNAMICPERFORMER").value = ret.split("|")[0];
    	document.all.item("DYNAMICPERFORMER_NAME").value = ret.split("|")[1]; 
   	}
}
function addAndUser() {
	var andusers = "";
	var andusers_name = "";
	if (document.workflowform.ANDSPLITUSERS) {
		andusers = document.workflowform.ANDSPLITUSERS.value;
	}
	if (document.workflowform.ANDSPLITUSERS_ACTNAME) {
		andusers_name = document.workflowform.ANDSPLITUSERS_ACTNAME.value;
	}
   	var ret = showModalDialog("select_andsplit_user.jsp?moduleId=<%=moduleId %>&pkgId=<%=pkgId%>&version=<%=version%>&procDefId=<%=procDefId%>"+"&andusers="+andusers+"&andusers_name="+andusers_name
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
		if (hasFlowButt) {
		%>
		<div style="display:none;">
			<%
			}
			%>
			<DIV valign=top
				style="width:100%;height:<%=div2Height%>;overflow:auto;">
				<form name="workflowform" action="start_form.jsp" method="post">
					<input type="hidden" name="mgrName" value="<%=mgrName%>">
					<input type="hidden" name="moduleId" value="<%=moduleId%>">
					<input type="hidden" name="busiId" value="<%=busiId%>">
					<input type="hidden" name="cc_form_issave" value="false">
					<input type="hidden" name="mgrNameEncode"
						value="<%=mgrNameEncode%>">
					<input type="hidden" name="curUserName" value="<%=userName%>">
					<input type="hidden" name="formDefId" value="<%=formDefId%>">
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
						bordercolor="#EEEEEE" width=100% class="<%=tableStyle%>" readonly>
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
								<input type="text" name="DYNAMICPERFORMER_NAME" size="50"
									value="" readonly="true">
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
								<input class="input" type="button" name="start_form"
									value="启动流程" onClick="startForm()">
								<input class="input" type="button" name="temp_sava" value="暂存数据"
									onClick="saveTemp()">
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
					border="<%if(hasFlowButt) {%>0<%} else {%>1<%}%>"
					style="padding:2 " bordercolorlight="#3B4D61"
					bordercolordark="#ffffff">
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
		<script language="JavaScript">

<%if(!isStartFlowUser){%>
	alert("您没有该任务的操作权限，请查看用户该任务是否被委派，请与管理员联系。");
	document.getElementById("start_form").disabled = true;
	document.getElementById("temp_sava").disabled = true;
<%}else{
	if(isEformPage){
		String queryString = request.getQueryString();
		//add by minghua.guo 2010-07-13 非正常菜单页面打开会重复
		if(queryString.indexOf("&cc_form_instanceid=undefined")>-1)
		{
			queryString = queryString.replace("&cc_form_instanceid=undefined"," ");
		}
		if(queryString.indexOf("moduleId=")==-1){
			queryString = "moduleId="+moduleId+"&"+queryString;
		}%>
		r_down.document.location=kcpubdata.openDjUrl+"<%=formDefId%>&cc_form_instanceid=clear&workflowId=<%=procDefId%>&procDefName=<%=procDefName%>&actDefId=<%=actDefId%>&actDefName=<%=actDefName%>&<%=queryString%>";
	<%}else{
		//修改 minghua.guo 将生成的业务id传到jsp页面供业务数据用 2010-10-21
		//String url = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")+"cc_form_instanceid=clear&workflowId="+procDefId+"&procDefName="+procDefName+"&actDefId="+actDefId+"&actDefName="+actDefName+"&moduleId="+moduleId+"&"+request.getQueryString();
		String url = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")+"cc_form_instanceid="+busiId+"&workflowId="+procDefId+"&procDefName="+procDefName+"&actDefId="+actDefId+"&actDefName="+actDefName+"&moduleId="+moduleId+"&"+request.getQueryString();
		url = java.net.URLEncoder.encode(url);
		%>
		r_down.document.location="formFrame.jsp?url=<%=url%>";
<%	}	
}%>
<%if(hasFlowButt){%>
 	displayBut();
 <%}%>
function displayBut()
{
	if(document.workflowform.start_form)document.workflowform.start_form.style.display = "none";
	if(document.workflowform.temp_sava)document.workflowform.temp_sava.style.display = "none";
	<%
	if(!isShowUserText && !isShowAndActSelectText && !isShowActSelectText){%>
	//eForm.height="570";
	//r_down.height="570";
	<%}%>
}

function init(){
	document.getElementById("r_down").height = document.body.clientHeight;
}
</script>
</body>

<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ page import="com.chinacreator.security.AccessControl
				,java.util.List
				,java.util.ArrayList
				,java.util.Map
				,java.util.HashMap
				,com.frameworkset.util.StringUtil
				,com.chinacreator.workflow.shark.SharkEngine
				,com.chinacreator.workflow.shark.SharkUtil
				,org.enhydra.shark.api.SharkTransaction
				,org.enhydra.shark.xpdl.elements.Activity
				,org.enhydra.shark.api.client.wfmodel.WfActivity
				,org.apache.log4j.Logger
				,org.enhydra.shark.SharkUtilities"%>
<%!private static final Logger logger = Logger.getLogger("select_andsplit_user");%>
<% 
//add by minghua.guo 2010-9-29 加个展开级数的参数
String expandLevel = request.getParameter("expandLevel");
expandLevel = expandLevel == null ? "1" : ("".equals(expandLevel.trim()) ? "1" : expandLevel);
%>
<html>
	<%
		String pkgId = StringUtil.replaceNull(request.getParameter("pkgId"));
		String version = StringUtil.replaceNull(request.getParameter("version"));
		String procDefId = StringUtil.replaceNull(request.getParameter("procDefId"));
		String actInsId = StringUtil.replaceNull(request.getParameter("actInsId"));
		String andUsers = StringUtil.replaceNull(request.getParameter("andusers"));
		String andUsersName = StringUtil.replaceNull(request.getParameter("andusers_name"));
		String moduleId = StringUtil.replaceNull(request.getParameter("moduleId"));

		// add by yaohui.luo	2008-10-22
		String[] andUsersArr = andUsers.split(";");
		String[] andUsersNameArr = andUsersName.split(";");
		Map andUsersMap = new HashMap();
		Map andUsersNameMap = new HashMap();
		
		if (andUsersArr != null) {
			for (int i = 0; i < andUsersArr.length; i++) {
				if (andUsersArr[i] != null && !"".equals(andUsersArr[i])) {
					String[] andUsersArrArr = andUsersArr[i].split(":");
					String users = "";
					String actDefId = andUsersArr[i].split(":")[0];
					String usersName = "";
					if (andUsersArrArr.length > 1) {
						users = andUsersArr[i].split(":")[1];
						usersName = andUsersNameArr[i].split(":")[1];
					}
					
					andUsersMap.put(actDefId, users);
					andUsersNameMap.put(actDefId, usersName);
				}				
			}
		}		

		List list = new ArrayList();
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
		String userId = accesscontroler.getUserAccount();
		SharkTransaction t = null;		
		SharkEngine shark = SharkEngine.getInstance();
		boolean hasNextAct = false;
		
		
		try {
			t = SharkUtil.createTransaction();			
			shark.loginWorkflowServer(t,userId,"");
			if (pkgId.trim().length() < 1) {
				WfActivity wfAct = SharkUtil.currentLoginInfo()
				.getExecutionAdministration().getActivity(t,actInsId);
				pkgId = wfAct.container(t).manager(t).package_id(t);
				procDefId = wfAct.container(t).manager(t).process_definition_id(t);
				version = wfAct.container(t).manager(t).version(t);
			}
			if (actInsId.trim().length() > 0) {
				list = shark.getNextActivities(t,actInsId);
				Activity actDefObj = SharkUtilities.getActivityDefinition(t,actInsId);
				hasNextAct = actDefObj.getExtendedAttributes().containsValue(SharkEngine.EXTENTATTR_NEXT_ACT);
			} else {
				String mgrName = pkgId + "#" + version + "#" + procDefId;
				list = shark.getNextActivitiesFromFirstAct(mgrName);
				hasNextAct = shark.firstActivityHasExtentAttr(mgrName, SharkEngine.EXTENTATTR_NEXT_ACT);
			}
			// 提交事务
			SharkUtil.commitTransaction(t);			
		} catch(Exception e) {
			logger.error("与活动获取流程信息异常。",e);
			try {
				// 回滚事务
				SharkUtil.rollbackTransaction(t);
			} catch (Exception ex) {
				logger.error("exception in rollbackTransaction:", ex);
			}
		} finally {
			shark.logoutWorkflowServer(t);// 退出工作流
			try {
				// 释放事务
				SharkUtil.releaseTransaction(t);
			} catch (Exception e) {
				logger.error("exception in releaseTransaction:", e);
			}
		}
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="expires" content="Mon, 23 Jan 1978 20:52:30 GMT">
		<title></title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	<base target="_self">
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body scroll=no>
		<form action="">
			<div style="width:100%;height:420;overflow:auto">
				<table width="100%" border="1" cellpadding="2" cellspacing="0"
					bordercolorlight="#3B4D61" bordercolordark="#ffffff">
					<%
							for (int i = 0; i < list.size(); i++) {
							Activity nextAct = (Activity) list.get(i);
							String actId = nextAct.getId();
							String actName = StringUtil.replaceNull(nextAct.getName());
							boolean flag = andUsersMap.containsKey(actId);
							if (actName.length() < 1)
								actName = actId;
					%>
					<tr>
						<td align="LEFT">
							<% if (hasNextAct) { %>
								<input type="checkbox" name="<%=actId%>_SELECT" value="<%=actId%>" <%if (flag) {%>checked<%} %>>
							<% } else { %>
								<input type="checkbox" style="display:none" name="<%=actId%>_SELECT" value="<%=actId%>" checked>
							<% } %>							
							<%=actName%>
							<input type="hidden" name="<%=actId%>" value="<%=andUsersMap.get(actId)==null ? "" :andUsersMap.get(actId) %>">
							<input type="text" name="<%=actId%>_NAME" size="50" value="<%=andUsersNameMap.get(actId)==null ? "" :andUsersNameMap.get(actId) %>"
								readonly="true">
							<input type="button" value="请选择用户"
								onclick="adduser('<%=actId%>')">
						</td>
					</tr>
					<%
					}
					%>
				</table>
			</div>
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td align="center">
						<input name="Submit" type="button" class="black_menu" value="确定"
							onClick="return sel()">
						<input name="Close" type="button" class="black_menu" value="关闭窗口"
							onClick="return window.close()">
					</td>
				</tr>
			</table>
		</form>
		<script language="JavaScript">

// modified by yaohui.luo	2008-12-29
function sel() {
	var ret = "";
	var ret1 = "";
	var ret2 = "";
	var actId = "";
	<%
	for (int i = 0; i < list.size(); i++) {
	Activity nextAct = (Activity) list.get(i);
	String actId = nextAct.getId();
	String actName = nextAct.getName();
	%>
	//var actId = document.all.<%=actId%>.value;
	var actId = document.all.<%=actId%>_SELECT.value;	
	var flag = document.all.<%=actId%>_SELECT.checked;
	if (flag && actId != null && actId != "") {
		ret += "<%=actId%>:"+document.all.<%=actId%>.value+";";		
		ret1 += "<%=actName%>";
		if (document.all.<%=actId%>_NAME.value != null && document.all.<%=actId%>_NAME.value != "") {
			ret1 += ":" + document.all.<%=actId%>_NAME.value;
		}
		ret1 += ";";
		ret2 += "<%=actId%>" + ";";
	}
	<%}%>
	window.returnValue = ret+"#"+ret1+"#"+ret2;
	if (window.returnValue==null)
		window.returnValue = "";
	window.close();
}

// modified by yaohui.luo	2008-10-22
function adduser(actDefId) {
	if (document.all.item(actDefId)) {
		users = document.all.item(actDefId).value;
	}

   	var ret = showModalDialog('select_user.jsp?actDefId='+actDefId+'&inputText='+actDefId
   	+'&pkgId=<%=pkgId%>&version=<%=version%>&procDefId=<%=procDefId%>&type=act'+'&users='+users+'&moduleId=<%=moduleId%>&actInsId=<%=actInsId %>&expandLevel=<%=expandLevel %>'
   	,'newWin'
   	,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');

   	if (ret != null) {
   		document.all.item(actDefId).value = ret.split("|")[0];
    	document.all.item(actDefId+"_NAME").value = ret.split("|")[1]; 
   	}
}
</script>
	</body>
</html>

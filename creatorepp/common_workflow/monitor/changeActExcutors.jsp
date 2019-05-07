<%@ page language="java" contentType="text/html; charset=gbk"%>
<%@page import="com.chinacreator.spi.api.WorkflowManager"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="org.enhydra.shark.SharkEngineManager"%>
<%@ page import="org.enhydra.shark.api.common.SharkConstants"%>
<%@ page import="com.chinacreator.commonworkflow.ComponentFactory"%>
<%@ page import="com.chinacreator.sysmgrcoreext.manager.IUserManagerExt"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userName = accesscontroler.getUserAccount();
	boolean isAdmin = accesscontroler.isAdmin();

	String actInsId = request.getParameter("actInsId");
	String toUsers = request.getParameter("toUsers");
	String action = request.getParameter("action");
	String result = "";
	//add by minghua.guo[2011-07-25]�Ƿ�����ְ��� 
	boolean isSys_user_enablemutiorg = SharkEngineManager.getInstance().isSys_user_enablemutiorg();
	String token = SharkConstants.USER_ORG_TOKEN;
	IUserManagerExt userManager =  ComponentFactory.getUserManagerInstance();
	if("submit".equals(action)){
		//add by minghua.guo[2011-07-25]���û�id�滻Ϊ�û���
		String[] tmps = toUsers.split(",");
		String toUsersNew = "";
		int i = 0, len = tmps.length;
		for(; i < len; i++){
			String userId = tmps[i];
			String orgId = "";
			String toUserName = "";
			//��ְ������
			if(isSys_user_enablemutiorg){
				userId = (userId.split("\\" + token))[0];
				try{
					orgId =  tmps[i].split("\\" + token)[1];
				}catch(Exception e){
					orgId = "";
				}
				try{
					toUserName = userManager.getUserById(userId).getUserName();
				}catch(Exception e){
					
				}
			}else{
				try{
					//���ǵ�������������翪����ְ���֮���ֹرգ���ʱ���û��������Ǵ�$����id�ģ�
					//���������ṹid�Ļ�Ҳ����Ӱ��
					userId = (userId.split("\\" + token))[0];
					toUserName = userManager.getUserById(userId).getUserName();
				}catch(Exception e){
					
				}
			}
			if(toUserName != null && !"".equals(toUserName)){
				toUserName = "".equals(orgId) ? toUserName : (toUserName + token + orgId);
				toUsersNew += toUserName + ",";
			}
			
		}
		WorkflowManager impl = (WorkflowManager)org.frameworkset.spi.BaseSPIManager.getProvider("workflowManager");
		result = impl.reassignAssignments(userName,actInsId,toUsersNew,true);
	}
	if(isAdmin){
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="expires" content="Mon, 23 Jan 1978 20:52:30 GMT">
		<title>����ѡ���</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body
		scroll=no>
		<form action="changeActExcutors.jsp" name="caeForm" method="post">
			<input type="hidden" name="actInsId" value="<%=actInsId %>"/>
			<input type="hidden" name="toUsers" value=""/>
			<input type="hidden" name="action" value=""/>
			<div style="width: 100%; height: 100%; overflow: auto">
				<table width="100%" height="600" border="1" cellpadding="2" cellspacing="0"
					bordercolorlight="#3B4D61" bordercolordark="#ffffff">
					<tr>
						<td>
							<%-- minghua.guo[2011-7-25]�滻ΪopentTree��ext��,������ò��������޸ģ����ܻ���Ӱ�� --%>
							<%--<tree:tree tree="change_excutor_select_user_modal_tree"
								node="change_excutor_select_user_modal_tree.node"
								imageFolder="/sysmanager/images/tree_images/" collapse="true"
								includeRootNode="true" mode="static-dynamic">

								<tree:checkbox name="orguser" recursive="true"
									uprecursive="true" />

								<tree:treedata
									treetype="com.chinacreator.commonworkflow.tree.ChangeActExcutorTree"
									scope="request" rootid="0" rootName="ƽ̨�����û���" expandLevel="1"
									showRootHref="false" needObserver="false" />
							</tree:tree>--%>
						<iframe name="orgUserTreeFrame" height="100%" width="100%"	src="<%=request.getContextPath() %>/eformsys/systemManager/tree/orgUserTree.jsp?checkModel=cascade&rootId=0&rootName=��֯������&expandLevel=1" frameborder="0"></iframe>
						</td>
					</tr>
					<tr height="10%">
						<td align="center">
							<input name="Submit" type="button" class="input" value="ȷ��"
								onClick="sel()">
							<input name="Close" type="button" class="input" value="�رմ���"
								onClick="return window.close()">
						</td>
					</tr>
				</table>
			</div>
		</form>
		<script language="JavaScript">
		//modify by minghua.guo[2011-07-25] �滻Ϊext����ĸ���
		function sel(){

	        var orgusers =orgUserTreeFrame.tree.getChecked();
	      	var isSys_user_enablemutiorg = "<%=isSys_user_enablemutiorg %>";
	      	var token = "<%=token %>";
			var userids ="";
			//var userRealNames = "";			
			for(var i=0;i<orgusers.length;i++){					
					if(orgusers[i].isLeaf())
					{   
						var orgId = orgusers[i].parentNode.id;	
						var userId = orgusers[i].id.split("-")[1];
						if(isSys_user_enablemutiorg && orgId != "0" && orgId != ""){
							orgId = orgId.split("-")[1];
							userId += token + orgId;
						}
						userids = userids+ userId + ",";
						//userRealNames = userRealNames + orgusers[i].text + ",";													
					}

			}		
			//return;
		    if(orgusers == null || orgusers=="" || userids==""){ 
		    	alert("��ѡ���û�!");
			}else{
				document.getElementById("Submit").disabled=true;
				document.getElementById("toUsers").value=userids;
				document.getElementById("action").value="submit";
				document.getElementById("caeForm").submit();
			}

			
			//var ret = "";
			//var userRealname = "";
			//var o = document.all.item("orguser");
		    //var i = 0;
		    //for (; o && o.length && i<o.length; i++)
		   	//{
			//	var checkValue = o[i].value.split(",");
			//	if(o[i].checked && checkValue.length==2){
			//		ret += checkValue[0] + ",";
			//		userRealname += checkValue[1] + ",";
			//	}
			//}
			//if(i > 0){
			//	ret = ret.substring(0,ret.length-1);
			//	userRealname = userRealname.substring(0,userRealname.length-1);
			//}
			//if(o && !o.length)
		    //{
			//    if(o.checked)
			//    ret = o.value.split(",")[0];
			//    userRealname = o.value.split(",")[1];
		    //}
		    //if(ret == null || ret==""){ 
		    // 	alert("��ѡ���û�!");
			//}else{
			//	document.getElementById("Submit").disabled=true;
			//	document.getElementById("toUsers").value=ret;
			//	document.getElementById("action").value="submit";
			//	document.getElementById("caeForm").submit();
			//}	
		}
		var result = "<%=result %>";
		if(result == "true"){
			document.getElementById("Submit").disabled=false;
			alert("�����ɹ�!");
			parent.close();
		}
		if(result == "false"){
			alert("����ʧ�ܣ���鿴��̨��־!");
			window.close();
		}
		</script>
	</body>
	</base>
</html>
<%}else{ %>
	<script language="JavaScript">
		alert("ֻ�г�������Ա����Ȩ�޲�����");
		window.close();
	</script>
<%} %>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserAttribute("userAccount") + ":"
			+ control.getUserAttribute("userName") + "["
			+ control.getUserAttribute("userID") + "]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();

	//应用ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//是否修改状态	 "true"	可修改
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//取消状态，是否取消时注销应用 "true" 可注销
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
%>
<head>
	<title>应用管理员设置</title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<base target="_self">

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->

	<!-- 提交后页面变灰 -->
	<script language="javascript" type="text/javascript" src="../pageGrey.js" />



</head>
<html>

	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript"> 
	//应用ID
	var app_id = "<%=app_id%>";
	//是否修改状态		
	var isEdit = "<%=isEdit%>";	
	//取消状态，是否取消时删除应用
	var isCancel = "<%=isCancel%>";		
		
		//按下关闭按钮时刷新父窗口
		function appmanagerset1(isSave)
		{
		    var orgusers = document.getElementsByName("orguser");
			var orguser = "";
			for(var i=0;i<orgusers.length;i++)
			{
				if(orgusers[i].checked)
				{
					orguser = orguser + ";" + orgusers[i].value;
				}
			}
			//提交后页面变灰
			popSignFlow(1);			
			applyChange.saveappmanager(app_id,orguser,isSave,"<%=userInfo%>","<%=remoteAddr%>",appmanagerset2);
		}
		
		function appmanagerset2()
		{
			if(isEdit=="true"){
				alert("修改成功");
				//页面变灰恢复正常
				cancelSign();
				fullAppManagerJava();
			}else{
				document.location.assign("addapplytab5.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);	
			}
		}
		
		//弹出消息对话框，通过应用ID调用后台JAVA类注销应用
		function logoutApply()
		{	
			if(confirm("确认取消吗?\r取消同时将注销该应用!")){
				var app_id_arr = new Array;
				app_id_arr[0] = app_id;
				applyChange.updateApplyStatus(app_id_arr,0,"<%=userInfo%>","<%=remoteAddr%>",winClose);			
			}
		}
		
		//上一步
		function backApply()
		{
			document.location.assign("addapplytab3.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
		}
		
		//关闭模态窗口并刷新父页面
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}
		
		//判断取消状态是否需要注销应用
		function cancel(){
			if(isCancel=="true"){
				logoutApply();
			}else{
				winClose();
			}				
		}
		
		//按下关闭按钮时刷新父窗口
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       if(isCancel=="true"&&app_id!=""){
					logoutApply();
				}else{
					winClose();
				}
		    }
		}
		
		
		
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form action="" method="post">
				<input type="hidden" name="app_id" value="<%=app_id%>">
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">应用管理员设置-应用机构用户树</FONT>
						</LEGEND>
						<table width="85%" height="35" border="0" align="left" cellpadding="0" cellspacing="1" class="table">
							<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="app_manager_tree" node="app_manager_tree.node" imageFolder="../../images/tree_images/" collapse="true" includeRootNode="true" dynamic="false" mode="static">

										<tree:param name="app_id" value="<%=app_id%>"></tree:param>
										<tree:checkbox name="orguser" recursive="true" uprecursive="true" />

										<tree:treedata treetype="com.chinacreator.epp.applymanager.menu.AppManagerSelectTree" scope="request" rootid="0" rootName="应用机构用户树" expandLevel="1" showRootHref="false" needObserver="false" />
									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div align="left">
										<%
										if (isEdit.equals("true")) {
										%>
										<input name="Submit" type="button" class="input" value="修改" onClick="appmanagerset1('edit')">
										<%
										} else {
										%>
										<input name="back" type="button" class="input" value="上一步" onclick="backApply();">
										<input name="Submit" type="button" class="input" value="下一步" onClick="appmanagerset1('save')">
										<%
										}
										%>
										<input name="rsset" type="reset" class="input" value="重置">
										<input name="button" type="button" class="input" value="取消" onClick="cancel()">
									</div>
								</td>
							</tr>
						</table>
					<br>
					<br>
					<br>
					<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td id="showAppManager">
							</td>
						</tr>
					</table>
					</div>					
				</pg:beaninfo>
			</form>
		</div>
	</body>
</html>
<script type="text/javascript">
<!--
		if(isEdit=="true"){
			fullAppManagerJava();			
		}
		
		function fullAppManagerJava(){
			applyChange.getApplyManagerStr("<%=app_id%>",fullAppManager);
		}
		
		function fullAppManager(obj){		
			document.getElementById("showAppManager").innerHTML = obj;
		}
//-->
</script>


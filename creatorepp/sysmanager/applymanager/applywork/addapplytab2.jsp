<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo =  control.getUserAttribute("userAccount")+":"+control.getUserAttribute("userName")+"["+control.getUserAttribute("userID")+"]  ";
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

	//菜单文件夹路径
	String appMenuFilePath = ConfigManager.getInstance()
			.getConfigValue("appMenuFilePath");
%>
<head>
	<title>添加应用</title>
	<style type="text/css">
<!--
.style1 {
	color: #CC0000
}
-->
</style>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
	<base target="_self">

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->

	<!-- 提交后页面变灰 -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />


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
	
	function trim(string){
	  var temp="";
	  string = ''+string;
	  splitstring = string.split(" ");
	  for(i=0;i<splitstring.length;i++){
	    temp += splitstring[i];
	  } 
	  return temp;
	}	
	
	//应用注册第二个页面：保存菜单文件
	//保存的第一步：构建和初始化应用的菜单文件
	function nextApply1(isSave) {			
		var menuids = document.getElementsByName("menuid");
		var menuid = "";
		for(var i=0;i<menuids.length;i++)
		{
			if(menuids[i].checked)
			{
				menuid = menuid + ";" + menuids[i].value;
			}
		}	
		
		//提交后页面变灰
		popSignFlow(1);
		applyChange.buildAppMenuItem(app_id,menuid,isSave,"<%=userInfo%>","<%=remoteAddr%>",nextApply2);		
	}
	
	//应用注册第二个页面：保存菜单文件
	//保存的第二步：跳转到第三个页面
	function nextApply2()
	{
		if(isEdit=="true"){
			alert("修改成功");
			//页面变灰恢复正常
			cancelSign();
		}else{
			document.location.assign("addapplytab3.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
		}
	}  
	
	function backApply() {			
		document.location.assign("addapplytab1.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit+"&&isBack=true");
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
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form name="addapplytab2" action="" method="post">

				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">菜单生成</FONT>
					</LEGEND>
					<br />
					<table class="table" width="100%" border="0" cellpadding="0"
						cellspacing="1">
						<!-- 
						<tr>
							<td width="26%" height="26" class="detailtitle" align=left>
								<strong>菜单文件：</strong>
								<%=appMenuFilePath + "module-" + app_id + ".xml"%>
							</td>
						</tr>	
						 -->
						<tr>
							<td class="detailtitle" align=left>
								<strong>选择从平台继承的菜单：</strong>
							</td>
						</tr>
						<tr>
							<td class="detailtitle" align=left>
								<tree:tree tree="apply_menu_tree" node="apply_menu_tree.node"
									imageFolder="../../images/tree_images/" collapse="true"
									includeRootNode="true" target="operList" dynamic="false"
									mode="static">
									<tree:param name="menuid" />
									<tree:checkbox recursive="true" name="menuid"
										partuprecursive="true" />
									<tree:treedata
										treetype="com.chinacreator.epp.applymanager.menu.EppMenuTree"
										scope="request" rootid="0" rootName="平台菜单树" expandLevel="1"
										showRootHref="false" needObserver="false" refreshNode="true" />
								</tree:tree>
							</td>
						</tr>
					</table>
				</fieldset>
				<br />
				<br />
				<div align="center">
					<table width="35%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<%
									if (isEdit.equals("true")) {
									%>
									<input name="Submit" type="button" class="input" value="修改"
										onclick="nextApply1('edit')">
									<%
									} else {
									%>
									<input name="Submit" type="button" class="input" value="上一步"
										onClick="backApply()">
									<input name="Submit" type="button" class="input" value="下一步"
										onClick="nextApply1('save')">
									<%
									}
									%>
									<input name="rsset" type="reset" class="input" value="重置">
									<input name="button" type="button" class="input" value="取消"
										onClick="cancel()">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>

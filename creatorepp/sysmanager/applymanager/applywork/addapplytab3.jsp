<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//�û���Ϣ���û���ʵ���ƣ��û��ʺ�[�û�ID]��
	String userInfo =  control.getUserAttribute("userAccount")+":"+control.getUserAttribute("userName")+"["+control.getUserAttribute("userID")+"]  ";
	//������ip��ַ
	String remoteAddr = request.getRemoteAddr();

	//Ӧ��ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//�Ƿ��޸�״̬	 "true"	���޸�
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//ȡ��״̬���Ƿ�ȡ��ʱע��Ӧ�� "true" ��ע��
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
			
	boolean isCMS = "cms".equals(app_id.trim().toLowerCase())?false:true;
%>
<head>
	<title>���Ӧ��</title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
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
	<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->

	<!-- �ύ��ҳ���� -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />
</head>
<html>
	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript"> 
	//Ӧ��ID
	var app_id = "<%=app_id%>";
	//�Ƿ��޸�״̬		
	var isEdit = "<%=isEdit%>";	
	//ȡ��״̬���Ƿ�ȡ��ʱɾ��Ӧ��
	var isCancel = "<%=isCancel%>";


	function trim(string)
	{
	  var temp="";
	  string = ''+string;
	  splitstring = string.split(" ");
	  for(i=0;i<splitstring.length;i++)
	  {
	    temp += splitstring[i];
	  } 
	  return temp;
	}	
	
	
	function saveApply1(isSave) 
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
		//�ύ��ҳ����
		popSignFlow(1);
		
		applyChange.buildAppOrgUser(app_id,orguser,isSave,"<%=userInfo%>","<%=remoteAddr%>",saveApply2);
	}
	
	function saveApply2() 
	{
		if(isEdit=="true"){
			alert("�޸ĳɹ�");
			//ҳ���һָ�����
			cancelSign();
		}else{
			if("false"=="<%=isCMS%>"){
				alert("Ӧ��ע��ɹ���");
				winClose();
			}else{
				document.location.assign("addapplytab4.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
			}
		}	
	}
	
	function backApply()
	{
		document.location.assign("addapplytab2.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
	}
					
	//������Ϣ�Ի���ͨ��Ӧ��ID���ú�̨JAVA��ע��Ӧ��
		function logoutApply()
		{	
			if(confirm("ȷ��ȡ����?\rȡ��ͬʱ��ע����Ӧ��!")){
				var app_id_arr = new Array;
				app_id_arr[0] = app_id;
				applyChange.updateApplyStatus(app_id_arr,0,"<%=userInfo%>","<%=remoteAddr%>",winClose);			
			}
		}
		
		//�ر�ģ̬���ڲ�ˢ�¸�ҳ��
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}
		
		//�ж�ȡ��״̬�Ƿ���Ҫע��Ӧ��
		function cancel(){
			if(isCancel=="true"){
				logoutApply();
			}else{
				winClose();
			}				
		}
		
		//���¹رհ�ťʱˢ�¸�����
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
		
		function opentab4(){
			openWin("addapplytab4.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit,screen.availWidth-320,screen.availHeight-200);
		}
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form action="" method="post">
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">�����û�</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"
							cellpadding="0" cellspacing="1" class="table">							
							<tr>
								<td width="26%" height="26" class="detailtitle">
									<strong>ѡ���ƽ̨�̳еĻ������û���</strong>
								</td>
							</tr>
							<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="app_org_user_tree"
										node="app_org_user_tree.node"
										imageFolder="../../images/tree_images/" collapse="true"
										includeRootNode="true" dynamic="false" mode="static">

										<tree:param name="app_id" value="<%=app_id%>"></tree:param>
										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />

										<tree:treedata
											treetype="com.chinacreator.epp.applymanager.menu.EppOrgUserTree"
											scope="request" rootid="0" rootName="ƽ̨�����û���" expandLevel="1"
											showRootHref="false" needObserver="false" />
									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<%	
									if(isEdit.equals("true")){
										if(isCMS){
								%>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="����Ա����..."
											onClick="opentab4()">
									</div>
								</td>
								<%} %>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="�޸�"
											onClick="saveApply1('edit')">
									</div>
								</td>
								<%}else{ %>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="��һ��"
											onClick="backApply()">
									</div>
								</td>
								<%if(isCMS){ %>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="��һ��"
											onClick="saveApply1('save')">
									</div>
								</td>
								<%}else{ %>
								<td>
									<div align="left">
										<input name="Submit" type="button" class="input" value="����"
											onClick="saveApply1('save')">
									</div>
								</td>
								<%}} %>
								<td>								
									<div align="left">
										<input name="rsset" type="reset" class="input" value="����">
									</div>
								</td>
								<td>
									<div align="left">
										<input name="button" type="button" class="input" value="ȡ��"
											onClick="cancel()">
									</div>
								</td>
							</tr>
						</table>
					</div>
				</pg:beaninfo>
			</form>
		</div>
	</body>
</html>

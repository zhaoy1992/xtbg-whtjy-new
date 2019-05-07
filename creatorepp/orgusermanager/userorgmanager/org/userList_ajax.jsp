<%
/*
 * <p>Title: �û�����������û��б�ҳ��</p>
 * <p>Description: �û�����������û��б�ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
 %>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%@ page
	import="com.chinacreator.security.AccessControl,
	com.chinacreator.menu.OrgUserTree,
	com.chinacreator.sysmgrcore.entity.Job,
	com.chinacreator.sysmgrcore.entity.User,
	com.chinacreator.sysmgrcore.manager.JobManager,
	com.chinacreator.sysmgrcore.manager.SecurityDatabase,
	com.chinacreator.sysmgrcore.manager.UserManager,java.util.*,
	com.frameworkset.common.poolman.DBUtil"%>
	
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String orgId = request.getParameter("orgId");
	String oid = request.getParameter("oid");
	String classType = request.getParameter("classType");
	UserManager userManager = SecurityDatabase.getUserManager();
	//�����������е��û�
	List thisUser = new ArrayList();
	thisUser = userManager.getOrgUserList(oid);
	request.setAttribute("thisUser", thisUser);
	//���������µ��û�
	if(orgId != null && !orgId.equals("")){
		List allUser = new ArrayList();
		allUser = userManager.getOrgUserList(orgId);
		request.setAttribute("allUser", allUser);
	}
	//��ɢ�û�
	if("lisan".equals(request.getParameter("classType"))){
		List allUser = userManager.getDicList();
		request.setAttribute("allUser", allUser);
	}
%>
<html>
<head>
	<title>��������</title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
	<script language="javascript">
	function addone(name,value,n){
		for(var i=n;i>=0;i--){
			if(value==document.all("userIds").options[i].value){
				return;
			}
		}
		var op=new Option(name,value);
	    document.all("userIds").add(op);
	}
	
	function addUser(){
		//���뵥���û�
		var userIds = "";
		var n = document.all("userIds").options.length-1;
		
		for(var i=0;i<document.all("allist").options.length;i++){
			op = document.all("allist").options[i];
			
			if(op.selected){
				userIds = op.value;
				//addone(op.text,op.value,n);
			}
		}
		
		if(document.all("allist").options.length < 1){
			alert("û���û���ѡ");
			return;
		}
		var orgId = "<%=oid%>";
		var flag = "1";
		var classType = "<%=classType%>";
		document.OrgUserForm.target="saveUser";
		document.all.divProcessing.style.display = "block";
		document.all.button1.disabled = true;
		document.all.button2.disabled = true;
		document.all.exit.disabled = true;
		document.OrgUserForm.action="../user/saveOrgUser.jsp?userId=" + userIds + "&orgId=" + orgId + "&flag=" + flag + "&classType=" + classType +"&CurorgId=<%=orgId%>";
		document.OrgUserForm.submit();
	}
	
	function addall(){
		//���������û�
		var userIds = "";
		var flag1 = false;
		
		if(document.all("allist").options.length < 1){
			alert("û���û���ѡ");
			return;
		}
		
		var n = document.all("userIds").options.length-1;
		var p = document.all("allist").options.length-1
		for(var i = 0; i < document.all("allist").options.length; i++){
			var op = document.all("allist").options[i];
			if(flag1){
				userIds += "," + op.value;
			}else{
				userIds += op.value;
				flag1 = true;
			}
			//addone(op.text,op.value,n);
		}
		var orgId = "<%=oid%>";
		var flag = "1";
		var classType = "<%=classType%>";
		document.all.divProcessing.style.display = "block";
		document.all.button1.disabled = true;
		document.all.button2.disabled = true;
		document.all.exit.disabled = true;
		document.OrgUserForm.target="saveUser";
		document.OrgUserForm.action="../user/saveOrgUser.jsp?userId=" + userIds + "&orgId=" + orgId + "&flag=" + flag + "&classType=" + classType +"&CurorgId=<%=orgId%>";
		document.OrgUserForm.submit();
	}
	
	function deleteall(){
		alert("ɾ���û�--");
	}
	
	function deleteuser(){
		alert("ɾ���û�");
	}
	
	function okadd(){
		alert("�����û��ɹ���");
		window.returnValue = "ok";
		parent.window.close();
	}
	</script>		
</head>
		
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onunload="window.returnValue = 'ok'">
	<div id="contentborder" align="center">
		<center>
			<form name="OrgUserForm" action="" method="post">
				<table width="80%" border="0" cellpadding="0" cellspacing="1" class="table">
				<tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					  </tr>
					<tr class="tr">
						<td class="td" width="40%" align="center">
							�����¿�ѡ�û�
						</td>
						<td width="20%" class="td" align="center">
							&nbsp;
						</td>
						<td width="40%" align="center" class="td">
							�Ѵ��ڸû����µ��û�
						</td>
					</tr>
					<tr class="tabletop">
					    <td width="40%" align="center">&nbsp;</td>
					    <td width="20%" align="center">&nbsp;</td>
					    <td width="40%" align="center">&nbsp;</td>
					  </tr>
					<tr class="tr">
						<td class="td" align="center" >
							<select class="select" name="allist"  style="width:90%" onDBLclick="addUser()" size="18">
								<pg:list requestKey="allUser">
									<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname"/>(<pg:cell colName="userName"/>)
										</option>
									 </pg:list>
								</select>
							</td>

							<td align="center" class="td">
								<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="tr">
										<td align="center" class="td">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addUser()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr class="tr">
										<td align="center" class="td">
											&nbsp;
										</td>
									</tr>
									<!--
								<tr class="tr">
									<td align="center" class="td">
										<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
									</td>
								</tr>
								<tr class="tr">
									<td align="center" class="td">
										&nbsp;
									</td>
								</tr>
								<tr class="tr">
									<td align="center" class="td">
										<input name="button4" type="button" class="input" value="&lt;" onclick="deleteuser()">
	 								</td>
								</tr>
								<tr class="tr">
									<td align="center" class="td">
										&nbsp;
									</td>
								</tr>
								-->
							</table>
						</td>
						<td class="td" align="center" >
							<select class="select" name="userIds"  style="width:90%" size="18">
								<pg:list requestKey="thisUser">
									<option value="<pg:cell colName="userId"/>">
											<pg:cell colName="userRealname"/>(<pg:cell colName="userName"/>)
										</option>
									 </pg:list>
								</select>

							</td>

						</tr>
						<tr class="tabletop">
						    <td  align="center">&nbsp;</td>
						  </tr>
						<tr class="tr">
							<td colspan="3" class="td" align="center">
								

							</td>
						</tr>
						
					    <tr class="tr">
						    <td colspan="3" class="td" align="center">
							    <input name="exit" type="button" class="input" value="����" onclick="parent.window.close();">
    						</td>
					    </tr>
					</table>
				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:190px;top:380px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="saveUser" width="" height=""></iframe>
</html>
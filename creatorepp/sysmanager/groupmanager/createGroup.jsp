<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-template" prefix="template"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested"%>
<%
	String parentId=(String)request.getParameter("parentId");
	if(parentId == "" ||parentId == null || parentId.length() <1){
		parentId = "0";
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�û��������Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/tab.winclassic.css">

		<script language="javascript">

			function updateloadPage()
			{
				loadPage();
				updateAfter();
				//alert("update ok");
			}
			
			function setDisable(v){
				v.disabled = false;
				if  ( document.forms[0].groupId.value != "" )
				{
					v.disabled = true;
				}
			}
			
			function loadPage() {
				
				var form = document.forms[0];
				var act = form.action.value; 
				if (act == 2) {
					
					form.groupId.value = "";
					form.groupName.value = "";
					form.groupDesc.value = "";					
				}
				
				if (act == 1 || act == 2) {
				//	getNavigatorContent().location.href="/sysmanager/groupmanager/groupTree.jsp";
				}

				form.action.value = 0;
				
			}
			
			function createGroup() {
				var form = document.forms[0];
				form.parentId.value = form.groupId.value;
				//document.forms[0].action="groupInfo.jsp";
				
				//form.groupName.disabled="false";				
				form.groupId.value = "";
				form.groupName.value = "";
				form.createflag.value="1";
				form.groupDesc.value = "";
				form.action.value = "0";
				form.b1.disabled="disabled";				
				document.forms[0].submit();
				
			}
			
			function saveGroup() {			
				var form = document.forms[0];
				if(form.groupName.value == "" || form.groupName.value.length<1 || form.groupName.value.replace(/\s/g,"")=="" || form.groupDesc.value == "" || form.groupDesc.value.length<1 || form.groupName.value.replace(/\s/g,"")=="")
				{
					alert("��*Ϊ������");
					return false;
				}
				if(form.parentId.value == "null" || form.parentId.value.length<1){
					alert("���������ѡ����");
					return false;
				}
				var gn = form.groupName.value;
				var gd = form.groupDesc.value;
				if(gn.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("�����Ʋ�����\\/|:*?<>\"'!�������ַ�");
					return false;
				}	
				if(gd.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("������������\\/|:*?<>\"'!�������ַ�");
					return false;
				}
				if(gn.length>100)
				{
					alert("�����ƹ���,������100�ַ�����!");
					return false;
				}
				if(gd.length>100)
				{
					alert("����������,������100�ַ�����!");
					return false;
				}
				form.submit();
			}
			
			
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
		<html:form action="groupInfo.do">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
				<tr>
					<td width="16%" height="25" class="detailtitle">
						<P align="center">
							<STRONG>�û�������*</STRONG>
						</P>
					</td>
					<td width="907" height="25">
						
						<html:text property="groupName"  style="width:30%" />
					</td>
				</tr>
				<tr>
					<td height="25" class="detailtitle">
						<P align="center">
							<STRONG>�û���˵��*</STRONG>
						</P>
					</td>
					<td height="25">
						<html:textarea property="groupDesc" style="width:30%" />
					</td>
				</tr>
		</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td></td>
					<td>
						<table width="60%" border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td align="right">									
									<html:button property="b2" styleClass="input" value="����" onclick="saveGroup();" />
									<input type="reset" class="input" value="����" >									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="parentId" value="<%=parentId%>">
			<input type="hidden" name="action" value="1">
		</html:form>
		<p></p>
		</div>
	</body>
</html>

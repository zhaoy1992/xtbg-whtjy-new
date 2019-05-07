<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(pageContext);
	String reFlush = "true";
	session.setAttribute("roleTabId","1");
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	String isUserExist =(String)request.getAttribute("isUserExist");

	String setDisbaled = "";
	if ( request.getAttribute("userNameDisable") != null ){
		setDisbaled = "disabled = true";
	}		
	
	RoleManagerForm user = (RoleManagerForm)request.getAttribute("currUser");
	
	if(user == null)
		user = new RoleManagerForm();
		
	String isNew = (String)request.getAttribute("isNew");
	if(isNew == null ){
		isNew = "1";
	}
	
%>

<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../../sysmanager/scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../../sysmanager/scripts/validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo</title>
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
	    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
        </style>
</head>

<script language="JavaScript">
var isNew ="<%=isNew%>";


if(isNew == "1"){
	getNavigatorContent().location.href ="../sitemember/drug_content.jsp?anchor=0&expand=0&request_scope=session"; 
}

var reFlush = "<%=reFlush%>";
var userErr = 0;
	
var isUserExist = "<%=isUserExist%>";
if ( isUserExist == "true"){
	alert("��Ա�����Ѵ��ڣ������������Ա����!");
}

function trim(string){
  var temp="";
  string = ''+string;
  splitstring = string.split(" ");
  for(i=0;i<splitstring.length;i++){
    temp += splitstring[i];
  } 
  return temp;
 }
function storeRole()
{
	var RoleManagerForm = document.all.RoleManagerForm; 
	if(RoleManagerForm.roleName.value.search(/[*\|:<>\?"]/g)!=-1){
		alert("�û���ֻ�ܰ������֡��ַ����»���!");
		RoleManagerForm.roleName.focus();
		return false;
	}
	document.RoleManagerForm.roleName.disabled = false;
	
	if (validateForm(RoleManagerForm) )
	{
		var roleName= document.forms[0].roleName.value;
		if (trim(roleName).length == 0 ){
    	alert("�������ɫ����"); 
    	return false;
    } 
    	
   		
		document.RoleManagerForm.action="../memberManager/roleManager.do?method=storeRole";
		document.RoleManagerForm.submit();
	}
}
//�޸�
function updateRole()
{
	if(RoleManagerForm.roleName.value.search(/[*\|:<>\?"]/g)!=-1){
		alert("�û���ֻ�ܰ������֡��ַ����»���!");
		RoleManagerForm.roleName.focus();
		return false;
	}	
	document.RoleManagerForm.roleName.disabled = false;
	
	if (validateForm(RoleManagerForm) )
	{
		var roleName= document.forms[0].roleName.value;
		if (trim(roleName).length == 0 ){
    	alert("�������ɫ����"); 
    	return false;
    } 
    	
   		
		document.RoleManagerForm.action="../memberManager/roleManager.do?method=updateRole&flag=2";
		document.RoleManagerForm.submit();
	}
}
//ɾ��
function deleteRole()
{
	var roleId= document.forms[0].roleId.value;
    if(roleId=="1"){
    	alert("�˽�ɫ��ϵͳ����Ա������ɾ����");
    	return;
    }
    if (confirm("��ȷ��ɾ����ɫ�𣿣�ɾ�����ǲ��ָܻ��ģ�")){
						
		document.RoleManagerForm.action="../memberManager/roleManager.do?method=deleteRoleByRoleId&flag=2&roleId="+roleId;
		document.RoleManagerForm.submit();
		return true;

	}
}


//����
function back()
{
	if(flag =="1")
	{
		document.location.href="../sitemember/newRole.jsp";
	}
	else
	{
		document.location.href="../sitemember/drugRole.jsp";
	}
}
//����
function resetuser()
{
	var roleId= document.forms[0].roleId.value;
	document.location.href="../memberManager/roleManager.do?method=getRole&flag=2&roleId="+roleId;
}

function setDisable(v){
	v.disabled = false;
	if  ( document.RoleManagerForm.roleId.value == "1" )
	{
		v.disabled = true;
	}
}


//Ĭ�Ϲ��ͣ���ڽ�ɫ���������
	function document.onreadystatechange(){
		if (document.readyState!="complete") return;
		document.all.RoleManagerForm.roleName.focus();
	}
</script>

	<body class="info"  onload="">
		<form  id="RoleManagerForm" name="RoleManagerForm" method="post">
		<pg:beaninfo requestKey="currUser">
		<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<input type="hidden" name="remark2" value="<pg:cell colName="remark2"  defaultValue=""/>" />
		<input type="hidden" name="remark3" value="<pg:cell colName="remark3"  defaultValue=""/>" />
		<input type="hidden" name="roleType" value="<pg:cell colName="roleType"  defaultValue=""/>" />
		<input type="hidden" name="roleUsage" value="<pg:cell colName="roleUsage"  defaultValue=""/>" />
		<input type="hidden" name="roleId" value="<pg:cell colName="roleId"  defaultValue=""/>" />
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
			<tr>
				<td height="25" class="detailtitle" width="23%"><strong>��ɫ����</strong></td>						
				<td height="25">
					<input type="text" id="roleName" name="roleName" style="width:200px" value="<pg:cell colName="roleName"  defaultValue=""/>" validator="string" cnname="��ɫ����" maxlength="100" <%=setDisbaled%> onfocus="setDisable(this)"><span class="STYLE1">*</span>
				</td>
			</tr>
			
			<tr>						
				<td height="25" class="detailtitle"><strong>��ɫ����</strong></td>
				<td height="25">
					<textarea name="roleDesc"  style="width:200px" rows="4" defaultValue=""><pg:cell colName="roleDesc" defaultValue=""/></textarea>
				</td>
								
			</tr>
		</table>
		</pg:beaninfo>
		</form>
	
		<hr width="100%">
		<table width="100%" cellpadding="2" cellspacing="0" bordercolorlight="#3B4D61" bordercolordark="#ffffff">
			<tr>
				<td>
					<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="center">
																		
								</div>
							</td>
							 
							<td>
								<div align="center">
									<input name="Submit31" type="submit" class="input" value="����" onClick="back()">
									<input name="update" type="button" class="input" value="�޸�" onClick="updateRole()">
									<input name="delete" type="button" class="input" value="ɾ��" onClick="deleteRole()">
									<input name="calc" type="button" onClick="resetuser()" class="input" value="����">
								</div>
							</td>
						
							<td>
								<div align="center">
								
								</div>
							</td>
						
          				</tr>
					</table>
				</td>
			</tr>
		</table>
		
	</body>
</html>
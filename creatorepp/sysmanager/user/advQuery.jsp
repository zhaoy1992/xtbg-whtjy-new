<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
	
		<title>ϵͳ����</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
        </style>
</head>

<script language="JavaScript">
var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");



function queryUser()
{
	document.userInfo.action="../user/userManager.do?method=advQueryUser";
	document.userInfo.submit();	
}

function back()
{
	document.location.href="../user/userquery_content_tab.jsp";	
}

</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info">

		<form name="userInfo" method="post" action="">		

				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
				
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��½��</strong>
						</td>
					  <td height="25">
						<input type="text" name="userName"  maxlength="200">					</td>
						<td height="25" class="detailtitle">
							<strong> ��ʵ����</strong>
						</td>
					  <td height="25">
						<input type="text" name="userRealname"  maxlength="100">						</td>
						
					</tr>					
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��λ�绰</strong>
						</td>
					  <td height="25">
						<input type="text" name="userWorktel" maxlength="11"></td>
						<td height="25" class="detailtitle">
							<strong> �Ա�</strong>
						</td>
					  <td height="25">					  
					    <dict:select type="sex" textValue="--��ѡ���Ա�--"  name="userSex" />						
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��ͥ�绰</strong>
						</td>
						<td height="25">
							<input type="text" name="homePhone"  maxlength="11">
						</td>
						<td height="25" class="detailtitle">
							<strong> �����ʼ�</strong>
						</td>
						<td height="25">
							<input type="text" name="mail"  validator="emailNull" cnname="�����ʼ�" maxlength="40">
						</td>
						
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							<strong> �ƶ��绰1</strong>
						</td>
						<td height="25">
							<input type="text" name="mobile"  validator="intNull" cnname="�ƶ��绰" maxlength="11">
						</td>
						<td height="25" class="detailtitle">
							<strong> �ֻ��̺���</strong>
						</td>
						<td height="25">
							<input type="text" name="shortMobile" validator="stringNull"  cnname="�ֻ��̺���" maxlength="40">
						</td>
						
					</tr>
					
					<tr>
						<td height="25" class="detailtitle">
							<strong> �ƶ��绰2</strong>
						</td>
						<td height="25">
							<input type="text" name="userMobiletel2"  validator="intNull" cnname="�ƶ��绰2" maxlength="11">
						</td>
						<td height="25" class="detailtitle">
							<strong> ƴ��</strong>
						</td>
						<td height="25">
							<input type="text" name="userPinyin"  validator="stringNull" cnname="ƴ��" maxlength="100">
						</td>
						
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							<strong> �û�����</strong>
						</td>
						<td height="25">
							<dict:select type="userType" textValue="--��ѡ���û�����--" name="userType"  />
						</td>
						<td height="25" class="detailtitle">
							<strong> ��������</strong>
						</td>
						<td height="25">
							<input type="text" name="postalCode"  validator="intNull" cnname="��������" maxlength="7">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ����</strong>
						</td>
						<td height="25">
							<input type="text" name="userFax"  validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> OICQ</strong>
						</td>
						<td height="25">
							<input type="text" name="userOicq"  validator="intNull" cnname="OICQ" maxlength="13">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ����</strong>
						</td>
						<td height="25">
							<input type="text" name="userBirthday" onClick="selectTime('userInfo.userBirthday',1)" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> �û���ַ</strong>
						</td>
						<td height="25">
							<input type="text" name="userAddress" validator="stringNull" cnname="�û���ַ" maxlength="200">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��¼����</strong>
						</td>
						<td height="25">
							<input type="text" name="userLogincount"  validator="intNull"  cnname="��¼����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> �Ƿ���Ч</strong>
						</td>
						<td height="25">
						<dict:select type="isvalid"  textValue="--��ѡ��״̬--" name="userIsvalid" />
							
							
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ע������</strong>
						</td>
						<td height="25">
							<input type="text" name="userRegdate" onClick="selectTime('userInfo.userRegdate',1)"  validator="stringNull" cnname="ע������" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							
						</td>
						<td height="25">
							<select name="userOrgType"> 
								<option selected value="hasMainOrg">���������û�</option> 
								<option value="noMainOrg">���������û�</option> 
								<option value="dis">��ɢ�û�</option>  
							</select>	
						</td>						
					</tr>					
		  </table>			
		</form>

		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<div align="center">
						<input name="qqq" type="button" class="input" value="��ѯ" onClick="queryUser()">									
					</div>
				</td>							 
				<td>
					<div align="left">									
						<input name="bbb" type="submit" class="input" value="����" onClick="back()">
					</div>
				</td>	
			</tr>
		</table>

	</body>
</html>

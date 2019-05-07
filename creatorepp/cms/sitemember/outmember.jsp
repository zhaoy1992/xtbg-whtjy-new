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
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	String isUserExist =(String)request.getAttribute("isUserExist");

	String setDisbaled = "";
	if ( request.getAttribute("userNameDisable") != null ){
		setDisbaled = "disabled = true";
	}		
	
	UserInfoForm user = (UserInfoForm)request.getAttribute("currUser");
	
	if(user == null)
		user = new UserInfoForm();
		
	String isNew = (String)request.getAttribute("isNew");
	if(isNew == null ){
		isNew = "0";
	}
	String entpeach = (String)request.getAttribute("entpeach");
	String outtype="";
	if(entpeach.equals("entp")){
		outtype ="��ҵ";
	}else{
		outtype ="����";
	}
	
	String isaddorupdate = (String)request.getAttribute("isaddorupdate");
	
	if(isaddorupdate == null ){
		isaddorupdate = "1";
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
function storeUser()
{
	var UserInfoForm = document.all.UserInfoForm; 
	if(UserInfoForm.userName.value.search(/\W/g)!=-1){
		alert("�û���ֻ�ܰ������֡��ַ����»���!");
		UserInfoForm.userName.focus();
		return false;
	}
	document.UserInfoForm.userName.disabled = false;
	
	if (validateForm(UserInfoForm) )
	{
		var userName= document.forms[0].userName.value;
		if (trim(userName).length == 0 ){
    	alert("�������½����"); 
    	return false;
    } 
    	
   		
		document.UserInfoForm.action="../member/memberManager.do?method=storeMember";
		document.UserInfoForm.submit();
	}
}
function updateUser()
{
	
	document.UserInfoForm.userName.disabled = false;
	
	if (validateForm(UserInfoForm) )
	{
		var userName= document.forms[0].userName.value;
		if (trim(userName).length == 0 ){
    	alert("�������½����"); 
    	return false;
    } 
    	
   		
		document.UserInfoForm.action="../member/memberManager.do?method=updateMember";
		document.UserInfoForm.submit();
	}
}
function defaultpass()//�ָ��û���ʼ����
{
		var userId= document.forms[0].userId.value;
		if (confirm("��ȷ��Ҫ�ָ�Ϊ��ʼ������")){
			document.UserInfoForm.action="../member/memberManager.do?method=defaultpass&userName="+userId;
			document.UserInfoForm.submit();
		}
}

function reloadUser(){
	document.UserInfoForm.submit();
}

function newUser()
{
	document.UserInfoForm.action="../user/userManager.do?method=newUser";
	document.UserInfoForm.submit();
}

function back()
{
	document.location.href="../member/memberManager.do?method=getMemberList";	
}

function resetuser()
{
	var userId= document.forms[0].userId.value;
	document.location.href="../member/memberManager.do?method=updateMember&memberId="+userId;	
}

function setDisable(v){
	v.disabled = false;
	if  ( document.UserInfoForm.userId.value != "" )
	{
		v.disabled = true;
	}
}


//Ĭ�Ϲ��ͣ�����ĵ����������
	function document.onreadystatechange(){
		if (document.readyState!="complete") return;
		document.all.UserInfoForm.userName.focus();
	}
	
	function outmember()
	{
		document.location.href="../member/memberManager.do?method=newMember&flag=0";
	}
	function entpeach()
	{
		document.location.href="../member/memberManager.do?method=newMember&flag=1&entpeach=entp";
	}
</script>

	<body class="info"  onload="">
		<form  id="UserInfoForm" name="UserInfoForm" method="post">
		<pg:beaninfo requestKey="currUser">
		<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<input type="hidden" name="remark3" value="<pg:cell colName="remark3"  defaultValue=""/>" />
		<input type="hidden" name="shortMobile" value="<pg:cell colName="shortMobile"  defaultValue=""/>" />
		
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
			<%if(isaddorupdate.equals("1")){%>
			<tr>
				<td height="25" class="detailtitle" width="23%"><strong>>>�����Ա����</strong></td>						
				<td colspan=3 height="25">
						<select name="userkind"  style="width:100px" onChange="outmember()">
				         <option value="1" select>�ⲿ��Ա</option>
				         <option value="0">�ڲ���Ա</option>
				        </select>
				</td>
				
			</tr>
			<tr>
						<td height="25" class="detailtitle">
							<strong>>>ѡ���ⲿ��Ա����</strong>
						</td>
						<td colspan=3 height="25">
								<select name="type"  style="width:100px" onChange="entpeach()">
						         <option value="1" <%if(entpeach.equals("each")){%>selected<%}%>>����</option>
						         <option value="2" <%if(entpeach.equals("entp")){%>selected<%}%>>��ҵ</option>
						        </select>
						</td>
					
			</tr>
			<%}%>
			<tr>
				<td height="25" class="detailtitle" width="23%"><strong>��Ա����</strong></td>						
				<td height="25">
					<input type="text" id="userName" name="userName" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="��½��" maxlength="100" <%=setDisbaled%> onfocus="setDisable(this)"><span class="STYLE1">*</span>
				</td>
				<td height="25" class="detailtitle" width="20%"><strong> ��ʵ����</strong></td>						
				<td height="25">
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="��ʵ����" maxlength="100"><span class="STYLE1">*</span>	</td>
			</tr>
			
			<tr>						
				<td height="25" class="detailtitle"><strong> ����</strong></td>
				<td height="25">
					<input type="password" name="userPassword" value="<pg:cell colName="userPassword"  defaultValue="123456"/>" validator="string" cnname="����" maxlength="40"><span class="STYLE1">*ȱʡ����Ϊ123456</span>
				</td>
				<td height="25" class="detailtitle"><strong> ���֤����</strong></td>
					<td height="25">
					<input type="text" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" validator="stringNull" cnname="���֤����" maxlength="40">
				</td>					
			</tr>
			
			<tr><td height="25" class="detailtitle"><strong> ��λ�绰</strong></td>						
				<td height="25">
					<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>"  cnname="��λ�绰" maxlength="13"></td>
				<td height="25" class="detailtitle"><strong> �Ա�</strong></td>
				<td height="25">					  					    
					    <dict:select style="width:100px" dictTypeName="sex" name="userSex" defaultValue="M" value="<%=user.getUserSex()%>"/>
				</tr>
			
			<tr><td height="25" class="detailtitle"><strong> ��ͥ�绰</strong></td>
				<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="homePhone"  defaultValue=""/>"  cnname="��ͥ�绰" maxlength="13"></td>				
				<td height="25" class="detailtitle"><strong> �����ʼ�</strong></td>
				<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="mail"  defaultValue=""/>" validator="emailNull" cnname="�����ʼ�" maxlength="40"></td>
			</tr>
			
			<tr>
				<td height="25" class="detailtitle"><strong> �ƶ��绰1</strong></td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="mobile"  defaultValue=""/>" cnname="�ƶ��绰" maxlength="13"></td>
				<td height="25" class="detailtitle"><strong> �ƶ��绰1������</strong></td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰1������" maxlength="100"></td>
			</tr>
			
			<tr><td height="25" class="detailtitle"><strong> �ƶ��绰2</strong></td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" cnname="�ƶ��绰2" maxlength="13"></td>
				<td height="25" class="detailtitle"><strong> �ƶ��绰2������</strong></td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰2������" maxlength="100"></td>
		   </tr>
		   <tr>
			   <td height="25" class="detailtitle">
			   		<strong> ����ʱ��</strong>
			   </td>
				<td height="25">
					<input type="text" name="pastTime" readonly="true" onClick="selectTime('UserInfoForm.pastTime',1)" value="<pg:cell colName="pastTime"  defaultValue=""  />" maxlength="40">
				</td>
		   <td height="25" class="detailtitle"><strong> ƴ��</strong></td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" validator="stringNull" cnname="ƴ��" maxlength="100"></td>
	       </tr>   
		   <tr>
						<td height="25" class="detailtitle">
							<strong> ��Ա����</strong>
						</td>
			   <td height="25">
<!--							<dict:select style="width:100px" dictTypeName="userType" name="userType" defaultValue="1" value="<%=user.getUserType()%>" />-->
							<input type="userType" name="userType" value="<pg:cell colName="userType"  defaultValue="�ⲿ��Ա"/>"  readonly="true">  <%=outtype%>
				</td>						
			   <td height="25" class="detailtitle"><strong> ��������</strong></td>
			   <td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="postalCode"  defaultValue=""/>" validator="intNull" cnname="��������" maxlength="7"></td>	
		   </tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ����</strong>
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> OICQ</strong>
						</td>
						<td height="25">
							<input type="text" name="userOicq" value="<pg:cell colName="userOicq"  defaultValue=""/>" validator="intNull" cnname="OICQ" maxlength="13">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ����</strong>
						</td>
						<td height="25">
							<input type="text" name="userBirthday" readonly="true" onClick="selectTime('UserInfoForm.userBirthday',1)" value="<pg:cell colName="userBirthday"  defaultValue=""  />" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> &nbsp;��ַ</strong>
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" validator="stringNull" cnname="�û���ַ" maxlength="200">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��¼����</strong>
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>" validator="intNull" readonly cnname="��¼����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong> �Ƿ���Ч</strong>
						</td>
						<td height="25">
							<dict:select style="width:100px" dictTypeName="isvalid" name="userIsvalid" defaultValue="1" value="<%=String.valueOf(user.getUserIsvalid())%>"/>							
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ע������</strong>
						</td>
						<td height="25">
							<input type="text" name="userRegdate" readonly="true" onClick="selectTime('UserInfoForm.userRegdate',1)" value="<pg:cell colName="userRegdate"  defaultValue="" />" validator="stringNull" cnname="ע������" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong>�����</strong>
						</td>
						<td height="25">
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" validator="stringNull" cnname="�û������" maxlength="40">
						</td>
					</tr>
					
				
					<tr>
						<td height="25" class="detailtitle">
							<strong> ����ȡ������</strong>
						</td>
						<td height="25">
							<input type="text" name="question"  value="<pg:cell colName="question"  defaultValue="" />" validator="stringNull" cnname="����ȡ������" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong>����ȡ�ش�</strong>
						</td>
						<td height="25">
							<input type="text" name="answer" value="<pg:cell colName="answer"  defaultValue="" />" validator="stringNull" cnname="����ȡ�ش�" maxlength="40">
						</td>
					</tr>
					<%if(entpeach.equals("entp")){%>
					<tr>
						<td height="25" class="detailtitle">
							<strong> ��ҵ��ϵ��</strong>
						</td>
						<td height="25">
							<input type="text" name="enterpriseLinkman"  value="<pg:cell colName="enterpriseLinkman"  defaultValue="" />" validator="stringNull" cnname="��ҵ��ϵ��" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							<strong>�Ƿ񹫿���ϵ��ʽ������</strong>
						</td>
						<td height="25">
							<dict:select style="width:100px" dictTypeName="enableopen" name="enableopen" defaultValue="1" value="<%=user.getEnableopen()%>"/>							
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<strong>��ҵ����</strong>
						</td>
						<td colspan=3 height="25">
							<input type="text" size="110" name="enterpriseIntro" value="<pg:cell colName="enterpriseIntro"  defaultValue=""/>" validator="stringNull" cnname="��ҵ����" maxlength="200" >
						</td>
						
					</tr>
					
					<%}%>
					<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />
					
		</table>
		  </pg:beaninfo>
		</form>
		
		<hr width="100%">
		<table width="100%" cellpadding="2" cellspacing="0" >
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
									<%
										//����û�����ð�ť
										if(isNew.equals("0")){
									%>
									<input name="update" type="button" class="input" value="�޸�" onClick="updateUser()">
<!--									<input name="calc" type="button" onClick="resetuser()" class="input" value="����">-->
									<input name="default" type="button" onClick="defaultpass()" class="input" value="����ָ�">
									<%
									}
									else {
									%>
									<input name="resave" type="button" class="input" value="����" onClick="storeUser()">
									<%}%>
								</div>
							</td>
						
							<td>
								<div align="center">
									<input name="Submit32" type="submit" class="input" value="����" onClick="back()">
								</div>
							</td>
						
          				</tr>
					</table>
				</td>
			</tr>
		</table>
		
	</body>
</html>
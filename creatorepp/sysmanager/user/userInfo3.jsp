
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager
				,com.chinacreator.security.authentication.EncrpyPwd" %>
<%@ page import="com.chinacreator.security.*,java.sql.Date"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%	
	//action start
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request,response);
			
			UserManager userManager = SecurityDatabase.getUserManager();
			String userId=request.getParameter("userId");
			
			User user = new User();
			user = userManager.getUserById(userId);
			String userName = user.getUserName();
			//����  ���²���
			if(request.getParameter("isSave") != null){
				
				user.setUserPassword(request.getParameter("userPassword"));
				user.setUserRealname(request.getParameter("userRealname"));
				user.setUserSn(new Integer(request.getParameter("userSn")));
				if(!"NaN".equals(request.getParameter("userSex")))
					user.setUserSex(request.getParameter("userSex"));
				if(!"NaN".equals(request.getParameter("userIsvalid")))
					user.setUserIsvalid(new Integer(request.getParameter("userIsvalid")));
				user.setUserHometel(request.getParameter("homePhone"));
				user.setUserMobiletel1(request.getParameter("mobile"));
				user.setUserPostalcode(request.getParameter("postalCode"));
				user.setRemark2(request.getParameter("shortMobile"));
				user.setUserEmail(request.getParameter("mail"));
				user.setUserMobiletel2(request.getParameter("userMobiletel2"));
				user.setRemark1(request.getParameter("remark1"));
				user.setRemark3(request.getParameter("remark3"));
				user.setRemark4(request.getParameter("remark4"));
				user.setRemark5(request.getParameter("remark5"));
				
				if(!"NaN".equals(request.getParameter("userType")))
					user.setUserType(request.getParameter("userType"));
	
				user.setUserPinyin(request.getParameter("userPinyin"));
	
				user.setUserWorktel(request.getParameter("userWorktel"));
	
				user.setUserFax(request.getParameter("userFax"));
	
				user.setUserOicq(request.getParameter("userOicq"));
				if (request.getParameter("userBirthday") != null
						&& request.getParameter("userBirthday").length() > 0)
					user.setUserBirthday(Date.valueOf(request.getParameter("userBirthday")));
	
				user.setUserAddress(request.getParameter("userAddress"));
	
				user.setUserIdcard(request.getParameter("userIdcard"));
				if (request.getParameter("userRegdate") != null
						&& request.getParameter("userRegdate").length() > 0)
					user.setUserRegdate(Date.valueOf(request.getParameter("userRegdate")));
				
				if(request.getParameter("istaxmanager")==null){
					user.setIstaxmanager(0);
				}else{
					user.setIstaxmanager(Integer.valueOf(request.getParameter("istaxmanager")).intValue());
				}
				userManager.updateUser(user);
				
			}else{
				user = userManager.getUserById(userId);
			}
			
			//����ָ�
			if(request.getParameter("dispersePwd") != null){
				user.setUserPassword("123456");
				userManager.updateUserPassword(user);
			}
	//action end
		
	String qstring = request.getParameter("qstring");
	if(qstring == null){
		qstring  = (String)request.getAttribute("qstring");
	}
	if(qstring == null){
		qstring = "";
	}
	String qqstring = java.net.URLEncoder.encode(qstring);


	String pwd = EncrpyPwd.decodePassword(user.getUserPassword());
	user.setUserPassword(pwd);
	request.setAttribute("currUser",user);
%>

<html>
	<head>
		<title>�û���<%=userName%>��������Ϣ</title>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">	
	</head>

<script language="JavaScript">
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
var q = "<%=qstring%>";
function trim(string){
  var temp="";
  string = ''+string;
  splitstring = string.split(" ");
  for(i=0;i<splitstring.length;i++){
    temp += splitstring[i];
  } 
  return temp;
 }
//��ɢ�û�����ɹ���ʾ
var isSave = "<%=request.getParameter("isSave")%>";
if(isSave == "true"){
	alert("�޸��û��ɹ���");
}
//��ɢ�û�����ָ���ʾ
var dispersePwd = "<%=request.getParameter("dispersePwd")%>";
if(dispersePwd == "2"){
	alert("�����ɹ����û������ѻָ���ʼ���룡");
}

function storeUser1()
{
	document.userInfo.userName.disabled = false;
	
	if (validateForm(userInfo))
	{
		var userName= document.forms[0].userName.value;
		if (trim(userName).length == 0 ){
    		alert("�������½����"); 
    		return false;
    	} 
    	
	    if(document.userInfo.remark3.checked){
	    	document.userInfo.remark3.value="��";
	    }
		else{ 
			document.userInfo.remark3.value="��";
		}	
		if(document.userInfo.istaxmanager.checked){
			document.userInfo.istaxmanager.value="1";
		}
		else{
			document.userInfo.istaxmanager.value="0";
		}
		
	    document.userInfo.target="saveDisperse";
		document.userInfo.action="userInfo3.jsp?isSave=true";
		document.userInfo.submit();
		//document.userInfo.action="../user/userManager.do?method=storeDiscreteUser&isSave=true";
	}
}

 function goback(e,userId)
{		
	document.location.href="../user/discreteUserList.jsp?<%=qstring%>";
}
function defaultpass()//�ָ��û���ʼ����
{
		var userId= document.forms[0].userId.value;
		//alert(userId);
		document.userInfo.target="saveDisperse";
		//document.userInfo.action="../user/userManager.do?method=defaultpass&userName="+userId;
		document.userInfo.action="userInfo3.jsp?dispersePwd=2&userName="+userId;
		document.userInfo.submit();
		document.userInfo.userPassword.value="123456";
	
}

</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info"><CENTER><br>
		<form name="userInfo" method="post" action="">
			<pg:beaninfo requestKey="currUser">
			<input type="hidden" name="remark11" value="<pg:cell colName="remark1"  defaultValue=""/>" />
			<input type="hidden" name="remark31" value="<pg:cell colName="remark3"  defaultValue=""/>" />
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="thin">
					<tr>
					<td height="25" class="detailtitle" width="23%">
							 ��½��
						</td>
					  <td height="25">
						<input type="text" name="userName" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="��½��" maxlength="200" disabled=true ></td>
						<td height="25" class="detailtitle" width="20%">
							 ��ʵ����
						</td>
					  <td height="25">
						<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="��ʵ����" maxlength="100">					</td>
						
					</tr>
					
					<tr>
						<td height="25" class="detailtitle">
							 ����(��ʼ����Ϊ123456)
						</td>
					  <td height="25">
						<input type="password" name="userPassword" value="<pg:cell colName="userPassword"  defaultValue=""/>" validator="string" cnname="����" maxlength="40"></td>
						<td height="25" class="detailtitle">
							 ���֤����
						</td>
						<td height="25">
							<input type="password" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" validator="intNull" cnname="���֤����" maxlength="18">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ��λ�绰
						</td>
					  <td height="25">
						<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>"  cnname="��λ�绰" maxlength="13"></td>
						<td height="25" class="detailtitle">
							 �Ա�
						</td>
					  <td height="25">					  
					    <%if("1".equals(request.getParameter("userId"))){%>
					    <dict:select type="sex" name="userSex" expression="{userSex}" disabled="true"/>
						<%}else{%>
						<dict:select type="sex" name="userSex" expression="{userSex}"/>
						<%}%>		
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ��ͥ�绰
						</td>
						<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>"  cnname="��ͥ�绰" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							 �����ʼ�
						</td>
						<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" validator="emailNull" cnname="�����ʼ�" maxlength="40">
						</td>
					</tr>

				<tr>
					<td height="25" class="detailtitle"> �ƶ��绰1</td>
					<td height="25">
								<input type="text" name="mobile" value="<pg:cell colName="userMobiletel1"  defaultValue=""/>" cnname="�ƶ��绰" maxlength="13"></td>
					<td height="25" class="detailtitle"> �ƶ��绰1������</td>
					<td height="25">
								<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰1������" maxlength="100"></td>
					
			 	</tr>
			
			<tr><td height="25" class="detailtitle"> �ƶ��绰2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>"  cnname="�ƶ��绰2" maxlength="13"></td>
				<td height="25" class="detailtitle"> �ƶ��绰2������</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" validator="stringNull" cnname="�ƶ��绰2������" maxlength="100"></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> ��֯����</td>
				<td height="25">
							<input disabled="true" type="text" name="ou" value="<pg:cell colName="ou"  defaultValue=""/>" validator="stringNull" cnname="��֯����" maxlength="100"></td>
		   <td height="25" class="detailtitle"> ƴ��</td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" validator="stringNull" cnname="ƴ��" maxlength="100"></td>
				
	       </tr>   
					<tr>
						<td height="25" class="detailtitle">
							 �û�����
						</td>
						<td height="25">
							<%if("1".equals(request.getParameter("userId"))){%>
							<dict:select type="userType" name="userType" expression="{userType}" disabled="true" textValue="<%=user.getUserType()%>" />
							<%}else{%>
							<dict:select type="userType" name="userType" expression="{userType}" textValue="<%=user.getUserType()%>" />
							<%}%>
						</td>
						<td height="25" class="detailtitle">
							 ��������
						</td>
						<td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" validator="intNull" cnname="��������" maxlength="7">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 OICQ
						</td>
						<td height="25">
							<input type="text" name="userOicq" value="<pg:cell colName="userOicq"  defaultValue=""/>" validator="intNull" cnname="OICQ" maxlength="13">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userBirthday" onclick="showdate(document.all('userBirthday'))" readonly="true" value="<pg:cell colName="userBirthday"  defaultValue=""  />" validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �û���ַ
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" validator="stringNull" cnname="�û���ַ" maxlength="200">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ��¼����
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>" validator="intNull" readonly="true" cnname="��¼����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �Ƿ���Ч
						</td>
						<td height="25">
						<%if("1".equals(request.getParameter("userId"))){%>
						<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" disabled="true" />
						<%}else{%>
						<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" />
						<%}%>
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ע������
						</td>
						<td height="25">
							<input type="text" name="userRegdate"  onclick="showdate(document.all('userRegdate'))" readonly="true" value="<pg:cell colName="userRegdate"  defaultValue=""  />" validator="stringNull" cnname="ע������" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 �ֻ��̺���
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" validator="stringNull"  cnname="�ֻ��̺���" maxlength="40">
						</td>
						
				</tr>
				<tr>
						<td height="25" class="detailtitle">
							 �û������
						</td>
						<td height="25">
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" validator="stringNull" cnname="�û������" maxlength="40">
						</td>
						<td height="25" class="detailtitle" colspan="2">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr><td width='10%'>
							<input type="checkbox" name="remark3" <pg:equal colName="remark3" value="��">checked</pg:equal>>
							</td><td width='150px'><div class='label'>������Ϣ�Ƿ���</div></td></tr>
							</table>
						</td>
    					
				</tr>
				<tr>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" name="istaxmanager" <pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
						</td><td width='150px'><div class='label'>�Ƿ�˰��Ա</div></td>
						</tr>
						</table>
						</td>
				</tr>					
				<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />				
				<input type="hidden" name="qstring" value="<%=qqstring%>" >
			  </table>
			</pg:beaninfo>
		</form>
		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="center">
									<input name="resave" type="button" class="input" value="����" onClick="storeUser1()">
								</div>
							</td>
							<td>
								<div align="center">
									<input name="default" type="button" onClick="defaultpass()" class="input" value="����ָ�">
								</div>
							</td>							
							<td>
								<div align="center">
									<input name="Submit32" type="submit" class="input" value="�ر�" onclick="window.close();window.returnValue='ok';">
								</div>
							</td>							
						</tr>
					</table>
				</td>
			</tr>
		</table>
<iframe name="saveDisperse" border="0" width="0" height="0"></iframe>
	</CENTER></body>
</html>
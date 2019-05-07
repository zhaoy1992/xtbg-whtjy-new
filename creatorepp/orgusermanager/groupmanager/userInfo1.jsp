<%
/*
 * <p>Title: �û���Ϣ�鿴ҳ��</p>
 * <p>Description: �û���Ϣ�鿴ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-24
 * @author baowen.liu
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.*" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="java.util.*"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%     

	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
	
		 String userId = request.getParameter("userId");
		 UserManager userManager = SecurityDatabase.getUserManager();
		 User user = userManager.getUserById(userId);
     	 String userName= user.getUserRealname();
	     request.setAttribute("currUser", user);
	     
	     String userAccount = user.getUserName();
	    
	
	//�õ��û����ڻ������б�.
	
	OrgManager orgManager  = SecurityDatabase.getOrgManager();
	List list  = orgManager.getOrgList(user);
	
	String orgNames ="";
	
	if(list.size() > 0)
	{
		for(int i=0 ; i<list.size();i++)
		{
			Organization org = (Organization) list.get(i);
			orgNames += org.getOrgName() + ",";		
		}
	}
	if(orgNames.length()!=0){
		orgNames = orgNames.substring(0,orgNames.length()-1);
	}
	
	 
%>
<html>
	<head>
		<title>�û�[<%=userName%>]������Ϣ</title>
	   

		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	<script language="JavaScript">	
		function back()
			{
				
				window.close();
			}
	</script>

</head>




<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="">
		<div id="contentborder" align="center">

	
		<form name="UserInfoForm" method="post">
		
		
		<pg:beaninfo requestKey="currUser">
		<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
			
			<tr>
				<td height="25" class="detailtitle" width="23%"> ��½��</td>						
				<td height="25">
					<input type="text" readonly name="userName"  value="<pg:cell colName="userName"  defaultValue=""/>" >
					<font color="red">*</font>
				</td>
				<td height="25" class="detailtitle" width="20%"> ��ʵ����</td>						
				<td height="25">
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" readonly>
					<font color="red">*</font>
				</td>											  
			</tr>
			
			<tr>						
				<td height="25" class="detailtitle"> ����</td>
				<td height="25">
					<input type="password" name="userPassword" readonly  value="<pg:cell colName="userPassword"  defaultValue="123456"/>" readonly>
					<font color="red">*ȱʡ����Ϊ123456</font>
				</td>
				<td height="25" class="detailtitle"> ���֤����</td>
					<td height="25">
					<input type="text" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" readonly>
				</td>
										
			</tr>
			
			<tr><td height="25" class="detailtitle"> ��λ�绰</td>						
				<td height="25">
					<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> �Ա�</td>
				<td height="25">					  					    
				<%if("1".equals(request.getParameter("userId"))){%>
				<dict:select type="sex" name="userSex" expression="{userSex}" disabled="true"/>
				<%}else{%>
				<dict:select type="sex" name="userSex" expression="{userSex}"  disabled="true"/>
				<%}%>
				</td>
			</tr>
			
			<tr><td height="25" class="detailtitle"> ��ͥ�绰</td>
				<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>" readonly></td>				
				<td height="25" class="detailtitle"> �����ʼ�</td>
				<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" readonly></td>
				
			</tr>
			
			<tr>
				<td height="25" class="detailtitle"> �ƶ��绰1</td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="userMobiletel1"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> �ƶ��绰1������</td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" readonly></td>
				
			</tr>
			
			<tr><td height="25" class="detailtitle"> �ƶ��绰2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> �ƶ��绰2������</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" readonly ></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> ��֯����</td>
				<td height="25">
							<input type="text" name="ou" readonly="true" value="<%=orgNames%>" readonly ></td>
		   <td height="25" class="detailtitle"> ƴ��</td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" readonly></td>
				
	       </tr>   
		   <tr><td height="25" class="detailtitle"> �û�����</td>
			   <td height="25">
			   		<%if(accesscontroler.isAdmin(userAccount) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true"  />
					<%}else{%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true" />
					<%}%>
			   </td>					
			   <td height="25" class="detailtitle"> ��������</td>
			   <td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" readonly></td>						
			   
		   </tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" readonly>
						</td>
						<td height="25" class="detailtitle">
							 OICQ
						</td>
						<td height="25">
							<input type="text" name="userOicq" value="<pg:cell colName="userOicq"  defaultValue=""/>" readonly>
						</td>
						
						</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ����
						</td>
						<td height="25">
							<input type="text" name="userBirthday"  readonly="true" value="<pg:cell colName="userBirthday"  defaultValue=""  />" readonly>
						</td>
						<td height="25" class="detailtitle">
							 �û���ַ
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" readonly>
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ��¼����
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>"  readonly >
						</td>
						<td height="25" class="detailtitle">
							 �Ƿ���Ч
						</td>
						<td height="25">
							<%if(accesscontroler.isAdmin(userAccount) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" disabled="true" />
							<%}else{%>
							<dict:select type="isvalid" name="userIsvalid" expression="{userIsvalid}" disabled="true"/>
						<%}%>							
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 ע������
						</td>
						<td height="25">
							<input type="text" name="userRegdate"  readonly="true" value="<pg:cell colName="userRegdate"  defaultValue="" />" readonly >
						</td>
						<td height="25" class="detailtitle">
							 �ֻ��̺���
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" readonly >
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 �û������
						</td>
						<td height="25">
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" readonly >
						</td>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input disabled="true" type="checkbox" name="remark3" <pg:equal colName="remark3" value="��">checked</pg:equal>>
						</td><td width='150px'><div class='label'>������Ϣ�Ƿ���</div></td>
						</tr>
						</table>
						</td>
					</tr>
					<!-- <tr>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" disabled="true" name="istaxmanager" <pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
						</td><td width='150px'><div class='label'>�Ƿ�˰��Ա</div></td>
						</tr>
						</table>
						</td>
						</tr> -->
											
		     </table>
		  </pg:beaninfo>
		</form>
		<hr>
        <div align="center">
	         <input name="Submit3" type="button" class="input" value="����" onclick="back()">
		</div>
	
		

</div>

</body> 
</html>
<%
/*
 * <p>Title: 用户信息查看页面</p>
 * <p>Description: 用户信息查看页面</p>
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
	    
	
	//得到用户所在机构的列表.
	
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
		<title>用户[<%=userName%>]基本信息</title>
	   

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
				<td height="25" class="detailtitle" width="23%"> 登陆名</td>						
				<td height="25">
					<input type="text" readonly name="userName"  value="<pg:cell colName="userName"  defaultValue=""/>" >
					<font color="red">*</font>
				</td>
				<td height="25" class="detailtitle" width="20%"> 真实名称</td>						
				<td height="25">
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" readonly>
					<font color="red">*</font>
				</td>											  
			</tr>
			
			<tr>						
				<td height="25" class="detailtitle"> 口令</td>
				<td height="25">
					<input type="password" name="userPassword" readonly  value="<pg:cell colName="userPassword"  defaultValue="123456"/>" readonly>
					<font color="red">*缺省口令为123456</font>
				</td>
				<td height="25" class="detailtitle"> 身份证号码</td>
					<td height="25">
					<input type="text" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" readonly>
				</td>
										
			</tr>
			
			<tr><td height="25" class="detailtitle"> 单位电话</td>						
				<td height="25">
					<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> 性别</td>
				<td height="25">					  					    
				<%if("1".equals(request.getParameter("userId"))){%>
				<dict:select type="sex" name="userSex" expression="{userSex}" disabled="true"/>
				<%}else{%>
				<dict:select type="sex" name="userSex" expression="{userSex}"  disabled="true"/>
				<%}%>
				</td>
			</tr>
			
			<tr><td height="25" class="detailtitle"> 家庭电话</td>
				<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>" readonly></td>				
				<td height="25" class="detailtitle"> 电子邮件</td>
				<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" readonly></td>
				
			</tr>
			
			<tr>
				<td height="25" class="detailtitle"> 移动电话1</td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="userMobiletel1"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> 移动电话1归属地</td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" readonly></td>
				
			</tr>
			
			<tr><td height="25" class="detailtitle"> 移动电话2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" readonly></td>
				<td height="25" class="detailtitle"> 移动电话2归属地</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" readonly ></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> 组织机构</td>
				<td height="25">
							<input type="text" name="ou" readonly="true" value="<%=orgNames%>" readonly ></td>
		   <td height="25" class="detailtitle"> 拼音</td>
				<td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" readonly></td>
				
	       </tr>   
		   <tr><td height="25" class="detailtitle"> 用户类型</td>
			   <td height="25">
			   		<%if(accesscontroler.isAdmin(userAccount) || "1".equals(userId) || userId.equals(accesscontroler.getUserID())){%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true"  />
					<%}else{%>
					<dict:select type="userType" name="userType" expression="{userType}" disabled="true" />
					<%}%>
			   </td>					
			   <td height="25" class="detailtitle"> 邮政编码</td>
			   <td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" readonly></td>						
			   
		   </tr>
					<tr>
						<td height="25" class="detailtitle">
							 传真
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
							 生日
						</td>
						<td height="25">
							<input type="text" name="userBirthday"  readonly="true" value="<pg:cell colName="userBirthday"  defaultValue=""  />" readonly>
						</td>
						<td height="25" class="detailtitle">
							 用户地址
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" readonly>
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 登录次数
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>"  readonly >
						</td>
						<td height="25" class="detailtitle">
							 是否有效
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
							 注册日期
						</td>
						<td height="25">
							<input type="text" name="userRegdate"  readonly="true" value="<pg:cell colName="userRegdate"  defaultValue="" />" readonly >
						</td>
						<td height="25" class="detailtitle">
							 手机短号码
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" readonly >
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 用户排序号
						</td>
						<td height="25">
							<input type="text" name="userSn" value="<pg:cell colName="userSn"  defaultValue="" />" readonly >
						</td>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input disabled="true" type="checkbox" name="remark3" <pg:equal colName="remark3" value="是">checked</pg:equal>>
						</td><td width='150px'><div class='label'>个人信息是否保密</div></td>
						</tr>
						</table>
						</td>
					</tr>
					<!-- <tr>
						<td height="25" class="detailtitle" colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" disabled="true" name="istaxmanager" <pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
						</td><td width='150px'><div class='label'>是否税管员</div></td>
						</tr>
						</table>
						</td>
						</tr> -->
											
		     </table>
		  </pg:beaninfo>
		</form>
		<hr>
        <div align="center">
	         <input name="Submit3" type="button" class="input" value="返回" onclick="back()">
		</div>
	
		

</div>

</body> 
</html>

<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%	
	UserInfoForm user = (UserInfoForm)request.getAttribute("currUser");
	if(user == null)
		user = new UserInfoForm();
		
		
	String qstring = request.getParameter("qstring");
	String userId = request.getParameter("userId");
	
	if(qstring != null){
		//qstring  = java.net.URLEncoder.encode(qstring);
	}
	if(qstring == null){
		qstring = "";
	}
	
	UserManager userManager = SecurityDatabase.getUserManager();
	User quser = userManager.getUserById(userId);
	if(quser == null){
		quser = new User();
	}
	String orginfo = "";//用户所属的org
	try {
				OrgManager orgManager = SecurityDatabase.getOrgManager();
				List orgList = orgManager.getOrgList(quser);
				if (orgList != null && orgList.size() > 0) {
					StringBuffer sb = new StringBuffer();
					boolean flags = true;
					for (int i = 0; i < orgList.size(); i++) {
						Organization o = (Organization) orgList.get(i);
						if (flags) {
							sb.append(o.getOrgName());
							flags = false;
						} else {
							sb.append("," + o.getOrgName());
						}
					}
					orginfo = sb.toString();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
	String jobinfo = "";//用户所属的岗位
	try {
	JobManager jobManager = SecurityDatabase.getJobManager();
	List jobList = jobManager.getJobList(quser);
	if (jobList != null && jobList.size() > 0) {
		StringBuffer sb = new StringBuffer();
		boolean flags = true;
		for (int i = 0; i < jobList.size(); i++) {
			Job j = (Job) jobList.get(i);
			if (flags) {
				sb.append(j.getJobName());
				flags = false;
			} else {
				sb.append("," + j.getJobName());
			}
		}
		jobinfo = sb.toString();
				}

	} catch (Exception e) {
		e.printStackTrace();
	}
	request.setAttribute("currUser",quser);
%>

<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo2</title>
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
 
 function goback2(e,userId)
{		
	getPropertiesContent().location.href="../user/userquery_content.jsp?<%=qstring%>";
}

 function goback(e,userId)
{		
	document.location.href="../user/userquery_content_tab.jsp?<%=qstring%>";
}
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info">

		<form name="userInfo" method="post" action="">
			<pg:beaninfo requestKey="currUser">
			</pg:beaninfo>	
			<pg:beaninfo requestKey="currUser">
			<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
			<input type="hidden" name="remark3" value="<pg:cell colName="remark3"  defaultValue=""/>" />
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
				<tr>
					<td height="25" class="detailtitle" width="25%">
							 登陆名
				  </td>
					  <td height="25" width="25%">
						<input type="text" name="userName" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="登陆名" maxlength="200" disabled=true ></td>
						<td height="25" class="detailtitle" width="25%">
							 真实名称
						</td>
					  <td height="25" width="25%">
						<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="真实名称" maxlength="100"></td>
						
			  </tr>
			  <tr>
			  <td height="25" class="detailtitle">
							 口令
						</td>
					  <td height="25">
						<input type="password" name="userPassword" value="<pg:cell colName="userPassword"  defaultValue=""/>" validator="string" cnname="口令" maxlength="40"></td>
						<td height="25" class="detailtitle">
							 身份证号码
						</td>
						<td height="25">
							<input type="password" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" validator="intNull" cnname="身份证号码" maxlength="18">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 单位电话
						</td>
					  <td height="25">
						<input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>" validator="intNull" cnname="单位电话" maxlength="11"></td>
						<td height="25" class="detailtitle">
							 性别
						</td>
					  <td height="25">					  
					    <pg:equal colName="userSex" value="M"><input type="text" name="userSex" value="男"></pg:equal>
						<pg:equal colName="userSex" value="-1"><input type="text" name="userSex" value="未知"></pg:equal>
						<pg:equal colName="userSex" value="F"><input type="text" name="userSex" value="女"></pg:equal>		
						</td>		
					 
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 家庭电话
						</td>
						<td height="25">
							<input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>" validator="intNull" cnname="家庭电话" maxlength="11">
						</td>
						<td height="25" class="detailtitle">
							 电子邮件
						</td>
						<td height="25">
							<input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" validator="emailNull" cnname="电子邮件" maxlength="40">
						</td>
						
					</tr>

					<tr>
				<td height="25" class="detailtitle"> 移动电话1</td>
				<td height="25">
							<input type="text" name="mobile" value="<pg:cell colName="mobile"  defaultValue=""/>" validator="intNull" cnname="移动电话" maxlength="11"></td>
				<td height="25" class="detailtitle"> 移动电话1归属地</td>
				<td height="25">
							<input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" validator="stringNull" cnname="移动电话1归属地" maxlength="100"></td>
				
			</tr>
			
			<tr><td height="25" class="detailtitle"> 移动电话2</td>
				<td height="25">
					<input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" validator="intNull" cnname="移动电话2" maxlength="11"></td>
				<td height="25" class="detailtitle"> 移动电话2归属地</td>
				<td height="25">
							<input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" validator="stringNull" cnname="移动电话2归属地" maxlength="100"></td>
				
		   </tr>
		   <tr>
		   <td height="25" class="detailtitle"> 组织机构</td>
				<td height="25">
							<input type="text" name="ou" value="<%=orginfo%>" readonly="true">
				</td>
		   <td height="25" class="detailtitle"> 所属岗位</td>
		    	 <td height="25">
							<input type="text" name="ju" value="<%=jobinfo%>" readonly="true">
				</td>
	       </tr>   
					<tr>
						<td height="25" class="detailtitle">
							 用户类型
						</td>
						<td height="25">
										  
					    	<pg:equal colName="userType" value="1"><input type="text" name="userType" value="OA用户"></pg:equal>
							
							<pg:equal colName="userType" value="0"><input type="text" name="userType" value="非OA用户"></pg:equal>
						</td>
						<td height="25" class="detailtitle">
							 邮政编码
						</td>
						<td height="25">
							<input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" validator="intNull" cnname="邮政编码" maxlength="7">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 传真
						</td>
						<td height="25">
							<input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" validator="stringNull" cnname="传真" maxlength="40">
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
							 生日
						</td>
						<td height="25">
							<input type="text" name="userBirthday"  value="<pg:cell colName="userBirthday"  defaultValue=""  />" validator="stringNull" cnname="生日" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 用户地址
						</td>
						<td height="25">
							<input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" validator="stringNull" cnname="用户地址" maxlength="200">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 登录次数
						</td>
						<td height="25">
							<input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>" validator="intNull" readonly="true" cnname="登录次数" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 是否有效
						</td>
						<td height="25">
						<pg:equal colName="userIsvalid" value="1"><input type="text" name="userSex" value="有效"></pg:equal>
						<pg:equal colName="userIsvalid" value="0"><input type="text" name="userSex" value="无效"></pg:equal>	
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							 注册日期
						</td>
						<td height="25">
							<input type="text" name="userRegdate" value="<pg:cell colName="userRegdate"  defaultValue=""  />" validator="stringNull" cnname="注册日期" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							 手机短号码
						</td>
						<td height="25">
							<input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" validator="stringNull"  cnname="手机短号码" maxlength="40">
						</td>
						
				</tr>
			
				<tr>
		         <td height="25" class="detailtitle"> 拼音</td>
		    	 <td height="25">
							<input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" readonly="true">
				</td>
				<td height="25" class="detailtitle"></td>
				  <td height="25">
				  </td>
				</tr>						
				<tr>
						<td height="25" class="detailtitle" colspan="4">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" name="remark3" <pg:equal colName="remark3" value="是">checked</pg:equal>>
						</td><td width='150px'>个人信息是否保密</td>
						</tr>
						</table>
						</td> 
						 </tr>
				<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />				
		    </table>
			</pg:beaninfo>			
		</form>
		<hr width="100%">
		<table width="100%" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#3B4D61" bordercolordark="#ffffff">
			<tr bgcolor="#415A76">
				<td>
					<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>							
							<td>
								<div align="center">
									<input name="Submit32" type="submit" class="input" value="返回" onclick="goback()">
								</div>
							</td>							
						</tr>
					</table>
				</td>
			</tr>
		</table>

	</body>
</html>
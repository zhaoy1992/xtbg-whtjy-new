
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.JobManager" %>
<%@ page import="com.frameworkset.util.StringUtil"%>
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
	if(quser.getRemark3()==null||quser.getRemark3().equals(""))
	quser.setRemark3("否");
	
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
		<title>userInfo4</title>
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
			<input type="hidden" name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
			
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
				<tr>
					<td height="25" class="detailtitle" width="25%"><strong> 登陆名</strong></td>					
			    	<td height="25" width="25%">
					<input type="text" name="userName" onchange="checkUser()" value="<pg:cell colName="userName"  defaultValue=""/>" validator="string" cnname="登陆名" maxlength="200" readonly="true"></td>

					<td height="25" class="detailtitle" width="25%"><strong> 真实名称</strong></td>
					<td height="25" width="25%">
					<input type="text" name="userRealname" value="<pg:cell colName="userRealname"  defaultValue=""/>" validator="string" cnname="真实名称" maxlength="100" readonly="true"></td>
					</tr>			
					 
				<tr><td height="25" class="detailtitle"><strong> 口令</strong></td>
					<td height="25">
							<pg:equal colName="remark3" value="否"><input type="password" name="userPassword" value="<pg:cell colName="userPassword"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="password" name="userIdcard" value="******" readonly="true"></pg:equal>
				  </td>
							<td height="25" class="detailtitle"><strong> 身份证号码</strong></td>
							<td height="25">
									<pg:equal colName="remark3" value="否"><input type="text" name="userIdcard" value="<pg:cell colName="userIdcard"  defaultValue=""/>" readonly="true"></pg:equal>
									<pg:equal colName="remark3" value="是"><input type="text" name="userIdcard" value="******" readonly="true"></pg:equal>
							</td>									  
				</tr>
				<tr><td height="25" class="detailtitle"><strong> 单位电话</strong></td>																			
					<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userWorktel" value="<pg:cell colName="userWorktel"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userWorktel" value="******" readonly="true"></pg:equal>						
					</td>						
					<td height="25" class="detailtitle"><strong> 性别</strong></td>
					<td height="25">
						<pg:equal colName="remark3" value="否">					  
					    	<pg:equal colName="userSex" value="M"><input type="text" name="userSex" value="男" readonly="true"></pg:equal>
							<pg:equal colName="userSex" value="-1"><input type="text" name="userSex" value="未知" readonly="true"></pg:equal>
							<pg:equal colName="userSex" value="F"><input type="text" name="userSex" value="女" readonly="true"></pg:equal>				
				    	</pg:equal>					    	
				    	<pg:equal colName="remark3" value="是">				
					    	<input type="text" name="userSex" value="******" readonly="true">
				    	</pg:equal>					    	
					</td>
					 </tr>
			   <tr><td height="25" class="detailtitle"><strong> 家庭电话</strong></td>
					<td height="25">	
							<pg:equal colName="remark3" value="否"><input type="text" name="homePhone" value="<pg:cell colName="userHometel"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="homePhone" value="******" readonly="true"></pg:equal>			
					</td>
					<td height="25" class="detailtitle"><strong> 电子邮件</strong></td>
					<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="mail" value="<pg:cell colName="userEmail"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="mail" value="******" readonly="true"></pg:equal>			
					</td>
					</tr>
			  <tr><td height="25" class="detailtitle"><strong> 移动电话1</strong></td>
				  <td height="25">
				   		    <pg:equal colName="remark3" value="否"><input type="text" name="mobile" value="<pg:cell colName="userMobiletel1"  defaultValue=""/>" readonly="true"></pg:equal>
				   		    <pg:equal colName="remark3" value="是"><input type="text" name="mobile" value="******" readonly="true"></pg:equal>			
				  </td>
				  <td height="25" class="detailtitle"><strong>移动电话1归属地</strong></td>
				  <td height="25">
				            <pg:equal colName="remark3" value="否"><input type="text" name="remark4" value="<pg:cell colName="remark4"  defaultValue=""/>" readonly="true"></pg:equal>
				            <pg:equal colName="remark3" value="是"><input type="text" name="remark4" value="******" readonly="true"></pg:equal>			
				  </td>
			 </tr>
			 <tr><td height="25" class="detailtitle"><strong> 移动电话2</strong></td>
				 <td height="25">		
						    <pg:equal colName="remark3" value="否"><input type="text" name="userMobiletel2" value="<pg:cell colName="userMobiletel2"  defaultValue=""/>" readonly="true"></pg:equal>
						    <pg:equal colName="remark3" value="是"><input type="text" name="userMobiletel2" value="******" readonly="true"></pg:equal>							
				 </td>
				 <td height="25" class="detailtitle"><strong> 移动电话2归属地</strong></td>
		    	 <td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="remark5" value="<pg:cell colName="remark5"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="remark5" value="******" readonly="true"></pg:equal>
				 </td>
			</tr>
			<tr>
		
				  <td height="25" class="detailtitle"><strong> 组织机构</strong></td>
				  <td height="25">
				            <pg:equal colName="remark3" value="否"><input type="text" name="ou" value="<%=orginfo%>" readonly="true"></pg:equal>
				            <pg:equal colName="remark3" value="是"><input type="text" name="ou" value="******" readonly="true"></pg:equal>			
				  </td>
                 <td height="25" class="detailtitle"><strong> 所属岗位</strong></td>
		    	 <td height="25">
		    	 			
							<pg:equal colName="remark3" value="否"><input type="text" name="ju" value="<%=jobinfo%>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="ju" value="******" readonly="true"></pg:equal>
				 </td>
			</tr>
			<tr><td height="25" class="detailtitle"><strong> 用户类型</strong></td>
				<td height="25">		
							<pg:equal colName="remark3" value="否">
								
					    	<pg:equal colName="userType" value="1"><input type="text" name="userType" value="外部会员" readonly="true"></pg:equal>
							<pg:equal colName="userType" value="0"><input type="text" name="userType" value="内部用户" readonly="true"></pg:equal>							
							</pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userType" value="******" readonly="true"></pg:equal>				
				</td>
				
				<td height="25" class="detailtitle"><strong> 邮政编码</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="postalCode" value="<pg:cell colName="userPostalcode"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userPostalcode" value="******" readonly="true"></pg:equal>
				</td>
			</tr>
			<tr><td height="25" class="detailtitle"><strong> 传真</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userFax" value="<pg:cell colName="userFax"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userFax" value="******" readonly="true"></pg:equal>
				</td>
				<td height="25" class="detailtitle"><strong> OICQ</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userOicq" value="<pg:cell colName="userOicq"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userOicq" value="******" readonly="true"></pg:equal>
							
				</td>
			</tr>
		    <tr><td height="25" class="detailtitle"><strong> 生日</strong></td>						
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userBirthday"  value="<pg:cell colName="userBirthday"  defaultValue=""  />" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userBirthday" value="******" readonly="true"></pg:equal>
							
				</td>
				<td height="25" class="detailtitle"><strong> 用户地址</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userAddress" value="<pg:cell colName="userAddress"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userAddress" value="******" readonly="true"></pg:equal>
							
				</td>
			</tr>
			<tr><td height="25" class="detailtitle"><strong> 登录次数</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userLogincount" value="<pg:cell colName="userLogincount"  defaultValue="0"/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userLogincount" value="******" readonly="true"></pg:equal>
							
				</td>
				<td height="25" class="detailtitle"><strong> 是否有效</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否">					  
					    	<pg:equal colName="userIsvalid" value="1"><input type="text" name="userSex" value="有效" readonly="true"></pg:equal>
							<pg:equal colName="userIsvalid" value="0"><input type="text" name="userSex" value="无效" readonly="true"></pg:equal>
							</pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userIsvalid" value="******" readonly="true"></pg:equal>
				</td>
			</tr>
			<tr>
				<td height="25" class="detailtitle"><strong> 注册日期</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userRegdate" value="<pg:cell colName="userRegdate"  defaultValue=""  />" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userRegdate" value="******" readonly="true"></pg:equal>
				</td>
				<td height="25" class="detailtitle"><strong> 手机短号码</strong></td>
				<td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="shortMobile" value="<pg:cell colName="remark2"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="shortMobile" value="******" readonly="true"></pg:equal>
				</td>
			</tr>
				<tr>
		         <td height="25" class="detailtitle"><strong> 拼音</strong></td>
		    	 <td height="25">
							<pg:equal colName="remark3" value="否"><input type="text" name="userPinyin" value="<pg:cell colName="userPinyin"  defaultValue=""/>" readonly="true"></pg:equal>
							<pg:equal colName="remark3" value="是"><input type="text" name="userPinyin" value="******" readonly="true"></pg:equal>
				 </td>
				 
				  <td height="25" class="detailtitle"></td>
				  <td height="25">
				  </td>
			</tr>	
			<!--tr>
						<td height="25" class="detailtitle" colspan="4">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width='10%'>
						<input type="checkbox" name="remark3" <pg:equal colName="remark3" value="是">checked</pg:equal>>
						</td>
						<td width='150px'><font color="#CC0000">个人信息是否保密</font></td>
						</tr>
						</table>
						</td>    				
			 </tr-->				
				<input type="hidden" name="userId" value="<pg:cell colName="userId"  defaultValue=""/>" />				
		    </table>
			</pg:beaninfo>
			<p>&nbsp;</p>
		</form>

		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
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
<%@ include file="../sysMsg.jsp"%>
	</body>
</html>
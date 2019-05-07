<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%	
	String desc = (String)request.getParameter("pager.desc");
	String orgId = request.getParameter("orgId");
	if (orgId == null) {
		orgId = (String) request.getAttribute("orgId");
	}
	if (orgId == null) {
		orgId = "";
	}
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="sysmanager/orgmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../orgmanager/common.js" type="text/javascript"></script>
		<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");

function getUserInfo(e,userId)
{
	if (jsAccessControl.setBackColor(e))
	{
		//parent.userInfo.userInfo.action="../user/userManager.do?method=getUser"+"&userId="+userId;
		//parent.userInfo.userInfo.submit();	
		
	}
}

function selmail(){
	document.forms[0].action="createMail.do?method=createMailByUser";
	document.forms[0].submit();
}

function markUser(){
	document.forms[0].action="createMail.do?method=markUser";
	document.forms[0].submit();
}

function markAll(){
	document.forms[0].action="createMail.do?method=markAllUser";
	document.forms[0].submit();
}

function allmail(){
	document.forms[0].action="createMail.do?method=createMailByOrg";
	document.forms[0].submit();
}

</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
				<form name="userList" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%" class="thin" >
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><strong>�û��б�</strong></td>
         				</tr>
         				<tr >
         					<td height='30' colspan="3" valign='middle' align="center">�û����ͣ�<dict:select type="userType" name="userType" /></td>
           					<td height='30'valign='middle' align="center">  <input name="b1" value="��ʶѡ���û�" type="button"  onClick="markUser()" class="input"></td>
           					<td height='30'valign='middle' align="center">  <input name="b2" value="��ʶ�����û�" type="button"  onClick="markAll()" class="input"></td>
         				</tr>
         				<tr >
           					<td colspan="3" height='30'valign='middle' align="center">�����׺����<dict:select type="MailPostfix" name="mailPostfix" /></td>
           					<td height='30'valign='middle' align="center">  <input name="b1" value="����ѡ���û�" type="button"  onClick="selmail()" class="input"></td>
           					<td height='30'valign='middle' align="center">  <input name="b2" value="����������" type="button"  onClick="allmail()" class="input"></td>
         				</tr>
						<pg:listdata dataInfo="MailUserList" keyName="UserList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="15" scope="request" data="UserList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="10">
									<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','userIds')" width="10">
								</td>
								<td class="headercolor"  >�û�����	</td>
								<td class="headercolor"  >�û�ʵ��</td>
								
								<td class="headercolor"  >�û�����</td>
								<td class="headercolor"  >�����ַ</td>
								
							</tr>
							<pg:param name="orgId" />
							<pg:param name="userName" />
							<pg:param name="userRealname" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû���û�
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>								
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
									<td class="tablecells" nowrap="nowrap">
										<input type="checkBox" name="userIds" onClick="checkOne('checkBoxAll','userIds')" value="<pg:cell colName="userId" defaultValue=""/>" width="10">
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" >
									<%
										String userType = dataSet.getString(Integer.parseInt(rowid),"userType");
									%>
									<dict:itemName type="userType" itemValue="<%=userType%>" />
									
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="userEmail" defaultValue="��ʱû������" />
									</td>	
								</tr>
							</pg:list>
							
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=5 align='center'>
									<pg:index />
									<!-- 
									<input type="submit" value="ɾ��" class="input" onclick="javascript:dealRecord(1); return false;">
									-->
								</td>							
							</tr>
							
							<input name="queryString" value="<pg:querystring/>" type="hidden">
							<input name="orgId" value="<%=orgId%>" type="hidden">
						</pg:pager>

					</table>
				</form>
<%@ include file="../sysMsg.jsp"%>
			</body>
			<center>
</html>

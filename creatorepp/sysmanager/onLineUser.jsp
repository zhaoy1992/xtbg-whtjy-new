<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.LineUser"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl" %>

<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	if(!accesscontroler.checkAccess(request, response))
		return ;
	
	String curUserName = accesscontroler.getUserAccount();
	String curSessionId = session.getId();
	
	String userName = request.getParameter("userName")==null?"":request.getParameter("userName");
	
	boolean state = (accesscontroler.isAdmin() || accesscontroler.isOrgManager(accesscontroler.getUserAccount()));
%>
<html>
	<head>
		<title>��ǰ�����û��鿴</title>
		
		<link rel="stylesheet" type="text/css" href="css/windows.css">
		<link rel="stylesheet" type="text/css" href="css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="css/tab.winclassic.css">
<base target="_self">		
<script language="JavaScript" src="<%=request.getContextPath()%>../sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="include/pager.js" type="text/javascript"></script>
<script language="JavaScript">
function removeUser(delState){
	var state = false;
	var userAccounts = "";
	if(delState == "allUser"){
		if(confirm("��ȷ��ɾ��ȫ�������û���ɾ����ȫ�������û����˳�ϵͳ��"))
			state = true;	
	}
	if(delState == "selectUser"){
		
		var arr = document.getElementsByName("checkBoxOne");
		if(arr && arr.length >0){
			var isSelect = false;
			for(var n = 0 ; n < arr.length; n++){
				if(arr[n].checked){
					isSelect = true;
				}
			}
			
			if(!isSelect){
				alert("��ѡ��Ҫɾ���������û�!");
				return false;
			}
			if(confirm("��ȷ��ɾ����ѡ�����û���ɾ������ѡ�����û����˳�ϵͳ��"))
				state = true;
		}
	}
	if(delState == "allUserExcludeSelf"){
		if(confirm("��ȷ��ɾ�������û���ɾ���������û����˳�ϵͳ��"))
			state = true;
	}
	if(state){
		document.ListForm.target = "hiddenIframe";
		document.ListForm.action = "onLineUser_do.jsp?delState="+delState;
		document.ListForm.submit();
	}
}

function resetwindow()
{
	document.ListForm.action = window.location.href;	
	document.ListForm.target = "";
	
	document.ListForm.submit();
	
}

function queryUser(){
	document.ListForm.target = "hiddenIframe";
	document.ListForm.action = "onLineUser.jsp";
	resetwindow();
}

function selectUser(){
	var returnValue = window.showModalDialog('orgUserTree.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
	if(returnValue){
		document.all.userName.value = returnValue;
	}
}

//F1
function window.onhelp(){  
  selectUser();
  return false;
}

function enterKeydowngo(){ 
	if(window.event.keyCode == 13){
		queryUser();
	}
}

</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onunload="window.returnValue='ok';">
		<div id="contentborder" align="center">
			<form name="ListForm" action="" method="post">
				<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
				
					<tr valign='top'>
           					<td height='30'  valign='middle' colspan="9"><img src='images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�����û��б�</strong></td>
         			</tr>
					<tr>
					
					<td align="left" colspan="5">
					<%if(state){ %>
					�����û�����
					<input name="userName" value="<%=userName %>" onkeydown="enterKeydowngo()" type="text" ondblclick="selectUser()" title="˫����F1ѡ���û�" />
					<input name="sel" value="ѡ���û�" type="button" onclick="selectUser()" class="input">
					<%} %>
					</td>
					
					<td colspan="4">
					<%if(state){ %>
					<input name="quer" value="��ѯ" type="button" class="input" onclick="queryUser()" />
					<input value="����" type="button" class="input" onclick="document.all('userName').value='';"  />
					<%} %>
					<input name="sx" value="ˢ���û�" type="button" onclick="queryUser()" class="input" />
					</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.OnlineList" keyName="OnlineList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="20" scope="request" data="OnlineList" isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							
				    		<th height='20' class="headercolor">��ǰ�����û���½��</th>
				    		<th height='20' class="headercolor">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
							</th>
				    		<th height='20' class="headercolor">IP��ַ</th>
							<th height='20' class="headercolor">��½ʱ��</th>
							<th height='20' class="headercolor">�Ựid</th>
							<th height='20' class="headercolor">����mac��ַ</th>
							<th height='20' class="headercolor">��������</th>
							<th height='20' class="headercolor">������ip</th>
							<th height='20' class="headercolor">�������˿�</th>
							</tr>
						<pg:param name="userName" />
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû������
								</td>
							</tr>
						</pg:notify>

						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
						
							<% 
								LineUser lineUser = (LineUser)dataSet.getOrigineObject();
								int rowInt = lineUser.getContextSize();
								int i = 0;
							%>
								<pg:list colName="lineContexts" declare="false">
								<% 
									String sessionId = dataSet.getString("sessionId");
									String username = dataSet.getString("userName");
									String userRealName = new UserManagerImpl().getUserByName(username).getUserRealname();
									if(curSessionId.equals(sessionId)){
								%>
								<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<%if(rowInt != 1 && i == 0){ %>
								<td rowspan="<%=rowInt %>"  align="center" class="tablecells"><pg:cell colName="userName" defaultValue="" />(<%=userRealName %>)</td>
								<%
									i ++;
								  } 
								%>
								<%if(rowInt == 1) {%>
								<td height='20' align="center" class="tablecells">
									<font color="#0000FF"><pg:cell colName="userName" defaultValue="" />(<%=userRealName %>)</font>
								</td>
								<%} %>
									<td height='20' align=center class="tablecells">
										<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" disabled 
										value='<pg:cell colName="userName" defaultValue="" />$<pg:cell colName="sessionId" defaultValue="" />$<pg:cell colName="ipaddress" defaultValue="" />$<pg:cell colName="macaddr" defaultValue="" />'
										
										 >
										 
									</td>
									
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="ipaddress" defaultValue="" /></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="loginTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="sessionId" defaultValue="" /></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="macaddr" defaultValue="" /></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="DNSName" defaultValue="" /></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="serverIp" defaultValue="" /></font>
									</td>
									<td height='20' align="center" class="tablecells">
										<font color="#0000FF"><pg:cell colName="serverport" defaultValue="" /></font>
									</td>
								
								<%	
									}else{
								%>
								<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<%if(rowInt != 1 && i == 0){ %>
								<td rowspan="<%=rowInt %>" align="center" class="tablecells"><pg:cell colName="userName" defaultValue="" />(<%=userRealName %>)</td>
								<%
									i ++;
								  } 
								%>
									<%if(rowInt == 1){ %>
									<td height='20' align="center" class="tablecells"><pg:cell colName="userName" defaultValue="" />(<%=userRealName %>)</td>
									<%} %>
									<td height='20' align=center class="tablecells">
										<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="userName" defaultValue="" />$<pg:cell colName="sessionId" defaultValue="" />$<pg:cell colName="ipaddress" defaultValue="" />$<pg:cell colName="macaddr" defaultValue="" />' >
										<input type="hidden" name="userAccounts" value='<pg:cell colName="userName" defaultValue="" />' />
									</td>
									
									<td height='20' align="center" class="tablecells"><pg:cell colName="ipaddress" defaultValue="" /></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="loginTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="sessionId" defaultValue="" /></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="macaddr" defaultValue="" /></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="DNSName" defaultValue="" /></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="serverIp" defaultValue="" /></td>
									<td height='20' align="center" class="tablecells"><pg:cell colName="serverport" defaultValue="" /></td>
	
								<% 
									}
								%>	
								</pg:list>								
							</tr>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='center'>
								ÿҳ��ʾ20���û�&nbsp;&nbsp;&nbsp;�������û�<pg:rowcount/>���ˣ�&nbsp;&nbsp;&nbsp;<pg:index />
							</td>
						</tr>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan="9" align='right'>
								<input name="del" value="ɾ��" type="button" onclick="removeUser('selectUser');" class="input" />
								<% 
									if(accesscontroler.isAdmin()){
								%>
								<input name="delall" value="ɾ��ȫ��" type="button" onclick="removeUser('allUser');" class="input" />
							 	<input name="delAllExcludeSelf" value="ɾ��ȫ�������Լ�" type="button" onclick="removeUser('allUserExcludeSelf');" class="input" />
							 	<% 
							 		}
							 	%>
							 	<input name="col" value="�ر�ҳ��" type="button" onclick="window.close();window.returnValue='ok';" class="input" />
							 	
							</td>
						</tr>
					</pg:pager>
				</table>
			</form>
			<iframe name="hiddenIframe" height="0" width="0"></iframe>
		</body>
</html>

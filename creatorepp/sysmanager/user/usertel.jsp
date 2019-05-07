
<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "true";
	}
	Integer currUserId = (Integer)session.getAttribute("currUserId");
	if(currUserId == null){
		currUserId = Integer.valueOf("-1");
	}
	String desc = (String)request.getParameter("pager.desc");
	String curOrgId = (String)session.getAttribute("orgId");
	String ischecked="";
	if((String)request.getAttribute("ischecked")==null){
		ischecked ="";
	}else{
		ischecked =(String)request.getAttribute("ischecked");
	}
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		
<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
var reFlush = "<%=reFlush%>";

function getUserInfo(e,userId)
{
	if (jsAccessControl.setBackColor(e))
	{
	//	getPropertiesToolbar().location.href="properties_toolbar.jsp?userId="+userId+"&orgId=<%=curOrgId%>";
	}
}


	
function sortBy(byName){
	var desc = "false";

	if ( "<%=desc%>"  == desc ) desc = "true";
	userList.action="../user/userList.jsp?orgId=<%=curOrgId%>&pager.offset=0&pager.sortKey="+byName+"&pager.desc="+desc;
	userList.submit();
}
	
function actionOnmouseover(e){	
	e.style.backgroundColor = "#8080FF";
}

function actionOnmouseup(e){
	e.style.backgroundColor = "#BEC0C2";
}

function queryUser()
{	
	userList.action="../user/usertel.jsp"
	userList.submit();	
}
function advQueryUser()
{	
	history.back();	
}


</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
				<form name="userList" method="post" >
				<input type="hidden" name="orgId" value="<%=curOrgId%>"/>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="7"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�绰��</strong></td>
         				</tr>
         			
         				
         				<tr >
           				    <td colspan="2" height='30'valign='middle' align="center">�û���½���ƣ�<input type="text" name="userName" ></td>
           					<td colspan="2" height='30'valign='middle' align="center">�û�ʵ����<input type="text" name="userRealname" ></td>
           					
           					<td colspan="3" height='30'valign='middle' align="center">
           					<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">
           					</td>
         				</tr>
         				<pg:listdata dataInfo="TelListSn" keyName="TelListSn" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="18" scope="request" data="TelListSn" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" onclick="sortBy('userName')" width="15%">�û���½����</td>
								<td class="headercolor" onclick="sortBy('userName')" width="15%">�û�ʵ��</td>
								<td class="headercolor" onclick="sortBy('userName')" width="15%">�칫�绰</td>
								<td class="headercolor" onclick="sortBy('userName')" width="15%">��ͥ�绰</td>								
								<td class="headercolor" onclick="sortBy('userName')" width="15%">�ֻ�����</td>
								<td class="headercolor" onclick="sortBy('userName')" width="15%">С��ͨ</td>								
								<td class="headercolor" onclick="sortBy('userName')" width="10%">Email</td>
								</tr>
							<pg:param name="orgId" />
							<pg:param name="userName" />
							<pg:param name="userRealname" />
							<pg:param name="intervalType" />
						
							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû�м�¼
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" >
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:equal colName="remark3" value="��">
											******
										</pg:equal>
										<pg:notequal colName="remark3" value="��">
											<pg:cell colName="userWorktel" defaultValue="" />
										</pg:notequal>
									</td>
									<td class="tablecells" nowrap="nowrap">
									    <pg:equal colName="remark3" value="��">
											******
										</pg:equal>
										<pg:notequal colName="remark3" value="��">
											<pg:cell colName="userHometel" defaultValue="" />
										</pg:notequal>
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:equal colName="remark3" value="��">
											******
										</pg:equal>
										<pg:notequal colName="remark3" value="��">
											<pg:cell colName="userMobiletel1" defaultValue="" />
										</pg:notequal>										
									</td>
									<td class="tablecells" nowrap="nowrap">
									    <pg:equal colName="remark3" value="��">
											******
										</pg:equal>
										<pg:notequal colName="remark3" value="��">
											<pg:cell colName="userMobiletel2" defaultValue="" />
										</pg:notequal>
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:equal colName="remark3" value="��">
											******
										</pg:equal>
										<pg:notequal colName="remark3" value="��">
											<pg:cell colName="userEmail" defaultValue="" />
										</pg:notequal>
									</td>		
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=7 align='center'>
								 ÿҳ18����¼	��<pg:rowcount/>����¼ <pg:index />
								</td>
								
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

				  </table>
				</form>
</body>
<center>
</html>

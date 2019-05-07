<%
/*
 * <p>Title: �û�����Ϣҳ��</p>
 * <p>Description: ��ʾ�û�����Ϣ���ѯ</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
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
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	

	
	String groupName = request.getParameter("groupName");
	String groupDesc = request.getParameter("groupDesc");
	String groupOwnerName = request.getParameter("groupOwnerName");

	
	groupName = groupName == null ? "" : groupName ;
	groupDesc = groupDesc == null ? "" : groupDesc ;
	groupOwnerName = groupOwnerName == null ? "" : groupOwnerName ;
%>
<html>
	<head>
		<title>��������</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<script language="javascript">
			function validateInfo()
			{
				groupForm.action = "groupInfo.jsp";
				groupForm.submit();
			}
			
			function clearInfo()
			{
				document.getElementById("groupName").value = '';
				document.getElementById("groupDesc").value = '';
				document.groupForm.groupOwnerName.value="";
			}
		</script>
		
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.GroupSearchList" keyName="GroupSearchList" />
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10" scope="request" data="GroupSearchList" isList="false">
		
		<%@ include file="/epp/css/cssControl.jsp"%><body >	
			<div id="contentborder" align="center">		
				<form name="groupForm" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr valign='top'>
		   					<td height='30'valign='middle' colspan="4" nowrap>
		   						<strong>�û����б�
									<div align="right">���û�����Ϊ��
										<pg:rowcount/>
									</div>
		       					</strong>	
		   					</td>
		 				</tr>
						<tr height=30>
							<td width="25%" align="center" nowrap>
								�û�������: <input type="text" name="groupName" value="<%=groupName%>" >
							</td>
							<td width="25%" align="center" nowrap>
								�û�������: <input type="text" name="groupDesc" value="<%=groupDesc%>" >
							</td>
							<td width="25%" align="center" nowrap>
								������: <input type="text" name="groupOwnerName" value="<%=groupOwnerName%>" >
							</td>
						</tr>
						<tr>
						<td width="25%" colspan="99" align="right" nowrap>
								<input type="button"  value="��ѯ"  onclick="validateInfo()" class="input">
								<input type="button"  value="���" onclick="clearInfo()" class="input">
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				<table width="100%" cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
				
						<pg:param name="groupName"/>
						<pg:param name="groupDesc"/>
						
						<tr class="labeltable_middle_td" 
							onmouseover="this.className='mouseover'"
							onmouseout="this.className= 'mouseout'" >
							<!--���÷�ҳ��ͷ-->
							<td height='30' bgcolor="#EDEFF6" class="headercolor" width="40%">
								�û�������
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								�û�������
							</td>
							<td height='30' bgcolor="#EDEFF6" class="headercolor">
								�û��鴴����
							</td>
						</tr>
						<pg:param name="groupName" />
						<pg:param name="groupDesc" />
						<pg:param name="groupOwnerName" />
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû���û���
								</td>
							</tr>
						</pg:notify>
						
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<% 
							//ֻ��ʾ����û��������û��� 2008-4-8 baowen.liu
	                          //     String  userId=accesscontroler.getUserID();						
								String data = (String)dataSet.getString("owner_id");
								UserManager userManager=new UserManagerImpl();
								User user=userManager.getUserById(data);
								String userName=user.getUserName();
								String userRealName=user.getUserRealname();
							  //  if(userId.equals(data)){
							%>
							<tr class="labeltable_middle_td"  
								onmouseover="this.className='mouseover'"
								onmouseout="this.className= 'mouseout'">
								<td height='20' align=left class="tablecells">
										<pg:cell colName="groupName" defaultValue="û������"/>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="groupDesc" defaultValue="û������" />
								</td>
								<td height='20' align=left class="tablecells">
									<%=userName%>��<%=userRealName%>��
								</td>
							</tr>
							<%
							// }
							%>
						</pg:list>
						<tr height="30px">
							<td class="detailcontent" colspan=4 align='center'>
								��<pg:rowcount />����¼<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
				</table>
			</form>
		</div>
	</body>
	</pg:pager>
</html>
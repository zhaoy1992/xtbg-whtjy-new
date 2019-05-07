<%
/*
 * <p>Title: �û���ѯҳ��</p>
 * <p>Description: �û���ѯҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil" %>
<%@ page import="com.chinacreator.config.ConfigManager" %>


<%
 			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkManagerAccess(request,response);
	        
	        String userId = accesscontroler.getUserID();
	        DBUtil db = new DBUtil();
	        
		    db.executeSelect("select 1 from td_sm_user");
		    
		    String usercount = String.valueOf(db.size());
		    
		    String userOrgType = (String)request.getParameter("userOrgType");
		    String userName = (String)request.getParameter("userName");
		    String userRealname = (String)request.getParameter("userRealname");
		    
		    if(userOrgType == null)
		    {
		    	userOrgType = "";
		    }
		    if(userName == null)
		    {
		    	userName = "";
		    }
		    if(userRealname == null)
		    {
		    	userRealname = "";
		    }
%>

<html >
	<head>				
		<tab:tabConfig/>
			<title>��������</title>
			<link rel="stylesheet" type="text/css" href="../../css/windows.css">
			<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
			<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
			<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
			<SCRIPT language="javascript">	
				function actionOnmouseover(e)
				{	
					e.style.backgroundColor = "#8080FF";
				}
			
				function actionOnmouseup(e)
				{
					e.style.backgroundColor = "#BEC0C2";
				}
			
			
				function queryUser()
				{	
					var userOrgType = document.all("userOrgType").value;
					userList.action="../user/userquery_content_tab.jsp?userOrgType="+userOrgType+"&userId=<%=userId%>";
					userList.submit();	
				}
				
				function queryUserInfo()
				{
					var userOrgType = document.all("userOrgType").value;
					var userName = document.all("userName").value;
					var userRealname = document.all("userRealname").value;
					var url = "../user/ireport/queryUser_info.jsp?userOrgType="+userOrgType+"&userName="+userName+"&userRealname="+userRealname;
					window.showModalDialog(url,window,"dialogWidth:"+(620)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
				}
				
				function clearQueryInfo()
				{
					userList.userName.value = '';
					userList.userRealname.value = '';
				}
		</SCRIPT>	
	</head>
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserSearchList" keyName="UserSearchList" />
	<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
	<pg:pager maxPageItems="15" id="UserSearchList" scope="request" data="UserSearchList" isList="false">
	
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="userList" method="post" onkeydown="if(event.keyCode==13)queryUser();">
			<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
				<input type="hidden" name="userOrgType" value="hasMainOrg" />
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="3" nowrap>
   						<strong>�û��б�
							<div align="right">���û���Ϊ��<!-- <%=usercount%> -->
								<pg:rowcount/>
							</div>
       					</strong>	
   					</td>
 				</tr>
 				<tr >           		
					<td width="40%" align="center">
						�û���½���ƣ�<input type="text" name="userName" value="<%=userName%>">
					</td>
					<td width="30%">
						�û�ʵ����<input type="text" name="userRealname" value="<%=userRealname%>">
					</td>
					<td width="30%" align="center">
						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">&nbsp;&nbsp;
						<input name="clearInfo" type="button" class="input" value="���" onclick="clearQueryInfo()">&nbsp;&nbsp;   
						<%--<input name="mimeograph" type="button" class="input" value="��ӡ" onClick="queryUserInfo()">--%>
					</td>
 				</tr>
 			</table>
     			<hr width=100%>
				<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
					<tr>
						<!--���÷�ҳ��ͷ-->								
						<td height='30' width="20%" class="headercolor"  >�û���½����	</td>
						<td height='30' width="20%" class="headercolor"  >�û�ʵ��</td>
						<td height='30' width="*" class="headercolor"  >���ڻ���</td>
						<td height='30' width="17%" class="headercolor"  >�ֻ�����</td>
					</tr>
						
					<pg:param name="orgId"/>
					<pg:param name="userName"/>
					<pg:param name="userRealname"/>
					<pg:param name="advQuery" />
					<pg:param name="userId" />
					<pg:param name="job_name"/>	
					<pg:param name="userOrgType"/>						
						
                      
					<!--��⵱ǰҳ���Ƿ��м�¼-->
					<pg:notify>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height='20'>
								��ʱû���û�
							</td>
						</tr>
					</pg:notify>

					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
							<td height='20' class="tablecells" nowrap="nowrap">
								<pg:cell colName="userName" defaultValue="" />
								<pg:null colName="userName">�û���¼����Ϊ��</pg:null>
								<pg:equal colName="userName" value="">�û���¼����Ϊ��</pg:equal>
							</td>
							<td height='20' class="tablecells" nowrap="nowrap">
								<pg:cell colName="userRealname" defaultValue="" />
								<pg:null colName="userRealname">�û�ʵ��Ϊ��</pg:null>
								<pg:equal colName="userRealname" value="">�û�ʵ��Ϊ��</pg:equal>
							</td>	
							<td height='20' class="tablecells" >
								<pg:cell colName="orgName" defaultValue="" />
								<pg:null colName="orgName">���ڻ���Ϊ��</pg:null>
								<pg:equal colName="orgName" value="">���ڻ���Ϊ��</pg:equal>
							</td>
							<td height='20' class="tablecells" nowrap="nowrap" >
								<pg:notnull colName="userMobiletel1"><pg:cell colName="userMobiletel1" defaultValue=" "/></pg:notnull>
								<pg:null colName="userMobiletel1">����Ϊ��</pg:null>
								<pg:equal colName="userMobiletel1" value="">����Ϊ��</pg:equal>
							</td>		
						</tr>
					</pg:list>
					
					<tr height="30px" class="labeltable_middle_tr_01">
						<td colspan=5 align='center'>
							��<pg:rowcount/>����¼  <pg:index />
						</td>
					</tr>
				<input name="queryString" value="<pg:querystring/>" type="hidden">
			 </table>
		</form>
	</body>
	</pg:pager>
</html>
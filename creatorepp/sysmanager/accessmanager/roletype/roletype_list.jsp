
<%@page import="com.chinacreator.sysmgrcore.manager.OrgAdministrator"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%><%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil" %>
<%
 			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkManagerAccess(request,response);
	        String curUserId = accesscontroler.getUserID();	
	        String curOrgId = accesscontroler.getChargeOrgId();
	        String roletype = ""; 
			roletype = request.getParameter("roletype");
			if(roletype == null)
			{
				roletype = "";
			}        
			OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
			List list = orgAdministrator.getManagerOrgsOfUserByID(curUserId);
			boolean isAdminOrOrgManager = false;//��ǰ��½�û��Ƿ���в��Ź���Ա��ɫ���߳�������Ա��ɫ
			if(list.size() > 0 || accesscontroler.isAdmin()){//�ж��Ƿ��ǲ��Ź���Ա��ӵ�г�������Ա��ɫ
		      	  isAdminOrOrgManager = true;
			}  
			
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			UserManager userManager = SecurityDatabase.getUserManager(); 
			
			boolean isAdmin = accesscontroler.isAdmin();
%>

<html >
<head>				
	<tab:tabConfig/>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		
	<script language="JavaScript" src="common.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
	<script language="JavaScript" src="func.js" type="text/javascript"></script>
	<SCRIPT language="javascript">
	function queryRoleType()
	{
		searchForm.action='roletype_list.jsp';
		searchForm.submit();
	}
	function newRoleType()
	{
		var url = "roletype_add.jsp";
		window.showModalDialog(url,window,"dialogWidth:"+(500)+"px;dialogHeight:"+(440)+"px;help:no;scroll:auto;status:no");
	}
	
	function delRoleType()
	{
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++)
		{
			if(all[i].checked == true)
			{
				if(all[i].value==1)
				{
					alert("ͨ�ý�ɫ���Ͳ��ܱ�ɾ����");
					return false;			
				}
				docidStr = docidStr + all[i].value + ";";
			}
		}
		if(haveSelect('ID'))
		{		
			if(confirm('��ȷ��Ҫɾ����ѡ�Ľ�ɫ����?ɾ��ǰ��Ը������µĽ�ɫ���д���'))
			{
			RoleTypeList.action="roletype_delete.jsp?roletype_id=" + docidStr;
		    RoleTypeList.target="";
			RoleTypeList.submit();			
			}
			else
			{
			  return false;
			}
		
		}else{
	    	alert("��ѡ��Ҫ��ɾ���ļ�¼��");
	    	return false;
	   	}	
    }	
	</SCRIPT>	
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<%if(isAdminOrOrgManager){ %>
	<form name='searchForm' method='post'>
		<table cellspacing="1" cellpadding="0" border="0" width="100%" class="thin">
        	<tr valign='top'>
           		<td height='30'valign='middle' colspan="6"><img src='../../images/edit.gif' width="16" height="16" border=0 align='middle'>&nbsp;<strong>��ɫ�����б�</strong></td>
         	</tr>
         				<tr >           					
           					<td height="30" colspan="5" align="left">
	           					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ɫ���ͣ�<input type="text" name="roletype" value="<%=roletype%>">
           					</td>         					
           					<td height='30' valign='middle' align="center">
           						<input name="search" type="button" class="input" value="��ѯ" onClick='queryRoleType()'>           						          						
           					</td>
           					</tr>
    </form>     				
         <form name="RoleTypeList" method="post" >
						<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.RoleTypeList" keyName="RoleTypeList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="15" id="RoleTypeList" scope="request" data="RoleTypeList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="3%">
								<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','ID')">							
								</td>
								<td height='30' width="25%" class="headercolor"  >��ɫ��������</td>
								<td height='30' width="*" class="headercolor" colspan="2" >��ɫ��������</td>	
								<td height='30' width="*" class="headercolor" >������������</td>		
								<td height='30' width="*" class="headercolor" >���ʹ�����</td>						
							</tr>                       
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
							<% 
								String orgId = dataSet.getString("creatorOrgId");
								String userId = dataSet.getString("creatorUserId");
							%>
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
									<td class="tablecells" nowrap="true">
										<P align="left">
											<input type="checkbox" name="ID" onclick="checkOne('checkBoxAll','ID')" value='<pg:cell colName="roleTypeID" defaultValue=""/>' 
											<%
												if(!isAdmin && !orgId.equals(curOrgId)){
													out.print(" disabled ");
												} 
											%>
											>						
										</P>
									</td>
									<td height='20' class="tablecells" nowrap="nowrap">
										<pg:cell colName="typeName" defaultValue="" />
									</td>		
									<td height='20' class="tablecells" nowrap="nowrap" colspan="2" >
										<pg:cell colName="typeDesc" defaultValue="" />
									</td>		
									<td height='20' class="tablecells" nowrap="nowrap" >
										<% 
											if(orgManager.getOrgById(orgId) != null){
												out.print(orgId + " " + orgManager.getOrgById(orgId).getRemark5());
											}else{
												out.print("δ֪");
											}
										%>
									</td>		
									<td height='20' class="tablecells" nowrap="nowrap" >
										<% 
											if(userManager.getUserById(userId) != null){
												out.print(userManager.getUserById(userId).getUserName() + "(" + userManager.getUserById(userId).getUserRealname() + ")");
											}else{
												out.print("δ֪");
											}
										%>
									</td>							
								
										
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan="4" align='center'>
									ÿҳ15����¼	��<pg:rowcount/>����¼  <pg:index />
								</td>
								<td colspan="2" align='center'>													
								<input name="newroletype" type="button" class="input" value="����" onClick="newRoleType()">
								<input type="submit" value="ɾ��" class="input" onclick="javascript:delRoleType(); return false;">			
								</td>										
							</tr>
						</pg:pager>

				  </table>
				</form>
				<%}else{ %>
				<div align="center">û��Ȩ�ޣ�����ϵͳ����Ա��ϵ</div>
				<%} %>
</body>
</html>

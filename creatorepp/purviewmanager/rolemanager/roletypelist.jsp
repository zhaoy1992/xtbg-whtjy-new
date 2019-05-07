
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%><%
/**
 * <p>Title: ��ʾ��ɫ�����б�ҳ��</p>
 * <p>Description:��ʾ��ɫ�����б�ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%
 			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkManagerAccess(request,response);
	        //String userId = accesscontroler.getUserID();	
	        String typeName = ""; 
			typeName = request.getParameter("typeName");
			if(typeName == null)
			{
				typeName = "";
			} 
			String typeDesc = ""; 
			typeDesc = request.getParameter("typeDesc");
			if(typeDesc == null)
			{
				typeDesc = "";
			}     
			
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			UserManager userManager = SecurityDatabase.getUserManager();  
			
			boolean isAdmin = accesscontroler.isAdmin();
			String curOrgId = accesscontroler.getChargeOrgId();
%>
<html >
<head>				
	<title>��ɫ���͹���</title>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	
	<script language="JavaScript" src="common.js" type="text/javascript"></script>
	
	<script language="JavaScript" src="../scripts/func.js" type="text/javascript"></script>
	<SCRIPT language="javascript">
	
	
	
	
    function roleTypeInfo(typeId)
    {
    	var url = "roletype_modify.jsp?typeId="+typeId;
		var winValue = window.showModalDialog(url,window,"dialogWidth:"+(500)+"px;dialogHeight:"+(440)+"px;help:no;scroll:auto;status:no");
		if(winValue)
		{
			var typeName = parent.document.all("typeName").value;
			var typeDesc = parent.document.all("typeDesc").value;
			parent.document.all("roletypelist").src = 'roletypelist.jsp';
		}
    }
	</SCRIPT>	
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >				
 <form name="RoleTypeList" method="post" >
 	<table cellspacing="1" cellpadding="0" border="0" width="100%" class="thin">
 		<input type=hidden name=typeName1 value='typeName1' />
		<input type=hidden name=typeDesc1 value='typeDesc1' />
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.RoleTypeList" keyName="RoleTypeList" />
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10" id="RoleTypeList" scope="request" data="RoleTypeList" isList="false">
			<tr>
				<!--���÷�ҳ��ͷ-->
				<td class="headercolor" width="3%">
				<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','ID')">							
				</td>
				<td height='30' width="37%" class="headercolor"  >��ɫ��������</td>
				<td height='30' width="*" class="headercolor" colspan="3" >��ɫ��������</td>		
				<td height='30' width="*" class="headercolor" colspan="1" >������������</td>
				<td height='30' width="*" class="headercolor" colspan="1" >���ʹ�����</td>							
			</tr>        
			<pg:param name="typeName" /> 
			<pg:param name="typeDesc" />              
			<!--��⵱ǰҳ���Ƿ��м�¼-->
			<pg:notify>
				<tr height="18px" class="labeltable_middle_tr_01">
					<td colspan=100 align='center' height='20'>
						��ʱû�н�ɫ����
					</td>
				</tr>
			</pg:notify>
			<%ContextMenu contextmenu = new ContextMenuImpl();%>
			<!--list��ǩѭ�����ÿ����¼-->
			<pg:list>
				<%
					String orgId = dataSet.getString("creatorOrgId");
					String userId = dataSet.getString("creatorUserId");
					String typeId = dataSet.getString("roleTypeID");
					Menu menu = new Menu();
					menu.setIdentity("oproletype_" + typeId);
					Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
					menuitem1.setName("������Ϣ");
					menuitem1.setLink("javascript:roleTypeInfo('" + typeId + "')");
					menuitem1.setIcon("../images/rightmenu_images/doc_fbyl.gif");
					menu.addContextMenuItem(menuitem1);
					contextmenu.addContextMenu(menu);
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
					<td id="oproletype_<%=typeId%>" height='20' class="tablecells" nowrap="nowrap" bgcolor="#F6FFEF">
						<pg:cell colName="typeName" defaultValue="" />
					</td>		
					<td height='20' class="tablecells" nowrap="nowrap" colspan="3" >
						<pg:cell colName="typeDesc" defaultValue="" />
					</td>
					<td height='20' class="tablecells" nowrap="nowrap" colspan="1" >
						<% 
							if(orgManager.getOrgById(orgId) != null){
								out.print(orgId + " " + orgManager.getOrgById(orgId).getRemark5());
							}else{
								out.print("δ֪");
							}
						%>
					</td>
					<td height='20' class="tablecells" nowrap="nowrap" colspan="1" >
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
				<td colspan="7" align='center'>
					��<pg:rowcount/>����¼  <pg:index />			
				</td>										
			</tr>
			<%request.setAttribute("oproletype", contextmenu);%>
			<pg:contextmenu enablecontextmenu="true" context="oproletype" scope="request" />
			</pg:pager>
  </table>
</form>
</body>
</html>

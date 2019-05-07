<%
/**
 * 
 * <p>Title: "��ɫ����"Ȩ������</p>
 *
 * <p>Description: "��ɫ����"Ȩ������ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.resource.ResourceManager,
				com.chinacreator.config.model.Operation"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    //��ǰ�û�ID
    String curUserId = accesscontroler.getUserID(); 
    String opId = "roleset";//��ɫ����
	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = request.getParameter("currOrgId");
	
	ResourceManager resManager = new ResourceManager();

	Operation operation = resManager.getOperation(resTypeId,"roleset");
	String description = operation==null?"":operation.getDescription();
	
	String roleName = ""; 
	roleName = request.getParameter("roleName");
	if(roleName == null)
	{
		roleName = "";
	}
	
%>
<html>
	<head>
		<title>��������</title>
		<script language="JavaScript" src="../../../sysmanager/user/common.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/treeview.css">
<script>
function queryUser()
{	
	userList.action="rolesetTree.jsp";
	userList.submit();	
}

function turnPageSumbmitSet(){
	document.userList.target = "hiddenFrame";
	var checkValues = "";
	var un_checkValues = "";
	var arr = document.getElementsByName("checkBoxOne");
	if(arr){
		for(var i = 0; i < arr.length; i++){
			if(arr[i].checked){
				if(checkValues==""){
					checkValues = arr[i].value;
				}else{
					checkValues += "," + arr[i].value;
				}
			}else{
				if(un_checkValues==""){
					un_checkValues = arr[i].value;
				}else{
					un_checkValues += "," + arr[i].value;
				}
			}
		}
	}
	document.userList.checkValues.value = checkValues;
	document.userList.un_checkValues.value = un_checkValues;
	return true;
}

function saveReadorgname(){
	document.userList.target = "hiddenFrame";
	var checkValues = "";
	var un_checkValues = "";
	var arr = document.getElementsByName("checkBoxOne");
	if(arr){
		for(var i = 0; i < arr.length; i++){
			if(arr[i].checked){
				if(checkValues==""){
					checkValues = arr[i].value;
				}else{
					checkValues += "," + arr[i].value;
				}
			}else{
				if(un_checkValues==""){
					un_checkValues = arr[i].value;
				}else{
					un_checkValues += "," + arr[i].value;
				}
			}
		}
	}
	document.userList.checkValues.value = checkValues;
	document.userList.un_checkValues.value = un_checkValues;
	document.userList.action = "saveRolesetTree.jsp";
	document.userList.submit();
}
	
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
	  <form name="userList" action="savePage.jsp" method="post" >
		<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
		<input name="checkValues" type="hidden" value="" />
		<input name="un_checkValues" type="hidden" value="" />
		<input name="resTypeId" type="hidden" value="<%=resTypeId%>" />
		<input name="currRoleId" type="hidden" value="<%=currRoleId%>" />
		<input name="role_type" type="hidden" value="<%=role_type%>" />
		<input name="currOrgId" type="hidden" value="<%=currOrgId%>" />
		<input name="opId" type="hidden" value="<%=opId%>" />
			<tr valign='top'>
				<td height='30'valign='middle' colspan="5"><img src='../../../sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��ɫ�б�---</strong>
				<%=description%>
				</td>
			</tr>
			<tr >
           					
           					<td colspan=2 height='30'valign='middle' align="center">��ɫ���ƣ�<input type="text" name="roleName" value="<%=roleName%>"></td>
           					
           					<td height='30'valign='middle' align=left>
           						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">           						
           						<input name="sx" type="button" class="input" value="ˢ��" onClick="parent.window.location.href = parent.window.location.href;">
           					</td>
         				</tr>
						<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleSearchList" keyName="RoleSearchList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager form="userList" 
							maxPageItems="12" 
							scope="request" 
							promotion="true" 
							commitevent="turnPageSumbmitSet()" 
							data="RoleSearchList" 
							isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="6%">
								<P align="left">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
								</td>
								<td height='30' class="headercolor" width="20%">��ɫ����</td>
								<td height='30' class="headercolor" width="20%">��ɫ����</td>
								<td height='30' class="headercolor" width="20%">��ɫ����</td>
								<td height='30' class="headercolor" width="30%">��Դ��Դ</td>							
							</tr>
							<pg:param name="roleId" />
							<pg:param name="roleName" />
							<pg:param name="resTypeId" />
							<pg:param name="currRoleId" />
							<pg:param name="role_type" />
							<pg:param name="currOrgId" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû�н�ɫ
									</td>
								</tr>
							</pg:notify>
							
							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
							
							
								<tr
								<%
								  String resName = dataSet.getString("roleName");
								  String resId = dataSet.getString("roleId");
								  String ownerId = String.valueOf(dataSet.getInt("owner_id"));
								  String noCheck = "";
								  boolean isRoleSet = curUserId.equals(ownerId) || accesscontroler.checkPermission(resId,"roleset",AccessControl.ROLE_RESOURCE);
							      if((!isRoleSet&&!accesscontroler.isAdmin()) || "1".equals(resId) || "2".equals(resId) || "3".equals(resId) || "4".equals(resId)){
							      	out.print(" disabled=\"true\"");
							      	noCheck = "noCheck";
							      }
							      String returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(currOrgId,currRoleId,resName,resTypeId,resId,opId);
							      
								%>
								>
									<td class="tablecells" nowrap="true" width="6%">
										<P align="left">
											<font color="#0000FF">
												<INPUT type="checkbox" name="checkBoxOne<%=noCheck %>" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="roleId" defaultValue=""/>#<pg:cell colName="roleName" defaultValue=""/>'
												<% 
													if(AccessControl.hasGrantedRole(currRoleId,role_type,resId,resTypeId)){
														out.println("checked");
													}
													String returnStrResouce = "";
										            if(role_type.equals("user")){
										                returnStrResouce = accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(currRoleId,currRoleId,resName,resTypeId,resId,opId);
										                if(returnStr.equals("1")){
										                    out.println(" disabled=\"true\" checked ");
										                }
										            }
												%>
												 >
											</font>
										</P>
									</td>
									<td class="tablecells" width="20%" >
										<pg:cell colName="roleName" defaultValue="" />
									</td>
									<td class="tablecells"  width="20%" >
										<pg:cell colName="roleDesc" defaultValue="" />
									</td>
									<td class="tablecells"  width="20%" >
										<pg:cell colName="roleType" defaultValue="" />
									</td>
									<td class="tablecells"  width="30%" >
										<%=returnStrResouce %>
									</td>
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan="5" align='center'>
								��<pg:rowcount/>����¼	<pg:index />
								</td>
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>
						<tr>
						<td colspan="5" align="center">
						<input name="saveButton" value="����" type="button" onclick="saveReadorgname()" class="input" />
						<input name="col" value="�ر�ҳ��" type="button" onclick="parent.window.close();" class="input" />
						</td>
						</tr>
				  </table>
				  <iframe height="0" width="0" name="hiddenFrame"></iframe>
				  </form>
	</body>
</html>

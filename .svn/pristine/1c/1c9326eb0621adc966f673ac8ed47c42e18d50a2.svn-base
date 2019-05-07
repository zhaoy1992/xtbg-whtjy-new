<%
/**
 * 
 * <p>Title: "岗位授予"权限设置</p>
 *
 * <p>Description: "岗位授予"权限设置页面</p>
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
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>				
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    
    //当前用户ID
    String curUserId = accesscontroler.getUserID(); 
    String opId = "jobset";//岗位设置
	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = request.getParameter("currOrgId");
	String isBatch = request.getParameter("isBatch");
	boolean isResPath = (role_type.equals("user") && isBatch.equals("false"));
	
	ResourceManager resManager = new ResourceManager();
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	

	Operation operation = resManager.getOperation(resTypeId,"jobset");
	
	String description = operation== null ? "" : operation.getDescription();
	
	String jobName = ""; 
	jobName = request.getParameter("jobName");
	
	if(jobName == null)
	{
		jobName = "";
	}
	
%>
<html>
	<head>
		<title>属性容器</title>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<script>
function queryUser()
{	
	userList.action="jobsetList.jsp";
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
	if(arr)
	{
		for(var i = 0; i < arr.length; i++)
		{
			if(arr[i].checked)
			{
				if(checkValues=="")
				{
					checkValues = arr[i].value;
				}
				else
				{
					checkValues += "," + arr[i].value;
				}
			}
			else
			{
				if(un_checkValues=="")
				{
					un_checkValues = arr[i].value;
				}
				else
				{
					un_checkValues += "," + arr[i].value;
				}
			}
		}
	}
	
	
	document.userList.checkValues.value = checkValues;
	document.userList.un_checkValues.value = un_checkValues;
	
	//alert(checkValues);
	//alert(un_checkValues);
	
	var url = "saveTreeRoleresop_handle.jsp?resTypeId=<%=resTypeId%>&currRoleId=<%=currRoleId%>&role_type=<%=role_type%>&opId=jobset&currOrgId=<%=currOrgId%>&isBatch=<%=isBatch%>";
	document.userList.action = url ;
	
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
		<input name="isBatch" type="hidden" value="<%=isBatch%>" />
		<input name="opId" type="hidden" value="<%=opId%>" />
			<tr valign='top'>
				<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>
				岗位列表---用户拥有岗位的岗位授予权限就可以将岗位授予给其他用户和角色，用户自己创建的岗位默认拥有该权限</strong>
				
				</td>
			</tr>
			<tr >
           					
           					<td colspan=2 height='30'valign='middle' align="center">岗位名称：<input type="text" name="jobName" value="<%=jobName%>"></td>
           					
           					<td height='30'valign='middle' align=left>
           						<input name="search" type="button" class="input" value="查询" onClick="queryUser()"> 
           						<%if("false".equals(isBatch)){ %>          						
           						<!-- <input name="sx" type="button" class="input" value="刷新" onClick="parent.window.location.href = parent.window.location.href;"> -->
           						 <input name="sx" type="button" class="input" value="刷新" onClick="window.location.href = window.location.href;">
           						<%} %>
           						<input name="saveButton" value="保存" type="button" onclick="saveReadorgname()" class="input" />
           					</td>
         				</tr>
						<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.JobSearchList" keyName="JobSearchList" />
						<!--分页显示开始,分页标签初始化 promotion="true"  commitevent="turnPageSumbmitSet()" form="userList"  -->
						<pg:pager 
							maxPageItems="12" 
							scope="request" 
							
							data="JobSearchList" 
							isList="false">
							<tr>
								<!--设置分页表头-->
								<td class="headercolor" width="6%">
								<P align="left">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
								</td>
								<td height='20' class="headercolor" width="20%">岗位名称</td>
								<td height='20' class="headercolor" width="20%">岗位编号</td>
								<td height='30' class="headercolor" width="20%">岗位等级</td>
								<%if(isResPath){ %>
									<td height='30' class="headercolor" width="30%">资源来源</td>
								<%} %>							
							</tr>
							<pg:param name="roleId" />
							<pg:param name="jobName" />
							<pg:param name="resTypeId" />
							<pg:param name="currRoleId" />
							<pg:param name="role_type" />
							<pg:param name="currOrgId" />
							<pg:param name="isBatch" />
							

							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										暂时没有岗位
									</td>
								</tr>
							</pg:notify>
							
							<!--list标签循环输出每条记录-->
							<pg:list>
							    <pg:notequal colName="jobId" value="1">
									<tr
									<%
									  String resName = dataSet.getString("jobName");
									  String resId = dataSet.getString("jobId");
									  String ownerId = String.valueOf(dataSet.getInt("owner_id"));
									  String noCheck = "";
									  boolean isJobSet = curUserId.equals(ownerId) || accesscontroler.checkPermission(resId,"jobset",AccessControl.JOB_RESOURCE);
								      if((!isJobSet
								      			&& !accesscontroler.isAdmin()) || "1".equals(resId))
								      {
								      	out.print(" disabled=\"true\"");
								      	noCheck = "noCheck";
								      }
								      
								      
								      
									%>>
										<td class="tablecells" nowrap="true" width="6%">
											<P align="left">
												<font color="#0000FF">
													<INPUT type="checkbox" name="checkBoxOne<%=noCheck %>" 
															onclick="checkOne('checkBoxAll','checkBoxOne')" 
															value='<pg:cell colName="jobId" defaultValue=""/>#<%=resTypeId%>#<pg:cell colName="jobName" defaultValue=""/>'
													<% 
														if(isrolerelatedorg){
															if(roleManager.hasGrantRole(currRoleId,role_type,resId,resTypeId,currOrgId)){
																out.println("checked");
															}
														}else{
															if(AccessControl.hasGrantedRole(currRoleId,role_type,resId,resTypeId))
															{
																out.println("checked");
															}
														}
														String returnStrResouce = "";
											            if(isResPath)
											            {
											            	String returnStr = 
								      							accesscontroler.getUserRes_jobRoleandRoleandSelf(currOrgId,currRoleId,resName,resTypeId,resId,opId);
											                returnStrResouce = 
											                	accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(currRoleId,currRoleId,resName,resTypeId,resId,opId);
											                	
											                if(returnStr.equals("1"))
											                {
											                    out.println(" disabled=\"true\" checked ");
											                }
											            }
													%>
													 >
												</font>
											</P>
										</td>
										<td class="tablecells"  width="20%" >
											<pg:cell colName="jobName" defaultValue="" />
										</td>
										<td class="tablecells" width="20%" >
											<pg:cell colName="jobNumber" defaultValue="" />
										</td>
										<td class="tablecells"  width="20%" >
											<pg:cell colName="jobRank" defaultValue="" />
										</td>
										<%if(isResPath){ %>
										<td class="tablecells"  width="30%" >
											<%=returnStrResouce %>
										</td>
										<%} %>
									</tr>
								</pg:notequal>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan="5" align='center'>
								共<pg:rowcount/>条记录	<pg:index />
								</td>
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>
						<tr>
						<td colspan="5" align="center">
						
						
						</td>
						</tr>
				  </table>
				  <iframe height="0" width="0" name="hiddenFrame"></iframe>
				  </form>
	</body>
</html>

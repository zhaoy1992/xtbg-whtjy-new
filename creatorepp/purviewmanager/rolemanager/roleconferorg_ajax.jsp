<%
/*
 * <p>Title: 角色隶属机构的操作页面</p>
 * <p>Description: 角色隶属机构的操作页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.sysmgrcore.manager.OrgManager,
				com.chinacreator.sysmgrcore.entity.Organization"%>

<%@ page import="com.chinacreator.sysmgrcore.entity.User,
				java.util.List,
				java.util.ArrayList"%>

<%@ page import="com.chinacreator.security.AccessControl"%>


<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);

			String roleId = (String) request.getParameter("roleId");
						
			String orgId = request.getParameter("orgId");

			if (orgId == null)
			{
				orgId = "0";
			}	
			OrgManager orgManager = SecurityDatabase.getOrgManager();

			List existOrg = null;//orgManager.getOrgListOfRole(roleId);// 该角色关联机构
			List allOrg = null;
			//List allOrgAfterCheck = new ArrayList();
			//List existOrgAfterCheck = new ArrayList();
			//得到所选机构与该机构直接子集机构
			StringBuffer allOrgSql = new StringBuffer()
				.append("select * from (select o.*,1 as com_level from td_sm_Organization o where o.org_Id='")
				.append(orgId).append("' ")
				.append(" union select o.*,2 as com_level from td_sm_Organization o where ")
				.append(" o.parent_Id='").append(orgId)
				.append("') dd order by com_level asc,org_sn asc");
			//得到所选机构与该机构直接子集机构已设置的机构
			StringBuffer existOrgSql = new StringBuffer()
				.append("select * from td_sm_organization where org_id in(")
				.append("select org_id from td_sm_orgrole where org_id in(")
				.append("select dd.org_id from (select o.*,1 as com_level from td_sm_Organization o where o.org_Id='")
				.append(orgId).append("' ")
				.append(" union select o.*,2 as com_level from td_sm_Organization o where ")
				.append(" o.parent_Id='").append(orgId)
				.append("') dd ) and role_id='")
				.append(roleId).append("')");
			existOrg = orgManager.getOrgListBySql(existOrgSql.toString());
			if("0".equals(orgId) && accesscontroler.isAdmin()){//orgId为零时，显示所有一级机构，只有拥有超级管理员角色的用户才能查看
				allOrg = orgManager.getOrgListBySql(allOrgSql.toString());				
			}else if(!"0".equals(orgId)){
				allOrg = orgManager.getOrgListBySql(allOrgSql.toString());
			}

			//增加权限判断，如果用户无权对机构设置角色，就不显示此机构
			/*
			if (allOrg != null) {
				for (int k = 0; k < allOrg.size(); k++) {
					Organization organization = (Organization) allOrg.get(k);
					if (organization != null) {
						if (accesscontroler.checkPermission(organization
								.getOrgId(), "orgroleset",
								AccessControl.ORGUNIT_RESOURCE)) {
							allOrgAfterCheck.add(organization);
						}
					}
				}
			}
			if (existOrg != null) {
				for (int k = 0; k < existOrg.size(); k++) {
					Organization organization = (Organization) existOrg.get(k);
					if (organization != null) {
						if (accesscontroler.checkPermission(organization
								.getOrgId(), "orgroleset",
								AccessControl.ORGUNIT_RESOURCE)) {
							existOrgAfterCheck.add(organization);
						}
					}
				}
			}
			*/
			request.setAttribute("existOrg", existOrg);
			request.setAttribute("allOrg", allOrg);

			%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<SCRIPT LANGUAGE="JavaScript"> 
			function addOrg()
			{	
			  var n=document.all("orgId").options.length-1;
			  var orgIds = "";
			  for(var i=0;i<document.all("allist").options.length;i++)
			  {
			    var op=document.all("allist").options[i];
			    if(op.selected)
			    {
			        addone(op.text,op.value,n);
			        if(orgIds =="") orgIds = orgIds + op.value;
			        else orgIds = orgIds + "," + op.value;
			    }
			  }
			  document.all.orgids.value = orgIds; 
		   	if(orgIds != "")
		    {
		    	//send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&orgId='+orgIds+'&tag=add');
		    	send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&tag=add');
		    }
			
		}
			
		function addone(name,value,n)
		{
		
		   for(var i=n;i>=0;i--)
		   {
				if(value==document.all("orgId").options[i].value)
				{
				  return;
				}
			}
		   var op=new Option(name,value);
		   document.all("orgId").add(op);
		}
			
		function deleteall()
		{
		 	var orgIds = "";
			for (var m=document.all("orgId").options.length-1;m>=0;m--)
			{
				if(orgIds =="") orgIds = orgIds + document.all("orgId").options[m].value;
		        else orgIds = orgIds + "," + document.all("orgId").options[m].value;
				
		   		document.all("orgId").options[m]=null
			}    
			document.all.orgids.value = orgIds; 
			 if(orgIds != "")
		    {
		    	send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&tag=delete');
		    	//send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&orgId='+orgIds+'&tag=delete');
		    }
		  
		}
	      
		function addall()
		{
			var n=document.all("orgId").options.length-1;
			var p=document.all("allist").options.length-1;	
			
			var orgIds = "";
					  
		    for(var i=0;i<document.all("allist").options.length;i++){
		        var op=document.all("allist").options[i];
		        addone(op.text,op.value,n);  
		        if(orgIds =="") orgIds = orgIds + op.value;
			    else orgIds = orgIds + "," + op.value;
		    }
		    document.all.orgids.value = orgIds; 
		    if(orgIds != "")
		    {
		    	send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&tag=add');
		    	//send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&orgId='+orgIds+'&tag=add');
		    }	  
		    
		   
		}
			
		function deleteorg()
		{ 
		 	var orgIds = "";		
		    for (var m=document.all("orgId").options.length-1;m>=0;m--)
		    {
			    if(document.all("orgId").options[m].selected)
			    {
		      	    var op = document.all("orgId").options[m]
		      	    if(orgIds =="") orgIds = orgIds + op.value;
			        else orgIds = orgIds + "," + op.value;
			        document.all("orgId").options[m]=null;
		        }
		    }
		    document.all.orgids.value = orgIds; 
			if(orgIds != "")
		    {
		    	//send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&orgId='+orgIds+'&tag=delete');
		    	send_request('saveRoleOrg.jsp?roleId='+<%=roleId%>+'&tag=delete');
		    }	
		}
			
	
		function send_request(url)
		{						
			document.all.divProcessing.style.display = "block";
			
			document.all("button1").disabled = true;
			document.all("button2").disabled = true;
			document.all("button3").disabled = true;
			document.all("button4").disabled = true;
			document.all("back").disabled = true;
			
			
			document.RoleOrgForm.action = url;
			document.RoleOrgForm.target = "hiddenFrame";
			document.RoleOrgForm.submit();
		}
	</SCRIPT>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder">
			<center>
				<form name="RoleOrgForm" action="" method="post">
				<input type="hidden" name="orgids" value=""/>
					<table width="100%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tabletop">
							<td width="45%" align="center">
								&nbsp;
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr class="tabletop">
							<td width="45%" align="center">
								可选机构
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								已授予机构
							</td>
						</tr>
						<tr class="tabletop">
							<td width="45%" align="center">
								&nbsp;
							</td>
							<td width="10%" align="center">
								&nbsp;
							</td>
							<td width="45%" align="center">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="right">
								<select name="allist" multiple style="width:100%" onDBLclick="addOrg()" size="18">
									<pg:list requestKey="allOrg">
										<option value="<pg:cell colName="orgId"/>">
											<pg:null colName="remark5">
												<pg:cell colName="orgName" />
											</pg:null>
											<pg:notnull colName="orgName">
												<pg:equal colName="remark5" value="">
													<pg:cell colName="orgName" />
												</pg:equal>
												<pg:notequal colName="remark5" value="">
													<pg:cell colName="remark5" />
												</pg:notequal>
											</pg:notnull>
										</option>
									</pg:list>
								</select>
							</td>

							<td align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center">
											<input name="button1" type="button" class="input" value="&gt;" onclick="addOrg()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td align="center">
											<input name="button4" type="button" class="input" value="&lt;" onclick="deleteorg()">
										</td>
									</tr>
									<tr>
										<td align="center">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
							<td>
								<select name="orgId" multiple style="width:100%" onDBLclick="deleteorg()" size="18">
									<pg:list requestKey="existOrg">

										<option value="<pg:cell colName="orgId"/>">
											<pg:null colName="remark5">
												<pg:cell colName="orgName" />
											</pg:null>
											<pg:notnull colName="remark5">
												<pg:equal colName="remark5" value="">
													<pg:cell colName="remark5" />
												</pg:equal>
												<pg:notequal colName="remark5" value="">
													<pg:cell colName="remark5" />
												</pg:notequal>
											</pg:notnull>
										</option>
									</pg:list>
								</select>

							</td>

						</tr>
						<tr class="tabletop">
							<td width="40%" align="center">
								&nbsp;
							</td>

						</tr>
						<tr>
							<td colspan="3" align="center">
								<input type="button" name="back" class="input" value="返回" onclick="window.close()"/>
							</td>
						</tr>
					</table>

					<input type="hidden" name="roleId" value="<%=roleId%>" />

				</form>
			</center>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150px;top:450px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

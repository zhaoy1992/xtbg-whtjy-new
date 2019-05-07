<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//String app_id = session.getAttribute("subsystem_id_nouse").toString();	
	String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>
<script type="text/javascript">
		function uf_ok(){
			var groups = groupTreeFrame.document.getElementsByName("groupid");
			var groupIds = "";
			var groupNames = "";		
			for(var i=0;i<groups.length;i++){
				if(groups[i].checked){			
					var arr = new Array();
					arr = groups[i].value.split(",");
					groupIds = groupIds + arr[0] + ",";
					groupNames = groupNames  + arr[1] + ",";	
				}
			}
			groupIds = groupIds.substring(0,groupIds.length-1);				
			groupNames = groupNames.substring(0,groupNames.length-1);		
			window.close();
			window.returnValue=groupIds+";"+groupNames;
        }
</script>
<html>
	<head>
		<title>用户组选择</title>
	</head>	
	<body class="contentbodymargin">
		<div align="center">
			<br />
			<iframe name="groupTreeFrame" height=85% width="100%"	src="groupTreeFrameSrc.jsp?showmode=<%=showmode %>" frameborder="0"></iframe>
			<br />
			<br />
			<div align="center">
				<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="left">
					     		<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
						    </div>
					    </td>
					    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					    <td>
							<div align="left">
						  		<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
						    </div>
					    </td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>

<%-- 
<%
/*
 * <p>Title: 用户组树页面</p>
 * <p>Description: 用户组树显示页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//String app_id = session.getAttribute("subsystem_id_nouse").toString();	
%>
<html>
	<head>
		<title>属性容器</title>
		<script src="/purviewmanager/scripts/func.js"></script>
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">
		<script type="text/javascript">
		function uf_ok(){
			var groups = document.getElementsByName("groupid");
			var groupIds = "";
			var groupNames = "";		
			for(var i=0;i<groups.length;i++){
				if(groups[i].checked){			
					var arr = new Array();
					arr = groups[i].value.split(",");
					groupIds = groupIds + arr[0] + ",";
					groupNames = groupNames  + arr[1] + ",";	
				}
			}
			groupIds = groupIds.substring(0,groupIds.length-1);				
			groupNames = groupNames.substring(0,groupNames.length-1);		
			window.close();
			window.returnValue=groupIds+";"+groupNames;
        }
		</script>
	<body class="contentbodymargin" scroll="no">
		<div>
			<center>
				<form name="OrgJobForm" action="" method="post">
					<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tr" height=30>
							<td class="td" align="center">
							用户组树
							</td>
						</tr>
					</table>
					<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1">
						<tr class="tr" align=left>
							<td class="td"><!-- mode="static" -->
								<tree:tree tree="group_role_tree" 
									node="group_role_tree.node" 
									imageFolder="/sysmanager/images/tree_images/" 
									collapse="true" 
									includeRootNode="true" 									
									target="groupinfo"
									mode="static-dynamic"
									>									
									
    			                    <tree:checkbox name="groupid"></tree:checkbox>
									
									<tree:treedata treetype="com.chinacreator.eform.systemManager.GroupAddTree" 
										scope="request" rootid="0" 
										rootName="用户组树" expandLevel="1" 
										showRootHref="false" 
										needObserver="false" />
								</tree:tree>
							</td>
						</tr>
					</table>
				</form>
				<div align="center">
			<table width="25%" border="0" align="right" cellpadding="0" cellspacing="0">
				<tr>
					<td><div align="left">
					     <input name="Submit" type="button" class="input" value="确定"
											onClick="uf_ok()">
						</div>
					</td>
					<td>
						<div align="left">
						  <input name="cancel" type="button" class="input" value="取消"
											onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
	</div>
			</center>
		</div>

	</body>
</html>
--%>
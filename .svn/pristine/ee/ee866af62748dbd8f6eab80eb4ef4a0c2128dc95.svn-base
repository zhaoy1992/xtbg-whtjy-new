
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="java.util.ArrayList,org.apache.commons.lang.StringUtils"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	if(!accesscontroler.checkAccess(request, response))
		return;
	String busids = StringUtils.defaultIfEmpty(request.getParameter("busids"),"");
	String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>

<script type="text/javascript">
<!--
function uf_ok(){
	var busid = document.getElementsByName("busid");
	var _id = "";
	var _name = "";		
	for(var i=0;i<busid.length;i++){
		if(busid[i].checked){			
			var arr = new Array();
			arr = busid[i].value.split(",");
			_id = _id + arr[0] + ",";
			_name = _name  + arr[1] + ",";	
		}
	}
	_id = _id.substring(0,_id.length-1);				
	_name = _name.substring(0,_name.length-1);		
	window.close();
	window.returnValue=_id+";"+_name;
}
//-->
</script>
<html>
	<head>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">
	
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">
	</head>
	<body class="contentbodymargin" scroll="auto">
		<div id="contentborder" align="left">
				<form name="OrgJobForm" action="" method="post">
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
						<tr>
							<td>
								<div align="center">
									业务类别选择
									&nbsp;&nbsp;	
								</div>
							</td>
						</tr>
					</table>
					<table >					
						<tr>
							<td>
							    <!-- dynamic="false" mode="static" -->				    		
					    		<tree:tree tree="app_bus_type_tree"
										node="app_bus_type_tree.node"
										imageFolder="/sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true"  mode="<%=showmode %>">
										<tree:param name="showmode" value="<%=showmode%>"></tree:param>
										<tree:param name="busids" value="<%=busids%>"></tree:param>										
										<tree:checkbox name="busid" recursive="true"/>
										<tree:treedata
											treetype="com.chinacreator.eform.systemManager.BusinessTypeTree"
											scope="request" rootid="0" rootName="业务类别" expandLevel="1"
											showRootHref="false" needObserver="false" />
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
		</div>
	</body>
</html>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.epp.xml.ParseXml,org.frameworkset.spi.BaseSPIManager"%>

<%
	ParseXml px = null;
	String app_id = session.getAttribute(Framework.SUBSYSTEM).toString();
	String moduleXmlName =  BaseSPIManager.getProperty("menu.folder") + "module.xml";
	if (app_id != null && !app_id.trim().equals("") && !app_id.trim().equals("module")) 
	{
		moduleXmlName =  BaseSPIManager.getProperty("menu.folder") + "module-" + app_id + ".xml";
	}
	px = new ParseXml(moduleXmlName);
	request.setAttribute("px", px);	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title></title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<script language="javascript">
			function action11(){
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/applymanager/applywork/properties_toolbar.jsp";   
			}
			
			function menuissue(obj){
				openWin('<%=request.getContextPath()%>/eppissue/menuissue/menuissuemain.jsp?issuetype='+obj,screen.availWidth-320,screen.availHeight-200);
			}						
</script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="left">
			<form name="applyform">			
				<table>
					<!-- <tr align="center"><td><a href="#" onclick="menuissue('exp');">模块导出</a>&nbsp;&nbsp;<a href="#" onclick="menuissue('imp');">模块导入</a></td></tr> -->
					<tr>
						<td>
							<tree:tree tree="eppModule_tree" node="eppModule_tree.node"
									imageFolder="../../sysmanager/images/tree_images/" collapse="true"
									includeRootNode="true" target="base_properties_content" dynamic="false"
									mode="static" href="../menuconfigure/menulist.jsp">																		
									<tree:treedata
										treetype="com.chinacreator.epp.menuconfigure.menu.EppModuleTree"
										scope="request" rootid="0" rootName="平台模块树" expandLevel="1"
										showRootHref="true" needObserver="false" refreshNode="true" />
								</tree:tree>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>

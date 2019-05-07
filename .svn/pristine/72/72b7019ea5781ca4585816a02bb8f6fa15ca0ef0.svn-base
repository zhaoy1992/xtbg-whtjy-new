<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
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
			
			function editApply(app_id){
				var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/editapplymain.jsp?isEdit=true&&app_id='+app_id,screen.availWidth-320,screen.availHeight-200);
				if(ww)
				{
					parent.location.reload();
					getPropertiesContent().location.reload();
				}
			}
</script>
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="../css/tab.winclassic.css">

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="left">
			<form name="applyform">

				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="table">
					<tr>
						<td>
							<div align="center">
								<a href="../applymanager/applywork/applyinfo.jsp"
									target="base_properties_content">应用查询</a>																	
							</div>							
						</td>
					</tr>
				</table>

				<table>
					<tr>
						<td>
							<tree:tree tree="apply_tree" node="apply_tree.node"
								imageFolder="../images/tree_images/" collapse="true"
								includeRootNode="true"
								href=""
								target="" dynamic="false">

								<tree:treedata treetype="com.chinacreator.epp.applymanager.menu.ApplyTree" scope="request" rootid="0"
									rootName="应用管理" expandLevel="1" showRootHref="false"
									needObserver="false" enablecontextmenu="true" />

							</tree:tree>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>

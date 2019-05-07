<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.config.ConfigManager" %>
<%	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	// 得到平台类型
	String egptype = ConfigManager.getInstance().getConfigValue("egptype");
 %>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/toolbar.css">
		<script language="javascript" src="<%=request.getContextPath()%>/sysmanager/scripts/toolbar.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">	
		<script language="javascript">
			function menuissue(obj){
				openWin('<%=request.getContextPath()%>/eppissue/menuissue/menuissuemain.jsp?issuetype='+obj,screen.availWidth-320,screen.availHeight-200);
			}						
</script>	
		<style type="text/css">
<!--
.style4 {color: #FF00FF}
.style6 {color: #FFFFFF}
-->
</style>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="toolbarbodymargin">
		<div id="toolbarborder">
			<div id="toolbar"
				ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25>
							<img class="normal" src="<%=request.getContextPath()%>/sysmanager/images/actions.gif">
						</td>
						<td valign="middle" align="left" nowrap class="text">
							模块操作
						</td>
						<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化"
							title="双击最大化" valign="middle" align="right" width="*" nowrap
							class="text">
							<table height=25 cellpadding=0 cellspacing=0 border=0>
								<% if("devegp".equals(egptype)){%>								
									<td class=normal name="tool1" id="tools1" title="流程导出" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="menuissue('exp');" height=25>
									<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="<%=request.getContextPath() %>/sysmanager/images/new.gif" alt="流程导出" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;流程导出&nbsp;</td></tr></table></td>								
								<%}else if("runegp".equals(egptype)){ %>	
									<td class=normal name="tool1" id="tools1" title="流程导入" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="menuissue('imp');" height=25>
									<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="<%=request.getContextPath() %>/sysmanager/images/new.gif" alt="流程导入" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;流程导入&nbsp;</td></tr></table></td>
								<%}else if("testegp".equals(egptype)){ %>
									<td class=normal name="tool1" id="tools1" title="流程导出" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="menuissue('exp');" height=25>
									<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="<%=request.getContextPath() %>/sysmanager/images/new.gif" alt="流程导出" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;流程导出&nbsp;</td></tr></table></td>								
									<td class=normal name="tool1" id="tools1" title="流程导入" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="menuissue('imp');" height=25>
									<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="<%=request.getContextPath() %>/sysmanager/images/new.gif" alt="流程导入" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;流程导入&nbsp;</td></tr></table></td>
								<%} %>
								
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>

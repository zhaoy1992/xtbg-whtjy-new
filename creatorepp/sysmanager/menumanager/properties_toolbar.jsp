<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

			
%>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
			<script language="javascript" src="../scripts/toolbar.js"></script>
		<script language="javascript">
		

	function getElementByName(eName){
		var elements = document.body.all;
		for(i = 0;i< elements.length;i++){
           if (elements[i].name==eName) return elements[i];
		}
		return null;
	}
	function selectTool(toolName) {
	    var tool=getElementByName(toolName);
		if (tool) {
		    tool.onclick();
		}
	}
	//页面跳转
	function bussinessAction(action){	 
			if (action == 0 ) {
				getPropertiesContent().location.href="../schedularmanage/successfulSchedular.jsp" ;	
			}
			if (action == 1 ) {
				getPropertiesContent().location.href="../../sysmanager/menumanager/menuList.jsp" ;	
			}
	}
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
		<div id="toolbarborder">
			<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
				<table width="100%"  cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25 >
							<img class="normal" src="../images/actions.gif">
						</td>
						<td valign="middle" align="left"  nowrap class="text">
							操作
						</td>
						<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" 
							valign="middle" align="right" width="*"  nowrap class="text">
							<table height=25 cellpadding=0 cellspacing=0 border=0>
								<td class=normal name="tool1" id="tools1" title="菜单查询" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(0)" height=25>
								<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="../images/new.gif" alt="菜单查询" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;<span class="style6">菜单查询&nbsp;</span></td></tr></table></td>
								<td class=normal name="tool1" id="tools1" title="菜单资源查询" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" height=25>
								<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center class="style4">&nbsp;<img src="../images/new.gif" alt="菜单资源查询" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;<span class="style6">菜单资源查询&nbsp;</span></td></tr></table></td>
							</table>
						</td>
				</table>
					
			</div>
		</div>
	</body>
</html>

<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<html>
	<head>
		<title>��������������</title>
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/toolbar.css">
		<jsp:include page="../../sysmanager/base/scripts/panes.jsp" />
		<script language="javascript" src="../../sysmanager/scripts/toolbar.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="toolbarbodymargin">
		<div id="toolbarborder">
			<div id="toolbar"
				ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25>
							<img class="normal" src="../../sysmanager/images/actions.gif">
						</td>
						<td valign="middle" align="left" nowrap class="text">
							����Դ����
						</td>
						<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����"
							title="˫�����" valign="middle" align="right" width="*" nowrap
							class="text">
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
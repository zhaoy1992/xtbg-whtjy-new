<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.net.URLEncoder,java.net.URLDecoder"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css"
			href="../../sysmanager/css/toolbar.css">
		<script language="javascript"
			src="../../sysmanager/base/scripts/toolbar.js"></script>
		<script type="text/javascript">
			function load()
			{
				var _type="<%=request.getParameter("_type")%>";
				var class_id="<%=request.getParameter("class_id")%>";

				if(_type=="class"){					
					getPropertiesContent().location.href="form_class_list.jsp?class_id=" + class_id;
				}else if(_type=="class_home"){		
				 	getPropertiesContent().location.href="form_class_home.jsp";
				}else if(_type=="form"){
				    getPropertiesContent().location.href="form_list.jsp?class_id=" + class_id;
				}else if(_type=="form_home"){
				    getPropertiesContent().location.href="form_home.jsp";
				}
			}	
		</script>
	</head>
<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="toolbarbodymargin" onload="load();">
		<div id="toolbarborder">
			<div id="toolbar">
				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25 height="20">
							<img class="normal" src="../../sysmanager/images/actions.gif">
						</td>
						<td valign="middle" align="left" nowrap class="text" height="20">
							<%
								String toolbar_type = request.getParameter("_type");
								if (toolbar_type.equals("form") || toolbar_type.equals("form_home")) {
							%>
							表单操作
							<%
							} else {
							%>
							业务类别操作
							<%
							}
							%>
						</td>
						<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化"
							title="双击最大化" valign="middle" align="right" width="*" nowrap
							class="text">
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>

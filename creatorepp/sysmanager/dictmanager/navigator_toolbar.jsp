<%@include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>
<%
    String dicttype_type = request.getParameter("dicttype_type")==null?"�ֵ����":request.getParameter("dicttype_type");
    if("0".equals(dicttype_type)){
        dicttype_type = "�����ֵ����ݲɼ�";
    }else if("1".equals(dicttype_type)){
        dicttype_type = "ͨ��ҵ�����ݲɼ�";
    }else if("2".equals(dicttype_type)){
        dicttype_type = "��Ȩҵ�����ݲɼ�";
    } 
    //��properties_content_toolbar.jsp
    session.removeAttribute("dicttype_type");
    session.setAttribute("dicttype_type",dicttype_type);
%>

<title>������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">

<jsp:include page="../base/scripts/panes.jsp" />
<script language="javascript" src="../scripts/toolbar.js"></script>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_NAVIGATOR%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%"  cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td valign="middle" align="center" width=25 ><img
			class="normal" src="../base/images/base_perspective_enabled.gif" width=16 height=16></td>
	<td
			width="*"  align="left" valign="middle" nowrap class="text" id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����"><%=dicttype_type%></td>
	<td valign="middle" align="center" width=25 ><a
       
        target="perspective_workarea"><img class="normal"
        src="../images/refresh_enabled.gif"
        onMouseOver="src='../images/refresh_highlighted.gif';mouseover(this)"
        onMouseOut="src='../images/refresh_enabled.gif';mouseout(this)"
        onMouseDown="src='../images/refresh_highlighted.gif';mousedown(this)"
        onMouseUp="src='../images/refresh_enabled.gif';mouseup(this)"
        alt="ˢ��" title="ˢ��" onclick="getNavigatorContent().location.reload();return false;"></a></td>
        
	</tr>
	
</table>
</div>
</div>
</body>
</html>

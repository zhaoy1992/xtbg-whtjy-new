<%--
　　描述：模板详细界面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-07-31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String template_id_th = request.getParameter("mb_id");
	String orgId = request.getParameter("org_id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>模板详细信息</title>
<script type="text/javascript">
function closeWin(){
	var returnObj = new Object();
	window.returnValue = returnObj;
	window.close();
}
</script>
</head>
<frameset rows="0,*" cols="*" frameborder="no" border="1" framespacing="0" onunload="closeWin()">
	<frame
		src="thwordtemplatedetailtop.jsp?template_id_th=<%=template_id_th%>"
		name="topFrame" scrolling="no" noresize="noresize" id="topFrame"
		title="topFrame" />
	<frameset cols="*,380" frameborder="no" border="1" framespacing="0" id="centerFrame">
		<frameset cols="*,7" frameborder="no" border="1" framespacing="0">
			<frame
				src="thwordtemplatedetailmain.jsp?template_id_th=<%=template_id_th%>"
				name="mainFrame" scrolling="no" id="mainFrame" title="mainFrame" />
			<frame src="hiddenframe.jsp" name="hiddenFrame" scrolling="No"
				noresize="noresize" id="hiddenFrame" title="hiddenFrame" />
		</frameset>
		<frame
			src="thwordtemplatedetailright.jsp?template_id_th=<%=template_id_th%>&org_id=<%=orgId %>"
			name="rightFrame" scrolling="no" noresize="noresize" id="rightFrame"
			title="rightFrame" /> 
	</frameset>
</frameset>
</html>
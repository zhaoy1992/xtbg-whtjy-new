<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String template_id = request.getParameter("mb_id");
	String orgId = request.getParameter("org_id");

%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>模板详细信息</title>
	<script type="text/javascript">
	function closeWin(){
		var returnObj = new Object();
		window.returnValue = returnObj;
		window.close();
	}
	</script>
</head>


<frameset rows="80,*" cols="*" frameborder="no" border="1" framespacing="0" onunload="closeWin()">
	<frame
		src="wordtemplatedetailtop.jsp?template_id=<%=template_id%>"
		name="topFrame" scrolling="No" noresize="noresize" id="topFrame"
		title="topFrame" />
	<frameset cols="*,380" frameborder="no" border="1" framespacing="0" id="centerFrame">
		<frameset cols="*,7" frameborder="no" border="1" framespacing="0">
			<frame
				src="wordtemplatedetailmain.jsp?template_id=<%=template_id%>"
				name="mainFrame" scrolling="No" id="mainFrame" title="mainFrame" />
			<frame src="hiddenframe.jsp" name="hiddenFrame" scrolling="No"
				noresize="noresize" id="hiddenFrame" title="hiddenFrame" />
		</frameset>
		<frame
			src="wordtemplatedetailright.jsp?template_id=<%=template_id%>&org_id=<%=orgId %>"
			name="rightFrame" scrolling="No" noresize="noresize" id="rightFrame"
			title="rightFrame" /> 
	</frameset>
</frameset>

</html>
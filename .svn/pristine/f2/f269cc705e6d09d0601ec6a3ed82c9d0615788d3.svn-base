<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.lucene.IndexFields"%>
<html>
<head>
	<title>快速全文检索</title>
</head>
<body>
<div>
	<form action="search.jsp" method="get">
		<input type="hidden" name="filetypes" value="all"/>
		<input type="hidden" name="fields" value="<%=IndexFields.FIELD_CONTENT%>;<%=IndexFields.FIELD_NAME%>"/>
		
		<input name="querystr" size="50"><button onclick="doSearch()">搜索</button>
	</form>   
</div>
</body>
</html>
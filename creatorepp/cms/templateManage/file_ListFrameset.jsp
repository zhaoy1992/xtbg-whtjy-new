<%@ page contentType="text/html; charset=GBK" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<style type="text/css">
.toolFrmstyle {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #999999;
}
</style>
</head>
<%
	//��ߵ����Ľڵ�����������:һ���ṩվ��id,һ���ṩ�ļ�ϵͳ�����·��
	String uri = request.getParameter("uri");
	String siteId = request.getParameter("siteId");
	if(siteId==null && (uri==null ||  uri.indexOf(".jsp")<0) ){
%>
<frameset rows="35,*" frameborder="no" border="0" framespacing="0">
	<frame src="toolbar.jsp?uri=<%=(uri==null?"":uri)%>" name="toolFrm" id="toolFrm" scrolling="NO" noresize class="toolFrmstyle">
	<frame src="file_list.jsp?uri=<%=(uri==null?"":uri)%>" name="fileList" id="fileList">
</frameset><noframes></noframes>
<%
	}
	if(siteId!=null && siteId.trim().length()!=0 && (uri==null ||  uri.indexOf(".jsp")<0) ){
	
%>
<body>
	<script type="text/javascript">
		window.location.href = "template_main.jsp?siteId=<%=siteId%>";
	</script>
</body>
	<%}else if(uri!=null && uri.indexOf(".jsp") >=0){	
%>	
	<body>
	<script type="text/javascript">
		window.location.href = "<%=uri%>";
	</script>
</body>
<%	
	} 	
	%>
</html>

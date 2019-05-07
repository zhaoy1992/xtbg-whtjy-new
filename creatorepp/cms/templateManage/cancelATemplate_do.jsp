<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.templatemanager.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body>
<% 
try{
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String siteId = request.getParameter("siteId");
	String templateId = request.getParameter("templateIds");
	if(siteId==null||siteId.trim().length()==0||templateId==null||templateId.trim().length()==0){
%>
		<script type="text/javascript">
			alert("请提供站点id和模板id.");
			top.close();
		</script>
<%		
		return;
	}
	boolean hasDelete = new TemplateManagerImpl().deleteTemplateofSite(Integer.parseInt(templateId),Integer.parseInt(siteId));

	if(hasDelete){
		%>
		<script type="text/javascript">
			alert("文件已经不是模板了!");
			window.dialogArguments.parent.toolFrm.reloadView();
			top.close();
		</script>	
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("模板可能已经在使用了，没有取消成功!");
			window.dialogArguments.parent.toolFrm.reloadView();
			top.close();
		</script>	
		<%
	}
}catch(Exception e){
%>
	<script type="text/javascript">
		alert('取消文件作为模板发生异常');
		window.dialogArguments.reloadView();
		top.close();
	</script>	
<%	e.printStackTrace();
	return;
}
%>

</body>
</html>
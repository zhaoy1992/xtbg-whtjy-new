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
			alert("���ṩվ��id��ģ��id.");
			top.close();
		</script>
<%		
		return;
	}
	boolean hasDelete = new TemplateManagerImpl().deleteTemplateofSite(Integer.parseInt(templateId),Integer.parseInt(siteId));

	if(hasDelete){
		%>
		<script type="text/javascript">
			alert("�ļ��Ѿ�����ģ����!");
			window.dialogArguments.parent.toolFrm.reloadView();
			top.close();
		</script>	
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("ģ������Ѿ���ʹ���ˣ�û��ȡ���ɹ�!");
			window.dialogArguments.parent.toolFrm.reloadView();
			top.close();
		</script>	
		<%
	}
}catch(Exception e){
%>
	<script type="text/javascript">
		alert('ȡ���ļ���Ϊģ�巢���쳣');
		window.dialogArguments.reloadView();
		top.close();
	</script>	
<%	e.printStackTrace();
	return;
}
%>

</body>
</html>
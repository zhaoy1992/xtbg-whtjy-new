<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	DocumentManager dm = new DocumentManagerImpl();
	String userid = accesscontroler.getUserID();
	String docid = request.getParameter("docid");
	String version = request.getParameter("version");
	int b = dm.delDocVersion(Integer.parseInt(docid),Integer.parseInt(version));
	
	if(b!=0){%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ɾ���ĵ��汾�ɹ���");
			var str = window.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		</script>
	
	<%}else{%>
		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ɾ���ĵ��汾ʧ�ܣ�");
			window.close();
		</script>
		
	<%
		}
	%>			
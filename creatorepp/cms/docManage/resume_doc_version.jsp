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
	int b = dm.resumeDocVersion(Integer.parseInt(docid),Integer.parseInt(version),Integer.parseInt(userid));
	//��Ӱ汾�ָ���־
	dm.recordDocOperate(Integer.parseInt(docid),Integer.parseInt(userid),"�汾�ָ�",-1,"�汾�ָ�:�ָ����汾"+version);
	
	if(b!=0){%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("�ָ��ĵ��汾�ɹ���");
			var str = window.dialogArguments.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.dialogArguments.location.href = strArray+"?"+window.dialogArguments.dialogArguments.document.all.queryString.value;
			//window.close();
			window.dialogArguments.close(); 
		</script>
	
	<%}else{%>
		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("�ָ��ĵ��汾ʧ�ܣ�");
			window.close();
		</script>
		
	<%
		}
	%>			
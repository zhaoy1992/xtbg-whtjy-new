<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%
	//�����ĵ����˻ز������������ĵ��˻ظ��ύ�ˣ��ĵ���Ϊ�����ĵ�

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request,response);
	DocumentManager idm = new DocumentManagerImpl();
	int userId = Integer.parseInt(accesscontroler.getUserID());
	int docId = Integer.parseInt(request.getParameter("docId"));
	int taskId = Integer.parseInt(request.getParameter("taskId"));	
	try{
		int executer = idm.getPreSubmitterId(taskId);
		idm.toPubWithdraw(docId,taskId,userId,new int[]{executer});
		%>
			<script language = "javascript">
				alert("�����ɹ�");
				var str = parent.document.location.href;
				var end = str.indexOf("?");
				var strArray;
				if(end != -1)
					 strArray= str.slice(0,end);
				else
					strArray = str;
				parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;
			</script>
		<%
	}catch(DocumentManagerException de){
		de.printStackTrace();
		%>
		<script language="javascript">
			alert("���ݿ����ʧ��");
		</script>
		<%
	}
%>
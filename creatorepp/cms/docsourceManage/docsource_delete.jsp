<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.cms.docsourcemanager.*"%>
<%
	String[] docsrcid = request.getParameterValues("checkBoxOne");
	boolean b = false;
	if (docsrcid != null) {
		for (int i = 0; i < docsrcid.length; i++) {
			DocsourceManager addm = new DocsourceManagerImpl();
			b = addm.deleteDsrc(Integer.parseInt(docsrcid[i]));
		}
	}
	if(b == true)
	{
%>
<font size=2 color=blue>ɾ�����ĵ���Դ�ɹ�,���ڴ���������Ϣ���Ժ��Զ�����</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_list.jsp'>
<%
	}
	else{
	%>
<font size=2 color=blue>ɾ�����ĵ���Դʧ��,�ĵ����������ã��Ժ��Զ�����</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_list.jsp'>
	<%
	}
%>
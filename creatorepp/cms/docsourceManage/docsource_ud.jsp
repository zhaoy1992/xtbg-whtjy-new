<%@ page language="java"  pageEncoding="GBK"%>
<%@page import="com.chinacreator.cms.docsourcemanager.*"%>

<%
	Docsource docsource= new Docsource();
	
	String srcName = request.getParameter("srcname") ;
	
	if(srcName != null)
	{
		srcName = srcName.trim();
	}
	
	docsource.setSRCNAME(srcName);
	docsource.setSRCDESC(request.getParameter("srcdesc"));
	docsource.setSRCLINK(request.getParameter("srclink"));
	docsource.setDOCSOURCE_ID(Integer.parseInt(request.getParameter("docId")));


	if(!request.getParameter("srcname").equals(""))
	{
		DocsourceManager dm = new DocsourceManagerImpl();
		boolean b=dm.updateDsrc(docsource);
		if(b==false)
		{
%>
			<font size=2 color=blue>���ĵ���Դ�Ѵ���!</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_creator.jsp'>
<%		}
		else
		{
%>
			<font size=2 color=blue>�ĵ���Դ��Ϣ�޸ĳɹ�,���ڴ��������ύ��Ϣ���Ժ��Զ�����!</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_list.jsp'>
<%}
	}
	else
	{
		if(request.getParameter("srcname").equals("") && request.getParameter("cruser").equals(""))
		{
%>
			<font size=2 color=blue>�ĵ����ƴ��ʹ����ߴ�����Ϊ��!</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_creator.jsp'>
<%		}
		else
		{
			if(request.getParameter("srcname").equals(""))
			{
%>
				<font size=2 color=blue>�ĵ����ƴ�����Ϊ��!</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_creator.jsp'>
<%			}
			else
			{
%>
				<font size=2 color=blue>�����ߴ�����Ϊ��!</font><meta http-equiv='refresh' content='2;url=<%=request.getContextPath()%>/cms/docsourceManage/docsource_creator.jsp'>
			<%
			}
		}
	}
%>
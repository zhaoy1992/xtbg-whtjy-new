<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.bean.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>��������</title>
</head>
<body>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String indexFlag = request.getParameter("indexFlag");
	
	boolean lockd;
	String alertStr = "��ϲ�����Ѿ�������̨�������̣߳�";
	
	CMSSearchManager sm = new CMSSearchManager();
	if("1".equals(indexFlag)){	//�����������
		String cmsIndexIds[] = request.getParameterValues("dbIndexID");
		String tmp = "";	
		for(int i=0;i<cmsIndexIds.length;i++){
			CMSSearchIndex cmsIndex = sm.getIndex(cmsIndexIds[i]);
			
			//�ж������ļ����Ƿ��Ѿ�����
			lockd = sm.isIndexLocked(cmsIndex);
			if(lockd == true){
				if(tmp.length()>0)
					tmp = tmp + "," + cmsIndex.getIndexName();
				else 
					tmp = cmsIndex.getIndexName();
			}else{
			
				//�����̼߳�����վ�㽨������
				new CMSCrawlerThread(cmsIndex).start();	
			}
		}
		
	if(tmp.length()>0)
		alertStr = "�Բ���������" + tmp + " ���ڽ����У����Ժ�������Щ������";
		
	}else{						//����վȺ����
		String siteId = request.getParameter("siteId");
		String indexId = request.getParameter("indexId");
				
		CMSSearchIndex cmsIndex = sm.getIndex(indexId);
		
		//�ж������ļ����Ƿ��Ѿ�����
		lockd = sm.isIndexLocked(cmsIndex);
		if(lockd == true)
			alertStr = "�Բ������ڽ�������:" + cmsIndex.getIndexName() + "�����Ժ����ԣ�";
		else
			//�����̼߳����Կ��������
			new CMSCrawlerThread(cmsIndex).start();
	}
	
	out.println("<script language='javascript'>alert('" + alertStr + "');</script>");
	//if(alertStr.contains("��ϲ"))
	//contains��������,jdk�汾����,weida
	if(alertStr.indexOf("��ϲ") != -1)
		out.println("<script language='javascript'>parent.document.location.reload();</script>");
%>
</body>
</html>

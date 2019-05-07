<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.bean.*"%>
<%@ page import="com.chinacreator.cms.util.CMSUtil"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>��������</title>
</head>
<body>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//indexFlagΪ0��ʾվ��������Ϊ1��ʾ��վ��Ƶ����������
	String indexFlag = request.getParameter("indexFlag");
	
	boolean lockd;
	String alertStr = "��ϲ�����Ѿ�������̨�������̣߳�";
	
	CMSSearchManager sm = new CMSSearchManager();
	if("0".equals(indexFlag)){			//������վ�㿪ʼ����
		String siteId = request.getParameter("siteId");
		//������վ��Ŀ¼��������
		int indexId = sm.isAllSiteIndexExist(siteId);
		if(indexId != -1){
			CMSSearchIndex cmsIndex = sm.getIndex(indexId+"");
			
			//�ж������ļ����Ƿ��Ѿ�����
			lockd = sm.isIndexLocked(cmsIndex);
			if(lockd == true)
				alertStr = "�Բ������ڽ�������:" + cmsIndex.getIndexName() + "�����Ժ����ԣ�";
			else
				//�����̼߳�������վ��������
				new CMSCrawlerThread(cmsIndex).start();
		}else{
			alertStr = "�Բ��𣬵�ǰվ�㻹û����վ������¼���������Ӻ��ٿ�ʼ������";
		}
		
		
	}else if("1".equals(indexFlag)){	//����վ��Ƶ������
		String cmsIndexIds[] = request.getParameterValues("siteIndexID");
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
			
	}else{						//����վ��Ƶ������
		String siteId = request.getParameter("siteId");
		String indexId = request.getParameter("indexId");
				
		CMSSearchIndex cmsIndex = sm.getIndex(indexId);
		
		//�ж������ļ����Ƿ��Ѿ�����
		lockd = sm.isIndexLocked(cmsIndex);
		if(lockd == true)
			alertStr = "�Բ������ڽ�������:" + cmsIndex.getIndexName() + "�����Ժ����ԣ�";
		else
			//�����̼߳�����վ��Ƶ����������
			new CMSCrawlerThread(cmsIndex).start();
	}
	
	out.println("<script language='javascript'>alert('" + alertStr + "');</script>");
	if(alertStr.indexOf("��ϲ") != -1)
		out.println("<script language='javascript'>parent.document.location.reload();</script>");
%>
</body>
</html>

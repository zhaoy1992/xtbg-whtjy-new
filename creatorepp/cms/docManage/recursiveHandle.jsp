<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%
/*
	˵��������
	�ݹ鷢�������������1���ݹ鷢�������ĵ���2���ݹ鷢�������ĵ���3���ݹ鷢��Ƶ����4�����·����ĵ����������·����Զ��ݹ飩
	1��2��3�����봫����siteId��action
	1���봫����docId
	2���봫����docs����ΪdocsΪһ��list��������ͨ��session��
	3���봫����channelId
	4���봫����docInfos����ΪdocInfos�Ǹ���ά���飬����ͨ��session��
*/
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String siteId = request.getParameter("siteId");
	String action = request.getParameter("action");
	
	String docId = request.getParameter("docId");
	
	String channelId = request.getParameter("channelId");
	
	String flag = request.getParameter("flag");
	
	Object o = session.getAttribute("docs");
	session.removeAttribute("docs");
	List docs = null;
	if(o != null)
	 	docs = (List)o;
	
	Object oDocInfos = session.getAttribute("docInfos");
	session.removeAttribute("docInfos");
	String[][] docInfos = null;
	if(oDocInfos != null)
	 	docInfos = (String[][])oDocInfos;
	
	DocumentManager idm = new DocumentManagerImpl();
	
	WEBPublish publish = new WEBPublish();
	publish.init(request,response,pageContext,accesscontroler);
	if(docInfos != null)
	{
		//�ڷ����ĵ�ʱ������ǿ��ִ���ѷ����ĵ��ĵݹ鷢����ʶΪtrue			
		publish.forceStatusPublished(true);
	}
	PublishCallBack callback = new PublishCallBackImpl();
	publish.setPublishCallBack(callback);
	if(flag!=null&&flag.equals("channel"))//����Ƶ���ݹ鷢��
	{
		publish.recursivePubObjectOfChannelAncester(siteId,channelId,Integer.parseInt(action));
	}
	else if(docId != null && !docId.equals(""))	//�ݹ鷢�������ĵ�
	{
		publish.recursivePubObjectOfDocument(siteId,idm.getPartDocInfoById(docId+""),Integer.parseInt(action));
	}
	else if(docs != null)					//�ݹ鷢�������ĵ�
	{
		publish.recursivePubObjectOfDocuments(siteId,docs,Integer.parseInt(action));
	}
	else if(channelId != null)				//�ݹ鷢��Ƶ��
	{
		publish.recursivePubObjectOfChannelAncester(siteId,channelId,Integer.parseInt(action));
	}
	else if(docInfos != null)				//���·����ĵ����ڻ����ĵ��ָ�ʱ�����·����ĵ�		
	{
		publish.publishBatchDocument(docInfos,new boolean[] {true,false},new int[] {0});
	}
%>
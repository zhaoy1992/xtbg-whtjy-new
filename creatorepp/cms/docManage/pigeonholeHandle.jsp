<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	int userId = Integer.parseInt(accesscontroler.getUserID());
	
	String siteId = request.getParameter("siteId");
	
	//�ĵ��Ĺ鵵
	String docidStr = request.getParameter("docidStr");
	String[] docidArr = docidStr.split(";");
	//���ĵ�id���ַ�������ת��Ϊ��������	
	int[] intDocids = new int[docidArr.length];
	for(int i=0;i<docidArr.length;i++){
		intDocids[i] = Integer.parseInt(docidArr[i]);
	}

	//weida
	session.removeAttribute("docIds_pigDoc");
	session.setAttribute("docIds_pigDoc",docidArr);
	session.removeAttribute("siteId_pigDoc");
	session.setAttribute("siteId_pigDoc",siteId);
	%>
	<html><body>
	<iframe name="deleteIndexsFrame" src="DeleteIndexsHandle.jsp?action=pigDoc"></iframe>
	</body></html>
	<%
	
	//�����ĵ�����
	DocumentManager docManager = new DocumentManagerImpl();
	try{
		
		//��ʼ���ݹ淢��
		//WEBPublish publish = new WEBPublish();
		//publish.init(request,response,pageContext,accesscontroler);
		//PublishCallBack callback = new PublishCallBackImpl();
		//publish.setPublishCallBack(callback);
		
		//����洢�ѷ����ĵ��б��������Ա���еݹ鷢��
	    java.util.List docs = new java.util.ArrayList();
	    for(int i=0;i<intDocids.length;i++){
		    Document doc = docManager.getPartDocInfoById(intDocids[i] + "");
			if(doc.getStatus()==5){
				docs.add(doc);
				//ɾ�������������ļ�
				//publish.deletePublishFile(siteId,intDocids[i],request,response);
				
			}
		}
		
		//�鵵����
		Map tranIdMap = docManager.canTransition(intDocids,7);
		//�ܿ����ع����������ť��һ�����ܹ鵵�ģ��ۺ��ĵ��������ĵ�����Ǩ���жϣ�
		docManager.pigeonholeDoc(intDocids,userId);
		
		
		//�ݹ鷢���ĵ�
		if(docs.size() > 0)
		{
			int action = RecursivePublishManager.ACTIONTYPE_ARCHIVE;
			session.removeAttribute("docs");
			session.setAttribute("docs",docs);
		%>
			<html>
			<body>
			<iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=siteId%>&action=<%=action%>"></iframe>
			</body>
			</html>
			<!-- publish.recursivePubObjectOfDocuments(siteId,docs,RecursivePublishManager.ACTIONTYPE_ARCHIVE);-->
		<%
		}
			%>
				<script language = "javascript">
					alert("�����ɹ���");
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
	}catch(Exception de){
		de.printStackTrace();
		%>
		<script language="javascript">
			alert("���ݿ����ʧ�ܣ�");
			window.close();
		</script>
		<%
	}
%>





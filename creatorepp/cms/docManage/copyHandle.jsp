<%@ page contentType="text/html; charset=GBK" language="java" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	int userId = Integer.parseInt(accesscontroler.getUserID());
	
	String channelid = request.getParameter("channelid");
	String docidStr = request.getParameter("docidStr");
	String newDoc = request.getParameter("newDoc");
	String statutype = request.getParameter("statutype"); //ѡ����ĵ�״̬
	String mixid = request.getParameter("channelid");//channelid site1:channelid1,site2:channelid2,....
	String[] mixids = mixid.split(",");
	
	int[] channelids = new int[mixids.length];
	int[] siteids = new int[mixids.length];
	for(int i=0;i<mixids.length;i++){
	    String[] tmp = mixids[i].split(":");
	    siteids[i] = Integer.parseInt(tmp[0]);
	    channelids[i] = Integer.parseInt(tmp[1]);
	}
	
	String[] docid;				//��ʱ���ĵ�id���ַ�������
	int[] intDocid = null;
	if(docidStr != null){
		docid = docidStr.split(":");
		//�õ��ĵ�id����������
		intDocid = new int[docid.length];
		for(int i=0;i<docid.length;i++){
			intDocid[i] = Integer.parseInt(docid[i]);
		}
	} 
	
	//�ĵ����ƴ���
	DocumentManager idm = new DocumentManagerImpl();	
	try{	    
		//idm.copyDoc(request,intDocid,Integer.parseInt(channelid));
		//�ƶ���ָ����վ���Ƶ���� ���Ƶ��, ָ��״̬ ������������
		//�����󷵻��²����ĵ���ID����, ������Щ�ĵ�		
        //���ĵ���״̬ѡ��Ϊ"����","������"ʱ, ��������
		//�����������	
		//��������������	
		//���ĵ�����|�ƶ�ʱ����	
		//����������֡��ִ��
		int[][] newDocIds = null; 
	    newDocIds = idm.copyDocs(request,intDocid,channelids,siteids,Integer.parseInt(statutype),userId);	    
	    if(Integer.parseInt(statutype)==5){
	        //session����²������ĵ�ID����
	        session.removeAttribute("muti_newDocIds");	    
	    	session.setAttribute("muti_newDocIds",newDocIds);	    		
	    	
	    %>	        		
	    	<html>
			<body>
			<iframe name="publishMutiDocsHandle" src="publishMutiDocsHandle.jsp"></iframe>
			</body>
			</html>
	    		    
	    <%	    
	    }   
	    //����ѭ���ݹ鷢��Ƶ��
	    if(Integer.parseInt(statutype)==5){
	    	int action = RecursivePublishManager.PUBOBJECTTYPE_CHANNEL;	
		    for(int i=0;i<siteids.length;i++)
		    {
		    	%>
				<html>
				<body>
				<iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=siteids[i]%>&channelId=<%=channelids[i]%>&action=<%=action%>&flag=channel"></iframe>
				</body>
				</html>
			<%		
		    }
	    }
		
%>
<script language = "javascript">
	alert("�����ɹ���");
	window.close();
	<%if("true".equals(newDoc)){%>
		var str = window.dialogArguments.location.href;
		var end = str.indexOf("?");
		var strArray;
		if(end != -1)
			strArray= str.slice(0,end);
		else
			strArray = str;
		window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
	<%}%>
</script>
<%
	}catch(DocumentManagerException de){
		de.printStackTrace();
%>
		<script language="javascript">
			alert("���ݿ����ʧ�ܣ�");
			window.close();
		</script>
<%
	}
%>
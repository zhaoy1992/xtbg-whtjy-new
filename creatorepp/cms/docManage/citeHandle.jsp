<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();

	//flagΪ1��ʾ������Ƶ�������ĵ�������Ϊ2��ʾ������Ƶ�����������ĵ�,Ϊ3��ʾƵ������,��ʱdocidStrʵ����ΪƵ����id��
	String flag = request.getParameter("flag");
	String siteid = request.getParameter("siteid");				//��ǰվ��
	String channelid = request.getParameter("channelid");		//Ŀ��Ƶ��
	String dstSiteId = request.getParameter("dstSiteId");		//Ŀ��վ��
	String docidStr = request.getParameter("docidStr");
	String docsiteidstr = request.getParameter("docsiteid");		//�����ĵ���������Ƶ��������վ��

	String[] docid = null;				//��ʱ���ĵ�id���ַ�������
	int[] intDocid = null;
	int[] intdocsiteid = null;    //����Ƶ�����ã�ÿ��Ƶ����Ӧһ��վ��id
	String[] docsiteid = null;
	if(docidStr != null){
		if("3".equals(flag)){
			docid = docidStr.split(",");
			docsiteid = docsiteidstr.split(",");
			intdocsiteid = new int[docsiteid.length];
		}
		else {docid = docidStr.split(":");}
		//�õ��ĵ�id����������
		intDocid = new int[docid.length];
		for(int i=0;i<docid.length;i++){
			intDocid[i] = Integer.parseInt(docid[i]);
			if("3".equals(flag)){
				intdocsiteid[i] = Integer.parseInt(docsiteid[i]);}
		}
	}  
	//�ĵ����ô���
	DocumentManager idm = new DocumentManagerImpl();
	try{
		int citeType = 0;
		if(!"3".equals(flag))				//�ĵ�����
			citeType = 0;
		else 								//Ƶ������
			citeType = 1;
		String canntCiteDocNames = idm.canCite(intDocid,Integer.parseInt(channelid),citeType);
		if(canntCiteDocNames != null && canntCiteDocNames.length()==0){
			if(!"3".equals(flag))
			{
				idm.citeDoc(intDocid,Integer.parseInt(channelid),Integer.parseInt(userid),citeType,Integer.parseInt(docsiteidstr));
				
			}
			else
			{
				for(int j=0;j<intDocid.length;j++)
				{
					idm.citeDoc(intDocid[j],Integer.parseInt(channelid),Integer.parseInt(userid),citeType,intdocsiteid[j]);
				}
			}
			//�ݹ鷢������
			try
			{
				boolean recursiveFlag = false;
				//�ж��Ƿ���Ҫ�ݹ鷢��
				if(citeType == 1)				//Ƶ������һ���õݹ鷢��
				{
					recursiveFlag = true;
				}
				else
				{
				    for(int i=0;i<intDocid.length;i++){
					    Document doc = idm.getPartDocInfoById(intDocid[i] + "");
						if(doc.getStatus()==5){
							recursiveFlag = true;
							break;
						}
					}
				}
				
				if(recursiveFlag){
					
					int action = RecursivePublishManager.RECURSIVE_PUB_ADD_ARRANGEDOC;
				%>
					<html>
					<body>
					<iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=dstSiteId%>&channelId=<%=channelid%>&action=<%=action%>"></iframe>
					</body>
					</html>
				<%
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			%>
			<script language = "javascript">
				alert("�����ɹ���");
				if(<%=flag%>==1 || <%=flag%>==3){
					var str = window.dialogArguments.dialogArguments.location.href;
					var strArray = str.slice(0,str.indexOf("?"));
					window.dialogArguments.dialogArguments.location.href = strArray+"?"+window.dialogArguments.dialogArguments.document.all.queryString.value;
				}
				window.dialogArguments.close(); window.close();
			</script>
			<%
		}else{
			%>
			<script language = "javascript">
				alert("���������Ѿ����ù����ĵ�/Ƶ����<%=canntCiteDocNames%>��");
				window.close();
			</script>
			<%		 
		}
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
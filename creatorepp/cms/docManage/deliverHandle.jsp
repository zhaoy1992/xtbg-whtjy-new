
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	//flagΪ1��ʾ�¸��ĵ�������,Ϊ2��ʾ�����ĵ�������,3���������
    String flag = request.getParameter("flag"); 
	String[] auditors = request.getParameterValues("checkBoxOne");
	//�õ�����˵���������
	int[] intAuditors = null;
	if(auditors!=null&& auditors.length>0){
	 	intAuditors = new int[auditors.length];
		for(int i=0;i<auditors.length;i++){
			intAuditors[i] = Integer.parseInt(auditors[i]);
		}
	}
	
	DocumentManager docManager = new DocumentManagerImpl();
	try{
		if(flag.equals("1")){
	    	String docidStr = request.getParameter("docidStr");  //Ƶ���б���Ҳֻ��һ���ĵ�����
	    	Map tranIdMap = (HashMap)session.getAttribute("tranIdMap");
			session.removeAttribute("tranIdMap");
			//�õ��ĵ�id����,Ϊ�ַ�������
			String[] docids = null;
			if(docidStr!= null){
				docids = docidStr.split(":");
			}
			//Ƶ���б���Ҳֻ��һ���ĵ�����
			//int intDocid = Integer.parseInt(docids[0]);
			int[] intDocid = new int[docids.length];
			for(int i=0;i<docids.length;i++){
				intDocid[i] = Integer.parseInt(docids[i]);
			}
			//������ֵ��ʾ��ǰ�ĵ��Ƿ������񡣶��ڷ����ĵ���ֵΪ��������id����Ϊ�¸壬ֵΪ0
			int[] taskids = docManager.hasTask(Integer.parseInt(userId),intDocid,2);
			//�����ʹ���
			docManager.deliverDoc(intDocid,intAuditors,Integer.parseInt(userId),taskids);   
			docManager.recordDocOperate(intDocid,Integer.parseInt(userId),"����",tranIdMap,"����");
%>
			<script language="javascript">
				alert("�����ɹ���");
				window.close();
			</script>
<%
	    }
	    else if(flag.equals("2")||flag.equals("3")){
	    	String docid = request.getParameter("docid");  //�����ĵ�id
	    	String taskid = request.getParameter("taskid");
	    	if(flag.equals("3")){
	    		String auditComment = request.getParameter("auditComment");
    			//�����
    			int tranId3 = docManager.canTransition(Integer.parseInt(docid),3);
				if(tranId3 >= 0){
					docManager.audit(Integer.parseInt(docid),Integer.parseInt(taskid),Integer.parseInt(userId),auditComment,1);
					docManager.recordDocOperate(Integer.parseInt(docid),Integer.parseInt(userId),"���",tranId3,"���ͨ��");
				}
	    	}
	    	int tanid = docManager.canTransition(Integer.parseInt(docid),2);
	    	if(tanid >= 0){
		    	docManager.deliverDoc(Integer.parseInt(docid),intAuditors,Integer.parseInt(userId),Integer.parseInt(taskid));
		    	docManager.recordDocOperate(Integer.parseInt(docid),Integer.parseInt(userId),"����",tanid,"����");
%>
			<script language = "javascript">
				alert("�����ɹ���");
				window.close();
				if(<%=flag%>==2){
					var str = window.dialogArguments.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						 strArray= str.slice(0,end);
					else
						strArray = str;
					window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
				}
			</script>
<%
			}
			else{
%>
			<script language = "javascript">
			alert("����ʧ�ܣ�");
			window.close();
			</script>
<%
			}
	    }
	}
	catch(DocumentManagerException de){
		de.printStackTrace();
%>
		<script language="javascript">
			alert("���ݿ����ʧ�ܣ�");
			window.close();
		</script>
<%
	}
%>





<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*,
				 com.chinacreator.sysmgrcore.manager.db.*,
				 com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="org.apache.ecs.wml.Do" %>
<%
	int successflag = 0;
	
	String docId = request.getParameter("docId");
	String commenterName = request.getParameter("commenterName");
	String psword = request.getParameter("psword");
	String srcCommentId = request.getParameter("srcCommentId");
	String flag = request.getParameter("flag");              //Ϊup��ʾ��������Ϊresponse��ʾ�ظ����ظ�����Ҫ�رմ��ڣ�
	
	String userhide = request.getParameter("userhide");	  //1��null��ʾ��������0��ʾ����������
	//System.out.println("userhide:" + userhide);
	DocCommentManager idm = new DocCommentManagerImpl();
	UserManager um = new UserManagerImpl();
	
	boolean isUserExist = false;
	
	if("0".equals(userhide) && commenterName!=null && psword!=null){
		isUserExist=idm.hasUser(commenterName,psword);
		
	}
	if("1".equals(userhide) || isUserExist ||"up".equals(flag)){	
		//�ĵ����۴���
		
		DocumentManager dm = new DocumentManagerImpl();
		String docTitle = dm.getDoc(docId.trim()).getSubtitle();
		String commenterIP =request.getRemoteAddr();
		
		DocComment docComment = new DocComment();
		docComment.setComment(request.getParameter("docComment"));
		docComment.setDocId(Integer.parseInt(docId.trim()));
		docComment.setDocTitle(docTitle);
		docComment.setUserIP(commenterIP);
		docComment.setStatus(0);     //ǰ̨�û�������Ϊδ��״̬�������
		if(isUserExist){
			docComment.setUserName(commenterName);
		}
		if(srcCommentId!=null && srcCommentId.length()>0){
			int srcsrcCommentId = idm.getCommentByComId(Integer.parseInt(srcCommentId)).getSrcCommentId();
			int realSrcCommentId = srcsrcCommentId==0?Integer.parseInt(srcCommentId):srcsrcCommentId;
			docComment.setSrcCommentId(realSrcCommentId);
		}
		
		if (request.getParameter("docComment").trim().equals("")||request.getParameter("docComment")==null){
		%>
		<script language = "javascript">
			alert("���۲���Ϊ�գ�");
				
		</script>
	<%	}	
		if(dm.getCommentswitch(Integer.parseInt(docId))==1){
		successflag = 2;
	%>
		<script language="javascript">
			alert("�����Ѿ��ر�!");
		</script>
		<%
		}else{
		idm.addOneComment(docComment);
		successflag = 1;
		} 
		
		//System.out.println("״̬��" + dm.getCommentswitch(Integer.parseInt(docId)));   
	}	
%>
<%		 
	if(successflag == 1){ 
%>
		<script language = "javascript">
			alert("�����ɹ���");
			if("<%=flag%>"=="response"){
				window.close();
				window.returnValue = "cf";
			}
			//var str = parent.document.location.href;
			//var end = str.indexOf("?");
			//var strArray;
			//if(end != -1)
			//	strArray= str.slice(0,end);
			//else
			//	strArray = str;
			//parent.document.location.href = strArray+"?"+parent.document.all.queryString.value;
			
			parent.document.location.reload();
		</script>
		<%
			}else if(successflag == 0){
		%>
		<script language="javascript">
			alert("�û������������");
		</script>
		
<%
	}
%>
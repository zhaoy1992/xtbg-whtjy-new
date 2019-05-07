<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String docTitle = request.getParameter("docTitle");
	String subtime = request.getParameter("subtime");
	String userName = request.getParameter("userName");
	//String docComment = request.getParameter("docComment");
	String userIP = request.getParameter("userIP");
	String commentId = request.getParameter("commentId");
	
	//System.out.println(request.getRemoteAddr());
	//System.out.println(request.getRemoteHost());
	
	DocCommentManager ddm = new DocCommentManagerImpl();
	DocComment comment = new DocComment();
	comment = ddm.getCommentByComId(Integer.parseInt(commentId.trim()));
	int status = comment.getStatus();
	String docComment = comment.getComment();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<title>:::�鿴��������::::::::::</title>
	<script src="../inc/js/func.js"></script>
	<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	<style type="text/css">
		.STYLE1 {color: blue}
	</style>
	<script language="javascript">
		function publishComments(){
			seeCommentForm.action="docCommentHandle.jsp?commentId=<%=commentId%>&action=publish"; 
			seeCommentForm.submit();
		}
		function deleteC(){	
			seeCommentForm.action="docCommentHandle.jsp?commentId=<%=commentId%>&action=delete"; 
			seeCommentForm.submit();
		}
		function withdrawPubComments(){
			seeCommentForm.action="docCommentHandle.jsp?commentId=<%=commentId%>&action=withdrawPub"; 
			seeCommentForm.submit();
		}	
	</script>
</head>
<body scroll=no leftmargin=0>
	<div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;
			background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
	    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>���ڷ����У����Եȡ���</span></marquee>
    </div>
	<form action="" method="post" name="seeCommentForm" target="seeCommentIframe">
		<table width="100%" height="100%" border="0" align="center" bgcolor="#FFFFFF">	 
		  <tr>
			<td align="left" height="20">
				�ĵ����⣺<input value="<%=docTitle%>" disabled type="text" name="docTitle">
			</td>
		  </tr> 
		  <tr>
			<td align="left" height="20">
				ʱ�䣺<input value="<%=subtime%>" disabled type="text" name="subtime">
			</td>
		  </tr>
		  <tr>
			<td align="left" height="20">
				���۷����ˣ�<input value="<%=userName%>" disabled type="text" name="userName">
			</td>
		  </tr>
		  <tr>
			<td align="left" height="20">
				���۷�����IP��<input value="<%=userIP%>" disabled type="text" name="userName">
			</td>
		  </tr>
		  <tr>
			<td align="left" height="20">
				�������ݣ�
			</td>
		  </tr>
		  <tr>
			<td align="left" height="150">		
				<textarea name="docComment" cols="60" rows="23"><%=docComment%></textarea>
			</td>
		  </tr>
		  <tr>
			  <td align="center" height="20">
			  	<%if(status==0 || status==2){%>
					<input name="cancelForm" type="button" value="����" class="cms_button" onClick="publishComments()"/>
				<%}else if(status==1){%>
					<input name="cancelForm" type="button" value="����" class="cms_button" onClick="withdrawPubComments()"/>
				<%}%>
					<input name="cancelForm" type="button" value="ɾ��" class="cms_button" onClick="deleteC()"/>
					<input name="cancelForm" type="button" value="����" class="cms_button" onClick="window.close()"/>
			  </td>
		  </tr>
		  <tr>
		  </tr>
		</table>
	</form>
	<div height=0 width=0 style="display:none">
		<iframe name="seeCommentIframe"></iframe>
	</div>
</body>
</html>
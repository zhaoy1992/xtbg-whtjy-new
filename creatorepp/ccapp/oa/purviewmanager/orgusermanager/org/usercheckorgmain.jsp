<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String userID = StringUtil.replaceNull(request.getParameter("checkBoxOne"),"");
	String orgID = StringUtil.replaceNull(request.getParameter("orgId"),"");
 %>
<html>
	<head>
		<title>�û�����</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<% if(control.isAdmin()){ %>
			<iframe id="menuissuemain" src="usercheckorgselect.jsp?userID=<%=userID %>&&orgID=<%=orgID %>" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		<%}else{ %>
		<table width="100%" border="0">
  			<tr>
    			<td align="center" nowrap="nowrap" style="color: #FF0000;">
    			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    			�Բ���Ȩ�޲���������ϵͳ����Ա��ݵ�¼��
    			<br /><br />
	    			<input type="button" class="input" value="�رմ���" onclick="window.close();"> 
    			</td>
  			</tr>
		</table>
		<%} %>
	</body>
</html>

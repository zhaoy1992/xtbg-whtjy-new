<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String issuetype = request.getParameter("issuetype")!=null?request.getParameter("issuetype"):"";
 %>
<html>
	<head>
		<title>ģ�����</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<% if(control.isAdmin()){ %>
			<%if("exp".equals(issuetype.trim())){ %>
				<iframe id="menuissuemain" src="<%=request.getContextPath()%>/eppissue/menuissue/expmenu/expmenuselect.jsp" width="100%" height="100%" frameborder="0"></iframe>
			<%}else if("imp".equals(issuetype.trim())){ %>
				<iframe id="menuissuemain" src="<%=request.getContextPath()%>/eppissue/menuissue/impmenu/impmenuinfo.jsp" width="100%" height="100%" frameborder="0"></iframe>
			<%}else{ %>
				<table width="100%" border="0">
	  			<tr>
	    			<td align="center" nowrap="nowrap" style="color: #FF0000;">
	    			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	    			�Բ��𣡲���������رմ������¿�ʼ��
	    			<br /><br />
	    			<input type="button" class="input" value="�رմ���" onclick="window.close();"> 
	    			</td>
	  			</tr>
			</table>
			<%} %>
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

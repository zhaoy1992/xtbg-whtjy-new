<%
/**
 * 
 * <p>Title: �ֵ���Ȩ���ҳ��</p>
 *
 * <p>Description: �ֵ���Ȩ���ҳ��-�ұ���ʾ�ֵ������ұ���ʾ�ֵ������</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = "";
	if(role_type.equals("user")){
		currOrgId = request.getParameter("currOrgId");
	}
	String isBatch = request.getParameter("isBatch");
	
%>
<html>
<frameset name="dictFrame" cols="30,70" frameborder="no" border="0" framespacing="0" >
  	<frame src="dictsetTree.jsp?resTypeId=dict&currRoleId=<%=currRoleId%>&currOrgId=<%=currOrgId%>&role_type=<%=role_type%>&isBatch=<%=isBatch %>" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
  	<frame src="operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
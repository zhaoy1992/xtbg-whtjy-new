<%
/*
 * <p>Title: ��Ϣ��ʾҳ��</p>
 * <p>Description: ��Ϣ��ʾҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
%>

<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder">
			<center>
				<br>
				<table>
					<tr>
						<td class="td">
							�������ѡ����Ӧ��Դ���в���
						<td>
					<tr>
				</table>
			</center>
		</div>
	</body>
</html>

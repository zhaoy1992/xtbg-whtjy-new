<%
/*
 * <p>Title: ��Դѡ����</p>
 * <p>Description: ��Դѡ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);

	String roleId = request.getParameter("roleId");
	session.setAttribute("currRoleId", roleId);
	session.setAttribute("role_type", "role");
%>

<html>
	<head>
		<title>��������</title>
		<script language="javascript" src="../scripts/changeView.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder">
			<table class="table" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">

				<tr class="tr">
					<td width="25%" class="td">
						<select class="select" name="select" onChange="changeView('select')">
							<option selected>
								--��ѡ����Դ--
							</option>
							<option value="site" link="resSiteTree.jsp">
								վ����Դ
							</option>
							<option value="channel" link="resChannelTree.jsp">
								Ƶ����Դ
							</option>
							<option value="column" link="../userorgmanager/user/resColumnTree.jsp">
								�˵���Դ
							</option>
							<option value="res" link="resResourcTree.jsp">
								��Դ����Դ
							</option>
						</select>
					</td>
				</tr>
				<tr height="100%" width="100%">
					<td height="100%" width="100%">
						<iframe id="resource_bridge" frameborder="0" 
							name="resource_bridge" src="" height="100%" width="100%" />
					</td>
				</tr>

			</table>

		</div>
	</body>
</html>

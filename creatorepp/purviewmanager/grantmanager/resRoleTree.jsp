<%
/**
 * 
 * <p>Title: ��ɫ��Դtabҳ��</p>
 *
 * <p>Description: ��ɫ��Դtabҳ�棬��ɫ��ȫ��ȫ���������ɫ����Ȩ������</p>
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
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	//Ȩ����������  ��������role��user
	String role_type = request.getParameter("role_type");
	
	//�Ƿ�����Ȩ������ true����Ȩ�����裻false����Ȩ������
	String isBatch = request.getParameter("isBatch");
	
	//currRoleId��ǰѡ����ȨID  ��������IDΪuser��role��ID������role_type������  ���������Ȩ��������user��role��ID��","�ָ�
	String currRoleId = request.getParameter("currRoleId");
	
	//�û���������ID
	String orgId = "";
	if(role_type.equals("user")){
		orgId = request.getParameter("orgId");
	}
	
	StringBuffer url = new StringBuffer()
		.append("operList_global.jsp?resTypeId=role&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
	StringBuffer lefturl = new StringBuffer()
		.append("rolesetTree.jsp?resTypeId=role&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
		
%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="roleResFrame" selectedTabPaneId="roleGlog_res" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="roleGlog_res" tabTitle="��ɫȫ��Ȩ��" lazeload="true">
						<tab:iframe id="roleGlogRes" src="<%=url.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="roleset_res" tabTitle="��ɫ����Ȩ��" lazeload="true">
						<tab:iframe id="rolesetRes" src="<%=lefturl.toString()%>" frameborder="0" scrolling="no"  width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>
<%@ page language="java" import="java.util.*
								,com.frameworkset.util.StringUtil,com.chinacreator.sysmgrcore.entity.*
								,com.chinacreator.sysmgrcore.manager.*" pageEncoding="GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<script language="JavaScript">
alert("����������Ϣ�ɹ���");
</script>
<%
	String action = StringUtil.replaceNull(request.getParameter("action"));
	
	System.out.println("action:" + action);
	
	String parentId = StringUtil.replaceNull(request.getParameter("parentId"));
	String orgId=request.getParameter("orgId");
	String resName = request.getParameter("resName");
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization org = orgManager.getOrgById(orgId);

	if (orgId.equals("0")) {
		org = new Organization();
		org.setOrgName("������");
	}
	
	session.setAttribute("Organization", org);
	
	String redirect = "getPropertiesContent().location.href = \"" + request.getContextPath() + "/sysmanager/orgmanager/orginfo.jsp?orgId="+ orgId +"&action="+ action +"&parentId="+ parentId +"&resName="+ resName +"\";";
%>

<script language="javascript">
	<%=redirect%>
</script>

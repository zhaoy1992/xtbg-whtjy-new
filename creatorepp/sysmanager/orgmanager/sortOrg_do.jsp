<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%
	String orgId = request.getParameter("orgId");//机构id
	String orgIdsStr = request.getParameter("orgIds");//机构orgName
	String[] orgIds = orgIdsStr.split(",");

	boolean flag = false;//System.out.println(orgIds.length);
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	flag = orgManager.sortOrg(orgId,orgIds);
	if(flag)
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("操作成功！");
	window.dialogArguments.location.href = window.dialogArguments.location.href;
	window.close();
</SCRIPT>
<%
	}
	else
	{
%>
<SCRIPT LANGUAGE="JavaScript">
	alert("操作失败！");
</SCRIPT>
<%
	}
%>

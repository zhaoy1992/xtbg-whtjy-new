<%
/**
 * <p>Title: 子机构排序</p>
 * <p>Description: 子机构排序处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
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
<SCRIPT LANGUAGE="JavaScript">
	window.onload = function prompt(){
        parent.divProcessing.style.display="none";
        parent.document.getElementById("saveButton").disabled = false;
		parent.document.getElementById("backButton").disabled = false;
		parent.document.getElementById("button1").disabled = false;
		parent.document.getElementById("button2").disabled = false;
		parent.document.getElementById("button3").disabled = false;
		parent.document.getElementById("button4").disabled = false;
    }
</SCRIPT>

<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%
	String displayNameInput=request.getParameter("displayNameInput");
	String displayValueInput=request.getParameter("displayValueInput");
	String pkgId = request.getParameter("pkgId");
	String procDefId = request.getParameter("procDefId");
	String actorId = request.getParameter("actorId");
	String procDefName = request.getParameter("procDefName");
    if (procDefName == null)
        procDefName = (String) request.getAttribute("procDefName");
    String pkgName = request.getParameter("pkgName");
    if (pkgName == null)
        pkgName = (String) request.getAttribute("pkgName");
	String enProcDefId = "";
            if (procDefId != null)
            {
                enProcDefId = StringUtil.encode(procDefId);
            } else
            {
                enProcDefId = procDefId;
            }
            procDefId = enProcDefId;
			
%>
<html>
<head>
<title>—°‘Ò»À‘±</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<frameset name="frame1" cols="0,30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="frame_bridge.jsp" name="frame_bridge" scrolling="No" noresize="noresize" id="frame_bridge" />
  <frame src="orgTree.jsp" name="orgTree" id="orgTree" />
  <frame src="userList.jsp?displayNameInput=<%=displayNameInput%>&pkgId=<%=pkgId%>&procDefId=<%=procDefId%>&actorId=<%=actorId%>&displayValueInput=<%=displayValueInput%>&procDefName=<%=procDefName%>&pkgName=<%=pkgName%>" name="userList" scrolling="No" noresize="noresize" id="userList" />  
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

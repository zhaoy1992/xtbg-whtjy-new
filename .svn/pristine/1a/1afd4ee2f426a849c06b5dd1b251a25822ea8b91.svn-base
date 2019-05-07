<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);	
	
	String did = request.getParameter("did");
	String docid = request.getParameter("docid");
	String[] doc = docid.split(",");
	DictManager dictManager = new DictManagerImpl();
	boolean state = dictManager.updateDictArr(did, doc);
%>

<script>
	if(<%=state%>){
		alert("±£¥Ê≈≈–Ú≥…π¶£°");
		parent.dictList.document.location.href = parent.dictList.document.location.href;
	}else{
		alert("±£¥Ê≈≈–Ú ß∞‹£°");
		parent.dictList.document.location.href = parent.dictList.document.location.href;
	}
</script>
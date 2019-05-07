<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);	
	
	String did = request.getParameter("did");
	String dictdataValue = request.getParameter("dictdata");
	String docid = request.getParameter("docid");
	String[] doc = docid.split(",");
	DictManager dictManager = new DictManagerImpl();
	boolean state = dictManager.updateDictArrTree(did, dictdataValue, doc);
%>

<script>
	if(<%=state%>){
		alert("±£¥Ê≈≈–Ú≥…π¶£°");
		parent.afterAddRefresh();
	}else{
		alert("±£¥Ê≈≈–Ú ß∞‹£°");
	}
</script>
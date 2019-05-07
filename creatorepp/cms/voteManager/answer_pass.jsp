<%@ page contentType="text/html; charset=GBK" language="java"  %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>

<html>
<head><title>网上调查审核</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="Mon, 23 Jan 1978 20:52:30 GMT">
<style type="text/css">
<!--
.STYLE2 {	color: #263F77;
	font-weight: bold;
}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<% 
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
	
	
	    String id = request.getParameter("id");
		if (request.getParameter("answerIDs")!=null&&!"".equals(request.getParameter("answerIDs"))){
    	VoteManager voteMgr  = new VoteManagerImpl();
    	
  		if ("pass".equals(request.getParameter("actionType"))){
  		
  			if(voteMgr.passAnswers(request.getParameter("answerIDs"),accesscontroler.getUserAccount(),accesscontroler.getUserName(),request.getRemoteAddr())==1){
		
%>
<SCRIPT>
	window.alert("审核成功");
	var str = parent.document.location.href;
	
	var end = str.indexOf("?");
	var strArray;
	if(end != -1)
	 	strArray= str.slice(0,end);
	else
		strArray = str;
	parent.document.location.href = strArray+"?" + parent.document.all.queryString.value;
</SCRIPT>
<%
		}
		else
		{
%>
<SCRIPT>
	window.alert("审核失败");
</SCRIPT>
<%			
		}
	}
	}
%>
</html>
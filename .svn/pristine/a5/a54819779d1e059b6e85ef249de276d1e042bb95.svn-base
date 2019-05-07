<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>

<html>
<head><title>ÍøÉÏµ÷²éÉ¾³ı</title>
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
	
	boolean ret = false;
	//É¾³ı²Ù×÷
	    String id = request.getParameter("id");
		if (request.getParameter("answerIDs")!=null&&!"".equals(request.getParameter("answerIDs"))){
    	VoteManager voteMgr  = new VoteManagerImpl();
  		if ("delete".equals(request.getParameter("actionType"))){
  			if(voteMgr.delAnswers(request.getParameter("answerIDs"),accesscontroler.getUserAccount(),accesscontroler.getUserName(),request.getRemoteAddr())==1){
		
%>
<SCRIPT>
	window.alert("É¾³ı³É¹¦");
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
	window.alert("É¾³ıÊ§°Ü");
</SCRIPT>
<%			
		}
	}
	}
%>
</html>
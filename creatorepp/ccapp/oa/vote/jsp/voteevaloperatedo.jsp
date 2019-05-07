<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	boolean flag = false;
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	String windowId=request.getParameter("windowId");
	String path = request.getContextPath();
	
	VoteViewService voteViewService = new VoteViewServiceImpl();
	flag = voteViewService.saveEvalVote(request);
 %>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
var mes = "";
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	removeWindows('<%=windowId%>',true,false,true);
}
if(bool){
	window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
}else{
	window.top.alert(mes);
}
</script>
<body>
</body> 
</html>
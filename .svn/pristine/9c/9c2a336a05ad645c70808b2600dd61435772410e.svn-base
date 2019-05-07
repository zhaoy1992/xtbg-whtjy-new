<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
String basePath = request.getContextPath()+"/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>提前结束</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">
	
	<script type="text/javascript" src="<%=basePath%>delegate/prototype-1.4.0.js"></script>
	<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
	<script>
	function docancel(p)
	{
	var url = '<%=basePath%>delegate/docancel.jsp';
	var pars = 'id=' + p + '&flag=1&nowtime=' + new Date().getTime();
	var myAjax = new Ajax.Request(
	url,
	{
	method: 'get',
	parameters: pars,    //Loading, Loaded, Interactive
	onComplete: showResponse
	});
	}
	function showResponse(originalRequest)
	{
	//put returned XML in the textarea
	var restr=originalRequest.responseText;
	if(restr.replace(/\s+/g,"")=="success"){
	alert("操作成功！");
	window.location.href='showdelegate.jsp';
	}else if(restr.replace(/\s+/g,"")=="errmsg"){
	alert('取消操作成功，但是通知消息发送失败！');
	}else{
	alert('操作失败！！'+restr);
	}
	}

</script>
	
 
  </head>
 	<%
 	String id=request.getParameter("id");
  	%>
		<%@ include file="/epp/css/cssControl.jsp"%>
  <body>
  <br>
   <br>
    <div align="center">
   <h3> <font color="red">该委派已经被接受和进行中，你不能修改任务信息，只能取消委派，若要取消委派可以点击下面按钮 </font></h3>
 
  <input type="button" value="&nbsp;&nbsp;&nbsp;取消委派&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="docancel(<%=id %>);"/>
 	<input type="button" value="&nbsp;&nbsp;&nbsp;返&nbsp;&nbsp;回&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="javascript:window.location.href='showdelegate.jsp'"/>
  </div>
  </body>
</html>

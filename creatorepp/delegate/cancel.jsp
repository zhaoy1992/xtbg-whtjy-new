<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
String basePath = request.getContextPath()+"/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>��ǰ����</title>
    
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
	alert("�����ɹ���");
	window.location.href='showdelegate.jsp';
	}else if(restr.replace(/\s+/g,"")=="errmsg"){
	alert('ȡ�������ɹ�������֪ͨ��Ϣ����ʧ�ܣ�');
	}else{
	alert('����ʧ�ܣ���'+restr);
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
   <h3> <font color="red">��ί���Ѿ������ܺͽ����У��㲻���޸�������Ϣ��ֻ��ȡ��ί�ɣ���Ҫȡ��ί�ɿ��Ե�����水ť </font></h3>
 
  <input type="button" value="&nbsp;&nbsp;&nbsp;ȡ��ί��&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="docancel(<%=id %>);"/>
 	<input type="button" value="&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;" class="input"  style="cursor:hand" onclick="javascript:window.location.href='showdelegate.jsp'"/>
  </div>
  </body>
</html>

<%@ page pageEncoding="GBK" import="com.chinacreator.message.MessageFactory
				,com.chinacreator.message.Message
				,org.apache.commons.lang.StringUtils
				,com.chinacreator.security.AccessControl
				,com.chinacreator.message.util.*
				" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
  </head>
  <%@ include file="/epp/css/cssControl.jsp"%><body>
    <%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    //获得应用ID

	String from = accesscontroler.getUserAccount();
	String title = request.getParameter("title");
	String receivers = request.getParameter("receiver_name");
	String content = request.getParameter("content");
	String box = StringUtils.defaultString(request.getParameter("box"));
	System.out.println(title.length());
    Message message = MessageFactory.getMessageInstance();
	int flag = message.send(from, receivers, title, content,3);

    if(flag == Integer.parseInt(MsgConfig.getProperties("SYS_SEND_SUCCESS"))){
    %>
    <script type="text/javascript" language="javascript">
    	alert("发送成功！");
    	window.location.href = "showMessage.jsp?box=send_box";
    </script>
    <%} else if(flag == Integer.parseInt(MsgConfig.getProperties("SYS_CONTENT_NULL"))) {%>
    <script type="text/javascript" language="javascript">
    	alert("发送失败，内容不能为空");
    	window.location.href = "showMessage.jsp?box=<%=box%>";
    </script>
    <%} else if(flag ==Integer.parseInt(MsgConfig.getProperties("SYS_CONTENT_TOLONG"))) {%>
    <script type="text/javascript" language="javascript">
    	alert("发送失败，内容不能超过<%=MsgConfig.getProperties("SYS_CONTENT_LIMIT")%>个字符");
    	window.location.href = "showMessage.jsp?box=<%=box%>";
    </script>
    <%} else {%>
    <script type="text/javascript" language="javascript">
    	alert("发送失败，请重新发送");
    	window.location.href = "showMessage.jsp?box=<%=box%>";
    </script>
    <%}%>
  </body>
</html>

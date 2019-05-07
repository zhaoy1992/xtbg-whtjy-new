<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.message.website.WebsiteMessageBusiness,
				com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title>deleteSend.jsp</title>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body>
  <%
  String box = request.getParameter("box");
  String[] ids = request.getParameterValues("checkBoxOne");
  WebsiteMessageBusiness messageBusiness = new WebsiteMessageBusiness();
  boolean flag = false;
  if(box.equals("receive_box")){
  		flag = messageBusiness.deleteReceive(ids);	  
  }else if(box.equals("send_box")){
  		flag = messageBusiness.delete_send(ids);
  }else if(box.equals("nosend_box")){
  		flag = messageBusiness.delete_nosend(ids);
  }else if(box.equals("receive_deleted_box")){
  		flag = messageBusiness.delete_deletedReceive(ids);
  }
  if(flag){
  %>
  <script type="text/javascript" language="javascript">
    	alert("删除成功！");
    	var url = "showMessage.jsp?box=<%=box%>";
    	window.location.href=url;
    </script>
    <%}else{%>
    <script type="text/javascript" language="javascript">
    	alert("删除失败，请稍后再试！");
    	history.back();
    </script>
    <%}%> 
  </body>
</html>


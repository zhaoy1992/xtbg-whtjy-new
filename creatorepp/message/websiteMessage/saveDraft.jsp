<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.message.website.WebsiteMessageBusiness,com.chinacreator.message.website.WebsiteMessageForm,
				org.apache.commons.lang.StringUtils,
				com.chinacreator.security.AccessControl"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>saveDraft.jsp</title>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body>
    <%

    AccessControl accessController = AccessControl.getInstance();
    accessController.checkAccess(request,response);

    String draftId = "";
    String id = StringUtils.defaultString(request.getParameter("id"));
    String box = StringUtils.defaultString(request.getParameter("box"));
    String receiver_name = StringUtils.defaultString(request.getParameter("recnames"));

    String receiver_id = StringUtils.defaultString(request.getParameter("receiver_name"));
    String title = StringUtils.defaultString(request.getParameter("title"));
    String content = StringUtils.defaultString(request.getParameter("content"));    

	//accessController.checkAccess(session);

    String sender_id = StringUtils.defaultString(accessController.getUserID());
    String sender_name = StringUtils.defaultString(accessController.getUserName());    
    WebsiteMessageForm form = new WebsiteMessageForm();
    form.setId(id);
    form.setReceiver_name(receiver_name);
    form.setReceiver_id(receiver_id);
    form.setTitle(title);
    form.setContent(content);
    form.setSender_id(sender_id);
    form.setSender_name(sender_name);
    System.out.println("form.getReceiver_name"+form.getReceiver_name());
    System.out.println("form.getReceiver_id"+form.getReceiver_id());
    WebsiteMessageBusiness messageBusiness = new WebsiteMessageBusiness();
    if (id!=null && !id.equals("") && box!=null && box.equals("nosend_box")) {
    	try {
    		draftId = messageBusiness.saveNoSendMessage(form);
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    } else {
    	try {
    		draftId = messageBusiness.saveEditMessage(form);
    	} catch(Exception e) {
    		e.printStackTrace();
    	}    	
    }
    
    if(draftId!= null && !draftId.equals("")){
    %>
    <script type="text/javascript" language="javascript">
    	alert("保存成功！");
    	window.location.href = "showMessage.jsp?box=<%=box%>";
    </script>
    <%
    }else{%>
    <script type="text/javascript" language="javascript">
    	alert("保存失败，请重新保存！");
    	window.location.href = "showMessage.jsp?box=<%=box%>";
    </script>
    <%}%>
  </body>
</html>

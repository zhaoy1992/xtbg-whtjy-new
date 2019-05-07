<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.message.vo.MessageResource,
                 com.chinacreator.message.dbmanager.UserMessageResourceManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String user_id = control.getUserID();
	
	String[] msgTypesArr = request.getParameterValues("msgType");
	String msgTypes = "";
	if(msgTypesArr!=null){
		for(String msgType : msgTypesArr){
			msgTypes += msgType+",";
		}
	}
	if(msgTypes.length()>0&&!"".equals(msgTypes)){ 
		msgTypes = msgTypes.substring(0,msgTypes.length()-1);
	}
	// 获得传递参数
	String r_name = request.getParameter("r_name");
	String r_desc = request.getParameter("r_desc");
	/*String r_sms = request.getParameter("r_sms");
	String r_sys = request.getParameter("r_sys");
	String r_rtx = request.getParameter("r_rtx");*/

	String r_id = request.getParameter("r_id");
	String r_state = request.getParameter("r_state");

	MessageResource messageResource = new MessageResource();
	messageResource.setR_id(r_id);
	messageResource.setR_name(r_name);
	messageResource.setR_desc(r_desc);
	messageResource.setR_sms(msgTypes);
	messageResource.setR_sys("");
	messageResource.setR_rtx("");
	/*messageResource.setR_sms(r_sms);
	messageResource.setR_sys(r_sys);
	messageResource.setR_rtx(r_rtx);*/
	messageResource.setR_state(r_state);

	UserMessageResourceManager userMessageResourceManager = new UserMessageResourceManager();

    boolean isSuccess = userMessageResourceManager.updateMessageResource(messageResource, user_id);
    if(isSuccess) {
    %>
        <script language="javascript">
         alert("设置成功!");
         parent.returnValue = 'refresh';
         window.close();
        </script>
   <%
   } else {
   %>
       <script language="javascript">
         alert("设置失败，请稍后再试！");
         window.close();
        </script>
   <%
   }
%>
<script>
    window.onload = function prompt() {
    	parent.document.all.update.disabled=false;
		parent.document.all.calc[0].disabled=false;
		parent.document.all.calc[1].disabled=false;
        // parent.divProcessing.style.display="none";
    }
</script>
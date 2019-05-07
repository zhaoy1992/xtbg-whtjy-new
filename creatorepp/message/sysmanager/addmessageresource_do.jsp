<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.message.vo.MessageResource,
                 com.chinacreator.message.dbmanager.MessageResourceManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	// 获得传递参数
	String r_id = "";
	String[] msgTypesArr = request.getParameterValues("msgType");
	String msgTypesStr = "";
	for(int i = 0 ; i<msgTypesArr.length;i++){
		msgTypesStr += msgTypesArr[i]+",";
	}
	msgTypesStr = msgTypesStr.substring(0,msgTypesStr.length()-1);
	String r_name = request.getParameter("r_name");
	String r_desc = request.getParameter("r_desc");
	/*String r_sms = request.getParameter("r_sms");
	String r_sys = request.getParameter("r_sys");
	String r_rtx = request.getParameter("r_rtx");*/
	boolean isEdit = request.getParameter("isEdit")!=null&&request.getParameter("isEdit").equals("true");
	if(isEdit) {
		r_id = request.getParameter("r_id");
	}else{
	    r_id = System.currentTimeMillis()+"";
	}

	MessageResource messageResource = new MessageResource();
	messageResource.setR_id(r_id);
	messageResource.setR_name(r_name);
	messageResource.setR_desc(r_desc);
	messageResource.setR_sms(msgTypesStr);
	messageResource.setR_sys("");
	messageResource.setR_rtx("");

	MessageResourceManager messageResourceManager = new MessageResourceManager();
	if(!isEdit) {
		if(messageResourceManager.isExistByName(r_name)) {
		%>
		    <script language="javascript">
		        alert("消息资源名称已存在，请另外取名!");
		    </script>
	    <%
	    return;
	    } else {
	        r_id = messageResourceManager.addMessageResource(messageResource);

	        if(!"".equals(r_id)) {
	        %>
	            <script language="javascript">
		            alert("新增消息资源成功!");
		            parent.returnValue = 'refresh';
		            window.close();
	            </script>
	       <%
	       } else {
	       %>
	           <script language="javascript">
		            alert("新增消息资源失败!");
		            window.close();
	            </script>
	       <%
	       }
		}
	} else {

	        boolean isSuccess = messageResourceManager.updateMessageResource(messageResource);
	        if(isSuccess) {
	        %>
	            <script language="javascript">
		            alert("更新消息资源成功!");
		            parent.returnValue = 'refresh';
		            window.close();
	            </script>
	       <%
	       } else {
	       %>
	           <script language="javascript">
		            alert("更新消息资源失败!");
		            window.close();
	            </script>
	       <%
	       }
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
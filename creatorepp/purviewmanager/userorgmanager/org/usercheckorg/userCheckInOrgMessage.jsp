<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);
	boolean isExistsSecondEndUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isExistsSecondEndUserByAdmin(accesscontroler);
%>
<script type="text/javascript" src="<%=request.getContextPath() %>/purviewmanager/userorgmanager/org/usercheckorg/ie_messageBox.js"></script>
<script type="text/javascript">
	if("true"=="<%=isExistsSecondEndUser%>"){
		var url = "<%=request.getContextPath() %>/purviewmanager/userorgmanager/org/usercheckorg/userCheckInOrgBySecondEndUserMain.jsp";
		showMessage("userCheckInOrgMessage",
					200,
					100,
					"消息提示：",
					"您有到期未调回用户",
					"<a href='#' onclick='document.getElementById(\"btSysClose\").click();showModalDialog(\""+url+"\",\"window\",\"dialogWidth:800px;dialogHeight:600px;help:no;scroll:no;status:no;maximize=yes;minimize=0\");' >"
					+ "打开用户调回窗口"
					+ "</a>",
					120,
					10);
	}
</script>
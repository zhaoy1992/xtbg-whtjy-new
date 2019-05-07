<%--
描述：删除角色类型
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
String notice = "";
	try{
		AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkManagerAccess(request, response); //页面登录保护
		
		//删除操作
		RoleTypeManager rtm = new RoleTypeManager();
		String type_ids = StringUtil.deNull(request.getParameter("type_ids"));
		if ((type_ids != null) && (type_ids.length() > 0)) {
			StringTokenizer stValues = new StringTokenizer(type_ids, ";");
			while (stValues.hasMoreElements()) {
				String nextId = (String) stValues.nextElement();
				String name = rtm.getRoleType(nextId).getTypeName();
				if (rtm.hasRoles(nextId)) {//已经有角色的类别不能被删除
					notice = notice + "角色类型‘" + name + "’存在角色，不能被删除。\\n";
				} else {
					boolean delTag = rtm.delRoleType(nextId);
					if (!delTag) {
						notice = notice + "角色类型‘" + name + "’删除失败。\\n";
					} else {
						notice = notice + "角色类型‘" + name + "’删除成功。\\n";
					}
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script type="text/javascript">
var mes = "<%=notice %>";
var bool = true;

var ok=function(){
	window.parent.location.reload();
}

if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("windowsId"))%>',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok});
	}else{
		window.top.alert(mes);
	}
}
</script>

<%
/**
 * <p>Title: 删除角色类型页面</p>
 * <p>Description:删除角色类型类型列表页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK" language="java" errorPage="" %>
<%@ taglib   uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib   uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="java.util.*" %>
<html>
<head>
<title>角色类型删除</title>
<style type="text/css">
<!--
.STYLE2 {	color: #263F77;
	font-weight: bold;
}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%			
			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response); //页面登录保护

			boolean tag = true;
			String notice = "";

			//删除操作
			RoleTypeManager rtm = new RoleTypeManager();
			String id = request.getParameter("roletype_id");
			if ((id != null) && (id.length() > 0)) {
				StringTokenizer stValues = new StringTokenizer(id, ";");

				while (stValues.hasMoreElements()) {
					String nextId = (String) stValues.nextElement();
					String name = rtm.getRoleType(nextId).getTypeName();
					if (rtm.hasRoles(nextId))//已经有角色的类别不能被删除
					{
						notice = notice + "角色类型‘" + name + "’存在角色，不能被删除。\\n";
					} 
					else
					{
						boolean delTag = rtm.delRoleType(nextId);
						if(!delTag)
						{							
							notice = notice + "角色类型‘" + name + "’删除失败。\\n";
						}
						else
						{
							notice = notice + "角色类型‘" + name + "’删除成功。\\n";
						}
					}
				}
			}

		%>
<script language="javascript">
	window.alert("<%=notice%>");  
</script>
</body>
</html>
<SCRIPT>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        //这样确保在删除完成后刷新列表
        parent.document.all.roletypelist.src = 'roletypelist.jsp?typeName='+parent.document.all("typeName").value+'&typeDesc='+parent.document.all("typeDesc").value;
    }
</script>

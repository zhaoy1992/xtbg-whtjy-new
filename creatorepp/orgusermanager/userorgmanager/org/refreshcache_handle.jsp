<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdminCache"%><%
/**
 * 
 * <p>Title: ����,���Ź���Ա�ɹ������ˢ�»��崦��ҳ��</p>
 *
 * <p>Description: ����,���Ź���Ա�ɹ������ˢ�»��崦��ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-10-08
 * @author gao.tang
 * @version 1.0
 */
 %>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	//flagֵΪ1��ˢ�»������壻flagֵΪ2��ˢ�²��Ź���Ա�ɹ����������
	String flag = request.getParameter("flag");
	String errorMessage = "";
	if("1".equals(flag)){
		OrgCacheManager orgCacheManager = OrgCacheManager.getInstance();
		
		try{
			orgCacheManager.reset();
		}catch(Exception e){
			errorMessage = control.formatErrorMsg(e.getMessage());
		}
	}else if("2".equals(flag)){
		OrgAdminCache orgAdminCache = OrgAdminCache.getOrgAdminCache();
		try{
			orgAdminCache.reset();
		}catch(Exception e){
			errorMessage = control.formatErrorMsg(e.getMessage());
		} 
	}else if("3".equals(flag)){
		try{
			AccessControl.resetAuthCache();
		}catch(Exception e){
			errorMessage = control.formatErrorMsg(e.getMessage());
		}
		try{
			AccessControl.resetPermissionCache();
		}catch(Exception e){
			errorMessage += control.formatErrorMsg(e.getMessage());
		}
	}
%>
<script language="javascript">
<%if("".equals(errorMessage)){ %>
	alert("�����ɹ���");
	parent.parent.location.href = parent.parent.location.href;
<%}else{ %>
	alert("����ʧ�ܣ�ԭ�����£�\\n<%=errorMessage %>");
<%} %>
</script>
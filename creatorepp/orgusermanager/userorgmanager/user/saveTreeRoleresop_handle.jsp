<%
/**
 * 
 * <p>Title: ����--������Դ</p>
 *
 * <p>Description: ����--������Դ����ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
 <%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil,
			com.chinacreator.security.AccessControl,
			com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl,
			com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
			
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String[] checkedValues = request.getParameterValues("checkboxValue");
	String opId = request.getParameter("opId");
	
	PurviewManager purviewManager = new PurviewManagerImpl();
	
	boolean state = purviewManager.batchSaveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type);
%>		
<%
	if(state){
%>
<script language="Javascript">
	alert("�����ɹ���");
</script>
<%}else{%>
<script language="Javascript">
	alert("��Ȩʧ�ܣ�");
</script>
<%}%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.GroupAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>

<%

		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
	
			
		String resTypeId = request.getParameter("resTypeId");
		String resId = request.getParameter("resId");
		String opId = request.getParameter("opId");
		String checked = request.getParameter("checked");
		String title = request.getParameter("title");
		String isRecursion = request.getParameter("isRecursion");
		


		//--�û������д������־
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="�û������";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String resName_log = LogGetNameById.getResNameByResId(resId);
		operContent=userName+"�����û���("+title+")��������Ȩ"; 		
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");       
		//--	
		out.println(GroupAction.groupRoleOper(resId,resTypeId,opId,checked,title,isRecursion));
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.kettle.mq.MqNode"%>
<%@page import="com.chinacreator.kettle.mq.MqNodeDo"%>
<%
		try { 
			MqNode base = new MqNode();
			String NODE_NAME = request.getParameter("NODE_NAME");
			String SERVER    = request.getParameter("SERVER");
			String TARGET   = request.getParameter("TARGET");
			String USERNAME    = request.getParameter("USERNAME");
			String PASSWORDS    = request.getParameter("PASSWORDS");
			String REMARK    = request.getParameter("REMARK");
			String ID    =request.getParameter("NODEID");
			base.setNODE_NAME(NODE_NAME);
			base.setSERVER(SERVER);
			base.setTARGET(TARGET);
			base.setUSERNAME(USERNAME);
			base.setPASSWORDS(PASSWORDS);
			base.setREMARK(REMARK);
			base.setNODE_ID(ID);
			MqNodeDo mnd = new MqNodeDo();
			
			if(mnd.modifyNode(base)) {				
		 	%>
		 	<script type="text/javascript">
				alert("�����ɹ�!");
				window.location.href="mq-configure.jsp";
			</script>
		 	<%
			}else {
				%>
			 	<script type="text/javascript">
					alert("����ʧ��!");
					window.location.href="mq-configure.jsp";
				</script>
		 	<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
 %>
	
	  
	
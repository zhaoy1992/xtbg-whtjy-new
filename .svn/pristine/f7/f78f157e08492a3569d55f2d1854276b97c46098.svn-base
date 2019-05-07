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
			//base.setNODE_ID(db.getString(i, "NODE_ID"));
			base.setNODE_NAME(NODE_NAME);
			base.setSERVER(SERVER);
			base.setTARGET(TARGET);
			base.setUSERNAME(USERNAME);
			base.setPASSWORDS(PASSWORDS);
			base.setREMARK(REMARK);
			MqNodeDo mnd = new MqNodeDo();
			int landId = mnd.addNode(base);
			if(landId > 0) {				
		 	%>
		 	<script type="text/javascript">
				alert("操作成功!");
				window.location.href="mq-configure.jsp";
			</script>
		 	<%
			}else {
				%>
			 	<script type="text/javascript">
					alert("操作失败!");
					window.location.href="mq-configure.jsp";
				</script>
		 	<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
 %>
	
	  
	
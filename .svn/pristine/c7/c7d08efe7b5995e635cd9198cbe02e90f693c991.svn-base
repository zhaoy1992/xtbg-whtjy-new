<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%String actionType = request.getParameter("actioinType");
			VoteManager vote = new VoteManager();
			String[] id = request.getParameterValues("checkBoxOne");
			if (actionType.equals("delete")) {
				//out.println(actionType);
				if (id != null) {
					int i = vote.deleteVote(id);
					if (i == 1) {

						out.println("<script language='javascript'>alert('É¾³ý³É¹¦£¡'); self.location='votelist.jsp';</script>");
					} else {
						out.println("<script language='javascript'>alert('É¾³ýÊ§°Ü£¡');</script>");
					}
				}
			} else if (actionType == "modify") {
				//out.println("<script language='javascript'>self.location='modify.jsp?id=';</script>");
			}

		%>

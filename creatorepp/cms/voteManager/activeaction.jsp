<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%
String[] id=request.getParameterValues("lang");
VoteManager vote = new VoteManager();
boolean flag=false;  
            if (id != null) {
			  flag=vote.updateActiveVote(id);
			    //out.print(idd);
			    
			    }
			    
	   if (flag){
			
			out.println("<script language='javascript'>alert('设置投票主题成功！！'); self.location='votelist.jsp';</script>");
		} else {
			out.println("<script language='javascript'>alert('设置投票主题失败！！');</script>");
		}			

%>

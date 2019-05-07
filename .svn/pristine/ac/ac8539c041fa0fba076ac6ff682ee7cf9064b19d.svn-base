<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
String id=request.getParameter("id");
String flag=request.getParameter("flag");
if(flag!=null && "accept".equals(flag)){//接受委派
	String s=DelegateService.getInstance().confirmDelegate(id);
	out.print(s);
}
if(flag!=null && "reject".equals(flag)){//拒绝委派
	String s=DelegateService.getInstance().rejectDelegate(id);
	out.print(s);
}
%>
<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
String s=request.getParameter("flag");
String id=request.getParameter("id");
if("1".equals(s)){
//ÌáÇ°½áÊø
String s0=DelegateService.getInstance().endDelegate(id);
out.print(s0);
}else{
String s1=DelegateService.getInstance().cancelDelegate(id);
out.print(s1);
}
%>
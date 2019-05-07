<%@ page language="java" import="java.text.*, java.util.*,com.chinacreator.epp.delegate.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil" pageEncoding="GBK"%>
<%
String id=request.getParameter("id");
String uname=request.getParameter("uname");
if(id==null || "".equals(id.trim()) || uname==null || "".equals(uname.trim())){//½ÓÊÜÎ¯ÅÉ
	out.print("error");
}else{
boolean b=DelegateUtils.hasPartManagePriv(id,uname);
if(b){
	out.print("success");
	}else{
	out.print("noautho");
	}
}

%>

<%@page import="com.chinacreator.epp.reportmanage.cache.ReportCacheManager"%><%
try{
String filledString = request.getParameter("filledString");
Long d= System.currentTimeMillis();
		String s= Long.toBinaryString(d);
		ReportCacheManager.getInstance().cacheObject(s,filledString);
out.print(s);
}catch(Exception e){
	out.print("error");
}

%>


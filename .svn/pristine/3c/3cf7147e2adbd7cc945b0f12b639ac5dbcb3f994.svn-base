<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<script src="js/fcpub.js"></script>	
<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String op = request.getParameter("op");
		String eformClassId = request.getParameter("eformClassId");
		String recursion = request.getParameter("recursion");
		//System.out.println("eformClassId:"+eformClassId);
		//System.out.println("recursion:"+recursion);
%>
<script type="text/javascript">
    var thisEformClassId = "<%=eformClassId%>";
    var url = location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=publishFormBat&eformClassId="+thisEformClassId+"&recursion="+<%=recursion%>;
	var retX = SendHttp(url);
	alert(retX);
	var url = document.referrer;
	parent.window.location.replace(url);
</script>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
%>
<html>
    <%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
    <br><br>
    <p align="center"><strong><--ÇëÑ¡Ôñ×ÖµäÀàÐÍ</strong>
    </body>
</html>


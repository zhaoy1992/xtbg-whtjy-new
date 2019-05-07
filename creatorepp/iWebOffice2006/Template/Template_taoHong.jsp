<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);

			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			String flag = request.getParameter("flag");
			String fileType = request.getParameter("fileType");
%>
<html>
	<head>
		<title>ДЈ°е№ЬАн</title>
	</head>
	<frameset name="userOrgFrame" cols="18%,*" border=0 framespacing="0">
		<frame frameborder=1 scrolling="yes" name="org_tree" src="../../eformsys/fceform/WebOffice_orgTree_taoHong.jsp?fileType=<%= fileType%>" marginWidth=0 marginHeight=0 >
		</frame>
		<frame frameborder=1 scrolling="no" name="org_templateList" src="../../eformsys/fceform/WebOffice_content_taoHong.jsp?fileType=<%= fileType%>" marginWidth=0 marginHeight=0 >
		</frame>
	</frameset>
</html>

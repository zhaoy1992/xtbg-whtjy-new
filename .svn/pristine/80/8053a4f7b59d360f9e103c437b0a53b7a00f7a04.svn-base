<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
%>
<html>
	<frameset cols="25%,*" border=0>
	<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="chanenl_tree" src="channel_tree.jsp"></frame>
	<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="chn_doc_list" src="publicInfoList.jsp"></frame>
	</frameset>
</html>
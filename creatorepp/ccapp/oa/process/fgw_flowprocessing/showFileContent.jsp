<%@page import="java.util.UUID"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html; charset=utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserName();
	String orgId = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	String path = request.getContextPath();
	//正文ID
	String textId = request.getParameter("textId");
	String windowId = request.getParameter("windowId");
%>
<title></title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<!-- 公共部分引用结束 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf_8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf_8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
var document_recordid="<%=textId%>";
jQuery(function() {
	jQuery("#iframe_iwebOffice").attr("src","<%=path%>/ccapp/oa/archive/iwebofficequery.jsp?RecordID="+document_recordid);
});

</script>
</head>
<body style="overflow-x:hidden;overflow-y:auto;height: 100%"  >
	<form id="form1" name="form1" method="post" >
		<!-- 表格-->
		<div id="vcenter" style="width: 100%; height: 100%;overflow: hidden; overflow-x: hidden; overflow-y: hidden;margin: 0 auto;" scrolling="yes" >
			<iframe id="iframe_iwebOffice" frameborder="0" scrolling="no" width="100%" height="820"></iframe>
		</div>
	</form>
</body>
</html>
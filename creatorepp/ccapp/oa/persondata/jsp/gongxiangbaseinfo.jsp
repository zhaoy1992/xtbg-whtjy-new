<%--
描述：个人资料基本信息
作者：邱炼
版本：1.0
日期：2013-08-14
--%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.impl.PsdataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.PsdataTypeService"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.PsdataBaseService"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.impl.PsdataBaseServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String doc_id = request.getParameter("doc_id");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入上传控件 -->
	<script type="text/javascript" src="../../resources/plug/iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/fileupload.js"   charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/util/jsonutil.js" ></script>
	<!-- 引入资料个人js -->
	<script type="text/javascript" src="../resources/js/psdata.js" ></script>
	
	<script type="text/javascript">
	var document_recordid = "<%=doc_id%>"
	function workflow(){
		var url ='<%=path%>/ccapp/oa/archive/newflowmain.jsp?';
		window.parent.location.href=url;
	}
	function notic(){
		var url ='<%=path%>/ccapp/xtbg/yimingju/announcement/jsp/announcementdrew.jsp?subid=gongxiang&document_recordid='+document_recordid;
		//window.parent.location.href=url;
		openWindows()
	}
	function email(){
		var url ='<%=path%>/ccapp/oa/archive/newflowmain.jsp?';
		window.parent.location.href=url;
	}
	function back(){
		var url ='<%=path%>/ccapp/oa/persondata/jsp/psdatabasemain.jsp';
		window.parent.location.href=url;
	}
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input type="button" class="but_y_01" value="返回" onclick="back();" id="btn_update"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="psdatabaseinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
<table>
	<tr>
		<td onclick="workflow()"><a href="#">公文</a></td>
	</tr>
	<tr>
		<td onclick="notic()"><a href="#">通知公告</a></td>
	</tr>
	<tr>
		<td onclick="email()"><a href="#">邮件</a></td>
	</tr>
</table>
</form>
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
<script>
if(jQuery("#vcenter").width()>jQuery("body").width()){<%--1024*?分辨率下,拉长divA宽度--%>
	jQuery("#divA").width(jQuery("#vcenter").width()+10);
}else{<%--1440*?分辨率下,缩短divA宽度,防止横向滚动条出现--%>
	jQuery("#divA").width(jQuery("body").width()-19);
}
</script>
</body>
<script type="text/javascript" >
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
</script>
</html>

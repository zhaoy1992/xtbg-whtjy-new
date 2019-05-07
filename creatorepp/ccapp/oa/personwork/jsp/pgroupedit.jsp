<%--  
描述：分组编辑
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.personwork.entity.PGroupBean"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String loginUserID = accesscontroler.getUserID();	
	String groupId = request.getParameter("groupId");
	
	//个人通讯录操作的service对象
    PersonInfoServiceIfc service = new PersonInfoServiceImpl();
	//根据分组id查询得到分组信息
	PGroupBean pgb = service.queryGroupByGroupId(groupId);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人通讯录分组管理</title>

<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"	href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery_dialog/jquery_dialog.css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js"	type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<script type="text/javascript">
$(function(){
	jQuery("#form1").validationEngine();
	$('body').keydown(function(e){
		if(e.which == 13) {
			var paramjosn = "";
			paramjosn = "{'groupID':'<%=groupId%>"+
				"','groupName':'" + $("#groupName").val()+"'}";
			$("#paramjosn").val(paramjosn);
			$("#form1").attr("target","hiddenFrame");
		}
	});
})
/**
 * 编辑分组信息
 */
function saveGroupInfo(){
	$('#form1').submit();
}

/**
 * 提交表单时操作函数
 */
function submit_from(){
	var paramjosn = "";
	paramjosn = "{'groupID':'<%=groupId%>"+
	"','groupName':'" + $("#groupName").val()+"'}";
	$("#paramjosn").val(paramjosn);

}
</script>
</head>
<body>
	<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr>
	    <td class="tj1">分组名称</td>
	  </tr>
	</table>
	<form id="form1" action="pgroupeditdo.jsp" method="post" onsubmit="submit_from()">
		<input type="hidden" id="paramjosn" name="paramjosn"/> 
		<input type="text" id="groupName" class="validate[required],maxSize[20] input_cx_title_283" value="<%=pgb.getGroupName() %>"/>
		<br/><br>
		<div class="cue_box_foot" >
			<input type="button" value='关闭' onclick="removeAlertWindows('windowId_1',true)" class="but_y_01"/>
			<input type="button" class="but_y_01" onClick="saveGroupInfo()" value="保存"/>
	  	</div>
	</form>
		
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
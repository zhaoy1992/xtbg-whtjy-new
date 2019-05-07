<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.demo.entity.InstanceBean"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String loginUserID = accesscontroler.getUserID();
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>公共通讯录新增</title>
<link rel="stylesheet" type="text/css" media="screen"
	href="../resources/css/priManageAdd.css" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->

<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"
	href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"
	type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
	type="text/javascript" charset="GBK">
	
</script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
	type="text/javascript" charset="GBK">
</script>

<script type="text/javascript">	
var loginUserID=<%=loginUserID%>;
$(function(){
	jQuery("#formAdd").validationEngine();
	$('body').keydown(function(e){
		if(e.which == 13) {
			var paramjosn = "";
			paramjosn = "{'loginUserID':'" +  loginUserID + 
			"','groupName':'" + $("#groupName").val()+"'}";
			$("#paramjosn").val(paramjosn);
			$("#formAdd").attr("target","hiddenFrame");
		}
	});
})


function ok() {
	var paramjosn = "";
	paramjosn = "{'loginUserID':'" +  loginUserID + 
	"','groupName':'" + $("#groupName").val()+"'}";
	$("#paramjosn").val(paramjosn);
	$("#formAdd").attr("target","hiddenFrame");
	$('#formAdd').submit();
}

function returnPage() {
	var url = "pGroup.jsp";
	location.href = url;
}
</script>
</head>
<body>
<div style="margin-top: 30px;text-align: center;">
	<form id="formAdd" method="post" action="pGroupAdddo.jsp">
	<input type="hidden" id="paramjosn" name="paramjosn"> 
	<div align="center">
		<span class="fontbold">请输入组名<font color=red>*</font>：</span>
		<input type="text" id="groupName" class="validate[required] cTextarea"></input><br/><br>
		<input class="cButton_Gray" id="submitBut" style="" type="button" onclick="ok()"  value="保存"></input>
	</div>
	</form>
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
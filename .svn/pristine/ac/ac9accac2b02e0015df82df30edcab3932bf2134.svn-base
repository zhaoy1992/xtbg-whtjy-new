<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.demo.entity.InstanceBean"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>
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
$(function(){
	jQuery("#formAdd").validationEngine();
})


function chooseActUser(id){
	var url = "";
	if(id=="leadName"){
		url = "../../tree/jsp/orgusertree.jsp?ischeck=true";
	}else{
		url = "../../tree/jsp/orgpersontree.jsp?ischeck=true";
	}
	var userObj= null;
	userObj = window.showModalDialog(url,"","dialogWidth=400px;dialogHeight=620px;center:yes;scroll:no");
	var name=userObj.name;
	var userID=userObj.id;
	if(id=="leadName"){
		$("#leadName").val(name);
		$("#leadsID").val(userID)
	}else{
		$("#persons").val(name);
		$("#personsID").val(userID);
	}
}

function ok() {
	var paramjosn = "";
	paramjosn = "{'leadName':'" +  $("#leadName").val()+ 
	"','persons':'" + $("#persons").val()+
	"','personsID':'"+$("#personsID").val()+
	"','leadsID':'"+$("#leadsID").val()+"'}";
	$("#paramjosn").val(paramjosn);
	var fm = document.getElementById("formAdd");
	fm.target = "hiddenFrame";
	$('#formAdd').submit();
}

function returnPage() {
	var url = "priManage.jsp";
	location.href = url;
}


</script>
</head>
<body>
<div style="margin-top: 30px;text-align: center;">
	<form id="formAdd" action="priManageAdddo.jsp" method="post">
	<input type="hidden" id="paramjosn" name="paramjosn"> 
	<input type="hidden" id="personsID"> 
	<input type="hidden" id="leadsID" > 
	
	<div class="divstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>领导姓名</span>
		<textarea id="leadName" class="validate[required] cTextarea" rows="4" cols="30" readonly="readonly"></textarea>
		<input class="cButton_4text" type="button" value="选择" onclick="chooseActUser('leadName')"/>
	 </div>
	 <br>
	<div class="divstyle">
		<span>可查看人员名单</span>
		<textarea id="persons" class="validate[required] cTextarea" rows="4" cols="30" readonly="readonly"></textarea>
		<input class="cButton_4text" type="button" value="选择" onclick="chooseActUser('persons')"/>
	</div>
	<div class="divbutton">
		<input class="cButton_4text" style="width: 100px" type="button" onclick="ok()" value="保存"></input>
	</div>
	</form>
	
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
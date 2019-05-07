<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.demo.entity.InstanceBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PriManageBean"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.PriManageServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.PriManageServiceImpl"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String leadID=request.getParameter("leadID");
	PriManageBean pBean=new PriManageBean();
	PriManageServiceIfc priManageService=new PriManageServiceImpl();
	pBean.setLeadID(leadID);
	pBean=priManageService.querySingle(pBean);	
	String flow_id = pBean.getLeadName();
	String persons=pBean.getPersons();
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
var flow_id='<%=flow_id%>';
var persons='<%=persons%>';
var leadID='<%=leadID%>';
$(function(){
	jQuery("#formAdd").validationEngine();
	$("#leadName").val(flow_id);
	$("#persons").val(persons);
})

/*
 * 选择用户树
 */
function chooseActUser(id){
	var url = "../../tree/jsp/orgpersontree.jsp?ischeck=true";
	var userObj= null;
	userObj = window.showModalDialog(url,"","dialogWidth=700px;dialogHeight=600px;center:yes");
	var name=userObj.name;
	var userID=userObj.id;
	if(id=="leadName"){
		$("#leadName").val(name);
		$("#leadsID").val(userID);
	}else{
		$("#persons").val(name);
		$("#personsID").val(userID);
	}
}
/*
 * 提交数据
 */
function ok() {
	var paramjosn = "";
	paramjosn = "{'leadName':'" +  $("#leadName").val()+ 
	"','persons':'" + $("#persons").val()+
	"','personsID':'"+$("#personsID").val()+
	"','leadsID':'"+leadID+"'}";
	$("#paramjosn").val(paramjosn);
	var fm = document.getElementById("formAdd");
	fm.target = "hiddenFrame";
	$('#formAdd').submit();
}
/*
 * 返回模块首页
 */
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
	
	<div class="divstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="position: relative; left: -30px">领导姓名</span>
		<textarea id="leadName" 
				  class="validate[required] cTextarea" 
				  rows="4" cols="30" 
				  readonly="readonly" style="position: relative; left: -30px"></textarea>
	 </div>
	 <br>
	<div class="divstyle">
		<span>可查看人员名单</span>
		<textarea id="persons" class="validate[required] cTextarea" rows="4" cols="30" readonly="readonly"></textarea>
		<input type="button" value="选择" onclick="chooseActUser('persons')"/>
	</div>
	<div class="divbutton">
		<input class="cButton_Gray" style="width: 100px" type="button" onclick="ok()" value="保存"></input>
	</div>
	</form>
	
</div>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
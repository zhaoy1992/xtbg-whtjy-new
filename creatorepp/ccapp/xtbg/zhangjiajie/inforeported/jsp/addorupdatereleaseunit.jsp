<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.ReleaseunitBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.ReleaseunitServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.ReleaseunitServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page contentType="text/html; charset=GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	String sql = "select infotype_id, infotype_name from ta_oa_infre_info_type";
	String str = DictDropDownList.buildSelect(sql,"infotype_id","","",false,"");
	
	String releaseunit_id = request.getParameter("releaseunit_id");
	ReleaseunitServiceIfc releaseunitServiceIfc = new ReleaseunitServiceImpl();
	ReleaseunitBean releaseunitBean = new ReleaseunitBean();
	if (!StringUtil.isBlank(releaseunit_id)) {
		releaseunitBean = releaseunitServiceIfc.getReleaseunitBeanById(releaseunit_id);
	}
%>
<title>发布栏目添加和修改页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />

<!-- 引入公共JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>

<script type="text/javascript">
/*
函数:  save
说明:  提交添加与修改栏目
参数:   无
返回值: 无
*/
function save() {
	var paramjosn = "";
	if (IsSpace($("#releaseunit_id").val())) { //修改
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}
	paramjosn = "{'releaseunit_id':'" + $("#releaseunit_id").val() + "','user_id':'" + <%=user_id %> + "','infotype_id':'" + $("#infotype_id").val() + "','releaseunit_name':'" + $("#releaseunit_name").val() + "','rec_personid':'" + $("#rec_personid").val() + "','rec_person_name':'" + $("#rec_person_name").val()+"'}";
	$("#paramjosn").val(descape(escape(paramjosn)));
	var fm = document.getElementById("form1");
	fm.target = "hiddenFrame";
	$('#form1').submit();
}

var init = function() {
	if (!IsSpace($("#infotype_id").val())) { //修改
		$('#infotype_source').attr('disabled',true);
	} 
}

var chooseUser = function (){
	var url = "../../tree/jsp/orgusertree.jsp?ischeck=true";

	var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
	 	$('#rec_personid').val(orgObj.id);
	 	$('#rec_person_name').val(orgObj.name);
	 }
}
</script>
<body onload="init()">
	<form id="form1" action="addorupdatereleaseunitdo.jsp" method="post">
		<input type="hidden" name="releaseunit_id" id="releaseunit_id"
			value="<%=StringUtil.deNull(releaseunitBean.getReleaseunit_id()) %>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<div>
		<table class="popTableArea">
			<tr>
				<td class="poptableLable" width="20%">发布单位</td>
				<td class="tableValue" width="80%">
					<input class="cText_out" type="text" name="releaseunit_name"
					id="releaseunit_name"
					value="<%=StringUtil.deNull(releaseunitBean.getReleaseunit_name()) %>">
				</td>
			</tr>
			<tr>
				<td class="poptableLable" >信息类型</td>
				<td class="tableValue" >
				<%=str %>
				</td>
			</tr>
			<tr>
				<td class="poptableLable">接收人</td>
				<td class="tableValue">
				<textarea class="cTextarea" rows="4" cols="30" type="text" name="rec_person_name" id="rec_person_name" value="<%=StringUtil.deNull(releaseunitBean.getRec_person_name()) %>"><%=StringUtil.deNull(releaseunitBean.getRec_person_name()) %></textarea>
					<input type="hidden" name="rec_personid" id="rec_personid"
							value="<%=StringUtil.deNull(releaseunitBean.getRec_personid()) %>">
							<input class="cButton_Gray" type="button" onclick="chooseUser()" value="选择"></input>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="textcenter"><input class="cButton_Gray"  type="button" onClick="save()" value="保存"></input></td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.UnitsetupBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.UnitsetupServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.UnitsetupServiceImpl"%>
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
	
	String infotype_id = "";
	String unitsetup_id = request.getParameter("unitsetup_id");
	UnitsetupServiceIfc infoTypeServiceIfc = new UnitsetupServiceImpl();
	UnitsetupBean unitsetupBean = new UnitsetupBean();
	if (!StringUtil.isBlank(unitsetup_id)) {
		unitsetupBean = infoTypeServiceIfc.getUnitsetupBeanById(unitsetup_id);
		infotype_id = unitsetupBean.getInfotype_id();
	}
	
	String sql = "select infotype_id, infotype_name from ta_oa_infre_info_type";
	String str = DictDropDownList.buildSelect(sql,"infotype_id",infotype_id,"",false,"");
%>
<title>上报单位添加和修改页面</title>
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
说明:  提交添加与修改上报单位
参数:   无
返回值: 无
*/
function save() {
	if(isExsitUnitsetupInfo4Org()){
		return;
	}else{
		var paramjosn = "";
		if (IsSpace($("#unitsetup_id").val())) { //修改
			$("#action").val("add");
		} else {
			$("#action").val("update");
		}
		paramjosn = "{'unitsetup_id':'" + $("#unitsetup_id").val() +"','infotype_id':'" + $("#infotype_id").val() + "','org_id':'" + $("#org_id").val() + "','infotype_desc':'" + $("#infotype_desc").val() + "','user_id':'" + <%=user_id %>+ "','unitsetup_name':'" + $("#unitsetup_name").val()+"'}";
		$("#paramjosn").val(descape(escape(paramjosn)));
		var fm = document.getElementById("form1");
		fm.target = "hiddenFrame";
		$('#form1').submit();
	}
	
}

/*
 * 判断当前机构在数据库中是否已被使用
 */
function isExsitUnitsetupInfo4Org(){
	var url = "isexsitunitsetupinfo4org.jsp";
	params = {org_id:$('#org_id').val()};
	var isExsitUnitsetup = false;
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		async: false,
		data: params,
		success: function(data){
			if(data.isexsit){
				alert("机构已经被使用，请重选！");
				isExsitUnitsetup = true;
			}else{
				isExsitUnitsetup = false;
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询失败，请重试");
		}
	});
	return isExsitUnitsetup;
}

var init = function() {
	$('#unitsetup_name').bind('propertychange',isExsitUnitsetupInfo4Org);
	if (!IsSpace($("#unitsetup_id").val())) { //修改
		$('#Select').attr('disabled',true);
	} 
}

var chooseOrg = function (){
	var url = "../../tree/jsp/orgtree.jsp";

	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 $('#org_id').val(orgObj.id);
		 $('#unitsetup_name').val(orgObj.name);
	 }
}

</script>
<body onLoad="init()">
	<form id="form1" action="addorupdateunitsetupdo.jsp" method="post">
		<input type="hidden" name="unitsetup_id" id="unitsetup_id"
			value="<%=StringUtil.deNull(unitsetupBean.getUnitsetup_id()) %>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<div>
		<table class="popTableArea">
			<tr>
				<td class="poptableLable" width="20%">单位名称</td>
				<td class="tableValue" width="80%">
					
					<input class="cText_out" style="width:80%" type="text" name="unitsetup_name"
					id="unitsetup_name" readonly="readonly"
					value="<%=StringUtil.deNull(unitsetupBean.getUnitsetup_name()) %>">
					<input type="hidden" name="org_id" id="org_id"
			value="<%=StringUtil.deNull(unitsetupBean.getOrg_id()) %>">
					<input class="cButton_Gray" type="button" id="Select" onClick="chooseOrg()" value="选择"></input>
				</td>
			</tr>
			<tr>
				<td class="poptableLable" >信息类型</td>
				<td><%=str %></td>
			</tr>
			<tr>
				<td class="poptableLable">描述</td>
				<td class="tableValue">
				<textarea class="cTextarea" rows="4" cols="30" type="text" name="infotype_desc" id="infotype_desc" value="<%=StringUtil.deNull(unitsetupBean.getInfotype_desc()) %>"><%=StringUtil.deNull(unitsetupBean.getInfotype_desc()) %></textarea>
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
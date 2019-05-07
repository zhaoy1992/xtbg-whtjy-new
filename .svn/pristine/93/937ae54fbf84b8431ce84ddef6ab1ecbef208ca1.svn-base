<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
function save(){
    //表单验证  
    $("#form").validationEngine();
	$("#form").attr("target","hiddenFrame");
	$("#form").attr("action","addressBookimportdo.jsp?salarytype=bj&wdo=single");
	$("#form").submit();
}
//选择机构
var chooseOrg = function (orgid,org){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.type='ADEPT';
	  s.treetypestr="radio";
	  s.selectedIds=$('#orgid').val(),
	  s.returnFunction=function(orgObj){
		  $('#orgid').val(orgObj.id);
		  $('#org').val(orgObj.name);
		  	
		  if(!IsSpace(orgObj)){
				 $('#org').val(orgObj.name);
			 }else{
				 $('#org').val("");
			 }

		 }
	  
	  s.init();
}
</script>
<title>单独输入页面</title>
</head>
<body>
<form id="form" action="" method="post">
	<div class="content_02_top" >
				<input class="but_y_01" type="button" id="sel" value="保存" onclick="save()" />
	</div>
	<table width="100%" class="content_02_box_div_table_02">
		<tr>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>姓名：</td>
			<td class="content_02_box_div_table_td" width="170px"><input type="text" class="validate[[required]custom[onlyCc]] input_title_text" id="username" name="username"/></td>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>性别：</td>
			<td class="content_02_box_div_table_td" width="200px" style="text-align: center;">
			<input type="radio"  name="usersex" value="男" checked="checked"/>男&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio"  name="usersex" value="女"/>女
			</td>
		</tr>
		<tr>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>职务：</td>
			<td class="content_02_box_div_table_td"><input type="text" class="validate[required] input_title_text" name="duties" id="duties"/></td>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>所在单位：</td>
			<td class="content_02_box_div_table_td">
				<input type="text" style="width: 100px" class="input_160 validate[required] input_title_text" id="org" name="org" onclick="chooseOrg(orgid,org)"/>
				<input type="hidden"   id="orgid" name="orgid"/>
			 	<input name="button_verify_username" id="button_verify_username" type="button"  class="but_x" onclick="chooseOrg(orgid,org)"/>
			</td>
		</tr>
		<tr>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>办公电话：</td>
			<td class="content_02_box_div_table_td"><input type="text" class="validate[[required][custom[mphone]] input_title_text" name="user_worktel" id="user_worktel"/></td>
			<td class="content_02_box_div_table_th"><span class="color_red">*</span>办公手机：</td>
			<td class="content_02_box_div_table_td"><input type="text" class="validate[[required][custom[mphone]] input_title_text" name="user_mobiletel1" id="user_mobiletel1"/></td>
		</tr>
	</table>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
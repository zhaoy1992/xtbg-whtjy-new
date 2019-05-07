<%-- 
描述：机构添加页面
作者：黄艺平
版本：1.0
日期：2013-05-16
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.Organization"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@ page import="java.util.Date"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String type = request.getParameter("type");
	String org_id = request.getParameter("org_id");
	String org_xzqm = request.getParameter("org_xzqm");

	String parent_id = "";
	
	OrgManagerServiceIfc orgManagerServiceIfc = new OrgManagerServiceImpl();
	
	Organization org = new Organization();
	
	String orgXzqmHtml = "&nbsp;";
	if("update".equals(type)) {//修改操作
		org = orgManagerServiceIfc.getOrganization(org_id);
	} else { //添加操作
		 if(StringUtil.isBlank(org_id)) {
			 parent_id = "0";
			 org_xzqm = "0";
		 } else {
			 parent_id = org_id;
			 org_id = ""; 
		 }
		// String orgXzqmSql = "select a.area_code, a.area_name from oa_org_area a where a.parent_area_code = " + org_xzqm;
		 orgXzqmHtml = DictDropDownList.buildSelect4DictType("oa_org_area","org_xzqm","","",false,"","","validate[required]",org_xzqm);//机构区域编号下拉框
	}
	
	String orgTypeSql = "select t.type_code, t.type_name from oa_org_type t";
	String orgTypeHtml = DictDropDownList.buildSelectNoDefault(orgTypeSql,"org_level","","",false,org_xzqm);//机构类型下拉框

	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>机构添加</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	jQuery("#orgnumber").focus();
	if('update' == '<%=type %>') {
		jQuery("#orgnumber").attr("disabled",true);
		jQuery("#remark3").val("<%=StringUtil.deNull(org.getRemark3()) %>");
		jQuery("#org_level").val("<%=StringUtil.deNull(org.getOrg_level()) %>");
		jQuery("#xzqm").hide();
	} else {
		jQuery("#org_sn").val("1");
	}
});

 /*
　 * description: 保存机构信息
　 * author: 黄艺平
　 * date: 2013-05-16
　 * param:
　 * return:  
　 */
function saveorg() {
	if(validateForm()){
		var okF = function(){
			$("#form1").attr("action","new_org_do.jsp");
			$("#form1").attr("target","hiddenFrame");
			jQuery('#form1').submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
				okFunction:okF,
				cancelName:'取消'
		};
		if('add' == '<%= type %>') {
			alert('确定添加机构吗？ ',p)
		} else {
			alert('确定修改机构吗？ ',p)
		}
		
	}
}

/*
 * description: 验证方法
 * author: 黄艺平
 * date: 2013-05-16
 * param:
 * return:  
 */
function validateForm(){
	if(jQuery("#form1").validationEngine("validateform")) {
		return true;
	} else {
		return false;
	}
}

 /*
　 * description: 选择机构
　 * author: 黄艺平
　 * date: 2013-05-23
　 * param:
　 * return:  
　 */
var chooseOrg = function (){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr='radio';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#remark2').val();
	  s.type='AORG';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
				 $('#remark2').val(orgObj.id);
				 $('#remark4').val(orgObj.name);
			 }else{
				 $('#remark2').val("");
				 $('#remark4').val("");
			 }

		 }
	  s.init();
}
</script>

</head>
<body onload="">
<form action="" id="form1" name="form1" method="post">

<input type="hidden" id="type" name="type" value="<%=type %>"></input>
<input type="hidden" id="org_id" name="org_id" value="<%=org_id %>"></input>
<input type="hidden" id="parent_id" name="parent_id" value="<%=parent_id %>"></input>
<input type="hidden"  name="oldOrgname" value="<%=StringUtil.deNull(org.getOrg_name()) %>" />
<input type="hidden"  name="oldremark5" value="<%=StringUtil.deNull(org.getRemark5()) %>" />

<div class="content_02_box">
	<div class="content_02_box_title_bg"><span>机构基本信息</span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>机构编号:
					</th>
					<td class="content_02_box_div_table_td">
						<input maxlength="9" id="orgnumber" name="orgnumber" value="<%=StringUtil.deNull(org.getOrgnumber()) %>" class="validate[required,custom[onlyLetterOrNumber],maxSize[9],minSize[9]] input_185" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>机构简称:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="org_name" name="org_name" value="<%=StringUtil.deNull(org.getOrg_name()) %>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[40]] input_185"></input>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>机构排序号:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="org_sn" name="org_sn" value="<%=StringUtil.deNull(org.getOrg_sn()) %>" class="validate[required,custom[onlyNumberSp],maxSize[5]] input_185"  />
					</td>
					<th class="content_02_box_div_table_th">
						机构描述:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="orgdesc" name="orgdesc" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(org.getOrgdesc()) %>" class="validate[maxSize[300]] input_185"  />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						简拼:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="jp" name="jp" value="<%=StringUtil.deNull(org.getJp()) %>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[maxSize[40]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						全拼:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="qp" name="qp" class="validate[maxSize[40]] input_185" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(org.getQp()) %>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						机构有效标志:
					</th>
					<td class="content_02_box_div_table_td">
						<select name="remark3" id="remark3">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>机构全称:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="remark5" name="remark5" value="<%=StringUtil.deNull(org.getRemark5()) %>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_185"></input>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						机构级别:
					</th>
					<td class="content_02_box_div_table_td">
						<%=orgTypeHtml %>
					</td>
					<th class="content_02_box_div_table_th" >
						上级部门:
					</th>
					<td class="content_02_box_div_table_td">
					 <input class="input_160"  id="remark4" name="remark4" value="<%=StringUtil.deNull(org.getRemark4()) %>" readonly onclick='chooseOrg()'></input>
					 <input type="button" class="but_x" onclick="chooseOrg()" ></input> 
					 <input type="hidden" id="remark2" value="<%=StringUtil.deNull(org.getRemark2()) %>"  name="remark2"></input>
					</td>
				</tr>
				<tr id="xzqm">
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>行政区码:
					</th>
					<td class="content_02_box_div_table_td">
						<%=orgXzqmHtml %>
					</td>
					<th class="content_02_box_div_table_th" >
					&nbsp;
					</th>
					<td class="content_02_box_div_table_td">
						&nbsp;
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >部门描述:</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea class="validate[maxSize[400]] textarea_575" id="remark1" name="remark1" rows="2" style="width:98%;border:none; height: 60px;overflow: auto;"><%=StringUtil.deNull(org.getRemark1()) %></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="cue_box_foot">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="removeAlertWindows('',true)" />
		<input class="but_y_01" type="button" value="确定" onclick="saveorg()"/>
  	</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
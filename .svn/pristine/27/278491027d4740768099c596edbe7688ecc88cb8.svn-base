<%-- 
描述：字典类型基本信息
作者：肖杰
版本：1.0
日期：2013-07-23
 --%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String type = StringUtil.deNull(request.getParameter("type"));
	String dict_id=StringUtil.deNull(request.getParameter("dict_id"));
	String dict_parent_id="";
	if(StringUtil.isBlank(dict_id)){
		dict_parent_id="0";
	}else{
		dict_parent_id=dict_id;
	}
	String dict_name="";
	String dict_code="";
	String dict_remark="";
	String dict_is_valid="";
	String dict_order="";
	String dict_type="";
	Map<String, String> viewMap = new HashMap<String, String>();
	DictServiceIfc dictServiceIfc=new DictServiceImpl();
	if("update".equals(type)){
		viewMap=dictServiceIfc.getDictTypeBean(dict_id);
		dict_parent_id = StringUtil.deNull(viewMap.get("dict_parent_id"));
		dict_name = StringUtil.deNull(viewMap.get("dict_name"));
		dict_code = StringUtil.deNull(viewMap.get("dict_code"));
		dict_remark = StringUtil.deNull(viewMap.get("dict_remark"));
		dict_is_valid = StringUtil.deNull(viewMap.get("dict_is_valid"));
		dict_order = StringUtil.deNull(viewMap.get("dict_order"));
		dict_type = StringUtil.deNull(viewMap.get("dict_type"));
	}
%>
<title>字典数据基本信息</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">

var path = '<%=path %>';

var subid = '<%=subid %>';
jQuery(function() {
	if("update"=="<%=type%>"){
		jQuery("#dict_code").attr("disabled","disabled");
	}
	if('<%=dict_id %>' != '') {
		jQuery("#dict_is_valid").val("<%=dict_is_valid %>");
		jQuery("#dict_type").val("<%=dict_type %>");
	}

	
	
});
/*
函数:  addDictType
说明:  添加
参数:   无
返回值: 无
*/
var addDictType = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addDictType");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定添加吗？',p);

}
/*
函数:  updateDictType
说明:  修改
参数:   无
返回值: 无
*/
var updateDictType = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateDictType");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定修改吗？',p);

}


/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
		var okF = function(){
			closeAlertWindows(subid,false,true);
		}
		 var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'};
		 alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="dicttypedo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="dict_parent_id" id="dict_parent_id"  value="<%=dict_parent_id %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if("add".equals(type)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addDictType();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateDictType();"  type="button" class="but_y_01" />
		<% }%>
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>字典名称：</th>
						<td colspan="3"  class="content_02_box_div_table_td">
							<input type="hidden" name="dict_id" id="dict_id"  value="<%=dict_id %>" />
							<input   class="validate[required,maxSize[100]] input_188" name="dict_name" id="dict_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=dict_name %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>字典编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[100]] input_188" name="dict_code" id="dict_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=dict_code %>" type="text"/>
						</td>
						<th class="content_02_box_div_table_th">字典数据排序：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="dict_order" id="dict_order" value="<%=dict_order %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">字典是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="dict_is_valid" name="dict_is_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
						<th class="content_02_box_div_table_th">字典类型：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<select id="dict_type" name="dict_type" class="select_100_box" style="width: 125px" >
								<option value="0">普通</option>
								<option value="1">递归</option>
							</select>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">字典备注：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[500]] textarea_575" style="width:99%" name="dict_remark" id="dict_remark"  ><%=dict_remark %></textarea>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>
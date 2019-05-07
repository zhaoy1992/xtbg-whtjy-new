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
	String dict_id = StringUtil.deNull(request.getParameter("orgid"));
	String dict_type = StringUtil.deNull(request.getParameter("dict_type"));
	String dictdata_id=StringUtil.deNull(request.getParameter("dictdata_id"));
	String org_id=StringUtil.deNull(request.getParameter("org_id"));
	String dictdata_parent_id=org_id;
	String dictdata_name="";
	String dictdata_value="";
	String dictdata_remark="";
	String dictdata_is_valid="";
	String dictdata_order="";
	Map<String, String> viewMap = new HashMap<String, String>();
	DictServiceIfc dictServiceIfc=new DictServiceImpl();
	if(!StringUtil.isBlank(dictdata_id)){
		viewMap=dictServiceIfc.getDictDataBean(dictdata_id);
		dictdata_parent_id = StringUtil.deNull(viewMap.get("dictdata_parent_id"));
		dictdata_name = StringUtil.deNull(viewMap.get("dictdata_name"));
		dictdata_value = StringUtil.deNull(viewMap.get("dictdata_value"));
		dictdata_remark = StringUtil.deNull(viewMap.get("dictdata_remark"));
		dictdata_is_valid = StringUtil.deNull(viewMap.get("dictdata_is_valid"));
		dictdata_order = StringUtil.deNull(viewMap.get("dictdata_order"));
		dictdata_id = StringUtil.deNull(viewMap.get("dictdata_id"));
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
	if('<%=dictdata_id %>' != '') {
		jQuery("#dictdata_value").attr("disabled","disabled");
		jQuery("#dictdata_is_valid").val("<%=dictdata_is_valid %>");
	}

	
	
});
/*
函数:  addDictData
说明:  添加
参数:   无
返回值: 无
*/
var addDictData = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addDictData");
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
函数:  updateDictData
说明:  修改
参数:   无
返回值: 无
*/
var updateDictData = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateDictData");
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
			removeWindows(subid,true);
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
<form id="form1" action="dictdatado.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="dict_id" id="dict_id"  value="<%=dict_id %>" />
<input type="hidden" name="dict_type" id="dict_type"  value="<%=dict_type %>" />
<input type="hidden" name="org_id" id="org_id"  value="<%=org_id %>" />
<input type="hidden" name="dictdata_parent_id" id="dictdata_parent_id"  value="<%=dictdata_parent_id %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(dictdata_id)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addDictData();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateDictData();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>字典数据名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="dictdata_id" id="dictdata_id"  value="<%=dictdata_id %>" />
							<input  class="validate[required,maxSize[100]] input_188" name="dictdata_name" id="dictdata_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=dictdata_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>字典数据编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[100]] input_188" name="dictdata_value" id="dictdata_value" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=dictdata_value %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">字典数据是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="dictdata_is_valid" name="dictdata_is_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
						<th class="content_02_box_div_table_th">字典数据排序：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="dictdata_order" id="dictdata_order" value="<%=dictdata_order %>" />
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">字典数据备注：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[500]] textarea_575" style="width:99%" name="dictdata_remark" id="dictdata_remark"  ><%=dictdata_remark %></textarea>
							
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
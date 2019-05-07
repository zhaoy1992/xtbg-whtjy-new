<%-- 
描述：表单环节定义基本信息
作者：肖杰
版本：1.0
日期：2013-07-31
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FormActionServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc"%>
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
	String busitype_code = StringUtil.deNull(request.getParameter("busitype_code"));
	String busitype_name = StringUtil.deNull(request.getParameter("busitype_name"));
	String action_id=StringUtil.deNull(request.getParameter("action_id"));
	String table_id=StringUtil.deNull(request.getParameter("table_id"));
	String action_code="";
	String action_name="";
	String action_desc="";
	String is_valid="";
	String create_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	Map<String, String> viewMap = new HashMap<String, String>();
	FormActionServiceIfc formActionServiceIfc=new FormActionServiceImpl();
	if(!StringUtil.isBlank(action_id)){
		viewMap=formActionServiceIfc.getFormActionBean(action_id);
		action_code = StringUtil.deNull(viewMap.get("action_code"));
		action_name = StringUtil.deNull(viewMap.get("action_name"));
		busitype_code = StringUtil.deNull(viewMap.get("busitype_code"));
		busitype_name = StringUtil.deNull(viewMap.get("busitype_name"));
		action_desc = StringUtil.deNull(viewMap.get("action_desc"));
		create_time = StringUtil.deNull(viewMap.get("create_time"));
		is_valid = StringUtil.deNull(viewMap.get("is_valid"));
	}
%>
<title>表单环节定义基本信息</title>
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
	
	if('<%=action_id %>' != '') {
		jQuery("#is_valid").val("<%=is_valid %>");
	}

	
	
});
/*
函数:  addFormAction
说明:  添加
参数:   无
返回值: 无
*/
var addFormAction = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addFormAction");
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
函数:  updateFormAction
说明:  修改
参数:   无
返回值: 无
*/
var updateFormAction = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateFormAction");
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
			closeAlertWindows(subid,true,false);
		}
		 var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'};
		 alert('确定返回？',p);
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="formactiondo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="busitype_code" id="busitype_code"  value="<%=busitype_code %>" />
<input type="hidden" name="busitype_name" id="busitype_name"  value="<%=busitype_name %>" />
<input type="hidden" name="create_time" id="create_time"  value="<%=create_time %>" />
<input type="hidden" name="table_id" id="table_id"  value="<%=table_id %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(action_id)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addFormAction();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateFormAction();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>环节名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="action_id" id="action_id"  value="<%=action_id %>" />
							<input  class="validate[required,maxSize[50]] input_188" name="action_name" id="action_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value="<%=action_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>环节编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[50]] input_188" name="action_code" id="action_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=action_code%>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>业务类型名称：</th>
						<td class="content_02_box_div_table_td">
							<input disabled="disabled" class="validate[required,maxSize[100]] input_188" name="busitype_name" id="busitype_name"  value="<%=busitype_name %>" />
						</td>
						<th class="content_02_box_div_table_th">是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="is_valid" name="is_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">创建时间：</th>
						<td colspan="3" class="content_02_box_div_table_td" width="192px">
							<input disabled="disabled"  class="validate[required] input_188" name="create_time" id="create_time" value="<%=create_time %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">环节描述：</th>
						<td colspan="3" class="content_02_box_div_table_td" width="192px">
							<textarea  name="action_desc" id="action_desc" class="validate[maxSize[100]] input_575 " onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" style="width:99%;height: 80px;"><%=action_desc%></textarea>
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
<%-- 
描述：系统参数值基本信息
作者：肖杰
版本：1.0
日期：2013-07-19
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
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
	Object treeNode = StringUtil.deNull(request.getParameter("treeNode"));
	String p_code=StringUtil.deNull(DataControlUtil.pageUnEscape(request.getParameter("p_code")));
	String p_value_id=StringUtil.deNull(request.getParameter("p_value_id"));
	String p_value_code="";
	String p_value_name="";
	String p_value_valid="";
	String p_creator_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	Map<String, String> viewMap = new HashMap<String, String>();
	SysParamServiceIfc SysParamServiceIfc=new SysParamServiceImpl();
	if(!StringUtil.isBlank(p_value_id)){
		viewMap=SysParamServiceIfc.getSysParamvalueBean(p_value_id);
		p_value_code = StringUtil.deNull(viewMap.get("p_value_code"));
		p_value_name = StringUtil.deNull(viewMap.get("p_value_name"));
		p_value_valid = StringUtil.deNull(viewMap.get("p_value_valid"));
		p_code = StringUtil.deNull(viewMap.get("p_code"));
		p_creator_time = StringUtil.deNull(viewMap.get("p_creator_time"));
	}
%>
<title>系统参数设置基本信息</title>
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
	
	if('<%=p_value_id %>' != '') {
		jQuery("#p_value_valid").val("<%=p_value_valid %>");
	}

	
	
});
/*
函数:  addSysParamvalue
说明:  添加
参数:   无
返回值: 无
*/
var addSysParamvalue = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addSysParamvalue");
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
函数:  updateSysParamvalue
说明:  修改
参数:   无
返回值: 无
*/
var updateSysParamvalue = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateSysParamvalue");
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
<form id="form1" action="sysparamvaluedo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="p_code" id="p_code"  value="<%=p_code %>" />
<input type="hidden" name="p_creator_time" id="p_creator_time"  value="<%=p_creator_time %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(p_value_id)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addSysParamvalue();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateSysParamvalue();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th">参数值名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="p_value_id" id="p_value_id"  value="<%=p_value_id %>" />
							<input  class="validate[maxSize[100]] input_188" name="p_value_name" id="p_value_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value="<%=p_value_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>参数值编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[100]] input_188" name="p_value_code" id="p_value_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=p_value_code %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>参数编号：</th>
						<td class="content_02_box_div_table_td">
							<input disabled="disabled" class="validate[required,maxSize[100]] input_188" name="p_code" id="p_code"  value="<%=p_code %>" />
						</td>
						<th class="content_02_box_div_table_th">是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="p_value_valid" name="p_value_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">创建时间：</th>
						<td colspan="3" class="content_02_box_div_table_td" width="192px">
							<input disabled="disabled"  class="validate[required] input_188" name="p_creator_time" id="p_creator_time" value="<%=p_creator_time %>" />
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
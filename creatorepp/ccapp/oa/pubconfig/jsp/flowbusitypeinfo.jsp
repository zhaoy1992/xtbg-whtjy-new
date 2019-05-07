<%-- 
描述：业务类型分类信息
作者：shuqi.liu
版本：1.0
日期：2013-07-23
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FlowBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean" %>
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
	String busitype_type_code="";
	String busitype_type_name="";
	String is_valid="";
	String is_flow="";
	String order_no="";
	String type_desc="";
	String count_type="";
	if("updateType".equals(type)){
		FlowBusitypeTypeBean flowBusitypeTypeBean = new FlowBusitypeTypeBean();
		busitype_type_code = StringUtil.deNull(request.getParameter("busitype_type_code"));
		FlowBusitypeServiceIfc service = new FlowBusitypeServiceImpl();
		flowBusitypeTypeBean = service.findFlowBusitypeTypeInfoById(busitype_type_code);
		busitype_type_code = flowBusitypeTypeBean.getBusitype_type_code();
		busitype_type_name = flowBusitypeTypeBean.getBusitype_type_name();
		is_valid = flowBusitypeTypeBean.getIs_valid();
		is_flow = flowBusitypeTypeBean.getIs_flow();
		order_no = flowBusitypeTypeBean.getOrder_no();
		type_desc = flowBusitypeTypeBean.getType_desc();
		count_type = flowBusitypeTypeBean.getCount_type();
	}
%>
<title>业务类型分类信息</title>
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
var subid = '<%=subid%>';
jQuery(function() {
	if("updateType"=="<%=type%>"){
		jQuery("#busitype_type_code").attr("readonly","readonly");
	}
	if('<%=busitype_type_code %>' != '') {
		jQuery("#is_valid").val("<%=is_valid %>");
		jQuery("#is_flow").val("<%=is_flow %>");
		jQuery("#count_type").val("<%=count_type %>");
	}
	jQuery("#busitype_type_name").focus();
});
/*
函数:  addDictType
说明:  添加
参数:   无
返回值: 无
*/
var addBusiType = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addType");
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
var updateBusiType = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateType");
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
<form id="form1" action="flowbusitypeinfodo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action" value ="<%= type %>"  />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if("addType".equals(type)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addBusiType();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateBusiType();"  type="button" class="but_y_01" />
		<% }%>
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>业务类型分类名称：</th>
						<td  class="content_02_box_div_table_td">
							<input class="validate[required,maxSize[100]] input_188" name="busitype_type_name" id="busitype_type_name"  value="<%=busitype_type_name %>" />
						</td>
						<th class="content_02_box_div_table_th">类型分类登记分类：</th>
						<td  class="content_02_box_div_table_td">
							<select id="count_type" name="count_type" class="select_100_box" style="width: 125px" >
								<option value="发文">发文</option>
								<option value="收文">收文</option>
								<option value="其他">其他</option>
							</select>						
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>业务类型分类编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[100]] input_188" name="busitype_type_code" id="busitype_type_code" value="<%=busitype_type_code %>" type="text"/>
						</td>
						<th class="content_02_box_div_table_th">业务类型分类排序：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="order_no" id="order_no" value="<%=order_no %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="is_valid" name="is_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
						<th class="content_02_box_div_table_th">是否加入流程：</th>
						<td class="content_02_box_div_table_td">
							<select id="is_flow" name="is_flow" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">业务类型分类描述：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[500]] textarea_575" style="width:99%" name="type_desc" id="type_desc"  ><%=type_desc %></textarea>
							
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
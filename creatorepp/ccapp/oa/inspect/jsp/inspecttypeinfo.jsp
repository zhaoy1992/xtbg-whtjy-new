<%-- 
描述：督查督办类别基本信息
作者：肖杰
版本：1.0
日期：2013-11-05
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectTypeService"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
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
	UserCacheBean usercachebean= UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String type_id = request.getParameter("type_id");
	String type_name="";
	String type_remark="";
	String type_template="";
	//得到最大排序号
	String sql="select max(type_order) from oa_inspect_type ";
	String maxorder =DaoUtil.sqlToField(sql);
	if(StringUtil.isBlank(maxorder)){
		maxorder="0";
	}
	String type_order=(Integer.parseInt(maxorder)+1)+"";
	Map<String, String> viewMap = new HashMap<String, String>();
	InspectTypeService service = new InspectTypeServiceImpl();
	if(!StringUtil.isBlank(type_id)){
		viewMap=service.getInspectTypeByid(type_id);
		type_name = StringUtil.deNull(viewMap.get("type_name"));
		type_remark = StringUtil.deNull(viewMap.get("type_remark"));
		type_template = StringUtil.deNull(viewMap.get("type_template"));
		type_order = StringUtil.deNull(viewMap.get("type_order"));
	}
	

	
%>
<title>督查督办类别基本信息</title>
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

/*
函数:  addinspect
说明:  添加
参数:   无
返回值: 无
*/
var addinspect = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addinspect");
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
函数:  updateinspect
说明:  修改
参数:   无
返回值: 无
*/
var updateinspect = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateinspect");
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
	removeWindows(subid,true);
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="inspecttypedo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(type_id)){%>
		<input name="fbbt" id="fbbt" value="添加" onclick="addinspect();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="修改" onclick="updateinspect();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>类别名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="type_id" id="type_id"  value="<%=type_id %>" />
							<input  class="validate[required,maxSize[15]] input_188" name="type_name" id="type_name"  onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=type_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>排序号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="type_order" id="type_order" value="<%=type_order %>" />
						</td>
					</tr>
					<tr id="sel">
						<th width="212" valign="top" class="content_02_box_div_table_02_th">说明：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[100]] textarea_575" style="width:99%" name="type_remark" id="type_remark" value="" ><%=type_remark %></textarea>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="content_02_box">
		
			<div class="content_02_box_title_bg"><span>内容模版</span> 
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span class="color_red">提示：可以直接粘贴word、excel表格</span>
			<div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
			</div>
		
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<td colspan="4">
						<textarea style="display: none" name="type_template" id="type_template"  class=""><%=type_template %></textarea> 
						<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=type_template&style=gray" frameborder="0" 
						scrolling="no" width="100%" height="400"></iframe>
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
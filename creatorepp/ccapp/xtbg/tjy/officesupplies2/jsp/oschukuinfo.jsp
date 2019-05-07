<%--
描述：领用出库
作者：王淑滨
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppRegYhpService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppRegYhpServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppRegYhpBean"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	//当前时间
	String time = DateUtil.getCurrentDateString("yyyy-MM-dd");
	
	String t_appregyhp_id  = request.getParameter("t_appregyhp_id");
	//得申领表信息
	OsAppRegYhpService service = new OsAppRegYhpServiceImpl();
	OsAppRegYhpBean bean = service.getById(t_appregyhp_id);
	//得物品清单
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	List<Map<String,String>> osAppRegObjectList = new ArrayList<Map<String,String>>();
	osAppRegObjectList = osHavaObjectService.queryAppRegObjectForRegId(t_appregyhp_id);
	//发放/库存区别
	String type = request.getParameter("type");
%>
<!-- 公共部分开始 -->
<title>计划</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<!-- 公共部分结束 -->
<script type="text/javascript">
var type = "<%=type%>";
jQuery(function() {
	if(IsSpace(type)){
		jQuery("#ck").hide();
	}
});

function chuku() {
	jQuery("#action").val("chuku");
	document.all.form1.submit();
};

function dayin(){
	var url = "printHoldinfoexcel2.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='t_appregyhp_id' value='<%=t_appregyhp_id%>' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
};
</script>

</head>
<body onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="oschukudo.jsp" class="formular" method="post">
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'> 
			<input class="but_y_01" id="dy" name="dy" type="button" value="打印" onclick="dayin();"/>
			<input class="but_y_01" id="ck" name="ck" type="button" value="出库" onclick="chuku();"/>
			<input class="but_y_01" id="back" name="back" type="button" value="返回" onclick="window.history.back();"/>
		</div>
	</div>
		 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 1000px; ">
 <!--------------采购清单-------------->
 <div class="content_02_box_div"style="width: 1000px; ">
	<div class="content_02_box_title_bg"style="width: 1000px; ">
		<span>申领登记表</span>
	</div>                                           
	<table  style="width: 1000px; "border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">	
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申领部室：</th>
			<td class="content_02_box_div_table_td">
				<input id="action" name="action" type="hidden" value="" />
				<input id="user_id" name="user_id" type="hidden" value="<%=user_id %>">
				<input id="user_name" name="user_name" type="hidden" value="<%=user_name %>">
				<input id="time" name="time" type="hidden" value="<%=time %>">   
				<input type="hidden" id="t_appregyhp_id" name="t_appregyhp_id" value="<%=t_appregyhp_id%>"> 
				<input type="hidden" id="t_appregyhp_org_id" name="t_appregyhp_org_id" value="<%=bean.getT_appregyhp_org_id()%>">
				<input class="validate[required] input_title_text" id="t_appregyhp_org_name" name="t_appregyhp_org_name" readonly="readonly" value="<%=bean.getT_appregyhp_org_name() %>">
			</td>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>填写时间：</th>
			<td class="content_02_box_div_table_td">
				<input class="validate[required] input_title_text" id="t_appregyhp_date" name="t_appregyhp_date" readonly="readonly" value="<%=bean.getT_appregyhp_date() %>">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购标题：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<input class="validate[required,maxSize[250]] input_title_text" id="t_appregyhp_title" name="t_appregyhp_title" readonly="readonly" value="<%=bean.getT_appregyhp_title() %>">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购人：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<input type="hidden" id="t_appregyhp_user_id" name="t_appregyhp_user_id" value="<%=bean.getT_appregyhp_user_id() %>">
				<input class="validate[required] input_title_text" id="t_appregyhp_user_name" name="t_appregyhp_user_name" readonly="readonly" value="<%=bean.getT_appregyhp_user_name() %>">
			</td>
		</tr>
	</table>
	<div class="content_02_box_title_bg" style="width: 1000px; ">
		<span>申领物品清单</span>
	</div>
	<div class="content_02_box_div" style="width: 1000px; ">
		<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">		
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品类别</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品名称</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>规格型号</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>数量</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;">备注</td>	
			
			<%for(int i=0;i<osAppRegObjectList.size();i++){
				Map<String,String> map = osAppRegObjectList.get(i);
			 %>
			 <tr>
			 	<td class="content_02_box_div_table_td">
			 		<input type="hidden" id="t_osappreg_ob_id" name="t_osappreg_ob_id" value="<%=map.get("t_osappreg_ob_id") %>">
			 		<input type="hidden" id="oftype_id" name="oftype_id" value="<%=map.get("oftype_id") %>">
			 		<input class="validate[required] input_title_text" id="oftype_name" name="oftype_name" readonly="readonly" value="<%=map.get("oftype_name") %>">
			 	</td>
			 	<td class="content_02_box_div_table_td">
			 		<input type="hidden" id="ofustype_id" name="ofustype_id" value="<%=map.get("ofustype_id") %>">
			 		<input class="validate[required] input_title_text" id="ofustype_name" name="ofustype_name" readonly="readonly" value="<%=map.get("ofustype_name") %>">
			 	</td>
			 	<td class="content_02_box_div_table_td">
			 		<input type="hidden" id="it_id" name="it_id" value="<%=map.get("it_id") %>">
			 		<input class="validate[required] input_title_text" id="it_name" name="it_name" readonly="readonly" value="<%=map.get("it_name") %>">
			 	</td>
			 	<td class="content_02_box_div_table_td">
			 		<input class="validate[required] input_title_text" id="t_osappreg_ob_no" name="t_osappreg_ob_no" readonly="readonly" value="<%=map.get("t_osappreg_ob_no") %>">
			 	</td>
			 	<td class="content_02_box_div_table_td">
			 		<input class="validate[required] input_title_text" id="t_osappreg_ob_bz" name="t_osappreg_ob_bz" readonly="readonly" value="<%=map.get("t_osappreg_ob_bz") %>">
			 	</td>
			 </tr>
			 <%} %>
		</table>
	</div>
</div>
</div>
</div>
</form>
</body>
</html>


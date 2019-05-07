<%--
描述：采购清单
作者：王淑滨
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieTypeServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsapPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(user_id);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	//当前系统时间
	String time = DateUtil.getCurrentDateString("yyyy-MM-dd");
	
	String id = request.getParameter("t_id");
	//得申购表信息
	OsApplanBean bean = new OsApplanBean();
	if(!StringUtil.isBlank(id)){
		OsapPlanService planService = new OsapPlanServiceImpl();
		bean = planService.getById(id);
	}else{
		bean.setT_id(DaoUtil.getUUID());
		bean.setT_user_id(user_id);
		bean.setT_user_name(user_name);
		bean.setUnit_id(unit_id);
		bean.setUnit_name(unit_name);
		bean.setT_org_id(org_id);
		bean.setT_org_name(orgName);
		bean.setT_creator_time(time);
	}
	//物品清单
	OsAppObjectService osapplanitemserviceimpl = new OsAppObjectServiceImpl();
	List<Map<String,String>> listItems = osapplanitemserviceimpl.selectOsAppObject(id);
	
	//分类
	OsupplieTypeService typeService = new OsupplieTypeServiceImpl();
	OsupplieTypeBean typeBean = new OsupplieTypeBean();
	List<Map<String,String>> typeList = new ArrayList<Map<String,String>>();
	typeList = typeService.getTypeList(typeBean);
	
	String action = request.getParameter("action");
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
var action = "<%=action%>";
jQuery(function(){ 	
	if(action == 'insert'){
		jQuery("#back").hide();
		jQuery("#rk").hide();
	}else if(action == 'update'){
		jQuery("#add").hide();
	}else{
		jQuery("#add").hide();
		jQuery("#rk").hide();
	}
  	jQuery("[name=dayrowhidden]").hide();
  	<%if(listItems.size()>0){
  		for(int i=0;i<listItems.size();i++){
  			HashMap<String,String> itemMap = (HashMap<String,String>)listItems.get(i);%>
  			jQuery("#PTYPE_SELECT<%=i+1%>").val("<%=itemMap.get("p_type_id")+";"+itemMap.get("p_type") %>");
			jQuery("#PTYPE_SELECT<%=i+1%>").change();
			jQuery("#TYPE_SELECT<%=i+1%>").val("<%=itemMap.get("type_id")+";"+itemMap.get("type") %>");
			jQuery("#TYPE_SELECT<%=i+1%>").change();
			jQuery("#NAME_SELECT<%=i+1%>").val("<%=itemMap.get("ofustype_id")+";"+itemMap.get("ofustype_name") %>");
			jQuery("#NAME_SELECT<%=i+1%>").change();
			jQuery("#IT_NAME_SELECT<%=i+1%>").val("<%=itemMap.get("it_id")+";"+itemMap.get("it_name") %>");
			jQuery("#IT_NAME_SELECT<%=i+1%>").change();
			if(action == 'update'){
				var OFUSTYPE_MONEY = jQuery("#OFUSTYPE_MONEY<%=i+1%>").val();
				var T_OS_OB_NO = jQuery("#T_OS_OB_NO<%=i+1%>").val();
				jQuery("#sum<%=i+1%>").val(OFUSTYPE_MONEY * T_OS_OB_NO);
			}
  	<%}}%>
});
//添加物品
function Add_Row4NewDay1(){
	var lastTrObject = jQuery("[name=dayrow]").last();
	var lastTr = jQuery("[name=dayrowhidden]").clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[name=T_OS_OB_ID]").val("");
	//数字默认是 为空
	jQuery(lastTr).find("input[name=T_OS_OB_NO]").val("");	
	jQuery(lastTr).find("input[name=OFUSTYPE_MONEY]").val("");
	
	var lastSelectId = lastTrObject.find("select[name=PTYPE_SELECT]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("PTYPE_SELECT");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}
	jQuery(lastTr).find("select[name=PTYPE_SELECT]").attr("id","PTYPE_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=PTYPE_SELECT]").val("");
	jQuery(lastTr).find("input[name=PTYPE_ID]").attr("id","PTYPE_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=PTYPE_NAME]").attr("id","PTYPE_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=PTYPE_ID]").val("PTYPE_ID;")
	
	jQuery(lastTr).find("select[name=TYPE_SELECT]").attr("id","TYPE_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=TYPE_SELECT]").empty();
	jQuery(lastTr).find("select[name=TYPE_SELECT]").show();
	jQuery(lastTr).find("input[name=TYPE_ID]").attr("id","TYPE_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=TYPE_NAME]").attr("id","TYPE_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=TYPE_ID]").val("TYPE_ID;");
	
	jQuery(lastTr).find("select[name=NAME_SELECT]").attr("id","NAME_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=NAME_SELECT]").empty();
	jQuery(lastTr).find("select[name=NAME_SELECT]").show();
	jQuery(lastTr).find("input[name=NAME_ID]").attr("id","NAME_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=NAME]").attr("id","NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=NAME_ID]").val("NAME_ID;");
	
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").attr("id","IT_NAME_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").empty();
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").show();
	jQuery(lastTr).find("input[name=IT_NAME_ID]").attr("id","IT_NAME_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_NAME]").attr("id","IT_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_NAME_ID]").val("IT_NAME_ID;");
	
	jQuery(lastTr).find("input[name=T_OS_OB_ID]").attr("id","T_OS_OB_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OS_OB_NO]").attr("id","T_OS_OB_NO"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_MONEY]").attr("id","OFUSTYPE_MONEY"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OS_OB_BZ]").attr("id","T_OS_OB_BZ"+newlastSelectId);
	
	
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	lastTr.attr("style","");
	
	var dayTable = jQuery("#dayTable");
	
	lastTr.appendTo(dayTable);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}
//删除物品
function deleteDay(tag,goodsId){
	
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
}

//异步填充子类别下拉列表
function loadTypeSelect(OFUSTYPE_SELECT){
	var url = "getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"type"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("PTYPE_SELECT");   //获取当前列的id后缀

	
	var NEW_OFUSTYPE_SELECT_ID = "#TYPE_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#PTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#PTYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#TYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#TYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val("PTYPE_ID;"+ofustypevalueArr[0]);
		
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){				
				IT_NAME_SELECT.empty();
				
				var newOption1 = document.createElement("OPTION"); 
				newOption1.text = "--请选择--"; 
				newOption1.value = "";
				IT_NAME_SELECT.get(0).options.add(newOption1); 
				
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].oftype_name; 
					newOption.value = data[i].oftype_id+";"+data[i].oftype_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val("TYPE_ID;"+data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
}
//异步填充物品名称下拉列表
function loadNameSelect(OFUSTYPE_SELECT){
	var url = "getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"name"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("TYPE_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#NAME_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var OFUSTYPE_NAME_VALUE_ID = "#TYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#TYPE_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#NAME_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val("TYPE_ID;"+ofustypevalueArr[0]);
	
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				
				var newOption1 = document.createElement("OPTION"); 
				newOption1.text = "--请选择--"; 
				newOption1.value = "";
				IT_NAME_SELECT.get(0).options.add(newOption1); 
				
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].ofustype_name; 
					newOption.value = data[i].ofustype_id+";"+data[i].ofustype_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val("NAME_ID;"+data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
}

//异步填充规格下拉列表
function loadItNameSelect(OFUSTYPE_SELECT){
	var url = "getbacktypeajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value,method:"it_name"};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("NAME_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#IT_NAME_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var OFUSTYPE_NAME_VALUE_ID = "#NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#NAME_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#IT_NAME"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#IT_NAME_ID"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	
	if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val("NAME_ID;"+ofustypevalueArr[0]);
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				var newOption1 = document.createElement("OPTION"); 
				newOption1.text = "--请选择--"; 
				newOption1.value = "";
				IT_NAME_SELECT.get(0).options.add(newOption1); 
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].it_name; 
					newOption.value = data[i].it_id+";"+data[i].it_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val("IT_NAME_ID;"+data[0].it_id);
				}else{
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
}

function save(){
	jQuery("#action").val("insert");
	//解决乱码
	flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if(flag){
		var title = jQuery("#T_TITLE").val();
		jQuery("#T_TITLE").val(encodeURI(title));	
		var org_name = jQuery("#T_ORG_NAME").val();
		jQuery("#T_ORG_NAME").val(encodeURI(org_name));	
		var user_name = jQuery("#T_USER_NAME").val();
		jQuery("#T_USER_NAME").val(encodeURI(user_name));	
		var unit_name = jQuery("#UNIT_NAME").val();
		jQuery("#UNIT_NAME").val(encodeURI(unit_name));	
		document.all.form1.submit();
	}
}
function ruku() {
	jQuery("#action").val("ruku");
	var t_rkuser_name = jQuery("#t_rkuser_name").val();
	jQuery("#t_rkuser_name").val(encodeURI(t_rkuser_name));	
	document.all.form1.submit();
}
//选择规格
	function inItNameForSelect(IT_NAME_SELECT){
		var ofusvalue = IT_NAME_SELECT.value;
		var ofustypevalueArr = ofusvalue.split(";");
		
		var IT_NAME_SELECT_ID =  IT_NAME_SELECT.id;
		var IT_NAME_SELECT_ARR = IT_NAME_SELECT_ID.split("IT_NAME_SELECT");
		
		var IT_NAME_VALUE_ID = "#IT_NAME_SELECT"+IT_NAME_SELECT_ARR[1];
		var IT_ID_VALUE_ID = "#IT_NAME_ID"+IT_NAME_SELECT_ARR[1];
		var IT_ID_VALUE_NAME = "#IT_NAME"+IT_NAME_SELECT_ARR[1];
		
		jQuery(IT_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(IT_ID_VALUE_ID).val(ofustypevalueArr[0]);
		jQuery(IT_ID_VALUE_NAME).val(ofustypevalueArr[1]);
	}
</script>

</head>
<body onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="osapplyplando.jsp" class="formular" method="post">
	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsAppServiceImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/>
	<input type="hidden" id="t_rkuser_id" name="t_rkuser_id" value="<%=user_id %>">
	<input type="hidden" id="t_rkuser_name" name="t_rkuser_name" value="<%=user_name %>">
	<input type="hidden" id="t_rkdate" name="t_rkdate" value="<%=time %>">
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'> 
			<input class="but_y_01" id="add" name="add" type="button" value="提交" onclick="save();"/>
			<input class="but_y_01" id="rk" name="rk" type="button" value="入库" onclick="ruku();"/>
			<input class="but_y_01" id="back" name="back" type="button" value="返回" onclick="window.history.back();"/>
		</div>
	</div>
	 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 1000px; ">
 <!--------------采购清单-------------->
 <div class="content_02_box_div"style="width: 1000px; ">
	<div class="content_02_box_title_bg"style="width: 1000px; ">
		<span>计划表</span>
	</div>                                           
	<table  style="width: 1000px; "border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">	
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购部室：</th>
			<td class="content_02_box_div_table_td">
				<input id="action" name="action" type="hidden" value="" />
				<input type="hidden" id="T_ID" name="T_ID" value="<%=bean.getT_id() %>">
				<input type="hidden" id="UNIT_ID" name="UNIT_ID" value="<%=bean.getUnit_id() %>">
				<input type="hidden" id="UNIT_NAME" name="UNIT_NAME" value="<%=bean.getUnit_name() %>"/> 
				<input type="hidden" id="T_ORG_ID" name="T_ORG_ID" value="<%=bean.getT_org_id() %>">
				<input class="validate[required] input_title_text" id="T_ORG_NAME" name="T_ORG_NAME" readonly="readonly" value="<%=bean.getT_org_name() %>">
			</td>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>填写时间：</th>
			<td class="content_02_box_div_table_td">
				<input class="validate[required] input_title_text" id="T_CREATOR_TIME" name="T_CREATOR_TIME" readonly="readonly" value="<%=bean.getT_creator_time() %>">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购标题：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<input class="validate[required,maxSize[250]] input_title_text" id="T_TITLE" name="T_TITLE" value="<%=StringUtil.deNull(bean.getT_title()) %>">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购人：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<input type="hidden" id="T_USER_ID" name="T_USER_ID" value="<%=bean.getT_user_id() %>">
				<input class="validate[required] input_title_text" id="T_USER_NAME" name="T_USER_NAME" readonly="readonly" value="<%=bean.getT_user_name() %>">
			</td>
		</tr>
	</table>
	<div class="content_02_box_title_bg" style="width: 1000px; ">
		<span>物品清单</span>
		 <%if(action.equals("insert")) {%>
			<div class="content_02_box_add">
				<a onclick="Add_Row4NewDay1()" id="addButton"><img src="../../../resources/images/add.gif"/>添加物品</a>
			</div>
		<%} %>
	</div>
	<div class="content_02_box_div" style="width: 1000px; ">
		<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品类别</td>			
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>子类别</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品名称</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>规格型号</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>数量</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>单价</td>	
			<td class="content_02_box_div_table_th" style="text-align: center;">备注</td>	
			<%if(action.equals("insert")) {%>
			<td class="content_02_box_div_table_th" style="text-align: center;">操作</td>
			<%}else if(action.equals("read")){ %>
			<td class="content_02_box_div_table_th" style="text-align: center;">是否入库</td>
			<td class="content_02_box_div_table_th" style="text-align: center;">入库人</td>
			<td class="content_02_box_div_table_th" style="text-align: center;">入库日期</td>
			<%}else{%>
			<td class="content_02_box_div_table_th" style="text-align: center;">总价</td>
			<%}%>
			
			<%if(listItems.size()>0) {
				for(int i=0;i<listItems.size();i++){
					HashMap<String,String> itemMap = (HashMap<String,String>)listItems.get(i);
				%>
					<tr id="dayrow" name="dayrow">
						<td class="content_02_box_div_table_td">
							<input type="hidden" id="T_OS_OB_ID<%=i+1 %>" name="T_OS_OB_ID" value="<%=itemMap.get("t_os_ob_id") %>">
							<select id="PTYPE_SELECT<%=i+1 %>" name="PTYPE_SELECT" onchange="loadTypeSelect(this);" class="validate[required]" style="width: 150px;">
								<option value="">--请选择--</option>
								<%if(typeList.size()>0){ 
									for(int j=0;j<typeList.size();j++){
										Map<String,String> pTypeMap = typeList.get(j);%>
										<option value="<%=pTypeMap.get("oftype_id")+";"+pTypeMap.get("oftype_name")%>"><%=pTypeMap.get("oftype_name")%></option>
								<%}}%>
							</select>
							<input type="hidden" id="PTYPE_ID<%=i+1 %>" name="PTYPE_ID" value="<%=itemMap.get("p_type_id") %>">
							<input type="hidden" id="PTYPE_NAME<%=i+1%>" name="PTYPE_NAME" value="<%=itemMap.get("p_type") %>">
						</td>
						<td class="content_02_box_div_table_td">
							<select id="TYPE_SELECT<%=i+1 %>" name="TYPE_SELECT"onchange="loadNameSelect(this);" class="validate[required]" style="width: 150px;">
							
							</select>
							<input type="hidden" id="TYPE_ID<%=i+1 %> " name="TYPE_ID" value="<%=itemMap.get("type_id") %>">
							<input type="hidden" id="TYPE_NAME<%=i+1%>" name="TYPE_NAME" value="<%=itemMap.get("type") %>">
						</td>
						<td class="content_02_box_div_table_td">
							<select id="NAME_SELECT<%=i+1 %>" name="NAME_SELECT"onchange="loadItNameSelect(this);" class="validate[required]" style="width: 150px;">
							
							</select>
							<input type="hidden" id="NAME_ID<%=i+1 %>" name="NAME_ID" value="<%=itemMap.get("ofustype_id") %>">
							<input type="hidden" id="NAME<%=i+1 %>" name="NAME" value="<%=itemMap.get("ofustype_name") %>">
						</td>
						<td class="content_02_box_div_table_td">
							<select id="IT_NAME_SELECT<%=i+1 %>" name="IT_NAME_SELECT" onchange="inItNameForSelect(this);" class="validate[required]" style="width: 150px;">
						
							</select>
							<input type="hidden" id="IT_NAME_ID<%=i+1 %>" name="IT_NAME_ID" value="<%=itemMap.get("it_id") %>">
							<input type="hidden" id="IT_NAME<%=i+1 %>" name="IT_NAME" value="<%=itemMap.get("it_name") %>">
						</td>
						<td class="content_02_box_div_table_td">
							<input type="text" id="T_OS_OB_NO<%=i+1 %>" name="T_OS_OB_NO" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_os_ob_no") %>"/>
						</td>
						<td class="content_02_box_div_table_td">
							<input type="text" id="OFUSTYPE_MONEY<%=i+1 %>" name="OFUSTYPE_MONEY" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value="<%=itemMap.get("ofustype_money") %>"/>
						</td>
						<td class="content_02_box_div_table_td">
							<input type="text" id="T_OS_OB_BZ<%=i+1 %>" name="T_OS_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_os_ob_bz") %>"/>
						</td>
						<%if(action.equals("insert")){ %>
						<td class="content_02_box_div_table_td">
							<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
								<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
							</div>
						</td>
						<%}else if(action.equals("read")){ %>
						<td class="content_02_box_div_table_td">
							<input type="text" id="IS_RK<%=i+1 %>" name="IS_RK" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("is_rk") %>"/>
						</td>
						<td class="content_02_box_div_table_td">
							<input type="hidden" id="RK_ID<%=i+1 %>" name="RK_ID" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("rk_id") %>"/>
							<input type="text" id="RK_NAME<%=i+1 %>" name="RK_NAME" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("rk_name") %>"/>
						</td>
						<td class="content_02_box_div_table_td">
							<input type="text" id="RK_DATE<%=i+1 %>" name="RK_DATE" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("rk_date") %>"/>
						</td>
						<%} else{%>
						<td class="content_02_box_div_table_td">
							<input type="text" id="sum<%=i+1 %>" name="sum" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value=""/>
						</td>
						<%} %>
					</tr>
			<%}}%>
			
			<tr id ="dayrowhidden" name="dayrowhidden">
				<td class="content_02_box_div_table_td">
					<input type="hidden" id="T_OS_OB_ID" name="T_OS_OB_ID" value="">
					<select id="PTYPE_SELECT" name="PTYPE_SELECT" onchange="loadTypeSelect(this);" class="validate[required]" style="width: 150px;">
						<option value="">--请选择--</option>
							<%if(typeList.size()>0){ 
								for(int j=0;j<typeList.size();j++){
									Map<String,String> pTypeMap = typeList.get(j);%>
									<option value="<%=pTypeMap.get("oftype_id")+";"+pTypeMap.get("oftype_name")%>"><%=pTypeMap.get("oftype_name")%></option>
							<%}}%>
					</select>
					<input type="hidden" id="PTYPE_ID" name="PTYPE_ID" value="">
					<input type="hidden" id="PTYPE_NAME" name="PTYPE_NAME" value="">
				</td>
				<td class="content_02_box_div_table_td">
					<select id="TYPE_SELECT" name="TYPE_SELECT"onchange="loadNameSelect(this);" class="validate[required]" style="width: 150px;">
							
					</select>
					<input type="hidden" id="TYPE_ID" name="TYPE_ID" value="">
					<input type="hidden" id="TYPE_NAME" name="TYPE_NAME" value="">
				</td>
				<td class="content_02_box_div_table_td">
					<select id="NAME_SELECT" name="NAME_SELECT"onchange="loadItNameSelect(this);" class="validate[required]" style="width: 150px;">
							
					</select>
					<input type="hidden" id="NAME_ID" name="NAME_ID" value="">
					<input type="hidden" id="NAME" name="NAME" value="">
				</td>
				<td class="content_02_box_div_table_td">
					<select id="IT_NAME_SELECT" name="IT_NAME_SELECT" onchange="inItNameForSelect(this);" class="validate[required]" style="width: 150px;">
						
					</select>
					<input type="hidden" id="IT_NAME_ID" name="IT_NAME_ID" value="">
					<input type="hidden" id="IT_NAME" name="IT_NAME" value="">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="T_OS_OB_NO" name="T_OS_OB_NO" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value="0"/>
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="OFUSTYPE_MONEY" name="OFUSTYPE_MONEY" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value=""/>
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="T_OS_OB_BZ" name="T_OS_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
				</td>
				<td class="content_02_box_div_table_td">
					<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
						<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
					</div>
				</td>
			</tr>	
		</table>
	</div> 
</div>
</div>
</div>
</form>
</body>
</html>


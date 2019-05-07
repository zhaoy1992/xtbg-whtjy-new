<%@page language="java" contentType="text/html; charset=gbk"pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsapPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
   <%
   		String path = request.getContextPath();
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
		
		String user_id = accesscontroler.getUserID();
		UserCacheBean userCache = UserCache.getUserCacheBean(user_id);
		String user_name = userCache.getUser_name();
		String org_id = userCache.getOrg_id();
		String org_name = userCache.getOrg_name();
		String unit_id = userCache.getUnit_id();
		String unit_name = userCache.getUnit_name();
		String currentTime = DateUtil.getCurrentDateString("yyyy-MM-dd");
		
		String action = request.getParameter("action");
		String t_id = StringUtil.deNull(request.getParameter("t_id"));
		OsapPlanService planService = new OsapPlanServiceImpl();
		OsAppObjectService osapplanitemserviceimpl = new OsAppObjectServiceImpl();
		List<Map<String,String>> listItems = new ArrayList<Map<String,String>>();
		
		OsApplanBean bean = new OsApplanBean();
		if(StringUtil.isBlank(t_id)){
			bean.setT_id(DaoUtil.getUUID());
			bean.setT_org_id(org_id);
			bean.setT_org_name(org_name);
			bean.setUnit_id(unit_id);
			bean.setUnit_name(unit_name);
			bean.setT_user_id(user_id);
			bean.setT_user_name(user_name);
			bean.setT_creator_time(currentTime);
		}else{
			bean = planService.getById(t_id);
			listItems = osapplanitemserviceimpl.selectOsAppObject(t_id);
		}
   %>
    <!-- 公共部分开始 -->
	<title>计划</title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
		
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
			<%if(listItems.size()>0){
				for(int i=0;i<listItems.size();i++){
					Map<String,String> map = listItems.get(i);%>
					Add_Row4NewDay1(); 
					var id = '<%=i+1%>';
					jQuery("#T_OS_OB_ID"+id).val("<%=StringUtil.deNull(map.get("t_os_ob_id"))%>");	
					jQuery("#TYPE_ID"+id).val("<%=StringUtil.deNull(map.get("type_id"))%>");	
					jQuery("#TYPE_NAME"+id).val("<%=StringUtil.deNull(map.get("type"))%>");
					
					//jQuery("#NAME_SELECT"+id).val("<%=StringUtil.deNull(map.get("ofustype_id"))+ ";" + StringUtil.deNull(map.get("ofustype_name")) %>");
					jQuery("#NAME_SELECT"+id).hide();
					jQuery("#NAME_ID"+id).val("<%=StringUtil.deNull(map.get("ofustype_id"))%>");
					jQuery("#NAME"+id).val("<%=StringUtil.deNull(map.get("ofustype_name"))%>");
					
					//jQuery("#IT_NAME_SELECT"+id).val("<%=StringUtil.deNull(map.get("it_id"))+ ";" + StringUtil.deNull(map.get("it_name"))%>");
					jQuery("#IT_NAME_SELECT"+id).hide();
					jQuery("#IT_NAME_ID"+id).val("<%=StringUtil.deNull(map.get("it_id"))%>");
					jQuery("#IT_NAME"+id).val("<%=StringUtil.deNull(map.get("it_name"))%>");
					
					jQuery("#T_OS_OB_NO"+id).val("<%=StringUtil.deNull(map.get("t_os_ob_no"))%>");
					jQuery("#OFUSTYPE_MONEY"+id).val("<%=StringUtil.deNull(map.get("ofustype_money"))%>");
					jQuery("#T_OS_OB_BZ"+id).val("<%=StringUtil.deNull(map.get("t_os_ob_bz"))%>");
					jQuery("#IS_RK"+id).val("<%=StringUtil.deNull(map.get("is_rk"))%>");
					jQuery("#RK_ID"+id).val("<%=StringUtil.deNull(map.get("rk_id"))%>");
					jQuery("#RK_NAME"+id).val("<%=StringUtil.deNull(map.get("rk_name"))%>");
					jQuery("#RK_DATE"+id).val("<%=StringUtil.deNull(map.get("rk_date"))%>");
					
			<%}}%>
			jQuery("#dayrowhidden").hide();
			if(action == "insert"){
				jQuery("#back").hide();
				jQuery("#rk").hide();
			}else if(action == "update"){
				jQuery("#add").hide();
				jQuery("#tjwp").hide();
			}else{
				jQuery("#add").hide();
				jQuery("#rk").hide();
				jQuery("#tjwp").hide();
			}
		});

		function Add_Row4NewDay1(){
			var lastTrObject = jQuery("[name=dayrow]").last();
			var lastTr = jQuery("[name=dayrowhidden]").last().clone();
				
			jQuery(lastTr).find("input[type=text]").val("");	
			jQuery(lastTr).find("input[type=hidden]").val("");
			//得id序号
			var lastSelectId = lastTrObject.find("select[name=NAME_SELECT]").attr("id");
			var newlastSelectId;
			if(lastSelectId){
				var lastSelectIdArr = lastSelectId.split("NAME_SELECT");
				newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
			}else{
				newlastSelectId = 1;
			}
			//物品名称下拉框
			jQuery(lastTr).find("select[name=NAME_SELECT]").attr("id","NAME_SELECT"+newlastSelectId);
			jQuery(lastTr).find("select[name=NAME_SELECT]").empty();
			jQuery(lastTr).find("select[name=NAME_SELECT]").show();
			jQuery(lastTr).find("input[name=NAME_ID]").attr("id","NAME_ID"+newlastSelectId);
			jQuery(lastTr).find("input[name=NAME]").attr("id","NAME"+newlastSelectId);
			//型号规格下拉框
			jQuery(lastTr).find("select[name=IT_NAME_SELECT]").attr("id","IT_NAME_SELECT"+newlastSelectId);
			jQuery(lastTr).find("select[name=IT_NAME_SELECT]").empty();
			jQuery(lastTr).find("select[name=IT_NAME_SELECT]").show();
			jQuery(lastTr).find("input[name=IT_NAME_ID]").attr("id","IT_NAME_ID"+newlastSelectId);
			jQuery(lastTr).find("input[name=IT_NAME]").attr("id","IT_NAME"+newlastSelectId);
			//赋id
			jQuery(lastTr).find("input[name=T_OS_OB_ID]").attr("id","T_OS_OB_ID"+newlastSelectId);
			jQuery(lastTr).find("input[name=TYPE_ID]").attr("id","TYPE_ID"+newlastSelectId);
			jQuery(lastTr).find("input[name=TYPE_NAME]").attr("id","TYPE_NAME"+newlastSelectId);
			jQuery(lastTr).find("input[name=T_OS_OB_NO]").attr("id","T_OS_OB_NO"+newlastSelectId);
			jQuery(lastTr).find("input[name=OFUSTYPE_MONEY]").attr("id","OFUSTYPE_MONEY"+newlastSelectId);
			jQuery(lastTr).find("input[name=T_OS_OB_BZ]").attr("id","T_OS_OB_BZ"+newlastSelectId);
			jQuery(lastTr).find("input[name=IS_RK]").attr("id","IS_RK"+newlastSelectId);
			jQuery(lastTr).find("input[name=RK_ID]").attr("id","RK_ID"+newlastSelectId);
			jQuery(lastTr).find("input[name=RK_NAME]").attr("id","RK_NAME"+newlastSelectId);
			jQuery(lastTr).find("input[name=RK_DATE]").attr("id","RK_DATE"+newlastSelectId);
			jQuery(lastTr).find("input[name=sum]").attr("id","sum"+newlastSelectId);
			
			if(action == "insert"){
				jQuery(lastTr).find("input[name=NAME]").hide();
				jQuery(lastTr).find("input[name=IT_NAME]").hide();
			}
			
			lastTr.attr("id","dayrow");
			lastTr.attr("name","dayrow");
			lastTr.attr("style","");
			
			var dayTable = jQuery("#dayTable");
			
			lastTr.appendTo(dayTable);
			
			jQuery(lastTr).find(".date_187").each(function(i,e){
				setDataTimeClickShowOrHide($(this).attr("id"),window);
			})
		};
		
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
		};
		
		function chooseType(type_name){
			var type_name_id =  type_name.id;
			var type_name_id_arr = type_name_id.split("TYPE_NAME");
			var new_type_id = "#TYPE_ID"+type_name_id_arr[1];
			var new_name_select_id = "#NAME_SELECT"+type_name_id_arr[1];
			var name_select = jQuery(new_name_select_id);
			var new_it_name_select_id = "#IT_NAME_SELECT"+type_name_id_arr[1];
			var it_name_select = jQuery(new_it_name_select_id);
			
			var s = new $.z_tree();
			s.treeID='mian';
			s.treetypestr='radio';
			s.isShowSeacher=true;
			s.treeName="选取类型";
			s.isType='dept';
			s.headerName="选取类型";
			s.item_id = 'oftype_id';
			s.selectedIds = jQuery(new_type_id).val();
			s.type='OSUPPLIE_TYPE';
			s.returnFunction=function(orgObj){
				it_name_select.empty(); //物品类别改变 规格也跟着改变
				if(!IsSpace(orgObj)){
					jQuery(new_type_id).val(orgObj.id);
					type_name.value = orgObj.name;
					var url = "getbacktypeajax2.jsp";
					var params = {ofustypeValue:orgObj.id,method:"name"};
					name_select.show();
					jQuery.ajax({
						async:false,
						url: url,
						type: 'POST',
						dataType: 'json',
						data: params,
						success: function(data){
							name_select.empty();
								
							var newOption1 = document.createElement("OPTION"); 
							newOption1.text = "--请选择--"; 
							newOption1.value = "";
							name_select.get(0).options.add(newOption1); 
								
							for (var i = 0; i<data.length; i++){
								//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
								var newOption = document.createElement("OPTION"); 
								newOption.text = data[i].ofustype_name; 
								newOption.value = data[i].ofustype_id + ";" + data[i].ofustype_name;
								
								name_select.get(0).options.add(newOption); 
							}
						},
						error: function(jqXHR, textStatus, errorThrown){
							alert(jqXHR);
							alert(textStatus);
							alert(errorThrown);
						}
					});
				}else{
					jQuery(new_type_id).val("");
					type_name.value = "";
					name_select.empty();
				}
			}
			s.init();
		};
		
		function loadItNameSelect(name_select){
			var name_select_value = name_select.value;
			var name_select_value_arr = name_select_value.split(";");
			
			var url = "getbacktypeajax2.jsp";
			var params = {ofustypeValue:name_select_value_arr[0],method:"it_name"};
			
			var name_select_id  = name_select.id;
			var name_select_id_arr = name_select_id.split("NAME_SELECT");
			
			var it_name_select_id = "#IT_NAME_SELECT" + name_select_id_arr[1];
			var name_id_id = "#NAME_ID" + name_select_id_arr[1];
			var name_id = "#NAME" +name_select_id_arr[1];
			
			var it_name_select = jQuery(it_name_select_id);
			if(name_select.value == ""){
				it_name_select.empty();
			}else{
				jQuery(name_id_id).val(name_select_value_arr[0]);
				jQuery(name_id).val(name_select_value_arr[1]);
				it_name_select.show();
				
				jQuery.ajax({
					async:false,
					url: url,
					type: 'POST',
					dataType: 'json',
					data: params,
					success: function(data){
						it_name_select.empty();
						var newOption1 = document.createElement("OPTION"); 
						newOption1.text = "--请选择--"; 
						newOption1.value = "";
						it_name_select.get(0).options.add(newOption1); 
						
						for (var i = 0; i<data.length; i++){
							//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
							var newOption = document.createElement("OPTION"); 
							newOption.text = data[i].it_name; 
							newOption.value = data[i].it_id + ";" + data[i].it_name;
							
							it_name_select.get(0).options.add(newOption); 
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
						alert(jqXHR);
						alert(textStatus);
						alert(errorThrown);
					}
				});
			}
		};
		
		function inItNameForSelect(it_name_select){
			var it_name_select_value = it_name_select.value;
			var it_name_select_value_arr = it_name_select_value.split(";");
			var it_name_select_id = it_name_select.id;
			var it_name_select_id_arr = it_name_select_id.split("IT_NAME_SELECT");
			var it_name_id_id = "#IT_NAME_ID" + it_name_select_id_arr[1];
			var it_name_id = "#IT_NAME" + it_name_select_id_arr[1];
			if(it_name_select == ""){
				jQuery(it_name_id_id).val("");
				jQuery(it_name_id).val("");
			}else{
				jQuery(it_name_id_id).val(it_name_select_value_arr[0]);
				jQuery(it_name_id).val(it_name_select_value_arr[1]);
			}
		};
		function save(){
			jQuery("#action").val("insert");
			flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
			if(flag){
				document.all.form1.submit();
			}
		};
		function ruku(){
			jQuery("#action").val("ruku");
			jQuery("#t_state").val("1");
			flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
			if(flag){
				document.all.form1.submit();
			}
		};
		//得总价 OFUSTYPE_MONEY
		function getSum(ofustype_money){
			var ofustype_money_value = ofustype_money.value;
			var ofustype_money_id = ofustype_money.id;
			var id_arr = ofustype_money_id.split("OFUSTYPE_MONEY");
			var new_sum_id = "#sum" + id_arr[1];
			var new_no_id = "#T_OS_OB_NO" + id_arr[1];
			var no_value = jQuery(new_no_id).val();
			jQuery(new_sum_id).val(no_value * ofustype_money_value);
		};
		//检查数量 大于等于0
		function checkHavaNo(t_os_ob_no){
			var number = t_os_ob_no.value;
			var regex = /^\+?[1-9][0-9]*$/;
			var re = new RegExp(regex);
			if(!re.test(number)){
				alert("数量为大于0的整数！");
				t_os_ob_no.value = "";
			}
		};
	</script>
  </head>
  
  <body onload="adaptationWH('_top','vcenter',45);">
  <form id="form1" name="form1" action="osapplyplando2.jsp" class="formular" method="post">
  	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsAppServiceImpl2" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/>
 	<input type="hidden" id="t_state" name="t_state" value="">
 	<input type="hidden" id="t_rkuser_id" name="t_rkuser_id" value="<%=user_id %>">
  	<input type="hidden" id="t_rkuser_name" name="t_rkuser_name" value="<%=user_name %>">
  	<input type="hidden" id="t_rkdate" name="t_rkdate" value="<%=currentTime %>">
  	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'> 
			<input class="but_y_01" id="add" name="add" type="button" value="提交" onclick="save();"/>
			<input class="but_y_01" id="rk" name="rk" type="button" value="入库" onclick="ruku();"/>
			<input class="but_y_01" id="back" name="back" type="button" value="返回" onclick="window.history.back();"/>
		</div>
	</div>
  	<div id="vcenter" style="float: left; width: 100%;">
  		<div style="float: left; width: 1000px; ">
  			<div class="content_02_box_div"style="width: 1000px; ">
  				<div class="content_02_box_title_bg"style="width: 1000px; ">
					<span>计划表</span>
				</div> 
				<table  style="width: 1000px; "border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">	
					<tr>
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购部室：</th>
						<td class="content_02_box_div_table_td">
							<input id="action" name="action" type="hidden" value="" />
							<input id="t_id" name="t_id" type="hidden" value="<%=StringUtil.deNull(bean.getT_id()) %>">
							<input id="unit_id" name="unit_id" type="hidden" value="<%=StringUtil.deNull(bean.getUnit_id()) %>">
							<input id="unit_name" name="unit_name" type="hidden" value="<%=StringUtil.deNull(bean.getUnit_name()) %>">
							
							<input id="t_org_id" name="t_org_id" type="hidden" value="<%=StringUtil.deNull(bean.getT_org_id()) %>">
							<input class="validate[required] input_title_text" id="t_org_name" name="t_org_name" type="text" readonly="readonly" value="<%=StringUtil.deNull(bean.getT_org_name()) %>"/>
						</td>
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>填写时间</th>
						<td class="content_02_box_div_table_td">
							<input class="validate[required] input_title_text" id="t_creator_time" name="t_creator_time" type="text" readonly="readonly" value="<%=StringUtil.deNull(bean.getT_creator_time()) %>"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购标题</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<input class="validate[required,maxSize[250]] input_title_text" id="t_title" name="t_title" type="text" value="<%=StringUtil.deNull(bean.getT_title()) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>申购人</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<input id="t_user_id" name="t_user_id" type="hidden" value="<%=StringUtil.deNull(bean.getT_user_id()) %>">
							<input class="validate[required] input_title_text" id="t_user_name" name="t_user_name" type="text" readonly="readonly" value="<%=StringUtil.deNull(bean.getT_user_name()) %>"/>
						</td>
					</tr>
				</table>
				<div class="content_02_box_title_bg"style="width: 1000px; ">
					<span>物品清单</span>
					<div class="content_02_box_add" id="tjwp">
						<a onclick="Add_Row4NewDay1()" id="addButton"><img src="../../../resources/images/add.gif"/>添加物品</a>
					</div>
				</div> 
				<div class="content_02_box_div" style="width: 100%;">
					<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
						<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品类别</td>	
						<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>物品名称</td>	
						<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>规格型号</td>
						<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>数量</td>	
						<td class="content_02_box_div_table_th" style="text-align: center;">备注</td>
						<%if(action.equals("insert")) {%>		
						<td class="content_02_box_div_table_th" style="text-align: center;">操作</td>
						<%}else if(action.equals("read")) {%>	
						<td class="content_02_box_div_table_th" style="text-align: center;">是否入库</td>
						<td class="content_02_box_div_table_th" style="text-align: center;">入库人</td>
						<td class="content_02_box_div_table_th" style="text-align: center;">入库日期</td>
						<%}else{ %>
						<td class="content_02_box_div_table_th" style="text-align: center;"><span class="color_red">*</span>单价</td>
						<td class="content_02_box_div_table_th" style="text-align: center;">总价</td>
						<%} %>
						<tr id="dayrowhidden" name="dayrowhidden">
							<td class="content_02_box_div_table_td">
								<input type="hidden" id="T_OS_OB_ID" name="T_OS_OB_ID" value="">
								<input type="hidden" id="TYPE_ID" name="TYPE_ID" >
								<input type="text" id="TYPE_NAME" name="TYPE_NAME" onclick="chooseType(this);" readonly="readonly" class="input_title_text"  style="text-align: center;">
							</td>
							<td class="content_02_box_div_table_td">
								<select id="NAME_SELECT" name="NAME_SELECT" onchange="loadItNameSelect(this);" class="validate[required]" style="width: 150px;">
										
								</select>
								<input type="hidden" id="NAME_ID" name="NAME_ID" value="">
								<input type="text" id="NAME" name="NAME" class="input_title_text"  style="text-align: center;">
							</td>
							<td	class="content_02_box_div_table_td">
								<select id="IT_NAME_SELECT" name="IT_NAME_SELECT" onchange="inItNameForSelect(this);" class="validate[required]" style="width: 150px;">
						
								</select>
								<input type="hidden" id="IT_NAME_ID" name="IT_NAME_ID" value="">
								<input type="text" id="IT_NAME" name="IT_NAME" class="input_title_text"  style="text-align: center;">
							</td>
							<td class="content_02_box_div_table_td">
								<input type="text" id="T_OS_OB_NO" onblur="checkHavaNo(this);" name="T_OS_OB_NO" class="validate[required,maxSize[20]] input_title_text" style="text-align: center;"/>
							</td>
							<td class="content_02_box_div_table_td">
								<input type="text" id="T_OS_OB_BZ" name="T_OS_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
							</td>
							<%if(action.equals("insert")){ %>
							<td class="content_02_box_div_table_td">
								<div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
									<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								</div>
							</td>
							<%}else if(action.equals("read")){ %>
							<td	class="content_02_box_div_table_td">
								<input id="IS_RK" name="IS_RK" type="text" class="input_title_text" style="text-align: center;" />
							</td>
							<td	class="content_02_box_div_table_td">
								<input id="RK_ID" name="RK_ID" type="hidden"/>
								<input id="RK_NAME" name="RK_NAME" type="text" class="input_title_text" style="text-align: center;" />
							</td>
							<td	class="content_02_box_div_table_td">
								<input id="RK_DATE" name="RK_DATE" type="text" class="input_title_text" style="text-align: center;" />
							</td>
							<%}else{ %>
							<td class="content_02_box_div_table_td">
								<input type="text" id="OFUSTYPE_MONEY" onblur="getSum(this);" name="OFUSTYPE_MONEY" class="validate[required,maxSize[20],custom[onlyNumberSD2]] input_title_text" style="text-align: center;"/>
							</td>
							<td	class="content_02_box_div_table_td">
								<input id="sum" name="sum" type="text" class="input_title_text" style="text-align: center;" />
							</td>
							<%} %>
						</tr>
					</table>
				</div>
  			</div>
  		</div>
  	</div>
  </form>
  </body>
</html>

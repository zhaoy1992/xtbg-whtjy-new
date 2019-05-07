<%--
描述：申购审批界面
作者：童佳
版本：1.0
日期：2014-03-07
--%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsExaminationObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsExaminationObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsapPlanItemServiceImpl"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
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
	
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(user_id);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();

	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	if(StringUtil.nullOrBlank(busi_id)){
		busi_id = StringUtil.getUUID();
	}
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//正文ID
	String document_id = UUID.randomUUID().toString();
	
	//物品列表业务实现类
	OsExaminationObjectService osExaminationObjectService = new OsExaminationObjectServiceImpl();
	List<Map<String,String>> listItems = osExaminationObjectService.selectOsExaObject(busi_id);
	//相关计划表id
	String OsExaIds = osExaminationObjectService.queryOsAppIdsForExaId(busi_id);
	
	//所有常用物品信息
	OsupplieUseTypeService osupplieUseTypeService = new OsupplieUseTypeServiceImpl();
	List<Map<String, String>> allOsupplieUseList = new ArrayList<Map<String,String>>();
	allOsupplieUseList = osupplieUseTypeService.queryAllOsupplieUseType(unit_id);
	
/* 	//简报类型 
	WorkReportTypeServiceImpl workReportTypeDaoImpl = new WorkReportTypeServiceImpl();
	List<Map<String,String>> reportTypeList =  workReportTypeDaoImpl.findAllWorkType(); */
	//物品名称
	/* String sql = "select i.ofustype_id, i.ofustype_name from ta_oa_osupplieusetype i order by i.ofustype_no";
	String ofustypeHtml = DictDropDownList.buildOsSelect(sql,"ofustype_id","","",true,"","");
	//物品规格
	String sql1 = "select i.it_id, i.it_name from ta_oa_osusertypeitem i order by i.it_no";
	String typeItemHtml = DictDropDownList.buildOsSelect(sql1,"susertypeitem_id","","",true,"",""); */
	
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="gzjb_wp1_act1";
	}
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
%>
<!-- 公共部分开始 -->
<title>申购计划审批</title>
	<!-- 引入jQuery -->
    <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../../../oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!-- 引入my97时间控件 -->
	<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	<!-- 引入jQuery UI -->
	<!-- 引入其它 -->
	<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
	<script src="../../../../oa/resources/js/common/commoncss.js" type="text/javascript"></script>
	<!-- 引入jQuery_dialog -->
	<script src="../../../../oa/resources/plug/jquery_dialog/jquery_dialog.js"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../../../oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript"src="../../../../oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script src="../../../../oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type="text/javascript" src="ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" href="ccapp/xtbg/resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript">

//添加物品
function Add_Row4NewDay1(){
	var lastTrObject = jQuery("[name=dayrow]").last();
	var lastTr = jQuery("[name=dayrowhidden]").last().clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[name=T_OS_OB_ID]").val("");
	//序号
	jQuery(lastTr).find("input[name=sequencId]").val("");
	
	var lastSelectId = lastTrObject.find("select[name=OFUSTYPE_SELECT]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("OFUSTYPE_SELECT");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}
	jQuery(lastTr).find("select[name=OFUSTYPE_SELECT]").attr("id","OFUSTYPE_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=OFUSTYPE_SELECT]").val("");
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").attr("id","IT_NAME_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").empty();
	jQuery(lastTr).find("select[name=IT_NAME_SELECT]").show();
	jQuery(lastTr).find("input[name=OFUSTYPE_NAME]").attr("id","OFUSTYPE_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_NAME]").hide();
	jQuery(lastTr).find("input[name=IT_NAME]").attr("id","IT_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_NAME]").hide();
	
	jQuery(lastTr).find("input[name=IT_NAME_VALUE]").attr("id","IT_NAME_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_ID_VALUE]").attr("id","IT_ID_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_ID_VALUE]").val("IT_ID_VALUE;");
	jQuery(lastTr).find("input[name=OFUSTYPE_NAME_VALUE]").attr("id","OFUSTYPE_NAME_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_ID_VALUE]").attr("id","OFUSTYPE_ID_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_ID_VALUE]").val("OFUSTYPE_ID_VALUE;")
	
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ORG_IDS]").attr("id","T_OSEXA_OB_ORG_IDS"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ORG_NAMES]").attr("id","T_OSEXA_OB_ORG_NAMES"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OS_OB_ID]").attr("id","T_OS_OB_ID"+newlastSelectId);
	//序号
	jQuery(lastTr).find("input[name=sequencId]").attr("id","sequencId"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ID]").attr("id","T_OSEXA_OB_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OSEXA_OB_NO]").attr("id","T_OSEXA_OB_NO"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OSEXA_OB_DJ]").attr("id","T_OSEXA_OB_DJ"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OSEXA_OB_BZ]").attr("id","T_OSEXA_OB_BZ"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_OS_OB_KC]").attr("id","T_OS_OB_KC"+newlastSelectId);//库存
	
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	
	var dayTable = jQuery("#dayTable");
	
	lastTr.appendTo(dayTable);
	
	//序号 赋值
	jQuery("#sequencId"+newlastSelectId).val(newlastSelectId);
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
	jQuery("[name=dayrow]").show();
}

function open_OsAppList(){
	var path ="<%=path%>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/osappovernoexalist.jsp?windowsId=windowIds";
	openAlertWindows('windowIds',path,'计划表列表',810,400,'25%','25%');
}

//添加计划表
function Add_RowForOsApp(){
	var lastTrObject = jQuery("[name=osapprow]").last();
	
	var lastTr = jQuery("[name=osapprowhidden]").last().clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	var lastSelectId = lastTrObject.find("input[name=osapp_id]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("osapp_id");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}
	
	
	lastTr.attr("id","osapprow");
	lastTr.attr("name","osapprow");
	
	jQuery(lastTr).find("input[name=osapp_id]").attr("id","osapp_id"+newlastSelectId);
	jQuery(lastTr).find("input[name=osapp_id]").val("");
	jQuery(lastTr).find("input[name=osapp_name]").attr("id","osapp_name"+newlastSelectId);
	jQuery(lastTr).find("input[name=osapp_name]").val("");
	jQuery(lastTr).find("input[name=osapp_user_name]").attr("id","osapp_user_name"+newlastSelectId);
	jQuery(lastTr).find("input[name=osapp_user_name]").val("");
	jQuery(lastTr).find("input[name=osapp_org_name]").attr("id","osapp_org_name"+newlastSelectId);
	jQuery(lastTr).find("input[name=osapp_org_name]").val("");
	jQuery(lastTr).find("input[name=osapp_date]").attr("id","osapp_date"+newlastSelectId);
	jQuery(lastTr).find("input[name=osapp_date]").val("");
	
	var osappTable = jQuery("#osappTable");
	
	lastTr.appendTo(osappTable);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
}

//删除物品
function deleteDay(tag,goodsId){
	
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var osapp_id = jQuery(tr).find("input[name=osapp_id]").val();
	var t_Ids = jQuery("#T_IDS").val();
	var firstindex = t_Ids.indexOf(osapp_id);
	var charsplit = t_Ids.substr(firstindex-1,1);
	if(charsplit==","){
		t_Ids = t_Ids.replace(","+osapp_id,"");
	} else {
		t_Ids = t_Ids.replace(osapp_id,"");
	}
	//重新赋值
	jQuery("#T_IDS").val(t_Ids)
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		Add_Row4NewDay1();
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
	loadOsAppItemObject("",'<%=busi_id%>');
}

function inOfusTypeValue(OFUSTYPE_NAME){
	var OFUSTYPE_NAME_ID =  OFUSTYPE_NAME.id;
	var OFUSTYPE_NAME_ARR = OFUSTYPE_NAME_ID.split("OFUSTYPE_NAME");
	
	var OFUSTYPE_NAME_VALUE_ID = "#OFUSTYPE_NAME_VALUE"+OFUSTYPE_NAME_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#OFUSTYPE_ID_VALUE"+OFUSTYPE_NAME_ARR[1];
	
	jQuery(OFUSTYPE_NAME_VALUE_ID).val(OFUSTYPE_NAME.value);
	jQuery(OFUSTYPE_ID_VALUE_ID).val("OFUSTYPE_ID_VALUE;");
}

function inItNameForSelect(IT_NAME_SELECT){
	var ofusvalue = IT_NAME_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");
	
	var IT_NAME_SELECT_ID =  IT_NAME_SELECT.id;
	var IT_NAME_SELECT_ARR = IT_NAME_SELECT_ID.split("IT_NAME_SELECT");
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+IT_NAME_SELECT_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+IT_NAME_SELECT_ARR[1];
	
	jQuery(IT_NAME_VALUE_ID).val(ofustypevalueArr[1]);
	jQuery(IT_ID_VALUE_ID).val("IT_ID_VALUE;"+ofustypevalueArr[0]);
	
	checkHavaNo(jQuery("#T_OSEXA_OB_NO"+IT_NAME_SELECT_ARR[1]));
	
}

function inItNameForText(IT_NAME){
	var IT_NAME_ID =  IT_NAME.id;
	var IT_NAME_ARR = IT_NAME_ID.split("IT_NAME");
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+IT_NAME_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+IT_NAME_ARR[1];
	
	jQuery(IT_NAME_VALUE_ID).val(IT_NAME.value);
	jQuery(IT_ID_VALUE_ID).val("IT_ID_VALUE;");
}

//异步获取计划表信息并填充表格信息
function loadOsAppItem(OsAppIds,_bus_id){
	var osapprowtr = jQuery("[name=osapprow]");
	for (var j = 0; j<osapprowtr.length; j++){
		var m = j+1;
		if(osapprowtr.find("input[id=osapp_id"+m+"]").val()){
			OsAppIds = OsAppIds+","+osapprowtr.find("input[id=osapp_id"+m+"]").val();
		}
	}
	var url = "<%=path %>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/getbackosappajax.jsp";
	var params = {osappitem:OsAppIds,bus_id:_bus_id};
	
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			osapprowtr.remove();
			for (var i = 0; i<data.length; i++){
				Add_RowForOsApp();
				jQuery("#osapp_id"+(i+1)).val(data[i].t_id);
				jQuery("#osapp_name"+(i+1)).val(data[i].t_title);
				jQuery("#osapp_user_name"+(i+1)).val(data[i].t_user_name);
				jQuery("#osapp_org_name"+(i+1)).val(data[i].t_org_name);
				jQuery("#osapp_date"+(i+1)).val(data[i].t_creator_time);
			}
			jQuery("#T_IDS").val(OsAppIds);
			jQuery("[name=osapprow]").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}

//同步获取计划表物品信息并填充表格信息
function loadOsAppItemObject(OsAppIds,_bus_id){
	var osapprowtr = jQuery("[name=osapprow]");
	for (var j = 0; j<osapprowtr.length; j++){
		if(jQuery(osapprowtr[j]).find("input[name=osapp_id]").val()){
			OsAppIds = OsAppIds+","+jQuery(osapprowtr[j]).find("input[name=osapp_id]").val();
		}
	}
	var url = "<%=path %>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/getbackosappobjectajax.jsp";
	var params = {osappitem:OsAppIds,bus_id:_bus_id};
	var dayrowtr = jQuery("[name=dayrow]");
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			dayrowtr.remove();
			for (var i = 0; i<data.length; i++){
				Add_Row4NewDay1();
				var objectidno = i+1;
				//序号
				jQuery("#sequencId"+objectidno).val(objectidno);
				
				jQuery("#T_OS_OB_ID"+objectidno).val(data[i].t_os_ob_id);
				jQuery("#T_OSEXA_OB_ORG_IDS"+objectidno).val(data[i].t_org_id);
				jQuery("#T_OSEXA_OB_ORG_NAMES"+objectidno).val(data[i].t_org_name);
				//绑定点击事件
				jQuery("#T_OSEXA_OB_ORG_NAMES"+objectidno).bind('click',{num: objectidno} ,function(event){
					var t_os_ob_id = jQuery("#T_OS_OB_ID"+event.data.num).val();
					showosOrglist(t_os_ob_id);
				});
				jQuery("#T_OSEXA_OB_NO"+objectidno).val(data[i].t_os_ob_no);
				
				if(data[i].ofustype_id){
					jQuery("#OFUSTYPE_SELECT"+objectidno).val(data[i].ofustype_id+";"+data[i].ofustype_name);
				    jQuery("#OFUSTYPE_SELECT"+objectidno).change();
					jQuery("#IT_NAME_SELECT"+objectidno).val(data[i].it_id+";"+data[i].it_name);
					jQuery("#IT_NAME_SELECT"+objectidno).change();
				}else{
					jQuery("#OFUSTYPE_SELECT"+objectidno).val("qita;qita");
					jQuery("#OFUSTYPE_SELECT"+objectidno).change();
					jQuery("#OFUSTYPE_NAME"+objectidno).val(data[i].ofustype_name);
					jQuery("#OFUSTYPE_NAME"+objectidno).change();
					jQuery("#IT_NAME"+objectidno).val(data[i].it_name);
					jQuery("#IT_NAME"+objectidno).change();
				} 
				
				checkHavaNo(jQuery("#T_OSEXA_OB_NO"+objectidno));
			}
			jQuery("[name=dayrow]").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
	 jQuery("#T_OSEXA_TITLE").focus();
}

//查询出库存数量
function checkHavaNo(T_OSEXA_OB_NO){
	var url = "<%=path %>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/getbackoshavabyitidajax.jsp";
	
	var T_OSAPPREG_OB_NO_ID = T_OSEXA_OB_NO.attr("id");
	var T_OSAPPREG_OB_NO_IDArr = T_OSAPPREG_OB_NO_ID.split("T_OSEXA_OB_NO");
    var IT_ID_VALUE = jQuery("#IT_ID_VALUE"+T_OSAPPREG_OB_NO_IDArr[1]).val();
    
    var T_NOW_OB_NO_NUM;                                              //库存数量
	
	var params = {it_id:IT_ID_VALUE};
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if(data.length>0){
				for (var i = 0; i<data.length; i++){
					if(data[i].t_ha_no==""){
						data[i].t_ha_no = "0";
					}
					T_NOW_OB_NO_NUM = parseFloat(data[i].t_ha_no);
				}
			}else{
				T_NOW_OB_NO_NUM = 0;
			}
			jQuery("#T_OS_OB_KC"+T_OSAPPREG_OB_NO_IDArr[1]).val(T_NOW_OB_NO_NUM);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}

//同步填充规格下拉列表
function loadItNameSelect(OFUSTYPE_SELECT,it_select_value){
	var url = "<%=path %>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/getbackitnameajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("OFUSTYPE_SELECT");
	var NEW_OFUSTYPE_SELECT_ID = "#IT_NAME_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#OFUSTYPE_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#OFUSTYPE_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	if(ofusvalue != "" && ofustypevalueArr[1] == "qita"){
		jQuery("#OFUSTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).show();
		//清空
		jQuery("#IT_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1]).val("IT_ID_VALUE;");
		jQuery("#IT_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).show();
		IT_NAME_SELECT.hide();
	//请选择
	} else if(ofusvalue == ""){
		jQuery("#IT_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1]).val("IT_ID_VALUE;");
		IT_NAME_SELECT.empty();
	} else{
		jQuery("#OFUSTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).hide();
		jQuery("#IT_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).hide();
		
		jQuery(OFUSTYPE_NAME_VALUE_ID).val(ofustypevalueArr[1]);
		jQuery(OFUSTYPE_ID_VALUE_ID).val("OFUSTYPE_ID_VALUE;"+ofustypevalueArr[0]);
		
		IT_NAME_SELECT.show();
		jQuery.ajax({
			async:false,
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				IT_NAME_SELECT.empty();
				for (var i = 0; i<data.length; i++){
					//IT_NAME_SELECT.append("<option value='"+data[i].it_id+";"+data[i].it_name+"'>"+data[i].it_name+"</option>");//不能使用此方法IE8有兼容性BUG
					var newOption = document.createElement("OPTION"); 
					newOption.text = data[i].it_name; 
					newOption.value = data[i].it_id+";"+data[i].it_name;
					
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				if(data.length > 0){
					jQuery(IT_NAME_VALUE_ID).val(data[0].it_name);
					jQuery(IT_ID_VALUE_ID).val("IT_ID_VALUE;"+data[0].it_id);
				}else{                                                    //空值时调整IE8出现的BUG
					var newOption = document.createElement("OPTION");
					IT_NAME_SELECT.get(0).options.add(newOption); 
				}
				IT_NAME_SELECT.eq(0).attr('selected', 'true');
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}
	// jQuery("#TA_OA_OSEXAMINATION__T_OSEXA_TITLE").focus();
	checkHavaNo(jQuery("#T_OSEXA_OB_NO"+OFUSTYPE_SELECT_ID_ARR[1]));
}

jQuery(function(){
	 jQuery("#T_OSEXA_TITLE").focus();
	 setValue();
	 //已办列表进来 屏蔽 添加按钮 删除按钮
	 <%if(operType.equals("yiban")){%>
		 jQuery("#addButton").hide();
		 jQuery("a[name=delbtn]").hide();
	 <%}%>
  	
  	jQuery("[name=osapprowhidden]").hide();
  	jQuery("[name=dayrowhidden]").hide();
  	
  	<%if(!"gzjb_wp1_act1".equals(action_defid)){%>
  		//jQuery("#addButton").hide();
  	<%}%>
});

function setValue(){
	loadOsAppItem("<%=OsExaIds%>","<%=busi_id%>");
	<% 
	 if(listItems.size()>0){
		for(int i=0;i<listItems.size();i++){
			HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i);
	 %>	
			jQuery("#OFUSTYPE_SELECT<%=i+1%>").val("<%=itemMap.get("ofustype_id") %>"+";"+"<%=itemMap.get("ofustype_name") %>");
			jQuery("#OFUSTYPE_SELECT<%=i+1%>").change();
			jQuery("#IT_NAME_SELECT<%=i+1%>").val("<%=itemMap.get("it_id") %>"+";"+"<%=itemMap.get("it_name") %>");
			jQuery("#IT_NAME_SELECT<%=i+1%>").change();
			checkHavaNo(jQuery("#T_OSEXA_OB_NO<%=i+1%>"));
	 <%   }
	 }%>
}
//展示机构物品数量列表
function showosOrglist(t_os_ob_ids){
	openAlertWindows('windowId',getCurrentFilePath()+'showosorglist.jsp?t_os_ob_ids='+ t_os_ob_ids,'查看物品明细数','60%','400','20%');
}
</script>

</head>
<body style="overflow: auto;">
<form id="form1" name="form1" action="osexaminationdo.jsp" method="post" >
	<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input type="hidden" id="org_id" name="org_id"  value="<%=org_id%>"/>
	<input type="hidden" id="orgName" name="orgName"  value="<%=orgName%>"/>
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="unit_id" name="unit_id"  value="<%=unit_id %>" />
	<input type="hidden" id="unit_name" name="unit_name"  value="<%=unit_name %>" />
<div id="tabs1" style="width:70%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
					<input class="but_y_01" type="button" id="sel"  value="入库" onclick="Ok();"/>
					<input class="but_y_01" type="button" id="back"  value="返回" onclick="returnPage();"/>
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 1020px;">
			<%--shang--%>
			<div class="content_02_box" style="width:100%;">
				<div class="content_02_box_title_bg" style="width: 998px;">
					<span>申购计划审批表</span>
				</div>
				<div class="content_02_box_div" style="width: 998px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
						<input type="hidden" id="T_IDS" name ="T_IDS"  value=""/>
						<input type="hidden" id="T_OSEXA_ORG_ID" name="T_OSEXA_ORG_ID" value="<%= org_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>填写部室：</th>
							<td class="content_02_box_div_table_td">
								<input
										type="text" id="T_OSEXA_ORG_NAME" name="T_OSEXA_ORG_NAME" 
										class="input_cx_title_240" readonly="readonly" value="<%=orgName%>" style="width:180px;"/>
							</td>
							<input type="hidden" id="T_OSEXA_USER_ID" name="T_OSEXA_USER_ID" value="<%= user_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>审批人：</th>
							<td class="content_02_box_div_table_td">
								<td class="content_02_box_div_table_td">
								<input
										type="text" id="T_OSEXA_USER_NAME" name="T_OSEXA_USER_NAME"
										class='input_cx_title_240' readonly='readonly' value="<%=user_name%>" style="width:180px;"/>
							</td>
						</tr>
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请标题：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="T_OSEXA_TITLE" name="T_OSEXA_TITLE"
										class="input_cx_title_240 validate[required,maxSize[200]]" style="width:705px;" />
							</td>
						</tr>
						
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填表时间：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" class="date_120 validate[required]" id="T_OSEXA_DATE" name="T_OSEXA_DATE"
								   onclick="WdatePicker()"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 相关计划表 -->
			<div class="content_02_box" style="width: 998px;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span>相关计划表</span>
			<div class="content_02_box_add">
			<a onclick="open_OsAppList();" id="addButton"><img src="<%=path %>/ccapp/xtbg/resources/images/add.gif"/>添加计划表</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 998px;">
			<table id="osappTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 申请标题</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">申请人</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">申请部门</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 申请日期</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
						</tr>
							<tr  id ="osapprowhidden" name="osapprowhidden">
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="osapp_id" name="osapp_id" class="input_title_text" value="" />
						           <input type="text" id="osapp_name" name="osapp_name" style="text-align: center;width: 150px;height: 20px;"disabled="disabled"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<input type="text" id="osapp_user_name" name="osapp_user_name" style="text-align: center;width: 150px;height: 20px;"disabled="disabled"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<input type="text" id="osapp_org_name" name="osapp_org_name" style="text-align: center;width: 150px;height: 20px;"disabled="disabled"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<input type="text" id="osapp_date" name="osapp_date" style="text-align: center;width: 150px;height: 20px;"disabled="disabled"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
															<a onClick="deleteDay(this,'')" name="delbtn"> <img src="<%=path %>/ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
				</table>
				</div>
			</div>
			<!-- 相关计划表 -->
			
			<!-- 形成申购审批物品清单 DIV-->
			<div class="content_02_box" style="width: 998px;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span>申购审批物品清单</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="<%=path %>/ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 998px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
					 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">序号</td>
					 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 120px">申购部门</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span> 名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span>规格型号</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">库存</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span> 数量</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">单价</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"> 备注</td>
						</tr>
						<%  if(listItems.size()>0){ %>
						 	<tr  id ="dayrowhidden" name="dayrowhidden">
							    <td class="content_02_box_div_table_td">
										<input type="text" id="sequencId" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
							    <td class="content_02_box_div_table_td">
							            <input type="hidden" id="T_OSEXA_OB_ORG_IDS" name="T_OSEXA_OB_ORG_IDS" class="input_title_text" value="" /> 
										<input type="text" id="T_OSEXA_OB_ORG_NAMES" name="T_OSEXA_OB_ORG_NAMES" class="input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="T_OS_OB_ID" name="T_OS_OB_ID" class="input_title_text" value="" />
							        <input type="hidden" id="T_OSEXA_OB_ID" name="T_OSEXA_OB_ID" class="input_title_text" value="" />
							        <select id="OFUSTYPE_SELECT" name="OFUSTYPE_SELECT" onchange="loadItNameSelect(this);" class="validate[required]" style="width: 165px;">
							        <option value="">--请选择--</option>
							        <%if(allOsupplieUseList.size()>0){ 
							              for(int i = 0; i<allOsupplieUseList.size(); i++){
							            	  Map<String,String> allOsupplieUseMap = allOsupplieUseList.get(i);
							        %>
							            <option value="<%=allOsupplieUseMap.get("OFUSTYPE_ID")+";"+allOsupplieUseMap.get("OFUSTYPE_NAME")%>"><%=allOsupplieUseMap.get("OFUSTYPE_NAME") %></option>
							        <%    }
						              } %>
						              <option value="qita;qita">其它</option>
						           </select>
						           <input type="text" id="OFUSTYPE_NAME" name="OFUSTYPE_NAME" style="text-align: center;width: 150px;height: 20px;" readonly="readonly" onchange="inOfusTypeValue(this);"/>
						           
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required]"/>
						           <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value="OFUSTYPE_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<select id="IT_NAME_SELECT" name="IT_NAME_SELECT" style="width: 165px;" onchange="inItNameForSelect(this);">
									
									</select>
									<input type="text" id="IT_NAME" name="IT_NAME" readonly="readonly" style="text-align: center;width: 150px;height: 20px;" onchange="inItNameForText(this);"/>
									
									 <input type="hidden" id="IT_NAME_VALUE" name="IT_NAME_VALUE" class="validate[required]"/>
						             <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value="IT_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_KC" name="T_OS_OB_KC" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" disabled="disabled" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_NO" name="T_OSEXA_OB_NO" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_DJ" name="T_OSEXA_OB_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_BZ" name="T_OSEXA_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
								</td>
							</tr>
						 <%
							for(int i=0;i<listItems.size();i++){
								HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i);
						 %>	
						 <tr  id ="dayrow" name="dayrow">
						 		<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">
						 			<input type="text" id="sequencId<%=i+1 %>" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" value="<%=i+1%>" />
						 		</td>
							    <td class="content_02_box_div_table_td">
							            <input type="hidden" id="T_OSEXA_OB_ORG_IDS<%=i+1 %>" name="T_OSEXA_OB_ORG_IDS" class="input_title_text" value="<%=itemMap.get("t_osexa_ob_org_ids") %>" /> 
										<input type="text" id="T_OSEXA_OB_ORG_NAMES<%=i+1 %>" name="T_OSEXA_OB_ORG_NAMES" class="input_title_text" style="text-align: center;" onclick="showosOrglist('<%=itemMap.get("t_os_ob_ids")%>')" value="<%=itemMap.get("t_osexa_ob_org_names") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="T_OS_OB_ID<%=i+1 %>" name="T_OS_OB_ID" class="input_title_text" value="<%=itemMap.get("t_os_ob_ids") %>" />
							        <input type="hidden" id="T_OSEXA_OB_ID<%=i+1 %>" name="T_OSEXA_OB_ID" class="input_title_text" value="" />
							        <select id="OFUSTYPE_SELECT<%=i+1 %>" name="OFUSTYPE_SELECT" onchange="loadItNameSelect(this);" class="validate[required]" style="width: 165px;">
							        <option value="">--请选择--</option>
							        <%if(allOsupplieUseList.size()>0){ 
							              for(int j = 0; j<allOsupplieUseList.size(); j++){
							            	  Map<String,String> allOsupplieUseMap = allOsupplieUseList.get(j);
							        %>
							            <option value="<%=allOsupplieUseMap.get("OFUSTYPE_ID")+";"+allOsupplieUseMap.get("OFUSTYPE_NAME")%>"><%=allOsupplieUseMap.get("OFUSTYPE_NAME") %></option>
							        <%    }
						              } %>
						              <option value="qita;qita">其它</option>
						           </select>
						           <input type="text" id="OFUSTYPE_NAME<%=i+1 %>" name="OFUSTYPE_NAME" style="text-align: center;width: 150px;height: 20px;" readonly="readonly" onchange="inOfusTypeValue(this);"/>
						           
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE<%=i+1 %>" value="<%=itemMap.get("ofustype_name") %>" name="OFUSTYPE_NAME_VALUE" class="validate[required]"/>
						           <input type="hidden" id="OFUSTYPE_ID_VALUE<%=i+1 %>" name="OFUSTYPE_ID_VALUE" value="OFUSTYPE_ID_VALUE;<%=itemMap.get("ofustype_id") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<select id="IT_NAME_SELECT<%=i+1 %>" name="IT_NAME_SELECT" style="width: 165px;" onchange="inItNameForSelect(this);">
									
									</select>
									<input type="text" id="IT_NAME<%=i+1 %>" name="IT_NAME" readonly="readonly" style="text-align: center;width: 150px;height: 20px;" onchange="inItNameForText(this);"/>
									
									 <input type="hidden" id="IT_NAME_VALUE<%=i+1 %>" name="IT_NAME_VALUE" value="<%=itemMap.get("it_name") %>" class="validate[required]"/>
						             <input type="hidden" id="IT_ID_VALUE<%=i+1 %>" name="IT_ID_VALUE" value="IT_ID_VALUE;<%=itemMap.get("it_id") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_KC<%=i+1 %>" name="T_OS_OB_KC" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" disabled="disabled"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_NO<%=i+1 %>" name="T_OSEXA_OB_NO" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_osexa_ob_no") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_DJ<%=i+1 %>" name="T_OSEXA_OB_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_osexa_ob_dj") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_BZ<%=i+1 %>" name="T_OSEXA_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_osexa_ob_bz") %>" />
								</td>
							</tr>
						 <%   } %>
							
	 					<%}else{%>
							<tr  id ="dayrowhidden" name="dayrowhidden">
							    <td class="content_02_box_div_table_td">
										<input type="text" id="sequencId" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
							    <td class="content_02_box_div_table_td">
							            <input type="hidden" id="T_OSEXA_OB_ORG_IDS" name="T_OSEXA_OB_ORG_IDS" class="input_title_text" value="" /> 
										<input type="text" id="T_OSEXA_OB_ORG_NAMES" name="T_OSEXA_OB_ORG_NAMES" class="input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="T_OS_OB_ID" name="T_OS_OB_ID" class="input_title_text" value="" />
							        <input type="hidden" id="T_OSEXA_OB_ID" name="T_OSEXA_OB_ID" class="input_title_text" value="" />
							        <select id="OFUSTYPE_SELECT" name="OFUSTYPE_SELECT" onchange="loadItNameSelect(this);" class="validate[required]" style="width: 165px;">
							        <option value="">--请选择--</option>
							        <%if(allOsupplieUseList.size()>0){ 
							              for(int i = 0; i<allOsupplieUseList.size(); i++){
							            	  Map<String,String> allOsupplieUseMap = allOsupplieUseList.get(i);
							        %>
							            <option value="<%=allOsupplieUseMap.get("OFUSTYPE_ID")+";"+allOsupplieUseMap.get("OFUSTYPE_NAME")%>"><%=allOsupplieUseMap.get("OFUSTYPE_NAME") %></option>
							        <%    }
						              } %>
						              <option value="qita;qita">其它</option>
						           </select>
						           <input type="text" id="OFUSTYPE_NAME" name="OFUSTYPE_NAME" style="text-align: center;width: 150px;height: 20px;" readonly="readonly" onchange="inOfusTypeValue(this);"/>
						           
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required]"/>
						           <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value="OFUSTYPE_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<select id="IT_NAME_SELECT" name="IT_NAME_SELECT" style="width: 165px;" onchange="inItNameForSelect(this);">
									
									</select>
									<input type="text" id="IT_NAME" name="IT_NAME" readonly="readonly" style="text-align: center;width: 150px;height: 20px;" onchange="inItNameForText(this);"/>
									
									 <input type="hidden" id="IT_NAME_VALUE" name="IT_NAME_VALUE" class="validate[required]"/>
						             <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value="IT_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_KC" name="T_OS_OB_KC" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" disabled="disabled" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_NO" name="T_OSEXA_OB_NO" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_DJ" name="T_OSEXA_OB_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OSEXA_OB_BZ" name="T_OSEXA_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
								</td>
							</tr>
						<%} %>
				</table>
				</div>
			</div>
			<!-- 形成申购审批物品清单DIV -->
			</div>
			</div>
			<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>	
	
</form>
<IFRAME name="filetypeinfodoJSPhiddenFrame" width=100% height=0> </IFRAME> 
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview_conferceBase() {
		jQuery("#print_table").show();
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,800,980,document.getElementById("print_conferenceBase").innerHTML);
	};	                     
	
	
	//点击完成
	var afterActionSuccessFn=function(){
		//易耗品入库 进入
		<%if("windowIdList".equals(windowsId)){%>
			getParentWindow('<%=windowsId%>').parent.location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		<%}else{%>
		//事务处理
			getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		<%}%>
		removeAlertWindows('<%=windowsId%>',true);
		
	};
	//返回按钮
	function returnPage() {
		//window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		//removeAlertWindows('<%=windowsId%>',true);
		
		var parentObject = getParentWindow('<%=windowsId%>');
		parentObject.location.reload();
		removeAlertWindows('<%=windowsId%>',true,true,'',false,'','');
	}
	
	//入库
	function Ok(){
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		var flagValue = true;
		if (isFlag && flagValue){
			jQuery("#action").val("addOsMore");
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
		}
	}

	
	function checkDataBeforeRunFlow(){
		var dayrowArr = jQuery("select[name=OFUSTYPE_SELECT]");
		var flagValue = true;
		for(var i = 1;i<dayrowArr.size();i++){
			//var idValue = dayrowArr[i];//$("select[@name=items] option[@selected]").text();
			var index = dayrowArr[i].selectedIndex; // 选中索引
			var idValue = dayrowArr[i].options[index].text; // 选中文本
			if(idValue == "其它"){
				alert("第"+i+"行不能为特殊物品!");
				flagValue = false;
				return false;
			}
		}
		if(flagValue){
			var flag = false;
			jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
			flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
			if(!flag){
				resetSubmit();
			}
			return flag;
		}
	}

	afterSubmitFn=function(result){
		try{
			if(result.indexOf("delete")!=-1){
				alert(result.split(",")[1]);
			}else{
				if(result.split(",").length>1){
						result = result.split(",");
						alert(result[0]);
						returnPage();
				} else {
					alert(result);
					returnPage();
				}
			}
		}catch(e){alert(e.description);}
	};
</script>
</body>
</html>


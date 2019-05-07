<%--
描述：申购计划界面
作者：邱炼
版本：1.0
日期：2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsapPlanItemServiceImpl"%>
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
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
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
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();

	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//正文ID
	String document_id = UUID.randomUUID().toString();
	
	//物品列表业务实现类
	OsAppObjectService osapplanitemserviceimpl = new OsAppObjectServiceImpl();
	List<Map<String,String>> listItems = osapplanitemserviceimpl.selectOsAppObject(busi_id);
	
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
<title>计划</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type="text/javascript" src="ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" href="ccapp/xtbg/resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">

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
	
	jQuery(lastTr).find("input[name=T_OS_OB_ID]").attr("id","T_OS_OB_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OS_OB_NO]").attr("id","T_OS_OB_NO"+newlastSelectId);
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
}

function inItNameForText(IT_NAME){
	var IT_NAME_ID =  IT_NAME.id;
	var IT_NAME_ARR = IT_NAME_ID.split("IT_NAME");
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+IT_NAME_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+IT_NAME_ARR[1];
	
	jQuery(IT_NAME_VALUE_ID).val(IT_NAME.value);
	jQuery(IT_ID_VALUE_ID).val("IT_ID_VALUE;");
}

//异步填充规格下拉列表
function loadItNameSelect(OFUSTYPE_SELECT){
	var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/getbackitnameajax.jsp";
	var params = {ofustypeValue:OFUSTYPE_SELECT.value};
	var ofusvalue = OFUSTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");                            //分割下拉框的值
	var OFUSTYPE_SELECT_ID =  OFUSTYPE_SELECT.id;
	var OFUSTYPE_SELECT_ID_ARR = OFUSTYPE_SELECT_ID.split("OFUSTYPE_SELECT");   //获取当前列的id后缀
	var NEW_OFUSTYPE_SELECT_ID = "#IT_NAME_SELECT"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_NAME_VALUE_ID = "#OFUSTYPE_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var OFUSTYPE_ID_VALUE_ID = "#OFUSTYPE_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_VALUE_ID = "#IT_NAME_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	var IT_ID_VALUE_ID = "#IT_ID_VALUE"+OFUSTYPE_SELECT_ID_ARR[1];
	
	var IT_NAME_SELECT = jQuery(NEW_OFUSTYPE_SELECT_ID);
	if(ofusvalue != "" && ofustypevalueArr[1] == "qita"){
		jQuery("#OFUSTYPE_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).show();
		jQuery("#IT_NAME"+OFUSTYPE_SELECT_ID_ARR[1]).show();
		IT_NAME_SELECT.hide();
		
	}else if(ofusvalue == ""){
		IT_NAME_SELECT.empty();
	}else{
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

jQuery(function(){
	<% 
	 if(listItems.size()>0){
		for(int i=0;i<listItems.size();i++){
			HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i);
			if(StringUtil.isBlank(itemMap.get("ofustype_id"))){
  %>	
				jQuery("#OFUSTYPE_SELECT<%=i+1%>").val("qita;qita");
				jQuery("#OFUSTYPE_SELECT<%=i+1%>").change();
				jQuery("#OFUSTYPE_NAME<%=i+1%>").val("<%=itemMap.get("ofustype_name") %>");
				jQuery("#OFUSTYPE_NAME<%=i+1%>").change();
				jQuery("#IT_NAME<%=i+1%>").val("<%=itemMap.get("it_name") %>");
				jQuery("#IT_NAME<%=i+1%>").change();
  <%		}else{    %>
			    jQuery("#OFUSTYPE_SELECT<%=i+1%>").val("<%=itemMap.get("ofustype_id")+";"+itemMap.get("ofustype_name") %>");
			    jQuery("#OFUSTYPE_SELECT<%=i+1%>").change();
				jQuery("#IT_NAME_SELECT<%=i+1%>").val("<%=itemMap.get("it_id")+";"+itemMap.get("it_name")%>");
				jQuery("#IT_NAME_SELECT<%=i+1%>").change();
  <%       }
  		}
  	}else{%>
	  	jQuery("#OFUSTYPE_NAME1").hide();
		jQuery("#IT_NAME1").hide();
  	
  	<%}%>
  	
  	jQuery("[name=dayrowhidden]").hide();
});

</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input type="hidden" id="org_id" name="org_id"  value="<%=org_id%>"/>
	<input type="hidden" id="orgName" name="orgName"  value="<%=orgName%>"/>
	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsAppServiceImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>

<div id="tabs1" style="width:100%;overflow-x: hidden;overflow: scroll;height: 530px;">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 920px;">
			<%--shang--%>
			<div class="content_02_box" style="width:100%;">
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>计划表</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr>
						<oa:input type="hidden" column="UNIT_ID" table="TA_OA_OSAPPLAN" value="<%= unit_id%>"/>
						<oa:input type="hidden" column="UNIT_NAME" table="TA_OA_OSAPPLAN" value="<%= unit_name%>"/>
						<oa:input type="hidden" column="T_ORG_ID" table="TA_OA_OSAPPLAN" value="<%= org_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>部室：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_ORG_NAME" table="TA_OA_OSAPPLAN"
										other="class='input_cx_title_240' readonly='readonly'" value="<%=orgName%>"  />
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填表时间：</th>
							<td class="content_02_box_div_table_td">
								<oa:date dateFmt='yyyy-MM-dd' other="class='Wdate validate[required]'" style='height:22px;line-height: 22px;float:left;margin-top:3px;'
								   column="T_CREATOR_TIME" table="TA_OA_OSAPPLAN"/>
							</td>
						</tr>
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_TITLE" table="TA_OA_OSAPPLAN"
										other="class='input_cx_title_240'" style="width:705px;" />
							</td>
						</tr>
						<tr>
						<%--row3--%>
						<oa:input type="hidden" column="T_USER_ID" table="TA_OA_OSAPPLAN" value="<%= user_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请人：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_USER_NAME" table="TA_OA_OSAPPLAN"
										other="class='input_cx_title_240' readonly='readonly' " style="width:705px;" value="<%= user_name%>"/>
							</td>
						</tr>
						
					</table>
				</div>
			</div>
			
			<!-- 形成物品清单 DIV-->
			<div class="content_02_box" style="width: 900px;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span>物品清单</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 900px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>规格型号</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 数量</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 备注</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
						</tr>
						<% 
									 if(listItems.size()>0){
										for(int i=0;i<listItems.size();i++){
											HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i); 
						 %>	
							 <tr  id ="dayrow" name="dayrow">
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="T_OS_OB_ID<%=i+1 %>" name="T_OS_OB_ID" class="input_title_text" value="<%=itemMap.get("t_os_ob_id") %>" />
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
						           <input type="text" id="OFUSTYPE_NAME<%=i+1 %>" name="OFUSTYPE_NAME" style="text-align: center;width: 150px;height: 20px;" class="validate[required]" onchange="inOfusTypeValue(this);"/>
						           
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE<%=i+1 %>" name="OFUSTYPE_NAME_VALUE"  value="<%=itemMap.get("ofustype_name") %>"/>
						           <input type="hidden" id="OFUSTYPE_ID_VALUE<%=i+1 %>" name="OFUSTYPE_ID_VALUE" value="OFUSTYPE_ID_VALUE;<%=itemMap.get("ofustype_id") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<select id="IT_NAME_SELECT<%=i+1 %>" name="IT_NAME_SELECT" style="width: 165px;" onchange="inItNameForSelect(this);">
									
									</select>
									<input type="text" id="IT_NAME<%=i+1 %>" name="IT_NAME" style="text-align: center;width: 150px;height: 20px;" class="validate[required]" onchange="inItNameForText(this);"/>
									
									 <input type="hidden" id="IT_NAME_VALUE<%=i+1 %>" name="IT_NAME_VALUE" value="<%=itemMap.get("it_name") %>"/>
						             <input type="hidden" id="IT_ID_VALUE<%=i+1 %>" name="IT_ID_VALUE" value="IT_ID_VALUE;<%=itemMap.get("it_id") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_NO<%=i+1 %>" name="T_OS_OB_NO" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value="<%=itemMap.get("t_os_ob_no") %>"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_BZ<%=i+1 %>" name="T_OS_OB_BZ" value="<%=itemMap.get("t_os_ob_bz") %>" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
															<a onClick="deleteDay(this,'')"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
							<%
									}
								} 
							%>
							<tr  id ="dayrowhidden" name="dayrowhidden">
								<td class="content_02_box_div_table_td"> 
							        <input type="hidden" id="T_OS_OB_ID" name="T_OS_OB_ID" class="input_title_text" value="" />
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
						           <input type="text" id="OFUSTYPE_NAME" name="OFUSTYPE_NAME" style="text-align: center;width: 155px;height: 20px;" class="validate[required]" onchange="inOfusTypeValue(this);"/>
						           
						            <input type="hidden" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" />
						           <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value="OFUSTYPE_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<select id="IT_NAME_SELECT" name="IT_NAME_SELECT" style="width: 165px;" onchange="inItNameForSelect(this);">
									
									</select>
									<input type="text" id="IT_NAME" name="IT_NAME" style="text-align: center;width: 150px;height: 20px;" class="validate[required]" onchange="inItNameForText(this);"/>
									
									 <input type="hidden" id="IT_NAME_VALUE" name="IT_NAME_VALUE" />
						             <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value="IT_ID_VALUE;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_NO" name="T_OS_OB_NO" class="validate[required,maxSize[20],custom[onlyNumberSD]] input_title_text" style="text-align: center;" value="0"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_OS_OB_BZ" name="T_OS_OB_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
															<a onClick="deleteDay(this,'')"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
							
				</table>
				</div>
			</div>
			<!-- 形成物品清单DIV -->
			
			
			<!--审核意见DIV-->
			<div class="content_02_box" style="width: 900px;"  >
			 <div class="content_02_box_title_bg" style="width: 900px;">
					<span>审批意见</span>
				</div>
			 	  <table width="100%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">部门负责人意见：</span>
							 <oa:view column="T_BMFZYJ" table="TA_OA_OSAPPLAN" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
				 </table>
			<!--审核意见DIV END-->
			</div>
			</div>
			</div>
			<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>	
	
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
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
	
	function checkDataBeforeRunFlow(){
		var dayrowArr = jQuery("select[name=OFUSTYPE_SELECT]");
		var flagValue = true;
		if(dayrowArr.size()>1){
			
		}else{
			alert("物品清单不能为空!");
			flagValue = false;
			return false;
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
	
	//点击完成
	var afterActionSuccessFn=function(){
		getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		removeAlertWindows('<%=windowsId%>',true);
		
	};
	//返回按钮
	function returnPage() {
		window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		removeAlertWindows('<%=windowsId%>',true);
		
	}
	/**
	 * 打印
	 */
	function exportFile(){
		//主键
		var busi_id = jQuery("#busi_id").val();
		//var
		if (IsSpace(busi_id)) {
		    alert("流程还没启动,没有申购数据！");
		} 
		else{
			var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
		    var html = new Array();
		    html.push("<div id='export_excel'>");
		    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
		    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
		    html.push("<input type='hidden' name='busi_id' value='"+busi_id+"' /> ");
		    html.push("<input type='hidden' name='excelname' value='申购计划信息' /> ");//导出的主题
		    html.push("<input type='hidden' name='excelImplClass' value='osapplandaoexcelimpl' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
		    html.push("<input type='hidden' name='excelTemplateFilePath' value='bgypsgjh_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
		    html.push('</form>');
		    html.push("</div>");
		    //加载到body，提交后再删除
		    jQuery(html.join("")).appendTo("body");
		    jQuery("#downFrom").submit();
		    jQuery("#export_excel").remove();
		}
	}
	/*
 	函数:  changeSelect
 	说明:  选择下一步 隐藏
 	参数:   无
 	返回值: 无
 	*/
 	function changeSelect(action_defid,selectAct){
 		//-------办公用品计划表  -------
 		//1.部室审批环节去掉 计划申请下拉框
 		if(!IsSpace(action_defid)&&action_defid=="sgjh_wp1_act2"){
 			selectAct.find("option[value=sgjh_wp1_act4]").attr("selected","selected").change();
 			selectAct.find("option[value=sgjh_wp1_act1]").remove();
 		} 
		//2.办公室初审环节去掉 部室审批下拉框
 		else if(!IsSpace(action_defid)&&action_defid=="sgjh_wp1_act4"){
 			selectAct.find("option[value=sgjh_wp1_act3]").attr("selected","selected").change();
 			selectAct.find("option[value=sgjh_wp1_act2]").remove();
 		} 
 	}
</script>
</body>
</oa:init>
</html>


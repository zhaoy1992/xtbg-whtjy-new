<%--
描述：固定资产申领登记
作者：童佳
版本：1.0
日期：2014-03-12
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
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
	
	String appIds  = "";
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	appIds = osHavaObjectService.queryHavaIdsForRegId(busi_id);
	
	List<Map<String,String>> osNoMoveObjectList = new ArrayList<Map<String,String>>();
	osNoMoveObjectList = osHavaObjectService.queryNoMoveObjectForRegId(busi_id);
	
	
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="gzjb_wp1_act1";
	}
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));

%>
<!-- 公共部分开始 -->
<title>申购计划</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type="text/javascript" src="ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" href="ccapp/xtbg/resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script src="ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">
	//环节ID
	var action_defid ="<%=action_defid%>";
	//添加物品
	function Add_Row4NewDay1(){
		var lastTrObject = jQuery("[name=dayrow]").last();
		var lastTr = jQuery("[name=dayrowhidden]").last().clone();
		
		jQuery(lastTr).find("input[type=text]").val("");
		
		jQuery(lastTr).find("input[type=hidden]").val("");
		
		lastTr.find("input[type=text]").val("");
		
		
		var lastSelectId = lastTrObject.find("input[name=T_NOMOVE_OB_ID]").attr("id");
		var newlastSelectId;
		if(lastSelectId){
			var lastSelectIdArr = lastSelectId.split("T_NOMOVE_OB_ID");
			newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
		}else{
			newlastSelectId = 1;
		}
		
		jQuery(lastTr).find("input[name=IT_NAME_VALUE]").attr("id","IT_NAME_VALUE"+newlastSelectId);
		jQuery(lastTr).find("input[name=OFUSTYPE_NAME_VALUE]").attr("id","OFUSTYPE_NAME_VALUE"+newlastSelectId);
		
		jQuery(lastTr).find("input[name=OFTYPE_ID]").attr("id","OFTYPE_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=OFTYPE_NAME]").attr("id","OFTYPE_NAME"+newlastSelectId);
		jQuery(lastTr).find("input[name=T_HA_ID]").attr("id","T_HA_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=T_HA_SBNO]").attr("id","T_HA_SBNO"+newlastSelectId);
		//老设备编号
		jQuery(lastTr).find("input[name=T_HA_oldSBNO]").attr("id","T_HA_oldSBNO"+newlastSelectId);
		
		jQuery(lastTr).find("input[name=T_NOMOVE_OB_ID]").attr("id","T_NOMOVE_OB_ID"+newlastSelectId);
		jQuery(lastTr).find("input[name=T_NOMOVE_OB_BZ]").attr("id","T_NOMOVE_OB_BZ"+newlastSelectId);//备注
		
		//序号
		jQuery(lastTr).find("input[name=sequencId]").attr("id","sequencId"+newlastSelectId);
		
		lastTr.attr("id","dayrow");
		lastTr.attr("name","dayrow");
		
		lastTr.attr("style","");
		
		var dayTable = jQuery("#dayTable");
		
		lastTr.appendTo(dayTable);
		
		//序号 赋值
		jQuery("#sequencId"+newlastSelectId).val(newlastSelectId);
		
		jQuery(lastTr).find(".date_187").each(function(i,e){
			setDataTimeClickShowOrHide($(this).attr("id"),window);
		});
	}

	function add_nomoveObject(){
		var path ="<%=path%>/ccapp/xtbg/tjy/officesupplies/jsp/choseosnomoveobjectlist.jsp?windowsId=windowIds";
		openAlertWindows('windowIds',path,'固定资产列表',810,400,'25%','25%');
	}
	
	function loadInfo(OsAppIds){
		loadOsAppItemObject(OsAppIds,'<%=busi_id%>');
	}


	//同步获取计划审批表物品信息并填充表格信息
	function loadOsAppItemObject(OsAppIds,_bus_id){
		var osapprowtr = jQuery("[name=dayrow]");
		for (var j = 0; j<osapprowtr.length; j++){
			var m = j+1;
			if(jQuery(osapprowtr[j]).find("input[name=T_HA_ID]").val()){
				OsAppIds = OsAppIds+","+jQuery(osapprowtr[j]).find("input[name=T_HA_ID]").val();
			}
		}
		var url = "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/getbackosnomoveobjectajax.jsp";
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
					jQuery("#OFTYPE_ID"+objectidno).val(data[i].oftype_id);
					jQuery("#OFTYPE_NAME"+objectidno).val(data[i].oftype_name);
					jQuery("#IT_NAME_VALUE"+objectidno).val(data[i].it_name);
					jQuery("#OFUSTYPE_NAME_VALUE"+objectidno).val(data[i].ofustype_name);
					jQuery("#T_NOMOVE_OB_BZ"+objectidno).val(data[i].t_ha_bz);
					jQuery("#T_HA_ID"+objectidno).val(data[i].t_ha_id);
					//物品发放环节设置设备编号为 必填
					if(action_defid=="gdzcly_wp1_act6"){
						jQuery("#T_HA_SBNO"+objectidno).addClass("validate[required]");
						jQuery("#T_HA_SBNO"+objectidno).removeAttr("readonly");
					}
					jQuery("#T_HA_SBNO"+objectidno).val(data[i].t_ha_sbno);
					//老设备编号
					jQuery("#T_HA_oldSBNO"+objectidno).val(data[i].t_ha_sbno);
					
					jQuery("#TA_OA_OSNOMOVE__T_HAVA_IDS").val(OsAppIds);
				}
				jQuery("[name=dayrow]").show();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR);
				alert(textStatus);
				alert(errorThrown);
			}
		});
		//焦点设置
		jQuery("#TA_OA_OSNOMOVE__T_OSNOM_TITLE").focus();
	}
	
	//删除物品
	function deleteDay(tag,goodsId){
		var intable=jQuery(tag).parents("table");
		var tr=jQuery(tag).parents("tr").first();
		var t_ha_id = jQuery(tr).find("input[name=T_HA_ID]").val();
		var t_hava_ids = jQuery("#TA_OA_OSNOMOVE__T_HAVA_IDS").val();
		var firstindex = t_hava_ids.indexOf(t_ha_id);
		var charsplit = t_hava_ids.substr(firstindex-1,1);
		if(charsplit==","){
			t_hava_ids = t_hava_ids.replace(","+t_ha_id,"");
		} else {
			t_hava_ids = t_hava_ids.replace(t_ha_id,"");
		}
		//重新赋值
		jQuery("#TA_OA_OSNOMOVE__T_HAVA_IDS").val(t_hava_ids)
		var trsize= jQuery(intable).find("tr[name=dayrow]").size();
		if(trsize==1){
			jQuery(tr).remove();
		}else{
			jQuery(tr).remove();
		}
		var newTrsize= jQuery(intable).find("tr[name=dayrow]").size();
		for(var i=0;i<newTrsize;i++){
			jQuery(intable).find("tr[name=dayrow]").eq(i).find("input[name=sequencId]").val(i+1);
		}
	}
	
	jQuery(function(){
		<%if(!StringUtil.isBlank(appIds)) {%>
		    loadOsAppItemObject('<%=appIds%>','<%=busi_id%>');
		    jQuery("#TA_OA_OSNOMOVE__T_HAVA_IDS").val('<%=appIds%>');
		<%}
		  if(osNoMoveObjectList.size()>0){
			  for(int i = 0;i<osNoMoveObjectList.size();i++){
				  Map<String,String> osNoMoveObjectMap = osNoMoveObjectList.get(i);
		%>
		          var id = '<%=i+1%>';
		          jQuery("#T_NOMOVE_OB_BZ"+id).val('<%=osNoMoveObjectMap.get("t_nomove_ob_bz")%>');
		<%    }
		  }%>
		
	  	jQuery("[name=dayrowhidden]").hide();
	  	
	  	//物品发放环节显示添加和删除按钮
	  	if(action_defid=="gdzcly_wp1_act6"){
	  		 jQuery("#addButton").show();
			 jQuery("a[name=delbtn]").show();
	  	}
	  	
	  	//【领用设备详情】只有在启动的时候校验必填
	  	if(action_defid=="gzjb_wp1_act1"){
	  		 jQuery("#TA_OA_OSNOMOVE__T_OSNOM_LYSBXQ").addClass("validate[required]");
	  	}
	});

</script>

</head>
<body style="overflow: auto;">
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input type="hidden" id="org_id" name="org_id"  value="<%=org_id%>"/>
	<input type="hidden" id="orgName" name="orgName"  value="<%=orgName%>"/>
	<input type="hidden" id="doTempState" name="doTempState"/>
	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsNoMoveObject" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>

<div id="tabs1" style="width:50%">
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
			<div style="float: left; width: 1015px;">
			<%--shang--%>
			<div class="content_02_box" style="width:100%;">
				<div class="content_02_box_title_bg" style="width: 998px;">
					<span>申领登记表</span>
				</div>
				<div class="content_02_box_div" style="width: 998px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
						<oa:input type="hidden" column="T_HAVA_IDS" table="TA_OA_OSNOMOVE" value=""/>
						<oa:input type="hidden" column="T_OSNOM_ORG_ID" table="TA_OA_OSNOMOVE" value="<%= org_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>填写部室：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_OSNOM_ORG_NAME" table="TA_OA_OSNOMOVE"
										other="class='input_cx_title_240' readonly='readonly'" value="<%=orgName%>"  />
							</td>
							<oa:input type="hidden" column="T_OSNOM_USER_ID" table="TA_OA_OSNOMOVE" value="<%= user_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>领取人：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="T_OSNOM_USER_NAME" table="TA_OA_OSNOMOVE"
										other="class='input_cx_title_240' readonly='readonly' " value="<%=user_name %>"/>
							</td>
						</tr>
						<tr>
						<%--row2--%>
						<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_OSNOM_TITLE" table="TA_OA_OSNOMOVE"
										other="class='input_cx_title_240'" style="width:705px;" />
							</td>
						</tr>
						<tr>
						<%--row3--%>
						  <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填写时间：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:date dateFmt='yyyy-MM-dd' other="class='Wdate validate[required]'" style='height:22px;line-height: 22px;float:left;margin-top:3px;'
								   column="T_OSNOM_DATE" table="TA_OA_OSNOMOVE"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--领用设备详情DIV start-->
			<div class="content_02_box" style="width: 998px;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span><font style="color: red;">*</font>领用设备详情</span>
			</div>
			<div class="content_02_box_div" style="width: 998px;">
				<table class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
						<tr >
							<td class="content_02_box_div_table_td">
									<oa:textarea
									column='T_OSNOM_LYSBXQ' table='TA_OA_OSNOMOVE' title='' 
									style='border: 1;width:97%; height: 80px; overflow: auto;' />
							</td>
						</tr>
				</table>
			</div>
			</div>
			<!--领用设备详情DIV end-->
			<!-- 形成申购物品清单 DIV-->
			<div class="content_02_box" style="width: 998px;">
			<div class="content_02_box_title_bg" style="width: 100%">
			<span>固定资产领用清单</span>
			<div class="content_02_box_add">
			<a onclick="add_nomoveObject()" id="addButton" style="display: none;"><img src="ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 998px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
					 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">序号</td>
					 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">类别</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>型号</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">设备编号</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 备注</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
						</tr>
							<tr  id ="dayrowhidden" name="dayrowhidden">
								<td class="content_02_box_div_table_td">
										<input type="text" id="sequencId" name="sequencId" class="input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
							    <td class="content_02_box_div_table_td">
							    	<input type="hidden" id="T_HA_ID" name="T_HA_ID" class="input_title_text" value="" />
							        <input type="hidden" id="T_NOMOVE_OB_ID" name="T_NOMOVE_OB_ID" class="input_title_text" value="" />
							        
							        <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" class="input_title_text" value="" />
							        <input type="text" id="OFTYPE_NAME" name="OFTYPE_NAME" class="validate[required] input_title_text" style="text-align: center;" readonly="readonly" value="" />
								</td>
								<td class="content_02_box_div_table_td"> 
						            <input type="text" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" readonly="readonly"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									
									 <input type="text" id="IT_NAME_VALUE" name="IT_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" readonly="readonly"/>
								</td>
								<td class="content_02_box_div_table_td"> 
									<input type="text" id="T_HA_SBNO" name="T_HA_SBNO" class="input_title_text" style="text-align: center;" readonly="readonly" />
									<input type="hidden" id="T_HA_oldSBNO" name="T_HA_oldSBNO" class="input_title_text" style="text-align: center;"  />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="T_NOMOVE_OB_BZ" name="T_NOMOVE_OB_BZ" class="validate[maxSize[400]] input_title_text" readonly="readonly" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
											<a onClick="deleteDay(this,'')" name="delbtn" style="display: none;"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
				</table>
				</div>
			</div>
			<!-- 形成申购物品清单DIV -->
			<!--审核意见DIV-->
			<div class="content_02_box" style="width: 998px;"  >
			 <div class="content_02_box_title_bg" style="width: 998px;">
					<span>固定资产审批意见</span>
				</div>
			 	  <table width="100%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">部门负责人意见：</span>
							 <oa:view column="T_OSNOM_BMFZRYJ" table="TA_OA_OSNOMOVE" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
					<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">办公室负责人意见：</span>
							 <oa:view column="T_OSNOM_BGSFZRYJ" table="TA_OA_OSNOMOVE" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
					<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">主管领导意见：</span>
							 <oa:view column="T_OSNOM_ZGLDYJ" table="TA_OA_OSNOMOVE" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
					<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">院长意见：</span>
							 <oa:view column="T_OSNOM_YZYJ" table="TA_OA_OSNOMOVE" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
				 </table>
			</div>
			<!--审核意见DIV END-->
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
	
	function checkDataBeforeRunFlow(){
		var flag = false;
		flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if(flag){
			var dayrowArr = jQuery("input[name=T_HA_SBNO]"); //设备编号
			var oldDayrowArr = jQuery("input[name=T_HA_oldSBNO]"); //老设备编号
			var dayThaIdArr = jQuery("input[name=T_HA_ID]"); //设备ID数组
			var flagValue = true;
			for(var i = 1;i<dayrowArr.size();i++){
				var idValue = jQuery(dayrowArr[i]).val(); // 选中索引
				var oldSbNo = jQuery(oldDayrowArr[i]).val();//老设备编号
				
				//设备发放环节 
				if(action_defid=="gdzcly_wp1_act6"){
					var ha_IdValue = jQuery(dayThaIdArr[i]).val(); // 设备ID
					//判断设备是否被领用了
					if(valiDevState(ha_IdValue) == true){
						alert("第"+i+"行设备已经被领用了！");
						flagValue = false;
						return false;
					}
				}
				
				//设备编号是否变更
				if(idValue!=oldSbNo){
					if(valiDevCode(idValue) == true){
						alert("第"+i+"行设备编号已存在！");
						flagValue = false;
						return false;
					}
				}
			}
			if(flagValue){
				jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
				resetSubmit();
				return true;
			}
		}
	}
	/*
	函数:  valiDevCode
	说明:  验证设备编号是否已经存在
	参数:   无
	返回值: 无
	*/
	function valiDevCode(t_ha_sbno){
		var flag = false;
		//验证设备编号是否已经存在
		var url= "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/checkStockCode.jsp";
		var params =  {t_ha_sbno:t_ha_sbno};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				if(data.result==true){
					flag = true;
				} else {
					flag = false;
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				flag = false;
			}
		})
		return flag;
	}
	
	/*
	函数:  valiDevState
	说明:  验证设备是否已经被领用了
	参数:   无
	返回值: 无
	*/
	function valiDevState(t_ha_id){
		var flag = false;
		//验证设备是否已经领用
		var url= "<%=path %>/ccapp/xtbg/tjy/officesupplies/jsp/checkStockState.jsp";
		var params =  {t_ha_id:t_ha_id};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				if(data.result==true){
					flag = true;
				} else {
					flag = false;
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				flag = false;
			}
		})
		return flag;
	}
	
	/*
	函数:  changeSelect
	说明:  选择下一步 隐藏
	参数:   无
	返回值: 无
	*/
	function changeSelect(action_defid,selectAct){
		if(!IsSpace(action_defid)&&action_defid=="gdzcly_wp1_act2"){//部门负责人审批
			selectAct.find("option[value=gdzcly_wp1_act8]").attr("selected","selected").change();
			selectAct.find("option[value=gdzcly_wp1_act1]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="gdzcly_wp1_act8"){//办公室初审
			selectAct.find("option[value=gdzcly_wp1_act3]").attr("selected","selected").change();
			selectAct.find("option[value=gdzcly_wp1_act2]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="gdzcly_wp1_act3"){//办公室负责人审批
			selectAct.find("option[value=gdzcly_wp1_act4]").attr("selected","selected").change();
			selectAct.find("option[value=gdzcly_wp1_act8]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="gdzcly_wp1_act4"){//办公室分管院长审批
			selectAct.find("option[value=gdzcly_wp1_act6]").attr("selected","selected").change();
			selectAct.find("option[value=gdzcly_wp1_act3]").remove();
			selectAct.find("option[value=gdzcly_wp1_act5]").remove();//院长审核
		}else if(!IsSpace(action_defid)&&action_defid=="gdzcly_wp1_act5"){//院长审批
			selectAct.find("option[value=gdzcly_wp1_act6]").attr("selected","selected").change();
			selectAct.find("option[value=gdzcly_wp1_act4]").remove();
		}
	}
</script>
</body>
</oa:init>
</html>


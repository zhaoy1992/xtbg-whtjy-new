<%--
描述：易耗品入库详情界面
作者：童佳
版本：1.0
日期：2014-03-09
--%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsExaminationObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsExaminationObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsapPlanItemServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
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
	
	//录入时间
	String now_date = DateUtil.getFormatDate(new Date());


%>
<!-- 公共部分开始 -->
<title>易耗品入库</title>
    <!-- 引入jQuery -->
    <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../../../oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!-- 引入jQuery UI -->
	<!-- 引入其它 -->
	<script src="../../../../oa/resources/js/util/public.js" type="text/javascript"></script>
	<script src="../../../../oa/resources/js/common/commoncss.js" type="text/javascript"></script>
	<!-- 引入jQuery_dialog -->
	<script src="../../../../oa/resources/plug/jquery_dialog/jquery_dialog.js"></script>
	<!-- 引入公共JS -->
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
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">

//添加物品
function Add_Row4NewDay1(){
	var lastTrObject = jQuery("[name=dayrow]").last();
	var lastTr = jQuery("[name=dayrowhidden]").last().clone();
	
	jQuery(lastTr).find("input[type=text]").val("");
	
	jQuery(lastTr).find("input[type=hidden]").val("");
	
	lastTr.find("input[type=text]").val("");
	
	
	var lastSelectId = lastTrObject.find("input[name=T_HA_ID]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("T_HA_ID");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}
	
	jQuery(lastTr).find("input[name=IT_NAME_VALUE]").attr("id","IT_NAME_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_ID_VALUE]").attr("id","IT_ID_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=IT_ID_VALUE]").val("");
	jQuery(lastTr).find("input[name=OFUSTYPE_NAME_VALUE]").attr("id","OFUSTYPE_NAME_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_ID_VALUE]").attr("id","OFUSTYPE_ID_VALUE"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFUSTYPE_ID_VALUE]").val("")
	
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ORG_IDS]").attr("id","T_OSEXA_OB_ORG_IDS"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ORG_NAMES]").attr("id","T_OSEXA_OB_ORG_NAMES"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_ID]").attr("id","T_HA_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFTYPE_ID]").attr("id","OFTYPE_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFTYPE_NAME]").attr("id","OFTYPE_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_NO]").attr("id","T_HA_NO"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_DJ]").attr("id","T_HA_DJ"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_BZ]").attr("id","T_HA_BZ"+newlastSelectId);//备注
	
	jQuery(lastTr).find("input[name=T_SP_NO]").attr("id","T_SP_NO"+newlastSelectId);  //审批数量
	jQuery(lastTr).find("input[name=T_OSEXA_OBRK_NO]").attr("id","T_OSEXA_OBRK_NO"+newlastSelectId); //已入库数量
	jQuery(lastTr).find("input[name=T_OSEXA_OB_ID]").attr("id","T_OSEXA_OB_ID"+newlastSelectId);   //审批物品表ID
	jQuery(lastTr).find("input[name=T_OSEXA_ID]").attr("id","T_OSEXA_ID"+newlastSelectId);   //审批表ID
	
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	
	lastTr.attr("style","");
	
	var dayTable = jQuery("#dayTable");
	
	lastTr.appendTo(dayTable);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
}

function open_OsAppList(){
	var path ="<%=path%>/ccapp/xtbg/tjy/detectionsupplies/jsp/osappovernoexalist.jsp?windowsId=windowIds";
	openAlertWindows('windowIds',path,'计划表列表',810,400,'25%','25%');
}


//同步获取计划审批表物品信息并填充表格信息
function loadOsAppItemObject(OsAppIds){
	var url = "<%=path %>/ccapp/xtbg/tjy/detectionsupplies/jsp/getbackosexaobjectajax.jsp";
	var params = {osappitem:OsAppIds};
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
				jQuery("#IT_ID_VALUE"+objectidno).val(data[i].it_id);
				jQuery("#OFUSTYPE_NAME_VALUE"+objectidno).val(data[i].ofustype_name);
				jQuery("#OFUSTYPE_ID_VALUE"+objectidno).val(data[i].ofustype_id);
				jQuery("#T_OSEXA_OB_ORG_IDS"+objectidno).val(data[i].t_osexa_ob_org_ids);
				jQuery("#T_OSEXA_OB_ORG_NAMES"+objectidno).val(data[i].t_osexa_ob_org_names);
				var T_HA_NO;
				var T_OSEXA_OBRK_NO;
				if(data[i].t_osexa_ob_no == ""){
					T_HA_NO = "0";
				}else{
					T_HA_NO = parseFloat(data[i].t_osexa_ob_no);
				}
				if (data[i].t_osexa_obrk_no == ""){
					T_OSEXA_OBRK_NO = "0";
				}else{
					T_OSEXA_OBRK_NO	= parseFloat(data[i].t_osexa_obrk_no);
				} 
				 
				jQuery("#T_SP_NO"+objectidno).val(T_HA_NO);
				jQuery("#T_HA_NO"+objectidno).val(T_HA_NO-T_OSEXA_OBRK_NO);
				jQuery("#T_HA_DJ"+objectidno).val(data[i].t_osexa_ob_dj);
				jQuery("#T_HA_BZ"+objectidno).val(data[i].t_osexa_ob_bz);
				
				jQuery("#T_OSEXA_OBRK_NO"+objectidno).val(T_OSEXA_OBRK_NO);
				jQuery("#T_OSEXA_OB_ID"+objectidno).val(data[i].t_osexa_ob_id);
				jQuery("#T_OSEXA_ID"+objectidno).val(data[i].t_osexa_id);
				
				jQuery("#osExaIds").val(OsAppIds);
			}
			jQuery("[name=dayrow]").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
	
	jQuery("#T_HA_NO1").focus(); //添加焦点
}

function choseOsExa(){
	var path ="<%=path%>/ccapp/xtbg/tjy/detectionsupplies/jsp/osexaovernohavalist.jsp?windowsId=windowIds2";
	openAlertWindows('windowIds2',path,'计划审批表列表',1000,400,'25%','25%');
	
}

//返回
function backParent(){
	var parentObject = getParentWindow('windowIds1');
	parentObject.location.reload();
	removeAlertWindows('windowIds1',true,true,'',false,'','');
}

afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					backParent();
			} else {
				alert(result);
				backParent();
			}
		}
	}catch(e){alert(e.description);}
};


jQuery(function(){
  	jQuery("[name=dayrowhidden]").hide();
});

//入库
function Ok(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	var T_SP_NOArr = jQuery("input[name=T_SP_NO]");
	var T_HA_NOArr = jQuery("input[name=T_HA_NO]");
	var T_OSEXA_OBRK_NOArr = jQuery("input[name=T_OSEXA_OBRK_NO]");
	var flagValue = true;
	for(var i = 1;i<T_SP_NOArr.size();i++){
		var T_SP_NO = parseFloat(T_SP_NOArr[i].value);
		var T_HA_NO = parseFloat(T_HA_NOArr[i].value);
		var T_OSEXA_OBRK_NO = parseFloat(T_OSEXA_OBRK_NOArr[i].value);
		if(T_SP_NO<(T_HA_NO+T_OSEXA_OBRK_NO)){
			   alert("第"+i+"行数量过大!审批数量为："+T_SP_NO);
			   return false;
		}
	}
	
	if (isFlag && flagValue){
		jQuery("#action").val("addOsMore");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}

</script>

</head>
<body style="overflow: auto;">
<form id="form1" name="form1" action="osmoreobjectinfodo.jsp" method="post" >
  <input type="hidden" id="T_HA_BUYDATE" name="T_HA_BUYDATE" class="input_title_text" value="<%=now_date %>" />
  <input type="hidden" id="T_HA_RKUSER_ID" name="T_HA_RKUSER_ID" class="input_title_text" value="<%=user_id %>" />
  <input type="hidden" id="T_HA_RKUSER_NAME" name="T_HA_RKUSER_NAME" class="input_title_text" value="<%=user_name %>" />
  <input type="hidden" id="osExaIds" name="osExaIds" class="input_title_text" value="" />
  <input type="hidden" id="action" name="action" class="input_title_text" value="" />
<div id="tabs1" style="width:70%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
				<input class="but_y_01" type="button" id="sel"  value="入库" onclick="Ok();"/>
				<input class="but_y_01" type="button" id="back"  value="返回" onclick="backParent();"/>
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 1000px;">
			<%--shang--%>
			
			<!-- 形成申购审批物品清单 DIV-->
			<div class="content_02_box" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>申购审批物品清单</span>   <div style="float: right;"><input class="but_y_01" type="button" id="osexa"  value="选择审批表" onclick="choseOsExa()"/> </div>
			<div class="content_02_box_add">
			</div>
			</div>
			<div class="content_02_box_div" style="width: 990px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="99%" cellspacing="0" cellpadding="0" border="0">
			 	<tr>
			 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 120px">申购部门</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span> 名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span>规格型号</span></td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"><span style="color: red">*</span> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">已入库数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">单价</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 120px"> 备注</td>
				</tr>
				<tr  id ="dayrowhidden" name="dayrowhidden">
				    <td class="content_02_box_div_table_td">
				            <input type="hidden" id="T_OSEXA_OB_ORG_IDS" name="T_OSEXA_OB_ORG_IDS" class="input_title_text" value="" /> 
							<input type="text" id="T_OSEXA_OB_ORG_NAMES" name="T_OSEXA_OB_ORG_NAMES" class="input_title_text" style="text-align: center;" />
					</td>
					<td class="content_02_box_div_table_td"> 
					    <input type="hidden" id="T_OSEXA_OB_ID" name="T_OSEXA_OB_ID" class="input_title_text" value="" />
				        <input type="hidden" id="T_HA_ID" name="T_HA_ID" class="input_title_text" value="" />
				        <input type="hidden" id="T_OSEXA_ID" name="T_OSEXA_ID" class="input_title_text" value="" />
				        <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" class="input_title_text" value="" />
				        <input type="hidden" id="OFTYPE_NAME" name="OFTYPE_NAME" class="input_title_text" value="" />
			           
			            <input type="text" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" readonly="readonly"/>
			            <input type="hidden" id="OFUSTYPE_ID_VALUE" name="OFUSTYPE_ID_VALUE" value=""/>
					</td>
					<td class="content_02_box_div_table_td"> 
						
						 <input type="text" id="IT_NAME_VALUE" name="IT_NAME_VALUE" class="validate[required] input_title_text" style="text-align: center;" readonly="readonly"/>
			             <input type="hidden" id="IT_ID_VALUE" name="IT_ID_VALUE" value=""/>
					</td>
					<td class="content_02_box_div_table_td"> 
					        <input type="hidden" id="T_SP_NO" name="T_SP_NO" class="input_title_text" value="" /> 
							<input type="text" id="T_HA_NO" name="T_HA_NO" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_OSEXA_OBRK_NO" name="T_OSEXA_OBRK_NO" readonly="readonly" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_DJ" name="T_HA_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_BZ" name="T_HA_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
					</td>
				</tr>
			</table>
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
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>

</body>
</html>


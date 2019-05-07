<%--
描述：固定资产入库详情界面
作者：童佳
版本：1.0
日期：2014-03-09
--%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsHavaObjectService"%>
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
	
	UserCacheBean userCacheBean = UserCache.getUserCacheBean(user_id);
	String dept_id = userCacheBean.getUnit_id();          //单位ID
	String dept_name = userCacheBean.getUnit_name();      //单位名称
	
	
	//录入时间
	String now_date = DateUtil.getFormatDate(new Date());
	
	//所有固定资产类型
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	List<Map<String, String>> allOsupplieUseList = new ArrayList<Map<String,String>>();
	allOsupplieUseList = osHavaObjectService.queryNoMoveType();


%>
<!-- 公共部分开始 -->
<title>固定资产入库</title>
    <!-- 引入jQuery -->
    <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../../../oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!-- 引入jQuery UI -->
	<!-- 引入其它 -->
	<script src="../../../../oa/resources/util/public.js" type="text/javascript"></script>
	<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
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
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
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
	jQuery(lastTr).find("input[name=OFUSTYPE_NAME_VALUE]").attr("id","OFUSTYPE_NAME_VALUE"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_HA_SBNO]").attr("id","T_HA_SBNO"+newlastSelectId);
	//jQuery(lastTr).find("input[name=T_OSEXA_OB_ORG_NAMES]").attr("id","T_OSEXA_OB_ORG_NAMES"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_ID]").attr("id","T_HA_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFTYPE_ID]").attr("id","OFTYPE_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=OFTYPE_NAME]").attr("id","OFTYPE_NAME"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_GHMAN]").attr("id","T_HA_GHMAN"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_DJ]").attr("id","T_HA_DJ"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_OVERTEL]").attr("id","T_HA_OVERTEL"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_BZ]").attr("id","T_HA_BZ"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_HA_ORG_ID]").attr("id","T_HA_ORG_ID"+newlastSelectId);
	jQuery(lastTr).find("input[name=T_HA_ORG_NAME]").attr("id","T_HA_ORG_NAME"+newlastSelectId);
	
	jQuery(lastTr).find("input[name=T_HA_ORG_ID]").val('<%=dept_id%>');
	jQuery(lastTr).find("input[name=T_HA_ORG_NAME]").val('<%=dept_name%>');
	
	jQuery(lastTr).find("input[name=T_HA_SL]").val('1');//数量默认是 "1"
	
	jQuery(lastTr).find("select[name=OFTYPE_SELECT]").attr("id","OFTYPE_SELECT"+newlastSelectId);
	jQuery(lastTr).find("select[name=OFTYPE_SELECT]").val("");
	
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	
	lastTr.attr("style","");
	
	var dayTable = jQuery("#dayTable");
	
	lastTr.appendTo(dayTable);
	
	jQuery(lastTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	});
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

function inOfTypeForSelect(OFTYPE_SELECT){
	var ofusvalue = OFTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");
	
	var OFTYPE_SELECT_ID =  OFTYPE_SELECT.id;
	var OFTYPE_SELECT_ARR = OFTYPE_SELECT_ID.split("OFTYPE_SELECT");
	
	var OFTYPE_NAME_ID = "#OFTYPE_NAME"+OFTYPE_SELECT_ARR[1];
	var OFTYPE_ID_ID = "#OFTYPE_ID"+OFTYPE_SELECT_ARR[1];
	
	jQuery(OFTYPE_NAME_ID).val(ofustypevalueArr[1]);
	jQuery(OFTYPE_ID_ID).val(ofustypevalueArr[0]);
}


//返回
backParent = function(){
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
}


jQuery(function(){
  	jQuery("[name=dayrowhidden]").hide();
  	//设置焦点
  	jQuery("#T_HA_RKUSER_NAME").focus();
});

//入库
function Ok(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#action").val("addOsNoMove");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}

var chooseDept = function (T_HA_ORG_ID){
	var T_HA_ORG_ID_ID = T_HA_ORG_ID.id.split("T_HA_ORG_NAME")[1];
	var T_HA_ORG_ID_This = "#T_HA_ORG_ID"+T_HA_ORG_ID_ID;
	var T_HA_ORG_NAME_This = "#T_HA_ORG_NAME"+T_HA_ORG_ID_ID;
	var s = new jQuery.z_tree();
	s.treeID = 'mianDept';
	s.treetypestr = 'radio';
	s.isShowSeacher = true;
	s.treeName = "选取部门";
	s.headerName = "选取部门";
	s.type = "AORG";
	s.selectedIds = jQuery(T_HA_ORG_ID_This).val(),
	s.returnFunction = function(orgObj,o) {
		if (!IsSpace(o)) {
			jQuery(T_HA_ORG_ID_This).val(o[0].id);
			jQuery(T_HA_ORG_NAME_This).val(o[0].name);
		} else {
			jQuery(T_HA_ORG_ID_This).val("");
			jQuery(T_HA_ORG_NAME_This).val("");
		}
	}
	s.init();
}

</script>

</head>
<body style="overflow: auto;">
<form id="form1" name="form1" action="osmoreobjectinfodo.jsp" method="post" >
  <input type="hidden" id="action" name="action" class="input_title_text" value="" />
  <div id="tabs1" style="width:70%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
				<input class="but_y_01" type="button" id="sel"  value="入库" onclick="Ok();"/>
				<input class="but_y_01" type="button" id="back"  value="返回" onclick="backParent()"/>
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 1000px;">
			<%--shang--%>
			<div class="content_02_box" style="width:100%;">
				<div class="content_02_box_title_bg" style="width: 970px;">
					<span>办公设备  采购入库单</span>
				</div>
				<div class="content_02_box_div" style="width: 970px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">入库人：</th>
							<td class="content_02_box_div_table_td">
								<input type="hidden" id="T_HA_RKUSER_ID" name="T_HA_RKUSER_ID" class="input_title_text" value="<%=user_id %>" />
						           
						        <input type="text" value="<%=user_name %>" id="T_HA_RKUSER_NAME" name="T_HA_RKUSER_NAME" class="input_title_text" style="text-align: center;" readonly="readonly"/>
							</td>
							<th class="content_02_box_div_table_th">入库日期：</th>
							<td class="content_02_box_div_table_td">
						           
						        <input type="text" value="<%=now_date %>" id="T_HA_BUYDATE" name="T_HA_BUYDATE" class="input_title_text" style="text-align: center;" readonly="readonly"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 形成申购审批物品清单 DIV-->
			<div class="content_02_box" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>物品列表</span>
		    <div class="content_02_box_add">
				<a onclick="Add_Row4NewDay1()" id="addButton"><img src="../../../../xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 990px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="99%" cellspacing="0" cellpadding="0" border="0">
			 	<tr>
			 	    <td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 110px"><span style="color: red">*</span>类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"><span style="color: red">*</span>设备名称</td>
					<!-- <td class="content_02_box_div_table_th" style="text-align: center;width: 110px">设备编号</td> -->
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"><span style="color: red">*</span>型号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"><span style="color: red">*</span>所属部门</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"><span style="color: red">*</span>单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"><span style="color: red">*</span>数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"> 售后电话</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"> 备注</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 110px"> 操作</td>
				</tr>
				<tr  id ="dayrowhidden" name="dayrowhidden">
				    <td class="content_02_box_div_table_td">
				        <select id="OFTYPE_SELECT" name="OFTYPE_SELECT" onchange="inOfTypeForSelect(this);" class="validate[required]">
				        <option value="">--请选择--</option>
				        <%if(allOsupplieUseList.size()>0){ 
				              for(int j = 0; j<allOsupplieUseList.size(); j++){
				            	  Map<String,String> allOsupplieUseMap = allOsupplieUseList.get(j);
				        %>
				            <option value="<%=allOsupplieUseMap.get("oftype_id")+";"+allOsupplieUseMap.get("oftype_name")%>"><%=allOsupplieUseMap.get("oftype_name") %></option>
				        <%    }
			              } %>
			           </select>
				       <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" class="validate[required,maxSize[200]] input_title_text" value="" />
				       <input type="hidden" id="OFTYPE_NAME" name="OFTYPE_NAME" class="validate[required,maxSize[200]] input_title_text" value="" />
					</td>
					<td class="content_02_box_div_table_td"> 
				        <input type="hidden" id="T_HA_ID" name="T_HA_ID" class="input_title_text" value="" />
			           
			            <input type="text" id="OFUSTYPE_NAME_VALUE" name="OFUSTYPE_NAME_VALUE" class="validate[required,maxSize[200]] input_title_text" style="text-align: center;"/>
					</td>
					<!-- <td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_SBNO" name="T_HA_SBNO" class="validate[maxSize[200]] input_title_text" style="text-align: center;" value="0"/>
					</td> -->
					<input type="hidden" id="T_HA_SBNO" name="T_HA_SBNO" class="validate[maxSize[200]] input_title_text" style="text-align: center;" value=""/>
					
					<td class="content_02_box_div_table_td"> 
						
						 <input type="text" id="IT_NAME_VALUE" name="IT_NAME_VALUE" class="validate[required,maxSize[200]] input_title_text" style="text-align: center;"/>
					</td>
					<td class="content_02_box_div_table_td"> 
						  <input type="hidden" id="T_HA_ORG_ID" name="T_HA_ORG_ID" class="input_title_text" value="" />
						 <input type="text" id="T_HA_ORG_NAME" name="T_HA_ORG_NAME" class="validate[required,maxSize[200]] input_title_text" readonly="readonly" style="text-align: center;"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_DJ" name="T_HA_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="0"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_SL" name="T_HA_SL" class="validate[maxSize[20],custom[positiveinteger]] input_title_text" style="text-align: center;" value="0"/>
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="T_HA_GHMAN" name="T_HA_GHMAN" class="validate[maxSize[200]] input_title_text" style="text-align: center;" />
					</td>
					<td class="content_02_box_div_table_td">
							<input type="text" id="T_HA_OVERTEL" name="T_HA_OVERTEL" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" />
					</td>
					<td class="content_02_box_div_table_td">
							<input type="text" id="T_HA_BZ" name="T_HA_BZ" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
					</td>
					<td class="content_02_box_div_table_td">
				            <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
												<a onClick="deleteDay(this,'')"> <img src="../../../../xtbg/resources/images/del.gif" id="del"/>删除</a>
							 </div>
					</td>
				</tr>
				</table>
				</div>
			</div>
			<!-- 形成申购审批物品清单DIV -->
			
			
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


<%--
描述：固定资产详情界面
作者：童佳
版本：1.0
日期：2014-03-13
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
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
	
	//库存主键
	String t_ha_id = request.getParameter("t_ha_id");
	
	//录入时间
	String now_date = DateUtil.getFormatDate(new Date());
	
	//所有固定资产类型
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	List<Map<String, String>> allOsupplieUseList = new ArrayList<Map<String,String>>();
	allOsupplieUseList = osHavaObjectService.queryNoMoveType();

	List<Map<String, String>> osHavaList = osHavaObjectService.queryHavaObjectByHaId(t_ha_id);
	Map<String, String> osHavaMap = osHavaList.get(0);

%>
<!-- 公共部分开始 -->
<title>固定资产详情</title>
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
	//设备编号
	var sb_code = '<%=osHavaMap.get("t_ha_sbno")%>';
	
function inOfTypeForSelect(OFTYPE_SELECT){
	var ofusvalue = OFTYPE_SELECT.value;
	var ofustypevalueArr = ofusvalue.split(";");
	
	jQuery("#OFTYPE_ID").val(ofustypevalueArr[0]);
	jQuery("#OFTYPE_NAME").val(ofustypevalueArr[1]);
}


//返回
backParent = function(){
	var parentObject = getParentWindow('windowIds');
	parentObject.location.reload();
	removeAlertWindows('windowIds',true,true,'',false,'','');
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
	jQuery("#OFTYPE_SELECT").val('<%=osHavaMap.get("oftype_id")%>'+';'+'<%=osHavaMap.get("oftype_name")%>');
	jQuery("#OFTYPE_SELECT").change();
	jQuery("#T_HA_SBSTATE").val('<%=osHavaMap.get("t_ha_sbstate")%>');
	jQuery("#T_HA_RKUSER_NAME").focus();
	
});

//入库
function Ok(){
	
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		var flagValue = false;
		//设备编号是否重复
		var t_ha_sbno = jQuery("#T_HA_SBNO").val();
		
		if(t_ha_sbno!=sb_code){
			flagValue = valiDevCode(t_ha_sbno);	
		}
		if(flagValue){
			alert("设备编号已存在！");
			return false;
		} else {
			jQuery("#action").val("addOsNoMove");
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
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

</script>

</head>
<body style="overflow: auto;">
<form id="form1" name="form1" action="osnomoveobjectinfodo.jsp" method="post" >
  <input type="hidden" id="action" name="action" class="input_title_text" value="" />
  <input type="hidden" id="t_ha_org_id" name="t_ha_org_id" value="<%=StringUtil.deNull(osHavaMap.get("t_ha_org_id")) %>" />
  <input type="hidden" id="t_ha_org_name" name="t_ha_org_name" value="<%=StringUtil.deNull(osHavaMap.get("t_ha_org_name"))%>" />
  <div id="tabs1" style="width:70%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
				<input class="but_y_01" type="button" id="sel"  value="更新" onclick="Ok();"/>
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
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>设备详情</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">入库人：</th>
							<td class="content_02_box_div_table_td">
								<input type="hidden" id="T_HA_RKUSER_ID" name="T_HA_RKUSER_ID" class="input_title_text" value="<%=osHavaMap.get("t_ha_rkuser_id") %>" />
						           
						        <input type="text" value="<%=osHavaMap.get("t_ha_rkuser_name") %>" id="T_HA_RKUSER_NAME" name="T_HA_RKUSER_NAME" class="input_title_text" style="text-align: center;" readonly="readonly"/>
							</td>
							<th class="content_02_box_div_table_th">入库日期：</th>
							<td class="content_02_box_div_table_td">
						           
						        <input type="text" value="<%=osHavaMap.get("t_ha_buydate") %>" id="T_HA_BUYDATE" name="T_HA_BUYDATE" class="input_title_text" style="text-align: center;" readonly="readonly"/>
							</td>
						</tr>
						
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">类别：</th>
							<td class="content_02_box_div_table_td">
								 <select id="OFTYPE_SELECT" name="OFTYPE_SELECT" onchange="inOfTypeForSelect(this);">
							        <option value="">--请选择--</option>
							        <%if(allOsupplieUseList.size()>0){ 
							              for(int j = 0; j<allOsupplieUseList.size(); j++){
							            	  Map<String,String> allOsupplieUseMap = allOsupplieUseList.get(j);
							        %>
							            <option value="<%=allOsupplieUseMap.get("oftype_id")+";"+allOsupplieUseMap.get("oftype_name")%>"><%=allOsupplieUseMap.get("oftype_name") %></option>
							        <%    }
						              } %>
						           </select>
							       <input type="hidden" id="OFTYPE_ID" name="OFTYPE_ID" class="validate[required,maxSize[200]] input_title_text" value="<%=osHavaMap.get("oftype_id") %>" />
							       <input type="hidden" id="OFTYPE_NAME" name="OFTYPE_NAME" class="validate[required,maxSize[200]] input_title_text" value="<%=osHavaMap.get("oftype_name") %>" />
							</td>
							<th class="content_02_box_div_table_th">设备名称：</th>
							<td class="content_02_box_div_table_td">
						        <input type="hidden" id="T_HA_ID" name="T_HA_ID" class="input_title_text" value="<%=osHavaMap.get("t_ha_id") %>" />
						           
					            <input type="text" id="OFUSTYPE_NAME_VALUE" value="<%=osHavaMap.get("ofustype_name") %>" name="OFUSTYPE_NAME_VALUE" class="validate[required,maxSize[200]] input_title_text" style="text-align: center;"/>
						    </td>
						</tr>
						
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">设备编号：</th>
							<td class="content_02_box_div_table_td">
								 <input type="text" id="T_HA_SBNO" name="T_HA_SBNO" class="validate[maxSize[200]] input_title_text" style="text-align: center;" value="<%=osHavaMap.get("t_ha_sbno") %>"/>
							</td>
							<th class="content_02_box_div_table_th">型号：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" id="IT_NAME_VALUE" name="IT_NAME_VALUE" value="<%=osHavaMap.get("it_name") %>" class="validate[required,maxSize[200]] input_title_text" style="text-align: center;"/>
						    </td>
						</tr>
						
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">单价(元)：</th>
							<td class="content_02_box_div_table_td">
								 <input type="text" id="T_HA_DJ" name="T_HA_DJ" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" value="<%=osHavaMap.get("t_ha_dj") %>"/>
							</td>
							<th class="content_02_box_div_table_th"> 供货厂商：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" id="T_HA_GHMAN" name="T_HA_GHMAN" value="<%=osHavaMap.get("t_ha_ghman") %>" class="validate[maxSize[200]] input_title_text" style="text-align: center;" />
						    </td>
						</tr>
						
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th">售后电话：</th>
							<td class="content_02_box_div_table_td">
								 <input type="text" id="T_HA_OVERTEL" name="T_HA_OVERTEL" value="<%=osHavaMap.get("t_ha_overtel") %>" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" />
							</td>
							<th class="content_02_box_div_table_th"> 备注：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" id="T_HA_BZ" name="T_HA_BZ" value="<%=osHavaMap.get("t_ha_bz") %>" class="validate[maxSize[400]] input_title_text" style="text-align: center;" />
						    </td>
						</tr>
						
						<tr>
							<th class="content_02_box_div_table_th">设备状态：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								  <select id="T_HA_SBSTATE" name="T_HA_SBSTATE">
								  <option value="1">在库</option>
								  <option value="2">领用</option>
								  <option value="3">在修</option>
								  <option value="4">报废</option>
								  </select>
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

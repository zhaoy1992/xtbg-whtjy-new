
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsKucunServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	 //获得当前登录的用户信息
    String userId = accesscontroler.getUserID();
    String userName = accesscontroler.getUserName();
    //获得当前登录用户所属单位信息
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String unit_id = usercachebean.getUnit_id();
    String unit_name = usercachebean.getUnit_name();
    //当前系统时间
    String time  = DateUtil.getCurrentDateString("yyyy-MM-dd");
    
    Map<String,String> map = new HashMap<String,String>();
    OsKucunService service = new OsKucunServiceImpl();
    
	String actionName = request.getParameter("actionName");
	//库存ID
	String t_ha_id = request.getParameter("t_ha_id");

	//新增
	if(StringUtil.isBlank(t_ha_id) && actionName.equals("insert")){
		map.put("t_ha_rkuser_id",userId);
		map.put("t_ha_rkuser_name",userName);
		map.put("t_ha_rkuser_date",time);
		map.put("unit_id",unit_id);
		map.put("unit_name",unit_name);
	}else{//更新
		map = service.getByID(t_ha_id);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>常用物品新增</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#ofustype_name").focus();
	});
//保存
function save() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		//jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
		getParentWindow("windowId").userSearch();
		removeAlertWindows("windowId",true);
	}
}
//选类型

var chooseOrg = function (){
	var s = new $.z_tree();
	s.treeID='mian';
	s.treetypestr='radio';
	s.isShowSeacher=true;
	s.treeName="选取类型";
	s.isType='dept';
	s.headerName="选取类型";
	s.item_id = 'oftype_id';
	s.selectedIds=$('#oftype_id').val();
	s.type='OSUPPLIE_TYPE';
	s.returnFunction=function(orgObj){
		if(!IsSpace(orgObj)){
		    $('#oftype_id').val(orgObj.id);
		    $('#oftype_name').val(orgObj.name);
		}else{
		    $('#oftype_id').val("");
		    $('#oftype_name').val("");
		}
	}
	s.init();
}

</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osupplieusetypeinfodo.jsp" method="post"  >
	<input type="hidden" name="actionName" id="actionName" value="<%=actionName %>"> 
	<input type="hidden" name="t_ha_rkuser_id" id="t_ha_rkuser_id" value="<%=StringUtil.deNull(map.get("t_ha_rkuser_id")) %>">
	<input type="hidden" name="t_ha_rkuser_name" id="t_ha_rkuser_name" value="<%=StringUtil.deNull(map.get("t_ha_rkuser_name")) %>">
	<input type="hidden" name="t_ha_rkuser_date" id="t_ha_rkuser_date" value="<%=StringUtil.deNull(map.get("t_ha_rkuser_date")) %>">
	<input type="hidden" name="t_ha_org_id" id="t_ha_org_id" value="<%=StringUtil.deNull(map.get("t_ha_org_id")) %>">
	<input type="hidden" name="t_ha_org_name" id="t_ha_org_name" value="<%=StringUtil.deNull(map.get("t_ha_org_name")) %>">
	<input type="hidden" name="unit_id" id="unit_id" value="<%=StringUtil.deNull(map.get("unit_id")) %>">
	<input type="hidden" name="unit_name" id="unit_name" value="<%=StringUtil.deNull(map.get("unit_name")) %>">	
	<input type="hidden" id="t_ha_id" name="t_ha_id" value="<%=StringUtil.deNull(map.get("t_ha_id")) %>">
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="ofustype_id" id="ofustype_id" value="<%=StringUtil.deNull(map.get("ofustype_id")) %>">
							<input type="text" name="ofustype_name" id="ofustype_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="<%=StringUtil.deNull(map.get("ofustype_name")) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>排序号：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="ofustype_no" id="ofustype_id" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="<%=StringUtil.deNull(map.get("ofustype_no")) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品类别：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="oftype_id" id="oftype_id" value="<%=StringUtil.deNull(map.get("oftype_id")) %>">
							<input onclick="chooseOrg()" type="text" name="oftype_name" id="oftype_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="<%=StringUtil.deNull(map.get("oftype_name")) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>规格型号：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="it_id" id="it_id" value="<%=StringUtil.deNull(map.get("it_id")) %>">
							<input readonly="readonly" type="text" name="it_name" id="it_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="<%=StringUtil.deNull(map.get("it_name")) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>数量：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="t_ha_no" id="t_ha_no" style="width:90%;height=23px;" class="validate[required,maxSize[200],custom[positiveinteger]] input_188" value="<%=StringUtil.deNull(map.get("t_ha_no")) %>">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">备注：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="t_ha_bz" id="t_ha_bz" style="width:90%;height=23px;" class="validate[maxSize[200]] input_188" value="<%=StringUtil.deNull(map.get("t_ha_bz")) %>">
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="save()"/>
		</div>
		
	</form>
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
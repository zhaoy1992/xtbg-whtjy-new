
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
    String org_id = usercachebean.getOrg_id();
    String org_name = usercachebean.getOrg_name();
    //当前系统时间
    String time  = DateUtil.getCurrentDateString("yyyy-MM-dd");
    
    Map<String,String> map = new HashMap<String,String>();
    OsKucunService service = new OsKucunServiceImpl();
    
	String actionName = request.getParameter("actionName");
	
	//物品id
	String ofustype_id = DaoUtil.getUUID();


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>常用物品新增</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
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
		jQuery("#addItem").attr("disabled","disabled");
	});
//保存
function save() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
		jQuery("#add").attr("disabled","disabled");
		jQuery("#addItem").removeAttr("disabled");
	}
};
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
};

function back(){
	removeWindows("windowId",true);
};

function add_item(){
	var ofustype_id = $('#ofustype_id').val();
	var ofustype_name = $('#ofustype_name').val();
	var pageName ="添加物品规格";
	openAlertWindows('windowId1','../../../tjy/officesupplies2/jsp/osusertypeIteminfo2.jsp?windowsId=windowId1&actionName=insert&ofustype_id='+ofustype_id+'&ofustype_name='+ofustype_name,pageName,500,180,'25%','25%');
};
//拼接新增的规格并显示
function show_item(name,order_no){
	var it_name = $('#it_name').val();//规格名
	//var t_ha_no = $('#t_ha_no').val();//数量
	var ofustype_no = $('#ofustype_no').val();//排序号
	if(IsSpace(it_name)){
		$('#it_name').val(name);
		//$('#t_ha_no').val(number);
		$('#ofustype_no').val(order_no);
	}else{
		$('#it_name').val(it_name +"," + name);
		//$('#t_ha_no').val(t_ha_no + "," + number);
		$('#ofustype_no').val(ofustype_no +"," + order_no);
	}
}; 
//物品名称同名验证
function checkOfustypeName(){
	var ofustype_name = $('#ofustype_name').val();
	jQuery.ajax({
		url:'checkofustypename.jsp',
		dataType:"json",
		type:"post",
		data:{"actionName":"checkOfustypeName","ofustype_name":encodeURI(ofustype_name)},
		success:function(data){
			if(!IsSpace(data.ofustype_id)){
				alert("已存在该物品！");
			}
		}
	});
};
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osupplieusetypeinfodo.jsp" method="post"  >
	<input type="hidden" name="actionName" id="actionName" value="<%=actionName %>"> 
	<input type="hidden" name="t_ha_rkuser_id" id="t_ha_rkuser_id" value="<%=userId %>">
	<input type="hidden" name="t_ha_rkuser_name" id="t_ha_rkuser_name" value="<%=userName %>">
	<input type="hidden" name="t_ha_rkuser_date" id="t_ha_rkuser_date" value="<%=time %>">
	<input type="hidden" name="t_ha_org_id" id="t_ha_org_id" value="<%=org_id%>">
	<input type="hidden" name="t_ha_org_name" id="t_ha_org_name" value="<%=org_name %>">
	<input type="hidden" name="unit_id" id="unit_id" value="<%=unit_id %>">
	<input type="hidden" name="unit_name" id="unit_name" value="<%=unit_name %>">	
	<input type="hidden" id="t_ha_id" name="t_ha_id" value="">
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
			<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
	</div>
	<div id="vcenter" style="float: left; width: 100%;">
 	<div style="float: left; width: 775px; ">
 		<!--------------车辆信息-------------->
		 <div class="content_02_box_div">
			<div class="content_02_box_title_bg">
				<span>新增办公用品</span>
			</div> 
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="ofustype_id" id="ofustype_id" value="<%=ofustype_id %>">
							<input  type="text" name="ofustype_name" id="ofustype_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品类别：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="oftype_id" id="oftype_id" value="">
							<input onclick="chooseOrg()"  type="text" name="oftype_name" id="oftype_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">备注：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="t_ha_bz" id="t_ha_bz" style="width:90%;height=23px;" class="validate[maxSize[200]] input_188" value="">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_td" colspan="2">
							<input style="margin-left: 35%" class="but_y_01" id="add" name="add" type="button" value="保存" onclick="save()" />
							<input style="margin-left: 10%" class="but_y_01" id="addItem" name="addItem" type="button" value="添加规格" onclick="add_item()" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">规格型号：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="it_id" id="it_id" value="">
							<input readonly="readonly" type="text" name="it_name" id="it_name" style="width:90%;height=23px;" class="validate[maxSize[200]] input_188" value="">
						</td>
					</tr>
					<!-- 
					<tr>
						<th class="content_02_box_div_table_th">数量：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" readonly="readonly" name="t_ha_no" id="t_ha_no" style="width:90%;height=23px;" class="validate[maxSize[200]] input_188" value="">
						</td>
					</tr>
					 -->
					<tr>
						<th class="content_02_box_div_table_th">排序号：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" readonly="readonly" name="ofustype_no" id="ofustype_no" style="width:90%;height=23px;" class="validate[maxSize[200]] input_188" value="">
						</td>
					</tr>
			</table>
		</div>
	</div>
	</div>
		
	</form>
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
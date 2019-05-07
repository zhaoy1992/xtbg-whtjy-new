<%--
描述：固定资产使用管理
作者：王淑滨
--%>
<%@page language="java" contentType="text/html; charset=gbk"pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountManageService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountManageServiceImpl"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>

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
	
	String temp = request.getParameter("temp");
	String temp1 = "";
	if(!StringUtil.nullOrBlank(temp)){
		if(temp.equals("1")){
			temp1 = "借用登记";
		}else if(temp.equals("2")){
			temp1 = "领用登记";
		}else if(temp.equals("3")){
			temp1 = "调拨登记";
		}else if(temp.equals("4")){
			temp1 = "出租登记";
		}else if(temp.equals("5")){
			temp1 = "借用归还";
		}else if(temp.equals("6")){
			temp1 = "领用归还";
		}else if(temp.equals("7")){
			temp1 = "调拨归还";
		}else if(temp.equals("8")){
			temp1 = "出租归还";
		}
	}
	String m_id = request.getParameter("m_id");
	String method = request.getParameter("action");
	OsAccountManagerBean bean = new OsAccountManagerBean();
	List<Map<String,String>> list = new ArrayList<Map<String,String>>();
	OsAccountManageService service = new OsAccountManageServiceImpl();
	if(StringUtil.nullOrBlank(m_id)){
		bean.setM_id(DaoUtil.getUUID());
		bean.setRegister_user_id(user_id);
		bean.setRegister_user_name(user_name);
		bean.setRegister_date(time);
		bean.setM_type(temp1);
	}else{
		bean = service.getByID(m_id);
		temp1 = bean.getM_type();
		list = service.getByMid(m_id);
	}
	
	//调度单位
	String org_sql = "select  org_id,org_name from td_sm_organization where org_level = '1' order by org_sn";
	String org = DictDropDownList.buildSelect(org_sql,"org",StringUtil.deNull(bean.getOrg_id()),"chooseOrg()",true,"院本部","width: 230px;height:24px;");
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
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

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
var temp1 = "<%=temp1%>";
var method = "<%=method%>";
jQuery(function(){ 	
	jQuery("#gdzc_classify").val(<%=StringUtil.deNull(bean.getGdzc_classify())%>)
	if(method == "update"){
		jQuery("#add").hide();
	}
	<%if(list.size()>0){
		for(int i=0;i<list.size();i++){
			Map<String,String> map = list.get(i);
	%>
		Add_Row4NewDay1(); 
		var id = '<%=i+1%>';
		jQuery("#id"+id).val('<%=map.get("id")%>');
		jQuery("#internal_no"+id).val('<%=map.get("internal_no")%>');
		jQuery("#gdzc_num"+id).val('<%=map.get("gdzc_num")%>');
		jQuery("#gdzc_id"+id).val('<%=map.get("gdzc_id")%>');
		jQuery("#gdzc_name"+id).val('<%=map.get("gdzc_name")%>');
		jQuery("#bar_code"+id).val('<%=map.get("bar_code")%>');
		jQuery("#body_no"+id).val('<%=map.get("body_no")%>');
		jQuery("#state"+id).val('<%=map.get("state")%>');
		
	<%}}%>
	jQuery("#dayrowhidden").hide();
	
});

/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds=jQuery('#user_id').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#user_id').val(orgObj.id);
		  jQuery('#user_name').val(orgObj.name);
		  //jQuery('#org_id').val(orgObj.org_id);
		  if((temp1 == "调拨登记") || (temp1 == "调拨归还")){
		  	jQuery('#org_name').val("");
		  }else{
		  	jQuery('#org_name').val(orgObj.returnparentNode);
		  }
	  }
  	 s.init();	  
}
var chooseOrg = function(){
	var org = jQuery("#org").val();
	if(!IsSpace(org)){
		jQuery("#org_id").val(org)
		jQuery("#org_name").val(jQuery("#org option:selected").text())
	}else{
		jQuery("#org_id").val("")
		jQuery("#org_name").val("")
	}
}

var save = function(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		//jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
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
	var newTrsize= jQuery(intable).find("tr[name=dayrow]").size();
}

//添加物品
function Add_Row4NewDay1(){
	var lastTrObject = jQuery("[name=dayrow]").last();
	var lastTr = jQuery("[name=dayrowhidden]").last().clone();
		
	jQuery(lastTr).find("input[type=text]").val("");	
	jQuery(lastTr).find("input[type=hidden]").val("");
		

	var lastSelectId = lastTrObject.find("input[name=gdzc_name]").attr("id");
	var newlastSelectId;
	if(lastSelectId){
		var lastSelectIdArr = lastSelectId.split("gdzc_name");
		newlastSelectId =  parseFloat(lastSelectIdArr[1])+1;
	}else{
		newlastSelectId = 1;
	}
			
	jQuery(lastTr).find("input[name=id]").attr("id","id"+newlastSelectId);
	jQuery(lastTr).find("input[name=internal_no]").attr("id","internal_no"+newlastSelectId);
	jQuery(lastTr).find("input[name=gdzc_num]").attr("id","gdzc_num"+newlastSelectId);
	jQuery(lastTr).find("input[name=gdzc_id]").attr("id","gdzc_id"+newlastSelectId);
	jQuery(lastTr).find("input[name=gdzc_name]").attr("id","gdzc_name"+newlastSelectId);
	jQuery(lastTr).find("input[name=bar_code]").attr("id","bar_code"+newlastSelectId);
	jQuery(lastTr).find("input[name=body_no]").attr("id","body_no"+newlastSelectId);
	jQuery(lastTr).find("input[name=state]").attr("id","state"+newlastSelectId);
		
		
	lastTr.attr("id","dayrow");
	lastTr.attr("name","dayrow");
	
	lastTr.attr("style","");
	
	var dayTable = jQuery("#dayTable");
		
	lastTr.appendTo(dayTable);
}
function changeAccount(gdzc_name){
	var id = gdzc_name.id;
	var id_arr = id.split("gdzc_name");
	var id_num = id_arr[1];
	var gdzc_classify  =  jQuery("#gdzc_classify").val();
	
	var path ="<%=path%>/ccapp/xtbg/tjy/account/jsp/changeaccountlist.jsp?windowsId=windowIds&id_num="+id_num+"&gdzc_classify="+gdzc_classify+"&m_type=<%=temp%>";
	openAlertWindows('windowIds',path,'固定资产列表',810,400,'25%','25%');
}

function loadInfo(id_num,id,num,internal_no,name,bar_code,body_no,state){
	jQuery("#gdzc_num"+id_num).val(num);
	jQuery("#internal_no"+id_num).val(internal_no);
	jQuery("#gdzc_id"+id_num).val(id);
	jQuery("#gdzc_name"+id_num).val(name);
	jQuery("#bar_code"+id_num).val(bar_code);
	jQuery("#body_no"+id_num).val(body_no);
	jQuery("#state"+id_num).val(state);
}
</script>

</head>
<body onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="officemanagedo.jsp" class="formular" method="post">
	<input id="m_id" name="m_id" type="hidden" value="<%=StringUtil.deNull(bean.getM_id()) %>"/>
	<input id="m_type" name="m_type" type="hidden" value="<%=StringUtil.deNull(bean.getM_type()) %>"/>
	<input id="method" name="method" type="hidden" value="<%=method %>">
	<input id="register_user_id" name="register_user_id" type="hidden" value="<%=StringUtil.deNull(bean.getRegister_user_id())%>">
	<input id="register_user_name" name="register_user_name" type="hidden" value="<%=StringUtil.deNull(bean.getRegister_user_name()) %>">
	<input id="register_date" name="register_date" type="hidden" value="<%=StringUtil.deNull(bean.getRegister_date()) %>">
	<input value="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsManageObject" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	 name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>
	
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'> 
			<input class="but_y_01" id="add" name="add" type="button" value="保存" onclick="save();"/>
			<input class="but_y_01" id="back" name="back" type="button" value="返回" onclick="window.history.back();"/>
		</div>
	</div>
	 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 1000px; ">
 <!--------------采购清单-------------->
 <div class="content_02_box_div"style="width: 1000px; ">
	<div class="content_02_box_title_bg"style="width: 1000px; ">
		<span><%=temp1 %></span>
	</div> 
	<table  style="width: 1000px; "border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">	
		<tr>
			<th class="content_02_box_div_table_th"><span style="color: red">*</span>资产类别：</th>
			<td class="content_02_box_div_table_td">
				<select id="gdzc_classify" name="gdzc_classify" class="validate[required]" style="width: 150px;" >
					<%if(temp1.equals("借用登记") || temp1.equals("借用归还")) {%>
						<option value="">---请选择----</option>
						<option value="2">仪器设备类</option>
					<%}else{ %>
						<option value="">---请选择---</option>
						<option value="1">办公设备类</option>
						<option value="2">仪器设备类</option>
						<option value="3">土地房屋类</option>
						<option value="4">电器类</option>
						<option value="5">公用物资类</option>
						<option value="6">家具类</option>
						<option value="7">车辆类</option>
					<%} %>
				</select>
			</td>
			<th class="content_02_box_div_table_th"><span style="color: red">*</span><%=temp1 %>日期：</th>
			<td class="content_02_box_div_table_td">
				<input type="text" value="<%=StringUtil.deNull(bean.getUse_date()) %>" class="validate[required] date_187" id="use_date" name="use_date"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span style="color: red">*</span><%=temp1 %>人：</th>
			<td class="content_02_box_div_table_td">
				<input id="user_id" name="user_id" type="hidden" value="<%=StringUtil.deNull(bean.getUser_id()) %>"/>
				<input onclick="chooseReportUnits()" readonly="readonly" id="user_name" name="user_name" class="validate[maxSize[50]] input_title_text" value="<%=StringUtil.deNull(bean.getUser_name()) %>">
			</td>
			<th class="content_02_box_div_table_th"><span style="color: red">*</span><%=temp1 %>部门：</th>
			<td class="content_02_box_div_table_td">
				<%if((temp1.equals("调拨归还")) || (temp1.equals("调拨登记"))) {%>
					<%=org %>
					<input id="org_id" name="org_id" type="hidden" value="<%=StringUtil.deNull(bean.getOrg_id()) %>"/>
					<input id="org_name" name="org_name" type="hidden" value="<%=StringUtil.deNull(bean.getOrg_name()) %>"/>
				<%}else{ %>
					<input id="org_id" name="org_id" type="hidden" value="<%=StringUtil.deNull(bean.getOrg_id()) %>"/>
					<input id="org_name" name="org_name" readonly="readonly" class="validate[maxSize[50]] input_title_text" value="<%=StringUtil.deNull(bean.getOrg_name()) %>">
				<%} %>
			</td>
		</tr>
	</table>  
	<div class="content_02_box_title_bg" style="width: 100%">
		<span>固定资产清单</span>
		<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="add.gif"/>添加物品</a>
		</div>
	</div> 
	<div class="content_02_box_div" style="width: 100%;">
		<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">编号</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">内部编号</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px"><span style="color: red">*</span>名称</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">条形码</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">机身号</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">状态</td>
				<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 50px">操作</td>
			</tr>
			<tr id ="dayrowhidden" name="dayrowhidden">
				<td class="content_02_box_div_table_td">
					<input type="hidden" id="id" name="id" value="">
					<input type="text" id="gdzc_num" name="gdzc_num" readonly="readonly" class="input_title_text"  style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="internal_no" name="internal_no" readonly="readonly" class="input_title_text" style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="hidden" id="gdzc_id" name="gdzc_id" value="">
					<input type="text" id="gdzc_name" onclick="changeAccount(this);" name="gdzc_name" readonly="readonly" class="input_title_text" style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="bar_code" name="bar_code" readonly="readonly" class="input_title_text" style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="body_no" name="body_no" readonly="readonly" class="input_title_text" style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<input type="text" id="state" name="state" readonly="readonly" class="input_title_text" style="text-align: center;">
				</td>
				<td class="content_02_box_div_table_td">
					<div class="content_02_box_del" name="delDiv"  style="height:24px; margin:0;float: none;text-align: center;">
						<a onClick="deleteDay(this,'')"> <img src="del.gif" id="del"/>删除</a>
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


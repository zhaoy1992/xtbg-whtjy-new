<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageRefuelmanageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageRefuelmanageServiceIfc"%>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean= UserCache.getUserCacheBean(curUserId);
	String path = request.getContextPath();//服务器根路径
	String subId = StringUtil.deNull(request.getParameter("subId"));//子窗口id
	String opt = StringUtil.deNull(request.getParameter("opt"));//操作类型标识
	String id = StringUtil.deNull(request.getParameter("id"));//业务id
	Map<String,String> m = new HashMap<String,String>();
	if("upd".equals(opt)){
		CarManageRefuelmanageServiceIfc carManageRefuelmanageServiceIfc = new CarManageRefuelmanageServiceImpl();
		m = carManageRefuelmanageServiceIfc.getCarManageRefuelmanage(id);
	}
	
	String sql = "select r.car_id,r.car_num from YMJ_OA_CARMANAGE_CAR r where r.current_state=1";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"license_number",StringUtil.deNull(m.get("license_number")),"",true,""); // 车辆下拉框的值 
	
	
%>
<title>加油管理信息详情</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8" ></script>
<!-- 引入其它 -->
<script src="../../../../oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8" ></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var path = '<%=path %>';

$(function() {
	$("#license_number").css("width","188px");
	var license_number_slc = document.getElementById("fuel_type");//自动选中加油类型值select
	for(var i=0 ; i<license_number_slc.options.length ; i++){
		if(license_number_slc.options[i].value == "<%=StringUtil.deNull(m.get("fuel_type")) %>"){
			license_number_slc.options[i].selected='selected';
		}
	}
});

/*
函数:  addInfo
说明:  添加
参数:   无
返回值: 无
*/
var addInfo = function() {
	jQuery("#opt").val("add");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定添加吗？',p);
}

/*
函数:  updateInfo
说明:  修改
参数:   无
返回值: 无
*/
var updateInfo = function() {
	jQuery("#opt").val("upd");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定修改吗？',p);

}

/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
	removeWindows("<%=subId%>",true);
}

/*
 * 人员选择
 */
function chooseReportUnits (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			   jQuery('#fuel_person').val('');
			   jQuery('#fuel_name').val('');
			}else{
				jQuery('#fuel_person').val(orgObj.ps.id);
				jQuery('#fuel_name').val(orgObj.ps.name);
			}
	  }
	  s.isNewCommonUse=true;
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#fuel_person').val(),
				  type:'APERSON'
		  		},{
					  leftHeaderText:'常用分组',
					  item_id :'org_id',
					  isType:'dept', 
					  valueKey:'dept',
					  selectedIds:'',
					  isGroup:true,
					  type:"A3"
				}];
	  s.init();
}

</script>

</head>
<body>
<form id="form1" action="addRefuelmanage.jsp" method="post">
<input type="hidden" name="opt" id="opt"   />
<input type="hidden" name="fuel_id" id="fuel_id" value="<%=id %>" />
<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<%if("add".equals(opt)){ %>
		<input name="fbbt" id="fbbt" value="添加" onclick="addInfo();"  type="button" class="but_y_01" />
		<%}else if("upd".equals(opt)){ %> 
		<input name="fbbt" id="fbbt" value="修改" onclick="updateInfo();"  type="button" class="but_y_01" />
		<%} %>
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->
<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: auto">
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>车辆用油信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th">车牌号码：</th>
						<td class="content_02_box_div_table_td" >
							<%=infotypeHtml %>
						</td>
						<th class="content_02_box_div_table_th">加油人：</th>
						<td class="content_02_box_div_table_td" >
							<!-- <input  class="input_188" name="fuel_person" id="fuel_person" value="" /> -->
							<input type="text" id="fuel_name" name="fuel_name" onmouseover="this.title=this.value" value="<%=StringUtil.deNull(m.get("fuel_name")) %>" class="input_188" style="width:159px;" onclick="chooseReportUnits()"/>
							<input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
           					<input type="hidden" id="fuel_person" name="fuel_person" value="<%=StringUtil.deNull(m.get("fuel_person")) %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">加油类型：</th>
						<td class="content_02_box_div_table_td">
							<select name="fuel_type"  class="select_188_box" id="fuel_type" style="width: 188px;">
		            			<option value="90" >90</option>
		            			<option value="93" >93</option>
		            			<option value="97" >97</option>
		            			<option value="98" >98</option>
		            			<option value="0" >0</option>
		            			<option value="-10" >-10</option>
		            			<option value="-20" >-20</option>
		            			<option value="-35" >-35</option>
		        			</select>
						</td>
						<th class="content_02_box_div_table_th">加油量：</th>
						<td class="content_02_box_div_table_td" >
							<input  class="input_188" name="fuel_charge" id="fuel_charge" value="<%=StringUtil.deNull(m.get("fuel_charge")) %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">单价(元/升)：</th>
						<td class="content_02_box_div_table_td" >
							<input  class="input_188" name="unit_cost" id="unit_cost" value="<%=StringUtil.deNull(m.get("unit_cost")) %>" />
						</td>
						<th class="content_02_box_div_table_th">总价(元)：</th>
						<td class="content_02_box_div_table_td" >
							<input  class="input_188" name="total_price" id="total_price" value="<%=StringUtil.deNull(m.get("total_price")) %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">加油地点：</th>
						<td class="content_02_box_div_table_td" >
							<input  class="input_188" name="refuel_point" id="refuel_point" value="<%=StringUtil.deNull(m.get("refuel_point")) %>" />
						</td>
						<th class="content_02_box_div_table_th">加油时间：</th>
						<td class="content_02_box_div_table_td" >
							<!-- <input  class="input_188" name="refuel_time" id="refuel_time" value="" /> -->
							<input style="width:100%;" class="date_120" style="height:26px;" type="text" id="refuel_time" name="refuel_time" onclick="WdatePicker()" value="<%=StringUtil.deNull(m.get("refuel_time")) %>"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">发票号码：</th>
						<td class="content_02_box_div_table_td" colspan="3" >
							<input  class="input_188" name="invoice_number" id="invoice_number" value="<%=StringUtil.deNull(m.get("invoice_number")) %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" valign="top">其他信息：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
							<textarea class="textarea_575" style="width:99%" name="more_detail" id="more_detail" ><%=StringUtil.deNull(m.get("more_detail")) %></textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
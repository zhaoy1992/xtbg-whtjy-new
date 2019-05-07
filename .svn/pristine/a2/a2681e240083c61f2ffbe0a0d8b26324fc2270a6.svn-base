<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html; charset=gbk"pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean = UserCache.getUserCacheBean(userid);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	String classify = request.getParameter("classify");
	String windowId = request.getParameter("windowId");
	String id = request.getParameter("id");
	String action = request.getParameter("action");
	
	OsAccountService service = new OsAccountServiceImpl();
	OsAccountBean bean = new OsAccountBean();
	if(!StringUtil.nullOrBlank(id)){
		bean = service.getByID(id);
	}else{
		bean.setId(DaoUtil.getUUID());
		bean.setState("在库正常");
		bean.setClassify(classify);
	}
	
	String location_sql = "select org_id,org_name from td_sm_organization where org_level = '1' order by org_sn";
	String location = DictDropDownList.buildSelect(location_sql,"location",StringUtil.deNull(bean.getLocation_id()),"chooseLocation()",true,"院本部","width: 230px;height:24px;");
	
	String org_sql = "select org_id,org_name from td_sm_organization where org_level = '3' order by org_sn";
	String org = DictDropDownList.buildSelect(org_sql,"org",StringUtil.deNull(bean.getLocation_org_id()),"chooseOrg()",true,"","width: 230px;height:24px;");
	//不同类别固定资产的分类处理
	String type = DictDropDownList.buildSelect4DictType("gdzc_"+classify,"type",StringUtil.deNull(bean.getType_id()),"chooseType()", true, "" ,"" ,"class='validate[required] select_240' style='width: 190px;height:24px;'","" );

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>固定资产-添加界面</title>
</head>
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
var classify = "<%=classify%>";
var action = "<%=action%>";
jQuery(function(){
	if(action == "read"){
		jQuery("#savebtn").hide();
	}

	jQuery("#form1").validationEngine();
	jQuery("#neibubianhao").hide();
	jQuery("#dizhi").hide();
	jQuery("#mianji").hide();
	jQuery("#quanshuzhenghao").hide();
	jQuery("#fazhengshijian").hide();
	jQuery("#fangzhididian").hide();
	jQuery("#yanse").hide();
	jQuery("#chejiahao").hide();
	jQuery("#fadongjihao").hide();
	jQuery("#chepaihao").hide();
	jQuery("#pailiang").hide();
	jQuery("#guanliren").hide();
	jQuery("#guanlibumen").hide();
	if(classify == '2'){
		jQuery("#neibubianhao").show();
	}else if(classify == '3'){
		jQuery("#dizhi").show();
		jQuery("#mianji").show();
		jQuery("#quanshuzhenghao").show();
		jQuery("#fazhengshijian").show();
		jQuery("#guigexinghao").hide();
		jQuery("#shengchanchangjia").hide();
		jQuery("#jishenhao").hide();
		jQuery("#goumaishijian").hide();
	}else if(classify == '4'){
		jQuery("#fenlei").hide();
	}else if(classify == '5'){
		jQuery("#fenlei").hide();
		jQuery("#fangzhididian").show();
		jQuery("#guanliren").show();
		jQuery("#guanlibumen").show();
	}else if(classify == '6'){
		jQuery("#jishenhao").hide();
	}else if(classify == '7'){
		jQuery("#fenlei").hide();
		jQuery("#shengchanchangjia").hide();
		jQuery("#jishenhao").hide();
		jQuery("#yanse").show();
		jQuery("#chejiahao").show();
		jQuery("#fadongjihao").show();
		jQuery("#chepaihao").show();
		jQuery("#pailiang").show();
		jQuery("#guanliren").show();
		jQuery("#guanlibumen").show();
	}
})

var chooseLocation = function(){
	var location = jQuery("#location").val();
	if(!IsSpace(location)){
	    jQuery("#bumen").hide();
		jQuery("#location_id").val(location);
		jQuery("#location_name").val(jQuery("#location option:selected").text())
		jQuery("#location_org_id").val(location)
		jQuery("#location_org").val(jQuery("#location option:selected").text())
	}else{
		jQuery("#bumen").show();
		jQuery("#location_id").val("");
		jQuery("#location_name").val("")
		jQuery("#location_org_id").val("")
		jQuery("#location_org").val("")
	}
}

var chooseOrg = function(){
	var org = jQuery("#org").val();
	if(!IsSpace(org)){
		jQuery("#location_org_id").val(org)
		jQuery("#location_org").val(jQuery("#org option:selected").text())
	}else{
		jQuery("#location_org_id").val("")
		jQuery("#location_org").val("")
	}
}

var chooseType = function(){
	var type = jQuery("#type").val();
	if(!IsSpace(type)){
		jQuery("#type_id").val(type)
		jQuery("#type_name").val(jQuery("#type option:selected").text())
	}else{
		jQuery("#type_id").val("")
		jQuery("#type_name").val("")
	}
}

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
		  jQuery('#org_name').val(orgObj.returnparentNode);
	  }
  	 s.init();	  
}

/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){;
		//jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}
var back = function(){
	removeWindows("windowId1",true);
}
</script>
<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="officedetaildo.jsp" class="formular" method="post"> 
	<input id="action" name="action" type="hidden" value="<%=action %>">
	<input id="windowId" name="windowId" type="hidden" value="<%=windowId %>">
	<input id="id" name="id" type="hidden" value="<%=StringUtil.deNull(bean.getId())%>"/>
	<input id="classify" name="classify" type="hidden" value="<%=StringUtil.deNull(bean.getClassify()) %>">
	<input id="state" name="state" type="hidden" value="<%=StringUtil.deNull(bean.getState())  %>">
	<input id="state_id" name="state_id" type="hidden" value="<%=StringUtil.deNull(bean.getState_id()) %>"/>
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
				<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="Ok()" value="保存" />
				<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
			</div>
	</div>
	 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------车辆信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>固定资产信息</span>
				</div>                                           
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr id="neibubianhao">
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>内部编号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[required,maxSize[50]] input_title_text" style="width: 55%;" id="internal_no" name="internal_no" value="<%=StringUtil.deNull(bean.getInternal_no()) %>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>编号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[required,maxSize[50]] input_title_text" style="width: 55%;" id="num" name="num" value="<%=StringUtil.deNull(bean.getNum()) %>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>名称：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[required,maxSize[50]] input_title_text" style="width: 55%;" id="name" name="name" value="<%=StringUtil.deNull(bean.getName()) %>">
				</td>
			</tr>
			<tr id="fenlei">
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>分类：</th>
				<td class="content_02_box_div_table_td">
					<%= type%>
					<input type="hidden" id="type_id" name="type_id" value="<%=StringUtil.deNull(bean.getType_id()) %>"/>
					<input type="hidden" id="type_name" name="type_name" value="<%=StringUtil.deNull(bean.getType_name()) %>">
				</td>
			</tr>
			<tr id="dizhi">
				<th class="content_02_box_div_table_th">地址：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="address" name="address" value="<%=StringUtil.deNull(bean.getAddress()) %>">
				</td>
			</tr>
			<tr id="mianji">
				<th class="content_02_box_div_table_th">面积：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="area" name="area" value="<%=StringUtil.deNull(bean.getArea()) %>">
				</td>
			</tr>
			<tr id="quanshuzhenghao">
				<th class="content_02_box_div_table_th">权属证号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="ownership_no" name="ownership_no" value="<%=StringUtil.deNull(bean.getOwnership_no()) %>">
				</td>
			</tr>
			<tr id="fazhengshijian">
				<th class="content_02_box_div_table_th">发证时间：</th>
				<td class="content_02_box_div_table_td">
					<input type="text" value="<%=StringUtil.deNull(bean.getFazheng_date()) %>" class="validate[required] date_187" id="fazheng_date" name="fazheng_date"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
				</td>
			</tr>
			<tr id="guigexinghao">
				<th class="content_02_box_div_table_th">规格型号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="it" name="it" value="<%=StringUtil.deNull(bean.getIt()) %>">
				</td>
			</tr>
			<tr id="yanse">
				<th class="content_02_box_div_table_th">颜色：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="color" name="color" value="<%=StringUtil.deNull(bean.getColor()) %>">
				</td>
			</tr>
			<tr id="chejiahao">
				<th class="content_02_box_div_table_th">车架号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="vin_number" name="vin_number" value="<%=StringUtil.deNull(bean.getVin_number()) %>">
				</td>
			</tr>
			<tr id="fadongjihao">
				<th class="content_02_box_div_table_th">发动机号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="engine_number" name="engine_number" value="<%=StringUtil.deNull(bean.getEngine_number()) %>">
				</td>
			</tr>
			<tr id="chepaihao">
				<th class="content_02_box_div_table_th">车牌号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="car_number" name="car_number" value="<%=StringUtil.deNull(bean.getCar_number()) %>">
				</td>
			</tr>
			<tr id="pailiang">
				<th class="content_02_box_div_table_th">排量：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="displacement" name="displacement" value="<%=StringUtil.deNull(bean.getDisplacement()) %>">
				</td>
			</tr>
			<tr id="shengchanchangjia">
				<th class="content_02_box_div_table_th">生产厂家：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="manufacturer" name="manufacturer" value="<%=StringUtil.deNull(bean.getManufacturer()) %>">
				</td>
			</tr>
			<tr id="jishenhao">
				<th class="content_02_box_div_table_th">机身号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="body_no" name="body_no" value="<%=StringUtil.deNull(bean.getBody_no()) %>">
				</td>
			</tr>
			<tr id="tiaoxingma">
				<th class="content_02_box_div_table_th">条形码：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="bar_code" name="bar_code" value="<%=StringUtil.deNull(bean.getBar_code()) %>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">财政编号：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="finance_no" name="finance_no" value="<%=StringUtil.deNull(bean.getFinance_no()) %>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">原值：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="original_value" name="original_value" value="<%=StringUtil.deNull(bean.getOriginal_value()) %>">
				</td>
			</tr>
			<tr id="goumaishijian">
				<th class="content_02_box_div_table_th">购买时间：</th>
				<td class="content_02_box_div_table_td">
					<input type="text" value="<%=StringUtil.deNull(bean.getBuy_time()) %>" class="validate[required] date_187" id="buy_time" name="buy_time"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
				</td>
			</tr>
			<tr id="guanliren">
				<th class="content_02_box_div_table_th">管理人：</th>
				<td class="content_02_box_div_table_td">
					<input id="user_id" name="user_id" type="hidden" value="<%=StringUtil.deNull(bean.getUser_id()) %>"/>
					<input onclick="chooseReportUnits()" readonly="readonly" id="user_name" name="user_name" class="validate[maxSize[50]] input_title_text" style="width: 55%;" value="<%=StringUtil.deNull(bean.getUser_name()) %>">
				</td>
			</tr>
			<tr id="guanlibumen">
				<th class="content_02_box_div_table_th">管理部门：</th>
				<td class="content_02_box_div_table_td">
					<input id="org_id" name="org_id" type="hidden" value="<%=StringUtil.deNull(bean.getOrg_id()) %>"/>
					<input id="org_name" name="org_name" readonly="readonly" class="validate[maxSize[50]] input_title_text" style="width: 55%;" value="<%=StringUtil.deNull(bean.getOrg_name())%>">
				</td>
			</tr>
			<tr id="fangzhididian">
				<th class="content_02_box_div_table_th">放置地点：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[50]] input_title_text" style="width: 55%;" id="location_place" name="location_place" value="<%=StringUtil.deNull(bean.getLocation_place()) %>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>所在地：</th>
				<td class="content_02_box_div_table_td">
					<input id="location_id" name="location_id" type="hidden" value="<%=StringUtil.deNull(bean.getLocation_id()) %>"/>
					<input id="location_name" name="location_name" type="hidden" value="<%=StringUtil.deNull(bean.getLocation_name()) %>">
					<%=location %>
				</td>
			</tr>
			<tr id="bumen">
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>所在部门：</th>
				<td class="content_02_box_div_table_td">
					<input id="location_org_id" name="location_org_id" type="hidden" value="<%=StringUtil.deNull(bean.getLocation_org_id()) %>"/>
					<input id="location_org" name="location_org"  type="hidden" value="<%=StringUtil.deNull(bean.getLocation_org()) %>">
					<%=org %>
				</td>
			</tr>
		</table>
	</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
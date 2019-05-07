<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();

	String theRootOrgid = DaoUtil
			.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String subid = request.getParameter("subid");
	String car_id = request.getParameter("car_id");

	CarManageCarBean carManageCarBean = new CarManageCarBean();
	// 车辆信息 carManageCarDaoImplymj
	CarManageCarDao carManageCarDao = (CarManageCarDao) DaoImplClassUtil
			.getDaoImplClass("carManageCarDaoImplymj");
	if (!StringUtil.nullOrBlank(car_id)) {
		carManageCarBean = carManageCarDao
				.findCarManageCarByCarID(car_id);
	}

	String sql = "select r.car_id,r.car_num from YMJ_OA_CARMANAGE_CAR r where r.current_state='1'";
	String infotypeHtml = DictDropDownList.buildSelect(sql, "car_num",
			"", "", true, "","width:190px;"); // 车辆下拉框的值
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>车辆维修保养-添加界面</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

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
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">
$(function(){
	jQuery("#form1").validationEngine();
})

var loginUserName = '<%=loginUserName%>';
var user_id = '<%=userid%>';

/**
 * 保存车辆申请基本信息--saveinfo
 */
var saveinfo = function(){
		if (IsSpace($("#car_id").val())) { //修改
			$("#action").val("add");
		} else {
			$("#action").val("update");
		}
		var baseinfoJson = "{'car_num':'"+$("#car_num").find("option:selected").text()+"','type':'"+$('input:radio[name="type"]:checked').val()+"',"+
			"'jbr':'"+$('#jbr').val()+"','wxc':'" + $('#wxc').val() + "',"+"'mobile':'" + 
			$("#mobile").val() + "',"+"'yjfy':'" + $('#yjfy').val() +"','wxbyrq':'" + $('#wxbyrq').val()
			+ "',"+"'sjfy':'" + $('#sjfy').val() + "',"+"'bz':'" + $('#bz').val()+"'}";
		if ($("#car_num").val() == "") {
	        alert("请选择车牌号");
	        return false;
	    }
		$("#baseinfoJson").val(descape(escape(baseinfoJson)));
		$("#form1").attr("target","hiddenFrame");
		$("#form1").submit();
}

/**
 * 选择用户
 */
function chooseUser() {
	var s = new $.z_tree_leftRigth_old();
		s.treeID='button_envelop_username';
		s.isShowSeacher=true;
		s.treeName="选取人员";
		s.headerName="选取人员";
		s.titelText = "选择人员";
		s.rightHeaderText="已添加人员";
		s.returnFunction=function(orgObj){
			if (!IsSpace(orgObj)) {
				$('#driver_id').val(orgObj.ps.id);
				$('#driver').val(orgObj.ps.name);
			}else{
				$('#driver_id').val("");
				$('#driver').val("");
			}
	}
	s.treeList=[{'url':'<%=path%>' + "/OrgUserYimingTreeServlet",
				 'autoParam':["item_id", "name=item_id", "level=lv"],
				 'leftHeaderText':'按人员选择',
				  valueKey:'ps',
				 'otherParam':{
				 "toporgId":"<%=theRootOrgid%>",
				 "userid":"<%=userid%>",
				 "resourceType":"",
				 "backchooseuserids":$('#driver_id').val(),
				 "showLevel":"3"}
			}];
		  s.init();
}
	
/* 
 * 返回 
 */
function back(){
	 var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carRecordList.jsp";
	 /*location.href = url; */
	var okF = function(){
		removeWindows('<%=subid%>',true);
		location.href = url;
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carWxbyList.jsp";
	location.href = url;
}
function checkcarno(){

 }
</script>

<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="carWxSave.jsp" class="formular" method="post">
<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;"
				id='content_02_top'>
		<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="saveinfo();" value="保存" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------车辆信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>维修保养信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>类&nbsp;&nbsp;&nbsp;&nbsp;型：</th>
				<td class="content_02_box_div_table_td">
				<input name="type" value="1" type="radio" checked="checked"/> 保养
				<input name="type" value="2" type="radio"/> 维修
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th" ><span class="color_red">*</span>车&nbsp;牌&nbsp;号：</th>
				<td class="content_02_box_div_table_td">
				<%=infotypeHtml%>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>经&nbsp;办&nbsp;人：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[30]] input_title_text" style="width: 55%;"
					id="jbr" name="jbr" value=""></input>
				<input id="jbr_id" name="jbr_id" type="hidden" />
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>修&nbsp;配&nbsp;厂：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[50]] input_title_text" style="width: 55%;"
					id="wxc" name="wxc" value=""></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>联系电话：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[10],custom[phone]] input_title_text" style="width: 55%;"
					id="mobile" name="mobile" value=""></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>预计费用：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,custom[number],maxSize[10]]" style="width: 171px; border: 0px;"   
					id="yjfy" name="yjfy" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" value="<%=StringUtil.deNull(carManageCarBean.getBuy_money())%>"></input>&nbsp;元
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">实际费用：</th>
				<td class="content_02_box_div_table_td">
				<input style="width: 171px; border: 0px;" 
					id="sjfy" name="sjfy" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" value="<%=StringUtil.deNull(carManageCarBean.getBuy_money())%>"></input>&nbsp;元
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>维修保养日期：</th>
				<td class="content_02_box_div_table_td">
				<input type="text" value=""
					class="validate[required] date_187" id="wxbyrq" name="wxbyrq"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})" />
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">备&nbsp;&nbsp;&nbsp;&nbsp;注：</th>
				<td class="content_02_box_div_table_td">
				<textarea  class="validate[maxSize[500]] textarea_575" cols="3" style="width: 55%;"
					id="bz" name="bz"><%=StringUtil.deNull(carManageCarBean.getRemark())%></textarea>
				</td>
			</tr>
		</table>
	</div>
	
	</div>
</div>
<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="" />
<input id="action" name="action" type="hidden" value="" />
<input id="car_id" name="car_id" type="hidden" value="<%=StringUtil.deNull(carManageCarBean.getCar_id())%>" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>